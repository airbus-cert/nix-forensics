{ pkgs
}:

pkgs.writeShellScriptBin "forensicslab" ''
    surge_find_path() {
        find $SURGE_ROOT -ipath $1 -print -quit
    }

    mksurgelab() {
        SURGE_ROOT=''${1%/}  
        SYSTEM_ROOT="$SURGE_ROOT/files/C"

        _SURGE_LAB_HISTFILE="$HISTFILE"
        HISTFILE="$SURGE_ROOT/.bash_history"
        history -r

        WINDOWS_WBEM_REPOSITORY=$(surge_find_path "$SYSTEM_ROOT/Windows/System32/wbem/Repository")
        alias surge_ccm_recentlyusedapps="show_CCM_RecentlyUsedApps.py win7 \"''${WINDOWS_WBEM_REPOSITORY}\" 2>/dev/null"

        
        mksurgeregistry
        mksurgedisk
        mksurgeamcache

        COMPNAME=$(reg_compname)
        _SURGE_LAB_OLD_VIRTUAL_PS1="$PS1"
        PS1="\n\[\033[1;32m\][surge(''${COMPNAME})][nix-shell:\w]\$\[\033[0m\] "

    }

    surge_usnrs() {
        usnrs-cli ''${@:3} --mft ''${1} ''${2}
    }

    surgelabexit() {
        unset SYSTEM_ROOT
        
        unset WINDOWS_WBEM_REPOSITORY
        unset AMCACHE_HIVE

        unalias surge_ccm_recentlyusedapps 2>/dev/null || true
        unalias surge_regipy_amcache 2>/dev/null || true 
        unalias surge_amcacheparser 2>/dev/null || true

        surgeregitryexit
        surgediskexit

        HISTFILE="''${_SURGE_LAB_HISTFILE:-}"
        export HISTFILE
        unset _SURGE_LAB_HISTFILE
        history -r

        PS1="''${_SURGE_LAB_OLD_VIRTUAL_PS1:-}"
        export PS1
        unset _SURGE_LAB_OLD_VIRTUAL_PS1
    }

    mksurgedisk() {
        MFT='$MFT'
        Extend='$Extend'
        UsnJrnl='$UsnJrnl'
        J='$J'
        USN_JRNL='$Extend/$UsnJrnl$J'
        for disk_letter in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
        do
            MFT_PATH=$(surge_find_path "''${SURGE_ROOT}/files/''${disk_letter}/''${MFT}")
            USN_JRNL_PATH=$(surge_find_path "''${SURGE_ROOT}/files/''${disk_letter}/''${USN_JRNL}")
            if [ -f "''${MFT_PATH}" ]; then
                echo "[*] Find MFT for disk ''${disk_letter}"

                if [ -f "''${USN_JRNL_PATH}" ]; then
                    echo "[*] Find UsnJrnl for disk ''${disk_letter}"
                    echo "[*] Creating alias surge_usnrs_''${disk_letter}"
                    alias surge_usnrs_''${disk_letter}="surge_usnrs \"''${MFT_PATH}\" \"''${USN_JRNL_PATH}\""
                fi
            fi
        done
    }

    surgediskexit() {
        for disk_letter in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
            do
                unalias surge_usnrs_''${disk_letter} 2>/dev/null || true
            done
    }


    mksurgeregistry() {
        SYSTEM_HIVE=$(surge_find_path "$SYSTEM_ROOT/Windows/System32/config/SYSTEM")
        SOFTWARE_HIVE=$(surge_find_path "$SYSTEM_ROOT/Windows/System32/config/SOFTWARE")
        SAM_HIVE=$(surge_find_path "$SYSTEM_ROOT/Windows/System32/config/SAM")

        if [ -f "$SYSTEM_HIVE" ] && [ -f "$SOFTWARE_HIVE" ] && [ -f "$SAM_HIVE" ]; then
            echo "[*] Find SYSTEM hive"
            echo "[*] Find SOFTWARE hive"
            echo "[*] Find SAM hive"
            echo "[*] Configuring regrippy"
            # for regrippy
            export REG_ROOT=''${SYSTEM_ROOT}

            echo "[*] Creating alias surge_forensicating, surge_shimcacheparser"
            alias surge_forensicating="forensicating.py \"''${SYSTEM_HIVE}\" \"''${SOFTWARE_HIVE}\" \"''${SAM_HIVE}\""
            alias surge_shimcacheparser="ShimCacheParser.py -i \"''${SYSTEM_HIVE}\""

        else
            echo "[!] Unable to find SYSTEM hive"
            echo "[!] Unable to find SOFTWARE hive"
            echo "[!] Unable to find SAM hive"
            surgeregitryexit
        fi
    }

    surgeregitryexit() {
        unset SYSTEM_HIVE
        unset SOFTWARE_HIVE
        unset SAM_HIVE
        unset REG_ROOT

        unalias surge_forensicating 2>/dev/null || true
        unalias surge_shimcacheparser 2>/dev/null || true
    }

    mksurgeamcache() {
        AMCACHE_HIVE=$(surge_find_path "$SYSTEM_ROOT/Windows/appcompat/Programs/Amcache.hve")

        if [ -f "$AMCACHE_HIVE" ] ; then
            echo "[*] Find AMCACHE hive : creating alias surge_regipy_amcache, surge_amcacheparser"
            alias surge_regipy_amcache="registry-plugins-run -p amcache \"''${AMCACHE_HIVE}\""
            alias surge_amcacheparser="AmcacheParser -f \"''${AMCACHE_HIVE}\""
        else
            echo "[!] Unable to find AMCACHE hive"
            surgeamcacheexit
        fi
    }

    surgeamcacheexit() {
        unset AMCACHE_HIVE
        unalias surge_regipy_amcache 2>/dev/null || true
        unalias surge_amcacheparser 2>/dev/null || true
    }
''
