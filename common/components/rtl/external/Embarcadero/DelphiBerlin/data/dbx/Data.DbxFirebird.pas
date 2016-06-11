{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxFirebird;

interface

uses
  Data.DBXDynalink,
  Data.DBXDynalinkNative,
  Data.DBXCommon, Data.DbxFirebirdReadOnlyMetaData, Data.DbxFirebirdMetaData;

type
  TDBXFirebirdProperties = class(TDBXProperties)
  strict private
    const StrServerCharSet = 'ServerCharSet';
    function GetDatabase: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetServerCharSet: string;
    procedure SetServerCharSet(const Value: string);
    procedure SetDatabase(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property Database: string read GetDatabase write SetDatabase;
    property UserName: string read GetUserName write SetUserName;
    property Password: string read GetPassword write SetPassword;
    property ServerCharSet: string read GetServerCharSet write SetServerCharSet;
  end;

  TDBXFirebirdDriver = class(TDBXDynalinkDriverNative)
  public
    constructor Create(DBXDriverDef: TDBXDriverDef); override;
end;

implementation

uses
  Data.DBXCommonResStrs, Data.DBXPlatform, System.SysUtils;

const
  sDriverName = 'Firebird';

{ TDBXFirebirdDriver }

constructor TDBXFirebirdDriver.Create(DBXDriverDef: TDBXDriverDef);
var
  Props: TDBXFirebirdProperties;
  I, Index: Integer;
begin
  Props := TDBXFirebirdProperties.Create(DBXDriverDef.FDBXContext);
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

{ TDBXFirebirdProperties }

constructor TDBXFirebirdProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXFirebird';
  Values[TDBXPropertyNames.DriverPackageLoader] := 'TDBXDynalinkDriverLoader,DBXFirebirdDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.DriverAssemblyLoader] := 'Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;
  Values[TDBXPropertyNames.MetaDataPackageLoader] := 'TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver' + PackageVersion + '.bpl';
  Values[TDBXPropertyNames.MetaDataAssemblyLoader] := 'Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=' + AssemblyVersion + ',Culture=neutral,PublicKeyToken=' + TDBXPlatform.GetPublicKeyToken;

  Values[TDBXPropertyNames.GetDriverFunc] := 'getSQLDriverINTERBASE';
  Values[TDBXPropertyNames.LibraryName] := 'dbxfb.dll';
  Values[TDBXPropertyNames.LibraryNameOsx] := 'libsqlfb.dylib';
  Values[TDBXPropertyNames.VendorLib] := 'fbclient.dll';
  Values[TDBXPropertyNames.VendorLibWin64] := 'fbclient.dll';
  Values[TDBXPropertyNames.VendorLibOsx] := '/Library/Frameworks/Firebird.framework/Firebird';

  Values[TDBXPropertyNames.Database] := 'database.fdb';
  Values[TDBXPropertyNames.UserName] := 'sysdba';
  Values[TDBXPropertyNames.Password] := 'masterkey';


  Values[TDBXPropertyNames.Role] := 'RoleName';
  Values[TDBXPropertyNames.MaxBlobSize] := '-1';

  Values[TDBXPropertyNames.ErrorResourceFile] := '';
  Values[TDBXDynalinkPropertyNames.LocaleCode] := '0000';
  Values[TDBXPropertyNames.IsolationLevel] := 'ReadCommitted';

  Values['ServerCharSet'] := '';
  Values['SQLDialect'] := '3';
  Values['CommitRetain'] := 'False';
  Values['WaitOnLocks'] := 'True';
  Values['TrimChar'] := 'False';
end;

function TDBXFirebirdProperties.GetDatabase: string;
begin
  Result := Values[TDBXPropertyNames.Database];
end;

function TDBXFirebirdProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;

function TDBXFirebirdProperties.GetServerCharSet: string;
begin
  Result := Values[StrServerCharSet];
end;

function TDBXFirebirdProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

procedure TDBXFirebirdProperties.SetDatabase(const Value: string);
begin
  Values[TDBXPropertyNames.Database] := Value;
end;

procedure TDBXFirebirdProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXFirebirdProperties.SetServerCharSet(const Value: string);
begin
  Values[StrServerCharSet] := Value;
end;

procedure TDBXFirebirdProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXFirebirdDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);

end.
