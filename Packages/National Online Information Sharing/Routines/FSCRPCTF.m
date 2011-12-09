FSCRPCTF ;SLC/STAFF-NOIS RPC Text Finder ;5/18/98  14:58
 ;;1.1;NOIS;;Sep 06, 1998
 ;
TEXT(IN,OUT) ; from FSCRPX (RPCTextFinder)
 N CNT,FIELDS,LINE,METHOD,NUM,TEXT K TEXT
 S METHOD=$G(^TMP("FSCRPC",$J,"INPUT",1)),FIELDS=$G(^(2))
 Q:'$L(METHOD)  Q:'$L(FIELDS)
 S CNT=0,NUM=2 F  S NUM=$O(^TMP("FSCRPC",$J,"INPUT",NUM)) Q:NUM<1  S LINE=^(NUM) D
 .I '$L(LINE) Q
 .S CNT=CNT+1
 .S TEXT(CNT)=$$UP^XLFSTR(LINE)
 I '$O(TEXT(0)) Q
 D
 .I METHOD=1 D CURRENT(FIELDS,.TEXT) Q
 .I +METHOD=2 D LAST(FIELDS,.TEXT,+$P(METHOD,";",2)) Q
 K TEXT
 Q
 ;
CURRENT(FIELDS,TEXT) ;
 N CALL,CNT
 K ^TMP("FSC LIST",$J)
 S CNT=0,CALL=0 F  S CALL=$O(^TMP("FSC CURRENT LIST",$J,"C",CALL)) Q:CALL<1  D ROUTE(CALL,FIELDS,.TEXT,.CNT)
 K ^TMP("FSC CURRENT LIST",$J)
 M ^TMP("FSC CURRENT LIST",$J)=^TMP("FSC LIST",$J)
 K ^TMP("FSC LIST",$J)
 S CNT=0 F  S CNT=$O(^TMP("FSC CURRENT LIST",$J,CNT)) Q:CNT<1  S ^TMP("FSCRPC",$J,"OUTPUT",CNT)=^(CNT)
 Q
 ;
LAST(FIELDS,TEXT,LAST) ;
 N CALL,CNT,NUM
 K ^TMP("FSC LIST",$J)
 S NUM=0,CNT=0,CALL="A" F  S CALL=$O(^FSCD("CALL",CALL),-1) Q:CALL=""  S NUM=NUM+1 Q:NUM>LAST  D ROUTE(CALL,FIELDS,.TEXT,.CNT)
 K ^TMP("FSC CURRENT LIST",$J)
 M ^TMP("FSC CURRENT LIST",$J)=^TMP("FSC LIST",$J)
 K ^TMP("FSC LIST",$J)
 S CNT=0 F  S CNT=$O(^TMP("FSC CURRENT LIST",$J,CNT)) Q:CNT<1  S ^TMP("FSCRPC",$J,"OUTPUT",CNT)=^(CNT)
 Q
 ;
ROUTE(CALL,FIELDS,TEXT,CNT) ;
 N IEN,OK
 S OK=0
 D
 .S IEN=+$G(^FSCD("CALL USER","AUC",DUZ,CALL))
 .I IEN D  I OK Q
 ..I $P(FIELDS,U,8) D PSHORT(IEN,.TEXT,.OK) I OK Q
 ..I $P(FIELDS,U,9) D PLONG(IEN,.TEXT,.OK) I OK Q
 ..I $P(FIELDS,U,7) D PNOTE(IEN,.TEXT,.OK) I OK Q
 .I $P(FIELDS,U) D SUBJECT(CALL,.TEXT,.OK) I OK Q
 .I $P(FIELDS,U,2) D KEYWORDS(CALL,.TEXT,.OK) I OK Q
 .I $P(FIELDS,U,3) D PATCH(CALL,.TEXT,.OK) I OK Q
 .I $P(FIELDS,U,4) D DESC(CALL,.TEXT,.OK) I OK Q
 .I $P(FIELDS,U,5) D RES(CALL,.TEXT,.OK) I OK Q
 .I $P(FIELDS,U,6) D NOTES(CALL,.TEXT,.OK) I OK Q
 I 'OK Q
 S CNT=CNT+1
 S ^TMP("FSC LIST",$J,CNT)=CALL_U_$$SHORT^FSCRPXUS(CALL,DUZ)
 S ^TMP("FSC LIST",$J,"C",CALL)=CNT
 Q
 ;
