* Nombre del fichero de configuración
#DEFINE FICHERO_INI [PSTWIN.INI]
#DEFINE cr CHR(13)
#DEFINE CRLF CHR(13)+CHR(10)

* Indicadores de modo desarrollo
********************************
#DEFINE DEBUGMODE .T.
#DEFINE _TITULOAPLICACION "Sicapro Win"
#DEFINE _VERSIONEXE TTOC(DATETIME())
#DEFINE DESARROLLO .T.

* Se utiliza esta parte de código para indicar
* quién ha bloqueado la aplicación para 
* evitar instalaciones incorrectas
*********************************************
#DEFINE _BLOQUEO .T.
#DEFINE _USUARIO "PEDRO. Ficha de usuarios y Ficha de comentarios "

* Estas constantes se usan en frmDatos para
* indicar el estado del alias actual
*******************************************
#DEFINE FILE_OK		0
#DEFINE FILE_BOF	1
#DEFINE FILE_EOF	2
#DEFINE FILE_CANCEL	3


#DEFINE AERRORARRAY	7

#DEFINE INSERTTRIG  1
#DEFINE UPDATETRIG  2
#DEFINE DELETETRIG  3

*#DEFINE _WIN16

*-- Nombres de barra de herramientas
#DEFINE TBR_FORMULARIOS      "Generador de formularios"
#DEFINE TBR_ESTANDAR         "Estándar"
#DEFINE TBR_DISTRIBUCION     "Distribución"
#DEFINE TBR_CONSULTAS        "Generador de consultas"
#DEFINE TBR_VISTAS           "Generador de vistas"
#DEFINE TBR_PALETA           "Paleta de colores"
#DEFINE TBR_CONTROLES        "Controles de formularios"
#DEFINE TBR_BASESDEDATOS     "Generador de bases de datos"
#DEFINE TBR_INFORMES         "Generador de informes"
#DEFINE TBR_CONTROLESINFORME "Controles de informes"
#DEFINE TBR_PRELIMINAR       "Presentación preliminar"


*-- Mensajes de cuadro de mensajes
#DEFINE NOEXISTEBASEDATOS   "El archivo no existe: "
#DEFINE TITULOERROR         "Ha ocurrido un error"



#DEFINE _NOPROT [DAT*@CLIENTES*@]


** FOXPRO.H **
************************************************************************************
************************************************************************************
**                                                                                **
** ================                    ===========                                **
**   ==         ===                      ==       ==                              **
**   ==           =                      ==        ==                             **
**   ==                                  ==        ==                             **
**   ==          ===      =====  =====   ==       ==  ===   ====         ===      **
**   =====    ==     ==     ==    ==     =========      == ==   ==    ==     ==   **
**   ==      ==       ==     ==  ==      ==             ===          ==       ==  **
**   ==     ==         ==     ===        ==             ==          ==         == **
**   ==      ==       ==     == ==       ==             ==           ==       ==  **
**   ==       ==     ==     ==   ==      ==             ==            ==     ==   **
** =======       ===      =====  ====  ======         ======             ===      **
**                                                                                **
************************************************************************************
************************************************************************************

************************************************************************************
************************************************************************************
**                                                                                **
** Visual FoxPro Named Constant File                                              **
** This file contains named constants for most Visual FoxPro functions            **
**                                                                                **
************************************************************************************
************************************************************************************

*-- General

*-- DragOver
#DEFINE DRAG_ENTER      0
#DEFINE DRAG_LEAVE      1
#DEFINE DRAG_OVER       2

*-- Drag (controls)
#DEFINE DRAG_CANCEL          0
#DEFINE DRAG_BEGIN      1
#DEFINE DRAG_END        2

*--ZOrder Method
#DEFINE ZORDER_BRINGTOFRONT    0
#DEFINE ZORDER_SENDTOBACK      1


*-- TYPE() tags
#DEFINE T_CHARACTER     "C"
#DEFINE T_NUMERIC       "N"
#DEFINE T_DOUBLE        "B"
#DEFINE T_DATE          "D"
#DEFINE T_DATETIME      "T"
#DEFINE T_MEMO          "M"
#DEFINE T_GENERAL       "G"
#DEFINE T_OBJECT        "O"
#DEFINE T_SCREEN        "S"
#DEFINE T_LOGICAL       "L"
#DEFINE T_CURRENCY      "Y"
#DEFINE T_UNDEFINED     "U"

