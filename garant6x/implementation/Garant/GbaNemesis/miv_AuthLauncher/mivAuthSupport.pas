unit mivAuthSupport;

interface
uses
 Classes,
 mivSettings;

type

 TmivAuthSupport = class(TObject)
 public
  class function CreateURL(const aLogin: String; const anURL: String;
   const aData: String; aTime: Int64; const aHardwareID: String): String;
  { - составляет URL с данными для аутентификации }
(*  class function ValidateFlash(const aMD5HardwareIDHash: String;
   const aFlashDriveName: String): Boolean;*)
  { - проверяет соответствие HardwareID флэшки по букве диска эталонному }
  class function ValidateFlashEx(const aMD5HardwareIDHash: String;
    out aIsValid: Boolean): String;
 end;


implementation
uses
 SysUtils,
 DateUtils,
 mivUtils,
 mivBase64,
 md5,
 l3Base;

{ TmivAuthSupport }

class function TmivAuthSupport.CreateURL(const aLogin: String; const anURL: String;
   const aData: String; aTime: Int64; const aHardwareID: String): String;
{ - составляет URL с данными для аутентификации }
var
 l_OpenPart: String;
 l_ClosedPart: String;
begin
 l_OpenPart := Format('%slogin=%s', [anURL, aLogin]);
 l_ClosedPart := mivXorStr(Format('{"data": "%s", "time": %d}', [aData, aTime]),
  aHardwareID);
 Result := Format('%s&data=%s', [l_OpenPart, EncodeString(l_ClosedPart)]);
end;

class function TmivAuthSupport.ValidateFlashEx(const aMD5HardwareIDHash: String;
 out aIsValid: Boolean): String;
var
 l_SL: TStrings;
 l_Index: Integer;
 l_CurHardwareIDMD5Hash: String;
begin
 aIsValid := False;
 Result := '';
 l_SL := TStringList.Create;
 try
  if mivGetFlashIDs(l_SL) then
  begin
   for l_Index := 0 to Pred(l_SL.Count) do
   begin
    l_CurHardwareIDMD5Hash := MD5DigestToStr(MD5String(l_SL[l_Index]));
    aIsValid := AnsiSameText(aMD5HardwareIDHash, l_CurHardwareIDMD5Hash) and
     (aMD5HardwareIDHash <> '') and (l_CurHardwareIDMD5Hash <> '');
    if aIsValid then
    begin
     Result := l_SL[l_Index];
     Exit;
    end;
   end;
  end;
 finally
  FreeAndNil(l_SL);
 end;
end;

end.
