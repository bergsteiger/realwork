{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSClientMetadata;

interface

uses
  System.Classes,
  Datasnap.DSClientRest,
  Datasnap.DSCommonProxy,
  Datasnap.DSProxyWriter,
  DataSnap.DSMetadata,
  System.Generics.Collections,
  System.SysUtils;

type
  TDSRestMetaDataProvider = class(TDSCustomMetaDataProvider)
  private
    [Weak]FConnection: TDSCustomRestConnection;
    procedure SetConnection(const Value: TDSCustomRestConnection);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HasProvider: Boolean; override;
    function GetProvider: IDSProxyMetaDataLoader; override;
  published
    property RestConnection: TDSCustomRestConnection read FConnection write SetConnection;
  end;

  TDSProxyWriterStreamDictionary = TDictionary<string, TStream>;

  TDSProxyGeneratorCreatingFiles = procedure(Sender: TObject; FileName: TStrings; var Cancel: Boolean) of object;
  TDSProxyGeneratorPrepareWriter = procedure(Sender: TObject; Writer: TDSCustomProxyWriter; var Cancel: Boolean) of object;
  TDSProxyGeneratorFinishWriter = procedure(Sender: TObject; Writer: TDSCustomProxyWriter) of object;
  TDSProxyGeneratorCreatedFiles = procedure(Sender: TObject; FileName: TStrings) of object;
  TDSProxyGeneratorCreateStream = procedure(Sender: TObject;
    const AFileDescription: TDSProxyFileDescription; const AFileName: string; out AStream: TStream) of object;

  TDSCustomProxyGenerator = class(TComponent)
  private
    FTargetDirectory: string;
    FTargetUnitName: string;
    FIncludeClasses: string;
    FExcludeClasses: string;
    FIncludeMethods: string;
    FExcludeMethods: string;
    FWriter: string;
    [Weak]FMetaDataProvider: TDSCustomMetaDataProvider;
    FCreatedFiles: TDSProxyGeneratorCreatedFiles;
    FCreatingFiles: TDSProxyGeneratorCreatingFiles;
    FCreateStream: TDSProxyGeneratorCreateStream;
    FMetaDataLoaderIntf: IDSProxyMetaDataLoader;
    FPrepareWriter: TDSProxyGeneratorPrepareWriter;
    FFinishWriter: TDSProxyGeneratorFinishWriter;
    procedure WriteToStreams(
      Callback: TProc<TDSProxyWriterStreamDictionary>); overload;
    procedure WriteToStreams(AProperties: TDSProxyWriterProperties; AProxyWriter: TDSCustomProxyWriter; AConnection: IDSProxyMetaDataLoader; AStreams: TDSProxyWriterStreamDictionary); overload;
    procedure GetProxyWriter(Callback: TProc<TDSProxyWriterProperties, TDSCustomProxyWriter>);
    procedure SetMetaDataProvider(const Value: TDSCustomMetaDataProvider);
  protected
    function GetStreams(out ACreatedFileNames: TStrings; var LCancel: Boolean): TDSProxyWriterStreamDictionary; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Write; overload;
    procedure Write(AConnection: IDSProxyMetaDataLoader); overload;
    procedure WriteToStreams(AStreams: TDSProxyWriterStreamDictionary); overload;
    procedure WriteToStreams(AConnection: IDSProxyMetaDataLoader; AStreams: TDSProxyWriterStreamDictionary); overload;
    function WriterProperties: TDSProxyWriterProperties;
    function FileDescriptions: TDSProxyFileDescriptions;
    function GetMetaDataLoaderIntf: IDSProxyMetaDataLoader; virtual;
    property MetaDataLoaderIntf: IDSProxyMetaDataLoader read GetMetaDataLoaderIntf write FMetaDataLoaderIntf;
    property IncludeClasses: string read FIncludeClasses write FIncludeClasses;
    property ExcludeClasses: string read FExcludeClasses write FExcludeClasses;
    property IncludeMethods: string read FIncludeMethods write FIncludeMethods;
    property ExcludeMethods: string read FExcludeMethods write FExcludeMethods;
    property MetaDataProvider: TDSCustomMetaDataProvider read FMetaDataProvider write SetMetaDataProvider;
    property OnCreatingFiles: TDSProxyGeneratorCreatingFiles read FCreatingFiles write FCreatingFiles;
    property OnCreatedFiles: TDSProxyGeneratorCreatedFiles read FCreatedFiles write FCreatedFiles;
    property OnCreateStream: TDSProxyGeneratorCreateStream read FCreateStream write FCreateStream;
    property OnPrepareWriter: TDSProxyGeneratorPrepareWriter read FPrepareWriter write FPrepareWriter;
    property OnFinishWriter: TDSProxyGeneratorFinishWriter read FFinishWriter write FFinishWriter;
    property TargetUnitName: string read FTargetUnitName write FTargetUnitName;
    property TargetDirectory: string read FTargetDirectory write FTargetDirectory;
    property Writer: string read FWriter write FWriter;
  end;

  TDSProxyGenerator = class(TDSCustomProxyGenerator)
  published
    property IncludeClasses;
    property ExcludeClasses;
    property IncludeMethods;
    property ExcludeMethods;
    property MetaDataProvider;
    property OnCreatingFiles;
    property OnCreatedFiles;
    property OnCreateStream;
    property TargetUnitName;
    property TargetDirectory;
    property Writer;
  end;

implementation

uses Data.DBXCommon, Data.DBXPlatform, Datasnap.DSClientResStrs, Datasnap.DSProxyRest;


{ TDSRestMetaDataProvider }

function TDSRestMetaDataProvider.GetProvider: IDSProxyMetaDataLoader;
begin
  if HasProvider then
  begin
    Result := TDSRestProxyMetaDataLoader.Create(FConnection);
  end
  else
    Result := nil;
end;

function TDSRestMetaDataProvider.HasProvider: Boolean;
begin
  Result := FConnection <> nil;
end;

procedure TDSRestMetaDataProvider.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FConnection) then
    FConnection := nil;
