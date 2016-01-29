{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DbxMySql"'}    {Do not Localize}
unit Data.DbxMySql;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxMySqlReadOnlyMetaData, Data.DbxMysqlMetaData;

type
  TDBXMySQLProperties = class(TDBXProperties)
  private
    const StrServerCharSet = 'ServerCharSet';
    function GetHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetBlobSize: Integer;
    function GetDatabase: string;
    function GetCompressed: Boolean;
    function GetEncrypted: Boolean;
    function GetServerCharSet: string;
    procedure SetServerCharSet(const Value: string);
    procedure SetCompressed(const Value: Boolean);
    procedure SetEncrypted(const Value: Boolean);
    procedure SetDatabase(const Value: string);
    procedure SetHostName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetBlobSize(const Value: Integer);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property HostName: string read GetHostName write SetHostName;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property Database: string read GetDatabase write SetDatabase;
    property BlobSize: Integer read GetBlobSize write SetBlobSize;
    property Compressed: Boolean read GetCompressed write SetCompressed;
    property Encrypted: Boolean read GetEncrypted write SetEncrypted;
    property ServerCharSet: string read GetServerCharSet write SetServerCharSet;
  end;

  TDBXMySQLDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;
  
const
  sDriverName = 'MySQL';

{ TDBXMySQLDriver }

constructor TDBXMySQLDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXMySQLProperties;
  I, Index: Integer;
begin
  Props := TDBXMySQLProperties.Create(DBXDriverDef.FDBXContext);
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

constructor TDBXMySQLProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXMySql';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXMySQLDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXMySqlMetaDataCommandFactory,DbxMySQLDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXMySqlMetaDataCommandFactory,Borland.Data.DbxMySQLDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverMYSQL';
  Values[TDBXPropertyNames.LibraryName] := 'dbxmys.dll';
  Values[TDBXPropertyNames.LibraryNameOsx] := 'libsqlmys.dylib';
  Values[TDBXPropertyNames.VendorLib] := 'libmysql.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'libmysql.dll';
  Values[TDBXPropertyNames.VendorLibOsx] := 'libmysqlclient.dylib';

  Values[TDBXPropertyNames.HostName] := 'ServerName';
  Values[TDBXPropertyNames.Database] := 'DBNAME';
  Values[TDBXPropertyNames.UserName] := 'user';
  Values[TDBXPropertyNames.Password] := 'password';

  Values[TDBXPropertyNames.MaxBlobSize] := '-1';
  Values[TDBXPropertyNames.ErrorResourceFile] := '';

  // Do we really us all of these?  Should they be moved to TDBXPropertyNames?
  //

  Values['ServerCharSet'] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXDynalinkPropertyNames.Compressed] := 'False';
  Values[TDBXDynalinkPropertyNames.Encrypted] := 'False';

end;

function TDBXMySqlProperties.GetBlobSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.MaxBlobSize], -1);
end;

function TDBXMySqlProperties.GetCompressed: Boolean;
begin
  Result := StrToBoolDef(Values[TDBXDynalinkPropertyNames.Compressed], False);
end;

function TDBXMySqlProperties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXMySqlProperties.GetEncrypted: Boolean;
begin
  Result := StrToBoolDef(Values[TDBXDynalinkPropertyNames.Encrypted], False);
end;

function TDBXMySqlProperties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXMySqlProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXMySQLProperties.GetServerCharSet: string;
begin
  Result := Values[StrServerCharSet];
end;

function TDBXMySqlProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXMySqlProperties.SetBlobSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.MaxBlobSize] := IntToStr(Value);
end;

procedure TDBXMySqlProperties.SetCompressed(const Value: Boolean);
begin
  Values[TDBXDynalinkPropertyNames.Compressed] := BoolToStr(Value, True);
end;

procedure TDBXMySqlProperties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;
procedure TDBXMySqlProperties.SetEncrypted(const Value: Boolean);
begin
  Values[TDBXDynalinkPropertyNames.Encrypted] := BoolToStr(Value, True);
end;

procedure TDBXMySqlProperties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXMySqlProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXMySQLProperties.SetServerCharSet(const Value: string);
begin
  Values[StrServerCharSet] := Value;
end;

procedure TDBXMySqlProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;


initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXMySQLDriver);
end.
