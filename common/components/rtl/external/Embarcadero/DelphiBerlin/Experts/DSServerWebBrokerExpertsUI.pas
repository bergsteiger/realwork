{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerWebBrokerExpertsUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InetExpertsUI, ExpertsUIWizard, DSServerFeatures, DSProjectLocationWizardPage,
  DSServerFeatureManager, FrameExtendedNextUnit;

type
  TDSServerWebBrokerExpertsUIModule = class(TInetExpertsUIModule)
    FeaturesWizardPage: TExpertsFeaturesWizardPage;
    ServerClassWizardPage: TExpertsFrameWizardPage;
    LocationWizardPage: TExpertsFrameWizardPage;
    procedure DataModuleCreate(Sender: TObject);
    procedure FeaturesWizardPageEnterPage(Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
    procedure FeaturesWizardPageFeatureChecked(
      AFeaturesWizardPage: TCustomExpertsFeaturesWizardPage);
    procedure FeaturesWizardPageWizardPageCreated(
      Sender: TCustomExpertsWizardPage);
    procedure ServerClassWizardPageCreateFrame(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure ServerClassWizardPageFrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure ServerClassWizardPageFrameOptionChanged(
      Sender: TCustomExpertsFrameWizardPage);
    procedure ApplicationTypeWizardPage1FrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure WebServerProjectWizardLoadImage(Sender: TCustomExpertsWizard;
      var AImage: TBitmap);
    procedure LocationWizardPageFrameCreate(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure ServerClassWizardPageEnterPage(Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
  private
    FSelectedClassName: TDSServerClassName;
    FWizardType: TDSWizardType;
    FFeatures: TDSServerFeatures;
    FFeatureDescriptions: TArray<TFeatureDescription>;
    procedure SetSelectedClassName(const Value: TDSServerClassName);
    function GetSelectedClassName: TDSServerClassName;
  protected
    function GetProjectLocation: string; virtual;
    procedure SetDefaults; virtual;
    procedure EnablePages; override;
    property FeatureDescriptions: TArray<TFeatureDescription> read FFeatureDescriptions write FFeatureDescriptions;
    property WizardType: TDSWizardType read FWizardType write FWizardType;
  public
    property Features: TDSServerFeatures read FFeatures write FFeatures;
    property SelectedClassName: TDSServerClassName read GetSelectedClassName write SetSelectedClassName;
    property ProjectLocation: string read GetProjectLocation;
  end;

var
  DSServerWebBrokerExpertsUIModule: TDSServerWebBrokerExpertsUIModule;

implementation

{$R *.dfm}

uses DSServerDsnResStrs, DSServerClassWizardPage, PlatformAPI,
  WebServerWizardPage, InetWiz, System.Generics.Collections;

procedure TDSServerWebBrokerExpertsUIModule.ApplicationTypeWizardPage1FrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  inherited;
  // Exclude CGI from DataSnap projects because it doesn't work well
  // with DBX connections.
  if ApplicationTypeWizardPage1.Frame <> nil then
  begin
    with TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame) do
      HiddenProjectTypes := HiddenProjectTypes + [InetWiz.ptCGI];
    TFrameExtendedNext(ApplicationTypeWizardPage1.Frame).OnGoNextFrame := OnGoNextFrame;
  end;
end;

procedure TDSServerWebBrokerExpertsUIModule.SetDefaults;
var
  LList: TList<TFeatureDescription>;
  LItem: TFeatureDescription;
begin
  WebServerProjectWizard.Caption := SNewDSWebAppExpertCaption;
//  hcDDataSnapWebApplication              = 4351;
//  hcDDataSnapStandAloneApplication       = 4352;
//  hcDDataSnapRESTApplication             = 4353;
  WizardType := wtWebBroker;
  WebServerProjectWizard.HelpContext := 4352;
  Features := [dsHTTPProtocol, dsServerMethodClass, dsSampleMethods];
  LList := TList<TFeatureDescription>.Create;
  try
    for LItem in DefaultFeatureDescriptions do
    begin
      if LItem.Feature = dsConnectors then
        if GetForceNoWebBrokerConnectors then
          continue;  // Don't add choice for connectors. 

      LList.Add(LItem);
    end;
    FeatureDescriptions := LList.ToArray;
  finally
    LList.Free;
  end;

  SelectedClassName := TDSServerClassName.scComponent;
end;

procedure TDSServerWebBrokerExpertsUIModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SetDefaults;
  EnablePages;
end;

procedure TDSServerWebBrokerExpertsUIModule.EnablePages;
begin
  inherited;

  //enable project save location page if DataSnap Connectors or WebFiles are enabled
  //Otherwise, it doesn't matter where the project is saved
  WebServerProjectWizard.PageEnabled[LocationWizardPage] :=
    (FFeatures * [dsConnectors] <> []) or (FFeatures * [dsWebFiles] <> []);
end;

procedure TDSServerWebBrokerExpertsUIModule.ServerClassWizardPageCreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
var
  LFrame: TDSServerClassFrame;
begin
  LFrame := TDSServerClassFrame.Create(AOwner);
  if FWizardType = wtWebBrokerRest then
    // ServerModules (e.g.; Midas modules) are not usefull in a REST application.
    LFrame.rbDSServerModule.Visible := False;

  LFrame.SelectedClassName := FSelectedClassName;
  AFrame := LFrame;
end;

procedure TDSServerWebBrokerExpertsUIModule.ServerClassWizardPageEnterPage(Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  TDSServerClassFrame(ServerClassWizardPage.Frame).rbDSServerModule.Visible := not (osfLinux in PlatformTypes);
end;

procedure TDSServerWebBrokerExpertsUIModule.ServerClassWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  if ServerClassWizardPage.Frame <> nil then
  begin
    TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName := FSelectedClassName;
    TFrameExtendedNext(ServerClassWizardPage.Frame).OnGoNextFrame := OnGoNextFrame;
  end;
end;

procedure TDSServerWebBrokerExpertsUIModule.ServerClassWizardPageFrameOptionChanged(
  Sender: TCustomExpertsFrameWizardPage);
begin
  FSelectedClassName := TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName;
end;


procedure TDSServerWebBrokerExpertsUIModule.SetSelectedClassName(
  const Value: TDSServerClassName);
begin
  FSelectedClassName := Value;
  if (ServerClassWizardPage.Frame <> nil) then
  begin
    TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName := Value;
  end;
end;

procedure TDSServerWebBrokerExpertsUIModule.WebServerProjectWizardLoadImage(
  Sender: TCustomExpertsWizard; var AImage: TBitmap);
begin
  AImage := TBitmap.Create;
  try
    AImage.LoadFromResourceName(HInstance, 'WIZARDDATASNAPWEBAPP');  // Do not localize
  except
    FreeAndNil(AImage);
  end;
end;

procedure TDSServerWebBrokerExpertsUIModule.FeaturesWizardPageEnterPage(
  Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  CheckFeatures(FFeatureDescriptions, TExpertsFeaturesWizardPage(Sender),
    FWizardType, FFeatures);
end;

procedure TDSServerWebBrokerExpertsUIModule.FeaturesWizardPageFeatureChecked(
  AFeaturesWizardPage: TCustomExpertsFeaturesWizardPage);
begin
  UpdateFeatures(FFeatureDescriptions, AFeaturesWizardPage, FWizardType, FFeatures);
  EnablePages;
end;

procedure TDSServerWebBrokerExpertsUIModule.FeaturesWizardPageWizardPageCreated(
  Sender: TCustomExpertsWizardPage);
begin
  Sender.Title :=  sFeaturesPageTitle;
  Sender.Description := sFeaturesPageDescription;
  AddFeatures(FFeatureDescriptions, TExpertsFeaturesWizardPage(Sender), FWizardType);
  CheckFeatures(FFeatureDescriptions, TExpertsFeaturesWizardPage(Sender),
    FWizardType, FFeatures);
end;

function TDSServerWebBrokerExpertsUIModule.GetProjectLocation: string;
begin
  if LocationWizardPage.Frame <> nil then
    Result := TDSProjectLocationWizardFrame(LocationWizardPage.Frame).ProjectLocation;
end;

function TDSServerWebBrokerExpertsUIModule.GetSelectedClassName: TDSServerClassName;
begin
  if (ServerClassWizardPage.Frame <> nil) then
    if not(osfLinux in PlatformTypes) or
      (TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName = scComponent) or
      (TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName = scDataModule) then
      Result := TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName
    else
       Result := TDSServerClassFrame.GetDefaultServerClassType
  else
    Result := TDSServerClassFrame.GetDefaultServerClassType;
end;

procedure TDSServerWebBrokerExpertsUIModule.LocationWizardPageFrameCreate(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent; out AFrame: TFrame);
begin
  AFrame := TDSProjectLocationWizardFrame.Create(AOwner);
end;

end.
