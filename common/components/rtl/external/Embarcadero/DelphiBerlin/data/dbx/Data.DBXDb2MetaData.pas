{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXDb2MetaData;

interface

uses
  Data.DBXMetaDataWriterFactory,
  Data.DBXDb2MetaDataWriter
  ;


implementation

initialization
  TDBXMetaDataWriterFactory.RegisterWriter('Db2', TDBXDb2MetaDataWriter);
finalization
  TDBXMetaDataWriterFactory.UnRegisterWriter('Db2', TDBXDb2MetaDataWriter);
end.
