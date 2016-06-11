{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSHTTPServiceProxyDispatcher;

interface

uses
  Datasnap.DSClientMetadata,
  Datasnap.DSHTTP,
  Datasnap.DSHTTPCommon,
  System.Classes,
  System.Generics.Collections;

type
  /// <summary>Proxy dispatcher for DataSnap servers that are not based on
  /// WebBroker.</summary>
  TDSHTTPServiceProxyDispatcher = class(TDSHTTPServiceFileDispatcher)
  private
  var
    FRequiredProxyFilesPath: string;
    FAvailableProxies: TDictionary<string, string>;
    FDSProxyGenerator: TDSProxyGenerator;
    procedure CreateZipFile(LanguageRequiredFiles, Filename: string);
    function isSupportedProxy(const Language: string;
      out WriterID: string): Boolean;
    function GetLanguage(const AFileName: string): string;
    procedure SetRequiredProxyFilesPath(const Value: string);
    procedure SetDSProxyGenerator(const Value: TDSProxyGenerator);
    procedure BuildAvailableProxies;
    function IsRequiredProxyFilesPathStored: Boolean;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoBeforeDispatch(Sender: TObject; const AFileName: string;
      AContext: TDSHTTPContext; Request: TDSHTTPRequest;
      Response: TDSHTTPResponse; var Handled: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    /// <summary>
    /// The TDSProxyGenerator instance to use
    /// </summary>
    property DSProxyGenerator: TDSProxyGenerator read FDSProxyGenerator
      write SetDSProxyGenerator;
    /// <summary>
    /// Represents the full path where are the required proxy files
    /// </summary>
    [Stored('IsRequiredProxyFilesPathStored'), nodefault]
    property RequiredProxyFilesPath: string read FRequiredProxyFilesPath
      write SetRequiredProxyFilesPath stored IsRequiredProxyFilesPathStored nodefault;
  end;

implementation

uses
  Datasnap.DSProxyWriter,
  Datasnap.DSProxyUtils,
  System.StrUtils,
  System.SysUtils,
  System.Types,
  Web.HTTPApp,
  Web.WebFileDispatcher;

{ TDSHTTPServiceProxyDispatcher }

constructor TDSHTTPServiceProxyDispatcher.Create(AOwner: TComponent);
begin
  inherited;
  RootDirectory := '.';
  WebDirectories.Clear;
  WebFileExtensions.Clear;
  TWebDirectoryItem.Create(WebDirectories, dirInclude, '\proxy\*');
  TWebDirectoryItem.Create(WebDirectories, dirExclude, '\proxy\*\*');
  RequiredProxyFilesPath := 'proxy';
  TWebFileExtensionItem.Create(WebFileExtensions,
    'application/x-zip-compressed', 'zip');
end;

procedure TDSHTTPServiceProxyDispatcher.CreateZipFile(LanguageRequiredFiles,
  Filename: string);
begin
  TDSProxyUtils.CompressDirectory(LanguageRequiredFiles, Filename);
end;

procedure TDSHTTPServiceProxyDispatcher.BuildAvailableProxies;
var
  writer: String;
  WriterProxy: TDSProxyWriter;
begin
  if not assigned(FAvailableProxies) then
  begin
    FAvailableProxies := TDictionary<string, string>.Create;
    for writer in TDSProxyWriterFactory.RegisteredWritersList do
    begin
      WriterProxy := TDSProxyWriterFactory.GetWriter(writer);
      try
        FAvailableProxies.AddOrSetValue(WriterProxy.Properties.Language, writer);
      finally
        WriterProxy.Free;
      end;
    end;
  end;
end;

function TDSHTTPServiceProxyDispatcher.isSupportedProxy(const Language: string;
  out WriterID: string): Boolean;
begin
  BuildAvailableProxies;
  Result := FAvailableProxies.TryGetValue(Language, WriterID);
end;

procedure TDSHTTPServiceProxyDispatcher.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDSProxyGenerator) then
    FDSProxyGenerator := nil;
end;

function TDSHTTPServiceProxyDispatcher.GetLanguage(const AFileName
  : string): string;
var
  a: TStringDynArray;
begin
  a := SplitString(LowerCase(AFileName), '.');
  Result := a[0];
end;

procedure TDSHTTPServiceProxyDispatcher.DoBeforeDispatch(Sender: TObject;
  const AFileName: string; AContext: TDSHTTPContext; Request: TDSHTTPRequest;
  Response: TDSHTTPResponse; var Handled: Boolean);
var
  D1, D2: TDateTime;
  Language, WriterID: string;
  Filename, LanguageRequiredFiles, OutputProxyDir: string;
  MustGenerateProxy: Boolean;
begin

  Response.ContentType := 'application/octet-stream';
  Handled := False;
  try
    Filename := WebApplicationDirectory + RequiredProxyFilesPath + '\' +
      ExtractFileName(AFileName);
    if assigned(FDSProxyGenerator) then
    begin
      Language := GetLanguage(ExtractFileName(Filename));
      if isSupportedProxy(Language, WriterID) then
      begin
        MustGenerateProxy := False;

        if not FileExists(Filename) then
          MustGenerateProxy := True;

        if not MustGenerateProxy then // the file exists
          // check for older generated proxy
          MustGenerateProxy := FileAge(Filename, D1) and
            FileAge(WebApplicationFileName, D2) and (D1 < D2);

        if MustGenerateProxy then
        begin

          FDSProxyGenerator.writer := WriterID;
          if DirectoryExists(FRequiredProxyFilesPath) then // full path
            LanguageRequiredFiles := IncludeTrailingPathDelimiter
              (FRequiredProxyFilesPath) + Language
          else // try with a relative path
            LanguageRequiredFiles := WebApplicationDirectory +
              FRequiredProxyFilesPath + '\' + Language;
          OutputProxyDir := LanguageRequiredFiles + '\' +
            FDSProxyGenerator.WriterProperties.Comment;
          FDSProxyGenerator.TargetDirectory := OutputProxyDir;
          FDSProxyGenerator.TargetUnitName := 'DSProxy' +
            FDSProxyGenerator.FileDescriptions[0].DefaultFileExt;
          FDSProxyGenerator.Write;
          DeleteFile(Filename);
          CreateZipFile(LanguageRequiredFiles, Filename);

        end;
      end
      else
        raise Exception.Create('Language not supported');
    end;
  except
    on E: EFCreateError do
    begin
      Handled := True;
      Response.ResponseNo := 500;
      Response.ContentType := 'text/plain';
      Response.ResponseText := 'Cannot create proxy file';
    end;
    on E: Exception do
    begin
      Handled := True;
      Response.ResponseNo := 500;
      Response.ContentType := 'text/plain';
      Response.ResponseText := E.Message;
    end;
  end;

end;

function TDSHTTPServiceProxyDispatcher.IsRequiredProxyFilesPathStored: Boolean;
begin
  Result := not SameText(FRequiredProxyFilesPath, 'Proxy');
end;

procedure TDSHTTPServiceProxyDispatcher.SetDSProxyGenerator
  (const Value: TDSProxyGenerator);
begin
  FDSProxyGenerator := Value;
end;

procedure TDSHTTPServiceProxyDispatcher.SetRequiredProxyFilesPath
  (const Value: string);
begin
  FRequiredProxyFilesPath := Value;
end;

end.
