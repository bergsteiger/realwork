{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXOdbcReadOnlyMetaData;

interface

uses
  Data.DBXCommon,
  Data.DBXOdbc,
  Data.DBXMetaDataReader,
  Data.DBXMetaDataCommandFactory;

type
  TDBXOdbcMetaDataCommandFactory = class(TDBXMetaDataCommandFactory)
  public
    function CreateCommand(DbxContext: TDBXContext; Connection: TDBXConnection;
      MorphicCommand: TDBXCommand): TDBXCommand; override;
    function CreateMetaDataReader: TDBXMetaDataReader; overload; override;
    function CreateMetaDataReader(OdbcConnection: TDBXOdbcConnection): TDBXMetaDataReader; reintroduce; overload;
  end;

implementation

uses
  Data.DBXOdbcMetaDataReader;

function TDBXOdbcMetaDataCommandFactory.CreateCommand(DbxContext: TDBXContext; Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
var
  Reader: TDBXMetaDataReader;
  ProviderContext: TDBXDataExpressProviderContext;
begin
  Reader := TDBXMetaDataReader(TDBXDriverHelp.GetMetaDataReader(Connection));
  if Reader = nil then
  begin
    Reader := CreateMetaDataReader(TDBXOdbcConnection(Connection));
    ProviderContext := TDBXDataExpressProviderContext.Create;
    ProviderContext.Connection := Connection;
    ProviderContext.UseAnsiStrings := TDBXProviderContext.UseAnsiString(Reader.ProductName);
    ProviderContext.RemoveIsNull := True;
    Reader.Context := ProviderContext;
    Reader.Version := TDBXConnection(Connection).ProductVersion;
    TDBXDriverHelp.SetMetaDataReader(Connection, Reader);
  end;
  Result := TDBXMetaDataCommand.Create(DBXContext, MorphicCommand, Reader);
end;

function TDBXOdbcMetaDataCommandFactory.CreateMetaDataReader: TDBXMetaDataReader;
begin
  Result := TDBXOdbcMetaDataReader.Create;
end;

function TDBXOdbcMetaDataCommandFactory.CreateMetaDataReader(OdbcConnection: TDBXOdbcConnection): TDBXMetaDataReader;
begin
  Result := TDBXOdbcMetaDataReader.Create(OdbcConnection);
end;

initialization
  TDBXMetaDataCommandFactory.RegisterMetaDataCommandFactory(TDBXOdbcMetaDataCommandFactory);
finalization
  TDBXMetaDataCommandFactory.UnRegisterMetaDataCommandFactory(TDBXOdbcMetaDataCommandFactory);
end.
