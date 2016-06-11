{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyJavaBlackBerry;

interface

const
  sJavaBlackBerryRESTProxyWriter = 'Java (Black Berry) REST';

implementation

uses
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyWriter,
  Datasnap.DSProxyJavaAndroid,
  System.Classes,
  System.SysUtils;

type
  TDSClientProxyWriterJavaBlackBerry = class(TDSProxyWriter)
  public
    function CreateProxyWriter: TDSCustomProxyWriter; override;
    function Properties: TDSProxyWriterProperties; override;
    function FileDescriptions: TDSProxyFileDescriptions; override;
  end;

  TDSCustomJavaBlackBerryProxyWriter = class (TDSCustomJavaAndroidProxyWriter)
  protected
    procedure WriteInterface; override;
  end;

  TDSJavaBlackBerryProxyWriter = class(TDSCustomJavaBlackBerryProxyWriter)
  private
    FStreamWriter: TStreamWriter;
  protected
    procedure DerivedWrite(const Line: string); override;
    procedure DerivedWriteLine; override;
  public
    property StreamWriter: TStreamWriter read FStreamWriter write FStreamWriter;
  end;


const
  sDSProxyJavaBlackBerryLanguage = 'java_blackberry';

  { TDSClientProxyWriterJavaBlackBerry }

function TDSClientProxyWriterJavaBlackBerry.CreateProxyWriter
  : TDSCustomProxyWriter;
begin
  Result := TDSJavaBlackBerryProxyWriter.Create;
end;

function TDSClientProxyWriterJavaBlackBerry.FileDescriptions
  : TDSProxyFileDescriptions;
begin
  SetLength(Result, 1);
  Result[0].ID := sImplementation; // do not localize
  Result[0].DefaultFileExt := '.java';
end;

function TDSClientProxyWriterJavaBlackBerry.Properties
  : TDSProxyWriterProperties;
begin
  Result.UsesUnits := 'Datasnap.DSProxyJavaBlackBerry';
  Result.DefaultExcludeClasses := sDSMetadataClassName+ ',' + sDSAdminClassName; // do not localize
  Result.DefaultExcludeMethods := sASMethodsPrefix;
  Result.Author := 'Embarcadero'; // do not localize
  Result.Comment := 'com\embarcadero\javablackberry'; // do not localize
  Result.Language := sDSProxyJavaBlackBerryLanguage;
  Result.Features := [feRESTClient];
  Result.DefaultEncoding := TEncoding.UTF8;
end;

{ TDSCustomJavaBlackBerryProxyWriter }


procedure TDSCustomJavaBlackBerryProxyWriter.WriteInterface;
begin
  WriteLine('package com.embarcadero.javablackberry;');
  WriteLine;
  WriteLine('import java.util.Date;');
  WriteLine;
end;

{ TDSJavaBlackBerryProxyWriter }

procedure TDSJavaBlackBerryProxyWriter.DerivedWrite(const Line: string);
begin
  if StreamWriter <> nil then
    StreamWriter.Write(Line)
  else
    ProxyWriters[sImplementation].Write(Line);
end;

procedure TDSJavaBlackBerryProxyWriter.DerivedWriteLine;
begin
  if StreamWriter <> nil then
    StreamWriter.WriteLine
  else
    ProxyWriters[sImplementation].WriteLine;
end;

initialization

TDSProxyWriterFactory.RegisterWriter(sJavaBlackBerryRESTProxyWriter,
  TDSClientProxyWriterJavaBlackBerry);

finalization

TDSProxyWriterFactory.UnregisterWriter(sJavaBlackBerryRESTProxyWriter);

end.
