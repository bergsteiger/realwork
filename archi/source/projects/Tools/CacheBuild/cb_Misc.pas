unit cb_Misc;

{ $Id: cb_Misc.pas,v 1.2 2016/08/03 09:13:42 fireton Exp $ }

interface

procedure UpcaseNumbersInCache;

implementation
uses
 SysUtils,

 l3Interfaces,
 l3String,
 l3Base,

 daSchemeConsts,

 HT_Const,
 dtIntf,
 DT_Types,
 DT_Const,
 DT_Sab,
 DT_Table,
 DT_Serv,
 DT_Misc,
 ddAutolinkCache;


procedure UpcaseNumbersInCache;
var
 l_Table : TdtTable;
 l_Sab   : ISab;
 l_Stub  : Pointer;

 function ModifyNumbers(aRecNo : LongInt; aRec : PCacheRec) : MFUNC_RET;
 var
  l_Num: Il3CString;
 begin
  Result := MFUNC_SUCCESS;
  l_Num := l3ArrayToCString(aRec^.rNumber, cDNNumberLen);
  if not l3IsNil(l_Num) then
  begin
   l_Num := l3Upper(l_Num);
   l3PCharLenToArray(aRec^.rNumber, cDNNumberLen, l_Num.AsWStr);
  end;
  l_Num := l3ArrayToCString(aRec^.rCaseCode, cDNNumberLen);
  if not l3IsNil(l_Num) then
  begin
   l_Num := l3Upper(l_Num);
   l3PCharLenToArray(aRec^.rCaseCode, cDNNumberLen, l_Num.AsWStr);
  end;
  l_Num := nil;
 end;

begin
 l_Table := TdtTable.CreateWithOpen(GlobalHTServer.Family[CurrentFamily].Path, '', GetALCacheMainTblPath(dsLocal), TAB_PRIVATE);
 try
  l_Sab := MakeAllRecords(l_Table);
  try
   l_Stub := HTStub3(@ModifyNumbers);
   try
    l_Sab.ModifyRecs(l_Stub);
   finally
    HTStubFree(l_Stub);
   end;
  finally
   l_Sab := nil;
  end;
  l_Table.UpdateTbl;
 finally
  FreeAndNil(l_Table);
 end;
end;

end.