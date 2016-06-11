{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxOracle;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxOracleReadOnlyMetaData, Data.DbxOracleMetaData;

type
  TDBXOracleProperties = class(TDBXProperties)
  strict private
    const StrOSAuthentication = 'OS Authentication';
    const StrOracleTransIsolation = 'Oracle TransIsolation';
    const StrDecimalSeparator = 'Decimal Separator';
    const StrTrimChar = 'Trim Char';
    const StrMultipleTransaction = 'Multiple Transaction';
    const StrRowsetSize = 'RowsetSize';
    function GetHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetBlobSize: Integer;
    function GetDatabase: string;
    function GetOracleTransIsolation: string;
    function GetDecimalSeparator: string;
    function GetTrimChar: Boolean;
    function GetRowsetSize: Integer;
    function GetOSAuthentication: Boolean;
    function GetMultipleTransaction: Boolean;
    procedure SetMultipleTransaction(const Value: Boolean);
    procedure SetOSAuthentication(const Value: Boolean);
    procedure SetRowsetSize(const Value: Integer);
    procedure SetBlobSize(const Value: Integer);
    procedure SetDatabase(const Value: string);
    procedure SetOracleTransIsolation(const Value: string);
    procedure SetDecimalSeparator(const Value: string);
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
    property OracleTransIsolation:string read GetOracleTransIsolation write SetOracleTransIsolation;
    property DecimalSeparator: string read GetDecimalSeparator write SetDecimalSeparator;
    property OSAuthentication: Boolean read GetOSAuthentication write SetOSAuthentication;
    property TrimChar: Boolean read GetTrimChar write SetTrimChar;
    property RowsetSize: Integer read GetRowsetSize write SetRowsetSize;
    property MultipleTransaction: Boolean read GetMultipleTransaction write SetMultipleTransaction;
  end;

  TDBXOracleDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;
  
const
  sDriverName = 'Oracle';

{ TDBXOracleDriver }

constructor TDBXOracleDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXOracleProperties;
  I, Index: Integer;
begin
  Props := TDBXOracleProperties.Create(DBXDriverDef.FDBXContext);
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

{ TDBXOracleProperties }

constructor TDBXOracleProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXOracle';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXOracleDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXOracleMetaDataCommandFactory,DbxOracleDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXOracleMetaDataCommandFactory,Borland.Data.DbxOracleDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverORACLE';
  Values[TDBXPropertyNames.LibraryName] := 'dbxora.dll';
  Values[TDBXPropertyNames.LibraryNameOsx] := 'libsqlora.dylib';
  Values[TDBXPropertyNames.VendorLib] := 'oci.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'oci.dll';
  Values[TDBXPropertyNames.VendorLibOsx] := 'libociei.dylib';

  Values[TDBXPropertyNames.Database] := 'Database Name';
  Values[TDBXPropertyNames.UserName] := 'user';
  Values[TDBXPropertyNames.Password] := 'password';

  Values[TDBXPropertyNames.MaxBlobSize] := '-1';
  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';

  Values['RowSetSize'] := '20';
  Values['OSAuthentication'] := 'False';
  Values['MultipleTransactions'] := 'False';
  Values['TrimChar'] := 'False';
end;

function TDBXOracleProperties.GetBlobSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.MaxBlobSize], -1);
end;

function TDBXOracleProperties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXOracleProperties.GetOracleTransIsolation: string;
begin
  Result := Values[StrOracleTransIsolation];
end;

function TDBXOracleProperties.GetDecimalSeparator: string;
begin
  Result := Values[StrDecimalSeparator];
end;

function TDBXOracleProperties.GetOSAuthentication: Boolean;
begin
  Result := StrToBoolDef(Values[StrOSAuthentication], False);
end;

function TDBXOracleProperties.GetTrimChar: Boolean;
begin
  Result := StrToBoolDef(Values[StrTrimChar], False);
end;

function TDBXOracleProperties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXOracleProperties.GetMultipleTransaction: Boolean;
begin
  Result := StrToBoolDef(Values[StrMultipleTransaction], False);
end;

function TDBXOracleProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXOracleProperties.GetRowsetSize: Integer;
begin
  Result := StrToIntDef(Values[StrRowsetSize], 20);
end;

function TDBXOracleProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXOracleProperties.SetBlobSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.MaxBlobSize] := IntToStr(Value);
end;

procedure TDBXOracleProperties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;

procedure TDBXOracleProperties.SetOracleTransIsolation(const Value: string);
begin
  Values[StrOracleTransisolation] := Value;
end;

procedure TDBXOracleProperties.SetDecimalSeparator(const Value: string);
begin
  Values[StrDecimalSeparator] := Value;
end;

procedure TDBXOracleProperties.SetOSAuthentication(const Value: Boolean);
begin
  Values[StrOSAuthentication] := BoolToStr(Value, True);
end;

procedure TDBXOracleProperties.SetTrimChar(const Value: Boolean);
begin
  Values[StrTrimChar] := BoolToStr(Value, True);
end;
procedure TDBXOracleProperties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXOracleProperties.SetMultipleTransaction(
  const Value: Boolean);
begin
  Values[StrMultipleTransaction] := BoolToStr(Value, True);
end;

procedure TDBXOracleProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXOracleProperties.SetRowsetSize(const Value: Integer);
begin
  Values[StrRowsetSize] := IntToStr(Value);
end;

procedure TDBXOracleProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXOracleDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
end.
