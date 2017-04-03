using Toybox.Application as App;
using Toybox.Activity as Act;
using Toybox.Attention as Attn;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.Math as Math;
	
class LandNavApp extends App.AppBase {
    function initialize() {
        AppBase.initialize();
    }
    function getInitialView() {
        return [ new LandNavView() ];
    }
    function onStart(state) {  	
    }
    function onStop(state) {
    	if (getProperty("B")) { 
	    	setProperty("B", false);
	    	setProperty("A", 3);
	    	Sys.println("* SAVED [" + getProperty("C") + "]");
		} 
    }
}


class LandNavView extends Ui.DataField {

	var pC;
	var pB;	
	var LD; 
	var m1;
	var sDs;
	var sDr;
	var LaD; 
	var LoD;
	var nP;  
	var crs;
	var aLa, aLo, xLa, xLo, rLa, rLo;
	var cL; 
	var rL;
	var i;
	var j;
	var z;
	var fA, fB, Ds;
	var cr;
	var pz;

    //--------------------------------------------------------------------------------------------
    //function memstr () {
    //	return ((Sys.getSystemStats().freeMemory.toFloat()/Sys.getSystemStats().totalMemory.toFloat()) * 100).toNumber() + "%";
    //	//return Sys.getSystemStats().freeMemory + " or " + ((Sys.getSystemStats().freeMemory.toFloat()/Sys.getSystemStats().totalMemory.toFloat()) * 100).toNumber() + "%";
    //} 
     //--------------------------------------------------------------------------------------------
	/*function distFromCourse(x, y, BLon, BLat, prevLon, prevLat) { // not implemented yet
	
		  var A = x - BLon;
		  var B = y - BLat;
		  var C = prevLon - BLon;
		  var D = prevLat - BLat;
		
		  var dot = A * C + B * D;
		  var len_sq = C * C + D * D;
		  var param = -1;
		  if (!len_sq.equals(0)) { //in case of 0 length line
		      param = dot / len_sq;
			}
		  var xx, yy;
		
		  if (param < 0) {
		    xx = BLon;
		    yy = BLat;
		  } else if (param > 1) {
		    xx = prevLon;
		    yy = prevLat;
		  } else {
		    xx = BLon + param * C;
		    yy = BLat + param * D;
		  }
		
		  var dx = x - xx;
		  var dy = y - yy;
		  return Math.sqrt(dx * dx + dy * dy);
	}*/
    //--------------------------------------------------------------------------------------------
	function MX(a, b) {
		return ( (a > b) ? a : b );
	}
	function MN(a, b) {
		return ( (a < b) ? a : b );
	}
    //--------------------------------------------------------------------------------------------
    function initialize() {
		DataField.initialize();
		onTimerReset();				
		
		crs = App.getApp().getProperty("C");
		
		z = crs.length().toNumber();
		if (z > 0) {
			LaD = crs.find(","); // 9 LaD  	
			LoD = (crs.find(" ") - 1 - LaD); // 20 - 1 - LaD(9) = 10 LoD
			//Sys.println("z = " + z + "     cD = " + cD);
    		nP = ( z / (LaD + LoD + 2) );
    		//Sys.println("nP = " + nP + "   LaD = " + LaD + "   LoD = " + LoD);
		}			
    	//Sys.println("z = " + z);
    	if (    (z < 1) or (nP < 3) or (LoD < 0) or (LaD.equals(0)) or (!crs.substring((z - 1), z).equals(" "))   ) {
    		nP = 0;
    		return;
    	} else { // if points good
    		z = App.getApp().getProperty("A").toNumber();			 			
			if (z.equals(1)) { //randomize within boundary
			    rLa = (App.getApp().getProperty("L").toFloat() / 110574);
			    rLo = (App.getApp().getProperty("L").toFloat() / (  Math.cos(Math.toRadians(LA(0))) * 111320  ));
		     	//Sys.println("rLa = " + rLa + "      rLo = " + rLo);
			    aLa = LA(0);
			    xLa = LA(0); // use as Max
			    aLo = LO(0);
			    xLo = LO(0); // use as Max
		    	for(i = 1; i < nP; i++) {
					xLa = MX( xLa, LA(i));
					aLa = MN( aLa, LA(i));
					xLo = MX( xLo, LO(i));
					aLo = MN( aLo, LO(i));
				} 
				//Sys.println("aLa = " + aLa + "     aLo = " + aLo);
				crs = crs + aLa + "," + aLo + " " + xLa + "," + xLo + " ";
				//Sys.println("1) from  " +  + "," + LO(nP) + "   to   " + LA(nP+1) + "," + LO(nP+1));
				if (Activity.getActivityInfo().currentLocation) {
					FX();
				}
			}
			Sys.println("LOADED [" + App.getApp().getProperty("C") + "]");
			if (App.getApp().getProperty("B")) { // if save course
				App.getApp().setProperty("C", ""); // clear points in settings
			}
			Sys.println(    Lang.format(  "MODE $1$$2$========== TO =========== STARTED $3$:$4$  DECL $5$  PTS $6$", [z, (App.getApp().getProperty("B") ? "* " : " ="), Sys.getClockTime().hour.format("%02d"), Sys.getClockTime().min.format("%02d"), App.getApp().getProperty("D").format("%0.1f"), nP])  );
			z = 0;
			j = z; // reset z and j (to equal each other) in case use for randomizing preset points...

    	} // end if points good
    }
    //--------------------------------------------------------------------------------------------
	function LA(p) {  
		var k = (p * (LaD + LoD + 2)); 
		return crs.substring(k, (k + LaD)).toFloat();// + Yoffset; //App.getApp().getProperty("Y").toFloat();
	}
    //--------------------------------------------------------------------------------------------
	function LO(p) {
		var k = (p * (LaD + LoD + 2)) + LaD + 1; 
		return crs.substring(k, (k + LoD)).toFloat();// + Xoffset; //App.getApp().getProperty("X").toFloat();
	}
    //--------------------------------------------------------------------------------------------
    function onTimerStart() {
        Ui.requestUpdate();
        pz = false;
    }
    //--------------------------------------------------------------------------------------------
    function onTimerStop() {
        Ui.requestUpdate();
        pz = true;
    }    
    //--------------------------------------------------------------------------------------------
    function onTimerReset() {
		Ds = 0.0;
		cL = 0; 
		rL = -1;
		sDs = "";
		sDr = "";
		pz = true;
		cr = "";
    }
	//--------------------------------------------------------------------------------------------
	function uTD() { //time distance 
		if (Activity.getActivityInfo()) {
			fA = (Activity.getActivityInfo().elapsedTime / 1000);
			fB = (fA / 60);
			return Lang.format("$1$:$2$:$3$  $4$km    ", [ (fB / 60), (fB % 60).format("%02d"), (fA % 60).format("%02d"), ((Activity.getActivityInfo().elapsedDistance ? Activity.getActivityInfo().elapsedDistance : 0 ) / 1000).format("%02.2f")]);
		}
		return "-:--:--  -.--km    ";
	}
    //--------------------------------------------------------------------------------------------
    function onTimerLap() {
		if (LD) {
			Math.srand(LD.toNumber());
		}
		LD = null; // resets LD for current distance

       	if (!pz) { // if RUNNING and ARRIVED	
	       	if ((!Ds.equals(0.0)) && (Ds < (App.getApp().getProperty("W") + 1)) ) { // if completed leg 
			    sP(pB); 
	       	}
	    } else { // if PAUSED and user wants to SKIP
	    	if (Activity.getActivityInfo().currentLocation) {
				Sys.println(uTD() + "--    " + Activity.getActivityInfo().currentLocation.toDegrees() + "  " + Activity.getActivityInfo().currentLocation.toGeoString(App.getApp().getProperty("M") ? 3 : 2) );
			    sP(Activity.getActivityInfo().currentLocation);
	    	}
	    }
       	Ui.requestUpdate();
       	
    }  
    //--------------------------------------------------------------------------------------------
    function buf(s,n) { // add space to end of point if has less digits than standard as defined in initialize
    	var b = "";
    	for (i = n - s.length(); i > 0; i--) {
			b = b + " ";
		}
		//b = b + s;
		//Sys.println("buf [" + b + "]");
		return (b + s); 
    }
    //--------------------------------------------------------------------------------------------
    function sP(loc) { // save point
		cL = rL + 1; // update currentLap here
		if (   (App.getApp().getProperty("B"))   &&   (App.getApp().getProperty("C").length() <  260 )) { // save point if save option enabled and course has less than 260 characters
			App.getApp().setProperty("C", App.getApp().getProperty("C") + buf(loc.toDegrees()[0].toString(),LaD) + "," + buf(loc.toDegrees()[1].toString(),LoD) + " ");
			//App.getApp().setProperty("C", App.getApp().getProperty("C") + loc.toDegrees()[0].toString() + "," + loc.toDegrees()[1].toString() + " ");
			//Sys.println(cL + " #   " + memstr() + "% 'C' added " + loc.toDegrees());
		}
    }
    //--------------------------------------------------------------------------------------------
   	function gDr() {
	    fA = pB.toRadians()[1].toFloat() - pC.toRadians()[1].toFloat();
	    fB = Math.log(   Math.tan (pB.toRadians()[0].toFloat()/2.0 + Math.PI/4.0) / Math.tan( pC.toRadians()[0].toFloat()/2.0 + Math.PI/4.0 ) );
	    if (fA > Math.PI) {
	        fA = -(2.0 * Math.PI - fA);
	    }
	    else if (fA < -Math.PI) {
	        fA = (2.0 * Math.PI + fA);
	    }
	    sDr = ((at2(fA, fB) * (180 / Math.PI)) + 360.0 + App.getApp().getProperty("D").toFloat() ).toNumber() % 360; // add declination to grid azimuth to get magnetic azimuth
	}
    //--------------------------------------------------------------------------------------------
	function at2(y, x) {
		if (x > 0) {
			return Math.atan((y / x));
		}
		if (x < 0) {
			if (y >= 0) {
				return Math.atan((y / x)) + Math.PI;
			}
			return Math.atan((y / x)) - Math.PI;
		}
		if (y > 0) {
			return Math.PI / 2;
		}
		if (y < 0) {
			return -Math.PI / 2;
		}
		return 0.0;
	}
    //--------------------------------------------------------------------------------------------
	function gDs () { // get distance, save in 'Ds' var
		fA = 111.3 * Math.cos((pC.toDegrees()[0].toFloat() + pB.toDegrees()[0].toFloat()) / 2 * 0.01745) * (pC.toDegrees()[1].toFloat() - pB.toDegrees()[1].toFloat()); 
	    fB = 111.3 * (pC.toDegrees()[0].toFloat() - pB.toDegrees()[0].toFloat());
		Ds = 1000 * Math.sqrt(fA * fA + fB * fB);
	}     
    //--------------------------------------------------------------------------------------------
    function IN() { // isInside - determines whether point falls inside polygon
    	var IS = false; //inside = false to start
		j = nP - 1; // j = number of points minus one
    	for ( i = 0 ; i < nP ; i++ )
    	{
        	if ( ( LA(i) > pB.toDegrees()[0].toFloat() ) != ( LA(j) > pB.toDegrees()[0].toFloat() ) &&
                pB.toDegrees()[1].toFloat() < ( LO(j) - LO(i) ) * ( pB.toDegrees()[0].toFloat() - LA(i) ) / ( LA(j) - LA(i) ) + LO(i) )
        	{
            	IS = !IS; // inside = !inside
        	}
    		j = i;
    	}
    	//Sys.println(z + " z) " + memstr());
    	//Sys.println(z + " z) " + memstr() + "  atmp " + IS + "  " + pB.toDegrees()[0].toFloat() + "," + pB.toDegrees()[1].toFloat());
    	//Sys.println("completed IN first section");
	    if (IS) {
			gDs(); 
			if ( (Ds < App.getApp().getProperty("S")) or (Ds > App.getApp().getProperty("L")) ) { 
				IS = false;
			}
	    }
	    return IS;
    }
    //--------------------------------------------------------------------------------------------
    function compute(info) {     	
        // elapsed distance
	    if (info.elapsedDistance) {		    
        	if (LD) { // if LD is not null
	        	if ( m1 < (((info.elapsedDistance - LD) / 100).toNumber())  ) { // if number of counted 100ms is smaller than current count of 100ms
					//if ((App.getApp().getProperty("P")) && (Attn has :playTone)) { // skip "has playtone" for this device since should have capability
					if (App.getApp().getProperty("P")) { // can play 100m pace count
						Attn.playTone(7);
						//Sys.println("played tone, m1 = " + m1 + " ");
					}
					m1 = ((info.elapsedDistance - LD) / 100).toNumber(); // reset pace count if beeped...
					//Sys.print("m1 now = " + m1 + " ");
				}
			} else { // if LD was null (reset), then reset LD to current elapsed Distance, and reset count of 100ms to 0
		    	LD = info.elapsedDistance;
		    	m1 = 0;
			}
		}
		
	if (!nP.equals(0)) { // if number of points = 0, means that points were bad, so skip all this logic entirely
				
		// gps stuff
        if (info.currentLocation) { // != null) {
        	pC = info.currentLocation;
	        
	        if (cL > rL) {  // if loading next point...
		        pB = Activity.getActivityInfo().currentLocation; // use getActivityInfo to unusually allow for two variables... current and target
		            
		        if (App.getApp().getProperty("A").toNumber().equals(3)) { // CONTROLS IN LIST ORDER
					if (cL.equals(nP)) { // loop if reached last point
						cL = 0;
						rL = -1;
					}
					pB.initialize({
					    :latitude => LA(cL).toFloat(),
					    :longitude => LO(cL).toFloat(),
					    :format => :degrees
					});	
					gDs();	
				} else { // anything other than "controls in list order" follows... 
			        
			        
			        if (App.getApp().getProperty("A").toNumber().equals(1)) { // RANDOMIZE WITHIN BOUNDARY
						z = 0;
						while (z < (451 - (25*nP)) ) { 
							//Sys.println("3) from  " + aLa + "," + aLo + "   to   " + xLa + "," + xLo + "    z: " + z);
							//Sys.println("3) " + memstr() + "     z: " + z);
							pB.initialize({
							  :latitude =>  (aLa + ( (Math.rand() % ((xLa-aLa) * 100000).toLong() ).toFloat() / 100000 ).toFloat()),
							  :longitude => (aLo + ( (Math.rand() % ((xLo-aLo) * 100000).toLong() ).toFloat() / 100000 ).toFloat()),
							  :format => :degrees
							});	
							if (IN()) {
								break;
							}
							z = z + 10;
						}
						if (z > (450 - (25*nP))) {  // if did too many calculations, just proceed, inform user that they need to skip points... using red background in onUpdate
							Sys.println("NEXT POINT OUT OF BOUNDS (" + (z/10) + "/" + ((450 - (25*nP))/10).toNumber() + " " + ((Sys.getSystemStats().freeMemory.toFloat()/Sys.getSystemStats().totalMemory.toFloat()) * 100).toNumber() + "%) SKIP REQUIRED");
						}
				
				
					} else { // CONTROLS IN RANDOM ORDER
						while (j == z) { 
							z = Math.rand() % nP;
						} 
						j = z;
						pB.initialize({
						    :latitude => LA(z).toFloat(),
						    :longitude => LO(z).toFloat(),
						    :format => :degrees
						});	
						gDs();
					}
				}
				///// CONTINUE PROCESSING NEW POINT HERE
				if (App.getApp().getProperty("Z")) { // if show distance and bearing
					sDs = Ds.toNumber();
					gDr();
				}	
				// print out new point information here
				Sys.println(uTD() + cL.format("%02d") + "    " + pB.toDegrees().toString() + "  " + pB.toGeoString(App.getApp().getProperty("M") ? 3 : 2) + ", at " + sDr + " for " + Ds.toNumber() + "m");
	            LD = ((info.elapsedDistance? info.elapsedDistance : 0) / 100).toNumber() % 100;	// reset PACECOUNT distance   //mike this parenthetical did the trick to make watch not crash...
	            rL = cL; 	// reset currentLap
	        
	        
	        } else { // PROCESS MOVEMENT (not new point)  , do regular distance calculation, coord update if show Hints enabled
		        gDs();	// always get Distance to check if ARRIVED
				if (App.getApp().getProperty("H")) {		//  (if self correcting)
					sDs = Ds.toNumber();					// update Distance for display purposes
					if (App.getApp().getProperty("Z")) {	//  (if show dist/dir)
						gDr();								// update Direction
					}				
					cr = pC.toGeoString(App.getApp().getProperty("M") ? 3 : 2); // show YOUR location
				
				} else {									//  (if not self correcting)
					cr = pB.toGeoString(App.getApp().getProperty("M") ? 3 : 2); // show NEXT location
				}
		        if (App.getApp().getProperty("A").toNumber().equals(1)) { // randomize within boundary
					FX(); // ADJUST LIMITS (pick smallest area to pick random point from, based on leg limits in settings, and boundary max min
				} // end if randomize within boundary		
 			}
   		}
   	} // if (!nP.equals(0)) {

	}
	//--------------------------------------------------------------------------------------------
	function FX(){ // ADJUST LIMITS (pick smallest area to pick random point from, based on leg limits in settings, and boundary max min
		//if (Activity.getActivityInfo().currentLocation) {
			aLa = MX( (Activity.getActivityInfo().currentLocation.toDegrees()[0] - rLa), LA(nP));
			aLo = MX( (Activity.getActivityInfo().currentLocation.toDegrees()[1] - rLo), LO(nP));
			//Sys.println("aLa = " + aLa + "      aLo = " + aLo);
			// now want to take the smallest of the maximums (diff or max)
			xLa = MN( (aLa + rLa + rLa), LA(nP+1));
			xLo = MN( (aLo + rLo + rLo), LO(nP+1));
			//Sys.println("2) from  " + aLa + "," + aLo + "   to   " + xLa + "," + xLo);
		//}
	}
	//--------------------------------------------------------------------------------------------
	function onUpdate(dc) 
    {
    	
    	if (z > (450 - (25*nP))) { 
	        dc.setColor( Gfx.COLOR_RED , Gfx.COLOR_RED );
		} else {
	    	if ((Ds != 0.0) && (Ds < (App.getApp().getProperty("W") + 1))) { 		
				//if (Toybox.Attention has :playTone) {
				Attn.playTone(15);				
				//}
	    		dc.setColor( Gfx.COLOR_GREEN , Gfx.COLOR_GREEN );					// background color
	    	} else {
	    		dc.setColor( Gfx.COLOR_WHITE , Gfx.COLOR_WHITE );
	    	}
	    	
			if (pz) {	
	        	dc.setColor( Gfx.COLOR_YELLOW , Gfx.COLOR_YELLOW );
			}
		}
 		dc.clear(); 
        dc.setColor( Gfx.COLOR_BLACK, -1 ); 
        //dc.drawText( 107, 154, 0, (z/10) + " / " + ((450 - (25*nP))/10).toNumber() + ", " + memstr(), 1 ); 	// "p" + LD + " " + memstr(), 1 ); 								// memory at bottom
	    dc.setPenWidth(3); //=========== THICK lines============================================================ 
		dc.drawLine( 0, 83, 218, 83); // horizontal
	    dc.drawLine( 97, 83, 97, 0 ); // vertical 
		
		if (nP > 0) { 
			if (App.getApp().getProperty("M")) {  									// M G R S 
			    dc.drawText( 175, 97, 4, cr.substring(0,3) + cr.substring(4,12), 0 );   
			    dc.drawText( 175, 127, 4, cr.substring(12,17), 0 ); 
			} else {																// L A T & L O N 
			    var sLb = cr.find("W");
			    if (sLb == null) { 
					sLb = cr.find("E");
				}
				if (sLb == null) {
			    	cr = "- ----'--.--\"- ----'--.--\"";
					sLb = 14;
				}
				dc.drawText( 114, 94, 4, cr.substring(0,sLb), 1 );
				dc.drawText( 114, 124, 4, cr.substring(sLb, cr.length()), 1 );
			}
			if (App.getApp().getProperty("Z")) { // show distance direction
				dc.drawText( 113, 25, 6, sDs, 2 ); 									// distance
	
		    	dc.setColor( Gfx.COLOR_RED, -1 );  									// direction
				dc.drawText( 80, 25, 6, sDr, 0 ); 
			}
		} else { // if (nP <= 0) 
			dc.drawText( 175, 97, 4, "Points Error", 0 );   
		} 
	}
//EOC---------------------------------------------------------------------------------------------
}
