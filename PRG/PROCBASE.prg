
**__RI_HEADER!@ Do NOT REMOVE or MODIFY this line!!!! @!__RI_HEADER**
procedure RIDELETE
local llRetVal
llRetVal=.t.
 IF (ISRLOCKED() and !deleted()) OR !RLOCK()
    llRetVal=.F.
  ELSE
    IF !deleted()
      DELETE
      IF CURSORGETPROP('BUFFERING') > 1
      	=TABLEUPDATE()
      ENDIF
    ENDIF not already deleted
  ENDIF
  UNLOCK RECORD (RECNO())
  llRetVal=pnerror=0
RETURN llRetVal

procedure RIUPDATE
lparameters tcFieldName,tcNewValue,tcCascadeParent
local llRetVal
llRetVal=.t.
 IF ISRLOCKED() OR !RLOCK()
    llRetVal=.F.
  ELSE
    IF EVAL(tcFieldName)<>tcNewValue
      PRIVATE pcCascadeParent
      pcCascadeParent=upper(iif(type("tcCascadeParent")<>"C","",tcCascadeParent))
      REPLACE (tcFieldName) WITH tcNewValue
      IF CURSORGETPROP('BUFFERING') > 1
      	=TABLEUPDATE()
      ENDIF
    ENDIF values don't already match
  ENDIF it's locked already, or I was able to lock it
  UNLOCK RECORD (RECNO())
  llRetVal=pnerror=0
return llRetVal

procedure rierror
parameters tnErrNo,tcMessage,tcCode,tcProgram
local lnErrorRows,lnXX
lnErrorRows=alen(gaErrors,1)
if type('gaErrors[lnErrorRows,1]')<>"L"
  dimension gaErrors[lnErrorRows+1,alen(gaErrors,2)]
  lnErrorRows=lnErrorRows+1
endif
gaErrors[lnErrorRows,1]=tnErrNo
gaErrors[lnErrorRows,2]=tcMessage
gaErrors[lnErrorRows,3]=tcCode
gaErrors[lnErrorRows,4]=""
lnXX=1
do while !empty(program(lnXX))
  gaErrors[lnErrorRows,4]=gaErrors[lnErrorRows,4]+","+;
  program(lnXX)
  lnXX=lnXX+1
enddo
gaErrors[lnErrorRows,5]=pcParentDBF
gaErrors[lnErrorRows,6]=pnParentRec
gaErrors[lnErrorRows,7]=pcParentID
gaErrors[lnErrorRows,8]=pcParentExpr
gaErrors[lnErrorRows,9]=pcChildDBF
gaErrors[lnErrorRows,10]=pnChildRec
gaErrors[lnErrorRows,11]=pcChildID
gaErrors[lnErrorRows,12]=pcChildExpr
return tnErrNo


PROCEDURE riopen
PARAMETERS tcTable,tcOrder

LOCAL lcCurWkArea,lcNewWkArea,lnInUseSpot,lnOccurs,lnOccurance
lnInUseSpot=0
lnOccurs = OCCURS(UPPER(tcTable)+"*",UPPER(pcRIcursors))
FOR lnOccurance = 1 TO lnOccurs
	lnInUseSpot=ATC(tcTable+"*",pcRIcursors,lnOccurance)
	IF ISDIGIT(SUBSTR(pcRIcursors,lnInUseSpot-1,1)) OR;
		 EMPTY(SUBSTR(pcRIcursors,lnInUseSpot-1,1))
		EXIT
	ENDIF
	lnInUseSpot=0
ENDFOR

IF lnInUseSpot=0
  lcCurWkArea=select()
  SELECT 0
  lcNewWkArea=select()
  IF NOT EMPTY(tcOrder)
    USE (tcTable) AGAIN ORDER (tcOrder) ;
      ALIAS ("__ri"+LTRIM(STR(SELECT()))) share
  ELSE
    USE (tcTable) AGAIN ALIAS ("__ri"+LTRIM(STR(SELECT()))) share
  ENDIF
  if pnerror=0
    pcRIcursors=pcRIcursors+upper(tcTable)+"?"+STR(SELECT(),5)
  else
    lcNewWkArea=0
  endif something bad happened while attempting to open the file
