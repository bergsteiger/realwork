{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetaDataWriterFactory;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.Generics.Defaults,
  Data.DBXMetaDataWriter
;

const
  SWriterPrefix = 'Borland.MetaDataWriter.';

type
  TDBXMetaDataWriterFactory = class
  private
    class var FProviderRegistry: TDictionary<string, TClass>;
  public
    class procedure RegisterWriter(DialectName: string; WriterClass: TClass);
    class procedure UnRegisterWriter(DialectName: string; WriterClass: TClass);
    class procedure FreeWriterRegistry;
    class function CreateWriter(DialectName: string): TDBXMetaDataWriter;
  end;

implementation

uses
  Data.DBXCommon,
  System.SysUtils,
  Data.DBXClassRegistry,
  Data.DBXCommonResStrs
;

{ TDBXMetaDataWriterFactory }

class function TDBXMetaDataWriterFactory.CreateWriter(
  DialectName: string): TDBXMetaDataWriter;
begin
  if not FProviderRegistry.ContainsKey(DialectName) then
    raise TDBXError.Create(TDBXErrorCodes.DriverInitFailed, Format(SNoMetadataProvider, [DialectName])+'  Add driver unit to your uses (DbxInterBase or DbxDb2 or DbxMsSql or DBXMySQL or DbxOracle or DbxSybaseASA or DbxSybaseASE)');
  Result := TClassRegistry.GetClassRegistry.CreateInstance(FProviderRegistry.Items[DialectName].ClassName) as TDBXMetaDataWriter;
  Result.Open;
end;

class procedure TDBXMetaDataWriterFactory.FreeWriterRegistry;
begin
  FProviderRegistry.Free;
end;

class procedure TDBXMetaDataWriterFactory.RegisterWriter(
  DialectName: string;
  WriterClass: TClass);
var
  ClassRegistry: TClassRegistry;
  ClassName: string;
begin
  FProviderRegistry.Add(DialectName, WriterClass);
  ClassRegistry := TClassRegistry.GetClassRegistry;
  ClassName := WriterClass.ClassName;
  if not ClassRegistry.HasClass(ClassName) then
    ClassRegistry.RegisterClass(ClassName, WriterClass);
end;

class procedure TDBXMetaDataWriterFactory.UnRegisterWriter(DialectName: string;
  WriterClass: TClass);
begin
  TClassRegistry.GetClassRegistry.UnregisterClass(WriterClass.ClassName);
end;

initialization
  TDBXMetaDataWriterFactory.FProviderRegistry := TDictionary<string, TClass>.Create(TIStringComparer.Ordinal);
finalization
  TDBXMetaDataWriterFactory.FreeWriterRegistry;

end.
