{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsProject;

interface

uses Classes, ToolsAPI, SysUtils, ExpertsTemplates, PlatformAPI;

type

  TExpertsProjectType = (ptApplication, ptLibrary, ptConsole, ptPackage, ptCppPackage, ptStaticLibrary);

  TOSFamilySet = set of TOTAOSFamily;

  TCustomExpertsProject = class;

  TExpertsProjectPersonalityEvent = procedure(Sender: TCustomExpertsProject; const APersonality: string) of object;
  TExpertsCreateProjectEvent = procedure(Sender: TCustomExpertsProject; const APersonality: string;
    const AProjectName: string) of object;

  TCustomExpertsProject = class(TComponent)
  private
    FProjectType: TExpertsProjectType;
    FProjectTemplateFile: TCustomExpertsTemplateFile;
    FTemplateProperties: TCustomExpertsTemplateProperties;
    FOnCreateModules: TExpertsProjectPersonalityEvent;
    FProjectDirectory: string;
    FProjectFileName: string;
    FUnnamed: Boolean;
    FTemplatePropertiesDoc: TStrings;
    FFrameWorkType: string;
    FPlatformTypes: TOSFamilySet;
    procedure SetProjectFile(const Value: TCustomExpertsTemplateFile);
    procedure SetTemplateProperties(const Value: TCustomExpertsTemplateProperties);
    procedure SetProjectDirectory(const Value: string);
    procedure SetProjectFileName(const Value: string);
    procedure SetTemplatePropertiesDoc(const Value: TStrings);
  protected
    procedure DoOnCreateModules(const APersonality: string); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    class function ProjectTypeToString(AProjectType: TExpertsProjectType): string; static;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateProject(const APersonality: string);
    property ProjectType: TExpertsProjectType read FProjectType write FProjectType;
    property ProjectTemplateFile: TCustomExpertsTemplateFile read FProjectTemplateFile write SetProjectFile;
    property ProjectFileName: string read FProjectFileName write SetProjectFileName;
    property ProjectDirectory: string read FProjectDirectory write SetProjectDirectory;
    property TemplateProperties: TCustomExpertsTemplateProperties read FTemplateProperties write SetTemplateProperties;
    property TemplatePropertiesDoc: TStrings read FTemplatePropertiesDoc write SetTemplatePropertiesDoc;
    property OnCreateModules: TExpertsProjectPersonalityEvent read FOnCreateModules write FOnCreateModules;
    property Unnamed: Boolean read FUnnamed write FUnnamed default true;
    property FrameWorkType: string read FFrameWorkType write FFrameWorkType;
    property PlatformTypes: TOSFamilySet read FPlatformTypes write FPlatformTypes;
  end;

  TExpertsProject = class(TCustomExpertsProject)
  published
    property ProjectType;
    property ProjectTemplateFile;
    property TemplateProperties;
    property TemplatePropertiesDoc;
    property OnCreateModules;
    property ProjectFileName;
    property ProjectDirectory;
    property PlatformTypes;
    property Unnamed;
  end;

implementation

uses ExpertsProjectCreators, ExpertsIntf, ExpertsResStrs;

type
  TExpertsProjectAccessor = class(TInterfacedObject, IExpertsProjectAccessor)
  private
    FPersonality: string;
    FExpertsProject: TCustomExpertsProject;
    // IExpertsProjectAccessor
    function GetCreatorType: string;
    function NewProjectSource(const ProjectName: string): IOTAFile;
    procedure NewDefaultModule;
    function GetFileName: string;
    function GetDirectory: string;
    function GetUnnamed: Boolean;
    function GetFrameWorkType: string;
    function GetPlatformTypes: TOSFamilySet;
  public
    constructor Create(const APersonality: string; AExpertsProject: TCustomExpertsProject);
  end;

{ TCustomExpertsProject }

constructor TCustomExpertsProject.Create(AOwner: TComponent);
begin
  inherited;
  FUnnamed := True;
  FTemplatePropertiesDoc := TStringList.Create;
end;

procedure TCustomExpertsProject.CreateProject(const APersonality: string);
begin
  (BorlandIDEServices as IOTAModuleServices).CreateModule(
    TExpertsProjectCreator.Create(APersonality, TExpertsProjectAccessor.Create(APersonality, Self)))

end;

destructor TCustomExpertsProject.Destroy;
begin
  FTemplatePropertiesDoc.Free;
  inherited;
end;

procedure TCustomExpertsProject.DoOnCreateModules(const APersonality: string);
begin
  if Assigned(FOnCreateModules) then
    FOnCreateModules(Self, APersonality);
end;

procedure TCustomExpertsProject.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FProjectTemplateFile) then
    FProjectTemplateFile := nil;
  if (Operation = opRemove) and (AComponent = FTemplateProperties) then
    FTemplateProperties := nil;
