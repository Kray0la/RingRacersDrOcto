# Dr. Octopus's Ring Racers
Community pack for Ring Racers game nights.

## Hosting a server for Ring Racer
- Go to https://github.com/Kray0la/RingRacersDrOcto and download all files listed under the link to your PC. The simplest way to do this is by clicking the green "Code" button around the top right, and then "Download ZIP". Make sure to redownload the pack regularly as it will be updated often.

- Go to where your `ringracer.exe` file is located. In this directory you should also see a `ringconfig.cfg` file. Open this file with any text editor. 

- In it, add the line `http_source https://kray0la.github.io/RingRacersDrOcto/`at the very bottom. Save and close. You only have to do this once.

- Open up Ring Racers. Go to Options > Server Settings and make sure both ``Max Connections`` and ``Max Players`` are both set to 16.

- Now go to the Addons page under Extras and load the `.loadconfig.cfg` file. This config file will instantaneously load all addons from our pack at once.

That's it. Now open up your server under the Online > Host Game tab and you're ready to race.

## Troubleshooting:
- Certain characters/followers are not showing up!
This is likely due to the game prioritising an older version from one of our repacks. For this, you must delete the duplicate addons affected. An easy and dirty fix for this is to simply completely delete your `downloads` folder.
