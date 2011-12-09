DGJOTP ;ALB/MAF - TRANSCRIPTION PRODUCTIVITY REPORT ; FEB 12 1991@900
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
 ;
OUT S (DGJFL,DGJTMESS)=0 W !!,"Sort output by: PHYSICIAN// " D ZSET1 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Pp"[X) S X="1"
 S X=$S("Ss"[X:2,1:X)
 I X="?" D ZSET1,HELP1 G OUT
 S DGJTSR=$E(X) D IN^DGJHELP W ! I %=-1 D ZSET1,HELP1 G OUT
OUT1 S DGJFL=0 W !!,"Print report for: (I)Inpatients, (O)Outpatients, (B)Both//  " D ZSET2 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Bb"[X) S X=3
 S X=$S("Ii"[X:1,"Oo"[X:2,1:X)
 I X="?" D ZSET2,HELP2 G OUT1
 S DGJTSR1=$E(X) D IN^DGJHELP W ! I %=-1 D ZSET2,HELP2 G OUT1
TOT1 S DGJFL=0 W !!,"Print report for: (P)Patient Lists, (T)Totals Page, (B)Both//  " D ZSET3 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Bb"[X) S X=3
 S X=$S("Pp"[X:1,"Tt"[X:2,1:X)
 I X="?" D ZSET3,HELP3 G TOT1
 S DGJTLPG=$E(X) D IN^DGJHELP W ! I %=-1 D ZSET3,HELP3 G TOT1
 I $D(^DG(43,1,"GL")) S DGJTMUL=$P(^DG(43,1,"GL"),"^",2)
 S DGJTL=$S(DGJTSR=1:"PHY",DGJTSR=2:"SER",1:"QUIT")
 S DGJTSTAT="^"_$O(^DG(393.2,"B","INCOMPLETE",0))_"^"_$O(^DG(393.2,"B","DICTATED",0))_"^"_$O(^DG(393.2,"B","TRANSCRIBED",0))_"^"_$O(^DG(393.2,"B","SIGNED",0))_"^"
 G ^DGJOTP1
QUIT K %,%DT,BY,DHD,DIC,DIOEND,DIS,DIR,DTOUT,DUOUT,FR,FLDS,K,L,TO,DGJTCK,DGJTDIR,DGJTL,DGJTLPG,DGJTMESS,DGJTMUL,DGJTSR,DGJTSTAT,DGJTUN,DGJFL,DGJTSR1,DGJ(0),X,Y,Z,DGJTBG,DGJTBEG,DGJTEND,%DT
 K DFN,DGJTBEG,DGJTBG,DGJTEND,DGJTDT,DGJTDV,DGJTDVN,DGJTF,DGJTFF,DGJTFLAG,DGJ,DGJJ,DGJP,DGJSPTOT,DGJSVTOT,DGJTLN,DGJTNODE,DGJTPC,DGJTPHY,DGJTPT,DGJTSP,DGJTSV,DGJY,DGU,IFN,VAUTD,VAUTN,VAUTNI,VAUTSTR,VAUTVB,VAUTT
 K DGFLAG,DGJTAD,DGJTDAT,DGJTDEL,DGJTDIS,DGJTDIV,DGJTDL,DGJTDV1,DGJTMESS,DGJTNODT,DGJTNOW,DGJTOT,DGJTOTAL,DGJTPAG,DGJTPAR,DGJPHTOT,DGJTTO,DGJTTYP,DGPGM,DGVAR,POP,VAR,VA,VADAT,VADATE,VAERR
 K DGJ2CNT,DGJC,DGJCNTX,DGJCOTO,DGJDOC,DGJFFL,DGJJX,DGJT1,DGJT2PC,DGJT2PH,DGJT3PC,DGJT4PC,DGJT5PC,DGJTADN,DGJTADTP,DGJTAIFN,DGJTAT,DGJTCFLG,DGJTCL,DGJTCNT,DGJTCT,DGJTDBY,DGJTDD,DGJTEDT,DGJTFG,DGJTFL,DGJDICTO,DGJTREC,DGJTRNTO,DGJTTI,DGJX
 K DGJ1X,DGJ30AVG,DGJDYAVG,DGJTCOD,DGJTDIC,DGJTO30,DGJTOREC,DGJTTODY,DGJTTRN,DGJT1X,DGJTFLLG,X1,X2,^UTILITY("VAS",$J)
 D CLOSE^DGJUTQ Q
DAT ;DATE RANGE
BEG W ! S %DT="AEX",%DT("A")="START WITH EVENT DATE: " D ^%DT S DGJTBG=Y,DGJTBEG=Y-.0001 S:X="^"!(X="") Y=-1 Q:Y=-1
END W ! S %DT("A")="END WITH EVENT DATE: " D ^%DT S:X="^"!(X="") Y=-1 Q:Y=-1  I Y<1 D HELP^%DTC G END
 S DGJTEND=Y_.9999
 I DGJTEND\1<DGJTBG W !!?5,"The ending date cannot be before the beginning date" G END
 Q
HELP1 W !!,"Choose a number or first initial :" F K=2:1:3 W !?15,$P(Z,"^",K)
 W ! Q
HELP2 W !!,"Choose a number or first initial:" F K=2:1:4 W !?15,$P(Z,"^",K)
 W ! Q
HELP3 W !!,"Choose a number or first initial:" F K=2:1:4 W !?15,$P(Z,"^",K)
 W ! Q
ZSET1 S Z="^1 PHYSICIAN^2 SERVICE/TREATING SPECIALTY^" Q
ZSET2 S Z="^1 INPATIENTS ONLY^2 OUTPATIENTS ONLY^3 BOTH INPATIENT and OUTPATIENTS^" Q
ZSET3 S Z="^1 PATIENTS LIST ONLY^2 TOTALS PAGE ONLY^3 BOTH PATIENTS LIST and TOTALS PAGE^" Q