*-- QueryUnload
#DEFINE FORM_CONTROLMENU        0
#DEFINE FORM_CODE               1
#DEFINE APP_WINDOWS             2
#DEFINE APP_TASKMANAGER         3
#DEFINE FORM_MDIFORM            4

*-- Properties

*-- Colors
#DEFINE COLOR_WHITE        16777215
#DEFINE COLOR_BLACK               0
#DEFINE COLOR_GRAY         12632256
#DEFINE COLOR_DARK_GRAY     8421504
#DEFINE COLOR_RED               255
#DEFINE COLOR_DARK_BLUE     8388608
#DEFINE COLOR_CYAN         16776960
#DEFINE COLOR_DARK_CYAN     8421376
#DEFINE COLOR_GREEN           65280
#DEFINE COLOR_DARK_GREEN      32768
#DEFINE COLOR_YELLOW          65535
#DEFINE COLOR_DARK_YELLOW     32896
#DEFINE COLOR_BLUE         16711680
#DEFINE COLOR_DARK_RED          128
#DEFINE COLOR_MAGENTA      16711935
#DEFINE COLOR_DARK_MAGENTA  8388736

*-- MousePointer
#DEFINE MOUSE_DEFAULT           0       && 0 - Default
#DEFINE MOUSE_ARROW             1       && 1 - Arrow
#DEFINE MOUSE_CROSSHAIR         2       && 2 - Cross
#DEFINE MOUSE_IBEAM             3       && 3 - I-Beam
#DEFINE MOUSE_ICON_POINTER      4       && 4 - Icon
#DEFINE MOUSE_SIZE_POINTER      5       && 5 - Size
#DEFINE MOUSE_SIZE_NE_SW        6       && 6 - Size NE SW
#DEFINE MOUSE_SIZE_N_S          7       && 7 - Size N S
#DEFINE MOUSE_SIZE_NW_SE        8       && 8 - Size NW SE
#DEFINE MOUSE_SIZE_W_E          9       && 9 - Size W E
#DEFINE MOUSE_UP_ARROW          10      && 10 - Up Arrow
#DEFINE MOUSE_HOURGLASS         11      && 11 - Hourglass
#DEFINE MOUSE_NO_DROP           12      && 12 - No drop

*-- DragMode
#DEFINE DRAG_MANUAL          0       && 0 - Manual
#DEFINE DRAG_AUTOMATIC       1       && 1 - Automatic

*-- DrawMode
#DEFINE DRAWMODE_BLACKNESS       1       && 1 - Blackness
#DEFINE DRAWMODE_NOT_MERGE_PEN   2       && 2 - Not Merge Pen
#DEFINE DRAWMODE_MASK_NOT_PEN    3       && 3 - Mask Not Pen
#DEFINE DRAWMODE_NOT_COPY_PEN    4       && 4 - Not Copy Pen
#DEFINE DRAWMODE_MASK_PEN_NOT    5       && 5 - Mask Pen Not
#DEFINE DRAWMODE_INVERT          6       && 6 - Invert
#DEFINE DRAWMODE_XOR_PEN         7       && 7 - Xor Pen
#DEFINE DRAWMODE_NOT_MASK_PEN    8       && 8 - Not Mask Pen
#DEFINE DRAWMODE_MASK_PEN        9       && 9 - Mask Pen
#DEFINE DRAWMODE_NOT_XOR_PEN     10      && 10 - Not Xor Pen
#DEFINE DRAWMODE_NOP             11      && 11 - Nop
#DEFINE DRAWMODE_MERGE_NOT_PEN   12      && 12 - Merge Not Pen
#DEFINE DRAWMODE_COPY_PEN        13      && 13 - Copy Pen
#DEFINE DRAWMODE_MERGE_PEN_NOT   14      && 14 - Merge Pen Not
#DEFINE DRAWMODE_MERGE_PEN       15      && 15 - Merge Pen
#DEFINE DRAWMODE_WHITENESS       16      && 16 - Whiteness

*-- DrawStyle
#DEFINE DRAWSTYLE_SOLID           0       && 0 - Solid
#DEFINE DRAWSTYLE_DASH            1       && 1 - Dash
#DEFINE DRAWSTYLE_DOT             2       && 2 - Dot
#DEFINE DRAWSTYLE_DASH_DOT        3       && 3 - Dash-Dot
#DEFINE DRAWSTYLE_DASH_DOT_DOT    4       && 4 - Dash-Dot-Dot
#DEFINE DRAWSTYLE_INVISIBLE       5       && 5 - Invisible
#DEFINE DRAWSTYLE_INSIDE_SOLID    6       && 6 - Inside Solid

