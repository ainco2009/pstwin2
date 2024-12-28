**************************************************
*-- Class:        frmmsg (d:\pstwin\vcx\app.vcx)
*-- ParentClass:  frmdialogo (d:\pstwin\vcx\base.vcx)
*-- BaseClass:    form
*-- Time Stamp:   09/09/20 11:44:11 PM
*
DEFINE CLASS frmmsgcuadre AS frmdialogo


	BorderStyle = 2
	Top = 32
	Left = 321
	Height = 415
	Width = 500
	DoCreate = .T.
	Caption = "Aviso"
	ControlBox = .F.
	WindowType = 1
	Name = "frmmsgcuadre"


	ADD OBJECT shape1 AS shape WITH ;
		Top = 11, ;
		Left = 24, ;
		Height = 294, ;
		Width = 457, ;
		Curvature = 25, ;
		BackColor = RGB(255,255,202), ;
		ZOrderSet = 0, ;
		Name = "Shape1"


	ADD OBJECT label1 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "PROCESO CONCLUIDO", ;
		Height = 17, ;
		Left = 181, ;
		Top = 21, ;
		Width = 130, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 1, ;
		Name = "Label1"


	ADD OBJECT label2 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "CONTRATOS EN ARCHIVO: ", ;
		Height = 17, ;
		Left = 46, ;
		Top = 49, ;
		Width = 153, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 2, ;
		Name = "Label2"


	ADD OBJECT label3 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "(-) CONTRATOS CANCELADOS:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 74, ;
		Width = 174, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 3, ;
		Name = "Label3"


	ADD OBJECT label4 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "(-) MODALIDAD DE DESC NO SELECCIONADO.:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 101, ;
		Width = 257, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 4, ;
		Name = "Label4"


	ADD OBJECT label5 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "(-) CONTRATOS SUSPENDIDOS:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 126, ;
		Width = 178, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 5, ;
		Name = "Label5"


	ADD OBJECT label6 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "(-) CONTRATOS CON FEC VIG. POSTERIOR:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 151, ;
		Width = 239, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 6, ;
		Name = "Label6"


	ADD OBJECT label7 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "(-) CONTRATOS POR CANCELAR:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 175, ;
		Width = 185, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 7, ;
		Name = "Label7"


	ADD OBJECT label8 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "(-) SERVICIO NO SELECCIONADO:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 201, ;
		Width = 187, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 8, ;
		Name = "Label8"


	ADD OBJECT label9 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "(+) CONTRATOS CON CUOTAS DUPLICADAS:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 226, ;
		Width = 251, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 9, ;
		Name = "Label9"


	ADD OBJECT label10 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "TOTAL REGISTROS:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 254, ;
		Width = 112, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 10, ;
		Name = "Label10"


	ADD OBJECT label11 AS label WITH ;
		AutoSize = .T., ;
		FontBold = .T., ;
		BackStyle = 0, ;
		Caption = "TOTAL MONTO Bs:", ;
		Height = 17, ;
		Left = 33, ;
		Top = 278, ;
		Width = 107, ;
		ForeColor = RGB(0,0,255), ;
		ZOrderSet = 11, ;
		Name = "Label11"


	ADD OBJECT line1 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 42, ;
		Width = 457, ;
		Name = "Line1"


	ADD OBJECT line2 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 67, ;
		Width = 457, ;
		Name = "Line2"


	ADD OBJECT line3 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 93, ;
		Width = 457, ;
		Name = "Line3"


	ADD OBJECT line4 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 120, ;
		Width = 457, ;
		Name = "Line4"


	ADD OBJECT line5 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 145, ;
		Width = 457, ;
		Name = "Line5"


	ADD OBJECT line6 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 170, ;
		Width = 457, ;
		Name = "Line6"


	ADD OBJECT line7 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 195, ;
		Width = 457, ;
		Name = "Line7"


	ADD OBJECT line8 AS line WITH ;
		Height = 0, ;
		Left = 24, ;
		Top = 220, ;
		Width = 457, ;
		Name = "Line8"


	ADD OBJECT line9 AS line WITH ;
		BorderStyle = 6, ;
		BorderWidth = 2, ;
		Height = 0, ;
		Left = 24, ;
		Top = 245, ;
		Width = 457, ;
		Name = "Line9"


	ADD OBJECT line11 AS line WITH ;
		Height = 256, ;
		Left = 312, ;
		Top = 42, ;
		Width = 0, ;
		Name = "Line11"


	ADD OBJECT command1 AS commandbutton WITH ;
		Top = 368, ;
		Left = 208, ;
		Height = 27, ;
		Width = 84, ;
		Caption = "Aceptar", ;
		Name = "Command1"


	ADD OBJECT txtreg_total AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 43, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "TxtReg_Total"


	ADD OBJECT txtcont_canc AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 69, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "Txtcont_canc"


	ADD OBJECT txtcont_mod AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 96, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "txtcont_mod"


	ADD OBJECT txtcont_susp AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 121, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "txtcont_susp"


	ADD OBJECT txtcont_fec_post AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 147, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "txtcont_fec_post"


	ADD OBJECT txtcont_por_cancxt AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 172, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "txtcont_por_cancxt"


	ADD OBJECT txtcont_servic AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 197, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "txtcont_servic"


	ADD OBJECT txtcont_duplic AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 221, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "Txtcont_duplic"


	ADD OBJECT txtregistros AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		InputMask = "", ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 248, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "Txtregistros"


	ADD OBJECT txtmonto_total AS textbox WITH ;
		FontBold = .T., ;
		Alignment = 1, ;
		Height = 23, ;
		InputMask = "999,999,999,999.99", ;
		Left = 316, ;
		ReadOnly = .T., ;
		Top = 274, ;
		Width = 161, ;
		BackColor = RGB(255,255,202), ;
		Name = "txtmonto_total"


	ADD OBJECT lblmensaje AS label WITH ;
		AutoSize = .T., ;
		FontSize = 12, ;
		BackStyle = 0, ;
		Caption = "Presione Aceptar para ver el Resumen Detallado por Servicio", ;
		Height = 21, ;
		Left = 35, ;
		Top = 326, ;
		Visible = .F., ;
		Width = 430, ;
		ForeColor = RGB(255,0,0), ;
		Name = "LblMensaje"


	PROCEDURE Init
		LPARAMETERS unreg_total, uncont_canc, uncont_mod, uncont_susp, uncont_fec_post, uncont_por_canc, uncont_servic ,;
			uncont_duplic, unregistros, unmonto_total, ulMessage
		LOCAL loError, 	lcErr

		SET DECIMALS TO 2
		SET POINT TO ","
		SET SEPARATOR TO "."
		lcErr = ""
		TRY
			THIS.txtreg_Total.VALUE 		= unreg_total
			THIS.txtcont_canc.VALUE 		= uncont_canc
			THIS.txtcont_mod.VALUE  		= uncont_mod
			THIS.txtcont_susp.VALUE 		= uncont_susp
			THIS.txtcont_fec_post.VALUE 	= uncont_fec_post
			THIS.txtcont_por_cancxt.VALUE 	= uncont_por_canc
			THIS.txtcont_servic.VALUE 		= uncont_servic
			THIS.txtcont_duplic.VALUE 		= uncont_duplic
			THIS.txtregistros.VALUE 		= unregistros
			THIS.txtmonto_total.VALUE 		= unmonto_total

			THIS.lblMensaje.VISIBLE = ulMessage

		CATCH TO loError
			lcErr = "Error: " + STR(loError.ERRORNO) + CHR(13) +;
				"Linea: " + STR(loError.LINENO) + CHR(13) +;
				"Mensaje: " + loError.MESSAGE + CHR(13) +;
				"Procedimiento: "+ loError.PROCEDURE

		FINALLY


			IF !EMPTY(lcErr)
				MESSAGEBOX(lcErr, 16, "Error")

			ENDIF
		ENDTRY


		RETURN EMPTY(lcErr)
	ENDPROC


	PROCEDURE command1.Click
		thisform.Release()
	ENDPROC


ENDDEFINE
*
*-- EndDefine: frmmsgcuadre
**************************************************
