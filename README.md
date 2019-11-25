# loadStravaGPX
 
### Purpose

I wrote this small script because I had problems with some new fit files (in the file archive are the originals e.g. .fit, .tcx) to decode using the existing R-Packages like "cycletools", "fit", or "fitdc". I want only the pure GPX which is already converted by STRAVA. You can manually download the GPX for each track, but with several hundreds of them it would take forever. <br>
As written here: <br>
https://support.strava.com/hc/en-us/articles/216918437-Exporting-your-Data-and-Bulk-Export <br>
you can export the GPX also with the link www.strava.com/activities/1234567890/export_gpx <br>
The number has to be always the track ID. You can get all the track IDs in CSV format in the file archive with all your data (But only the original data types .fit).
The script reads the ID's in the activities.csv and inserts the correct link in your browser, then it waits a second for the file to be ready for download. It then presses "Enter", waits another second and proceeds with next track.

My firefox had a timer until the downloadbutton gets active. To minimize that you can open the config by typing "about:config" in the URL-panel and then change <br>
security.dialog_enable_delay <br> to 0 <br>


### to do

You have to specify the download and activities.csv path (directory) for yourself in the top of the script. If you want you can specify the "copytoWD", then the script will copy the downloaded tracks into that folder and afterwards delete them from your download directory.
