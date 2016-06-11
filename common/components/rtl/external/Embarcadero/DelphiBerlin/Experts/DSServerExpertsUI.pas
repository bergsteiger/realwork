{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerExpertsUI;

interface

uses
  SysUtils, Classes, Forms, ExpertsProject,
  ExpertsUIWizard, DSServerFeatures, DSServerFeatureManager, Graphics,
  InetCertFilesWizardPage, DSProjectLocationWizardPage, FrameExtendedNextUnit;

type
  TDSServerExpertsUIModule = class(TDataModule)
    ApplicationTypeWizardPage1: TExpertsFrameWizardPage;
    DSStandAloneAppWizard: TExpertsWizard;
    PortsWizardPage: TExpertsFrameWizardPage;
    DSStandAloneFeaturesWizardPage: TExpertsFeaturesWizardPage;
    ServerClassWizardPage: TExpertsFrameWizardPage;
    CertFilesWizardPage: TExpertsFrameWizardPage;
    LocationWizardPage: TExpertsFrameWizardPage;
    FrameWorkWizardPage: TExpertsFrameWizardPage;
    PlatformFrameWizardPage: TExpertsFrameWizardPage;
    procedure ApplicationTypeWizardPage1CreateFrame(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure PortsWizardPageCreateFrame(Sender: TCustomExpertsFrameWizardPage;
      AOwner: TComponent; out AFrame: TFrame);
    procedure DataModuleCreate(Sender: TObject);
    procedure DSStandAloneFeaturesWizardPageEnterPage(
      Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
    procedure DSStandAloneFeaturesWizardPageFeatureChecked(
      AFeaturesWizardPage: TCustomExpertsFeaturesWizardPage);
    procedure DSStandAloneFeaturesWizardPageWizardPageCreated(
      Sender: TCustomExpertsWizardPage);
    procedure ServerClassWizardPageCreateFrame(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure PortsWizardPageEnterPage(Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
    procedure DSStandAloneAppWizardLoadImage(Sender: TCustomExpertsWizard;
      var AImage: TBitmap);
    procedure DSStandAloneFeaturesWizardPageLeavingPage(
      Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition; var Allow: Boolean);
    procedure CertFilesWizardPageCreateFrame(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure CertFilesWizardPageFrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure ApplicationTypeWizardPage1FrameOptionChanged(
      Sender: TCustomExpertsFrameWizardPage);
    procedure ServerClassWizardPageFrameOptionChanged(
      Sender: TCustomExpertsFrameWizardPage);
    procedure ApplicationTypeWizardPage1FrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure ServerClassWizardPageFrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure LocationWizardPageFrameCreate(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure FrameWorkWizardPageFrameCreate(Sender: TCustomExpertsFrameWizardPage;
      AOwner: TComponent; out AFrame: TFrame);
        procedure FrameWorkWizardPageFrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure PlatformFrameWizardPageFrameCreate(Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure PlatformFrameWizardPageFrameCreated(Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure PlatformFrameWizardPageFrameOptionChanged(Sender: TCustomExpertsFrameWizardPage);
    procedure ServerClassWizardPageEnterPage(Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
  private
    FFeatures: TDSServerFeatures;
    FProjectType: TDSServerProjectType;
    FSelectedClassName: TDSServerClassName;
    FWizardType: TDSWizardType;
    FFeatureDescriptions: TArray<TFeatureDescription>;
    FShowPlatformsPage: Boolean;
    FPlatformTypes: TOSFamilySet;
    procedure OnCertFilesTest(Sender: TObject);
    procedure OnGoNextFrame(Sender: TObject);
    function GetPlatformTypes: TOSFamilySet;
    procedure SetShowPlatformsPage(AValue: Boolean);
    function GetProjectType: TDSServerProjectType;
  protected
    procedure SetDefaults; virtual;
    procedure EnablePages; virtual;
    function GetHTTPPort: Integer; virtual;
    procedure UpdatePorts; virtual;
    function GetTCPIPPort: Integer; virtual;
    procedure SetSelectedClassName(const Value: TDSServerClassName); virtual;
    function GetCertFileInfo: TDSExpertCertFileInfo; virtual;
    function GetHTTPSPort: Integer; virtual;
    function GetProjectLocation: string; virtual;
    property FeatureDescriptions: TArray<TFeatureDescription> read FFeatureDescriptions write FFeatureDescriptions;
    function GetSelectedClassName: TDSServerClassName;
  public
    constructor Create(AOwner: TComponent); override;
    property ShowPlatformsPage: Boolean read FShowPlatformsPage write SetShowPlatformsPage;
    property ProjectType: TDSServerProjectType read GetProjectType write FProjectType;
    property HTTPPort: Integer read GetHTTPPort;
    property HTTPSPort: Integer read GetHTTPSPort;
    property TCPIPPort: Integer read GetTCPIPPort;
    property Features: TDSServerFeatures read FFeatures write FFeatures;
    property SelectedClassName: TDSServerClassName read GetSelectedClassName write SetSelectedClassName;
    property CertFileInfo: TDSExpertCertFileInfo read GetCertFileInfo;
    property ProjectLocation: string read GetProjectLocation;
    property PlatformTypes: TOSFamilySet read GetPlatformTypes;
    function GetFrameWorkType: string;
  end;

var
  DSServerExpertsUIModule: TDSServerExpertsUIModule;

implementation

{$R *.dfm}

uses Dialogs, DSStandAloneAppWizardPage, DSPortsWizardPage, PlatformAPI,
  DSServerDsnResStrs, DSServerClassWizardPage, InetDesignResStrs, InetPlatformWizardPage,
  InetFrameWorkWizardPage, InetWiz, ToolsAPI, IdentityAPI;


procedure TDSServerExpertsUIModule.ApplicationTypeWizardPage1CreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
var
  LFrame: TDSStandAloneAppWizardFrame;
begin
  LFrame := TDSStandAloneAppWizardFrame.Create(AOwner);
  AFrame := LFrame;
end;

procedure TDSServerExpertsUIModule.ApplicationTypeWizardPage1FrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  if ApplicationTypeWizardPage1.Frame <>nil then
  begin
    TDSStandAloneAppWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType := FProjectType;
    TFrameExtendedNext(ApplicationTypeWizardPage1.Frame).OnGoNextFrame := OnGoNextFrame;
  end;

end;

procedure TDSServerExpertsUIModule.ApplicationTypeWizardPage1FrameOptionChanged(
  Sender: TCustomExpertsFrameWizardPage);
begin
  FProjectType := TDSStandAloneAppWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType;
  EnablePages;
end;

procedure TDSServerExpertsUIModule.CertFilesWizardPageCreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
var
  LFrame: TInetCertFilesWizardFrame;
begin
  LFrame := TInetCertFilesWizardFrame.Create(AOwner);
  AFrame := LFrame;
end;

procedure TDSServerExpertsUIModule.CertFilesWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  TInetCertFilesWizardFrame(AFrame).OnTest := OnCertFilesTest;
end;

constructor TDSServerExpertsUIModule.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TDSServerExpertsUIModule.OnCertFilesTest(Sender: TObject);
begin
  TInetCertFilesWizardFrame(CertFilesWizardPage.Frame).TestCertFiles(Self.HTTPSPort);
end;

procedure TDSServerExpertsUIModule.OnGoNextFrame(Sender: TObject);
begin
  DSStandAloneAppWizard.NextOrFinish;
end;

procedure TDSServerExpertsUIModule.SetDefaults;
begin
//  hcDDataSnapWebApplication              = 4351;
//  hcDDataSnapStandAloneApplication       = 4352;
//  hcDDataSnapRESTApplication             = 4353;
  DSStandAloneAppWizard.HelpContext := 4352;
  ProjectType := ptVCL;
  Features := [dsTCPProtocol, dsServerMethodClass, dsSampleMethods];
  FFeatureDescriptions := DefaultFeatureDescriptions;
  SelectedClassName := TDSServerClassName.scComponent;
end;

procedure TDSServerExpertsUIModule.DataModuleCreate(Sender: TObject);
begin
  FWizardType := wtStandAlone;
  FPlatformTypes := TInetPlatformWizardFrame.GetDefaultPlatformType;
  SetDefaults;
  EnablePages;
end;

procedure TDSServerExpertsUIModule.EnablePages;
begin
  DSStandAloneAppWizard.PageEnabled[PlatformFrameWizardPage] := ShowPlatformsPage;
  DSStandAloneAppWizard.PageEnabled[CertFilesWizardPage] :=
    (FFeatures * [dsHTTPSProtocol] <> []);

  DSStandAloneAppWizard.PageEnabled[FrameWorkWizardPage] :=
    FprojectType = ptVCL;
  //enable project save location page if DataSnap Connectors are enabled
  //otherwise, it doesn't matter where the project is saved
  DSStandAloneAppWizard.PageEnabled[LocationWizardPage] :=
    (FFeatures * [dsConnectors] <> []) or (FFeatures * [dsWebFiles] <> []);
//   Hide page when no VCL (e.g.; AppMethod) or Console or SErvice or Linux
  DSStandAloneAppWizard.PageEnabled[FrameworkWizardPage] :=
    (Identity = nil) or (Identity.SupportsString(TBaseIdentity.SupportedDesignerFrameworks) and
	(Pos(sFrameworkTypeVCL, Identity.IdentityString[TBaseIdentity.SupportedDesignerFrameworks]) > 0)) and
  not ((FprojectType = ptConsole ) or (FprojectType = ptService)) and
  not (osfLinux in PlatformTypes);

  DSStandAloneAppWizard.PageEnabled[ApplicationTypeWizardPage1] := not (osfLinux in PlatformTypes);
//  DSStandAloneAppWizard.PageEnabled[ServerClassWizardPage] := not (osfLinux in PlatformTypes);
end;

procedure TDSServerExpertsUIModule.FrameWorkWizardPageFrameCreate(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
begin
    AFrame := TInetFrameWorkWizardFrame.Create(AOwner);
end;

procedure TDSServerExpertsUIModule.FrameWorkWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  if FrameWorkWizardPage.Frame <> nil then
  begin
    TInetFrameWorkWizardFrame(FrameWorkWizardPage.Frame).FrameWorkType := TInetFrameWorkWizardFrame.GetDefaultFrameWorkType;
    TFrameExtendedNext(FrameWorkWizardPage.Frame).OnGoNextFrame := OnGoNextFrame;
  end;
end;

function TDSServerExpertsUIModule.GetCertFileInfo: TDSExpertCertFileInfo;
begin
  if CertFilesWizardPage.Frame <> nil then
    Result := TInetCertFilesWizardFrame(CertFilesWizardPage.Frame).CertFileInfo;
end;

function TDSServerExpertsUIModule.GetFrameWorkType: string;
var
  LFrameWorkType : TFrameWorkType;
begin
  if FrameWorkWizardPage.Frame <> nil then
    LFrameWorkType := TInetFrameWorkWizardFrame(FrameWorkWizardPage.Frame).FrameWorkType
  else
    LFrameWorkType := TInetFrameWorkWizardFrame.GetDefaultFrameWorkType;
  if LFrameWorkType = frameworkVCL then
    Result := sFrameworkTypeVCL
  else if LFrameWorkType = frameworkFMX then
    Result := sFrameworkTypeFMX;
end;

function TDSServerExpertsUIModule.GetHTTPPort: Integer;
begin
  Result := 0;
  if PortsWizardPage.Frame <> nil then
  begin
    Result := TDSPortsWizardFrame(PortsWizardPage.Frame).Ports[portHTTP];
  end;
end;

function TDSServerExpertsUIModule.GetHTTPSPort: Integer;
begin
  Result := 0;
  if PortsWizardPage.Frame <> nil then
  begin
    Result := TDSPortsWizardFrame(PortsWizardPage.Frame).Ports[portHTTPS];
  end;
end;

function TDSServerExpertsUIModule.GetPlatformTypes: TOSFamilySet;
begin
  if PlatformFrameWizardPage.Frame <> nil then
    Result := TInetPlatformWizardFrame(PlatformFrameWizardPage.Frame).PlatformTypes
  else
    Result := TInetPlatformWizardFrame.GetDefaultPlatformType;
end;

function TDSServerExpertsUIModule.GetProjectLocation: string;
begin
  if LocationWizardPage.Frame <> nil then
    Result := TDSProjectLocationWizardFrame(LocationWizardPage.Frame).ProjectLocation
  else
    Result := EmptyStr;
end;

function TDSServerExpertsUIModule.GetProjectType: TDSServerProjectType;
begin
  if ApplicationTypeWizardPage1.Frame <> nil then
  begin
    if not (osfLinux in PlatformTypes) or
      (TDSStandAloneAppWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType = ptConsole) then
      Result := TDSStandAloneAppWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType
    else
      Result := TDSStandAloneAppWizardFrame.GetDefaultApplicationType
  end
  else
    Result := TDSStandAloneAppWizardFrame.GetDefaultApplicationType;
end;

function TDSServerExpertsUIModule.GetSelectedClassName: TDSServerClassName;
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

function TDSServerExpertsUIModule.GetTCPIPPort: Integer;
begin
  Result := 0;
  if PortsWizardPage.Frame <> nil then
  begin
    Result := TDSPortsWizardFrame(PortsWizardPage.Frame).Ports[portTCPIP];
  end;
end;

procedure TDSServerExpertsUIModule.LocationWizardPageFrameCreate(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent; out AFrame: TFrame);
begin
  AFrame := TDSProjectLocationWizardFrame.Create(AOwner);
end;

procedure TDSServerExpertsUIModule.PlatformFrameWizardPageFrameCreate(Sender: TCustomExpertsFrameWizardPage;
  AOwner: TComponent; out AFrame: TFrame);
begin
  AFrame := TInetPlatformWizardFrame.Create(AOwner);
end;

procedure TDSServerExpertsUIModule.PlatformFrameWizardPageFrameCreated(Sender: TCustomExpertsFrameWizardPage;
  AFrame: TFrame);
begin
  if PlatformFrameWizardPage.Frame <> nil then
  begin
    TInetPlatformWizardFrame(PlatformFrameWizardPage.Frame).PlatformTypes := FPlatformTypes;
    TFrameExtendedNext(PlatformFrameWizardPage.Frame).OnGoNextFrame := OnGoNextFrame;
  end;
end;

procedure TDSServerExpertsUIModule.PlatformFrameWizardPageFrameOptionChanged(Sender: TCustomExpertsFrameWizardPage);
begin
  FPlatformTypes := TInetPlatformWizardFrame(PlatformFrameWizardPage.Frame).PlatformTypes;
  EnablePages;
end;

procedure TDSServerExpertsUIModule.PortsWizardPageCreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
var
  LFrame: TDSPortsWizardFrame;
begin
  LFrame := TDSPortsWizardFrame.Create(AOwner);
  AFrame := LFrame;
end;

procedure TDSServerExpertsUIModule.PortsWizardPageEnterPage(
  Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  UpdatePorts;
end;

const
  nDefaultHTTPPort = 8080;
  nDefaultHTTPsPort = 8081;
  nDefaultTCPIPPort = 211;

procedure TDSServerExpertsUIModule.UpdatePorts;
var
  LPorts: TDSPortDescriptions;

  procedure AddPort(APort: TDSAvailablePort; ADefaultValue: Integer; const ALabel: string);
  var
    LDescription: TDSPortDescription;
  begin
    LDescription.Port := APort;
    LDescription.DefaultValue := ADefaultValue;
    LDescription.PortLabel := ALabel;
    SetLength(LPorts, Length(LPorts)+1);
    LPorts[Length(LPorts)-1] := LDescription;
  end;
begin
  if PortsWizardPage.Frame <>  nil then
  begin
    if dsTCPProtocol in FFeatures then
      AddPort(portTCPIP, nDefaultTCPIPPort, sTCPIPPortLabel);
    if (dsHTTPProtocol in FFeatures) or (dsWebServerPort in FFeatures) then
      AddPort(portHTTP, nDefaultHTTPPort, sHTTPPortLabel);
    if dsHTTPSProtocol in FFeatures then
      AddPort(portHTTPS, nDefaultHTTPSPort, sHTTPSPortLabel);
    TDSPortsWizardFrame(PortsWizardPage.Frame).PortDescriptions := LPorts;
  end;
end;

procedure TDSServerExpertsUIModule.ServerClassWizardPageCreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
var
  LFrame: TDSServerClassFrame;
begin
  LFrame := TDSServerClassFrame.Create(AOwner);
  AFrame := LFrame;
end;

procedure TDSServerExpertsUIModule.ServerClassWizardPageEnterPage(Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  TDSServerClassFrame(ServerClassWizardPage.Frame).rbDSServerModule.Visible := not (osfLinux in FPlatformTypes);
end;

procedure TDSServerExpertsUIModule.ServerClassWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  if ServerClassWizardPage.Frame <> nil then
  begin
    TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName := FSelectedClassName;
    TFrameExtendedNext(ServerClassWizardPage.Frame).OnGoNextFrame := OnGoNextFrame;
  end;
end;

procedure TDSServerExpertsUIModule.ServerClassWizardPageFrameOptionChanged(
  Sender: TCustomExpertsFrameWizardPage);
begin
  FSelectedClassName := TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName;
end;

procedure TDSServerExpertsUIModule.SetSelectedClassName(
  const Value: TDSServerClassName);
begin
  FSelectedClassName := Value;
  if (ServerClassWizardPage.Frame <> nil) then
  begin
    TDSServerClassFrame(ServerClassWizardPage.Frame).SelectedClassName := Value;
  end;
end;

procedure TDSServerExpertsUIModule.SetShowPlatformsPage(AValue: Boolean);
begin
  FShowPlatformsPage := AValue;
  EnablePages;
end;

procedure TDSServerExpertsUIModule.DSStandAloneAppWizardLoadImage(
  Sender: TCustomExpertsWizard; var AImage: TBitmap);
begin
  AImage := TBitmap.Create;
  try
    AImage.LoadFromResourceName(HInstance, 'WIZARDDATASNAPSTANDALONEAPP');  // Do not localize
  except
    FreeAndNil(AImage);
  end;
end;

procedure TDSServerExpertsUIModule.DSStandAloneFeaturesWizardPageEnterPage(
  Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  CheckFeatures(FFeatureDescriptions, TExpertsFeaturesWizardPage(Sender),
    FWizardType, FFeatures);
end;

procedure TDSServerExpertsUIModule.DSStandAloneFeaturesWizardPageFeatureChecked(
  AFeaturesWizardPage: TCustomExpertsFeaturesWizardPage);
begin
  UpdateFeatures(FFeatureDescriptions, AFeaturesWizardPage, FWizardType, FFeatures);
  EnablePages;
end;

procedure TDSServerExpertsUIModule.DSStandAloneFeaturesWizardPageLeavingPage(
  Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition; var Allow: Boolean);
begin
  // Must have at least one protocol
  if (FFeatures * [dsTCPProtocol, dsHTTPProtocol, dsHTTPSProtocol]) = []  then
    Include(FFeatures, dsTCPProtocol);
end;

procedure TDSServerExpertsUIModule.DSStandAloneFeaturesWizardPageWizardPageCreated(
  Sender: TCustomExpertsWizardPage);
begin
  Sender.Title :=  sFeaturesPageTitle;
  Sender.Description := sFeaturesPageDescription;
  AddFeatures(FFeatureDescriptions, TExpertsFeaturesWizardPage(Sender), FWizardType);
  CheckFeatures(FFeatureDescriptions, TExpertsFeaturesWizardPage(Sender),
    FWizardType, FFeatures);
end;

end.
