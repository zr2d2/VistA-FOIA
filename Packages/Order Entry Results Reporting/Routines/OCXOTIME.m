OCXOTIME ;SLC/RJS,CLA - PROCESS TIME BASED EVENT ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
 Q
EN ;
 ;
 Q:'$$RTEST
 ;
 N OCXDATE,OCXDFN,OCXELEM,OCXRULE
 S OCXRULE=0 F  S OCXRULE=$O(^OCXD(860.1,"TIME",OCXRULE)) Q:'OCXRULE  D
 .S OCXDFN=0 F  S OCXDFN=$O(^OCXD(860.1,"TIME",OCXRULE,OCXDFN)) Q:'OCXDFN  D
 ..S OCXDATE=0 F  S OCXDATE=$O(^OCXD(860.1,"TIME",OCXRULE,OCXDFN,OCXDATE)) Q:'OCXDATE  I '((+OCXDATE)>OCXNOW) D
 ...N DFN,OCXOSRC,OUTMSG,OCXNOTIF,OCXELEM
 ...S OCXOSRC="TIMED ORDER CHECK",(OUTMSG,OCXNOTIF)=""
 ...S OCXORMTR="ORMTIME: Executing D UPDATE^OCXOZ01  DATE: "_OCXDATE
 ...D LOG("     "_OCXORMTR)
 ...S OCXORMTR="    RULE: "_(+OCXRULE)_" ("_$P($G(^OCXS(860.2,+OCXRULE,0)),U,1)
 ...D LOG("     "_OCXORMTR)
 ...S OCXORMTR="    Patient: "_OCXDFN_" ("_$P($G(^DPT(OCXDFN,0)),U,1)_")"
 ...D LOG("     "_OCXORMTR)
 ...S OCXELEM=0 F  S OCXELEM=$O(^OCXS(860.2,OCXRULE,"C","C",OCXELEM)) Q:'OCXELEM  D
 ....S:($P($G(^OCXS(860.6,+$P($G(^OCXS(860.3,+OCXELEM,0)),U,2),0)),U,1)="TIMED ORDER CHECK") OCXOSRC("ELEMENT",OCXELEM)=""
 ...K ^OCXD(860.1,"TIME",OCXRULE,OCXDFN,OCXDATE)
 ...K ^OCXD(860.1,OCXDFN,2,OCXDATE,1,OCXRULE)
 ...K ^OCXD(860.1,OCXDFN,2,OCXDATE,1,"B",OCXRULE,OCXRULE)
 ...I '$O(^OCXD(860.1,OCXDFN,2,0)) K ^OCXD(860.1,OCXDFN,2)
 ...D LOGOCX("TIMEOC")
 ...D UPDATE^OCXOZ01(OCXDFN,OCXOSRC,.OUTMSG)
 ;
 Q
 ;
LOG(TEXT) ;
 ;
 Q
 ;
LOGOCX(OCXSRC) ;
 ;   Log Messages
 Q
ERROR Q
 ;
ACT(OCXDATE,OCXORD) Q:'$$RTEST  D CHECK("ACT") Q
 ;
EXP(OCXDATE,OCXORD) Q:'$$RTEST  D CHECK("EXP") Q
 ;
CHECK(OCXMODE) ;
 ;
 S OCXDATA("MODE")=OCXMODE
 Q
 ;
RTEST() ;
 N DATE,TMOUT
 Q:'$L($T(^OCXOZ01)) 1
 I '($P($G(^OCXD(861,1,0)),U,1)="SITE PREFERENCES") K ^OCXD(861,1) S ^OCXD(861,1,0)="SITE PREFERENCES"
 S DATE=$P($G(^OCXD(861,1,0)),U,3)
 I DATE,((+DATE)=(+$H)),(((+$P($H,",",2))-(+$P(DATE,",",2)))<1800) Q 1
 Q 0
 ;