ELSE
  lcNewWkArea=val(substr(pcRIcursors,lnInUseSpot+len(tcTable)+1,5))
  pcRIcursors = strtran(pcRIcursors,upper(tcTable)+"*"+str(lcNewWkArea,5),;
    upper(tcTable)+"?"+str(lcNewWkArea,5))
  IF NOT EMPTY(tcOrder)
    SET ORDER TO (tcOrder) IN (lcNewWkArea)
  ENDIF sent an order
  if pnerror<>0
    lcNewWkArea=0
  endif something bad happened while setting order
ENDIF
RETURN (lcNewWkArea)


PROCEDURE riend
PARAMETERS tlSuccess
local lnXX,lnSpot,lcWorkArea
IF tlSuccess
  END TRANSACTION
ELSE
  SET DELETED OFF
  ROLLBACK
  SET DELETED ON
ENDIF
IF EMPTY(pcRIolderror)
  ON ERROR
ELSE
  ON ERROR &pcRIolderror.
ENDIF
FOR lnXX=1 TO occurs("*",pcRIcursors)
  lnSpot=atc("*",pcRIcursors,lnXX)+1
  USE IN (VAL(substr(pcRIcursors,lnSpot,5)))
ENDFOR
IF pcOldCompat = "ON"
	SET COMPATIBLE ON
ENDIF
IF pcOldDele="OFF"
  SET DELETED OFF
ENDIF
IF pcOldExact="ON"
  SET EXACT ON
ENDIF
IF pcOldTalk="ON"
  SET TALK ON
ENDIF
do case
  case empty(pcOldDBC)
    set data to
  case pcOldDBC<>DBC()
    set data to (pcOldDBC)
endcase
RETURN .T.


PROCEDURE rireuse
* rireuse.prg
PARAMETERS tcTableName,tcWkArea
pcRIcursors = strtran(pcRIcursors,upper(tcTableName)+"?"+str(tcWkArea,5),;
  upper(tcTableName)+"*"+str(tcWkArea,5))
RETURN .t.

********************************************************************************
procedure __RI_UPDATE_contbase
** "Referential integrity update trigger for" contbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF	  
ENDIF first trigger
LOCAL lcParentID && parent's value to be sought in child
LOCAL lcOldParentID && previous parent id value
LOCAL lcChildWkArea && child work area handle returned by riopen
LOCAL lcChildID && child's value to be sought in parent
LOCAL lcOldChildID && old child id value
LOCAL lcParentWkArea && parentwork area handle returned by riopen
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcChildWkArea=select()
IF _triggerlevel=1 or type("pccascadeparent")#"C" or (NOT pccascadeparent=="EMPL"+cSufijo)
  SELECT (lcChildWkArea)
  lcChildID=CEDULA
  lcOldChildID=oldval("CEDULA")
  pcChildDBF=dbf(lcChildWkArea)
  pnChildRec=recno(lcChildWkArea)
  pcChildID=lcOldChildID
  pcChildExpr="CEDULA"
  if isnull(lcChildID) or isnull(lcOldChildID) or lcChildID <> lcOldChildID
    lcParentWkArea=riopen("empl"+cSufijo,"empl"+cSufijo)
    IF lcParentWkArea<=0
      IF _triggerlevel=1
        DO riend WITH .F.
      ENDIF at the end of the highest trigger level
      SELECT (lcStartArea)
      RETURN .F.
    ENDIF not able to open the child work area
    pcParentDBF=dbf(lcParentWkArea)
    llRetVal=SEEK(lcChildID,lcParentWkArea)
    pnParentRec=recno(lcParentWkArea)
    if llRetVal and not (isrlocked(pnParentRec, lcParentWkArea) or ;
      isflocked(lcParentWkArea))
      if rlock(lcParentWkArea)
        unlock record pnParentRec in lcParentWkArea
      else
        =rireuse("tparen",lcParentWkArea)
        pnError = rierror(-1,"Insert restrict rule violated.","","")
        IF _triggerlevel=1
          DO riend WITH llRetVal
        ENDIF at the end of the highest trigger level
        SELECT (lcStartArea)
        RETURN llRetVal
      endif
    endif
    =rireuse("empl"+cSufijo,lcParentWkArea)
    IF NOT llRetVal
      pnError = rierror(-1,"Insert restrict rule violated.","","")
      IF _triggerlevel=1
        DO riend WITH llRetVal
      ENDIF at the end of the highest trigger level
      SELECT (lcStartArea)
      RETURN llRetVal
    ENDIF no parent
  ENDIF this value was changed