*-- FillStyle
#DEFINE FILLSTYLE_SOLID                   0       && 0 - Solid
#DEFINE FILLSTYLE_TRANSPARENT             1       && 1 - Transparent
#DEFINE FILLSTYLE_HORIZONTAL_LINE         2       && 2 - Horizontal Line
#DEFINE FILLSTYLE_VERTICAL_LINE           3       && 3 - Vertical Line
#DEFINE FILLSTYLE_UPWARD_DIAGONAL         4       && 4 - Upward Diagonal
#DEFINE FILLSTYLE_DOWNWARD_DIAGONAL       5       && 5 - Downward Diagonal
#DEFINE FILLSTYLE_CROSS                   6       && 6 - Cross
#DEFINE FILLSTYLE_DIAGONAL_CROSS          7       && 7 - Diagonal Cross

*-- ScaleMode
#DEFINE SCALEMODE_PIXELS          3       && 3 - Pixel
#DEFINE SCALEMODE_FOXELS          0       && 0 - Foxels

*-- WindowState
#DEFINE WINDOWSTATE_NORMAL          0       && 0 - Normal
#DEFINE WINDOWSTATE_MINIMIZED       1       && 1 - Minimized
#DEFINE WINDOWSTATE_MAXIMIZED       2       && 2 - Maximized

*-- Window Borders
#DEFINE BORDER_NONE     0
#DEFINE BORDER_SINGLE   1
#DEFINE BORDER_DOUBLE   2
#DEFINE BORDER_SYSTEM   3

*-- Toolbar Positions
#DEFINE TOOL_NOTDOCKED  -1
#DEFINE TOOL_TOP        0
#DEFINE TOOL_LEFT       1
#DEFINE TOOL_RIGHT      2
#DEFINE TOOL_BOTTOM     3

*-- Button parameter masks
#DEFINE BUTTON_LEFT     1
#DEFINE BUTTON_RIGHT    2
#DEFINE BUTTON_MIDDLE   4

*-- Function Parameters
*-- MessageBox parameters
#DEFINE MB_OK                   0       && OK button only
#DEFINE MB_OKCANCEL             1       && OK and Cancel buttons
#DEFINE MB_ABORTRETRYIGNORE     2       && Abort, Retry, and Ignore buttons
#DEFINE MB_YESNOCANCEL          3       && Yes, No, and Cancel buttons
#DEFINE MB_YESNO                4       && Yes and No buttons
#DEFINE MB_RETRYCANCEL          5       && Retry and Cancel buttons

#DEFINE MB_ICONSTOP             16      && Critical message
#DEFINE MB_ICONQUESTION         32      && Warning query
#DEFINE MB_ICONEXCLAMATION      48      && Warning message
#DEFINE MB_ICONINFORMATION      64      && Information message

#DEFINE MB_APPLMODAL            0       && Application modal message box
#DEFINE MB_DEFBUTTON1           0       && First button is default
#DEFINE MB_DEFBUTTON2           256     && Second button is default
#DEFINE MB_DEFBUTTON3           512     && Third button is default
#DEFINE MB_SYSTEMMODAL          4096    && System Modal

*-- MsgBox return values
#DEFINE IDOK            1       && OK button pressed
#DEFINE IDCANCEL        2       && Cancel button pressed
#DEFINE IDABORT         3       && Abort button pressed
#DEFINE IDRETRY         4       && Retry button pressed
#DEFINE IDIGNORE        5       && Ignore button pressed
#DEFINE IDYES           6       && Yes button pressed
#DEFINE IDNO            7       && No button pressed


*-- Low Level File Constants
#DEFINE F_READONLY              0
#DEFINE F_WRITEONLY             1
#DEFINE F_READWRITE             2
#DEFINE F_READONLY_UNBUFF       10
#DEFINE F_WRITEONLY_UNBUFF      11
#DEFINE F_READWRITE_UNBUFF      12

