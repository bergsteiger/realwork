{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsTemplates;

interface

uses Classes, ToolsAPI, SysUtils, Generics.Collections;

type

  IPropertyPairs = interface;

  TExpertsTemplateFileManager = class(TComponent)
  public
    function GetFileName(const APersonality: string): string; virtual; abstract;
  end;

  TCustomExpertsTemplatePersonalityFiles = class(TExpertsTemplateFileManager)
  private
    FCBuilderTemplateFile: TFileName;
    FGenericTemplateFile: TFileName;
    FDelphiTemplateFile: TFileName;
  public
    function GetFileName(const APersonality: string): string; override;
    property DelphiTemplateFile: TFileName read FDelphiTemplateFile write FDelphiTemplateFile;
    property CBuilderTemplateFile: TFileName read FCBuilderTemplateFile write FCBuilderTemplateFile;
    property GenericTemplateFile: TFileName read FGenericTemplateFile write FGenericTemplateFile;
  end;

  TExpertsTemplatePersonalityFiles = class(TCustomExpertsTemplatePersonalityFiles)
  published
    property DelphiTemplateFile;
    property CBuilderTemplateFile;
    property GenericTemplateFile;
  end;

  TCustomExpertsTemplateProperties = class;

  TCustomExpertsTemplateFile = class(TComponent)
  private
    FTemplateFile: TFileName;
    FTemplateDoc: TStrings;
    FTemplateProperties: TCustomExpertsTemplateProperties;
    FTemplatePropertiesDoc: TStrings;
    FTemplateFileManager: TExpertsTemplateFileManager;
    procedure SetTemplateFile(const Value: TFileName);
    procedure SetTemplateDoc(Value: TStrings);
    procedure SetTemplateProperties(const Value: TCustomExpertsTemplateProperties);
    procedure SetTemplatePropertiesDoc(const Value: TStrings);
    procedure SetTemplateFileManager(
      const Value: TExpertsTemplateFileManager);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetTemplateFileName: string; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateSource(const APersonality: string; Props: IPropertyPairs): string;
    function CreateFile(const APersonality: string; Props: IPropertyPairs): IOTAFile;
    property TemplateDoc: TStrings read FTemplateDoc write SetTemplateDoc;
    property TemplateFile: TFileName read FTemplateFile write SetTemplateFile;
    property TemplateFileManager: TExpertsTemplateFileManager read FTemplateFileManager write SetTemplateFileManager;
    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
  end;

  TExpertsTemplateFile = class(TCustomExpertsTemplateFile)
  published
    property TemplateDoc;
    property TemplateFile;
    property TemplateProperties;
    property TemplatePropertiesDoc;
    property TemplateFileManager;
  end;

  TCustomExpertsTemplateProperties = class(TComponent)
  private
    FProperties: TStrings;
    procedure SetProperties(const Value: TStrings);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Properties: TStrings read FProperties write SetProperties;
  end;

  TExpertsTemplateProperties = class(TCustomExpertsTemplateProperties)
  published
    property Properties;
  end;

  IPropertyPair = interface
['{C304A811-9BA5-412E-8C0B-965210E1031F}']
    function Name: string;
    function Value: string;
  end;

  IPropertyPairs = interface(IEnumerable<IPropertyPair>)
  ['{F361A483-CD1C-4A64-88FD-EF313F6BEFF6}']
    function Count: Integer;
    function GetItem(I: Integer): IPropertyPair;
    property Item[I: Integer]: IPropertyPair read GetItem;
  end;

  TPropertyPair = class(TInterfacedObject, IPropertyPair)
  private
    FName: string;
    FValue: string;
    function Name: string;
    function Value: string;
  public
    constructor Create(const AName, AValue: string);
  end;

  TStringsPropertiesPairs = class(TInterfacedObject, IPropertyPairs, IEnumerable<IPropertyPair>, IEnumerable)
  private
    FOwnsStrings: Boolean;
    FProperties: TStrings;
    { IPropertyPairs }
    //  function GetGenericEnumerator: IEnumerator;
    function Count: Integer;
    function GetItem(I: Integer): IPropertyPair;
    function GetEnumerator: IEnumerator;
    function IEnumerable<IPropertyPair>.GetEnumerator = GetGenericEnumerator;
    function IPropertyPairs.GetEnumerator = GetGenericEnumerator;
    function GetGenericEnumerator: IEnumerator<IPropertyPair>;
  public
    constructor Create(AProperties: TStrings; AOwnsStrings: Boolean);
    destructor Destroy; override;
  end;


  TExpertsPropertiesPairs = class(TStringsPropertiesPairs)
  public
    constructor Create(AProperties: TCustomExpertsTemplateProperties);
  end;

  TExpertsPropertiesPairsEnumerator = class(TInterfacedObject,IEnumerator<IPropertyPair>,IEnumerator)
  private
    FPairs : TStrings;
    FIndex : integer;
    FDictionary: TDictionary<integer, IPropertyPair>;
    function GetItem(AIndex: Integer): IPropertyPair;
  protected
    function GetCurrent: TObject;
    function GenericGetCurrent: IPropertyPair;
    function IEnumerator<IPropertyPair>.GetCurrent = GenericGetCurrent;
    function MoveNext: Boolean;
    procedure Reset;
  public
    constructor Create(const APairs : TStrings);
    destructor Destroy; override;
  end;

  function MergePropertyPairs(APairs1, APairs2: IPropertyPairs): IPropertyPairs;
  function FindTemplateFile(const ATemplateFile: string; out APath: string): boolean;

implementation

uses ExpertsIntf, ExpertsResStrs, ExpertFilter;

function MergePropertyPairs(APairs1, APairs2: IPropertyPairs): IPropertyPairs;
var
  LList: TList<string>;
  LStrings: TStringList;

  procedure Add(APairs: IPropertyPairs);
  var
    LPair: IPropertyPair;
  begin
    for LPair in APairs do
      if not LList.Contains(LPair.Name) then
      begin
        LList.Add(LPair.Name);
        LStrings.Add(LPair.Name + '=' + LPair.Value);
      end;
  end;
begin
  LStrings := TStringList.Create;
  try
    LList := TList<string>.Create;
    try
      Add(APairs1);
      Add(APairs2);
    finally
      LList.Free;
    end;
  except
    LStrings.Free;
    raise;
  end;
  Result := TStringsPropertiesPairs.Create(LStrings, True);
end;

type
  TStringsProvider = class(TInterfacedObject, ILineProvider)
  protected
    FLineNumber: Integer;
    FLines: TStrings;
    { ILineProvider }
    function  HasMore: boolean;
    function  NextLine: string;
    function  LineNumber: integer;
    function  ReStart: boolean;
    procedure Cleanup;
    function  IsOutputOn: boolean;
  public
    constructor Create(ALines: TStrings);
    destructor Destroy; override;
  end;

function ExtractStringValue(const S: string): string;
var
  P: Integer;
begin
  P := AnsiPos('=', S);
  if (P <> 0) and (Length(S) > P) then
    Result := Copy(S, P+1, MaxInt) else
    SetLength(Result, 0);
end;

function FindTemplateFile(const ATemplateFile: string; out APath: string): boolean;
begin
  APath := ATemplateFile;
  if IsRelativePath(APath) then
  begin
    APath := (BorlandIDEServices as IOTAServices).GetTemplateDirectory + APath;
  end;
  Result := LocaleFileExists(APath);
  if Result then
    APath := GetLocaleFile(APath)
end;

function GetSourceFromTemplateFile(const FileName: string; Props: IPropertyPairs): string;
var
  Filter: IExpertFilter;
  TemplateDirectory: string;
  Pair: IPropertyPair;
begin
  //try
    Filter := CoExpertFilter.Create;
    if Props <> nil then
      for Pair in Props do
        Filter.SetProperty(Pair.Name, Pair.Value);
    if IsRelativePath(FileName) then
      TemplateDirectory := (BorlandIDEServices as IOTAServices).GetTemplateDirectory
    else
      TemplateDirectory := '';
//    if SameFileName(ExtractFileExt(FileName), '.cpp') or SameFileName(ExtractFileExt(FileName), '.h') then
//      TemplateDirectory := TemplateDirectory + 'cpp\'; // Do not localize
    Result := Filter.Filter(FileName, TemplateDirectory);
//  except
//    Result := '';
//  end;
end;

function GetSourceFromStrings(ALines: TStrings; Props: IPropertyPairs): string;
var
  Filter: IExpertFilter;
  Pair: IPropertyPair;
begin
//  try
    Filter := CoExpertFilter.Create;
    if Props <> nil then
      for Pair in Props do
        Filter.SetProperty(Pair.Name, Pair.Value);
    Result := Filter.Filter(TStringsProvider.Create(ALines));
//  except
//    Result := '';
//  end;
end;

{ TCustomExpertsFile }

constructor TCustomExpertsTemplateFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTemplateDoc := TStringList.Create;
  FTemplatePropertiesDoc := TStringList.Create;
end;

destructor TCustomExpertsTemplateFile.Destroy;
begin
  FTemplateDoc.Free;
  FTemplatePropertiesDoc.Free;
  inherited Destroy;
end;


procedure TCustomExpertsTemplateFile.SetTemplateFile(const Value: TFileName);
begin
  if CompareText(FTemplateFile, Value) <> 0 then
  begin
    FTemplateFile := Value;
    if Value <> '' then
    begin
      FTemplateDoc.Clear;
      TemplateFileManager := nil;
    end;
  end;
end;

procedure TCustomExpertsTemplateFile.SetTemplateFileManager(
  const Value: TExpertsTemplateFileManager);
begin
  if FTemplateFileManager <> Value then
  begin
    if Value <> nil then
    begin
      Value.FreeNotification(Self);
      FTemplateFile := '';
      FTemplateDoc.Clear;
    end;
    FTemplateFileManager := Value;
  end;
end;

procedure TCustomExpertsTemplateFile.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FTemplateProperties) then
    FTemplateProperties := nil;
  if (Operation = opRemove) and (AComponent = FTemplateFileManager) then
    FTemplateFileManager := nil;
