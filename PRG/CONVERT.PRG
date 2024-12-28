CLEAR

? Convertir("01-01-96","D")
? Convertir(2450205,"D")
? Convertir(.F.,"D") 
? Convertir("010101","D")

? Convertir(12321.334345,"C")
? Convertir(DATE(),"C")
? Convertir(DATETIME(),"C")
? Convertir(NTOM(34342.3235),"C")

? Convertir("S","L")
? Convertir(0,"L")
? Convertir({  /  /  },"L")

? Convertir(1234.231,"I")
? Convertir("123123.123","I")
? Convertir(DATE(),"I")
? Convertir(NTOM(123152),"I")

? Convertir(1234.231,"N")
? Convertir("123123.123","N")
? Convertir(DATE(),"N")
? Convertir(NTOM(123152),"N")

? Convertir(1234.231,"Y")
? Convertir("123123.123","Y")
? Convertir(DATE(),"Y")

? Convertir("01-01-96","T")
? Convertir(2450205,"T")
? Convertir(.F.,"T") 
? Convertir("010101","T")


? Convertir("Nulo","Z")

*-------------------------------------------------------
* Función.....: Convertir
*
* Descripción.: Convierte expresiones entre tipos de datos
*
* Devuelve....: La expresión del tipo pedido
*
* Parámetros..: uValor - Expresión orígen a convertir
*               cTipo  - Tipo válido. Puede ser:
*                        C - Carácter
*                        D - Fecha
*                        F - Flotante
*                        L - Lógico
*                        M - Memo
*                        N - Numérico
*                        I - Entero
*                        B - Doble precisión
*                        T - FechaHora
*                        Y - Monetario
*
* Notas.......: Convertimos cualquier expresión en otra
*               en base a los siguientes esquemas y
*               funciones necesarias:
*       
*  
*-------------------------------------------------------
FUNCTION Convertir(uValor,cTipo)

LOCAL cTipoDatos

* Averigua el tipo de datos de orígen
*************************************
cTipoDatos = TYPE([uValor])

DO CASE
   CASE cTipo == "C"
        **********************
        * Convertir a carácter
        **********************
        uValorRetorno = ConvertirCaracter(uValor,cTipoDatos)
   CASE cTipo == "D"
        *******************
        * Convertir a fecha
        *******************
        uValorRetorno = ConvertirFecha(uValor,cTipoDatos)
   CASE cTipo == "T"
        ***********************
        * Convertir a fechahora
        ***********************
        uValorRetorno = ConvertirFechaHora(uValor,cTipoDatos)

   CASE cTipo == "L"
        ********************
        * Convertir a lógico
        ********************
        uValorRetorno = ConvertirLogico(uValor,cTipoDatos)
   CASE cTipo == "I"
        ********************
        * Convertir a entero
        ********************
        uValorRetorno = ConvertirEntero(uValor,cTipoDatos)
   CASE INLIST(cTipo, "F", "N", "B")
        ********************
        * Convertir a número
        ********************
        uValorRetorno = ConvertirNumérico(uVAlor,cTipoDatos)
   CASE cTipo == "Y"
        ***********************
        * Convertir a monetario
        ***********************
        uValorRetorno = ConvertirMonetario(uValor,cTipoDatos)     
   OTHERWISE
        RETURN .NULL.
ENDCASE

	RETURN uValorRetorno
ENDFUNC && [Convertir]


*-------------------------------------------------------
* Función.....: ConvertirFecha
*
* Descripción.: Convierte cualquier tipo de datos en
*               una fecha
*
* Devuelve....:
*
* Parámetros..: uValor - Expresión a convertir
*               cTipoDatos - Tipo de datos orígen
*
* Notas.......:
*-------------------------------------------------------
FUNCTION ConvertirFecha(uValor,cTipoDatos)

LOCAL cErrorAnterior,lError,dValor

* Guarda la rutina de errores anterior
**************************************
cErrorAnterior = ON([ERROR])

ON ERROR lError = .T.
lError = .F.
DO CASE
   CASE INLIST(cTipoDatos, "C", "M")
        dValor = CTOD(uValor)
   CASE INLIST(cTipoDatos, "F", "I", "N", "B", "Y")
        dValor = CTOD(SYS(10,uValor))
   CASE cTipoDatos == "L"
        * No existe conversión posible
        ******************************
        dValor = {  /  /  }
   CASE cTipoDatos == "T"        
        dValor = TTOD(uValor)
   CASE cTipoDatos == "D"
        dValor = uValor     
   OTHERWISE
        dValor = uValor
ENDCASE


IF lError
   dValor = {  /  /  }
ENDIF

* Recupera el gestor de errores anterior
****************************************
ON ERROR &cErrorAnterior

	RETURN dValor
ENDFUNC && [ConvertirFecha]


*-------------------------------------------------------
* Función.....: ConvertirCaracter
*
* Descripción.: Convierte cualquier tipo de datos en
*               una cadena de caracteres
*
* Devuelve....:
*
* Parámetros..: uValor - Expresión a convertir
*               cTipoDatos - Tipo de datos orígen
*
* Notas.......:
*-------------------------------------------------------
FUNCTION ConvertirCaracter(uValor,cTipoDatos)