*-- PRTINFO() Constants
*-- PRTINFO() Valid types to pass
#DEFINE PRT_ORIENTATION         1
#DEFINE PRT_PAPERSIZE           2
#DEFINE PRT_PAPERLENGTH         3
#DEFINE PRT_PAPERWIDTH          4
#DEFINE PRT_SCALE               5
#DEFINE PRT_COPIES              6
#DEFINE PRT_DEFASOURCE          7
#DEFINE PRT_PRINTQUAL           8
#DEFINE PRT_COLOR               9
#DEFINE PRT_DUPLEX              10
#DEFINE PRT_YRESOLUTION         11
#DEFINE PRT_TTOPTION            12

*--PRTINFO() Return types
*-- Paper sizes
#define PRTPAPER_LETTER      1       && Letter 8 1/2 x 11 in               
#define PRTPAPER_LETTERSMALL 2       && Letter Small 8 1/2 x 11 in         
#define PRTPAPER_TABLOID     3       && Tabloid 11 x 17 in                 
#define PRTPAPER_LEDGER      4       && Ledger 17 x 11 in                  
#define PRTPAPER_LEGAL       5       && Legal 8 1/2 x 14 in                
#define PRTPAPER_STATEMENT   6       && Statement 5 1/2 x 8 1/2 in         
#define PRTPAPER_EXECUTIVE   7       && Executive 7 1/4 x 10 1/2 in      
#define PRTPAPER_A3          8       && A3 297 x 420 mm                    
#define PRTPAPER_A4          9       && A4 210 x 297 mm                    
#define PRTPAPER_A4SMALL     10      && A4 Small 210 x 297 mm              
#define PRTPAPER_A5          11      && A5 148 x 210 mm                    
#define PRTPAPER_B4          12      && B4 250 x 354                       
#define PRTPAPER_B5          13      && B5 182 x 257 mm                    
#define PRTPAPER_FOLIO       14      && Folio 8 1/2 x 13 in                
#define PRTPAPER_QUARTO      15      && Quarto 215 x 275 mm                
#define PRTPAPER_10X14       16      && 10x14 in                           
#define PRTPAPER_11X17       17      && 11x17 in                           
#define PRTPAPER_NOTE        18      && Note 8 1/2 x 11 in                 
#define PRTPAPER_ENV_9       19      && Envelope #9 3 7/8 x 8 7/8          
#define PRTPAPER_ENV_10      20      && Envelope #10 4 1/8 x 9 1/2         
#define PRTPAPER_ENV_11      21      && Envelope #11 4 1/2 x 10 3/8        
#define PRTPAPER_ENV_12      22      && Envelope #12 4 \276 x 11           
#define PRTPAPER_ENV_14      23      && Envelope #14 5 x 11 1/2            
#define PRTPAPER_CSHEET      24      && C size sheet                       
#define PRTPAPER_DSHEET      25      && D size sheet                       
#define PRTPAPER_ESHEET      26      && E size sheet                       
#define PRTPAPER_ENV_DL      27      && Envelope DL 110 x 220mm            
#define PRTPAPER_ENV_C5      28      && Envelope C5 162 x 229 mm           
#define PRTPAPER_ENV_C3      29      && Envelope C3  324 x 458 mm          
#define PRTPAPER_ENV_C4      30      && Envelope C4  229 x 324 mm          
#define PRTPAPER_ENV_C6      31      && Envelope C6  114 x 162 mm          
#define PRTPAPER_ENV_C65     32      && Envelope C65 114 x 229 mm          
#define PRTPAPER_ENV_B4      33      && Envelope B4  250 x 353 mm          
#define PRTPAPER_ENV_B5      34      && Envelope B5  176 x 250 mm          
#define PRTPAPER_ENV_B6      35      && Envelope B6  176 x 125 mm          
#define PRTPAPER_ENV_ITALY   36      && Envelope 110 x 230 mm              
#define PRTPAPER_ENV_MONARCH 37      && Envelope Monarch 3.875 x 7.5 in    
#define PRTPAPER_ENV_PERSONAL 38     && 6 3/4 Envelope 3 5/8 x 6 1/2 in    
#define PRTPAPER_FANFOLD_US  39      && US Std Fanfold 14 7/8 x 11 in      
#define PRTPAPER_FANFOLD_STD_GERMAN  40 && German Std Fanfold 8 1/2 x 12 in   
#define PRTPAPER_FANFOLD_LGL_GERMAN  41 && German Legal Fanfold 8 1/2 x 13 in 