end;

class function TCustomExpertsProject.ProjectTypeToString(
  AProjectType: TExpertsProjectType): string;
begin
  case AProjectType of
    ptApplication  : Result := ToolsAPI.sApplication;
    ptLibrary      : Result := ToolsAPI.sLibrary;
    ptConsole      : Result := ToolsAPI.sConsole;
    ptPackage      : Result := ToolsAPI.sPackage;
    ptCppPackage   : Result := ToolsAPI.sCppPackage;
    ptStaticLibrary: Result := ToolsAPI.sStaticLibrary;
  else
    raise Exception.Create(rsNotSupported);
  end;
end;

procedure TCustomExpertsProject.SetProjectFile(const Value: TCustomExpertsTemplateFile);
begin
  if FProjectTemplateFile <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FProjectTemplateFile := Value;
  end;
end;

procedure TCustomExpertsProject.SetProjectFileName(const Value: string);
begin
  FProjectFileName := Trim(Value);
  if FProjectFileName <> '' then
  begin
    FProjectFileName := ExtractFileName(ChangeFileExt(FProjectFileName, ''));
  end;
end;

procedure TCustomExpertsProject.SetProjectDirectory(const Value: string);
begin
  FProjectDirectory := Trim(Value);
  if FProjectDirectory <> '' then
    FProjectDirectory := IncludeTrailingPathDelimiter(FProjectDirectory)
end;

procedure TCustomExpertsProject.SetTemplateProperties(
  const Value: TCustomExpertsTemplateProperties);
begin
  if FTemplateProperties <> Value then
  begin
    if Value <> nil then Value.FreeNotification(Self);
    FTemplateProperties := Value;
  end;
end;

procedure TCustomExpertsProject.SetTemplatePropertiesDoc(const Value: TStrings);
begin
  FTemplatePropertiesDoc.Assign(Value);
end;

{ TExpertsProjectAccessor }

constructor TExpertsProjectAccessor.Create(
  const APersonality: string; AExpertsProject: TCustomExpertsProject);
begin
  FPersonality := APersonality;
  FExpertsProject := AExpertsProject;
end;

function TExpertsProjectAccessor.GetCreatorType: string;
begin
  Result := TCustomExpertsProject.ProjectTypeToString(FExpertsProject.ProjectType)
end;

function TExpertsProjectAccessor.GetFileName: string;
begin
  Result :=  FExpertsProject.ProjectFileName;
end;

function TExpertsProjectAccessor.GetDirectory: string;
begin
  Result :=  FExpertsProject.ProjectDirectory;
end;

function TExpertsProjectAccessor.GetUnnamed: Boolean;
begin
  Result := FExpertsProject.Unnamed;
end;

function TExpertsProjectAccessor.GetFrameWorkType: string;
begin
  Result := FExpertsProject.FrameWorkType;
end;

function TExpertsProjectAccessor.GetPlatformTypes: TOSFamilySet;
begin
  Result := FExpertsProject.PlatformTypes;
end;

procedure TExpertsProjectAccessor.NewDefaultModule;
begin
  FExpertsProject.DoOnCreateModules(FPersonality);
end;

function TExpertsProjectAccessor.NewProjectSource(
  const ProjectName: string): IOTAFile;
var
  LBuiltInProperties: TStrings;
  LBuiltInPropertyPairs: IPropertyPairs;
begin
  Result := nil;
  if FExpertsProject.FProjectTemplateFile <> nil then
  begin
    LBuiltInProperties := TStringList.Create;
    try
      LBuiltInProperties.Values['ProjectName'] := ProjectName;
      LBuiltInProperties.Values['ProjectType'] :=
        TCustomExpertsProject.ProjectTypeToString(FExpertsProject.ProjectType);
      LBuiltInPropertyPairs := TStringsPropertiesPairs.Create(LBuiltInProperties, False);
      LBuiltInPropertyPairs := MergePropertyPairs(LBuiltInPropertyPairs,
        TStringsPropertiesPairs.Create(FExpertsProject.FTemplatePropertiesDoc, False));
      Result := FExpertsProject.FProjectTemplateFile.CreateFile(FPersonality,
        MergePropertyPairs(LBuiltInPropertyPairs, TExpertsPropertiesPairs.Create(FExpertsProject.FTemplateProperties)))

    finally
      LBuiltInProperties.Free;
    end;
//  // Combine pairs from caller with this component's property pairs
//  LMergedPairs := MergePropertyPairs(Props, TExpertsPropertiesPairs.Create(Self.FTemplateProperties));
//  S := CreateSource(APersonality, LMergedPairs);
//  Result := TOTAFile.Create(S);
//
//  end
  end
  else
    Result := nil;
end;

end.