ENDIF not part of a cascade from "empl"+cSufijo
lcParentWkArea=lcChildWkArea
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity Update trigger for" contbase
********************************************************************************

********************************************************************************
** "Referential integrity insert trigger for" contbase
PROCEDURE __RI_INSERT_contbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
  *SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcChildID && child's value to be sought in parent
LOCAL lcParentWkArea && parentwork area handle returned by riopen
LOCAL lcChildWkArea && child's work area
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcChildWkArea=SELECT()
SELECT (lcChildWkArea)
lcChildID=CEDULA
pcChildDBF=dbf(lcChildWkArea)
pnChildRec=recno(lcChildWkArea)
pcChildID=lcChildID
pcChildExpr="CEDULA"
lcParentWkArea=riopen("empl"+cSufijo,"empl"+cSufijo)
IF lcParentWkArea<=0
  IF _triggerlevel=1
    DO riend WITH .F.
  ENDIF at the end of the highest trigger level
  SELECT (lcStartArea)
  RETURN .F.
ENDIF not able to open the child work area
pcParentDBF=dbf(lcParentWkArea)
llRetVal=SEEK(lcChildID,lcParentWkArea)
pnParentRec=recno(lcParentWkArea)
if llRetVal and not (isrlocked(pnParentRec, lcParentWkArea) or ;
  isflocked(lcParentWkArea))
  if rlock(lcParentWkArea)
    unlock record pnParentRec in lcParentWkArea
  else
    =rireuse("tparen",lcParentWkArea)
    pnError = rierror(-1,"Insert restrict rule violated.","","")
    IF _triggerlevel=1
      DO riend WITH llRetVal
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN llRetVal
  endif
endif
=rireuse("empl"+cSufijo,lcParentWkArea)
IF NOT llRetVal
  pnError = rierror(-1,"Insert restrict rule violated.","","")
  IF _triggerlevel=1
    DO riend WITH llRetVal
  ENDIF at the end of the highest trigger level
  SELECT (lcStartArea)
  RETURN llRetVal
ENDIF
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity insert trigger for" contbase
********************************************************************************

********************************************************************************
** "Referential integrity delete trigger for" emplbase
PROCEDURE __RI_DELETE_emplbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
 * SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcParentID && parent's value to be sought in child
LOCAL lcChildWkArea && child work area handle returned by riopen
LOCAL lcParentWkArea
LOCAL llDelHeaderarea
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcParentWkArea=select()
SELECT (lcParentWkArea)
pcParentDBF=dbf()
pnParentRec=recno()
STORE CEDULA TO lcParentID,pcParentID
pcParentExpr="CEDULA"
lcChildWkArea=riopen("cont"+cSufijo,"conc"+cSufijo)
IF lcChildWkArea<=0
  IF _triggerlevel=1
    DO riend WITH .F.
  ENDIF at the end of the highest trigger level
  RETURN .F.
