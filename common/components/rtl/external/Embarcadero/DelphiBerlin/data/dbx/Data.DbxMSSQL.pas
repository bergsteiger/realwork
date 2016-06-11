{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxMSSQL;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxMSSQLReadOnlyMetaData, Data.DbxMSSQLMetaData;

type
  TDBXMSSQLProperties = class(TDBXProperties)
  strict private
    const StrOSAuthentication = 'OS Authentication';
    const StrPrepareSQL = 'Prepare SQL';
    const StrMSSQLTransIsolation = 'MSSQL TransIsolation';
    function GetBlobSize: Integer;
    function GetMSSQLTransIsolation: string;
    function GetOSAuthentication: Boolean;
    function GetPrepareSql: Boolean;
    function GetSchemaOverride: string;
    function GetDatabase: string;
    procedure SetDatabase(const Value: string);
    procedure SetBlobSize(const Value: Integer);
    procedure SetMSSQLTransIsolation(const Value: string);
    procedure SetOSAuthentication(const Value: Boolean);
    procedure SetPrepareSql(const Value: Boolean);
    procedure SetSchemaOverride(const Value: string);
    function GetHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    procedure SetHostName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property HostName: string read GetHostName write SetHostName;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property SchemaOverride: string read GetSchemaOverride write SetSchemaOverride;
    property BlobSize: Integer read GetBlobSize write SetBlobSize;
    property MSSQLTransIsolation: string read GetMSSQLTransIsolation write SetMSSQLTransIsolation;
    property OSAuthentication: Boolean read GetOSAuthentication write SetOSAuthentication;
    property PrepareSQL: Boolean read GetPrepareSql write SetPrepareSql;
    property Database: string read GetDatabase write SetDatabase;
  end;

  TDBXMSSQLDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;

const
  sDriverName = 'MSSQL';
  sAltDriverName = 'MSSQL9';

{ TDBXMSSQLDriver }

constructor TDBXMSSQLDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXMSSQLProperties;
  I, Index: Integer;
begin
  Props := TDBXMSSQLProperties.Create(DBXDriverDef.FDBXContext);
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


{ TDBXMSSQLProperties }

constructor TDBXMSSQLProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.SchemaOverride] := '%.dbo';
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXMsSQL';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXMSSQLDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXMsSqlMetaDataCommandFactory,Borland.Data.DbxMSSQLDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverMSSQL';
  Values[TDBXPropertyNames.LibraryName] := 'dbxmss.dll';
  Values[TDBXPropertyNames.VendorLib] := 'sqlncli10.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'sqlncli10.dll';

  Values[TDBXPropertyNames.HostName] := 'ServerName';
  Values[TDBXPropertyNames.Database] := 'Database Name';
//  Values[TDBXPropertyNames.UserName] := 'user';
//  Values[TDBXPropertyNames.Password] := 'password';

  Values[TDBXPropertyNames.MaxBlobSize] := '-1';
  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';

  Values['OSAuthentication'] := 'False';
  Values['PrepareSQL'] := 'True';

end;

function TDBXMSSQLProperties.GetBlobSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.MaxBlobSize], -1);
end;

function TDBXMSSQLProperties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXMSSQLProperties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXMSSQLProperties.GetMSSQLTransIsolation: string;
begin
  Result := Values[StrMSSQLTransIsolation];
end;

function TDBXMSSQLProperties.GetOSAuthentication: Boolean;
begin
  Result := StrToBoolDef(Values[StrOSAuthentication], False);
end;

function TDBXMSSQLProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXMSSQLProperties.GetPrepareSql: Boolean;
begin
  Result := StrToBoolDef(Values[StrPrepareSQL], False);
end;

function TDBXMSSQLProperties.GetSchemaOverride: string;
begin
  Result := Values[TDBXPropertyNames.SchemaOverride];
end;

function TDBXMSSQLProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXMSSQLProperties.SetBlobSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.MaxBlobSize] := IntToStr(Value);
end;

procedure TDBXMSSQLProperties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;

procedure TDBXMSSQLProperties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXMSSQLProperties.SetMSSQLTransIsolation(const Value: string);
begin
  Values[StrMSSQLTransIsolation] := Value;
end;

procedure TDBXMSSQLProperties.SetOSAuthentication(const Value: Boolean);
begin
  Values[StrOSAuthentication] := BoolToStr(Value, True);
end;

procedure TDBXMSSQLProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXMSSQLProperties.SetPrepareSql(const Value: Boolean);
begin
  Values[StrPrepareSql] := BoolToStr(Value, True);
end;

procedure TDBXMSSQLProperties.SetSchemaOverride(const Value: string);
begin
  Values[TDBXPropertyNames.SchemaOverride] := Value;
end;

procedure TDBXMSSQLProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXMSSQLDriver);
  TDBXDriverRegistry.RegisterDriverClass(sAltDriverName, TDBXMSSQLDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
  TDBXDriverRegistry.UnloadDriver(sAltDriverName);
end.
