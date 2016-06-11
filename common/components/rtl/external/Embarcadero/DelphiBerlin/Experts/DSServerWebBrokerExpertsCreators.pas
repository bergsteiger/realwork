{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerWebBrokerExpertsCreators;

// This module derives from the internet creator module.  Some component properties have
// been overridden to support DataSnap.  For example, the webmodule template file a DataSnap file rather
// than internet file.   View as text to see the override properties.
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InetExpertsCreators, ExpertsProject, ExpertsTemplates, ExpertsModules,
    DSServerFeatures, DSServerMethodsExpertsCreators;

type
  TDSServerWebBrokerExpertsCreatorsModule = class(TInetExpertsCreatorsModule)
    DataSnapTemplatePersonalityFiles: TExpertsTemplatePersonalityFiles;
    ServerContainerModuleSourceTemplate: TExpertsTemplateFile;
    ServerContainerDFMTemplate: TExpertsTemplateFile;
    ServerContainerModuleIntfTemplate: TExpertsTemplateFile;
    ServerContainerModule: TExpertsModule;
  private
    FProjectLocation: string;
    FSelectedClassName: TDSServerClassName;
    FFeatures: TDSServerFeatures;
    FServerMethodsClassName: string;
    FServerMethodsUnitName: string;
    FServerModuleUnitName: string;
    procedure SetFeatures(const Value: TDSServerFeatures);
    procedure SetSelectedClassName(const Value: TDSServerClassName);
    procedure SetServerMethodsClassName(const Value: string);
    procedure SetServerMethodsUnitName(const Value: string);
    procedure SetServerModuleUnitName(const Value: string);
  protected
    function IsFeatureEnabled(AValue: TDSServerFeature): Boolean;
    procedure SetBoolTemplateProperty(const AName: string; AValue: Boolean);
    procedure CreateServerMethodsModule(const APersonality: string;
      out AMethodIdent, AFormIdent: string); virtual;
    procedure UpdateProperties;  override;
    procedure CreateModules(const APersonality: string); override;
    function GetServerMethodsCreatorModuleClass: TDSServerMethodsCreatorModuleClass; virtual;
    procedure AddFiles(const APersonality: string); virtual;
    procedure SetProjectOptions; virtual;
    procedure SetProjectLocation(const Value: string); virtual;
  public
    property Features: TDSServerFeatures read FFeatures write SetFeatures;
    property SelectedClassName: TDSServerClassName read FSelectedClassName write SetSelectedClassName;
    property ServerMethodsClassName: string read FServerMethodsClassName write SetServerMethodsClassName;
    property ServerMethodsUnitName: string read FServerMethodsUnitName write SetServerMethodsUnitName;
    property ServerModuleUnitName: string read FServerModuleUnitName write SetServerModuleUnitName;
    property ProjectLocation: string read FProjectLocation write SetProjectLocation;
  end;

var
  DSServerWebBrokerExpertsCreatorsModule: TDSServerWebBrokerExpertsCreatorsModule;

implementation

{$R *.dfm}

uses DSServerExpertsTemplateProperties,
  InetExpertsTemplateProperties, InetWiz, DSServerScriptGen;

procedure TDSServerWebBrokerExpertsCreatorsModule.AddFiles(const APersonality: string);
begin
  if dsConnectors in Features then
    DSServerScriptGen.AddConnectorFiles(Personality);
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.CreateServerMethodsModule(
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

procedure TDSServerWebBrokerExpertsCreatorsModule.CreateModules(
  const APersonality: string);
var
  LModuleIdent, LFormIdent, LAncestorIdent: string;
begin
  CreateConsoleModule(APersonality);
  if (FFeatures * [TDSServerFeature.dsServerMethodClass]) <> [] then
  begin
    CreateServerMethodsModule(APersonality, LModuleIdent, LFormIdent);
    Self.ServerMethodsUnitName := LModuleIdent;
    Self.ServerMethodsClassName := LFormIdent;
  end;
  if (FFeatures * [TDSServerFeature.dsServerModule]) <> [] then
  begin
    ServerContainerModule.AncestorName := 'DataModule';
    ServerContainerModule.CreateModuleIdents(APersonality, LModuleIdent, LFormIdent, LAncestorIdent);
    Self.ServerModuleUnitName := LModuleIdent;
  end;

  // Must create after we create server methods module and server container module,
  // so that classname and unit can be inserted
  CreateWebModule(APersonality);
  if ProjectType = ptIndyConsole then
    CreateResourceUnit(APersonality);
  AddFiles(APersonality);

  SetProjectOptions;
end;

function TDSServerWebBrokerExpertsCreatorsModule.GetServerMethodsCreatorModuleClass: TDSServerMethodsCreatorModuleClass;
begin
  Result := TDSServerMethodsCreatorModule;
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.SetFeatures(
  const Value: TDSServerFeatures);
begin
  FFeatures := Value;
  UpdateProperties;
end;

// Project executable must be relative to static files (js, html, DataSnap Connector proxy dir, etc.)
procedure TDSServerWebBrokerExpertsCreatorsModule.SetProjectLocation(const Value: string);
begin
  FProjectLocation := Value;
  if FProjectLocation <> '' then
  begin
    // Create project as named so save dialog will default to this location
    WebProject.Unnamed := False;
  end;
  WebProject.ProjectDirectory := Value;
  WebProject.ProjectFileName := ExtractFileName(Value);
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.SetProjectOptions;
begin
  DSServerScriptGen.SetCurrentProjectBuildScript(Features);
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.SetSelectedClassName(
  const Value: TDSServerClassName);
begin
  FSelectedClassName := Value;
  UpdateProperties
end;

function TDSServerWebBrokerExpertsCreatorsModule.IsFeatureEnabled(AValue: TDSServerFeature): Boolean;
begin
  Result := [AValue] * Features <> [];
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.SetBoolTemplateProperty(const AName: string; AValue: Boolean);
begin
  if AValue then
    CommonTemplateProperties.Properties.Values[AName] := sTrue
  else
    CommonTemplateProperties.Properties.Values[AName] := sFalse
end;


procedure TDSServerWebBrokerExpertsCreatorsModule.UpdateProperties;
begin
  inherited;
  CommonTemplateProperties.Properties.Values[sDBXTerminateThreads] := sTrue;
  // Commented properties do not apply

//  CommonTemplateProperties.Properties.Values[sHTTPPort_1] := FServerMethodsUnitName;
//  CommonTemplateProperties.Properties.Values[sTCPIPPort_2] := FServerMethodsUnitName;
  CommonTemplateProperties.Properties.Values[sServerMethodsUnitName_3] := FServerMethodsUnitName;
  CommonTemplateProperties.Properties.Values[sServerMethodsClassName_4] := FServerMethodsClassName;
  CommonTemplateProperties.Properties.Values[sServerModuleUnitName_10] := FServerModuleUnitName;
  SetBoolTemplateProperty(sServerMethodsClass_1, IsFeatureEnabled(dsServerMethodClass));
  SetBoolTemplateProperty(sAuthorization_2, IsFeatureEnabled(dsAuthorization));
  SetBoolTemplateProperty(sAuthentication_3, IsFeatureEnabled(dsAuthentication));
//  SetTemplateProperty(sServiceMethods_4, FProjectType = ptService);
//  SetTemplateProperty(sRunDSServer_5, (FProjectType = ptConsole));
//  SetTemplateProperty(sTCPIPProtocol_6, IsFeatureEnabled(dsTCPProtocol));
//  SetTemplateProperty(sHTTPProtocol_7, IsFeatureEnabled(dsHTTPProtocol));
  SetBoolTemplateProperty(sIncludeSampleMethods_8, IsFeatureEnabled(dsSampleMethods));
  SetBoolTemplateProperty(sIncludeSampleWebFiles_9, False);
  SetBoolTemplateProperty(sDataSnapREST_10, False);
  SetBoolTemplateProperty(sMethodInfoOn_11, Self.SelectedClassName <> scDSServerModule);
  SetBoolTemplateProperty(sIncludeEncryptionFilters_12, IsFeatureEnabled(dsEncryptionFilters));
  SetBoolTemplateProperty(sIncludeFilters_13, IsFeatureEnabled(dsCompressionFilter) or IsFeatureEnabled(dsEncryptionFilters));
  SetBoolTemplateProperty(sIncludeCompressionFilter_14, IsFeatureEnabled(dsCompressionFilter));
//  SetTemplateProperty(sHTTPSProtocol_15, IsFeatureEnabled(dsHTTPSProtocol));
  if GetForceNoWebBrokerConnectors then
    // Never select connectors
    SetBoolTemplateProperty(sDataSnapConnectors_16, False)
  else
    SetBoolTemplateProperty(sDataSnapConnectors_16, IsFeatureEnabled(dsConnectors));
  SetBoolTemplateProperty(sServerModule_18, IsFeatureEnabled(dsServerModule));
  if GetForceDSRESTDispatcher then
    // Always select REST dispatcher
    SetBoolTemplateProperty(sRESTDispatcher_19, True)
  else
    SetBoolTemplateProperty(sRESTDispatcher_19, IsFeatureEnabled(dsRESTDispatcher));
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.SetServerMethodsClassName(
  const Value: string);
begin
  FServerMethodsClassName := Value;
  UpdateProperties;
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.SetServerMethodsUnitName(
  const Value: string);
begin
  FServerMethodsUnitName := Value;
  UpdateProperties;
end;

procedure TDSServerWebBrokerExpertsCreatorsModule.SetServerModuleUnitName(
  const Value: string);
begin
  FServerModuleUnitName := Value;
  UpdateProperties;
end;

end.
