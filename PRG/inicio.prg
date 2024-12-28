
* Fichero....: Inicio.prg
* Versión....: 1.0
* Autor......: Pedro Amaro
* Fecha......: 02/02/2007 19:42:58
* Derechos...: Copyright (c) 1997
* Compilador.: Visual FoxPro 9 para Windows
* Notas......: Programa de inicio de la aplicación
* Cambios....:
*********************************************************
CLEAR
*********************************************************
* Mostrar logo del organismo con que se está trabajando
_SCREEN.VISIBLE = .F.
_SCREEN.ADDOBJECT("oImg", "image")
_SCREEN.oImg.STRETCH = 2
*_screen.oImg.width = SYSMETRIC(1)
*_screen.oImg.height = SYSMETRIC(2)
_SCREEN.oImg.WIDTH = 181
_SCREEN.oImg.HEIGHT = 45
*_screen.oImg.left = SYSMETRIC(1)/2
*_screen.oImg.top = SYSMETRIC(2) /2
_SCREEN.oImg.LEFT = INT(_SCREEN.WIDTH  - _SCREEN.oImg.WIDTH)
_SCREEN.oImg.TOP = INT(_SCREEN.HEIGHT - _SCREEN.oImg.HEIGHT)
_SCREEN.oImg.VISIBLE = .F.

*Mostrar la version del sistema
*!*	_SCREEN.ADDOBJECT("LBLVERSION","LABEL")
*!*	_SCREEN.lblversion.CAPTION="Versión 002.0013.03.18"
*!*	_SCREEN.lblversion.AUTOSIZE = .T.
*!*	_SCREEN.lblversion.TOP= 5
*!*	_SCREEN.lblversion.LEFT= _SCREEN.left - 10
*!*	*_SCREEN.lblversion.LEFT=800
*!*	_SCREEN.lblversion.FONTBOLD = .T.
*!*	_SCREEN.lblversion.FORECOLOR =RGB(0,0,255)
*!*	_SCREEN.lblversion.BACKSTYLE = 0
*!*	_SCREEN.lblversion.VISIBLE = .T.

*_SCREEN.VISIBLE = .T.
SET TALK OFF
_SCREEN.WINDOWSTATE = 2
_SCREEN.CLOSABLE = .F.
*hide wind ("Standard")
* Define el acceso a las librerias de clases
* ATENCION: SOLO PARA INICIAR LA APLICACION
* La clase ENTORNO modifica el entorno
********************************************
SET CLASSLIB TO D:\PSTWIN\VCX\APP

* Define el objeto público oAplicacion
**************************************
PUBLIC oAplicacion
oAplicacion = CREATEOBJECT("cusAplica","PST.DBC","INICIO.MPR","SICAPRO WIN","TbrMenuInicio","FRMINTRO","TbrLogo")


* Ejecuta la aplicación
***********************
IF TYPE('oAplicacion') == [O]
	oAplicacion.Ejecuta()
ENDIF
ON SHUTDOWN

* Elimina el objeto aplicación de la memoria
********************************************
RELEASE oAplicacion

* Elimina bibliotecas de clases de memoria
* y todas las variables
******************************************
SET CLASSLIB TO
CLEAR ALL



