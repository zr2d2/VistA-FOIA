NURCES3 ;HIRMFO/YH-END OF SHIFT REPORT PART 4 - INTRAVENOUS INFUSION ;12/12/96
 ;;4.0;NURSING SERVICE;**2**;Apr 25, 1997
IV K NURIV S NURIV=0,GDATE="" F  S GDATE=$O(^TMP($J,"GMRY",GDATE)) Q:GDATE=""  S GSFT="" F  S GSFT=$O(^TMP($J,"GMRY",GDATE,GSFT)) Q:GSFT=""  D GIO
 D Q^GMRYRP0 K GBLNK,GDA,GCATH,GDATA,GLN,GQ,GQT,GSAVE,GTOTAL,GTYPI,GTYPO
 Q
GIO  S GIO="" F  S GIO=$O(^TMP($J,"GMRY",GDATE,GSFT,GIO)) Q:GIO=""  I GIO="IV" S GHR=0 F  S GHR=$O(^TMP($J,"GMRY",GDATE,GSFT,"IV",GHR)) Q:GHR'>0  D GETDA
 Q
WIVINF ;
 S GDA=0 F  S GDA=$O(^TMP($J,"GMRY",GDATE,GSFT,"IV",GHR,GIVDT,GIVTYP,GSUB,GDA)) Q:GDA'>0  S GDATA=$G(^(GDA)),GAMT=+$P(GDATA,"^") K GTXT
 I GIVTYP="Z" D WCARE Q
 I GAMT>3000 D START Q
 Q
START ;
 S GCATH=$P(GDATA,"^",6),GTYP=$P(GDATA,"^",4),GSITE=$P(GDATA,"^",2),GSOL=$P(GDATA,"^",3),GVOL=$P(GDATA,"^",5),GNURSE=+$P(GDATA,"^",7),GREASON=$P(GDATA,"^",11),GRATE=$P(GDATA,"^",12) D WHR
 Q:GSITE=""!(GVOL="")
 S GPORT="",GSITE(GSITE)="" D FINDCA^GMRYCATH(.GSITE) I $D(^GMR(126,DFN,"IV",GSUB,3)) S GPORT=$P(^(3),"^")
 D WTYPE I GREASON["FLUSH" S GTXT=GTXT_" - "_GSITE(GSITE)_" "_GPORT D FITLINE^NURCES5(GTXT,62,.NURIV) Q
 S GTXT=GTXT_"  "_GVOL_" mls "_$S(GCATH'="":"started",1:"added")_"  Site: "_GSITE_" "_GSITE(GSITE)_$S(GPORT'="":" "_GPORT,1:"") S:GRATE'="" GTXT=GTXT_" Rate: "_GRATE_" ml/hr"
 D FITLINE^NURCES5(GTXT,62,.NURIV)
 Q:$P(GDATA,"^",9)=""  S GSAVE=GHR,GHR=$P(GDATA,"^",9),GNURSE=+$P(GDATA,"^",10),GREASON=$P(GDATA,"^",11)
 S GTXT="     Discontinued on " S Y=GHR X ^DD("DD") S GTXT=GTXT_$P(Y,":",1,2)_" Reason: "_GREASON D FITLINE^NURCES5(GTXT,62,.NURIV)
 S GHR=GSAVE Q
WTYPE ;PRINT IV TYPE
 I GREASON["FLUSH" S GTXT=GTIME_" "_GREASON_" "_GSITE Q
 S GTXT=GTIME_" "_GSOL_" "_$S(GTYP="A":"admix",GTYP="B":"blood",GTYP="P":"piggy",GTYP="H":"hyper",GTYP="I":"intra",1:"")
 Q
WHR ;
 S Y=GIVDT X ^DD("DD") S GTIME="@"_$P($P(Y,"@",2),":",1,2) Q
WCARE ;
 S GTXT="" D WHR S GTXT=GTIME,GSITE=$P(GDATA,"^",7),GCOND=$P(GDATA,"^",2)
 S GDRESS=$S($P(GDATA,"^",4)="Y":" dressing changed",1:""),GTUBE=$S($P(GDATA,"^",3)="Y":" tubing changed",1:"")
 S GDC=$S($P(GDATA,"^",6)="Y":" site discontinued",1:"")
 S GTXT(1)=GCOND S GTXT(1)=GTXT(1)_$S(GTXT(1)'=""&(GDRESS'=""):",",1:"")_GDRESS
 S GTXT(1)=GTXT(1)_$S(GTXT(1)'=""&(GDC'=""):",",1:"")_GDC,GTXT=GTXT_GSITE_" - "_GTXT(1) D:GCOND'="" FITLINE^NURCES5(GTXT,62,.NURIV) S (GTXT,GTXT(1))=""
 I GTUBE'="" S GTXT=" "_$P(GDATA,"^",8)_$S($P(GDATA,"^",9)'="":" - ",1:"")_$P(GDATA,"^",9)_" "_GTUBE D FITLINE^NURCES5(GTXT,62,.NURIV)
 K GTUBE,GDRESS,GDC,GCOND Q
GETDA ;
 S GIVDT=0 F  S GIVDT=$O(^TMP($J,"GMRY",GDATE,GSFT,"IV",GHR,GIVDT)) Q:GIVDT'>0  S GIVTYP="" F  S GIVTYP=$O(^TMP($J,"GMRY",GDATE,GSFT,"IV",GHR,GIVDT,GIVTYP)) Q:GIVTYP=""  D GETDA1
 Q
GETDA1 ;
 S GSUB=0 F  S GSUB=$O(^TMP($J,"GMRY",GDATE,GSFT,"IV",GHR,GIVDT,GIVTYP,GSUB)) Q:GSUB'>0  D WIVINF
 Q