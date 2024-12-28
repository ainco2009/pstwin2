CLOSE all
#DEFINE _DOCUMENTO    "c:\etiq\prueba\word\cheque.doc"
LOCAL loWord, loDocument
*- Crea referencia a Word

TRY
  loWord = GETOBJECT(,'Word.Application')
CATCH
  loWord = CREATEOBJECT('Word.Application')
ENDTRY

IF VARTYPE(loWord) <> 'O'
  ERROR 'No se ha podido crear una referencia a WORD'
  RETURN .F.
ENDIF
*---------------------------------

* Abre el documento como ReadOnly

*---------------------------------
USE c:\etiq\prueba\word\cheque IN 0 ALIAS cheque
SCAN FOR  RECNO() < 20
    TRY
          loDocument = loWord.Documents.Open(_DOCUMENTO,,.T.)
    CATCH    

    *- Cierra instancia de Word

    IF VARTYPE(loWord) = 'O'
         loWord.Application.Quit(0) && Sale sin salvar y sin preguntar
         loWord = .NULL.
    ENDIF
          ERROR 'No se ha podido abrir el documento "' + _DOCUMENTO + '".'
    ENDTRY

    lfBuscaReplaCadena(loWord.Selection, "<<MONTONROS>>",MONTONROS )
    lfBuscaReplaCadena(loWord.Selection, "<<NOMBRE>>",NOMBRE )
    lfBuscaReplaCadena(loWord.Selection, "<<MONTOLETRA>>",MONTOLETRA )
    *lfBuscaReplaCadena(loWord.Selection, "<<poblacion>>",mail50.poblacion )

    loWord.Visible = .t.
    loWord.printout()
    wait "Imprimiendo..." window at 15,40 timeout 5
    loWord.documents().close(.f.)
ENDSCAN

loWord.quit(.f.)
RETURN

 
************************************************************************************
 

FUNCTION lfBuscaReplaCadena
LPARAMETERS poSelection, pcValueToFind, pcValueToReplace
*--------------------------------------------------------
*- Busca una cadena y la reemplaza por otra
*-
*- Parametros:
*-       poSelection            Referencia a la selección a buscar. 
*-       Ej. oWord.Selection
*-       pcValueToFind        Valor a buscar
*-       pcValueToReplace     Valor a reemplazar
*-
*- Devuelve:
*-             .t.           Si ha podido reemplazar todo
*-             .f.           Si NO ha podido reemplazar
*-
*--------------------------------------------------------
LOCAL llReturn
llReturn = .t.
TRY
  WITH poSelection.Find
         .ClearFormatting
         .Replacement.ClearFormatting
         .Text = pcValueToFind
         .Replacement.Text = pcValueToReplace
         .Forward = .T.
         .Wrap= 1
         .Execute(,,,,,,,,,,2)
  ENDWITH

CATCH TO nError 
    llReturn = .f.
    THIS.cDescUltError = 'Ha ocurrido un error en el proceso de reemplazo de texto'
ENDTRY
RETURN (llReturn)