*-- Paper bins
#define PRTBIN_UPPER            1
#define PRTBIN_ONLYONE          1
#define PRTBIN_LOWER            2
#define PRTBIN_MIDDLE           3
#define PRTBIN_MANUAL           4
#define PRTBIN_ENVELOPE         5
#define PRTBIN_ENVMANUAL        6
#define PRTBIN_AUTO             7
#define PRTBIN_TRACTOR          8
#define PRTBIN_SMALLFMT         9
#define PRTBIN_LARGEFMT         10
#define PRTBIN_LARGECAPACITY    11
#define PRTBIN_CASSETTE         14

*-- Print qualities
#define PRTRES_DRAFT        -1
#define PRTRES_LOW          -2
#define PRTRES_MEDIUM       -3
#define PRTRES_HIGH         -4

*-- Color printer
#define PRTCOLOR_MONOCHROME  1
#define PRTCOLOR_COLOR       2

*-- Duplexing
#define PRTDUP_SIMPLEX    1
#define PRTDUP_VERTICAL   2
#define PRTDUP_HORIZONTAL 3

*-- True Type fonts
#define PRTTT_BITMAP     1  && Print True Type fonts as graphics
#define PRTTT_DOWNLOAD   2  && Download True Type fonts as soft fonts
#define PRTTT_SUBDEV     3  && Substitute device fonts for True Type

*-- FontMetric()
#DEFINE TM_HEIGHT           1
#DEFINE TM_ASCENT           2
#DEFINE TM_DESCENT          3
#DEFINE TM_INTERNALLEADING  4
#DEFINE TM_EXTERNALLEADING  5
#DEFINE TM_AVECHARWIDTH     6
#DEFINE TM_MAXCHARWIDTH     7
#DEFINE TM_WEIGHT           8
#DEFINE TM_ITALIC           9
#DEFINE TM_UNDERLINED      10
#DEFINE TM_STRUCKOUT       11
#DEFINE TM_FIRSTCHAR       12
#DEFINE TM_LASTCHAR        13
#DEFINE TM_DEFAULTCHAR     14
#DEFINE TM_BREAKCHAR       15
#DEFINE TM_PITCHANDFAMILY  16
#DEFINE TM_CHARSET         17
#DEFINE TM_OVERHANG        18
#DEFINE TM_ASPECTX         19
#DEFINE TM_ASPECTY         20

*-- SysMetric()
#DEFINE SM_CXSCREEN             0
#DEFINE SM_CYSCREEN             1
#DEFINE SM_CXVSCROLL            2
#DEFINE SM_CYHSCROLL            3
#DEFINE SM_CYCAPTION            4
#DEFINE SM_CXBORDER             5
#DEFINE SM_CYBORDER             6
#DEFINE SM_CXDLGFRAME           7
#DEFINE SM_CYDLGFRAME           8
#DEFINE SM_CYVTHUMB             9
#DEFINE SM_CXHTHUMB             10
#DEFINE SM_CXICON               11
#DEFINE SM_CYICON               12
#DEFINE SM_CXCURSOR             13
#DEFINE SM_CYCURSOR             14
#DEFINE SM_CYMENU               15
#DEFINE SM_CXFULLSCREEN         16
#DEFINE SM_CYFULLSCREEN         17
#DEFINE SM_CYKANJIWINDOW        18
#DEFINE SM_MOUSEPRESENT         19
#DEFINE SM_CYVSCROLL            20
#DEFINE SM_CXHSCROLL            21
#DEFINE SM_DEBUG                22
#DEFINE SM_SWAPBUTTON           23
#DEFINE SM_RESERVED1            24
#DEFINE SM_RESERVED2            25
#DEFINE SM_RESERVED3            26
#DEFINE SM_RESERVED4            27
#DEFINE SM_CXMIN                28
#DEFINE SM_CYMIN                29
#DEFINE SM_CXSIZE               30
#DEFINE SM_CYSIZE               31
#DEFINE SM_CXFRAME              32
#DEFINE SM_CYFRAME              33
#DEFINE SM_CXMINTRACK           34
#DEFINE SM_CYMINTRACK           35
#DEFINE SM_CMETRICS             36

*-- Cursor buffering modes
#DEFINE DB_BUFOFF               1
#DEFINE DB_BUFLOCKRECORD        2
#DEFINE DB_BUFOPTRECORD         3        
#DEFINE DB_BUFLOCKTABLE         4
#DEFINE DB_BUFOPTTABLE          5

