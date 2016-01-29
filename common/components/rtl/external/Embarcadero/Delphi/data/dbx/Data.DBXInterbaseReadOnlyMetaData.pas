{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DBXInterbaseReadOnlyMetaData"'}    {Do not Localize}
unit Data.DBXInterbaseReadOnlyMetaData;

interface

uses
  Data.DBXMetaDataReader,
  Data.DBXMetaDataCommandFactory;

type
  TDBXInterbaseMetaDataCommandFactory = class(TDBXMetaDataCommandFactory)
  public
    function CreateMetaDataReader: TDBXMetaDataReader; override;
  end;

implementation

uses
  Data.DBXInterbaseMetaDataReader;

function TDBXInterbaseMetaDataCommandFactory.CreateMetaDataReader: TDBXMetaDataReader;
begin
  Result := TDBXInterbaseMetaDataReader.Create;
end;

initialization
  TDBXMetaDataCommandFactory.RegisterMetaDataCommandFactory(TDBXInterbaseMetaDataCommandFactory);
finalization
  TDBXMetaDataCommandFactory.UnRegisterMetaDataCommandFactory(TDBXInterbaseMetaDataCommandFactory);
end.
