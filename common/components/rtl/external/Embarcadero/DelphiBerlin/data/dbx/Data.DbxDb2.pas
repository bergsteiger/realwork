{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxDb2;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxDb2ReadOnlyMetaData, Data.DbxDb2MetaData;

type
  TDBXDb2Properties = class(TDBXProperties)
  strict private
    const StrDb2TransIsolation = 'Db2 TransIsolation';
    const StrDecimalSeparator = 'Decimal Separator';
    function GetHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetBlobSize: Integer;
    function GetDatabase: string;
    function GetDB2TransIsolation: string;
    function GetDecimalSeparator: string;
    procedure SetBlobSize(const Value: Integer);
    procedure SetDatabase(const Value: string);
    procedure SetDB2TransIsolation(const Value: string);
    procedure SetDecimalSeparator(const Value: string);
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
    property DB2TransIsolation:string read GetDB2TransIsolation write SetDB2TransIsolation;
    property DecimalSeparator: string read GetDecimalSeparator write SetDecimalSeparator;
  end;

  TDBXDb2Driver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;

const
  sDriverName = 'Db2';

{ TDBXDb2Driver }

constructor TDBXDb2Driver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXDb2Properties;
  I, Index: Integer;
begin
  Props := TDBXDb2Properties.Create(DBXDriverDef.FDBXContext);
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


{ TDBXDb2Properties }

constructor TDBXDb2Properties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXDb2';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXDb2Driver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXDb2MetaDataCommandFactory,DBXDb2Driver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXDb2MetaDataCommandFactory,Borland.Data.DbxDb2Driver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverDB2';
  Values[TDBXPropertyNames.LibraryName] := 'dbxdb2.dll';
  Values[TDBXPropertyNames.VendorLib] := 'db2cli.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'db2cli64.dll';

  Values[TDBXPropertyNames.Database] := 'DBNAME';
  Values[TDBXPropertyNames.UserName] := 'user';
  Values[TDBXPropertyNames.Password] := 'password';

  Values[TDBXPropertyNames.MaxBlobSize] := '-1';
  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';
end;

function TDBXDb2Properties.GetBlobSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.MaxBlobSize], -1);
end;

function TDBXDb2Properties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXDb2Properties.GetDB2TransIsolation: string;
begin
  Result := Values[StrDb2TransIsolation];
end;

function TDBXDb2Properties.GetDecimalSeparator: string;
begin
  Result := Values[StrDecimalSeparator];
end;

function TDBXDb2Properties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXDb2Properties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXDb2Properties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXDb2Properties.SetBlobSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.MaxBlobSize] := IntToStr(Value);
end;

procedure TDBXDb2Properties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;

procedure TDBXDb2Properties.SetDB2TransIsolation(const Value: string);
begin
  Values[StrDb2Transisolation] := Value;
end;

procedure TDBXDb2Properties.SetDecimalSeparator(const Value: string);
begin
  Values[StrDecimalSeparator] := Value;
end;

procedure TDBXDb2Properties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXDb2Properties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXDb2Properties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXDb2Driver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
end.

