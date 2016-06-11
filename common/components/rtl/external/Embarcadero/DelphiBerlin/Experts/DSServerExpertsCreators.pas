{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerExpertsCreators;

interface

uses
  SysUtils, Classes, ExpertsProject, ExpertsTemplates, ExpertsModules,
  DSServerFeatures, InetCertFilesWizardPage, DSServerMethodsExpertsCreators;

type

  TDSServerExpertsCreatorsModule = class(TDataModule)
    CommonTemplateProperties: TExpertsTemplateProperties;
    ServerContainerModule: TExpertsModule;
    ProjectTemplate: TExpertsTemplateFile;
    DSStandAloneProject: TExpertsProject;
    ConsoleSourceTemplate: TExpertsTemplateFile;
    ServerContainerModuleIntfTemplate: TExpertsTemplateFile;
    ServerContainerModuleSourceTemplate: TExpertsTemplateFile;
    ServerContainerDFMTemplate: TExpertsTemplateFile;
    ConsoleModule: TExpertsModule;
    ConsoleIntfTemplate: TExpertsTemplateFile;
    DataSnapTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles;
    ServerConstSourceTemplate: TExpertsTemplateFile;
    ServerConstIntfTemplate: TExpertsTemplateFile;
    ServerContainerConst: TExpertsUnit;
    procedure DSStandAloneProjectCreateModules(Sender: TCustomExpertsProject;
      const APersonality: string);
  private
    FProjectLocation: string;
    FProjectType: TDSServerProjectType;
    FHTTPPort: Integer;
    FPersonality: string;
    FTCPIPPort: Integer;
    FFeatures: TDSServerFeatures;
    FSelectedClassName: TDSServerClassName;
    FServerMethodsClassName: string;
    FServerMethodsUnitName: string;
    FCertFileInfo: TDSExpertCertFileInfo;
    FHTTPSPort: Integer;
    FServerConstUnitName: string;
    procedure SetProjectType(AValue: TDSServerProjectType); virtual;
    procedure SetHTTPPort(const Value: Integer);
    //procedure SetPersonality(const Value: string);
    procedure SetTCPIPPort(const Value: Integer);
    procedure SetFeatures(const Value: TDSServerFeatures);
    procedure SetSelectedClassName(const Value: TDSServerClassName);
    procedure SetServerMethodsClassName(const Value: string);
    procedure SetServerMethodsUnitName(const Value: string);
    procedure SetCertFileInfo(const Value: TDSExpertCertFileInfo);
    procedure SetHTTPSPort(const Value: Integer);
    procedure SetProjectLocation(const Value: string);
    procedure SetConstUnitName(const Value: string);
  protected
    procedure CreateServerMethodsModule(const APersonality: string;
      out AMethodIdent, AFormIdent: string); virtual;
    procedure CreateResourceUnit(const APersonality: string);
    function GetServerMethodsCreatorModuleClass: TDSServerMethodsCreatorModuleClass; virtual;
    function IsFeatureEnabled(AValue: TDSServerFeature): Boolean;
    procedure SetBoolTemplateProperty(const AName: string; AValue: Boolean);
    procedure SetProjectOptions; virtual;
    procedure AddFiles(const APersonality: string); virtual;
    procedure UpdateProperties; virtual;
  public
    constructor Create(AOwner: TComponent); override;

    property ProjectType: TDSServerProjectType read FProjectType write SetProjectType;
    property HTTPPort: Integer read FHTTPPort write SetHTTPPort;
    property HTTPSPort: Integer read FHTTPSPort write SetHTTPSPort;
    property TCPIPPort: Integer read FTCPIPPort write SetTCPIPPort;
    property Features: TDSServerFeatures read FFeatures write SetFeatures;
    property Personality: string read FPersonality write FPersonality;
    property SelectedClassName: TDSServerClassName read FSelectedClassName write SetSelectedClassName;
    property ServerMethodsClassName: string read FServerMethodsClassName write SetServerMethodsClassName;
    property ServerMethodsUnitName: string read FServerMethodsUnitName write SetServerMethodsUnitName;
    property CertFileInfo: TDSExpertCertFileInfo write SetCertFileInfo;
    property ProjectLocation: string read FProjectLocation write SetProjectLocation;
    property ServerConstUnitName: string read FServerConstUnitName write SetConstUnitName;
  end;

var
  DSServerExpertsCreatorsModule: TDSServerExpertsCreatorsModule;

implementation

{$R *.dfm}

uses ToolsApi, DSServerDsnResStrs, DSServerExpertsTemplateProperties,
     DSServerScriptGen, PlatformAPI;


procedure TDSServerExpertsCreatorsModule.AddFiles(const APersonality: string);
begin
  if dsWebFiles in Features then
    DSServerScriptGen.AddScriptFiles(Personality, false); //don't include default (sample) proxy file
  if dsConnectors in Features then
    DSServerScriptGen.AddConnectorFiles(Personality, FProjectLocation);
end;

constructor TDSServerExpertsCreatorsModule.Create(AOwner: TComponent);
begin
  inherited;
  FPersonality := sDelphiPersonality;
  FProjectLocation := EmptyStr;
end;

procedure TDSServerExpertsCreatorsModule.SetCertFileInfo(
  const Value: TDSExpertCertFileInfo);
begin
  FCertFileInfo := Value;
  UpdateProperties;
end;

procedure TDSServerExpertsCreatorsModule.SetConstUnitName(const Value: string);
begin
  FServerConstUnitName := Value;
  UpdateProperties;
end;

procedure TDSServerExpertsCreatorsModule.SetFeatures(
  const Value: TDSServerFeatures);
begin
  FFeatures := Value;
  UpdateProperties;
end;

procedure TDSServerExpertsCreatorsModule.SetHTTPPort(const Value: Integer);
begin
  FHTTPPort := Value;
  UpdateProperties;
end;

procedure TDSServerExpertsCreatorsModule.SetHTTPSPort(const Value: Integer);
begin
  FHTTPSPort := Value;
  UpdateProperties;
end;


procedure TDSServerExpertsCreatorsModule.SetProjectLocation(const Value: string);
begin
  FProjectLocation := Value;
  if FProjectLocation <> '' then
  begin
    // Create project as named so save dialog will default to this location
    DSStandAloneProject.Unnamed := False;
  end;
  DSStandAloneProject.ProjectDirectory := Value;
  DSStandAloneProject.ProjectFileName := ExtractFileName(Value);
end;

procedure TDSServerExpertsCreatorsModule.SetProjectOptions;
begin
  DSServerScriptGen.SetCurrentProjectBuildScript(Features);
end;

procedure TDSServerExpertsCreatorsModule.SetProjectType(AValue: TDSServerProjectType);
begin
  FProjectType := AValue;
  UpdateProperties;
end;

procedure TDSServerExpertsCreatorsModule.SetSelectedClassName(
  const Value: TDSServerClassName);
begin
  FSelectedClassName := Value;
  UpdateProperties
end;

procedure TDSServerExpertsCreatorsModule.SetServerMethodsClassName(
  const Value: string);
begin
  FServerMethodsClassName := Value;
  UpdateProperties;
end;

procedure TDSServerExpertsCreatorsModule.SetServerMethodsUnitName(
  const Value: string);
begin
  FServerMethodsUnitName := Value;
  UpdateProperties;
end;

procedure TDSServerExpertsCreatorsModule.SetTCPIPPort(const Value: Integer);
begin
  FTCPIPPort := Value;
  UpdateProperties
end;

function TDSServerExpertsCreatorsModule.IsFeatureEnabled(AValue: TDSServerFeature): Boolean;
begin
  Result := [AValue] * Features <> [];
end;

procedure TDSServerExpertsCreatorsModule.SetBoolTemplateProperty(const AName: string; AValue: Boolean);
begin
  if AValue then
    CommonTemplateProperties.Properties.Values[AName] := sTrue
  else
    CommonTemplateProperties.Properties.Values[AName] := sFalse
end;

procedure TDSServerExpertsCreatorsModule.UpdateProperties;
begin
  //ServerContainerModule.AncestorName := DSServerFeatures.GetAncestorClass(FSelectedClassName);
  ProjectTemplate.TemplatePropertiesDoc.Clear;
  // Set options for project file
  case FProjectType of
    ptConsole:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sDataSnapConsoleSource] := sTrue;
      DSStandAloneProject.ProjectType := TExpertsProjectType.ptConsole;
      DSStandAloneProject.PlatformTypes := DSStandAloneProject.PlatformTypes - [osfLinux]; //add when linux is available in next release
    end;
    ptService:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sDataSnapServiceSource] := sTrue;
      DSStandAloneProject.ProjectType := TExpertsProjectType.ptConsole;
      DSStandAloneProject.PlatformTypes := DSStandAloneProject.PlatformTypes - [osfLinux];
    end;
    ptVCL:
    begin
      ProjectTemplate.TemplatePropertiesDoc.Values[sDataSnapVCLSource] := sTrue;
      DSStandAloneProject.ProjectType := TExpertsProjectType.ptApplication;
      DSStandAloneProject.PlatformTypes := DSStandAloneProject.PlatformTypes - [osfLinux];
    end;
  else
    Assert(False);
  end;
  CommonTemplateProperties.Properties.Clear;
  // Set properties
  CommonTemplateProperties.Properties.Values[sHTTPPort_1] := IntToStr(HTTPPort);
  CommonTemplateProperties.Properties.Values[sTCPIPPort_2] := IntToStr(TCPIPPort);
  CommonTemplateProperties.Properties.Values[sServerMethodsUnitName_3] := FServerMethodsUnitName;
  CommonTemplateProperties.Properties.Values[sServerMethodsClassName_4] := FServerMethodsClassName;
  CommonTemplateProperties.Properties.Values[sKeyFilePassword_5] := FCertFileInfo.KeyFilePassword;
  CommonTemplateProperties.Properties.Values[sRootCertFile_6] := FCertFileInfo.RootCertFile;
  CommonTemplateProperties.Properties.Values[sCertFile_7] := FCertFileInfo.CertFile;
  CommonTemplateProperties.Properties.Values[sKeyFile_8] := FCertFileInfo.KeyFile;
  CommonTemplateProperties.Properties.Values[sHTTPSPort_9] := IntToStr(HTTPSPort);
  CommonTemplateProperties.Properties.Values[sFrameWorkType] := DSStandAloneProject.FrameWorkType;
  // Does not apply to this wizard
  // CommonTemplateProperties.Properties.Values[sServerModuleUnitName_10] := FServerModuleUnitName;
  // Set options
  SetBoolTemplateProperty(sServerMethodsClass_1, IsFeatureEnabled(dsServerMethodClass));
  SetBoolTemplateProperty(sAuthorization_2, IsFeatureEnabled(dsAuthorization));
  SetBoolTemplateProperty(sAuthentication_3, IsFeatureEnabled(dsAuthentication));
  SetBoolTemplateProperty(sServiceMethods_4, FProjectType = ptService);
  SetBoolTemplateProperty(sRunDSServer_5, (FProjectType = ptConsole));
  SetBoolTemplateProperty(sTCPIPProtocol_6, IsFeatureEnabled(dsTCPProtocol));
  SetBoolTemplateProperty(sHTTPProtocol_7, IsFeatureEnabled(dsHTTPProtocol));
  SetBoolTemplateProperty(sIncludeSampleMethods_8, IsFeatureEnabled(dsSampleMethods));
  SetBoolTemplateProperty(sIncludeSampleWebFiles_9, False);
  SetBoolTemplateProperty(sDataSnapREST_10, False);
  SetBoolTemplateProperty(sMethodInfoOn_11, Self.SelectedClassName <> scDSServerModule);
  SetBoolTemplateProperty(sIncludeEncryptionFilters_12, IsFeatureEnabled(dsEncryptionFilters));
  SetBoolTemplateProperty(sIncludeFilters_13, IsFeatureEnabled(dsCompressionFilter) or IsFeatureEnabled(dsEncryptionFilters));
  SetBoolTemplateProperty(sIncludeCompressionFilter_14, IsFeatureEnabled(dsCompressionFilter));
  SetBoolTemplateProperty(sHTTPSProtocol_15, IsFeatureEnabled(dsHTTPSProtocol));
  SetBoolTemplateProperty(sDataSnapConnectors_16, IsFeatureEnabled(dsConnectors));
  SetBoolTemplateProperty(sIncludeJavaScriptFiles_17, IsFeatureEnabled(dsWebFiles));
  SetBoolTemplateProperty(sServerModule_18, IsFeatureEnabled(dsServerModule));
  CommonTemplateProperties.Properties.Values[sDSServerConstUnitName] := ServerConstUnitName;
