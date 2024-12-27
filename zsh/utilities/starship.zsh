#!/bin/sh

local scriptDir="$(dirname $0)"
local starshipDir="$scriptDir/../../starship"

export STARSHIP_CONFIG="${starshipDir}/default.toml"

_select-starship-profile() {
    command ls $starshipDir |
        sed 's/\.toml$//' |
        fzf --min-height=5 --height=10% --border --reverse --prompt="Select Starship profile: "
}

switch-theme() {
    if [[ $# -gt 1 ]]; then
        echo "Usage: switch-theme <profile>"
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        profile=$(_select-starship-profile)
        if [[ -z "$profile" ]]; then
            return 1
        fi
    else
        profile="$1"
    fi

    export STARSHIP_CONFIG="${starshipDir}/$profile.toml"
}
