MCARDPAR ;WISC/TJK,JA-INITIATE SCREEN VARIABLES ;7/18/96  09:32
 ;;2.3;Medicine;;09/13/1996
 ;DJEOP-ERASE FROM CURRENT XY TO END OF SCREEN
 ;DJHIN-HIGH INTENSITY
 ;DJLIN-LOW INTENSITY
 S DJRJ="" D DT^DICRW
 D HOME^%ZIS ;,^%ZIS9
 S X="IOEDEOP;IOINHI;IOINLOW"
 D ENDR^%ZISS S DJHIN=IOINHI,DJLIN=IOINLOW,DJEOP=IOEDEOP,XY=IOXY
 I $D(DJHIN),($D(DJLIN)),($D(DJEOP)),DJHIN'="",DJLIN'="",DJEOP'="",XY'="" S XY=XY_" "_^%ZOSF("XY") G BD
 W !,"'HIGH/LOW INTENSITY', 'ERASE TO END OF PAGE' OR 'XY CRT' ATTRIBUTES"
 W !,"HAVE NOT BEEN PROPERLY DEFINED FOR YOUR TERMINAL. SEE YOUR SITE MANAGER.",*7
 K DJRJ Q
BD ;
 S DJCL="S DY=23,DX=0 X XY W DJEOP"
 S DJCP="S DY=16,DX=0,MCMASS=1 X XY W DJEOP K MCDID"
 S DJRJ=1 K DJJ0,IOSC
 Q