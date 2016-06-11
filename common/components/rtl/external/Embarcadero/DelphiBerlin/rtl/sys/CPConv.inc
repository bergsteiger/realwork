{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
type
  TCPName= record
    WinCP: Cardinal;
    CanonicalIcuName: string;
    HashCode: Integer;
  end;

const
  TCPList: array [1..63] of TCPName = (
  (WinCP:932; CanonicalIcuName:'ibm-943_p15a-2003'; HashCode: 1246065839),
  (WinCP:936; CanonicalIcuName:'windows-936-2000'; HashCode: -937615316),
  (WinCP:949; CanonicalIcuName:'windows-949-2000'; HashCode: 371007533),
  (WinCP:950; CanonicalIcuName:'windows-950-2000'; HashCode: 1142759469),
  (WinCP:864; CanonicalIcuName:'ibm-864_x110-1999'; HashCode: -1185359484),
  (WinCP:874; CanonicalIcuName:'iso-8859_11-2001'; HashCode: -332594791),
  (WinCP:1200; CanonicalIcuName:'utf-16le'; HashCode: -1899474056),
  (WinCP:1201; CanonicalIcuName:'utf-16be'; HashCode: -1899474248),
  (WinCP:1250; CanonicalIcuName:'ibm-5346_p100-1998'; HashCode: 1098625461),
  (WinCP:1251; CanonicalIcuName:'ibm-5347_p100-1998'; HashCode: 1098887605),
  (WinCP:1252; CanonicalIcuName:'ibm-5348_p100-1997'; HashCode: 1094955450),
  (WinCP:1253; CanonicalIcuName:'ibm-5349_p100-1998'; HashCode: 1095217589),
  (WinCP:1254; CanonicalIcuName:'ibm-5350_p100-1998'; HashCode: 1105441205),
  (WinCP:1255; CanonicalIcuName:'ibm-9447_p100-2002'; HashCode: 830346375),
  (WinCP:1256; CanonicalIcuName:'ibm-9448_x100-2005'; HashCode: 826416256),
  (WinCP:1257; CanonicalIcuName:'ibm-9449_p100-2002'; HashCode: 826676359),
  (WinCP:1258; CanonicalIcuName:'ibm-5354_p100-1998'; HashCode: 1106489781),
  (WinCP:10000; CanonicalIcuName:'macos-0_2-10.2'; HashCode: -1770124805),
  (WinCP:10004; CanonicalIcuName:'macos-518-10.2'; HashCode: 41814472),
  (WinCP:10005; CanonicalIcuName:'macos-1285-10.2'; HashCode: 2114045610),
  (WinCP:10006; CanonicalIcuName:'macos-6_2-10.4'; HashCode: -1770124851),
  (WinCP:10007; CanonicalIcuName:'macos-7_3-10.2'; HashCode: -1803679293),
  (WinCP:10010; CanonicalIcuName:'macos-38_2-10.2'; HashCode: -1342061341),
  (WinCP:10021; CanonicalIcuName:'macos-21-10.5'; HashCode: 290322325),
  (WinCP:10029; CanonicalIcuName:'macos-29-10.2'; HashCode: 21886866),
  (WinCP:10079; CanonicalIcuName:'macos-37_5-10.2'; HashCode: -1107180389),
  (WinCP:10081; CanonicalIcuName:'macos-35-10.2 '; HashCode: 700379755),
  (WinCP:10082; CanonicalIcuName:'macos-36_2-10.2'; HashCode: -1342061421),
  (WinCP:12000; CanonicalIcuName:'utf-32le'; HashCode: -1899412616),
  (WinCP:12001; CanonicalIcuName:'utf-32be'; HashCode: -1899412808),
  (WinCP:20127; CanonicalIcuName:'us-ascii'; HashCode: -1640462379),
  (WinCP:20866; CanonicalIcuName:'ibm-878_p100-1996'; HashCode: -102182517),
  (WinCP:20936; CanonicalIcuName:'ibm-1383_p110-1999'; HashCode: 124760508),
  (WinCP:21866; CanonicalIcuName:'ibm-1168_p100-2002'; HashCode: 1614943383),
  (WinCP:28591; CanonicalIcuName:'iso-8859-1'; HashCode: 865276130),
  (WinCP:28592; CanonicalIcuName:'ibm-912_p100-1995'; HashCode: -356462200),
  (WinCP:28593; CanonicalIcuName:'ibm-913_p100-2000'; HashCode: -356158291),
  (WinCP:28594; CanonicalIcuName:'ibm-914_p100-1995'; HashCode: -354889336),
  (WinCP:28595; CanonicalIcuName:'ibm-915_p100-1995'; HashCode: -354627192),
  (WinCP:28596; CanonicalIcuName:'ibm-1089_p100-1995'; HashCode: 2001187248),
  (WinCP:28597; CanonicalIcuName:'ibm-9005_x110-2007'; HashCode: 863378562),
  (WinCP:28598; CanonicalIcuName:'ibm-5012_p100-1999'; HashCode: 1944826292),
  (WinCP:28599; CanonicalIcuName:'ibm-920_p100-1995'; HashCode: -347549304),
  (WinCP:28603; CanonicalIcuName:'ibm-921_p100-1995'; HashCode: -347287160),
  (WinCP:28605; CanonicalIcuName:'ibm-923_p100-1998'; HashCode: -347811451),
  (WinCP:50220; CanonicalIcuName:'iso_2022_jp'; HashCode: -501851932),
  (WinCP:50225; CanonicalIcuName:'iso_2022_kr'; HashCode: -501851962),
  (WinCP:50227; CanonicalIcuName:'iso_2022_cn'; HashCode: -501851686),
  (WinCP:50229; CanonicalIcuName:'iso_2022_cn'; HashCode: -501851686),
  (WinCP:51932; CanonicalIcuName:'euc-jp-2007'; HashCode: 601302093),
  (WinCP:52936; CanonicalIcuName:'hz'; HashCode: 2394),
  (WinCP:54936; CanonicalIcuName:'gb18030'; HashCode: 1192019521),
  (WinCP:57002; CanonicalIcuName:'x-iscii-de'; HashCode: 1119818649),
  (WinCP:57003; CanonicalIcuName:'x-iscii-be'; HashCode: 1119818585),
  (WinCP:57004; CanonicalIcuName:'x-iscii-ta'; HashCode: 1119818141),
  (WinCP:57005; CanonicalIcuName:'x-iscii-te'; HashCode: 1119818137),
  (WinCP:57007; CanonicalIcuName:'x-iscii-or'; HashCode: 1119818478),
  (WinCP:57008; CanonicalIcuName:'x-iscii-ka'; HashCode: 1119818365),
  (WinCP:57009; CanonicalIcuName:'x-iscii-ma'; HashCode: 1119818429),
  (WinCP:57010; CanonicalIcuName:'x-iscii-gu'; HashCode: 1119818729),
  (WinCP:57011; CanonicalIcuName:'x-iscii-pa'; HashCode: 1119818013),
  (WinCP:65000; CanonicalIcuName:'utf-7'; HashCode: 91954583),
  (WinCP:65001; CanonicalIcuName:'utf-8'; HashCode: 91954584));


function GetWinCodePage(var CodePage: Cardinal; CodePageName: string): Boolean;
  function GetCanonicalName(CodePageName:string): string;
  var
    Error: UErrorCode;
    M: TMarshaller;
    Conv: PUConverter;
  begin
    Result := '';
    Error := U_ZERO_ERROR;
    Conv := ucnv_open(M.AsUtf8(CodePageName).ToPointer,Error);
    if Integer(Error) <= 0 then
    begin
      try
        Error := U_ZERO_ERROR;
        Result := string(ucnv_getName(Conv, Error));
      finally
        ucnv_close(Conv);
      end;
    end;
  end;

var
  LCanonicalName: string;
  I: Integer;
  LCanonicalHash: Integer;
begin
  Result := false;
  LCanonicalName := LowerCase(GetCanonicalName(CodePageName));
  if LCanonicalName <> '' then
  begin
    LCanonicalHash := LCanonicalName.GetHashCode;
    for I := 1 to 63 do
    begin
      if (TCPList[I].HashCode = LCanonicalHash) and
         (TCPList[I].CanonicalIcuName = LCanonicalName)then
      begin
        CodePage := TCPList[I].WinCP;
        Exit( True );
      end;
    end;
  end;
end;

function GetIcuName(CodePage: Cardinal; var CodePageName: string): Boolean;
  function GetDisplayName(CanonicalName:string):string;
  var
    Error: UErrorCode;
    M: TMarshaller;
    Conv: PUConverter;
    LName: array of PUCHAR;
  begin
    Result := '';
    Error := U_ZERO_ERROR;
    conv := ucnv_open(M.AsUtf8(CanonicalName).ToPointer,Error);
    if Error <= U_ZERO_ERROR then
    begin
      try
        SetLength(LName, 250);
        Error := U_ZERO_ERROR;
        ucnv_getDisplayName(conv, TLanguages.UserDefaultLocale, PUCHAR(LName), 250, Error);
        if Error <= U_ZERO_ERROR then
          Result := PWideChar(LName);
      finally
        SetLength(LName, 0);
        ucnv_close(conv);
      end;
    end;
  end;
var
  I: Integer;
begin
  Result := False;
  for I := 1 to 63 do
  begin
    if TCPList[I].WinCP = CodePage then
    begin
      CodePageName := GetDisplayName( TCPList[I].CanonicalIcuName );
      Exit( True );
    end;
  end;
end;