end;

procedure TCustomExpertsTemplateFile.SetTemplateProperties(
  const Value: TCustomExpertsTemplateProperties);
begin
  if FTemplateProperties <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FTemplateProperties := Value;
  end;
end;

procedure TCustomExpertsTemplateFile.SetTemplatePropertiesDoc(
  const Value: TStrings);
begin
  FTemplatePropertiesDoc.Assign(Value);
  if Value.Text <> '' then
  begin
    FTemplateFile := '';
    TemplateFileManager := nil;
  end;
end;

procedure TCustomExpertsTemplateFile.SetTemplateDoc(Value: TStrings);
begin
  FTemplateDoc.Assign(Value);
  FTemplateFile := '';
end;

function TCustomExpertsTemplateFile.GetTemplateFileName: string;
begin
  Result := TemplateFile;
end;

{ TCustomExpertsFile }

function TCustomExpertsTemplateFile.CreateSource(const APersonality: string; Props: IPropertyPairs): string;
var
  LFileName: string;
  LDoc: TStrings;
begin
  LDoc := nil;
  if TemplateFileManager <> nil then
  begin
    LFileName := TemplateFileManager.GetFileName(APersonality);
  end
  else if Trim(TemplateFile) <> '' then
    LFileName := TemplateFile
  else
    LDoc := TemplateDoc;
  if LFileName <> '' then
    Result := GetSourceFromTemplateFile(LFileName, Props)
  else if LDoc <> nil then
    Result := GetSourceFromStrings(TemplateDoc, Props);


