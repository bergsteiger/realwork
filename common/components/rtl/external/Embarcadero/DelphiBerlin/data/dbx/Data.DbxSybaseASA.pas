{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxSybaseASA;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxSybaseASAReadOnlyMetaData, Data.DbxSybaseASAMetaData;

type
  TDBXSybaseASAProperties = class(TDBXProperties)
  strict private
    const StrASATransIsolation = 'ASA TransIsolation';
    function GetHostName: string;
    function GetDBHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetBlobSize: Integer;
    function GetSybaseASATransIsolation: string;
    procedure SetBlobSize(const Value: Integer);
    procedure SetSybaseASATransIsolation(const Value: string);
    procedure SetHostName(const Value: string);
    procedure SetDBHostName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property HostName: string read GetHostName write SetHostName;
    property DBHostName: string read GetDBHostName write SetDBHostName;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property BlobSize: Integer read GetBlobSize write SetBlobSize;
    property SybaseASATransIsolation:string read GetSybaseASATransIsolation write SetSybaseASATransIsolation;
  end;

  TDBXSybaseASADriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;

const
  sDriverName = 'ASA';

{ TDBXSybaseASADriver }

constructor TDBXSybaseASADriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXSybaseASAProperties;
  I, Index: Integer;
begin
  Props := TDBXSybaseASAProperties.Create(DBXDriverDef.FDBXContext);
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
  rpr;
end;

{ TDBXSybaseASAProperties }

constructor TDBXSybaseASAProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DbxSybaseASA';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXSybaseASADriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXSybaseASAMetaDataCommandFactory,DbxSybaseASADriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXSybaseASAMetaDataCommandFactory,Borland.Data.DbxSybaseASADriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverASA';
  Values[TDBXPropertyNames.LibraryName] := 'dbxasa.dll';
  Values[TDBXPropertyNames.LibraryNameOsx] := 'libsqlasa.dylib';
  Values[TDBXPropertyNames.VendorLib] := 'dbodbc*.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'dbodbc*.dll';
  Values[TDBXPropertynames.VendorLibOsx] := 'libdbodbc12.dylib';

  Values[TDBXPropertyNames.HostName] := 'ServerName';
  Values[TDBXPropertyNames.DBHostName] := '';
  Values[TDBXPropertyNames.Database] := 'DBNAME';
  Values[TDBXPropertyNames.UserName] := 'user';
  Values[TDBXPropertyNames.Password] := 'password';

  Values[TDBXPropertyNames.MaxBlobSize] := '-1';
  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';

  Values['ConnectionString'] := '';
end;

function TDBXSybaseASAProperties.GetBlobSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.MaxBlobSize], -1);
end;

function TDBXSybaseASAProperties.GetSybaseASATransIsolation: string;
begin
  Result := Values[StrASATransIsolation];
end;
function TDBXSybaseASAProperties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXSybaseASAProperties.GetDBHostName: string;
begin
  Result := Values[TDBXPropertyNames.DBHostName];
end;

function TDBXSybaseASAProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXSybaseASAProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXSybaseASAProperties.SetBlobSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.MaxBlobSize] := IntToStr(Value);
end;

procedure TDBXSybaseASAProperties.SetSybaseASATransIsolation(const Value: string);
begin
  Values[StrASATransIsolation] := Value;
end;
procedure TDBXSybaseASAProperties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXSybaseASAProperties.SetDBHostName(const Value: string);
begin
  Values[TDBXPropertyNames.DBHostName] := Value;
end;

procedure TDBXSybaseASAProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXSybaseASAProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXSybaseASADriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
end.
