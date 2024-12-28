********************************************************************
*** Nombre.: GetFList.prg
*** Autor.....: Andy Kramek
*** Fecha.....: 7/7/2004
*** Nota.......: Copyright (c) 2004 Tightline Computers, Inc
*** Función...: Copia la lista de los campos de la tabla actual,
*** o una especificada, en el portapapeles
********************************************************************
LPARAMETERS tcTable
LOCAL lcTable, lcAlias, lcList, lnCnt, lcField, lnSelect
*** ¿Tenemos el nombre de tabla?
lnSelect = SELECT()
IF VARTYPE(tcTable) = "C" AND NOT EMPTY( tcTable )
  lcAlias = JUSTSTEM( tcTable )
  *** Si no está en uso, la abre
  IF NOT USED( lcAlias )
    IF FILE( FORCEEXT( tcTable, 'dbf' ))
      USE (tcTable) AGAIN IN 0 ALIAS (lcALias)
    ELSE
      _CLIPTEXT = ''
      RETURN
    ENDIF
  ENDIF
  *** Y selecciona el Alias
  SELECT (lcAlias)
ELSE
  *** Utiliza cualquiera que esté abierta
  lcAlias = ALIAS()
ENDIF
*** Obtiene la lista de nombres de campos
IF NOT EMPTY( lcAlias )
  lcList = ''
  FOR lnCnt = 1 TO FCOUNT()
    lcField = LOWER( ALLTRIM( FIELD( lnCnt )))
    lcList = lcList + IIF( EMPTY( lcList ), "", ", " ) + lcField
  NEXT
  *** Agrega el nombre de alias
  _CLIPTEXT = lcList + CHR(13) + CHR(10) + "*** " + lcAlias
ENDIF
*** Restablece el área de trabajo
SELECT (lnSelect)
RETURN