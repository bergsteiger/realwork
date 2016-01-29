unit AddrSup;
interface
{see also D_DocAddr}

{ $Id: AddrSup.pas,v 1.4 2013/09/13 14:16:54 voba Exp $ }

 uses DT_Types;

 function StrToDocAddr(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID) : boolean;
 function DocAddrToStr(aDocID : TDocID; aSubID : TSubID) : String;

 function IsValidAddressStr(aAddrStr: string): Boolean;

 function StrToHlinkSpecValue(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID) : boolean;

implementation
 uses
  SysUtils,
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

function StrToHlinkSpecValue(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID) : boolean;
var
 I       : Integer;
 lCStr   : String;

begin
 Result := False;
 aDocID := -1;
 aSubID := -1;
 aAddrStr := ev_psTrim(aAddrStr);
 if aAddrStr[1] = '@' then // WrongHyperlink
 begin
  aDocID := Pred(MaxInt);
  Result := True;
 end
 else
 begin
  if Length(aAddrStr) < 2 then Exit;
  lCStr := '';

  if aAddrStr[1] = '#' then// ID Hyperlink
  begin
   for I := 2 to Length(aAddrStr) do
   if (aAddrStr[I] in ['0'..'9']) or ((I = 2) and (aAddrStr[I] = '-')) then
    lCStr := lCStr + aAddrStr[I]
   else
    break;

   aDocID := MaxInt;
   aSubID := StrtoInt(lCStr);
   Result := True;
  end;
 end;
end;

function IsValidAddressStr(aAddrStr: string): Boolean;
var
 I: Integer;
begin
 Result := False;
 aAddrStr := Trim(aAddrStr);
 if (aAddrStr = '') or (aAddrStr[1] = '.') or (aAddrStr[Length(aAddrStr)] = '.') then
  Exit;
 for I := 1 to Length(aAddrStr) do
  if not (aAddrStr[I] in ['0'..'9', '.']) then
   Exit;
 Result := True;    
end;


function StrToDocAddr(aAddrStr : String; var aDocID : TDocID; var aSubID : TSubID) : boolean;
var
 I       : Integer;
 lCurVar : Byte;  {0 - aDocID, 1 - aSubID}
 lCStr   : String;

 procedure SetVar;
  begin
   If Length(lCStr) > 0 then
    case lCurVar of
     0 : aDocID := StrToIntDef(lCStr, 0);
     1 : aSubID := StrToIntDef(lCStr, 0);
    end;

  end;

begin
 Result := False;
 aDocID := -1;
 aSubID := -1;

 aAddrStr := ev_psTrim(aAddrStr);
 If Length(aAddrStr) = 0 then Exit;
 //I := 0;
 lCStr := '';
 lCurVar := 0;

 for I:=1 to Length(aAddrStr) do
  case aAddrStr[I] of
   '.' :
    begin
     SetVar;
     Inc(lCurVar);
     lCStr := '';
    end;

   '0'..'9' :
    lCStr := lCStr + aAddrStr[I];

   else
    raise Exception.CreateFmt('Неправильный формат ссылки "%s"', [aAddrStr]);
    // Exit;
  end;
 SetVar;
 Result := True;
end;

end.