{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit WebServerWizardPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, WizardAPI, StdCtrls, ExtCtrls, AppEvnts, InetWiz, ExpertsUIWizard,
  FrameExtendedNextUnit;

type

  TWebServerWizardFrame = class(TFrameExtendedNext, IExpertsWizardPageFrame)
    CreateNewISAPIApp: TRadioButton;
    CreateNewCGIApp: TRadioButton;
    CreateNewIndyConsoleApp: TRadioButton;
    CreateNewIndyApp: TRadioButton;
    ApplicationEvents1: TApplicationEvents;
    CreateNewApacheApp: TRadioButton;
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure CreateAppTypeClick(Sender: TObject);
  private
    //FOnProjectTypeChangeProc: TProc;
    FOnProjectTypeChange: TNotifyEvent;
    FCoClassNameFocused: Boolean;
    FOnCoClassNameFocused: TNotifyEvent;
    FHiddenProjectTypes: TProjectTypes;
    FPage: TCustomExpertsFrameWizardPage;
    function ValidateFields: Boolean;
    function GetProjectType: TProjectType;
    procedure SetProjectType(AProjectType: TProjectType);
    procedure SetLeftMargin(const Value: Integer);
    procedure SetHiddenProjectTypes(const Value: TProjectTypes);
  protected
    function ExpertsFrameValidatePage(ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
    procedure ExpertsFrameUpdateInfo(ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
    procedure ExpertsFrameCreated(APage: TCustomExpertsFrameWizardPage);
    procedure ExpertsFrameEnterPage(APage: TCustomExpertsFrameWizardPage);
    function GetWizardInfo: string;
  public
    { Public declarations }
//    class function CreateFrame(AOwner: TComponent): TWebServerWizardFrame;
    class function GetDefaultApplicationType: TProjectType;
    property ProjectType: TProjectType read GetProjectType write SetProjectType;
    property OnProjectTypeChange: TNotifyEvent read FOnProjectTypeChange write FOnProjectTypeChange;
    property HiddenProjectTypes: TProjectTypes read FHiddenProjectTypes write SetHiddenProjectTypes;
  end;

  IWebServerWizardPage = interface(IWizardPage)
    ['{D62307AA-C316-4FAE-9B1B-5D873EFDD693}']
    function GetProjectType: TProjectType;
    function GetOnProjectTypeChange: TNotifyEvent;
    function GetFrame: TWebServerWizardFrame;
    procedure SetOnProjectTypeChange(AValue: TNotifyEvent);
    function GetHiddenProjectTypes: TProjectTypes;
    procedure SetHiddenProjectTypes(AProjectTypes: TProjectTypes);
    property ProjectType: TProjectType read GetProjectType;
    property Frame: TWebServerWizardFrame read GetFrame;
    property OnProjectTypeChange: TNotifyEvent read GetOnProjectTypeChange write SetOnProjectTypeChange;
    property HiddenProjectTypes: TProjectTypes read GetHiddenProjectTypes write SetHiddenProjectTypes;
  end;

  TWebServerWizardPage = class(TWizardPage, IWebServerWizardPage, IWizardPage, IWizardPageEvents)
  private
    FFrame: TWebServerWizardFrame;
    FProjectType: TProjectType;
    FOnProjectTypeChange: TNotifyEvent;
    FHiddenProjectTypes: TProjectTypes;
    procedure OnProjectTypeChange(ASender: TObject);
    procedure UpdateInfo;
    function GetProjectType: TProjectType;
    function GetWizardInfo(AProjectType: TProjectType): string;
    procedure SetProjectType(const Value: TProjectType);
    { IWizardPageEvents }
    procedure OnEnterPage(PageTransition: TPageTransition);
    procedure OnLeavePage(PageTransition: TPageTransition);
    procedure OnLeavingPage(PageTransition: TPageTransition; var Allow: Boolean);
    function GetOnProjectTypeChange: TNotifyEvent;
    procedure SetOnProjectTypeChange(AValue: TNotifyEvent);
    procedure OnCoClassNameFocused(ASender: TObject);
    function GetFrame: TWebServerWizardFrame;
    function GetHiddenProjectTypes: TProjectTypes;
    procedure SetHiddenProjectTypes(AProjectTypes: TProjectTypes);
  public
    constructor Create;
    destructor Destroy; override;

    { IWizardPage }
    function Close: Boolean;
    function Page: TFrame;
    function PageID: TGUID; override;
    procedure Clear;

    property ProjectType: TProjectType read GetProjectType write SetProjectType;
    property HiddenProjectTypes: TProjectTypes read GetHiddenProjectTypes write SetHiddenProjectTypes;
  end;

const
  sWebServerWizardPage = 'sWebServerWizardPage';

implementation

{$R *.dfm}

uses NetConst, InetDesignResStrs;


{ TWebServerWizardPage }

procedure TWebServerWizardPage.Clear;
begin
  inherited;
end;


procedure TWebServerWizardPage.UpdateInfo;
begin
  if Wizard <> nil then
    if (FFrame <> nil) and FFrame.FCoClassNameFocused then
      Wizard.Info := sCoClassNameInfo
    else
    Wizard.Info := GetWizardInfo(ProjectType);
end;

function TWebServerWizardPage.GetFrame: TWebServerWizardFrame;
begin
  Result := FFrame;
end;

function TWebServerWizardPage.GetHiddenProjectTypes: TProjectTypes;
begin
  Result := FHiddenProjectTypes;
end;

function TWebServerWizardPage.GetOnProjectTypeChange: TNotifyEvent;
begin
  if FFrame <> nil then
    Result := FFrame.OnProjectTypeChange
  else
    Result := FOnProjectTypeChange;
end;

function TWebServerWizardPage.GetProjectType: TProjectType;
begin
  if FFrame <> nil then
    Result := FFrame.ProjectType
  else
    Result := FProjectType;
end;

function TWebServerWizardPage.GetWizardInfo(AProjectType: TProjectType): string;
begin
  case AProjectType of
    ptISAPI: Result := sISAPIInfo;
    ptCGI: Result := sCGIInfo;
    ptIndyForm: Result := sIndyFormInfo;
    ptIndyConsole: Result := sIndyConsoleInfo;
    ptApacheTwo: Result := sApacheInfo;
  end;
end;

function TWebServerWizardPage.Close: Boolean;
begin
  Result := True;
end;

constructor TWebServerWizardPage.Create;
begin
  inherited;
  Title := sWebServerPageTitle;
  Description := sWebServerPageDescription;
  FProjectType := ptIndyForm;
  Name := sWebServerWizardPage;
end;

destructor TWebServerWizardPage.Destroy;
begin

  inherited;
end;

function TWebServerWizardPage.Page: TFrame;
begin
  if FFrame = nil then
  begin
    FFrame := TWebServerWizardFrame.Create(Wizard.Owner);
    FFrame.ProjectType := FProjectType;
    FFrame.OnProjectTypeChange := OnProjectTypeChange;
    FFrame.FOnCoClassNameFocused := OnCoClassNameFocused;
    FFrame.HiddenProjectTypes := FHiddenProjectTypes;
  end;
  Result := FFrame;
end;

procedure TWebServerWizardPage.OnEnterPage(PageTransition: TPageTransition);
begin
  UpdateInfo;
end;

procedure TWebServerWizardPage.OnLeavePage(PageTransition: TPageTransition);
begin

end;

procedure TWebServerWizardPage.OnLeavingPage(PageTransition: TPageTransition;
  var Allow: Boolean);
begin
  try
    case PageTransition of
      prNext,
      prFinish:
        if FFrame <> nil then
          FFrame.ValidateFields;
    end;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Allow := False;
    end;

  end;
end;

procedure TWebServerWizardPage.OnProjectTypeChange(ASender: TObject);
begin
  FProjectType := FFrame.ProjectType;
  UpdateInfo;
  if Assigned(FOnProjectTypeChange) then
    FOnProjectTypeChange(Self);
end;

procedure TWebServerWizardPage.OnCoClassNameFocused(ASender: TObject);
begin
  UpdateInfo;
end;

function TWebServerWizardPage.PageID: TGUID;
begin
  Result := IWebServerWizardPage;
end;

procedure TWebServerWizardPage.SetHiddenProjectTypes(
  AProjectTypes: TProjectTypes);
begin
  if FFrame <> nil then
    FFrame.HiddenProjectTypes := AProjectTypes
  else
    FHiddenProjectTypes := AProjectTypes;
end;

procedure TWebServerWizardPage.SetOnProjectTypeChange(AValue: TNotifyEvent);
begin
  if FFrame <> nil then
    FFrame.OnProjectTypeChange := AValue
  else
    FOnProjectTypeChange := AValue;
end;

procedure TWebServerWizardPage.SetProjectType(const Value: TProjectType);
begin
  if FFrame <> nil then
    FFrame.ProjectType := Value
  else
    FProjectType := Value;
end;

procedure TWebServerWizardFrame.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
end;

//class function TWebServerWizardFrame.CreateFrame(AOwner: TComponent): TWebServerWizardFrame;
//var
//  LFrame: TWebServerWizardFrame;
//begin
//  LFrame := TWebServerWizardFrame.Create(AOwner);
////  LFrame.HiddenProjectTypes := [ptCom]; // Deprecate Web App Debugger
////  LFrame.ProjectType := ptIndyForm;
////  //LFrame.FOnProjectTypeChange := AOnProjectChange;
////  LFrame.LeftMargin := ExpertsUIWizard.cExpertsLeftMargin;
//  Result := LFrame;
//end;

procedure TWebServerWizardFrame.CreateAppTypeClick(Sender: TObject);
begin
  if Assigned(OnProjectTypeChange) then
    OnProjectTypeChange(Self);
  Self.FPage.UpdateInfo;
  Self.FPage.DoOnFrameOptionsChanged;
//  if Assigned(FOnProjectTypeChangeProc) then
//    FOnProjectTypeChange(Self);
end;

procedure TWebServerWizardFrame.ExpertsFrameCreated(
  APage: TCustomExpertsFrameWizardPage);
begin
  FPage := APage;
  HiddenProjectTypes := [];
  ProjectType := ptIndyForm;
  SetLeftMargin(ExpertsUIWizard.cExpertsLeftMargin);
  FPage.Title := sWebServerPageTitle;
  FPage.Description := sWebServerPageDescription;
  DblCLickControlManager := TDblClickControlManager.Create(FPage.Frame);
  DblClickControlManager.AddControl(CreateNewISAPIApp);
  DblClickControlManager.AddControl(CreateNewCGIApp);
  DblClickControlManager.AddControl(CreateNewIndyConsoleApp);
  DblClickControlManager.AddControl(CreateNewIndyApp);
  DblClickControlManager.AddControl(CreateNewApacheApp);
end;

procedure TWebServerWizardFrame.ExpertsFrameEnterPage(
  APage: TCustomExpertsFrameWizardPage);
begin
 // APage.UpdateInfo;
end;

procedure TWebServerWizardFrame.ExpertsFrameUpdateInfo(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
begin
  AHandled := True;
  ASender.WizardInfo := GetWizardInfo;
end;

function TWebServerWizardFrame.ExpertsFrameValidatePage(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
begin
  AHandled := True;
  Result := ValidateFields;
end;

function TWebServerWizardFrame.ValidateFields: Boolean;
begin
  Result := not(CreateNewCGIApp.Checked or CreateNewISAPIApp.Checked or CreateNewIndyApp.Checked) or
    (CreateNewCGIApp.Visible and CreateNewISAPIApp.Visible and CreateNewIndyApp.Visible);
  if not Result then
    MessageDlg(sFrameWorkInfo, mtInformation, mbOKCancel, 0);
end;

class function TWebServerWizardFrame.GetDefaultApplicationType: TProjectType;
begin
  Result := ptIndyConsole;
end;

function TWebServerWizardFrame.GetProjectType: TProjectType;
begin
  if CreateNewCGIApp.Checked then
    Result := ptCGI
  else if CreateNewISAPIApp.Checked then
    Result := ptISAPI
  else if CreateNewIndyApp.Checked then
    Result := ptIndyForm
  else if CreateNewIndyConsoleApp.Checked then
    Result := ptIndyConsole
  else if CreateNewApacheApp.Checked then
    Result := ptApacheTwo
  else
  begin
    Result := ptIndyForm;
    Assert(False);
  end;
end;

procedure TWebServerWizardFrame.SetLeftMargin(const Value: Integer);
begin
  CreateNewISAPIApp.Left := Value;
  CreateNewCGIApp.Left := Value;
  CreateNewIndyApp.Left := Value;
  CreateNewIndyConsoleApp.Left := Value;
  CreateNewApacheApp.Left := Value;
end;

procedure TWebServerWizardFrame.SetProjectType(AProjectType: TProjectType);
begin
  if ProjectType <> AProjectType then
  begin
    case AProjectType of
      ptISAPI: CreateNewISAPIApp.Checked := True;
      ptCGI: CreateNewCGIApp.Checked := True;
      ptIndyForm: CreateNewIndyApp.Checked := True;
      ptIndyConsole: CreateNewIndyConsoleApp.Checked := True;
      ptApacheTwo: CreateNewApacheApp.Checked := True;
    end;
    if Assigned(OnProjectTypeChange) then
      OnProjectTypeChange(nil);
//    if Assigned(FOnProjectTypeChangeProc) then
//      FOnProjectTypeChange(Self);
    if Self.FPage <> nil then
      Self.FPage.UpdateInfo;
  end;
end;

procedure TWebServerWizardFrame.SetHiddenProjectTypes(
  const Value: TProjectTypes);
begin
  if FHiddenProjectTypes <> Value then
  begin
    FHiddenProjectTypes := Value;
    Assert(FHiddenProjectTypes - [ptCGI] = []);  // Only implemented for CGI
    if ptCGI in FHiddenProjectTypes then
    begin
      CreateNewCGIApp.Visible := False;
    end;
  end;
end;


function TWebServerWizardFrame.GetWizardInfo: string;
begin
  case ProjectType of
    ptIndyForm:
      Result := sIndyFormInfo;
    ptIndyConsole:
      Result := sIndyConsoleInfo;
    ptISAPI:
      Result := sISAPIInfo;
    ptCGI:
      Result := sCGIInfo;
    ptApacheTwo:
      Result := sApacheInfo;
  else
    Result := '';
  end;
end;

end.
