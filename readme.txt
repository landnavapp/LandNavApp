

LandNav datafield  

Practice land navigation, dead reckoning and orienteering

CREATE AND RUN YOUR OWN LAND NAVIGATION COURSE!
- Upload the boundaries of a nearby park
- Prompts you to locate random points in the park
- Use a map or practice dead reckoning with a compass
- Beeps when you've found the point, press lap to begin the next leg
- Saves GPS tracks (and heart rate if capable) to a FIT file
- Datafield runs with any standard activity

OPTIONAL SETTINGS:
- Shows degrees bearing and distance to the next point
- Updates distance, bearing, and position as you move
- Applies magnetic declination so you don't have to
- Chirps every 100m so you learn pace count
- Shows position in Lat/Lon or MGRS coordinates
- Saves 10 points of your course so a friend can re-run it later on
- Saves points, time and distance stats to a TXT file

This app is to improve your Land Navigation skills. Therefore, there is no 'arrow' and you cannot simply 'punch in' MGRS coordinates on the fly.

REQUIREMENTS
To configure this app, you must have an active internet connection, and sync your device with Garmin Connect or Garmin Connect Mobile app. To access the TXT file, you need a computer with a USB connection.

===================================================================================

	Coming soon - datafield currently undergoing review and approval process!

The below documentation available at https://forums.garmin.com/showthread.php?372973-LandNav-datafield-practice-land-navigation
 
This thread contains information on how to set up and use the LandNav datafield, 
available at the Garmin App store at https://apps.garmin.com/en-US/apps/2c6eec7d-62e0-492c-9b10-2bd3fd932388

	Link will work when approved : ) 

===================================================================================
PART I: ADDING THIS DATAFIELD TO AN ACTIVITY PROFILE

Before using this datafield, you will need to add it to an activity profile. You can create a new one or add it to an existing one. First time users should make this datafield 'full-screen' (to do this set the number of fields to 1). 

You should disable 'Auto Pause', so the activity doesn't 'pause' or 'stop' on its own. 

It is also recommended to: (1) disable 'Auto Lap', (2) disable 'Auto Scroll', (3) hide other screens or 'lock' the buttons so you don't accidentally scroll to other screens while using this app - if you do just scroll back.

To record more accurate GPS data, go 'Settings' -> 'System' -> 'Data Recording' -> 'Every Second'.

===================================================================================
PART II: SAVING PERFORMANCE STATS TO A TXT FILE

Garmin saves GPS tracks to FIT files. If you want to save your LandNav performance stats (times, distances, and coordinates for the points you visited), you will need to manually create a blank TXT file on the device. Plug your device into a computer to access the files via USB. Go to the 'GARMIN/APPS/' subdirectory. Examine the 'date modified' field to see which is the most recently installed one - it should be LandNav. Then go to 'GARMIN/APPS/LOGS/' subdirectory and create a blank text file with the same name as the app. For example, if your app is 3DDDD222.PRG you would want to create a blank text file in the 'GARMIN/APPS/LOGS/' subdirectory and rename it 3DDDD222.TXT. If you download this app a second time, you will need to rename the TXT file, because the app filename will change. 

===================================================================================
PART III: CONFIGURING THE SETTINGS
 
After installing this datafield, you need to configure the settings. Run the Garmin Connect program and sync with your Garmin device. Select 'Connect IQ Apps' -> ('Data Fields') -> 'LandNav' -> '…' or 'Settings': 

The Mode menu determines what the app does. Option 1. Randomize within boundary lets you practice finding points. Enter the park boundary in the Points section, and the app will produce random points within the boundary for you to find. Option 2. Points in random order lets you find pre-selected points. Enter the points, and the app will make you visit them in random order. Option 3. Points in list order has you visit points in order. 

The Points [Lat,Lon_Lat,Lon_] section requires a minimum of 3 points. Points must be Lat/Lon decimal degree format, with 6 digits of precision. Use a comma [,] with no space afterwards to separate latitude,longitude. Use a space [ ] to separate one lat/lon point from another lat/lon point. Use negative numbers to represent southern and western hemispheres. (do NOT include brackets like below)
 
[38.994336,-76.894223 38.994095,-76.893279 38.992560,-76.894127 38.992593,-76.894652 ]
 
The number of digits used for one latitude must be the same as all other latitudes, and the same rule applies to longitudes. In the above example, each latitude has 9 digits (including decimal), and each longitude has 10 digits (including decimal and minus sign). If your course contains a point where the longitude is 11 digits long, you will need to pad all the other longitudes with 0s so they are also 11 digits long.

NOTE: ***For improved performance, use a simple polygon for your boundary. If your boundary is complex or too concave, the app will make numerous attempts to produce a random point inside the boundary, before giving up due to memory and operating system limitations. For every 2 points you can omit from your boundary, the app can conduct 5 additional attempts to find a good point. For example, if your boundary has 10 points it can make 20 attempts, but if it has 6 points it can make 30 attempts. The app will also try to satisfy your maximum and minimum leg distance limits in the settings. If the generated point is out-of-bounds, the background will turn red as shown below:

