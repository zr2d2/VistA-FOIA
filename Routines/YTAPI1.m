YTAPI1 ;ALB/ASF PSYCH TEST API ;10/3/02  15:27
 ;;5.01;MENTAL HEALTH;**53,71,76,77**;Dec 30, 1994
SAVEIT(YSDATA,YS) ;
 N N,N2,N4,YSAA,I,II,DFN,YSCODE,YSADATE,YSSCALE,YSBED,YSEND
 D PARSE^YTAPI(.YS)
 IF YSSTAFF'?1N.N!('$D(^VA(200,YSSTAFF))) S YSDATA(1)="[ERROR]",YSDATA(2)="no appro staff" Q
 I '$D(^YTT(601,"B",YSCODE)) S YSDATA(1)="[ERROR]",YSDATA(2)="INCORRECT TEST CODE" Q
 S (YSTEST,YSET)=$O(^YTT(601,"B",YSCODE,0))
 S YSTYPE=$P(^YTT(601,YSTEST,0),U,9),YSINUM=$P(^YTT(601,YSTEST,0),U,11) ;ASF 11/5/01
 I YSTYPE'="T"&(YSTYPE'="I") S YSDATA(1)="ERROR",YSDATA(2)="not a test or int" Q
 D CK:YSCODE'="MCMI2",CKMCMI:YSCODE="MCMI2" Q:YSCK
 ;;
 S ^YTD(601.2,DFN,0)=DFN
 S ^YTD(601.2,DFN,1,0)="^601.21PA^"
 S ^YTD(601.2,DFN,1,YSET,0)=YSET
 S ^YTD(601.2,DFN,1,YSET,1,0)="^601.22DA^"
 S ^YTD(601.2,DFN,1,YSET,1,DT,0)=DT_U_IO_U_YSSTAFF_U_DUZ_U_U_2_U_DUZ(2)_U_YSADATE
 S ^YTD(601.2,DFN,1,YSET,1,DT,1)=R1
 S:$L(R2) ^YTD(601.2,DFN,1,YSET,1,DT,2)=R2
 S:$L(R3) ^YTD(601.2,DFN,1,YSET,1,DT,3)=R3
 S DIK="^YTD(601.2,",DA=DFN,DA(1)=YSET,DA(2)=DT D IX^DIK K DIK ;ASF 10/02/02
 S YSDATA(1)="[DATA]",YSDATA(2)="saved ok"
 S YSENT=YSET,YSDFN=DFN D ENKIL^YTFILE K YSENT,YSDFN ;ASF 6/29/01
 Q
CKMCMI ;check mcmi2
 S YSCK=0
 I $L(R1)'=177 S YSDATA(1)="[ERROR]",YSDATA(2)="MCMI2 BAD #",YSCK=1 Q
 I $L(R1,"T")+$L(R1,"F")+$L(R1,"X")'=178 S YSCK=1 Q
 Q
CK ;
 S YSCK=0
 S X=YSINUM\200+1
 I $E(@("R"_X),YSINUM#200)=""!($E(@("R"_X),YSINUM#200+1)'="") S YSDATA(1)="[ERROR]",YSDATA(2)="wrong # of respon",YSCK=1 Q
 F I=1:1:$L(R1) S X=$E(R1,I) D CK1 Q:YSCK
 Q:'$L(R2)
 F I=201:1:$L(R2) S X=$E(R2,I) D CK1 Q:YSCK
 Q:'$L(R3)
 F I=401:1:$L(R3) S X=$E(R1,3) D CK1 Q:YSCK
 Q
CK1 ;
 I YSTYPE="TEST" D
 . I $P($G(^YTT(601,YSTEST,"Q",I,0)),U,2)'="" S C=$P(^YTT(601,YSTEST,"Q",I,0),U,2)
 . I C'[X S YSCK=1,YSDATA(1)="[ERROR]",YSDATA(2)="test responses dont check"
 I YSTYPE="INTERVIEW" D
 . Q:X=" "
 . S YSQT=$P($G(^YTT(601,YSTEST,"Q",1)),U,1)
 . I +YSQT=3 S YSQT=$E("123456789",1,$P(YSQT,",",2))
 . E  S YSQT="YN"
 . S:YSQT'[X YSCK=1,YSDATA(1)="[ERROR]",YSDATA(2)="interview resp dont check"
 Q