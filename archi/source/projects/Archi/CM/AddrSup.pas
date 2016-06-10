unit AddrSup;

interface

{see also D_DocAddr}

{ $Id: AddrSup.pas,v 1.5 2016/05/16 10:31:58 dinishev Exp $ }

uses
 DT_Types;

 function StrToDocAddr(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID) : boolean;
 function DocAddrToStr(aDocID : TDocID; aSubID : TSubID) : String;

 function IsValidAddressStr(aAddrStr: string): Boolean;

 function StrToHlinkSpecValue(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID) : boolean;

implementation

uses
 SysUtils,

 arTextUtils,

 l3Chars,
 l3String;

function DocAddrToStr(aDocID : TDocID; aSubID : TSubID) : String;
begin
 if (aDocID <= 0) and (aSubID = -1) then
  Result := ''
 else
  if (aDocID > 0) and (aSubID = -1) then
   Result := Format('%d', [aDocID])
 else
  if (aDocID <= 0) and (aSubID > -1) then
   Result := Format('.%d', [aSubID])
 else
  if (aDocID > 0) and (aSubID > -1) then
   Result := Format('%d.%d', [aDocID, aSubID]);   
end;

function StrToHlinkSpecValue(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID): Boolean;
var
 I      : Integer;
 l_CStr : String;
begin
 Result := False;
 aDocID := -1;
 aSubID := -1;
 aAddrStr := ev_psTrim(aAddrStr);
 if aAddrStr[1] = '@' then // WrongHyperlink
 begin
  aDocID := Pred(MaxInt);
  Result := True;
 end // if aAddrStr[1] = '@' then
 else
 begin
  if Length(aAddrStr) < 2 then Exit;
  l_CStr := '';
  
  if aAddrStr[1] = cc_Number then // ID Hyperlink
  begin
   for I := 2 to Length(aAddrStr) do
   if (aAddrStr[I] in cc_Digits) or ((I = 2) and (aAddrStr[I] = cc_Minus)) then
    l_CStr := l_CStr + aAddrStr[I]
   else
    Break;

   aDocID := MaxInt;
   aSubID := StrtoInt(l_CStr);
   Result := True;
  end; // if aAddrStr[1] = cc_Number then
 end;
end;

function IsValidAddressStr(aAddrStr: string): Boolean;
var
 I: Integer;
begin
 Result := False;
 aAddrStr := Trim(aAddrStr);
 if (aAddrStr = '') or (aAddrStr[1] = cc_Dot) or (aAddrStr[Length(aAddrStr)] = cc_Dot) then
  Exit;
 for I := 1 to Length(aAddrStr) do
  if not (aAddrStr[I] in cc_DigitEX) then
   Exit;
 Result := True;    
end;                     

function StrToDocAddr(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID): Boolean;
var
 I        : Integer;
 l_CStr   : String;
 l_CurVar : Byte;  {0 - aDocID, 1 - aSubID}

 procedure SetVar;
 begin
  if Length(l_CStr) > 0 then
   case l_CurVar of
    0 : aDocID := StrToIntDef(l_CStr, 0);
    1 : aSubID := StrToIntDef(l_CStr, 0);
   end;
 end;

begin
 Result := False;
 aDocID := -1;
 aSubID := -1;

 aAddrStr := ev_psTrim(aAddrStr);
 if Length(aAddrStr) = 0 then Exit;
 l_CStr := '';
 l_CurVar := 0;

 for I := 1 to Length(aAddrStr) do
  case aAddrStr[I] of
   cc_Dot :
    begin
     SetVar;
     Inc(l_CurVar);
     l_CStr := '';
    end;

   '0'..'9' :
    l_CStr := l_CStr + aAddrStr[I];
   else
    raise Exception.CreateFmt('Неправильный формат ссылки "%s"', [aAddrStr]);
  end;
 SetVar;
 Result := True;
end;

end.