ENDIF not able to open the child work area
pcChildDBF=dbf(lcChildWkArea)
llRetVal=!SEEK(lcParentID,lcChildWkArea)
SELECT (lcChildWkArea)
pnChildRec=recno()
pcChildID=CEDULA
pcChildExpr="CEDULA"
IF !llRetVal
  pnError = rierror(-1,"Delete restrict rule violated.","","")
ENDIF
=rireuse("cont"+cSufijo,lcChildWkArea)
IF NOT llRetVal
  IF _triggerlevel=1
    DO riend WITH llRetVal
  ENDIF at the end of the highest trigger level
  SELECT (lcStartArea)
  RETURN llRetVal
ENDIF
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity Delete trigger for" emplbase
********************************************************************************

********************************************************************************
procedure __RI_UPDATE_emplbase
** "Referential integrity update trigger for" emplbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
 * SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcParentID && parent's value to be sought in child
LOCAL lcOldParentID && previous parent id value
LOCAL lcChildWkArea && child work area handle returned by riopen
LOCAL lcChildID && child's value to be sought in parent
LOCAL lcOldChildID && old child id value
LOCAL lcParentWkArea && parentwork area handle returned by riopen
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcChildWkArea=select()
IF _triggerlevel=1 or type("pccascadeparent")#"C" or (NOT pccascadeparent=="SERV"+cSufijo)
  SELECT (lcChildWkArea)
  lcChildID=UBI_SERVIC
  lcOldChildID=oldval("UBI_SERVIC")
  pcChildDBF=dbf(lcChildWkArea)
  pnChildRec=recno(lcChildWkArea)
  pcChildID=lcOldChildID
  pcChildExpr="UBI_SERVIC"
  if isnull(lcChildID) or isnull(lcOldChildID) or lcChildID <> lcOldChildID
    lcParentWkArea=riopen("serv"+cSufijo,"cod_servic")
    IF lcParentWkArea<=0
      IF _triggerlevel=1
        DO riend WITH .F.
      ENDIF at the end of the highest trigger level
      SELECT (lcStartArea)
      RETURN .F.
    ENDIF not able to open the child work area
    pcParentDBF=dbf(lcParentWkArea)
    llRetVal=SEEK(lcChildID,lcParentWkArea)
    pnParentRec=recno(lcParentWkArea)
    if llRetVal and not (isrlocked(pnParentRec, lcParentWkArea) or ;
      isflocked(lcParentWkArea))
      if rlock(lcParentWkArea)
        unlock record pnParentRec in lcParentWkArea
      else
        =rireuse("tparen",lcParentWkArea)
        pnError = rierror(-1,"Insert restrict rule violated.","","")
        IF _triggerlevel=1
          DO riend WITH llRetVal
        ENDIF at the end of the highest trigger level
        SELECT (lcStartArea)
        RETURN llRetVal
      endif
    endif
    =rireuse("serv"+cSufijo,lcParentWkArea)
    IF NOT llRetVal
      pnError = rierror(-1,"Insert restrict rule violated.","","")
      IF _triggerlevel=1
        DO riend WITH llRetVal
      ENDIF at the end of the highest trigger level
      SELECT (lcStartArea)
      RETURN llRetVal
    ENDIF no parent
  ENDIF this value was changed
ENDIF not part of a cascade from "serv"+cSufijo
lcParentWkArea=lcChildWkArea
SELECT (lcParentWkArea)
pcParentDBF=dbf()
pnParentRec=recno()
lcOldParentID=OLDVAL("CEDULA")
pcParentID=lcOldParentID
pcParentExpr="CEDULA"
lcParentID=CEDULA
IF lcParentID<>lcOldParentID
  lcChildWkArea=riopen("cont"+cSufijo)
  IF lcChildWkArea<=0
    IF _triggerlevel=1
      DO riend WITH .F.
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN .F.
  ENDIF not able to open the child work area
  pcChildDBF=dbf(lcChildWkArea)
  SELECT (lcChildWkArea)
  SCAN FOR CEDULA=lcOldParentID
    pnChildRec=recno()
    pcChildID=CEDULA
    pcChildExpr="CEDULA"
    IF NOT llRetVal
      EXIT
    ENDIF && not llretval
    llRetVal=riupdate("CEDULA",lcParentID,"EMPL"+cSufijo)
  ENDSCAN get all of the contbase records
  =rireuse("cont"+cSufijo,lcChildWkArea)
  IF NOT llRetVal
    IF _triggerlevel=1
      DO riend WITH llRetVal
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN llRetVal
  ENDIF