*-- Update types for views/cursors
#DEFINE DB_UPDATE               1
#DEFINE DB_DELETEINSERT         2

*-- WHERE clause types for views/cursors
#DEFINE DB_KEY                  1
#DEFINE DB_KEYANDUPDATABLE      2
#DEFINE DB_KEYANDMODIFIED       3
#DEFINE DB_KEYANDTIMESTAMP      4

*-- Remote connection login prompt options
#DEFINE DB_PROMPTCOMPLETE       1
#DEFINE DB_PROMPTALWAYS         2
#DEFINE DB_PROMPTNEVER          3

*-- Remote transaction modes
#DEFINE DB_TRANSAUTO            1
#DEFINE DB_TRANSMANUAL          2

*-- Source Types for CursorGetProp()
#DEFINE DB_SRCLOCALVIEW         1
#DEFINE DB_SRCREMOTEVIEW        2
#DEFINE DB_SRCTABLE             3

** STRINGS.H **
*-- (c) Microsoft Corporation 1995

*-- STRINGS.H
*-- Incluir este archivo donde sea necesario para
*-- la localización

*-- Títulos de cuadro de mensajes
#DEFINE ERRORTITLE_LOC      "Ha ocurrido un error"
#DEFINE TASTRADE_LOC        "SICAPRO"

*-- Nombres de barra de herramientas
#DEFINE TB_FORMDESIGNER_LOC  "Generador de formularios"
#DEFINE TB_STANDARD_LOC      "Estándar"
#DEFINE TB_LAYOUT_LOC        "Distribución"
#DEFINE TB_QUERY_LOC        "Generador de consultas"
#DEFINE TB_VIEWDESIGNER_LOC  "Generador de vistas"
#DEFINE TB_COLORPALETTE_LOC  "Paleta de colores"
#DEFINE TB_FORMCONTROLS_LOC  "Controles de formularios"
#DEFINE TB_DATADESIGNER_LOC  "Generador de bases de datos"
#DEFINE TB_REPODESIGNER_LOC  "Generador de informes"
#DEFINE TB_REPOCONTROLS_LOC  "Controles de informes"
#DEFINE TB_PRINTPREVIEW_LOC  "Presentación preliminar"


*-- Mensajes de cuadro de mensajes
#DEFINE FILENOTEXIST_LOC    "El archivo no existe: "
#DEFINE BADPASSWORD_LOC      "La contraseña no es válida. (Vea el cuadro de texto 'Pista')"
#DEFINE BADNAME_LOC          "No se ha encontrado el nombre."
#DEFINE BADUPDATE_LOC        "No se puede actualizar - revirtiendo al original."
#DEFINE SAVECHANGES_LOC      "¿Desea guardar primero sus cambios?"
#DEFINE ASKDELETE_LOC        "¿Realmente desea eliminar esta información?"
#DEFINE TAGNOTFOUND_LOC      "La etiqueta de índice no se ha encontrado."
#DEFINE REPORTNOTFOUND_LOC  "El archivo de informe no se ha encontrado."
#DEFINE PRINTERNOTREADY_LOC  "La impresora no está preparada."
#DEFINE NORECSMATCHED_LOC    "Ningún registro cumple los criterios."
#DEFINE DELETEREC_LOC        "¿Realmente desea eliminar este registro?"
#DEFINE DELETEWARN_LOC      "Eliminar advertencia"
#DEFINE AVAILABLECREDIT_LOC  "Crédito disponible"
#DEFINE NOTYET_LOC          "En construcción"
#DEFINE CUSTIDEXISTS_LOC    "El ID de cliente ya existe. Escriba otro distinto."
#DEFINE NOLASTORDER_LOC      "El cliente no tiene ningún pedido previo."
#DEFINE CUSTFIRSTORDER_LOC  "El último pedido del cliente es el actual."
#DEFINE TODAYORLATER_LOC    "La fecha debe ser hoy o posterior."
#DEFINE DATERANGEERROR_LOC  "La fecha 'Hasta' no puede ser anterior a la fecha 'Desde'."
#DEFINE ADDCUSTOMER_LOC      "¿Desea agregar este Empleado al archivo maestro de Empleados?"
#DEFINE NOTHINGTOPRINT_LOC  "No hay nada que imprimir."
#DEFINE PASSWORDEMPTY_LOC    "La nueva contraseña no puede estar vacía."
#DEFINE PSWDNOTCNFRM_LOC    "No se puede confirmar la nueva contraseña. Inténtelo de nuevo."
#DEFINE NOPSWDENTERED_LOC    "Todavía no ha introducido la contraseña anterior. ¿Desea continuar?"
#DEFINE FILESAVEDAS_LOC      "El archivo se ha guardado como "
#DEFINE ORDHASITEMS_LOC      "Una Inclusión debe tener al menos un contrato."
#DEFINE CUSTOVERMAX_LOC      "El cliente ha superado el importe máximo de pedido en "
#DEFINE CUSTUNDERMIN_LOC    "El total de pedidos del cliente debe ser al menos "
#DEFINE SAVEANYWAY_LOC      "¿Desea guardar de todas maneras?"
#DEFINE VALIDATING_LOC      "Validando ..."
#DEFINE PRINTING_LOC        "Imprimiendo ..."
#DEFINE VIEWCODEPRINT_LOC    "Este informe puede ser muy largo. ¿Desea continuar?"
#DEFINE VIEWCSDTYPRINT_LOC  "Este informe puede ser muy largo. ¿Desea continuar?"
#DEFINE METHOD_LOC          "Método: "
#DEFINE LINENUM_LOC          "Línea: "
#DEFINE CUSTNOORD_LOC        "El cliente no tiene ningún pedido."
#DEFINE SELCUSTFIRST_LOC    "Debe seleccionar primero un cliente."
#DEFINE CANNOTQUIT_LOC      "No puede salir de Visual FoxPro desde SICAPRO."
#DEFINE ADDNEWREC_LOC        "Este era el último registro. ¿Desea agregar uno nuevo?"
#DEFINE ENTERADDMODE_LOC    "No hay ningún registro en el archivo. Pasará al modo 'Agregar'."
#DEFINE NOEMPLOYEES_LOC      "No hay ningún empleado en el archivo."
#DEFINE INSEMPLOYEE_LOC      "Todos los empleados deben estar asignados a un grupo."
#DEFINE INSPRODUCT_LOC      "A todos los productos se les debe asignar un proveedor y una categoría."
#DEFINE INSORDER_LOC        "Todos los pedidos deben tener un cliente y una compañía de envío. "
#DEFINE TABLERULEFAIL_LOC    "Falló la regla de la tabla."

