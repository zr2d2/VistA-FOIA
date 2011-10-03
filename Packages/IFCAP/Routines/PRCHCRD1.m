PRCHCRD1 ;WISC/DJM,ID/RSD-EDIT OF PR CARDS ;5/3/96  9:29 AM [5/12/98 4:21pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN7 ;Edit packaging multiple from file 442 to 441
 Q:'$D(^PRC(441,+PRCHCI,2,PRCHCV,0))  S $P(^(0),U,8)=X G Q
EN8 ;Move FSC from file 442 (P.O.) to 441 (Item Master)
 S $P(^PRC(441,+PRCHCI,0),U,3)=X G Q
EN9 ;Move MAX.ORD.QTY.from file 442 to 441
 Q:'$D(^PRC(441,+PRCHCI,2,PRCHCV,0))  S $P(^(0),U,9)=X G Q
EN10 ;Edit SKU from file 442 to 441
 Q:'$D(^PRC(441,+PRCHCI,3))  S $P(^(3),U,8)=X G Q
EN11 ;Edit UNIT CONVERSION FACTOR from file 442 to 441
 Q:'$D(^PRC(441,+PRCHCI,2,PRCHCV,0))  S $P(^(0),U,10)=X G Q
EN12 ;Edit NATIONAL DRUG CODE from file 442 to 441
 Q:'$D(^PRC(441,+PRCHCI,2,PRCHCV,0))  S $P(^(0),U,5)=X G Q
EN13 ;Edit BOC from file 442 to 441
 ;Q:'$D(^PRC(441,+PRCHCI,0))  S $P(^(0),U,10)=PRCHBOC G Q
 G Q
LST ;ENTERED FROM LAST LINE OF "EN3^PRCHCRD"
 D VEN
 S PRCHCY=^PRC(441,PRCHCI,0)
 S PRCHCNS=$P(PRCHCY,U,5) ;NATIONAL STOCK NUMBER (NSN)
 S PRCHCSC=$P(PRCHCY,U,3) ;FEDERAL SUPPLY CLASSIFICATION (FSC)
 S PRCHCSB=+$P(PRCHCY,U,10) ;BUDGET OBJECT CODE (BOC)
 I PRCHCSB=0 S PRCHCSB=""
 S PRCHCC=+$P($G(^PRC(442,DA(1),0)),U,5) ;COST CENTER
 I PRCHCSB>0,($G(^PRCD(420.1,PRCHCC,1,PRCHCSB,0))="") S PRCHCSB=""
 I PRCHCSB>0 S PRCHCSB=$P(^PRCD(420.2,PRCHCSB,0),U,1)
 S PRCHCY=^PRC(441,PRCHCI,2,PRCHCV,0) ;VENDOR MULTIPLE
 S PRCHCVS=$P(PRCHCY,U,4) ;VENDOR STOCK #
 S PRCHCDC=$P(PRCHCY,U,5) ;NATIONAL DRUG CODE (NDC)
 S PRCHCUC=$P(PRCHCY,U,2) S:$G(PRCHPHAM) PRCHCUC=0 ;UNIT COST
 S PRCHCCN=$P(PRCHCY,U,3) ;CONTRACT
 S PRCHCUP=$P(PRCHCY,U,7) ;UNIT OF PURCHASE
 S PRCHCPK=$P(PRCHCY,U,8) ;PACKAGING MULTIPLE
 S PRCHCMX=$P(PRCHCY,U,9) ;MAXIMUM ORDER QUANTITY
 S PRCHSKM=$P(PRCHCY,U,10) ;UNIT CONVERSION FACTOR
 S PRCHHM=$P(PRCHCY,U,14) ;HAZARDOUS MATERIAL
 S PRCHCY=$G(^PRC(441,PRCHCI,3))
 S PRCHSKU=$P(PRCHCY,U,8) ;STOCK KEEPING UNIT (SKU)
 S PRCHFGRP=$P(PRCHCY,U,7) ;FOOD GROUP
 S PRCHDRTY=$P(PRCHCY,U,9) ;DRUG TYPE CODE
 S PRCHCS=" "
 S L=1
 F M=0:0 S M=$O(^PRC(441,PRCHCI,1,M)) Q:M'>0  S PRCHC("%X",L,0)=PRCHCS_^(M,0),L=L+1,PRCHCS="" ;DESCRIPTION
 S:PRCHCDC]"" PRCHC("%X",L,0)=" NDC:"_PRCHCDC,L=L+1 ;ADD IF NDC
 S PRCHC("%X",0)="^^"_L_U_L_U_DT_U ;SET UP NODE 0 OF DESCRIPTION FOR MOVE
 S %X="PRCHC(""%X"","
 S %Y="^PRC(442,DA(1),2,DA,1,"
 S:PRCHCCN]"" PRCHCY=$G(^PRC(440,PRCHCV,4,PRCHCCN,0)),PRCHCCN=$S($P(PRCHCY,U,2)>DT:$P(PRCHCY,U,1),1:"") ;CONTRACT NUMBER -- FROM FILE 440
 S PRCHC(0)=^PRC(442,DA(1),2,DA,0)
 S PRCHC(2)=""
 S PRCHCQ=$P(PRCHC(0),U,2) ;QUANTITY
 S:$D(^PRC(442,DA(1),2,DA,2)) PRCHC(2)=^PRC(442,DA(1),2,DA,2)
 S PRCHC(4)=$G(^PRC(442,DA(1),2,DA,4))
 S $P(PRCHC(0),U,3)=PRCHCUP ;UNIT OF PURCHASE
 S $P(PRCHC(0),U,12)=PRCHCPK ;PACKAGING MULTIPLE
 S $P(PRCHC(0),U,14)=PRCHCMX ;MAXIMUM ORDER QUANTITY
 S:$P(PRCHC(0),U,4)="" $P(PRCHC(0),U,4)=PRCHCSB ;BOC
 S $P(PRCHC(0),U,9)=PRCHCUC ;ACTUAL UNIT COST
 S $P(PRCHC(0),U,15)=PRCHCDC ;NATIONAL DRUG CODE
 S $P(PRCHC(0),U,16)=PRCHSKU ;STOCK KEEPING UNIT
 S $P(PRCHC(0),U,17)=PRCHSKM ;UNIT CONVERSION FACTOR
 S $P(PRCHC(4),U,12)=PRCHFGRP ;FOOD GROUP
 S $P(PRCHC(4),U,11)=PRCHDRTY ;DRUG TYPE CODE
 S:PRCHCVS'="" $P(PRCHC(0),U,6)=PRCHCVS ;VENDOR STOCK NUMBER
 S:PRCHCNS'="" $P(PRCHC(0),U,13)=PRCHCNS ;NATIONAL STOCK NUMBER
 S $P(PRCHC(2),U,1)=PRCHCQ*PRCHCUC ;TOTAL COST
 S $P(PRCHC(2),U,2)=PRCHCCN ;CONTRACT #
 S $P(PRCHC(2),U,3)=PRCHCSC ;FEDERAL SUPPLY CLASSIFICATION
 S $P(PRCHC(2),U,14)=PRCHHM ;HAZARDOUS MATERIAL
 S ^PRC(442,DA(1),2,DA,0)=PRCHC(0)
 S ^PRC(442,DA(1),2,DA,2)=PRCHC(2)
 S ^PRC(442,DA(1),2,DA,4)=PRCHC(4)
 S:PRCHCSB]"" ^PRC(442,DA(1),2,"D",+PRCHCSB,DA)=""
 S LIN=$P(^PRC(442,DA(1),2,DA,0),U)
 S ^PRC(442,DA(1),2,"AH",+PRCHCSB,LIN,DA)=""
 S:PRCHCCN]"" ^PRC(442,DA(1),2,"AC",$E(PRCHCCN,1,30),DA)=""
 K ^PRC(442,DA(1),2,DA,1)
 D %XY^%RCR ;MOVE DESCRIPTION TO FILE 442, ITEM MULTIPLE
 ;
 ;Release the lock on IMF applied in routine PRCHCRD, tag LCK.
 L -^PRC(441,PRCHCI,0)
 L -^PRC(441,PRCHCI,2,PRCHCV)
 G Q
 ;
VEN I '$D(^PRC(441,PRCHCI,2)) S ^PRC(441,PRCHCI,2,0)="^441.01P^0^0"
 I '$D(^PRC(441,PRCHCI,2,PRCHCV,0)) S ^(0)=PRCHCV,^PRC(441,PRCHCI,2,"B",PRCHCV,PRCHCV)="",$P(^(0),U,3,4)=PRCHCV_U_($P(^PRC(441,PRCHCI,2,0),U,4)+1)
 L +^PRC(441,PRCHCI,2,PRCHCV):5 E  W !!,$C(7),?5,"Another user is editing this entry, try later." Q
 S $P(^PRC(441,PRCHCI,0),U,4)=PRCHCV
 Q
Q K LIN,PRCHC,PRCHCCN,PRCHCCP,PRCHCDC,PRCHCI,PRCHCMX,PRCHCNS,PRCHCPD,PRCHCPK,PRCHCPO,PRCHCQ,PRCHCS,PRCHCSB,PRCHCSC,PRCHCUC,PRCHCUP,PRCHCV,PRCHCVS,PRCHCX,PRCHCY,PRCHSKM,PRCHSKU,PRCHFGRP,PRCHBOC
 Q