QANBENE2 ;HISC/GJC-Special incidents invol. a beneficiary ;3/3/92
 ;;2.0;Incident Reporting;**1,26,28**;08/07/1992
 ;
EN1 ;sort through divisions, if integrated
 I $G(QANDVFLG)=1 D  Q
 . S QANCC=""
 . F  S QANCC=$O(^TMP("QANBEN",$J,"BEN",QANCC)) Q:QANCC']""  D
 . . D INST^QANRPT1(QANCC,.QANDV)
 . . S QANHEAD(4)="REPORT FOR DIVISION: "_QANDV
 . . D HDH Q:QANQUIT
 . . D EN2 Q:QANQUIT
 I $G(QANQUIT)=1 Q
 I $G(QANDVFLG)'=1 S (QANCC,QANDIV)=0,QANDV="Unknown"
EN2 ;Format of the print for our Beneficiary Report.
 S QANLBL="PATIENT ABUSE/ALLEGED"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(1)",?QANTAB(2),"Alleged Patient Abuse" D STNDRD Q:QANQUIT
 S QANLBL="PATIENT ABUSE/PROVEN"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(2)",?QANTAB(2),"Proven Patient Abuse" D SPECIAL^QANBENE3 Q:QANQUIT
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(3)",?QANTAB(2),"Deaths" D DEATH Q:QANQUIT
 S QANLBL="INFORMED"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(4)",?QANTAB(2),"Failure to Obtain",!?QANTAB(2),"Informed Consent" D RGLAR Q:QANQUIT
 S QANLBL="FALLS"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(5)",?QANTAB(2),"Falls" D STNDRD Q:QANQUIT
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="HOMICIDE"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(6)",?QANTAB(2),"Homicide" D RGLAR2 Q:QANQUIT
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="MED ERR"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(7)",?QANTAB(2),"Medication Errors" D STNDRD Q:QANQUIT
 I PAGE,($E(IOST)'="C") D PRINT^QANBENE3
 D:$Y>(IOSL-8) HDH Q:QANQUIT
 S QANLBL="MISSING PAT"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(8)",?QANTAB(2),"Missing Patient" D STNDRD Q:QANQUIT
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="ASSAULT PAT/PAT"
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !!?QANTAB(1),"(9)",?QANTAB(2),"Patient on Patient",!?QANTAB(2),"Assault" D STNDRD Q:QANQUIT
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 D EN1^QANBENE3 Q:QANQUIT
 Q
DEATH ;Prints for deaths.
 S QANLBL="DEATH-OR"
 W !?QANTAB(3),"In Operating Room",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="DEATH-RR"
 W !?QANTAB(3),"In Recovery Room",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="DEATH-ANESTH" W !?QANTAB(3),"During induction"
 W !?QANTAB(3)," of anesthesia",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="DEATH-48" W !?QANTAB(3),"Within 48 hrs. of"
 W !?QANTAB(3)," surgery",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="DEATH-CON" W !?QANTAB(3),"In conjunction with"
 W !?QANTAB(3)," a procedure",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="DEATH-EQ" W !?QANTAB(3),"Equipment mal-"
 W !?QANTAB(3)," function",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="DEATH-FAIL" W !?QANTAB(3),"Due to failure to"
 W !?QANTAB(3)," diagnose or treat",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 S QANLBL="DEATH-M.E." W !?QANTAB(3),"Cases accepted by",!?QANTAB(3)," Medical Examiner"
 W ?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 S QANLBL="DEATH-MED CEN" W !?QANTAB(3),"On medical center",!?QANTAB(3)," grounds while not"
 W !?QANTAB(3)," being treated",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 Q
RGLAR ;Regular w/o Severity Levels.
 W ?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,2),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,2),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 Q
RGLAR2 ;Regular w/o severity levels - (homicide & suicide)
 W ?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0),?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 Q
STNDRD ;Printing 'Severity Level'
 W !?QANTAB(3),"Severity Level 0",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,0),0)
 W ?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,0),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !?QANTAB(3),"Severity Level 1",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,1),0)
 W ?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,1),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !?QANTAB(3),"Severity Level 2",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,2),0)
 W ?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,2),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 W !?QANTAB(3),"Severity Level 3",?QANTAB(5),$G(QANCOUNT("SLEV",QANCC,QANLBL,3),0)
 W ?QANTAB(6),$G(QANCOUNT("INV",QANCC,QANLBL,3),0)
 D:$Y>(IOSL-4) HDH Q:QANQUIT
 Q
HDH ;End of screen interface.
 Q:QANQUIT
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 QANQUIT=1
 Q:QANQUIT
 D HDR^QANBENE0
 Q