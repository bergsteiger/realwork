{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DBXSqliteReadOnlyMetaData"'}    {Do not Localize}
unit Data.DBXSqliteReadOnlyMetaData;

interface

uses
  Data.DBXMetaDataCommandFactory, Data.DBXMetaDataReader;

type
  TDBXSqliteMetaDataCommandFactory = class(TDBXMetaDataCommandFactory)
  public
    function CreateMetaDataReader: TDBXMetaDataReader; override;
  end;

implementation

uses
  Data.DbxSqliteMetaDataReader;

function TDBXSqliteMetaDataCommandFactory.CreateMetaDataReader: TDBXMetaDataReader;
begin
  Result := TDBXSqliteMetaDataReader.Create;
end;

initialization
  TDBXMetaDataCommandFactory.RegisterMetaDataCommandFactory(TDBXSqliteMetaDataCommandFactory);
finalization
  TDBXMetaDataCommandFactory.UnRegisterMetaDataCommandFactory(TDBXSqliteMetaDataCommandFactory);

end.