SUBJECT(CALL,TEXT,OK) ;
 N NUM,SUBJECT
 S SUBJECT=$G(^FSCD("CALL",CALL,1))
 I '$L(SUBJECT) Q
 S SUBJECT=$$UP^XLFSTR(SUBJECT)
 S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I SUBJECT[TEXT(NUM) S OK=1 Q
 Q
 ;
KEYWORDS(CALL,TEXT,OK) ;
 N KEYWORDS,NUM
 S KEYWORDS=$G(^FSCD("CALL",CALL,1.5))
 I '$L(KEYWORDS) Q
 S KEYWORDS=$$UP^XLFSTR(KEYWORDS)
 S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I KEYWORDS[TEXT(NUM) S OK=1 Q
 Q
 ;
PATCH(CALL,TEXT,OK) ;
 N NUM,PATCH
 S PATCH=$P($G(^FSCD("CALL",CALL,120)),U,14)
 I '$L(PATCH) Q
 S PATCH=$$UP^XLFSTR(PATCH)
 S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I PATCH[TEXT(NUM) S OK=1 Q
 Q
 ;
DESC(CALL,TEXT,OK) ;
 N LNUM,NUM,LINE
 S LNUM=0 F  S LNUM=$O(^FSCD("CALL",CALL,30,LNUM)) Q:LNUM<1  S LINE=$G(^(LNUM,0)) D  Q:OK
 .I '$L(LINE) Q
 .S LINE=$$UP^XLFSTR(LINE)
 .S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I LINE[TEXT(NUM) S OK=1 Q
 S LNUM=0 F  S LNUM=$O(^FSCD("CALL",CALL,30,LNUM)) Q:LNUM<1  S LINE=$G(^(LNUM,0)) D  Q:OK
 .I '$L(LINE) Q
 .S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I LINE[TEXT(NUM) S OK=1 Q
 Q
 ;
RES(CALL,TEXT,OK) ;
 N LNUM,NUM,LINE
 S LNUM=0 F  S LNUM=$O(^FSCD("CALL",CALL,80,LNUM)) Q:LNUM<1  S LINE=$G(^(LNUM,0)) D  Q:OK
 .I '$L(LINE) Q
 .S LINE=$$UP^XLFSTR(LINE)
 .S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I LINE[TEXT(NUM) S OK=1 Q
 Q
 ;
NOTES(CALL,TEXT,OK) ;
 N LNUM,NUM,LINE
 S LNUM=0 F  S LNUM=$O(^FSCD("CALL",CALL,50,LNUM)) Q:LNUM<1  S LINE=$G(^(LNUM,0)) D  Q:OK
 .I '$L(LINE) Q
 .S LINE=$$UP^XLFSTR(LINE)
 .S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I LINE[TEXT(NUM) S OK=1 Q
 Q
 ;
PSHORT(IEN,TEXT,OK) ;
 N NUM,PSHORT
 S PSHORT=$P($G(^FSCD("CALL USER",IEN,0)),U,3)
 I '$L(PSHORT) Q
 S PSHORT=$$UP^XLFSTR(PSHORT)
 S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I PSHORT[TEXT(NUM) S OK=1 Q
 Q
 ;
PLONG(IEN,TEXT,OK) ;
 N NUM,PLONG
 S PLONG=$G(^FSCD("CALL USR",IEN,1))
 I '$L(PLONG) Q
 S PLONG=$$UP^XLFSTR(PLONG)
 S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I PLONG[TEXT(NUM) S OK=1 Q
 Q
 ;
PNOTE(IEN,TEXT,OK) ;
 N LNUM,NUM,LINE
 S LNUM=0 F  S LNUM=$O(^FSCD("CALL USER",IEN,2,LNUM)) Q:LNUM<1  S LINE=$G(^(LNUM,0)) D  Q:OK
 .I '$L(LINE) Q
 .S LINE=$$UP^XLFSTR(LINE)
 .S NUM=0 F  S NUM=$O(TEXT(NUM)) Q:NUM<1  I LINE[TEXT(NUM) S OK=1 Q
 Q