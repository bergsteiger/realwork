{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXOdbcMetaData;

interface

uses
  Data.DBXMetaDataWriterFactory,
  Data.DBXOdbcMetaDataWriter
  ;


implementation

initialization
  TDBXMetaDataWriterFactory.RegisterWriter('Odbc', TDBXOdbcMetaDataWriter);
finalization
  TDBXMetaDataWriterFactory.UnRegisterWriter('Odbc', TDBXOdbcMetaDataWriter);
end.
