#!/bin/sh

local scriptDir="$(dirname $0)"
local nixDir="$scriptDir/../nix"

_check-nix-develop() {
    [[ "$SHELL" =~ "/nix/store*" ]]
}

_select-nix-profile() {
    command ls $nixDir | fzf --min-height=5 --height=10% --border --reverse --prompt="Select nix-shell: "
}

enter-nix() {
    if [[ $# -gt 1 ]]; then
        echo "Usage: enter-nix <profile>"
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        profile=$(_select-nix-profile)
        if [[ -z "$profile" ]]; then
            return 1
        fi
    else
        profile="$1"
    fi

    nix develop "$nixDir/$profile"
}

enter-nix-noreturn() {
    if [[ $# -gt 1 ]]; then
        echo "Usage: enter-nix-noreturn <profile>"
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        profile=$(_select-nix-profile)
        if [[ -z "$profile" ]]; then
            return 1
        fi
    else
        profile="$1"
    fi

    enter-nix "$profile"
    retcode=$?

    if [[ $retcode -eq 0 ]]; then
        exit
    fi

    return $retcode
}
