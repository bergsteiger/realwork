{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit InetHTTPPortWizardPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AppEvnts, ExtCtrls, ExpertsUIWizard, IPPeerAPI;

type
  TInetPortFocusField = (pfocNone, pfocPort, pfocHTTPS);

  TInetHTTPPortWizardFrame = class(TFrame, IExpertsWizardPageFrame)
    LabelPort: TLabel;
    EditPort: TEdit;
    ButtonTest: TButton;
    ButtonNextAvailable: TButton;
    CheckBoxHTTPS: TCheckBox;
    ApplicationEvents1: TApplicationEvents;
    Panel1: TPanel;
    procedure ButtonTestClick(Sender: TObject);
    procedure ButtonNextAvailableClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure CheckBoxHTTPSClick(Sender: TObject);
  private
    FFocusField: TInetPortFocusField;
    FOnHTTPSChange: TNotifyEvent;
    FPage: TCustomExpertsFrameWizardPage;
    function GetPort: Integer;
    procedure SetPort(const Value: Integer);
    procedure OnExecute(AContext: IIPContext);
    function GetAllowHTTPS: Boolean;
    procedure SetAllowHTTPS(const Value: Boolean);
    function GetFocusField: TInetPortFocusField;
    function GetHTTPS: Boolean;
    procedure SetHTTPS(const Value: Boolean);
  protected
    { IExpertsWizardPageFrame }
    procedure ExpertsFrameUpdateInfo(ASender: TCustomExpertsWizardPage;
      var AHandled: Boolean);
    function ExpertsFrameValidatePage(ASender: TCustomExpertsWizardPage;
      var AHandled: Boolean): Boolean;
    procedure ExpertsFrameCreated(APage: TCustomExpertsFrameWizardPage);
    procedure ExpertsFrameEnterPage(APage: TCustomExpertsFrameWizardPage);
  public
    { Public declarations }
//    class function CreateFrame(AOwner: TComponent): TInetHTTPPortWizardFrame; static;
    function ValidateFields: Boolean;
    function GetWizardInfo: string;
    property Port: Integer read GetPort write SetPort;
    property AllowHTTPS: Boolean read GetAllowHTTPS write SetAllowHTTPS;
    property HTTPS: Boolean read GetHTTPS write SetHTTPS;
    property FocusField: TInetPortFocusField read FFocusField;
    property OnHTTPSChange: TNotifyEvent read FOnHTTPSChange write FOnHTTPSChange;
  end;

implementation

{$R *.dfm}

uses InetDesignResStrs;

const
  nDefaultHTTPPort = 8080;

resourcestring
  sPort = 'Port';
  sInvalidInt = '%s must be an integer';
  rsTestPortOK = 'Test port succeeded';

procedure TInetHTTPPortWizardFrame.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  if not Self.Visible then
    Exit;
  if GetFocusField <> FFocusField then
  begin
    FFocusField := GetFocusField;
    if FPage <> nil then
      FPage.UpdateInfo;
  end;
end;

procedure TInetHTTPPortWizardFrame.ButtonNextAvailableClick(Sender: TObject);
var
  LPort: Integer;
  LTestServer: IIPTestServer;
begin
  LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
  LPort := LTestServer.GetOpenPort;
  Port := LPort;
end;

procedure TInetHTTPPortWizardFrame.ButtonTestClick(Sender: TObject);
var
  LTestServer: IIPTestServer;
begin
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(Port, OnExecute);
    MessageDlg(rsTestPortOK, mtInformation, [mbOK], 0);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

function TInetHTTPPortWizardFrame.GetWizardInfo: string;
begin
  case FocusField of
    pfocNone: Result := sPortsPageInfo;
    pfocPort: Result := sHTTPPortInfo;
    pfocHTTPS: Result := sHTTPSInfo;
  else
    Result := sPortsPageInfo;
  end;
end;

procedure TInetHTTPPortWizardFrame.OnExecute(AContext: IIPContext);
begin
end;

function TInetHTTPPortWizardFrame.GetAllowHTTPS: Boolean;
begin
  Result := CheckBoxHTTPS.Visible;
end;

function TInetHTTPPortWizardFrame.GetFocusField: TInetPortFocusField;
begin
  if CheckBoxHTTPS.Focused then
    Result := pfocHTTPS
  else if EditPort.Focused or  ButtonTest.Focused or ButtonNextAvailable.Focused then
    Result := pfocPort
  else
    Result := pfocNone;
end;

function TInetHTTPPortWizardFrame.GetHTTPS: Boolean;
begin
  Result := CheckBoxHTTPS.Checked;
end;

function TInetHTTPPortWizardFrame.GetPort: Integer;
begin
  Result := StrToInt(EditPort.Text);
end;

procedure TInetHTTPPortWizardFrame.SetAllowHTTPS(const Value: Boolean);
begin
  CheckBoxHTTPS.Visible := Value;
  if not Value then
    CheckBoxHTTPS.Checked := False;
end;

procedure TInetHTTPPortWizardFrame.SetHTTPS(const Value: Boolean);
begin
  Assert((not Value) or CheckBoxHTTPS.Visible);
  CheckBoxHTTPS.Checked := Value;
end;

procedure TInetHTTPPortWizardFrame.SetPort(const Value: Integer);
begin
  EditPort.Text := IntToStr(Value);
end;


function TInetHTTPPortWizardFrame.ValidateFields: Boolean;
begin
  try
    StrToInt(EditPort.Text);
  except
    EditPort.SetFocus;
    MessageDlg(Format(sInvalidInt, [sPort]), mtError, [mbOk], 0);
    Exit(False);
  end;
  Result := True;
end;

procedure TInetHTTPPortWizardFrame.ExpertsFrameCreated(
  APage: TCustomExpertsFrameWizardPage);
begin
  FPage := APage;
  FPage.Title := sPortsPageTitle;
  FPage.Description := sPortsPageDescription;
  Panel1.Left := cExpertsLeftMargin;
  FFocusField := pfocNone;
  FPage.UpdateInfo;
end;

procedure TInetHTTPPortWizardFrame.ExpertsFrameEnterPage(
  APage: TCustomExpertsFrameWizardPage);
begin
  //APage.UpdateInfo;
end;

procedure TInetHTTPPortWizardFrame.ExpertsFrameUpdateInfo(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
begin
  AHandled := True;
  ASender.WizardInfo := GetWizardInfo;
end;

function TInetHTTPPortWizardFrame.ExpertsFrameValidatePage(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
begin
  AHandled := True;
  Result := ValidateFields;
end;

procedure TInetHTTPPortWizardFrame.CheckBoxHTTPSClick(Sender: TObject);
begin
  if Assigned(FOnHTTPSChange) then
    FOnHTTPSChange(Sender);
  if FPage <> nil then
    FPage.DoOnFrameOptionsChanged;
end;

//class function TInetHTTPPortWizardFrame.CreateFrame(AOwner: TComponent): TInetHTTPPortWizardFrame;
//var
//  LFrame: TInetHTTPPortWizardFrame;
//begin
//  LFrame := TInetHTTPPortWizardFrame.Create(AOwner);
//  Result := LFrame;
//end;

end.
