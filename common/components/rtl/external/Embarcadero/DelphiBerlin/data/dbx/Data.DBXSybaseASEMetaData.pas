{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXSybaseASEMetaData;

interface

uses
  Data.DBXMetaDataWriterFactory,
  Data.DBXSybaseASEMetaDataWriter
  ;


implementation

initialization
  TDBXMetaDataWriterFactory.RegisterWriter('Sybase SQL Server', TDBXSybaseASEMetaDataWriter); {Do not localize}
finalization
  TDBXMetaDataWriterFactory.UnRegisterWriter('Sybase SQL Server', TDBXSybaseASEMetaDataWriter); {Do not localize}
end.
