NURAED0 ;HIRMFO/RM,JH,FT-MODULE TO EDIT NURS STAFF FILE ;8/23/96  10:41
 ;;4.0;NURSING SERVICE;**3**;Apr 25, 1997
EN14 ; CALL FROM OPTION NURAED-STF-MENU
 I '$D(^DIC(213.9,1,"OFF")) S XQUIT=1 Q
 I $P(^DIC(213.9,1,"OFF"),"^",1)=1 S XQUIT=1 Q
 D EN1^NURAED01
 Q
EN13 ; CALLED BY MENU OPTION NURAED-STF-ALL
 D C I $D(NQUIT) D Q Q
 F ZX=1:1:10 D @("EN"_ZX) D:ZX<10 CONTASK Q:X=""
 K %,ZX D Q
 Q
CONTASK ;
 S %=1 W !!,"DO YOU WISH TO CONTINUE TO THE NEXT SECTION" D YN^DICN
 I %=-1!(%=2) S X="" Q
 I %=1 S X=1 Q
 W !,"ANSWER YES OR NO" G CONTASK
EN1 ; CALLED BY OPTION NURAED-STF-DEMO
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2) D HEADER^NURAED1 W !,"Nursing Employee Demographic Data Edit. ",!
 I $S('$D(^DIC(213.9,1,0)):0,$P(^(0),"^",3)'=0:1,1:0) S DIE=$P(NURSDBA,"^",2),DA=+NURSDBA,DR="[NURSAED-I-STAFFPR]" D ^DIE K NURSX I X="" D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF1]" D ^DIE,Q Q
EN2 ; CALLED BY OPTION NURAED-STF-PER
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFFPD]" D HEADER^NURAED1,^DIE,Q Q
EN3 ; CALLED BY OPTION NURAED-STF-STA/POS
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2) D HEADER^NURAED1 W !,"Employee's Status and Position.",! S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR=5.5 D ^DIE I X="" D Q Q
 D ^NURAED1 I '$G(NUROUT) W !! S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF2]" D ^DIE
 D Q K NUROUT Q
EN4 ; CALLED BY OPTION NURAED-STF-LIC
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF3]" D HEADER^NURAED1,^DIE,Q Q
EN5 ; CALLED BY OPTION NURAED-STF-PROB
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF10]" D HEADER^NURAED1,^DIE,Q Q
EN6 ; CALLED BY OPTION NURAED-STF-NPSB
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF11]" D HEADER^NURAED1,^DIE,Q Q
EN7 ; CALLED BY OPTION NURAED-STF-EDUC
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF4]" D HEADER^NURAED1,^DIE,^NURAEDCK,Q Q
EN8 ; CALLED BY OPTION NURAED-STF-EXP
 D C I $D(NQUIT) D Q Q
 L +^NURSF(210,+NURSDBA,20,0):1 I '$T W $C(7),!!,"Another user is editing this employee's experience file.",!! Q
 S DA(1)=+NURSDBA,DA=DA(1) D HEADER^NURAED1 W !,"Employee's Professional Experience." S:'$D(^NURSF(210,DA(1),20,0)) ^(0)="^210.13AI^^"
EN83 S ZZ=$P($G(^NURSF(210,DA(1),20,0)),U,3),Y=ZZ,ZZ=$S(ZZ'="":$P($G(^NURSF(210,DA(1),20,ZZ,0)),U),1:ZZ),XZ=ZZ
EN85 S DIC="^NURSF(210,DA(1),20," W !!,"Select PROFESSIONAL EXPERIENCE: "_$S($G(ZZ)'="":$G(ZZ)_"// ",1:"") R X:DTIME G QQ:'$T!(X[U)!(ZZ=""&(X=""))!'($G(DA(1))) G DEL:X["@"
 I X="?" S YY=Y D
 .  W !! S DIC="^NURSF(210,DA(1),20,",D0=DA(1) F Y=0:0 S Y=$O(^NURSF(210,DA(1),20,Y)) Q:Y'>0  D EN6^NURAED3
 .  S DIC="^NURSF(211.5,",DZ="?",DIC(0)="",D="B" N X,Y D DQ^DICQ
 .  Q
 I X="?" S Y=YY G EN85
 S:X="" X=ZZ S DIC="^NURSF(210,DA(1),20,",DIC(0)="EZ",DIC("W")="S NURSLO=^(0) D DICW^NURAED3" D ^DIC
 S XX=X S:X?1"""".PA1"""".P X=$P(X,"""",2)
 I Y=-1 S DIC(0)="EZ",DIC=211.5 D ^DIC D MS85:+Y'>0&(X?1A.E) G EN85:+Y'>0
 I '$D(^NURSF(210,DA(1),20,"B",$P(Y,U,2)))!(XX?1"""".PA1"""".P) S X=$P(Y,U,2),DIC="^NURSF(210,DA(1),20,",DIC(0)="LZ",DLAYGO=210.13 K DO,DD D FILE^DICN
 S XZ=Y(0,0) W !,"PROFESSIONAL EXPERIENCE: "_XZ_"// " R XX:DTIME G QQ:'$T!(XX=U),DEL:XX["@" I XX'="" D MS85 G EN85
 S DA=+Y,DIE="^NURSF(210,DA(1),20,",DR="3;1;2.1;2.5" D ^DIE I '$D(Y) S Y=DA,DA(1)=+NURSDBA L -^NURSF(210,+NURSDBA,20,0)
 S ZZ="" G EN85
MS85 W $C(7),!!,"New clinical backgrounds can only be enter through Site File option!" Q
DEL W $C(7),!?3,"SURE YOU WANT TO DELETE THE ENTIRE '",XZ,"' PROFESSIONAL EXPERIENCE"
DEL1 S %=2 D YN^DICN I %=1 S DA=+Y,DIK=DIC D ^DIK S DA(1)=+NURSDBA W *7,!,"  <DELETED>" K DIK G EN83
 I %'=2 W !?2,"Enter 'Yes' or 'No'" G DEL1
 W $C(7),!,"  <NOTHING DELETED>"
 G EN85
EN9 ; CALLED BY OPTION NURAED-STF-CERT
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF7]" D HEADER^NURAED1,^DIE,Q Q
EN10 ; CALLED BY OPTION NURAED-STF-MIL
 D C I $D(NQUIT) D Q Q
 S DA=+NURSDBA,DIE=$P(NURSDBA,"^",2),DR="[NURSAED-I-STAFF8]" D HEADER^NURAED1,^DIE,Q K NURSM,NURSX Q
 K NPTR,NNM,NSPOS,NSSN
 Q
EN15 ;CALLED BY OPTION NURAED-STF-MENU EXIT ACTION
 K NURSDBA,DA,DIE,XQUIT,NI,NURSTAT,NURX
 Q
C K NQUIT,NPREV I $S('$D(^DIC(213.9,1,"OFF")):1,$P(^("OFF"),"^")'=1:0,1:1) S NQUIT=1 Q
 I $S('$D(NURSDBA):1,$P(NURSDBA,"^",2)=210:0,1:1) D EN1^NURAED01 S NPREV=0 I $D(XQUIT) K XQUIT S NQUIT=1 Q
 Q
QQ K %,%Y,D,D0,DDH,DLAYGO,DI,DIZ,DQ,I,NDA,NOD1,NOD2,NURS,NURSLO,NURSZ,X,XX,XZ,Y,ZZ
Q D:($D(NQUIT)&'$D(ZX))!$D(NPREV) EN15 K NOD1,NOD2,DR,NQUIT,NPREV,DIC,DIE,DA,%DT,J Q