end;

function TDSServerExpertsCreatorsModule.GetServerMethodsCreatorModuleClass: TDSServerMethodsCreatorModuleClass;
begin
  Result := TDSServerMethodsCreatorModule;
end;

procedure TDSServerExpertsCreatorsModule.CreateServerMethodsModule(
  const APersonality: string; out AMethodIdent, AFormIdent: string);
var
  LModuleIdent, LFormIdent, LAncestorIdent: string;
  LCreatorModule: TDSServerMethodsCreatorModule;
begin
  LCreatorModule := GetServerMethodsCreatorModuleClass.Create(nil);
  try
    LCreatorModule.CreateServerMethodsClass(Self.SelectedClassName, APersonality,
    LModuleIdent, LFormIdent, LAncestorIdent, CommonTemplateProperties.Properties);
    AMethodIdent := LModuleIdent;
    AFormIdent := LFormIdent;
  finally
    LCreatorModule.Free;
  end;
end;

procedure TDSServerExpertsCreatorsModule.CreateResourceUnit(const APersonality: string);
var
  LModuleIdent, LFormIdent, LAncestorIdent: string;
begin
  ServerContainerConst.CreateModuleIdents(APersonality, LModuleIdent, LFormIdent, LAncestorIdent);
  ServerConstUnitName := LModuleIdent;
  ServerConstSourceTemplate.TemplatePropertiesDoc.Values[sDSServerConstSource] := sTrue;
end;

procedure TDSServerExpertsCreatorsModule.DSStandAloneProjectCreateModules(
  Sender: TCustomExpertsProject; const APersonality: string);
var
  LModuleIdent, LFormIdent: string;
begin
  case FProjectType of
    ptConsole,
    ptService:
      // No additional module
      ;
    ptVCL:
      // Create form
      ConsoleModule.CreateModule(APersonality);
  else
    Assert(False);
  end;
  if (FFeatures * [TDSServerFeature.dsServerMethodClass]) <> [] then
  begin
    CreateServerMethodsModule(APersonality, LModuleIdent, LFormIdent);
    Self.ServerMethodsUnitName := LModuleIdent;
    Self.ServerMethodsClassName := LFormIdent;
  end;

  if FProjectType = ptService then
    ServerContainerModule.AncestorName := 'Service'
  else
    ServerContainerModule.AncestorName := 'DataModule';

  if FProjectType = ptConsole then
    CreateResourceUnit(APersonality);

  ServerContainerModule.CreateModule(APersonality);
  AddFiles(APersonality);

  SetProjectOptions;
end;

end.