end;

procedure TDSRestMetaDataProvider.SetConnection(
  const Value: TDSCustomRestConnection);
begin
  if Value <> FConnection then
  begin
    if Assigned(FConnection) then
      FConnection.RemoveFreeNotification(Self);
    FConnection := Value;
    if Value <> nil then
    begin
      Value.FreeNotification(Self);
    end;
  end;
end;

{ TDSCustomProxyGenerator }

function TDSCustomProxyGenerator.GetStreams(out ACreatedFileNames: TStrings; var LCancel: Boolean): TDSProxyWriterStreamDictionary;
var
  I: Integer;
  LFileName: string;
  LFileNames: TStrings;
  LStream: TStream;
begin
  ACreatedFileNames := TStringList.Create;
  try
    LFileNames := TStringList.Create;
    try
      for I := 0 to Length(FileDescriptions) - 1 do
      begin
        LFileName := IncludeTrailingPathDelimiter(TargetDirectory) + TargetUnitName;
        if (Length(FileDescriptions) > 1) or (ExtractFileExt(LFileName) = '') then
          LFileName := ChangeFileExt(LFileName, FileDescriptions[I].DefaultFileExt);
        LFileNames.Add(LFileName)
      end;
      LCancel := False;
      if Assigned(Self.FCreatingFiles) then
        FCreatingFiles(Self, LFileNames, LCancel);
      if LCancel then
        Exit(nil);
      for I := 0 to LFileNames.Count - 1 do
      begin
        LFileName := LFileNames[I];
        if Trim(LFileName) <> '' then
          LFileNames[I] := ExpandFileName(LFileName);
      end;
      Result := TObjectDictionary<string, TStream>.Create([doOwnsValues]);
      for I := 0 to Length(FileDescriptions) - 1 do
      begin
        LFileName := LFileNames[I];
        if LFileName <> '' then
        begin
          if Assigned(FCreateStream) then
            FCreateStream(Self, FileDescriptions[I], LFileName, LStream)
          else
            LStream := TFileStream.Create(LFileName, fmCreate);
          Result.Add(FileDescriptions[I].ID,
            LStream);
          ACreatedFileNames.Add(LFileName);
        end;
      end;
    finally
      LFileNames.Free;
    end;
  except
    ACreatedFileNames.Free;
    raise;
  end;
end;

procedure TDSCustomProxyGenerator.GetProxyWriter(
  Callback: TProc<TDSProxyWriterProperties, TDSCustomProxyWriter>);
var
  LWriter: TDSProxyWriter;
  LCustomProxyWriter: TDSCustomProxyWriter;
  LCancel: Boolean;
