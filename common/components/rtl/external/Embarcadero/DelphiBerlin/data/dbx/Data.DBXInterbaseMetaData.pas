{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXInterbaseMetaData;

interface

uses
  Data.DBXMetaDataWriterFactory,
  Data.DBXInterbaseMetaDataWriter
  ;


implementation

initialization
  TDBXMetaDataWriterFactory.RegisterWriter('Interbase', TDBXInterbaseMetaDataWriter);
finalization
  TDBXMetaDataWriterFactory.UnRegisterWriter('Interbase', TDBXInterbaseMetaDataWriter);
end.