[for screenshot visit https://forums.garmin.com/showthread.php?372973-LandNav-datafield-practice-land-navigation ]

This red background indicates you must 'skip' points. To 'skip' points, pause the activity, press lap, then un-pause the activity. If you begin the activity too far out-of-bounds, it may also show a red background.


SETTINGS CONTINUED... 

Disable SHOW DISTANCE AND BEARING if you wish to hide the top two fields, and manually calculate the distance and bearing to the next point.

When SHOW SELF-CORRECTING HINTS is enabled, the bearing and distance fields will continually update to show bearing and distance to the next point, and the coordinates indicate your moving position. When disabled, bearing and distance fields will not update. Instead, they will show the bearing and distance from the last point to the next point, and the coordinates will show the location of the next point, not your position.

Enable 100M PACE COUNT BEEP and your device will chirp every 100 meters you move (not 'as the bird flies', but as you meander along), helping you to learn pace count. Arriving at a point or pressing the lap button will reset this pace count to zero. (Vivoactive devices apparently cannot beep)

Enter your MAGNETIC DECLINATION to show magnetic instead of grid bearing. When it is set to 0.0, you will need to adjust for magnetic declination.

POINT RADIUS IN M is how close you must get to one point, before the app will let you move to the next point. If you encounter impassable terrain on the way (ex, if the point is in a lake), you must skip to the next control. To skip, press start/stop, then press lap, then press start/stop again.

MINIMUM LEG IN M is the minimum distance between your location and the next random point. 

MAXIMUM LEG IN M is the maximum distance between your location and the next random point. 

SHOW MGRS NOT LAT,LON displays the coordinates in MGRS format.

SAVE NEXT 10 PTS FOR RE-RUN will save your first 10 points (or skips) to the Points section. Whoever uses the device next will be presented with the same 'course' in mode 3. This is good for some friendly competition! 

===================================================================================
PART IV: BASIC OPERATION

When you load your activity, (if your settings are good) it should look like below. 

[for screenshot visit https://forums.garmin.com/showthread.php?372973-LandNav-datafield-practice-land-navigation ]

If the activity is 'paused' the background will be amber. Press 'Start/Stop'. If the activity is 'running' the background will be white. If you arrive at the next point, it will turn green. The device on the right in the below screenshot is 3 meters away from the point.

[for screenshot visit https://forums.garmin.com/showthread.php?372973-LandNav-datafield-practice-land-navigation ]

Pressing lap while the background is green ('arrived') will begin the next leg, and add a lap to the activity recording in the FIT file. 

Pressing lap while the background is white ('running') will not change legs, but will add a lap to the activity recording.

Pressing lap while the background is amber ('paused') will let you skip to the next leg (before reaching the first point). You might need to do this if the next point is in a lake, or if you encounter impassable terrain. You will definitely need to do this if the background is red, indicating that the point is out-of-bounds. To skip to the next leg, first press 'start/stop' to pause the activity, then press 'lap', then press 'start/stop' again to restart the activity. Note that skipping is annotated with two dashes '--' in the TXT file output.

===================================================================================
PART V: VIEWING TXT FILE OUTPUT

Once you run the app, after you have created a blank text file (as described above), and configured the settings, it will output to the TXT file. For better viewing, copy it to Microsoft Word, and change the font:
 
LOADED [38.990891,-76.900096 38.991440,-76.898423 38.992196,-76.897331 38.992665,-76.897590 ]
MODE 3 =========== TO =========== STARTED 23:04  DECL 11.0  PTS 4
0:00:01  0.00km    00   [38.990891, -76.900093]  18S UJ 3545517176, at 80 for 5m
0:00:19  0.00km    01   [38.991440, -76.898422]  18S UJ 3560217234, at 78 for 154m
0:02:22  0.06km    02   [38.992195, -76.897331]  18S UJ 3569817316, at 60 for 123m
0:03:45  0.13km    03   [38.992664, -76.897591]  18S UJ 3567717369, at 350 for 65m
 
The second line in the TXT file contains (1) the mode, (2) 24hr time the activity started, (3) magnetic declination, and (4) number of points loaded. Each line after that shows (5) elapsed time, (6) elapsed distance in km, (7) the next point number or '--' if it was skipped, (8) the next point (or skipping) location, and (9) the grid, distance and direction possibly displayed on screen.
 

===================================================================================
DEVELOPER NOTES

Unfortunately, I don't have much time to program updates so I hope this app works for you 'as is'. It's pretty small and 'feature-thin' because I programmed it to work on my FR630. But, if you need to practice Land Nav, this app will help! I hope to post the sourcecode soon.
 
(this readme.txt file last updated on 20170402)