LOCAL cErrorAnterior,lError, nManejador, cLinea, ;
      nPosIni, nPosFin, nLongitud, cValor

* Guarda la rutina de errores anterior
**************************************
cErrorAnterior = ON([ERROR])

ON ERROR lError = .T.
lError = .F.
DO CASE
   CASE INLIST(cTipoDatos, "C", "M")
        cValor = uValor
   CASE INLIST(cTipoDatos, "F", "I", "N", "B")
        * Crea un fichero de texto para 
        * acceder a la variable y
        * salvar la totalidad de 
        * posiciones decimales
        *******************************
        LIST MEMORY LIKE uValor TO MEMO.TXT NOCONSOLE
        
        * Abre el fichero de texto
        * a bajo nivel
        **************************
        nManejador = FOPEN([MEMO.TXT])
        
        * Recorre el fichero en busca
        * de la definición de variable
        ******************************
        DO WHILE ! FEOF(nManejador)
           cLinea = FGETS(nManejador)
           IF "("  $  cLinea
              nPosIni     = AT("(",cLinea)
              nPosFin     = AT(")",cLinea)
              nLongitud   = nPosFin - 1 - nPosIni
              cValor      = SUBSTR(cLinea,nPosIni+1,nLongitud)
           ENDIF
        ENDDO && ! FEOF(nManejador)
        
        * Cierra el fichero
        *******************
        =FCLOSE(nManejador)
    
   CASE cTipoDatos == "Y"
        cValor = ALLTRIM(STR(uValor,20,4))

   CASE cTipoDatos == "L"
        cValor = IIF(uValor,"S","N")
        
   CASE cTipoDatos == "T"        
        cValor = TTOC(uValor)
   OTHERWISE
        cValor = uValor
ENDCASE


IF lError
   cValor = ""
ENDIF

* Recupera el gestor de errores anterior
****************************************
ON ERROR &cErrorAnterior

	RETURN cValor

ENDFUNC && [ConvertirCaracter]



*-------------------------------------------------------
* Función.....: ConvertirLogico
*
* Descripción.: Convierte cualquier tipo de datos en
*               una expresión lógica
*
* Devuelve....:
*
* Parámetros..: uValor - Expresión a convertir
*               cTipoDatos - Tipo de datos orígen
*
* Notas.......:
*-------------------------------------------------------
FUNCTION ConvertirLogico(uValor,cTipoDatos)

LOCAL cErrorAnterior,lError,lValor

* Guarda la rutina de errores anterior
**************************************
cErrorAnterior = ON([ERROR])

ON ERROR lError = .T.
lError = .F.
DO CASE
   CASE INLIST(cTipoDatos, "C", "M")
        * En este caso se presupone
        * que el valor introducido
        * en la cadena que se desea
        * convertir a lógico es S ó N
        *****************************
        cCadena = UPPER(ALLTRIM(uValor))
        DO CASE
           CASE cCadena == "S"
                lValor = .T.
           CASE cCadena == "N"
                lValor = .F.
           OTHERWISE
                lValor = .F.
        ENDCASE

   CASE INLIST(cTipoDatos, "F", "I", "N", "B", "Y")
        * En este caso se presupone 
        * que el valor introducido
        * en la expresión numérica
        * que se se desea convertir
        * es 0 para .F. (FALSO)
        * y  1 para .T. (VERDADERO)
        ***************************
        uValor = INT(uValor)
        DO CASE
           CASE uValor = 1
                lValor = .T.
           CASE uValor = 0
                lValor = .F.
           OTHERWISE
                lValor = .F.
        ENDCASE
              
   CASE INLIST(cTipoDatos,"D","T")
        * En este caso únicamente
        * se comprueba que la 
        * expresión no esté vacía
        * En caso de estar vacía
        * devuelve .F. (FALSO) y 
        * en caso de contener 
        * algun valor, devuelve
        * .T. (VERDADERO)
        lValor = IIF(EMPTY(uValor),.F.,.T.)
   OTHERWISE
        lValor = uValor
ENDCASE


IF lError
   lValor = .F.
ENDIF

* Recupera el gestor de errores anterior
****************************************
ON ERROR &cErrorAnterior

	RETURN lValor

ENDFUNC && [ConvertirLogico]




*-------------------------------------------------------
* Función.....: ConvertirEntero
*
* Descripción.: Convierte cualquier tipo de datos en
*               un entero
*
* Devuelve....:
*
* Parámetros..: uValor - Expresión a convertir
*               cTipoDatos - Tipo de datos orígen
*
* Notas.......:
*-------------------------------------------------------
FUNCTION ConvertirEntero(uValor,cTipoDatos)

LOCAL cErrorAnterior,lError,nValor

* Guarda la rutina de errores anterior
**************************************
cErrorAnterior = ON([ERROR])

