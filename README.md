# Dr. Octopus's Ring Racers
Community pack for Ring Racers game nights.

## Hosting a server for Ring Racers
- Go to https://github.com/Kray0la/RingRacersDrOcto and download all files listed under the link to your PC. The simplest way to do this is by clicking the green "Code" button around the top right, and then "Download ZIP". Make sure to redownload the pack regularly as it will be updated often.

- Go to where your `ringracer.exe` file is located. In this directory you should also see a `ringconfig.cfg` file. Open this file with any text editor. 

- In it, add the line `http_source https://kray0la.github.io/RingRacersDrOcto/`at the very bottom. Save and close. You only have to do this once.

- Open up Ring Racers. Go to Options > Server Settings and make sure both ``Max Connections`` and ``Max Players`` are both set to 16.

- Now go to the Addons page under Extras and load the `.loadconfig.cfg` file. This config file will instantaneously load all addons from our pack at once.

That's it. Now open up your server under the Online > Host Game tab and you're ready to race.

## Troubleshooting:
- Certain characters/followers are not showing up!

This is likely due to the game prioritising an older version from one of our repacks. For this, you must delete the duplicate addons affected. An easy and dirty fix for this is to simply completely delete your `downloads` folder.

## Submitting to the pack
Any addons you'd like to be added to the pact, yours or otherwise, please post them into the Ring Racers Addons channel. **If you do, please keep the following guidelines in mind:**
- **If you want basic adjustments that are changeable just via the S_SKIN text file** (stats, rivals, preferred colour etc.), post your wanted changes in the thread and they will be applied on our end. *Please be as detailed as you can* (For example, give us the internal name of any rivals you might want added).
- **If you are adjusting sprites or sounds**, please resend the entire WAD file.
- **If you're submtting a custom addon**, your WAD must have the naming conventions set out by the SRB2 Message Board. This includes a prefix at the beginning of your file name to indicate what type of addon you are submitting. The most relevant for our server are as follows:

| Prefix | Description |
|---|-------------------------------------|
| D | Required for all Ring Racers addons |
| R | Race                                |
| B | Battle                              |
| C | Character                           |
| F | Follower                            |
| L | Lua                                 |
| S | Sound                               |

An example name would be `DC_MyCharPack_v1.wad`, where here the letter **D indicates it is a Ring Racer Addon**, and the letter **C indicates that it has a playable character in it**.

If you have multiple types of content as listed above, simply put your prefixes in order as displayed. So, if you have an addon with **Race, Battle and Characters** content, you'd put `DRBC_VariousPack_V1.wad`.

This system helps us to know in which order to load addons, and makes organizing everything much easier for us.

## For Internal Use
**These prefixes are for internal use only**, and you do not need to worry about them when submitting addons or requesting changes to the pack. They exist to help enforce specific load orders when relevant, since more complex addons need to be loaded first.

| Prefix | Description (For internal use only) |
|---|---|
| A_ | Priority (Loaded first) |
| Z_ | Miscellaneous (Loaded last) |
