#!/bin/bash

SUBFOLDER="extra"

# The first write into the loadmods.cfg file is done with > rather than >> to empty the file if it already exists
# Rather than append to a previously generated loadmods.cfg

# Priority (Y_)
echo "// As a rule of thumb, complex addons need to be loaded first

// Pizza Characters include any chars related to Pizza Tower/McPigs personal projects
// Server characters include any other OCs from Doc Oc
// SEGA Characters include any characters from SEGA, as well as fanmade OCs/AUs
// Misc Characters is for everything else, including shitpost characters

// Priority (Y_)" > .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "Y_D"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/Y_D"* ]]; then
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

# Miscellaneous (Z_)
echo "
// Miscellaneous (Z_)" >> .loadmods.cfg
for FILE in *; do
	if [[ "$FILE" == "Z_D"* ]]; then
		echo -e "addfile \"addons/$FILE\"" >> .loadmods.cfg
	fi
done
for FILE in "${SUBFOLDER}"/*; do
    if [[ "$FILE" == "${SUBFOLDER}/Z_D"* ]]; then
        echo -e "// addfile \"addons/$FILE\"" >> .loadmods.cfg
    fi
done