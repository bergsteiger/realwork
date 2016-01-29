{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SockAppReg;

interface

uses
{$IFDEF MSWINDOWS}
 System.Win.Registry,
{$ENDIF}
  System.IniFiles, System.Contnrs;

type

  TWebAppRegInfo = class(TObject)
  private
    FFileName: string;
    FProgID: string;
  public
    property FileName: string read FFileName;
    property ProgID: string read FProgID;
  end;

  TWebAppRegList = class(TObjectList)
  private
    function GetItem(I: Integer): TWebAppRegInfo;
  public
    property Items[I: Integer]: TWebAppRegInfo read GetItem; default;
  end;

  procedure GetRegisteredWebApps(AList: TWebAppRegList);
  procedure RegisterWebApp(const AFileName, AProgID: string);
  procedure UnregisterWebApp(const AProgID: string);
  function FindRegisteredWebApp(const AProgID: string): string;
  function CreateRegistry(InitializeNewFile: Boolean = False): TCustomIniFile;

const
  sUDPPort = 'UDPPort';

implementation

{$IFDEF MSWINDOWS}
uses Winapi.Windows, System.SysUtils, System.Classes, SockConst;
{$ENDIF}
{$IFDEF LINUX}
uses SysUtils, Classes, libc;
{$ENDIF}

function CreateRegistry(InitializeNewFile: Boolean): TCustomIniFile;
{$IFDEF MSWINDOWS}
const
  sKey = '\Software\CodeGear\WebAppDbg';                      { do not localize }
begin
  Result := TRegistryIniFile.Create(sKey);
end;
{$ENDIF}
{$IFDEF LINUX}
var
  RegFile, ServInfoFile: string;
  NewFile: Boolean;
begin
  __mkdir(PChar(getenv('HOME') + '/.borland'), S_IRWXU or S_IRWXG or S_IRWXO);
  RegFile := getenv('HOME') + '/.borland/webappdbgrc';
  NewFile := not FileExists(RegFile);
  if NewFile and InitializeNewFile then
  begin
    ServInfoFile := ExtractFilePath(GetModuleName(Maininstance)) + 'serverinfo';     { do not localize }
    if FileExists(ServInfoFile) then
      RegisterWebApp(ServInfoFile,  'serverinfo.Serverinfo');     { do not localize }
  end;
  Result := TMemIniFile.Create(RegFile);
  TMemIniFile(Result).CaseSensitive := False;
end;
{$ENDIF}

const
  sWebApps = 'WebApps'; // Do not localize

procedure GetRegisteredWebApps(AList: TWebAppRegList);
var
  Reg: TCustomIniFile;
  S: TStrings;
  Info: TWebAppRegInfo;
  I: Integer;
begin
  AList.Clear;
  Reg := CreateRegistry;
  try
    S := TStringList.Create;
    try
      Reg.ReadSectionValues(sWebApps, S);
      for I := 0 to S.Count - 1 do
      begin
        Info := TWebAppRegInfo.Create;
        Info.FProgID := S.Names[I];
        Info.FFileName := S.Values[S.Names[I]];
        AList.Add(Info);
      end;
    finally
      S.Free;
    end;
  finally
    Reg.Free;
  end;
end;

function FindRegisteredWebApp(const AProgID: string): string;
var
  Reg: TCustomIniFile;
begin
  Reg := CreateRegistry;
  try
    Result := Reg.ReadString(sWebApps, AProgID, '');
  finally
    Reg.Free;
  end;
end;

procedure RegisterWebApp(const AFileName, AProgID: string);
var
  Reg: TCustomIniFile;
  S: TStrings;
  I: Integer;
  SameFileName, SameProgID: Boolean;
begin
  Reg := CreateRegistry;
  try
    S := TStringList.Create;
    try
      Reg.ReadSectionValues(sWebApps, S);
      for I := 0 to S.Count - 1 do
      begin
        SameProgID := CompareText(S.Names[I], AProgID) = 0;
        SameFileName := CompareText(S.Values[S.Names[I]], AFileName) = 0;
        if SameProgID and SameFileName then
          Exit // already registered
        else if (SameProgID or SameFileName) then
          Reg.DeleteKey(sWebApps, S[I]);
      end;
      Reg.WriteString(sWebApps, AProgID, AFileName);
    finally
      S.Free;
    end;
  finally
    Reg.UpdateFile;
    Reg.Free;
  end;
end;

procedure UnregisterWebApp(const AProgID: string);
var
  Reg: TCustomIniFile;
begin
  Reg := CreateRegistry;
  try
    Reg.DeleteKey(sWebApps, AProgID);
  finally
    Reg.UpdateFile;
    Reg.Free;
  end;
end;

{ TWebAppRegList }

function TWebAppRegList.GetItem(I: Integer): TWebAppRegInfo;
begin
  Result := TWebAppRegInfo(inherited Items[I]);
end;

end.