ON ERROR lError = .T.
lError = .F.
DO CASE
   CASE INLIST(cTipoDatos, "C", "M")
        nValor = INT(VAL(uValor))
   CASE INLIST(cTipoDatos, "F", "I", "N", "B")
        nValor = INT(uValor)              
   CASE cTipoDatos = "Y"
        nValor = INT(MTON(uVAlor))     
   CASE INLIST(cTipoDatos,"D","T")
        * Este caso devuelve el número
        * de día juliano
        ******************************
        nValor = VAL(SYS(11,uValor)) 
   CASE cTipoDAtos == "L"
        nValor = IIF(uValor,1,0)     
   OTHERWISE
        nValor = uValor
ENDCASE


IF lError
   nValor = 0
ENDIF

* Recupera el gestor de errores anterior
****************************************
ON ERROR &cErrorAnterior

	RETURN nValor

ENDFUNC && [ConvertirEntero]



*-------------------------------------------------------
* Función.....: ConvertirNumérico
*
* Descripción.: Convierte cualquier tipo de datos en
*               una expresión numérica
*
* Devuelve....:
*
* Parámetros..: uValor - Expresión a convertir
*               cTipoDatos - Tipo de datos orígen
*
* Notas.......:
*-------------------------------------------------------
FUNCTION ConvertirNumérico(uValor,cTipoDatos)

LOCAL cErrorAnterior,lError,nValor

* Guarda la rutina de errores anterior
**************************************
cErrorAnterior = ON([ERROR])

ON ERROR lError = .T.
lError = .F.
DO CASE
   CASE INLIST(cTipoDatos, "C", "M")
        nValor = VAL(uValor)
   CASE INLIST(cTipoDatos, "F", "I", "N", "B")
        nValor = uValor              
   CASE cTipoDatos = "Y"
        nValor = MTON(uVAlor)
   CASE INLIST(cTipoDatos,"D","T")
        * Este caso devuelve el número
        * de día juliano
        ******************************
        nValor = VAL(SYS(11,uValor)) 
   CASE cTipoDAtos == "L"
        nValor = IIF(uValor,1,0)     
   OTHERWISE
        nValor = uValor
ENDCASE


IF lError
   nValor = 0
ENDIF

* Recupera el gestor de errores anterior
****************************************
ON ERROR &cErrorAnterior

	RETURN nValor

ENDFUNC && [ConvertirNumérico]


*-------------------------------------------------------
* Función.....: ConvertirMonetario
*
* Descripción.: Convierte cualquier tipo de datos en
*               una expresión monetaria
*
* Devuelve....:
*
* Parámetros..: uValor - Expresión a convertir
*               cTipoDatos - Tipo de datos orígen
*
* Notas.......:
*-------------------------------------------------------
FUNCTION ConvertirMonetario(uValor,cTipoDatos)

LOCAL cErrorAnterior,lError,nValor

* Guarda la rutina de errores anterior
**************************************
cErrorAnterior = ON([ERROR])

ON ERROR lError = .T.
lError = .F.
DO CASE
   CASE INLIST(cTipoDatos, "C", "M")
        nValor = NTOM(VAL(uValor))
   CASE INLIST(cTipoDatos, "F", "I", "N", "B")
        nValor = NTOM(uValor)
   CASE cTipoDatos = "Y"
        nValor = uValor
   CASE INLIST(cTipoDatos,"D","T")
        * Este caso devuelve el número
        * de día juliano
        ******************************
        nValor = NTOM(VAL(SYS(11,uValor)))
   CASE cTipoDAtos == "L"
        nValor = NTOM(IIF(uValor,1,0))
   OTHERWISE
        nValor = uValor
ENDCASE


IF lError
   nValor = 0
ENDIF

* Recupera el gestor de errores anterior
****************************************
ON ERROR &cErrorAnterior

	RETURN nValor

ENDFUNC && [ConvertirMonetario]


*-------------------------------------------------------
* Función.....: ConvertirFechaHora
*
* Descripción.: Convierte cualquier tipo de datos en
*               una expresión fechahora
*
* Devuelve....:
*
* Parámetros..: uValor - Expresión a convertir
*               cTipoDatos - Tipo de datos orígen
*
* Notas.......:
*-------------------------------------------------------
FUNCTION ConvertirFechaHora(uValor,cTipoDatos)

LOCAL cErrorAnterior,lError,tValor

* Guarda la rutina de errores anterior
**************************************
cErrorAnterior = ON([ERROR])

ON ERROR lError = .T.
lError = .F.
DO CASE
   CASE INLIST(cTipoDatos, "C", "M")
        tValor = CTOT(uValor)
   CASE INLIST(cTipoDatos, "F", "I", "N", "B", "Y")
        tValor = CTOT(SYS(10,uValor))
   CASE cTipoDatos == "L"
        * No existe conversión posible
        ******************************
        tValor = CTOT("  /  /  ")
   CASE cTipoDatos == "T"        
        tValor = uValor
   CASE cTipoDatos == "D"
        tValor = DTOT(uValor)
   OTHERWISE
        tValor = uValor
ENDCASE


IF lError
   tValor = CTOT("  /  /  ")
ENDIF

* Recupera el gestor de errores anterior
****************************************
ON ERROR &cErrorAnterior

	RETURN tValor
ENDFUNC && [ConvertirFechaHora]
