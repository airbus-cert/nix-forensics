# nix-forensics

Spawn a complete forensics environment in a reproducible way. Read its [associated blog post](https://skyblue.team/posts/nix-forensics/).

## Usage

### In a nix-enabled, Internet-connected environment

```
$ git clone https://github.com/airbus-cert/nix-forensics.git
$ cd nix-forensics
$ nix-shell
[nix-shell:~/nix-forensics-public]$ regrippy  --list|head
- auditpol(SECURITY): Get the advanced security audit policy settings
- compname(SYSTEM): Returns the computer name
- env(['SYSTEM', 'SOFTWARE', 'NTUSER.DAT']): Lists all environment variables
- filedialogmru(NTUSER.DAT): Reads OpenSaveMRU and LastVisitedMRU keys
- gpo(['SOFTWARE', 'NTUSER.DAT']): list all GPOs applied on this system
- kb(SOFTWARE): get all KB update installation status
```

This will build all required tools, both public and private ones, and put you in a shell where they're all ready to use.

```
$ bash export-shell.sh user@remote-server
```

This will copy all derivations required to run the environment to the remote server. Only missing derivations will be copied: this is potentially very fast. **Nix must be installed** on the remote server!

A script to enter the environment will be written at `~/nix-shell.sh` on the remote host.

### Building a Docker image containing all tools

```
$ nix-build . -A docker
```

Will generate a Docker image which, when instanciated, drops you in a shell similar to what you would get with the first option.

Import the Docker image like so:

```
$ docker load <result
```

### Using a ready-made bundle on a remote server

In the [Actions](actions/workflows/nix_shell_bundle.yml) tab, go to the latest action summary, and download the `nix-shell` artefact. Run the action manually if needed, in order to build the bundle for the latest commit. These bundles are not built for every single commit due to size constraints (each bundle is around 500MB).

Unzip the resulting file on the remote server, and run `nix-shell.sh`. This will automatically import the required derivations and drop you in a shell.

This still requires Nix to be installed on the server!


## Troubleshooting

### error: cannot add path XXX because it lacks a valid signature

This error happens because the remote user you are using is not part of Nix's "trusted group". Importing closures can be a potential security risk, so you need to manually allow your user to do it.

Edit `/etc/nix/nix.conf` on the remote machine and add the following line:

```
trusted-users = YOUR_USERNAME
```

Then, restart the Nix daemon:

```
$ sudo systemctl restart nix-daemon
```

### error: package is marked as insecure, refusing to evaluate

This shell uses Python 2.7, which is (rightly) marked as insecure. You can tell Nix "I understand the risks" by setting the following environment variables:

```
export NIXPKGS_ALLOW_INSECURE=1
```

### error: package is marked as unfree, refusing to evaluate

This shell uses Volatility 3, which uses a custom software licence, and as such is not free software. If you accept to taint your computer with proprietary software, set the following environment variable:

```
export NIXPKGS_ALLOW_UNFREE=1
```
