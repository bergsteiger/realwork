{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXFirebirdMetaData;

interface

uses
  Data.DBXMetaDataWriterFactory,
  Data.DBXFirebirdMetaDataWriter
  ;


implementation

initialization
  TDBXMetaDataWriterFactory.RegisterWriter('Firebird', TDBXFirebirdMetaDataWriter);
finalization
  TDBXMetaDataWriterFactory.UnRegisterWriter('Firebird', TDBXFirebirdMetaDataWriter);
end.
