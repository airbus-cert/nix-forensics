#!/usr/bin/env bash

function usage() {
  echo "Usage: $0 destination" 1>&2
  echo "" 1>&2
  echo "Deploys a nix-shell to a remote host"
}

function is_installed() {
  cmd="$1"
  which "$cmd" 2>/dev/null 1>/dev/null
  if [ $? -eq 0 ]; then
    echo "1"
  else
    echo "0"
  fi
}

function ensure_installed() {
  cmd="$1"
  if [ "$(is_installed $cmd)" -eq 0 ]; then
    echo "Error: command '$cmd' is required" 1>&2
    exit 1
  fi
}

if [ $# -eq 0 -o "$1" == "-h" -o "$1" == "--help" ]; then
  usage
  exit 3
fi

ensure_installed nix-copy-closure
ensure_installed nix-shell
ensure_installed xargs
ensure_installed tput

NIX_SHELL_DERIV="$(nix-build shell.nix 2> .nix-build.log)"
if [ $? -ne 0 ]; then
  echo "Error: nix-shell failed to build!" 1>&2
  cat .nix-build.log 1>&2
  exit 1
fi
rm .nix-build.log
rm result

echo "Getting ready to copy $NIX_SHELL_DERIV"

## Sanity checks
echo "Doing some sanity checks on the destination..."

### Checking that the remote nix-shell works
output="$(ssh $@ -- "nix-shell -p hello --run 'hello'")"
if [ $? -ne 0 ]; then
  echo "Remote nix-shell error: could not run the 'hello' command:" 1>&2
  echo "$output" 1>&2
  exit 1
fi

### Checking that nix-copy-closure works correctly
hello_deriv="$(nix-shell -p hello --run 'which hello' | xargs dirname | xargs dirname)"
output="$(nix-copy-closure --to $1 -s --gzip $hello_deriv 2>&1)"
if [ $? -ne 0 ]; then
  echo "nix-copy-closure error: could not import a sample derivation:" 1>&2
  echo "$output" 1>&2
  echo "" 1>&2
  echo "Tip: make sure your user is in the 'trusted-users' group:" 1>&2
  echo "  \$ cat /etc/nix/nix.conf" 1>&2
  echo "  trusted-users = ubuntu" 1>&2
  echo "  \$ sudo systemctl restart nix-daemon" 1>&2
  exit 1
fi

nix-copy-closure --to $1 -s --gzip $NIX_SHELL_DERIV
if [ $? -ne 0 ]; then
  echo "nix-copy-closure encountered an error, aborting"
  exit 1
fi

read -p 'Enter the remote path where the run script shall be written [~/nix-shell.sh]: ' REMOTE_SCRIPT_PATH
if [ -z "$REMOTE_SCRIPT_PATH" ]; then
  REMOTE_SCRIPT_PATH='~/nix-shell.sh'
fi

cat <<EOF | ssh $1 -- "cat > $REMOTE_SCRIPT_PATH"
#!/usr/bin/env bash

p="\$PATH"
$(nix-shell --pure --run 'export' | grep -F -e 'declare -x PATH=' -e 'declare -x PYTHONPATH=' -e 'declare -x PERL5LIB=' -e 'declare -x shellHook=')

export PATH="\$p:\$PATH"
export PS1="\[\033[00;32m\][\u@nix-shell:\w]\\\$ \[\033[00m\]"

bash --norc -i --rcfile <(echo "\$shellHook")

EOF
