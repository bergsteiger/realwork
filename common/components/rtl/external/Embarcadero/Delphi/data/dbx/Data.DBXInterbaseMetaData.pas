{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DBXInterbaseMetaData"'}    {Do not Localize}
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