end;

function TCustomExpertsTemplateFile.CreateFile(const APersonality: string; Props: IPropertyPairs): IOTAFile;
var
  S: string;
  LMergedPairs: IPropertyPairs;
begin
  // Combine pairs from caller with this component's property pairs
  if Props <> nil then
    LMergedPairs :=  MergePropertyPairs(Props, TStringsPropertiesPairs.Create(FTemplatePropertiesDoc, False));
  if LMergedPairs <> nil then
    LMergedPairs := MergePropertyPairs(LMergedPairs, TExpertsPropertiesPairs.Create(Self.FTemplateProperties))
  else
    LMergedPairs := TExpertsPropertiesPairs.Create(Self.FTemplateProperties);

  S := CreateSource(APersonality, LMergedPairs);
  Result := TOTAFile.Create(S);
end;

{ TStringProvider }

procedure TStringsProvider.Cleanup;
begin
  { NOP }
end;

constructor TStringsProvider.Create(ALines: TStrings);
begin
  inherited Create;
  FLineNumber := 0;
  FLines := ALines;
end;

destructor TStringsProvider.Destroy;
begin
  inherited;
end;

function TStringsProvider.HasMore: boolean;
begin
  Result := FLineNumber < FLines.Count;
end;

function TStringsProvider.IsOutputOn: boolean;
begin
  Result := True;
end;

function TStringsProvider.LineNumber: integer;
begin
  Result := FLineNumber;
end;

function TStringsProvider.NextLine: string;
begin
  Result :=FLines[FLineNumber];
  Inc(FLineNumber);
end;

