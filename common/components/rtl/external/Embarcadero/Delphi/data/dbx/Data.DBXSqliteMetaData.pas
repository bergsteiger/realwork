{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DBXSqliteMetaData"'}    {Do not Localize}
unit Data.DBXSqliteMetaData;

interface

uses
  Data.DBXMetaDataWriterFactory,
  Data.DBXSqliteMetaDataWriter;

implementation

initialization
  TDBXMetaDataWriterFactory.RegisterWriter('Sqlite', TDBXSqliteMetaDataWriter);
finalization
  TDBXMetaDataWriterFactory.UnRegisterWriter('Sqlite', TDBXSqliteMetaDataWriter);
end.
