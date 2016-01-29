{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DBXMySqlReadOnlyMetaData"'}    {Do not Localize}
unit Data.DBXMySqlReadOnlyMetaData;

interface

uses
  Data.DBXMetaDataReader,
  Data.DBXClassRegistry,
  Data.DBXMetaDataCommandFactory;

type
  TDBXMySqlMetaDataCommandFactory = class(TDBXMetaDataCommandFactory)
  public
    function CreateMetaDataReader: TDBXMetaDataReader; override;
  end;

implementation

uses
  Data.DBXMySqlMetaDataReader;

function TDBXMySqlMetaDataCommandFactory.CreateMetaDataReader: TDBXMetaDataReader;
begin
  Result := TDBXMySqlMetaDataReader.Create;
end;

initialization
  TDBXMetaDataCommandFactory.RegisterMetaDataCommandFactory(TDBXMySqlMetaDataCommandFactory);
finalization
  TDBXMetaDataCommandFactory.UnRegisterMetaDataCommandFactory(TDBXMySqlMetaDataCommandFactory);
end.
