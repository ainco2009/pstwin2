
OPEN DATABASE d:\pstwin\datos\pst.dbc EXCLUSIVE

crea_codmvto()
SET UNIQUE OFF

crea_movtos()

CLOSE DATABASES

MESSAGEBOX("TABLAS  CREADAS",48,"AVISO")

PROCEDURE crea_codmvto()

CREATE TABLE 'd:\pstwin\datos\CODMVTOS.DBF' NAME 'CODMVTOS' (COD_MOV C(2) NOT NULL, ;
                       NOM_MOV C(40) NOT NULL, ;
                       TIPO_MOV N(1, 0) NOT NULL)

***** Create INDICES *****
ALTER TABLE 'CODMVTOS' ADD PRIMARY KEY COD_MOV TAG CODMVTOS COLLATE 'MACHINE'

ENDPROC 


PROCEDURE crea_movtos()

CREATE TABLE 'd:\pstwin\datos\MOVTOS_DED.DBF' NAME 'MOVTOS_DED' ;
					   (COD_CASA C(4) NOT NULL, ;
					   NRO_DOC  C(8) NOT NULL, ;
					   DOC_ORIG C(8) NOT NULL, ;
					   TIPO_DOC C(1) NOT NULL,;
					   F_OPER D NOT NULL, ;
                       F_PROCESO D NOT NULL, ;
                       CONCEPTO C(40) NOT NULL, ;
                       MONTO_MVTO N(12,2) NOT NULL,;
                       MONTO_APLI N(12,2) NOT NULL,;
                       CODIGO_ORG C(4),;
                       PROCESADO L NOT NULL)
                       
INDEX ON COD_CASA+DTOS(F_OPER)     TAG MOVTOS_DED COLLATE 'MACHINE'                       

ENDPROC 