*-- Mensajes de error de desencadenantes
#DEFINE INSERTTRIGFAIL_LOC  "Falló el desencadenante Insert."
#DEFINE UPDATETRIGFAIL_LOC  "Falló el desencadenante Update."
#DEFINE DELETETRIGFAIL_LOC  "Falló el desencadenante Delete."
#DEFINE DELCATEGORY_LOC      "Los productos pertenecen a esta categoría. No se puede eliminar."
#DEFINE DELCUSTOMER_LOC      "El cliente tiene contratos. No se puede eliminar."
#DEFINE DELEMPLOYEE_LOC      "El promotor existe en los casas. No se puede eliminar."
#DEFINE DELPRODUCT_LOC      "El producto existe en los artículos de pedidos. No se puede eliminar."
#DEFINE DELSUPPLIER_LOC      "Los productos los suministra este proveedor. No se puede eliminar."
#DEFINE DELSHIPPER_LOC      "La compañía de envío existe en los pedidos. No se puede eliminar."

*-- Otras cadenas
#DEFINE ADDPICTURE_LOC      "Agregar Logo"
#DEFINE CHANGEPICTURE_LOC    "Cambiar Logo"
#DEFINE SELECTBUTTON_LOC    "Seleccionar"
#DEFINE VERSION_LOC          "1.0"
#DEFINE COPYRIGHT_LOC        "Copyright 1995 Microsoft Corporation"
#DEFINE RIGHTSRSRVD_LOC      "Reservados todos los derechos"
#DEFINE ADDITEM_LOC          "Agregar Item"
#DEFINE REMOVEITEM_LOC      "Quitar Item"
#DEFINE INFSAVED_LOC        "Se ha guardado la información."
#DEFINE REINDEXING_LOC      "Reindexando: "
#DEFINE DONE_LOC            "Terminado"
#DEFINE LOWERNOTFOUND_LOC    " no se encuentra."
#DEFINE ABOUT_LOC            "Acerca de "
#DEFINE VERSIONLABEL_LOC    "Versión "
#DEFINE LOWERFOR_LOC        " para "
#DEFINE UPDATEORDER_LOC      "Actualizando el pedido"
