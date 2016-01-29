{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DBXMySqlMetaData"'}    {Do not Localize}
unit Data.DBXMySqlMetaData;

interface

uses
  Data.DBXMetaDataWriterFactory,
  Data.DBXMySqlMetaDataWriter
  ;


implementation

initialization
  TDBXMetaDataWriterFactory.RegisterWriter('MySQL', TDBXMySqlMetaDataWriter);
finalization
  TDBXMetaDataWriterFactory.UnRegisterWriter('MySQL', TDBXMySqlMetaDataWriter);
end.
