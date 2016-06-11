{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit InetExpertsCreators;

interface

uses
  SysUtils, Classes, ExpertsProject, ExpertsTemplates, ExpertsModules, InetWiz, 
    InetCertFilesWizardPage, InetApacheWizardPage;

type
  TInetExpertsCreatorsModule = class(TDataModule)
    CommonTemplateProperties: TExpertsTemplateProperties;
    WebModule: TExpertsModule;
    ProjectTemplate: TExpertsTemplateFile;
    WebProject: TExpertsProject;
    ConsoleSourceTemplate: TExpertsTemplateFile;
    WebModuleIntfTemplate: TExpertsTemplateFile;
    WebModuleSourceTemplate: TExpertsTemplateFile;
    WebModuleDFMTemplate: TExpertsTemplateFile;
    ConsoleModule: TExpertsModule;
    ConsoleIntfTemplate: TExpertsTemplateFile;
    ConsoleDFMTemplate: TExpertsTemplateFile;

    WebModulesTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles;
    PCHSourceTemplate: TExpertsTemplateFile;
    PchModule: TExpertsPchModule;
    ServerConstSourceTemplate: TExpertsTemplateFile;
    ServerConstIntfTemplate: TExpertsTemplateFile;
    ServerContainerConst: TExpertsUnit;
    procedure WebProjectCreateModules(Sender: TCustomExpertsProject;
      const APersonality: string);
  private
    FProjectType: TProjectType;
    FHTTPPort: Integer;
    FPersonality: string;
    FHTTPS: Boolean;
    FCertFileInfo: TDSExpertCertFileInfo;
    FApacheInfo: TApacheInfo;
    FServerConstUnitName: string;
    procedure SetProjectType(AValue: TProjectType);
    procedure SetHTTPPort(const Value: Integer);
    procedure SetHTTPS(const Value: Boolean);
    procedure SetCertFileInfo(const Value: TDSExpertCertFileInfo);
    procedure SetApacheInfo(const Value: TApacheInfo);
    procedure SetConstUnitName(const Value: string);
  protected
    procedure CreateConsoleModule(const APersonality: string); virtual;
    procedure CreateWebModule(const APersonality: string); virtual;
    procedure UpdateProperties; virtual;
    procedure CreateModules(const APersonality: string); virtual;
    procedure CreatePchModule(const APersonality: string); virtual;
    procedure CreateResourceUnit(const APersonality: string);
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
    property ProjectType: TProjectType read FProjectType write SetProjectType;
    property HTTPPort: Integer read FHTTPPort write SetHTTPPort;
    property HTTPS: Boolean read FHTTPS write SetHTTPS;
    property Personality: string read FPersonality write FPersonality;
    property CertFileInfo: TDSExpertCertFileInfo write SetCertFileInfo;
    property ApacheInfo: TApacheInfo write SetApacheInfo;
    property ServerConstUnitName: string read FServerConstUnitName write SetConstUnitName;
  end;

var
  InetExpertsCreatorsModule: TInetExpertsCreatorsModule;

implementation

{$R *.dfm}

uses ToolsApi, InetExpertsTemplateProperties, StrUtils, PlatformAPI;

constructor TInetExpertsCreatorsModule.Create(AOwner: TComponent);
begin
  inherited;
  FApacheInfo.Create('', '', '', '');
  FPersonality := sDelphiPersonality;
end;


procedure TInetExpertsCreatorsModule.SetCertFileInfo(
  const Value: TDSExpertCertFileInfo);
begin
  FCertFileInfo := Value;
  UpdateProperties;
end;

procedure TInetExpertsCreatorsModule.SetConstUnitName(const Value: string);
begin
  FServerConstUnitName := Value;
  UpdateProperties;
end;

procedure TInetExpertsCreatorsModule.SetApacheInfo(
  const Value: TApacheInfo);
begin
  FApacheInfo := Value;
  UpdateProperties;
end;

procedure TInetExpertsCreatorsModule.SetHTTPPort(const Value: Integer);
begin
  FHTTPPort := Value;
  UpdateProperties;
end;

procedure TInetExpertsCreatorsModule.SetHTTPS(const Value: Boolean);
begin
  FHTTPS := Value;
  UpdateProperties;
end;

procedure TInetExpertsCreatorsModule.SetProjectType(AValue: TProjectType);
begin
  FProjectType := AValue;
  UpdateProperties;
end;

procedure TInetExpertsCreatorsModule.UpdateProperties;
  procedure SetTemplateProperty(const AName: string; AValue: Boolean);
  begin
    if AValue then
      CommonTemplateProperties.Properties.Values[AName] := sTrue
    else
      CommonTemplateProperties.Properties.Values[AName] := sFalse
  end;

  function EscapePath(const APath: string): string;
  begin
    Result := APath;
    if Personality = sCBuilderPersonality then
    begin
      Result := ReplaceStr(Result, '\', '\\');
    end;
  end;

  function EscapePassword(const APath: string): string;
  begin
    Result := APath;
    if Personality = sCBuilderPersonality then
    begin
      ReplaceStr(Result, '"', '\"');
    end
    else
      ReplaceStr(Result, '''', '''''');

  end;

begin
  ProjectTemplate.TemplatePropertiesDoc.Clear;
  case FProjectType of
    ptISAPI:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sIsapiSource] := sTrue;
      WebProject.ProjectType := ptLibrary;
      WebProject.PlatformTypes := WebProject.PlatformTypes - [osfLinux];
    end;
    ptCGI:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sCGISource] := sTrue;
      WebProject.ProjectType := ptConsole;
      WebProject.PlatformTypes := WebProject.PlatformTypes - [osfLinux];
    end;
    ptIndyForm:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sIndyFormProjectSource] := sTrue;
      WebProject.ProjectType := ptApplication;
      WebProject.PlatformTypes := WebProject.PlatformTypes - [osfLinux];
    end;
    ptIndyConsole:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sIndyConsoleProjectSource] := sTrue;
      WebProject.ProjectType := ptConsole;
      WebProject.PlatformTypes := WebProject.PlatformTypes - [osfLinux]; //add when linux is available in next release
    end;
    ptApacheTwo:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sApacheSource] := sTrue;
      WebProject.ProjectFileName := FApacheInfo.ApacheFileName;
      WebProject.ProjectType := ptLibrary;
      WebProject.PlatformTypes := WebProject.PlatformTypes - [osfLinux]; //add when linux is available in next release
    end
  else
    Assert(False);
  end;
  CommonTemplateProperties.Properties.Clear;
  CommonTemplateProperties.Properties.Values[sDBXTerminateThreads] := sFalse;
  CommonTemplateProperties.Properties.Values[sSetWebModuleClass] := sTrue;
  CommonTemplateProperties.Properties.Values[sHTTPPort] := IntToStr(HTTPPort);
  CommonTemplateProperties.Properties.Values[sKeyFilePassword] := EscapePassword(FCertFileInfo.KeyFilePassword);
  CommonTemplateProperties.Properties.Values[sRootCertFile] := EscapePath(FCertFileInfo.RootCertFile);
  CommonTemplateProperties.Properties.Values[sCertFile] := EscapePath(FCertFileInfo.CertFile);
  CommonTemplateProperties.Properties.Values[sKeyFile] := EscapePath(FCertFileInfo.KeyFile);
  CommonTemplateProperties.Properties.Values[sApacheVersion] := FApacheInfo.ApacheVersion;
  CommonTemplateProperties.Properties.Values[sApacheModule] := FApacheInfo.ApacheModule;
  CommonTemplateProperties.Properties.Values[sApacheUnit] := FApacheInfo.ApacheUnit;
  CommonTemplateProperties.Properties.Values[sFrameWorkType] := WebProject.FrameWorkType;
  if osfWindows in WebProject.PlatformTypes then
      CommonTemplateProperties.Properties.Values[sPlatformWindows] := sTrue;
  if osfLinux in WebProject.PlatformTypes then
      CommonTemplateProperties.Properties.Values[sPlatformLinux] := sTrue;
  CommonTemplateProperties.Properties.Values[sServerConstUnitName] := ServerConstUnitName;
  SetTemplateProperty(sHTTPS, HTTPS);
end;

procedure TInetExpertsCreatorsModule.CreateResourceUnit(const APersonality: string);
var
  LModuleIdent, LFormIdent, LAncestorIdent: string;
begin
  ServerContainerConst.CreateModuleIdents(APersonality, LModuleIdent, LFormIdent, LAncestorIdent);
  ServerConstUnitName := LModuleIdent;
  ServerConstSourceTemplate.TemplatePropertiesDoc.Values[sServerConstSource] := sTrue;
end;

procedure TInetExpertsCreatorsModule.WebProjectCreateModules(
  Sender: TCustomExpertsProject; const APersonality: string);
begin
  CreateModules(APersonality);
end;

procedure TInetExpertsCreatorsModule.CreateModules(const APersonality: string);
begin
  CreateConsoleModule(APersonality);
  CreateWebModule(APersonality);

  // To add the default header file as precompiled header
  if Personality = sCBuilderPersonality then
    CreatePchModule(APersonality);
  if ProjectType = ptIndyConsole then
    CreateResourceUnit(APersonality);
end;


procedure TInetExpertsCreatorsModule.CreatePchModule(const APersonality: string);
begin
  PchModule.SourceTemplateFile := PCHSourceTemplate;
  PCHSourceTemplate.TemplateDoc.Clear;
  case FProjectType of
    ptISAPI: PCHSourceTemplate.TemplatePropertiesDoc.Values[sNewIsapiPCHSource] := sTrue;
    ptCGI: PCHSourceTemplate.TemplatePropertiesDoc.Values[sNewCgiPCHSource] := sTrue;
    ptIndyForm: PCHSourceTemplate.TemplatePropertiesDoc.Values[sNewIndyVclPCHSource] := sTrue;
    ptIndyConsole: PCHSourceTemplate.TemplatePropertiesDoc.Values[sNewIndyConsolePCHSource] := sTrue;
    ptApacheTwo: PCHSourceTemplate.TemplatePropertiesDoc.Values[sNewApachePCHSource] := sTrue;
  end;
  PCHSourceTemplate.TemplatePropertiesDoc.Values[sFrameWorkType] := WebProject.FrameWorkType;
  PchModule.CreateModule;
end;

procedure TInetExpertsCreatorsModule.CreateConsoleModule(const APersonality: string);
begin
  case FProjectType of
    ptISAPI,
    ptApacheTwo,
    ptCGI: ;   // No form
    ptIndyForm:
      // Create form
      ConsoleModule.CreateModule(APersonality);
    ptIndyConsole:
      ;
  else
    Assert(False);
  end;
end;

procedure TInetExpertsCreatorsModule.CreateWebModule(const APersonality: string);
begin
  WebModule.CreateModule(APersonality);
end;

end.
