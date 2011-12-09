RMPR5N2 ;HIN/RVD-PRINT INVENTORY BALANCE BY LOCATION ;3/17/03  13:19
 ;;3.0;PROSTHETICS;**33,37,77**;Feb 09, 1996
 ;RVD 3/17/03 patch #77 - allow queing to p-message.  IO to ION.
 D DIV4^RMPRSIT I $D(Y),(Y<0) Q
 S X="NOW" D ^%DT D DD^%DT S RMDAT=Y
 ;
EN K ^TMP($J),RMPRI,RMPRFLG S RMPREND=0 D HOME^%ZIS S DIC="^RMPR(661.3,",DIC(0)="AEQ",DIC("S")="I $P(^RMPR(661.3,+Y,0),U,3)=RMPR(""STA"")"
EN1 R !!,"Enter 'ALL' for all Locations or 'RETURN' to select individual Locations: ",RMENTER:DTIME G:$D(DTOUT)!$D(DUOUT)!(RMENTER="^") EXIT1
 G:RMENTER["?" EN1
 S X=RMENTER X ^%ZOSF("UPPERCASE") S RMENTER=Y I RMENTER="ALL" S RMPRI(0)=1 G CONT
 W ! F RML=1:1 S DIC("A")="Select Location "_RML_": " D ^DIC G:$D(DTOUT)!(X["^")!(X=""&(RML=1)) EXIT1 Q:X=""  D
 .S RMLOCI=$P(^RMPR(661.3,+Y,0),U,1)
 .I $D(RMPRI(RMLOCI)) W $C(7)," ??",?40,"..Duplicate Location" S RML=RML-1 Q
 .S RMPRI(RMLOCI)=+Y
CONT G:'$D(RMPRI) EXIT1 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT1 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="PROSTHETIC INVENTORY LOCATION SUMMARY",ZTRTN="PRINT^RMPR5N2",ZTIO=ION,ZTSAVE("RMPRI(")="",ZTSAVE("RMPR(""STA"")")="",ZTSAVE("RMDAT")="",ZTSAVE("RMPR(")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT1
 ;
PRINT I $E(IOST)["C" W !!,"Processing report....."
 S RMPAGE=1,RMPREND=0,RS=RMPR("STA") D:$D(RMPRI(0)) ALL
 I '$D(RMPRI) D NONE G EXIT
C S RB="" F  S RB=$O(RMPRI(RB)) Q:RB=""  Q:RMPREND  S RMLIEN=RMPRI(RB) D CK
 G:RMPREND EXIT
 W:$E(IOST)["C" @IOF
 D HEAD,WRI D:'$D(^TMP($J)) NONE G EXIT
 ;
CK Q:'$D(^RMPR(661.3,RMLIEN,1,0))
 F J=0:0 S J=$O(^RMPR(661.3,RMLIEN,1,J)) Q:J'>0  F K=0:0 S K=$O(^RMPR(661.3,RMLIEN,1,J,1,K)) Q:K'>0  S RM3=$G(^RMPR(661.3,RMLIEN,1,J,1,K,0)),RMIT=$P(RM3,U,1) D
 .S RMHCPC=$P(RMIT,"-",1),RMDAIT=$P(RMIT,"-",2),RMDAHC=$O(^RMPR(661.1,"B",RMHCPC,0)) Q:'RMDAHC
 .S RM1=$G(^RMPR(661.1,RMDAHC,3,RMDAIT,0)),RMITEM=$P(RM1,U,1) Q:RM1=""
 .S RMBA=$P(RM3,U,2),RMCO=$P(RM3,U,3),RMUNI=$P(RM3,U,4),RMVEN=$P(RM3,U,5)
 .S RMRLE=$P(RM3,U,6),RMDI=$P(RM3,U,7),RMSO=$P(RM3,U,9),RMAV=$P(RM3,U,10)
 .S ^TMP($J,RB,RMIT,RMITEM)=RMAV_"^"_RMBA_"^"_RMCO_"^"_RMUNI_"^"_RMVEN_"^"_RMRLE_"^"_RMDI_"^"_RMSO_"^"_RMLIEN
 Q
 ;write/print report
WRI S RP="" F  S RP=$O(^TMP($J,RP)) Q:RP=""  Q:RMPREND  K RMPRFLG S J="" F  S J=$O(^TMP($J,RP,J)) Q:J=""  Q:RMPREND  S K="" F  S K=$O(^TMP($J,RP,J,K)) Q:K=""  Q:RMPREND  S RMAST="",RM3=^TMP($J,RP,J,K) D
 .I '$D(RMPRFLG) D HEAD1
 .S RMLODA=$P(RM3,U,9)
 .S RMIT=J
 .S RMITEM=K
 .S RMAV=$P(RM3,U,1)
 .S RMBA=$P(RM3,U,2)
 .S RMCO=$P(RM3,U,3)
 .S RMUNI=$P(RM3,U,4)
 .S RMVEN=$P(RM3,U,5)
 .S RMRLE=$P(RM3,U,6)
 .S RMDI=$P(RM3,U,7)
 .S RMSO=$P(RM3,U,8)
 .S:RMUNI RMUNI=$P($G(^PRCD(420.5,RMUNI,0)),U,1)
 .S:RMVEN RMVEN=$P($G(^PRC(440,RMVEN,0)),U,1)
 .S RMITEM=$E(RMITEM,1,27),RMVEN=$E(RMVEN,1,12)
 .S:RMBA<RMRLE RMAST="*"
 .;I RMSO="V" W !,RMHCPC,?9,RMITEM,?37,RMSO,?41,RMVEN,?55,RMUNI,?74,$J(RMBA,5)
 .;I RMSO="C" W !,RMHCPC,?9,RMITEM,?37,RMSO,?41,RMVEN,?55,RMUNI,?58,$J(RMRLE,4),?65,$J(RMAV,8,2),?74,$J(RMBA,5),RMAST
 .W !,RMIT,?9,RMITEM,?37,RMSO,?41,RMVEN,?55,RMUNI,?58,$J(RMRLE,4),?65,$J(RMAV,8,2),?74,$J(RMBA,5),RMAST
 .S RMPRFLG=1
 .I $E(IOST)["C",($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD,HEAD1 Q
 .I $Y>(IOSL-6) W @IOF D HEAD,HEAD1 Q
 Q
 ;
HEAD W !,"*** PROSTHETICS INVENTORY BALANCE BY LOCATION ***",?68,"PAGE: ",RMPAGE,!,"Run Date: ",RMDAT,?30,"station: ",$E($P($G(^DIC(4,RS,0)),U,1),1,20)
 S RMPAGE=RMPAGE+1
 Q
 ;
HEAD1 I $E(IOST)["C",($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD
 I $E(IOST)'["C",($Y>(IOSL-6)) W @IOF D HEAD
 W !,RMPR("L")
 W !,"Location: ",RP
 W !,?54,"UNIT",?60,"RE-"
 W !,?55,"OF",?59,"ORDER",?68,"AVG",?75,"CUR"
 W !,"HCPCS",?9,"ITEM",?36,"SRC",?41,"VENDOR",?53,"ISSUE",?59,"LEVEL",?68,"COST",?75,"BAL"
 W !,"-----",?9,"----",?36,"---",?41,"------",?53,"-----",?59,"-----",?67,"------",?74,"-----"
 S RMPRFLG=1
 Q
 ;
ALL ;PROCESS ALL LOCATION
 K RMPRI(0) S RML="" F  S RML=$O(^RMPR(661.3,"B",RML)) Q:RML=""  D
 .S RLOC=$O(^RMPR(661.3,"B",RML,0))
 .I $P($G(^RMPR(661.3,RLOC,0)),U,3)=RMPR("STA") S RMPRI(RML)=RLOC
 Q
 ;
EXIT I $E(IOST)["C",'RMPREND W ! S DIR(0)="E" D ^DIR
EXIT1 D ^%ZISC
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
NONE W !!,"NO DATA !!!!"
 Q