function TStringsProvider.ReStart: boolean;
begin
  { File Resource Providers don't need to be restarted }
  Assert(False);
  Result := False;
end;

{ TCustomExpertsProperties }

constructor TCustomExpertsTemplateProperties.Create(AOwner: TComponent);
begin
  inherited;
  FProperties := TStringList.Create;
end;

destructor TCustomExpertsTemplateProperties.Destroy;
begin
  FProperties.Free;
  inherited;
end;

procedure TCustomExpertsTemplateProperties.SetProperties(const Value: TStrings);
begin
  FProperties.Assign(Value);
end;

{ TStringsPropertiesPairs }

function TStringsPropertiesPairs.Count: Integer;
begin
  if FProperties <> nil then
    Result := FProperties.Count
  else
    Result := 0;
end;

constructor TStringsPropertiesPairs.Create(
  AProperties: TStrings; AOwnsStrings:Boolean);
begin
  FProperties := AProperties;
  FOwnsStrings := AOwnsStrings;
end;


destructor TStringsPropertiesPairs.Destroy;
begin
  if FOwnsStrings then
    FProperties.Free;
  inherited;
end;

function TStringsPropertiesPairs.GetEnumerator: IEnumerator;
begin
  Result := GetGenericEnumerator;
end;

function TStringsPropertiesPairs.GetGenericEnumerator: IEnumerator<IPropertyPair>;
begin
  if FProperties <> nil then
    Result := TExpertsPropertiesPairsEnumerator.Create(FProperties)
  else
    Result := TExpertsPropertiesPairsEnumerator.Create(nil)
end;

function TStringsPropertiesPairs.GetItem(I: Integer): IPropertyPair;
begin
  if FProperties <> nil then
    Result := TPropertyPair.Create(FProperties.Names[I], FProperties.ValueFromIndex[I])
  else
    Result := nil;
end;

{ TPropertyPair }

constructor TPropertyPair.Create(const AName, AValue: string);
begin
  FName := AName;
  FValue := AValue;
end;

function TPropertyPair.Name: string;
begin
  Result := FName;
end;

function TPropertyPair.Value: string;
begin
  Result := FValue;
end;

{ TExpertsPropertiesPairsEnumerator }

constructor TExpertsPropertiesPairsEnumerator.Create(const APairs: TStrings);
begin
  FPairs := APairs;
  FIndex := -1;
  FDictionary := TDictionary<Integer, IPropertyPair>.Create;
end;

function TExpertsPropertiesPairsEnumerator.GetItem(AIndex: Integer): IPropertyPair;
begin
  if FDictionary.TryGetValue(AIndex, Result) then
    Exit;
  if (FPairs <> nil) and (FPairs.Count > 0) and (FIndex < FPairs.Count) then
    result := TPropertyPair.Create(FPairs.Names[FIndex],
      FPairs.ValueFromIndex[FIndex])
  else
    result := nil;
  FDictionary.Add(AIndex, result);
end;

destructor TExpertsPropertiesPairsEnumerator.Destroy;
begin
  FDictionary.Free;
  inherited;
end;

function TExpertsPropertiesPairsEnumerator.GenericGetCurrent: IPropertyPair;
begin
  Result := GetItem(FIndex);
end;

function TExpertsPropertiesPairsEnumerator.GetCurrent: TObject;
begin
  Result := TObject(GetItem(FIndex));
end;

function TExpertsPropertiesPairsEnumerator.MoveNext: Boolean;
begin
  Inc(FIndex);
  result := (FPairs <> nil) and (FIndex < FPairs.Count);
end;

procedure TExpertsPropertiesPairsEnumerator.Reset;
begin
  FIndex := -1;
end;

{ TExpertsPropertiesPairs }

constructor TExpertsPropertiesPairs.Create(
  AProperties: TCustomExpertsTemplateProperties);
begin
  if AProperties <> nil then
    inherited Create(AProperties.Properties, False)
  else
    inherited Create(nil, False);
end;

{ TCustomExpertsPersonalityFilesManager }

function TCustomExpertsTemplatePersonalityFiles.GetFileName(
  const APersonality: string): string;
begin
  if SameText(sDelphiPersonality, APersonality) then
    Result := FDelphiTemplateFile
  else if SameText(sCBuilderPersonality, APersonality) then
    Result := FCBuilderTemplateFile
  else if APersonality = '' then
    Result := FGenericTemplateFile
  else
    raise Exception.CreateFmt(sUnknownPersonality, [APersonality]);
  if Result = '' then
    Result := FGenericTemplateFile;


end;


end.
