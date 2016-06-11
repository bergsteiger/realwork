{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
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
