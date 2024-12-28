
*Excelente función que te permitirá renombrar una base de datos sin perder los vínculos de las tablas.

*Por : Cetin Basoz

lcOldDBC = "c:\pstwin\datos\BCOLARA\BASES"
lcNewDBC = "c:\pstwin\datos\BCOLARA\BASEBNLA"
cDirNw= "c:\pstwin\datos\BCOLARA\"

RenTable(m.lcOldDBC,"BNLA",cDirNw)
RENAME (cDirNw+"????BASE.DBF") TO (cDirNw+"????BNLA.DBF")
RenDbc(m.lcOldDBC, m.lcNewDBC)

FUNCTION RENTABLE
	LPARAMETERS OldName, cNewDbf, cDirNw
	Open Data (OldName)
	lnTables=Adbobject(arrTables,"TABLE")
	
	FOR IX=1 TO  lnTables
		lcTable = arrTables[ix]
	    NwTable = SUBSTR(ALLTRIM(arrTables[ix]),1,4)+cNewDbf
	    RENAME TABLE (lcTable) TO (NwTable)
   	NEXT
CLOSE DATABASES ALL
ENDFUNC

Function RenDbc 
    Lparameters OldName, NewName 
    Open Data (OldName)
    lnTables=Adbobject(arrTables,"TABLE") 
  
    For ix=1 To lnTables
         lcTable = arrTables[ix]+".DBF"
         handle=Fopen(lcTable,12) 
     =Fseek(handle,8,0)
        lnLowByte = Asc(Fread(handle,1))
       lnHighByte = Asc(Fread(handle,1))*256 
        lnBackLinkstart = lnHighByte + lnLowByte - 263 
    = Fseek (handle,lnBackLinkstart,0)
        Fwrite(handle,Forceext(NewName,"dbc" )+Replicate(Chr(0),263),263)
         =Fclose(handle) 
    Endfor 
    Close Data All

    Rename (Forceext(OldName,"dbc"))To (Forceext(NewName,"dbc"))
     Rename(Forceext(OldName,"dcx"))To (Forceext(NewName,"dcx"))
    Rename(Forceext(OldName,"dct"))To (Forceext(NewName,"dct")) 
Endfunc



