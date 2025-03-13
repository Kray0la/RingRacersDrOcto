#!/bin/bash

function add_prefix {
	echo -e "// === $1 ==="
	for FILE in *; do
		if [[ "$FILE" == $2 ]]; then
			echo -e "addfile \"addons/$FILE\""
		fi
	done
}

add_prefix "PRIORITY" "A?_D*" > .coreMods.cfg
add_prefix "CHARACTERS" "DC*_*"  >> .coreMods.cfg
add_prefix "MAPS" "DR*_*"  >> .coreMods.cfg
add_prefix "FOLLOWERS" "DF*_*"  >> .coreMods.cfg
add_prefix "LUA" "DL*_*"  >> .coreMods.cfg
add_prefix "SOC" "D_*_*"  >> .coreMods.cfg
add_prefix "MISC." "Z_D*"  >> .coreMods.cfg

add_prefix "EXTRA ADDONS" "EX_D*_*" > .extraAddons.cfg