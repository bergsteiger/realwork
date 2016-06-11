{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxInformix;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxInformixReadOnlyMetaData, Data.DbxInformixMetaData;

type
  TDBXInformixProperties = class(TDBXProperties)
  strict private
    const StrInformixTransIsolation = 'Informix TransIsolation';
    const StrTrimChar = 'Trim Char';
    function GetHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetBlobSize: Integer;
    function GetDatabase: string;
    function GetInformixTransIsolation: string;
    function GetTrimChar: Boolean;
    procedure SetBlobSize(const Value: Integer);
    procedure SetDatabase(const Value: string);
    procedure SetInformixTransIsolation(const Value: string);
    procedure SetTrimChar(const Value: Boolean);
    procedure SetHostName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property HostName: string read GetHostName write SetHostName;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property Database: string read GetDatabase write SetDatabase;
    property BlobSize: Integer read GetBlobSize write SetBlobSize;
    property InformixTransIsolation:string read GetInformixTransIsolation write SetInformixTransIsolation;
    property TrimChar: Boolean read GetTrimChar write SetTrimChar;
  end;

  TDBXInformixDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;

const
  sDriverName = 'Informix';

{ TDBXInformixDriver }

constructor TDBXInformixDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXInformixProperties;
  I, Index: Integer;
begin
  Props := TDBXInformixProperties.Create(DBXDriverDef.FDBXContext);
  if DBXDriverDef.FDriverProperties <> nil then
  begin
    for I := 0 to DBXDriverDef.FDriverProperties.Count - 1 do
    begin
      Index := Props.Properties.IndexOfName(DBXDriverDef.FDriverProperties.Properties.Names[I]);
      if Index > -1 then
        Props.Properties.Strings[Index] := DBXDriverDef.FDriverProperties.Properties.Strings[I];
    end;
    Props.AddUniqueProperties(DBXDriverDef.FDriverProperties.Properties);
    DBXDriverDef.FDriverProperties.AddUniqueProperties(Props.Properties);
  end;
  inherited Create(DBXDriverDef, TDBXDynalinkDriverLoader, Props);
  rcs;
end;


{ TDBXInformixProperties }

constructor TDBXInformixProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXInformix';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXInformixDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXInformixMetaDataCommandFactory,DbxInformixDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXInformixMetaDataCommandFactory,Borland.Data.DbxInformixDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverINFORMIX';
  Values[TDBXPropertyNames.LibraryName] := 'dbxinf.dll';
  Values[TDBXPropertyNames.LibraryNameOsx] := 'libsqlinf.dylib';
  Values[TDBXPropertyNames.VendorLib] := 'isqlt09a.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'isqlt09a.dll';
  Values[TDBXPropertyNames.VendorLibOsx] := 'libifcli.dylib';

  Values[TDBXPropertyNames.HostName] := 'ServerName';
  Values[TDBXPropertyNames.Database] := 'Database Name';
  Values[TDBXPropertyNames.UserName] := 'user';
  Values[TDBXPropertyNames.Password] := 'password';

  Values[TDBXPropertyNames.MaxBlobSize] := '-1';
  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';

  Values['TrimChar'] := 'False';
  Values['DelimIdent'] := 'True';

end;

function TDBXInformixProperties.GetBlobSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.MaxBlobSize], -1);
end;

function TDBXInformixProperties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXInformixProperties.GetInformixTransIsolation: string;
begin
  Result := Values[StrInformixTransIsolation];
end;

function TDBXInformixProperties.GetTrimChar: Boolean;
begin
  Result := StrToBoolDef(Values[StrTrimChar], False);
end;

function TDBXInformixProperties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXInformixProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXInformixProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXInformixProperties.SetBlobSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.MaxBlobSize] := IntToStr(Value);
end;

procedure TDBXInformixProperties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;

procedure TDBXInformixProperties.SetInformixTransIsolation(const Value: string);
begin
  Values[StrInformixTransisolation] := Value;
end;

procedure TDBXInformixProperties.SetTrimChar(const Value: Boolean);
begin
  Values[StrTrimChar] := BoolToStr(Value, True);
end;
procedure TDBXInformixProperties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXInformixProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXInformixProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXInformixDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
end.
