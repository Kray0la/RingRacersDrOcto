#!/bin/bash

SUBFOLDER="extra"

# The first write into the loadmods.cfg file is done with > rather than >> to empty the file if it already exists
# Rather than append to a previously generated loadmods.cfg

# Priority (X)
echo "// Priority (X)
// As a rule of thumb, complex addons need to be loaded first
// Pizza Characters include any chars related to Pizza Tower/McPig's personal projects
// Server characters include any other OCs from Doc Oc
// SEGA Characters include any characters from SEGA, as well as fanmade OCs/AUs
// Misc Characters is for everything else, including shitpost characters
" > .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "DY"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/DY"* ]]; then
        echo -e "// addfile \"addons/$FILE\"" >> .loadmods.cfg
    fi
done

# Maps (M)
echo "
// Maps (R)" >> .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "DR"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/DR"* ]]; then
        echo -e "// addfile \"addons/$FILE\"" >> .loadmods.cfg
    fi
done

# Characters (C)
echo "
// Characters (C)" >> .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "DC"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/DC"* ]]; then
        echo -e "// addfile \"addons/$FILE\"" >> .loadmods.cfg
    fi
done

# Followers (F)
echo "
// Followers (F)" >> .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "DF"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/DF"* ]]; then
        echo -e "// addfile \"addons/$FILE\"" >> .loadmods.cfg
    fi
done


# LUA (L)
echo "
// LUA (L)" >> .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "DL"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/DL"* ]]; then
        echo -e "// addfile \"addons/$FILE\"" >> .loadmods.cfg
    fi
done

# Miscellaneous (Z)
echo "
// Miscellaneous (Z)" >> .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "DZ"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/DZ"* ]]; then
        echo -e "// addfile \"addons/$FILE\"" >> .loadmods.cfg
    fi
done