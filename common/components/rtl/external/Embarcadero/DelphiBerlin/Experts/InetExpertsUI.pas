{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit InetExpertsUI;

interface

uses
  SysUtils, Classes, Forms, WebServerWizardPage,
  ExpertsUIWizard, InetWiz, Graphics, InetCertFilesWizardPage, InetApacheWizardPage,
  FrameExtendedNextUnit, InetFrameWorkWizardPage, ExpertsProject, InetPlatformWizardPage;

type
  TInetExpertsUIModule = class(TDataModule)
    ApplicationTypeWizardPage1: TExpertsFrameWizardPage;
    WebServerProjectWizard: TExpertsWizard;
    PortsWizardPage: TExpertsFrameWizardPage;
    CertFilesWizardPage: TExpertsFrameWizardPage;
    ApacheWizardPage: TExpertsFrameWizardPage;
    FrameWorkWizardPage: TExpertsFrameWizardPage;
    PlatformFrameWizardPage: TExpertsFrameWizardPage;
    procedure ApplicationTypeWizardPage1CreateFrame(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure PortsWizardPageCreateFrame(Sender: TCustomExpertsFrameWizardPage;
      AOwner: TComponent; out AFrame: TFrame);
    procedure DataModuleCreate(Sender: TObject);
    procedure PortsWizardPageFrameOptionChanged(
      Sender: TCustomExpertsFrameWizardPage);
    procedure ApplicationTypeWizardPage1FrameOptionChanged(
      Sender: TCustomExpertsFrameWizardPage);
    procedure ApplicationTypeWizardPage1FrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure PortsWizardPageFrameCreated(Sender: TCustomExpertsFrameWizardPage;
      AFrame: TFrame);
    procedure PortsWizardPageEnterPage(Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
    procedure WebServerProjectWizardLoadImage(Sender: TCustomExpertsWizard;
      var AImage: TBitmap);
    procedure CertFilesWizardPageCreateFrame(
      Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure CertFilesWizardPageFrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure OnCertFilesTest(Sender: TObject);
    procedure ApacheWizardPageFrameCreate(Sender: TCustomExpertsFrameWizardPage;
      AOwner: TComponent; out AFrame: TFrame);
    procedure ApacheWizardPageFrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure OnVersionChanged(Sender: TObject);
    procedure FrameWorkWizardPageFrameCreate(Sender: TCustomExpertsFrameWizardPage;
      AOwner: TComponent; out AFrame: TFrame);
    procedure FrameWorkWizardPageFrameCreated(
      Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure PlatformFrameWizardPageFrameCreate(Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
      out AFrame: TFrame);
    procedure PlatformFrameWizardPageFrameCreated(Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
    procedure PlatformFrameWizardPageFrameOptionChanged(Sender: TCustomExpertsFrameWizardPage);
    procedure ApplicationTypeWizardPage1EnterPage(Sender: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
  private
    FProjectType: TProjectType;
    FPlatformTypes: TOSFamilySet;
    FHTTPS: Boolean;
    FHTTPPort: Integer;
    FShowPlatformsPage: Boolean;
    function GetCertFileInfo: TDSExpertCertFileInfo;
    function GetHTTPPort: Integer;
    function GetApacheInfo: TApacheInfo;
    function GetPlatformTypes: TOSFamilySet;
    procedure SetShowPlatformsPage(AValue: Boolean);
    function GetProjectType: TProjectType;
  protected
    procedure EnablePages; virtual;
    procedure OnGoNextFrame(Sender: TObject);
  public
    { Public declarations }
    property ShowPlatformsPage: Boolean read FShowPlatformsPage write SetShowPlatformsPage;
    property ProjectType: TProjectType read GetProjectType write FProjectType;
    property HTTPPort: Integer read GetHTTPPort;
    property HTTPS: Boolean read FHTTPS;
    property CertFileInfo: TDSExpertCertFileInfo read GetCertFileInfo;
    property ApacheInfo: TApacheInfo read GetApacheInfo;
    property PlatformTypes: TOSFamilySet read GetPlatformTypes;
    function GetFrameWorkType: string;
  end;

var
  InetExpertsUIModule: TInetExpertsUIModule;

implementation

{$R *.dfm}

uses InetHTTPPortWizardPage, Dialogs, InetDesignResStrs, ToolsAPI, IdentityAPI, PlatformAPI;


procedure TInetExpertsUIModule.ApacheWizardPageFrameCreate(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
var
  LFrame: TInetApacheWizardFrame;
begin
  LFrame := TInetApacheWizardFrame.Create(AOwner);
  AFrame := LFrame;
end;

procedure TInetExpertsUIModule.OnVersionChanged(Sender: TObject);
begin
  TInetApacheWizardFrame(ApacheWizardPage.Frame).VersionChanged(Self);
end;

procedure TInetExpertsUIModule.ApacheWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
var
  I: Integer;
begin
  for I := 0 to ApacheVersionCount do
    TInetApacheWizardFrame(ApacheWizardPage.Frame).cbApacheVersion.Items.Add(sApacheVersion[I]);
  TInetApacheWizardFrame(ApacheWizardPage.Frame).cbApacheVersion.ItemIndex := ApacheDefaultVersion;
  TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheVersion:= sApacheVersion[ApacheDefaultVersion];
  TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheUnit := sApacheImpl[ApacheDefaultVersion];
  TInetApacheWizardFrame(ApacheWizardPage.Frame).edApacheUnit.Text := sApacheImpl[ApacheDefaultVersion];
  TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheModule := sDefaultModule;
  TInetApacheWizardFrame(ApacheWizardPage.Frame).edApacheModule.Text := sDefaultModule;
  TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheFileName := sDefaultFileName;
  TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheInfo := GetApacheInfo;
  TInetApacheWizardFrame(ApacheWizardPage.Frame).OnVersionChange := OnVersionChanged;
end;

procedure TInetExpertsUIModule.ApplicationTypeWizardPage1CreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
begin
  AFrame := TWebServerWizardFrame.Create(AOwner);
end;

procedure TInetExpertsUIModule.ApplicationTypeWizardPage1EnterPage(Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).CreateNewIndyApp.Visible := not (osfLinux in FPlatformTypes);
  TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).CreateNewISAPIApp.Visible := not (osfLinux in FPlatformTypes);
  TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).CreateNewCGIApp.Visible := not (osfLinux in FPlatformTypes);
end;

procedure TInetExpertsUIModule.ApplicationTypeWizardPage1FrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  if ApplicationTypeWizardPage1.Frame <> nil then
  begin
    TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType := FProjectType;
    TFrameExtendedNext(ApplicationTypeWizardPage1.Frame).OnGoNextFrame:= OnGoNextFrame;
  end;
end;

procedure TInetExpertsUIModule.ApplicationTypeWizardPage1FrameOptionChanged(
  Sender: TCustomExpertsFrameWizardPage);
begin
  FProjectType := TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType;
  EnablePages;
end;

procedure TInetExpertsUIModule.DataModuleCreate(Sender: TObject);
begin
  WebServerProjectWizard.HelpContext := 1655;
  FProjectType := ptIndyForm;
  FPlatformTypes := TInetPlatformWizardFrame.GetDefaultPlatformType;
  FHTTPPort := 8080;
  FHTTPS := False;
  EnablePages;
end;

procedure TInetExpertsUIModule.EnablePages;
begin
  WebServerProjectWizard.PageEnabled[PlatformFrameWizardPage] := ShowPlatformsPage;
  WebServerProjectWizard.PageEnabled[PortsWizardPage] :=
    (FprojectType = ptIndyForm) or (FProjectType = ptIndyConsole);
  WebServerProjectWizard.PageEnabled[CertFilesWizardPage] :=
    FHTTPS and ((FProjectType = ptIndyForm) or (FProjectType = ptIndyConsole));
  WebServerProjectWizard.PageEnabled[ApacheWizardPage] :=
    FProjectType = ptApacheTwo;
  // Hide page when no VCL (e.g.: AppMethod) or Console App or ISAPI dll or Apache Module
  WebServerProjectWizard.PageEnabled[FrameworkWizardPage] :=
    (Identity = nil) or (Identity.SupportsString(TBaseIdentity.SupportedDesignerFrameworks) and
    not (osfLinux in PlatformTypes) and
	  (Pos(sFrameworkTypeVCL, Identity.IdentityString[TBaseIdentity.SupportedDesignerFrameworks]) > 0)) and
    not ((FprojectType = ptIndyConsole) or (FprojectType = ptISAPI) or (FprojectType = ptApacheTwo) or (FprojectType = ptCGI));
end;

procedure TInetExpertsUIModule.FrameWorkWizardPageFrameCreate(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
begin
  AFrame := TInetFrameWorkWizardFrame.Create(AOwner);
end;

procedure TInetExpertsUIModule.FrameWorkWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  if FrameWorkWizardPage.Frame <> nil then
  begin
    TInetFrameWorkWizardFrame(FrameWorkWizardPage.Frame).FrameWorkType := TInetFrameWorkWizardFrame.GetDefaultFrameWorkType;
    TFrameExtendedNext(FrameWorkWizardPage.Frame).OnGoNextFrame := OnGoNextFrame;
  end;
end;

function TInetExpertsUIModule.GetCertFileInfo: TDSExpertCertFileInfo;
begin
  if CertFilesWizardPage.Frame <> nil then
    Result := TInetCertFilesWizardFrame(CertFilesWizardPage.Frame).CertFileInfo;
end;

function TInetExpertsUIModule.GetFrameWorkType: string;
var
  LFrameWorkType : TFrameWorkType;
begin
  if FrameWorkWizardPage.Frame <> nil then
    LFrameWorkType := TInetFrameWorkWizardFrame(FrameWorkWizardPage.Frame).FrameWorkType
  else
    LFrameWorkType := TInetFrameWorkWizardFrame.GetDefaultFrameWorkType;
  if  LFrameWorkType = frameworkVCL then
    Result := sFrameworkTypeVCL
  else if LFrameWorkType = frameworkFMX then
    Result := sFrameworkTypeFMX;
end;

function TInetExpertsUIModule.GetApacheInfo: TApacheInfo;
var
  LApacheInfo: TApacheInfo;
begin
  if ApacheWizardPage.Frame <> nil then
  begin
    LApacheInfo.ApacheVersion := TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheVersion;
    LApacheInfo.ApacheUnit := TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheUnit;
    LApacheInfo.ApacheModule := TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheModule;
    LApacheInfo.ApacheFileName := TInetApacheWizardFrame(ApacheWizardPage.Frame).ApacheFileName;
    Result := LApacheInfo;
  end;
end;

function TInetExpertsUIModule.GetHTTPPort: Integer;
begin
  if PortsWizardPage.Frame <> nil then
    Result := TInetHTTPPortWizardFrame(PortsWizardPage.Frame).Port
  else
    Result := FHTTPPort;
end;

function TInetExpertsUIModule.GetPlatformTypes: TOSFamilySet;
begin
  if PlatformFrameWizardPage.Frame <> nil then
    Result := TInetPlatformWizardFrame(PlatformFrameWizardPage.Frame).PlatformTypes
  else
    Result := TInetPlatformWizardFrame.GetDefaultPlatformType;
end;

function TInetExpertsUIModule.GetProjectType: TProjectType;
begin
  if ApplicationTypeWizardPage1.Frame <> nil then
  begin
    if not (osfLinux in PlatformTypes) or
      (TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType = ptApacheTwo)
        or (TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType = ptIndyConsole ) then 
      Result := TWebServerWizardFrame(ApplicationTypeWizardPage1.Frame).ProjectType
    else
      Result := TWebServerWizardFrame.GetDefaultApplicationType
  end
  else
    Result := TWebServerWizardFrame.GetDefaultApplicationType;
end;

procedure TInetExpertsUIModule.PlatformFrameWizardPageFrameCreate(Sender: TCustomExpertsFrameWizardPage;
  AOwner: TComponent; out AFrame: TFrame);
begin
  AFrame := TInetPlatformWizardFrame.Create(AOwner);
end;

procedure TInetExpertsUIModule.PlatformFrameWizardPageFrameCreated(Sender: TCustomExpertsFrameWizardPage;
  AFrame: TFrame);
begin
  if PlatformFrameWizardPage.Frame <> nil then
  begin
    TInetPlatformWizardFrame(PlatformFrameWizardPage.Frame).PlatformTypes := FPlatformTypes;
    TFrameExtendedNext(PlatformFrameWizardPage.Frame).OnGoNextFrame := OnGoNextFrame;
  end;
end;

procedure TInetExpertsUIModule.PlatformFrameWizardPageFrameOptionChanged(Sender: TCustomExpertsFrameWizardPage);
begin
  FPlatformTypes := TInetPlatformWizardFrame(PlatformFrameWizardPage.Frame).PlatformTypes;
  EnablePages;
end;

procedure TInetExpertsUIModule.PortsWizardPageCreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
begin
  AFrame := TInetHTTPPortWizardFrame.Create(AOwner);
end;

procedure TInetExpertsUIModule.PortsWizardPageEnterPage(
  Sender: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  TInetHTTPPortWizardFrame(PortsWizardPage.Frame).AllowHTTPS :=
    (FProjectType = ptIndyForm) or (FProjecttype = ptIndyConsole);
end;

procedure TInetExpertsUIModule.PortsWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  TInetHTTPPortWizardFrame(PortsWizardPage.Frame).HTTPS := FHTTPS;
  TInetHTTPPortWizardFrame(PortsWizardPage.Frame).AllowHTTPS := True;
  TInetHTTPPortWizardFrame(PortsWizardPage.Frame).Port := FHTTPPort;
end;

procedure TInetExpertsUIModule.PortsWizardPageFrameOptionChanged(
  Sender: TCustomExpertsFrameWizardPage);
begin
  FHTTPS := TInetHTTPPortWizardFrame(PortsWizardPage.Frame).HTTPS;
  FHTTPPort := TInetHTTPPortWizardFrame(PortsWizardPage.Frame).Port;
  EnablePages;
end;

procedure TInetExpertsUIModule.SetShowPlatformsPage(AValue: Boolean);
begin
  FShowPlatformsPage := AValue;
  EnablePages;
end;

procedure TInetExpertsUIModule.WebServerProjectWizardLoadImage(
  Sender: TCustomExpertsWizard; var AImage: TBitmap);
begin
  AImage := TBitmap.Create;
  try
    AImage.LoadFromResourceName(HInstance, 'NEWPROJECTWIZARD');  // Do not localize
  except
    FreeAndNil(AImage);
  end;
end;


procedure TInetExpertsUIModule.CertFilesWizardPageCreateFrame(
  Sender: TCustomExpertsFrameWizardPage; AOwner: TComponent;
  out AFrame: TFrame);
var
  LFrame: TInetCertFilesWizardFrame;
begin
  LFrame := TInetCertFilesWizardFrame.Create(AOwner);
  AFrame := LFrame;
end;

procedure TInetExpertsUIModule.CertFilesWizardPageFrameCreated(
  Sender: TCustomExpertsFrameWizardPage; AFrame: TFrame);
begin
  TInetCertFilesWizardFrame(AFrame).OnTest := OnCertFilesTest;
end;

procedure TInetExpertsUIModule.OnCertFilesTest(Sender: TObject);
begin
  TInetCertFilesWizardFrame(CertFilesWizardPage.Frame).TestCertFiles(Self.HTTPPort);
end;

procedure TInetExpertsUIModule.OnGoNextFrame(Sender: TObject);
begin
  WebServerProjectWizard.NextOrFinish;
end;

end.