ENDIF this parent id changed
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity Update trigger for" emplbase
********************************************************************************

********************************************************************************
** "Referential integrity insert trigger for" emplbase
PROCEDURE __RI_INSERT_emplbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
  *SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcChildID && child's value to be sought in parent
LOCAL lcParentWkArea && parentwork area handle returned by riopen
LOCAL lcChildWkArea && child's work area
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcChildWkArea=SELECT()
SELECT (lcChildWkArea)
lcChildID=UBI_SERVIC
pcChildDBF=dbf(lcChildWkArea)
pnChildRec=recno(lcChildWkArea)
pcChildID=lcChildID
pcChildExpr="UBI_SERVIC"
lcParentWkArea=riopen("serv"+cSufijo,"cod_servic")
IF lcParentWkArea<=0
  IF _triggerlevel=1
    DO riend WITH .F.
  ENDIF at the end of the highest trigger level
  SELECT (lcStartArea)
  RETURN .F.
ENDIF not able to open the child work area
pcParentDBF=dbf(lcParentWkArea)
llRetVal=SEEK(lcChildID,lcParentWkArea)
pnParentRec=recno(lcParentWkArea)
if llRetVal and not (isrlocked(pnParentRec, lcParentWkArea) or ;
  isflocked(lcParentWkArea))
  if rlock(lcParentWkArea)
    unlock record pnParentRec in lcParentWkArea
  else
    =rireuse("tparen",lcParentWkArea)
    pnError = rierror(-1,"Insert restrict rule violated.","","")
    IF _triggerlevel=1
      DO riend WITH llRetVal
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN llRetVal
  endif
endif
=rireuse("serv"+cSufijo,lcParentWkArea)
IF NOT llRetVal
  pnError = rierror(-1,"Insert restrict rule violated.","","")
  IF _triggerlevel=1
    DO riend WITH llRetVal
  ENDIF at the end of the highest trigger level
  SELECT (lcStartArea)
  RETURN llRetVal
ENDIF
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity insert trigger for" emplbase
********************************************************************************

********************************************************************************
** "Referential integrity delete trigger for" inclbase
PROCEDURE __RI_DELETE_inclbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
  *SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcParentID && parent's value to be sought in child
LOCAL lcChildWkArea && child work area handle returned by riopen
LOCAL lcParentWkArea
LOCAL llDelHeaderarea
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcParentWkArea=select()
SELECT (lcParentWkArea)
pcParentDBF=dbf()
pnParentRec=recno()
STORE RELAINCLUS TO lcParentID,pcParentID
pcParentExpr="RELAINCLUS"
lcChildWkArea=riopen("cont"+cSufijo,"contrela")
IF lcChildWkArea<=0
  IF _triggerlevel=1
    DO riend WITH .F.
  ENDIF at the end of the highest trigger level
  RETURN .F.
ENDIF not able to open the child work area
pcChildDBF=dbf(lcChildWkArea)
SELECT (lcChildWkArea)
SEEK lcParentID
SCAN WHILE RELAINCLUS=lcParentID AND llRetVal
  pnChildRec=recno()
  pcChildID=RELAINCLUS
  pcChildExpr="RELAINCLUS"
  llRetVal=ridelete()
