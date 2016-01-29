unit arVAnouncedBlackList;

{ $Id: arVAnouncedBlackList.pas,v 1.5 2014/04/17 13:09:06 voba Exp $ }

interface
uses
 l3LongintList,
 dt_Types,
 dtIntf, dt_Sab;

function GetVAnouncedAccGroupsBlackList: Tl3LongintList;
function IsDocAccGroupInAnouncedBlackList(aDocID : TDocID): Boolean;
procedure FilterbyVAnouncedAccGroupsBlackList(const aSab : ISab);

implementation
uses
 SysUtils,
 l3Types,
 l3IniFile,
 l3String,
 IniShop,
 l3Interfaces,
 l3Base,

 dt_Const,
 dt_AttrSchema,
 dt_Doc,
 dt_Link,
 dt_LinkServ;

var
 gBlackList: Tl3LongintList;

function GetVAnouncedAccGroupsBlackList: Tl3LongintList;
var
 l_Ini: TCfgList;
 l_Str: Il3CString;

 function DoNum(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_Num: Integer;
 begin
  Result := True;
  l_Num := l3StrToIntDef(aStr, -1);
  if l_Num >= 0 then
   gBlackList.Add(l_Num);
 end;

begin
 if gBlackList = nil then
 begin
  gBlackList := Tl3LongintList.MakeSorted;
  l_Ini := CreateFamilyBaseIni;
  try
   l_Ini.Section := 'Anounced';
   l_Str := l3CStr(l_Ini.ReadParamStrDef('AccGroupsBlackList', ''));
   if not l3IsNil(l_Str) then
   begin
    l3ParseWordsExF(l_Str.AsWStr, l3L2WA(@DoNum), [';',' ']);
   end;
  finally
   FreeAndNil(l_Ini);
  end;
 end;
 Result := gBlackList;
end;

function IsDocAccGroupInAnouncedBlackList(aDocID : TDocID): Boolean;
var
 l_BL: Tl3LongintList;
 l_IsInList: Boolean;
 lAccGr: Integer;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  lAccGr := PInteger(aItemPtr)^;
  l_IsInList := l_BL.IndexOf(lAccGr) >= 0;
  Result := not l_IsInList;
 end;

var
 lSab : ISab;
 lRAProcStub : TdtRecAccessProc;

begin
 Result := False;
 l_BL := GetVAnouncedAccGroupsBlackList;
 l_IsInList := False;
 // get AccGr
 lSab := MakeSab(LinkServer(CurrentFamily).Attribute[atAccGroups]);
 lSab.Select(lnkDocIDFld, aDocID);
 if lSab.Count > 0 then
 begin
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lRAProcStub, [lnkDictIDFld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
  Result := l_IsInList;
 end;
end;

procedure FilterbyVAnouncedAccGroupsBlackList(const aSab : ISab);
var
 lSab : ISab;
 lDocIDSab : ISab;
 lList : Tl3LongintList;
begin
 lList := GetVAnouncedAccGroupsBlackList;
 if lList.Empty then Exit;

 lDocIDSab := MakeSabCopy(aSab);
 lDocIDSab.RecordsByKey(lnkDocIDFld, MakePhoto(LinkServer(CurrentFamily).Attribute[atAccGroups].Table));

 lSab := MakeValueSet(LinkServer(CurrentFamily).Attribute[atAccGroups].Table,
                      lnkDictIDFld,
                      lList);
 lSab.RecordsByKey;
 lSab.AndSab(lDocIDSab);
 lSab.ValuesOfKey(lnkDocIDFld);
 lSab.RecordsByKey(fId_Fld, aSab);
 aSab.RecordsByKey;
 aSab.SubtractSab(lSab);
 aSab.ValuesOfKey(fId_Fld);
end;

initialization
 gBlackList := nil;
finalization
 FreeAndNil(gBlackList);
end.