begin
  LWriter := TDSProxyWriterFactory.Instance.GetWriter(FWriter);
  try
    LCustomProxyWriter := LWriter.CreateProxyWriter;
    try
      if Assigned(FPrepareWriter) then
      begin
        LCancel := False;
        FPrepareWriter(Self, LCustomProxyWriter, LCancel);
        if LCancel then
          Exit;
      end;
      Callback(LWriter.Properties, LCustomProxyWriter);
      if Assigned(FFinishWriter) then
        FFinishWriter(Self, LCustomProxyWriter);
    finally
      LCustomProxyWriter.Free;
    end;
  finally
    LWriter.Free;
  end;
end;

function TDSCustomProxyGenerator.GetMetaDataLoaderIntf: IDSProxyMetaDataLoader;
begin
  if FMetaDataLoaderIntf <> nil then
    Result := FMetaDataLoaderIntf
  else if FMetaDataProvider <> nil then
    Result := FMetaDataProvider.GetProvider;
  if Result = nil then
    raise TDSProxyException.Create(SNoMetaData);
end;


procedure TDSCustomProxyGenerator.WriteToStreams(Callback: TProc<TDSProxyWriterStreamDictionary>);
var
  LStreams: TDSProxyWriterStreamDictionary;
  LCancel: Boolean;
  LCreatedFileNames: TStrings;
begin
  LCancel := False;
  LStreams := GetStreams(LCreatedFileNames, LCancel);
  try
    if LStreams = nil then
    begin
      if not LCancel then
        raise TDSProxyException.Create(SStreamNotFound);
    end
    else
    begin
      try
        Callback(LStreams);
        if (LCreatedFileNames <> nil) and (LCreatedFileNames.Count > 0) then
          if Assigned(FCreatedFiles) then
            FCreatedFiles(Self, LCreatedFileNames);
        finally
          LStreams.Free;
        end;
    end;
  finally
    LCreatedFileNames.Free;
  end;
end;

procedure TDSCustomProxyGenerator.Write(AConnection: IDSProxyMetaDataLoader);
begin
  GetProxyWriter(
    procedure(AProperties: TDSProxyWriterProperties; AProxyWriter: TDSCustomProxyWriter)
    begin
    WriteToStreams(
      procedure(AStreams: TDSProxyWriterStreamDictionary)
      begin
        WriteToStreams(AProperties, AProxyWriter, AConnection, AStreams);
      end);
    end)
end;

procedure TDSCustomProxyGenerator.Write;
begin
  WriteToStreams(
    procedure(AStreams: TDSProxyWriterStreamDictionary)
    begin
      WriteToStreams(AStreams);
    end);
end;

procedure TDSCustomProxyGenerator.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FMetaDataProvider) then
    FMetaDataProvider := nil;
end;

procedure TDSCustomProxyGenerator.SetMetaDataProvider(
  const Value: TDSCustomMetaDataProvider);
begin
  if Value <> FMetaDataProvider then
  begin
    if Assigned(FMetaDataProvider) then
      FMetaDataProvider.RemoveFreeNotification(Self);
    FMetaDataProvider := Value;
    if Value <> nil then
    begin
      FMetaDataLoaderIntf := nil;
      Value.FreeNotification(Self);
    end;
  end;
end;

procedure TDSCustomProxyGenerator.WriteToStreams(AConnection: IDSProxyMetaDataLoader; AStreams: TDSProxyWriterStreamDictionary);
begin
  GetProxyWriter(
    procedure(AProperties: TDSProxyWriterProperties; AWriter: TDSCustomProxyWriter)
    begin
     WriteToStreams(AProperties, AWriter, AConnection, AStreams);
    end);
end;

procedure TDSCustomProxyGenerator.WriteToStreams(AStreams: TDSProxyWriterStreamDictionary);
var
  LLoader: IDSProxyMetaDataLoader;
begin
  LLoader := GetMetaDataLoaderIntf;
  GetProxyWriter(
    procedure(AProperties: TDSProxyWriterProperties; AWriter: TDSCustomProxyWriter)
    begin
     WriteToStreams(AProperties, AWriter, LLoader, AStreams);
    end);
end;

