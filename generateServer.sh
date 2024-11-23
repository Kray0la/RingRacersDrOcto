#!/bin/bash

SERVERFOLDER="loadserver"
MAX=7

# This script is meant to generate a ".loadmods.cfg" file cut into several parts that can be loaded a little at a time.
# Such file is consequently much less pretty to look at than its regular counterpart.

# This is neccesary because using the exec console command on a large enough loadmods file will overwhelm the game's
# command buffer, making it so only the first few mods in the list are loaded.

if [ -d "${SUBFOLDER}" ]; then
    rm -rf "${SUBFOLDER}"
fi

mkdir "${SUBFOLDER}"

part=0
i=0

# Priority (A_)
for FILE in *; do
	if [[ "$FILE" == A?_D* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> "${SERVERFOLDER}/.loadserver"${part}".cfg"
		i=$((i+1))
		
		if [[ i -gt MAX ]]; then
			i=0
			part=$((part+1))
		fi
	fi
done

# Characters (C)
for FILE in *; do
	if [[ "$FILE" == "DC"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> "${SERVERFOLDER}/.loadserver"${part}".cfg"
		i=$((i+1))
		
		if [[ i -gt MAX ]]; then
			i=0
			part=$((part+1))
		fi
	fi
done

# Maps (M)
for FILE in *; do
	if [[ "$FILE" == "DR"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> "${SERVERFOLDER}/.loadserver"${part}".cfg"
		i=$((i+1))
		
		if [[ i -gt MAX ]]; then
			i=0
			part=$((part+1))
		fi
	fi
done

# Followers (F)
for FILE in *; do
	if [[ "$FILE" == "DF"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> "${SERVERFOLDER}/.loadserver"${part}".cfg"
		i=$((i+1))
		
		if [[ i -gt MAX ]]; then
			i=0
			part=$((part+1))
		fi
	fi
done


# LUA (L)
for FILE in *; do
	if [[ "$FILE" == "DL"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> "${SERVERFOLDER}/.loadserver"${part}".cfg"
		i=$((i+1))
		
		if [[ i -gt MAX ]]; then
			i=0
			part=$((part+1))
		fi
	fi
done

# SOC (D)
for FILE in *; do
	if [[ "$FILE" == "D_"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> "${SERVERFOLDER}/.loadserver"${part}".cfg"
		i=$((i+1))
		
		if [[ i -gt MAX ]]; then
			i=0
			part=$((part+1))
		fi
	fi
done

# Miscellaneous (Z_)
for FILE in *; do
	if [[ "$FILE" == "Z_D"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> "${SERVERFOLDER}/.loadserver"${part}".cfg"
		i=$((i+1))
		
		if [[ i -gt MAX ]]; then
			i=0
			part=$((part+1))
		fi
	fi
done

if [[ -f ".loadservermaster.cfg" ]]; then
    rm -rf ".loadservermaster.cfg"
fi

for FILE in "${SERVERFOLDER}"/*; do
    echo -e "// exec $FILE" >> ".loadservermaster.cfg"
done