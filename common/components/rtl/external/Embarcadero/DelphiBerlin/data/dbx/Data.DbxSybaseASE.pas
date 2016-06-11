{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxSybaseASE;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxSybaseASEReadOnlyMetaData, Data.DbxSybaseASEMetaData;

type
  TDBXSybaseASEProperties = class(TDBXProperties)
  strict private
    const StrASETransIsolation = 'ASE TransIsolation';
    const StrTDSPacketSize = 'TDS Packet Size';
    const StrClientHostName = 'Client HostName';
    const StrClientAppName = 'Client AppName';
    function GetHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetBlobSize: Integer;
    function GetDatabase: string;
    function GetTDSPacketSize: Integer;
    function GetSybaseASETransIsolation: string;
    function GetClientAppName: string;
    function GetClientHostName: string;
    procedure SetClientAppName(const Value: string);
    procedure SetClientHostName(const Value: string);
    procedure SetTDSPacketSize(const Value: Integer);
    procedure SetBlobSize(const Value: Integer);
    procedure SetDatabase(const Value: string);
    procedure SetSybaseASETransIsolation(const Value: string);
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
    property SybaseASETransIsolation:string read GetSybaseASETransIsolation write SetSybaseASETransIsolation;
    property TDSPacketSize: Integer read GetTDSPacketSize write SetTDSPacketSize;
    property ClientHostName: string read GetClientHostName write SetClientHostName;
    property ClientAppName: string read GetClientAppName write SetClientAppName;
  end;

  TDBXSybaseASEDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;
  
const
  sDriverName = 'ASE';

{ TDBXSybaseASEDriver }

constructor TDBXSybaseASEDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXSybaseASEProperties;
  I, Index: Integer;
begin
  Props := TDBXSybaseASEProperties.Create(DBXDriverDef.FDBXContext);
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


{ TDBXSybaseASEProperties }

constructor TDBXSybaseASEProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DbxSybaseASE';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXSybaseASEDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXSybaseASEMetaDataCommandFactory,DbxSybaseASEDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXSybaseASEMetaDataCommandFactory,Borland.Data.DbxSybaseASEDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverASE';
  Values[TDBXPropertyNames.LibraryName] := 'dbxase.dll';
  Values[TDBXPropertyNames.VendorLib] := 'libct.dll;libcs.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'libct64.dll;libcs64.dll';

  Values[TDBXPropertyNames.HostName] := 'ServerName';
  Values[TDBXPropertyNames.Database] := 'Database Name';
  Values[TDBXPropertyNames.UserName] := 'user';
  Values[TDBXPropertyNames.Password] := 'password';

  Values[TDBXPropertyNames.MaxBlobSize] := '-1';
  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';

  Values['TDSPacketSize'] := '512';
  Values['ClientHostName'] := '';
  Values['ClientAppName'] := '';
end;

function TDBXSybaseASEProperties.GetBlobSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.MaxBlobSize], -1);
end;

function TDBXSybaseASEProperties.GetClientAppName: string;
begin
  Result := Values[StrClientAppName];
end;

function TDBXSybaseASEProperties.GetClientHostName: string;
begin
  Result := Values[StrClientHostName];
end;

function TDBXSybaseASEProperties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXSybaseASEProperties.GetSybaseASETransIsolation: string;
begin
  Result := Values[StrASETransIsolation];
end;

function TDBXSybaseASEProperties.GetTDSPacketSize: Integer;
begin
  Result := StrToIntDef(Values[StrTDSPacketSize], 512);
end;

function TDBXSybaseASEProperties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXSybaseASEProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXSybaseASEProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXSybaseASEProperties.SetBlobSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.MaxBlobSize] := IntToStr(Value);
end;

procedure TDBXSybaseASEProperties.SetClientAppName(const Value: string);
begin
  Values[StrClientAppName] := Value;
end;

procedure TDBXSybaseASEProperties.SetClientHostName(const Value: string);
begin
  Values[StrClientHostName] := Value;
end;

procedure TDBXSybaseASEProperties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;

procedure TDBXSybaseASEProperties.SetSybaseASETransIsolation(const Value: string);
begin
  Values[StrASETransIsolation] := Value;
end;

procedure TDBXSybaseASEProperties.SetTDSPacketSize(const Value: Integer);
begin
  Values[StrTDSPacketSize] := IntToStr(Value);
end;

procedure TDBXSybaseASEProperties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXSybaseASEProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXSybaseASEProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXSybaseASEDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
end.
