unit dt_DictSup;

interface

Uses
 dt_Types, dt_AttrSchema, DT_TblCacheDef;

procedure dictChangeToLogFile(aAttrType: TCacheType; aDictID, aDocID, aSubID: Integer);

(*function dictLogFileToText: String;*)


implementation

Uses
 dt_TblCache, dt_Dict, dt_DictConst,
 RxStrUtils,
 SysUtils, Windows, Classes, dt_Const, dt_Doc, l3Base, l3String;

procedure dictChangeToLogFile(aAttrType: TCacheType; aDictID, aDocID, aSubID: Integer);
var
 l_S: String;
 l_Handle: Integer;
begin
 l_S:= Format('%d %d %d %d'#13#10, [Ord(aAttrType), aDictID, aDocID, aSubID]);
 if FileExists(DictChangeFileName) then
  l_Handle:= FileOpen(DictChangeFileName, fmOpenReadWrite + fmShareDenyNone)
 else
  l_Handle:= FileCreate(DictChangeFileName, fmOpenReadWrite + fmShareDenyNone);
 try
  if l_Handle > 0 then
  begin
   repeat
   until LockFile(l_Handle, 0, 0, 1, 0);
   try
    FileSeek(l_Handle, 0, soFromEnd);
    FileWrite(l_Handle, Pointer(l_S)^, Length(l_S));
   finally
    Win32Check(UnlockFile(l_Handle, 0, 0, 1, 0));
   end;
  end;
 finally
  if l_Handle > 0 then
   FileClose(l_Handle);
 end;
end;

end.