ENDSCAN get all of the contbase records
=rireuse("cont"+cSufijo,lcChildWkArea)
IF NOT llRetVal
  IF _triggerlevel=1
    DO riend WITH llRetVal
  ENDIF at the end of the highest trigger level
  SELECT (lcStartArea)
  RETURN llRetVal
ENDIF
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity Delete trigger for" inclbase
********************************************************************************

********************************************************************************
procedure __RI_UPDATE_inclbase
** "Referential integrity update trigger for" inclbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
  *SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcParentID && parent's value to be sought in child
LOCAL lcOldParentID && previous parent id value
LOCAL lcChildWkArea && child work area handle returned by riopen
LOCAL lcChildID && child's value to be sought in parent
LOCAL lcOldChildID && old child id value
LOCAL lcParentWkArea && parentwork area handle returned by riopen
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcParentWkArea=select()
SELECT (lcParentWkArea)
pcParentDBF=dbf()
pnParentRec=recno()
lcOldParentID=OLDVAL("RELAINCLUS")
pcParentID=lcOldParentID
pcParentExpr="RELAINCLUS"
lcParentID=RELAINCLUS
IF lcParentID<>lcOldParentID
  lcChildWkArea=riopen("cont"+cSufijo)
  IF lcChildWkArea<=0
    IF _triggerlevel=1
      DO riend WITH .F.
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN .F.
  ENDIF not able to open the child work area
  pcChildDBF=dbf(lcChildWkArea)
  SELECT (lcChildWkArea)
  SCAN FOR RELAINCLUS=lcOldParentID
    pnChildRec=recno()
    pcChildID=RELAINCLUS
    pcChildExpr="RELAINCLUS"
    IF NOT llRetVal
      EXIT
    ENDIF && not llretval
    llRetVal=riupdate("RELAINCLUS",lcParentID,"INCL"+cSufijo)
  ENDSCAN get all of the contbase records
  =rireuse("cont"+cSufijo,lcChildWkArea)
  IF NOT llRetVal
    IF _triggerlevel=1
      DO riend WITH llRetVal
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN llRetVal
  ENDIF
ENDIF this parent id changed
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity Update trigger for" inclbase
********************************************************************************

********************************************************************************
** "Referential integrity delete trigger for" servbase
PROCEDURE __RI_DELETE_servbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
  *SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcParentID && parent's value to be sought in child
LOCAL lcChildWkArea && child work area handle returned by riopen
LOCAL lcParentWkArea
LOCAL llDelHeaderarea
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcParentWkArea=select()
SELECT (lcParentWkArea)
pcParentDBF=dbf()
pnParentRec=recno()
STORE COD_SERVIC TO lcParentID,pcParentID
pcParentExpr="COD_SERVIC"
lcChildWkArea=riopen("empl"+cSufijo,"emplserv")
IF lcChildWkArea<=0
  IF _triggerlevel=1
    DO riend WITH .F.
  ENDIF at the end of the highest trigger level
  RETURN .F.
ENDIF not able to open the child work area
pcChildDBF=dbf(lcChildWkArea)
llRetVal=!SEEK(lcParentID,lcChildWkArea)
SELECT (lcChildWkArea)
pnChildRec=recno()
pcChildID=UBI_SERVIC
pcChildExpr="UBI_SERVIC"
IF !llRetVal
  pnError = rierror(-1,"Delete restrict rule violated.","","")
ENDIF
=rireuse("empl"+cSufijo,lcChildWkArea)
IF NOT llRetVal
  IF _triggerlevel=1
    DO riend WITH llRetVal
  ENDIF at the end of the highest trigger level
  SELECT (lcStartArea)
  RETURN llRetVal
ENDIF
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity Delete trigger for" servbase
********************************************************************************

********************************************************************************
procedure __RI_UPDATE_servbase
** "Referential integrity update trigger for" servbase
LOCAL llRetVal, cSufijo as Character
llRetVal = .t.
IF TYPE("oAplicacion") = "O" AND !EMPTY(oAplicacion.cSufijo)
	cSufijo = ALLTRIM(oAplicacion.cSufijo)