procedure TDSCustomProxyGenerator.AssignTo(Dest: TPersistent);
begin
  if Dest is TDSCustomProxyGenerator then
  begin
    TDSCustomProxyGenerator(Dest).TargetDirectory := TargetDirectory;
    TDSCustomProxyGenerator(Dest).TargetUnitName := TargetUnitName;
    TDSCustomProxyGenerator(Dest).ExcludeClasses := ExcludeClasses;
    TDSCustomProxyGenerator(Dest).IncludeClasses := IncludeClasses;
    TDSCustomProxyGenerator(Dest).ExcludeMethods := ExcludeMethods;
    TDSCustomProxyGenerator(Dest).IncludeMethods := IncludeMethods;
    TDSCustomProxyGenerator(Dest).Writer := Writer;
    TDSCustomProxyGenerator(Dest).MetaDataProvider := MetaDataProvider;
    if not (csDesigning in ComponentState) then
    begin
      TDSCustomProxyGenerator(Dest).OnCreatingFiles := OnCreatingFiles;
      TDSCustomProxyGenerator(Dest).OnCreatedFiles := OnCreatedFiles;
      TDSCustomProxyGenerator(Dest).OnCreateStream := OnCreateStream;
      TDSCustomProxyGenerator(Dest).OnFinishWriter := OnFinishWriter;
      TDSCustomProxyGenerator(Dest).OnPrepareWriter := OnPrepareWriter;
    end;

  end
  else
    inherited;
end;

constructor TDSCustomProxyGenerator.Create(AOwner: TComponent);
begin
  inherited;
end;

function TDSCustomProxyGenerator.FileDescriptions: TDSProxyFileDescriptions;
var
  LWriter: TDSProxyWriter;
begin
  LWriter := TDSProxyWriterFactory.Instance.GetWriter(FWriter);
  try
    Result := LWriter.FileDescriptions;
  finally
    LWriter.Free;
  end;
end;

function TDSCustomProxyGenerator.WriterProperties: TDSProxyWriterProperties;
var
  LWriter: TDSProxyWriter;
begin
  LWriter := TDSProxyWriterFactory.Instance.GetWriter(FWriter);
  try
    Result := LWriter.Properties;
  finally
    LWriter.Free;
  end;
end;

const
  sDelimiters = [';', ','];

function ExtractToArray(const AString: string): TDBXStringArray;
var
  LStrings: TStrings;
  I: Integer;
begin
  if Trim(AString) <> '' then
  begin
    LStrings := TStringList.Create;
    try
      ExtractStrings(sDelimiters, [], PChar(AString), LStrings);
      if LStrings.Count > 0 then
      begin
        SetLength(Result, LStrings.Count);
        for I := 0 to LStrings.Count - 1 do
          Result[I] := LStrings[I];
      end;
    finally
      LStrings.Free;
    end;
  end;
end;

procedure TDSCustomProxyGenerator.WriteToStreams(AProperties: TDSProxyWriterProperties; AProxyWriter: TDSCustomProxyWriter; AConnection: IDSProxyMetaDataLoader; AStreams: TDSProxyWriterStreamDictionary);
var
  LPair: TPair<string, TStream>;
  LEncoding: TEncoding;
begin
  AProxyWriter.UnitFileName := TargetUnitName;
  AProxyWriter.IncludeClasses := ExtractToArray(IncludeClasses);
  AProxyWriter.IncludeMethods := ExtractToArray(IncludeMethods);
  if Trim(ExcludeClasses) = '' then
    AProxyWriter.ExcludeClasses := ExtractToArray(AProperties.DefaultExcludeClasses)
  else
    AProxyWriter.ExcludeClasses := ExtractToArray(ExcludeClasses);
  if Trim(ExcludeMethods) = '' then
    AProxyWriter.ExcludeMethods := ExtractToArray(AProperties.DefaultExcludeMethods)
  else
    AProxyWriter.ExcludeMethods := ExtractToArray(ExcludeMethods);
  if AProperties.DefaultEncoding <> nil then
    LEncoding := AProperties.DefaultEncoding
  else
    LEncoding := TEncoding.ANSI;
  AProxyWriter.MetaDataLoader := AConnection;
  for LPair in AStreams do
    AProxyWriter.ProxyWriters.Add(LPair.Key,
      TDSProxyStreamWriter.Create(LPair.Key, LPair.Value, LEncoding) as IDSProxyWriter);
  AProxyWriter.WriteProxy;
end;

end.

