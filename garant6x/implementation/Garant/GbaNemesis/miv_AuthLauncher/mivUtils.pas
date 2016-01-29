unit mivUtils;

interface
uses
  Classes;

 function mivGetFlashIDs(aList: TStrings): boolean;
 { - Заполняет список строками с идентификаторам флэшек }
 (*function mivGetFlashID(const aDriveLetter: AnsiString): AnsiString;
 { - Возвращает HardwareID флэшки по букве }*)
 function mivXorStr(const aSubjectStr: AnsiString;
  const aKeyStr: AnsiString): AnsiString;
 { - ксорит первую строку второй }
 function mivGetTime: Int64;
 { - UNIX-style время в секундах по UTC }

implementation

uses
  Windows,
  DateUtils,
  SysUtils,
  StrUtils,
  SetupAPI,
  l3String,
  MD5,
  mivBase64;

function mivGetFlashIDs(aList: TStrings): boolean;
{ - Заполняет список строками с идентификаторам флэшек }
const
 cBuffSize     = 264;
 cDelim        = '\';
 cUsbStorIdent = 'USBSTOR\';
 cAmpersand    = '&';
var
 l_devs         : HDEVINFO;
 l_devIndex     : DWORD;
 l_devInfo      : TSPDevInfoData;
 l_SysDescrBuff : AnsiString;
 l_Buff         : AnsiString;
 l_devStr       : AnsiString;
 l_devStrStart  : Integer;
 l_devID        : AnsiString;
 l_devIDStart   : Integer;
 l_devIDEnd     : Integer;
 l_tempDw       : DWORD;
 l_reqSize      : DWORD;
begin
 Result := False;
 l_devs := INVALID_HANDLE_VALUE;
 l_devs := SetupDiGetClassDevs(nil, nil, HWND(0), DIGCF_PRESENT OR DIGCF_ALLCLASSES);
 if (l_devs = INVALID_HANDLE_VALUE) then
  Exit;
 FillChar(l_devInfo, SizeOf(l_devInfo), 0);
 l_devInfo.cbSize := SizeOf(l_devInfo);
 l_devIndex := 0;
 SetLength(l_SysDescrBuff, cBuffSize);
 while SetupDiEnumDeviceInfo(l_devs, l_devIndex, l_devInfo) do
 begin
  if (SetupDiGetDeviceRegistryProperty(l_devs, l_devInfo, SPDRP_DEVICEDESC, l_TempDw,
   PBYTE(PAnsiChar(l_SysDescrBuff)), Length(l_SysDescrBuff), l_reqSize)) then
   begin
    SetupDiGetDeviceInstanceId(l_devs, PSPDevInfoData(@l_devInfo), nil, 0, l_reqSize);
    Finalize(l_Buff);
    SetLength(l_Buff, l_reqSize);
    if (SetupDiGetDeviceInstanceId(l_devs, PSPDevInfoData(@l_devInfo),
     PAnsiChar(l_buff), Length(l_Buff), l_reqSize)) then
    begin
     l_devStrStart := l3StringPos(cUsbStorIdent, l_Buff);
     if (l_devStrStart > 0) then
     begin
      l_devStr := Copy(l_Buff, l_devStrStart, cBuffSize - l_devStrStart);
      // HardwareID по идее находится между последним слэшом и последним амперсандом
      l_devIDStart := l3StringRPos(cDelim, l_devStr) + 1;
      l_devIDEnd := l3StringRPos(cAmpersand, l_devStr);
      l_devID := Copy(l_devStr, l_devIDStart, l_devIDEnd - l_devIDStart);
      aList.Add(l_devID);
      Finalize(l_devID);
      Finalize(l_devStr);
      Result := True;
     end;//if (l_devStrStart > 0)
    end;//if (SetupDiGetDeviceInstanceId
   end;//if (SetupDiGetDeviceRegistryProperty
  Inc(l_devIndex);
 end;//while SetupDiEnumDeviceInfo
end;//mivGetFlashIDs

(*function mivGetFlashID(const aDriveLetter: AnsiString): AnsiString;
{ - Возвращает HardwareID флэшки по букве диска}
type
 TFNGetUSBInstanceID = function(const aDriveLetter: AnsiChar; anID: PAnsiChar): integer; stdcall;
const
 cDLLName       = 'GetFlashID.dll';
 cProcName      = 'pGetUSBInstanceID';
 cHardwareIDLen = 256;
var
 l_Module: HMODULE;
 l_FN: TFNGetUSBInstanceID;
 l_DriveLetter: Char;
 l_Str: String;
 l_Res: Integer;
begin
 Assert(False);
 Result := '';
 l_Module := HMODULE(0);
 l_FN := nil;
 l_Module := LoadLibrary(PChar(cDLLName));
 if (l_Module <> HMODULE(0)) then
 begin
  @l_FN := GetProcAddress(l_Module, PAnsiChar(cProcName));
  if (@l_FN <> nil) then
  begin
   SetLength(l_Str, cHardwareIDLen);
   l_DriveLetter := UpperCase(aDriveLetter)[1];
   l_FN(l_DriveLetter, PChar(l_Str));
   // могли вернуть пустую строчку
   if (StrLen(PChar(l_Str)) > 0) then
    Result := PChar(l_Str);
  end;//if (@l_FN <> nil)
 end;//if (l_Module <> HMODULE(0))
end;//mivGetFlashID *)

function mivXorStr(const aSubjectStr: AnsiString;
 const aKeyStr: AnsiString): AnsiString;
 { - ксорит первую строку второй }
var
 l_Index: Integer;
 l_KeyStrIndex: Integer;
begin
 Result := '';
 if (Length(aSubjectStr) = 0) or (Length(aKeyStr) = 0) then
  Exit;
 SetLength(Result, Length(aSubjectStr));
 l_KeyStrIndex := 1;
 for l_Index := 1 to Length(aSubjectStr) do
 begin
  Result[l_Index] := Chr(Ord(aSubjectStr[l_Index]) xor Ord(aKeyStr[l_KeyStrIndex]));
  if (l_KeyStrIndex < Length(aKeyStr)) then
   Inc(l_KeyStrIndex)
  else
   l_KeyStrIndex := 1;
 end;
end;//mivXorStr

function mivGetTime: Int64;
 { - UNIX-style время в секундах по UTC }
var
 l_Time: SYSTEMTIME;
 l_UTCTime: TDateTime;
begin
 FillChar(l_Time, SizeOf(l_Time), 0);
 GetSystemTime(l_Time);
 l_UTCTime := SystemTimeToDateTime(l_Time);
 Result := DateTimeToUnix(l_UTCTime);
end;

end.