ELSE
	cSufijo = "BASE"
ENDIF
PRIVATE pcParentDBF,pnParentRec,pcChildDBF,pnChildRec,pcParentID,pcChildID
PRIVATE pcParentExpr,pcChildExpr
STORE "" TO pcParentDBF,pcChildDBF,pcParentID,pcChildID,pcParentExpr,pcChildExpr
STORE 0 TO pnParentRec,pnChildRec
IF _triggerlevel=1
  BEGIN TRANSACTION
  PRIVATE pcRIcursors,pcRIwkareas,pcRIolderror,pnerror,;
  pcOldDele,pcOldExact,pcOldTalk,pcOldCompat,PcOldDBC
  pcOldTalk=SET("TALK")
  SET TALK OFF
  pcOldDele=SET("DELETED")
  pcOldExact=SET("EXACT")
  pcOldCompat=SET("COMPATIBLE")
  SET COMPATIBLE OFF
  SET DELETED ON
  SET EXACT OFF
  pcRIcursors=""
  pcRIwkareas=""
  pcRIolderror=ON("error")
  pnerror=0
  ON ERROR pnerror=rierror(ERROR(),message(),message(1),program())
  IF TYPE('gaErrors(1)')<>"U"
    release gaErrors
  ENDIF
  PUBLIC gaErrors(1,12)
  pcOldDBC=DBC()
  *SET DATA TO ("BASES")
  IF cSufijo =="BASE"
	  SET DATA TO ("BASES")
  ELSE
      SET DATA TO ("BASE"+cSufijo)
  ENDIF
ENDIF first trigger
LOCAL lcParentID && parent's value to be sought in child
LOCAL lcOldParentID && previous parent id value
LOCAL lcChildWkArea && child work area handle returned by riopen
LOCAL lcChildID && child's value to be sought in parent
LOCAL lcOldChildID && old child id value
LOCAL lcParentWkArea && parentwork area handle returned by riopen
LOCAL lcStartArea
lcStartArea=select()
llRetVal=.t.
lcParentWkArea=select()
SELECT (lcParentWkArea)
pcParentDBF=dbf()
pnParentRec=recno()
lcOldParentID=OLDVAL("COD_SERVIC")
pcParentID=lcOldParentID
pcParentExpr="COD_SERVIC"
lcParentID=COD_SERVIC
IF lcParentID<>lcOldParentID
  lcChildWkArea=riopen("empl"+cSufijo)
  IF lcChildWkArea<=0
    IF _triggerlevel=1
      DO riend WITH .F.
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN .F.
  ENDIF not able to open the child work area
  pcChildDBF=dbf(lcChildWkArea)
  SELECT (lcChildWkArea)
  SCAN FOR UBI_SERVIC=lcOldParentID
    pnChildRec=recno()
    pcChildID=UBI_SERVIC
    pcChildExpr="UBI_SERVIC"
    IF NOT llRetVal
      EXIT
    ENDIF && not llretval
    llRetVal=riupdate("UBI_SERVIC",lcParentID,"SERV"+cSufijo)
  ENDSCAN get all of the emplbase records
  =rireuse("empl"+cSufijo,lcChildWkArea)
  IF NOT llRetVal
    IF _triggerlevel=1
      DO riend WITH llRetVal
    ENDIF at the end of the highest trigger level
    SELECT (lcStartArea)
    RETURN llRetVal
  ENDIF
ENDIF this parent id changed
IF _triggerlevel=1
  do riend with llRetVal
ENDIF at the end of the highest trigger level
SELECT (lcStartArea)
RETURN llRetVal
** "End of Referential integrity Update trigger for" servbase
********************************************************************************
**__RI_FOOTER!@ Do NOT REMOVE or MODIFY this line!!!! @!__RI_FOOTER**
