PRCHHI4 ;WISC/TGH-IFCAP SEGMENT ST ;6/18/92  3:12 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ST(A,A1,A2,CNTR,NUM) ;SHIP TO INFORMATION SEGMENT
 N DDP,DDP0,FT,FT0,MP,NM,SP0,STS,STATE,ZIP
 S MP=$P(A,U,2),DDP=$P(A1,U,12)
 S PRCHTP(1,CNTR+1)="S X=""|ST"";514"
 ;G:MP=4&(DDP]"") STD
 S PRCHSITE=+$P(A,U)
 S PRCHST=+$P(A1,U,3)
 S PRCHRL=$G(^PRC(411,PRCHSITE,1,PRCHST,0))
 S SP0=$G(^PRC(411,PRCHSITE,0))
 S FT=+$P(SP0,U,7)
 S FT0=$G(^PRC(411.2,FT,0))
 S PRCHTP(1,CNTR+2)="S X=$P(PRCHRL,U,9);514.1"
 S PRCHB=$S($P(FT0,U,2)]"":$P(FT0,U,2),1:"V.A. *NO FACILITY TYPE*")
 S PRCHTP(1,CNTR+3)="S X=PRCHB;514.2"
 S PRCHB1=$P(PRCHRL,U,1)_" "_$P($P(A,U),"-",2)
 S PRCHTP(1,CNTR+4)="S X=PRCHB1;514.3"
 S PRCHTP(1,CNTR+5)="S X=$P(PRCHRL,U,2);514.4"
 S PRCHTP(1,CNTR+6)="S X=$P(PRCHRL,U,3);514.5"
 S PRCHTP(1,CNTR+7)="S X=$P(PRCHRL,U,5);514.7"
 S PRCHST=$G(^DIC(5,$P(PRCHRL,U,6),0))
 S PRCHTP(1,CNTR+8)="S X=$P(PRCHST,U,2);514.8"
 S PRCHTP(1,CNTR+9)="S X=$P(PRCHRL,U,7);514.9"
 S CNTR=CNTR+9
 S STATE=$P(PRCHRL,U,6),STATE=$G(^DIC(5,STATE,0)),STATE=$P(STATE,U,2)
 S ZIP=$P(PRCHRL,U,7) I ZIP["-" S ZIP=$P(ZIP,"-",1)_$P(ZIP,"-",2)
 S NUM=NUM+1,^TMP($J,"STRING",NUM)="ST"_"^"_$P(PRCHRL,U,9)_"^"_$P(PRCHRL,U,1,4)_"^^"_$P(PRCHRL,U,5)_"^"_STATE_"^"_ZIP_"^|"
 ;$P(PRCHRL,U,9)_"^"_PRCHB_"^"_PRCHB1_"|"
 Q
STD S NM=$G(^DPT(DDP,0))
 S NM=$E($P(NM,U),1,30),NM=$P(NM,",",2)_" "_$P(NM,",")
 S DDP0=$G(^PRC(440.2,DDP,0))
 S ST=$G(^DIC(5,$P(DDP0,U,6),0))
 S PRCHTP(1,2)="S X=NM;514.2"
 S PRCHTP(1,3)="S X=$P(DDP0,U,2);514.3"
 S PRCHTP(1,4)="S X=$P(DDP0,U,3);514.4"
 S PRCHTP(1,5)="S X=$P(DDP0,U,4);514.5"
 S PRCHTP(1,7)="S X=$P(DDP0,U,5);514.7"
 S PRCHTP(1,8)="S X=$P(ST,U,2);514.8"
 S PRCHTP(1,9)="S X=$P(DDP0,U,7);514.9"
TMP ;S ^TMP($J,"STRING",5)="ST"_"^"_
 Q