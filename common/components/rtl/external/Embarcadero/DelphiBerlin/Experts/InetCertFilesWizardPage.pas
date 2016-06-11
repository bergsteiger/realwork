{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit InetCertFilesWizardPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WizardAPI, ActnList, StdActns, StdCtrls, AppEvnts, ExpertsUIWizard;

type
  TDSCertFilesFocusField = (focCertFile, focKeyFile, focKeyFilePassword, focRootCertFile,
    focTestButton);

  TDSExpertCertFileInfo = record
    CertFile: string;
    KeyFile: string;
    KeyFilePassword: string;
    RootCertFile: string;
  end;

  TInetCertFilesWizardFrame = class(TFrame, IExpertsWizardPageFrame)
    LabelCertFile: TLabel;
    CertFileEdit: TEdit;
    BrowseCertFileBtn: TButton;
    KeyFileEdit: TEdit;
    LabelKeyFile: TLabel;
    RootCertFileEdit: TEdit;
    LabelRootCertFile: TLabel;
    BrowseKeyFileBtn: TButton;
    BrowseRootCertFileBtn: TButton;
    LabelKeyFilePassword: TLabel;
    KeyPasswordEdit: TEdit;
    OpenDialog1: TOpenDialog;
    ApplicationEvents1: TApplicationEvents;
    ButtonTest: TButton;
    procedure BrowseCertFileBtnClick(Sender: TObject);
    procedure BrowseKeyFileBtnClick(Sender: TObject);
    procedure BrowseRootCertFileBtnClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonTestClick(Sender: TObject);
  private
    FOnFocusChange: TNotifyEvent;
    FCertFilesFocusField: TDSCertFilesFocusField;
    FOnTest: TNotifyEvent;
    FPage: TCustomExpertsFrameWizardPage;
    function GetLeftMargin: Integer;
    procedure SetLeftMargin(const Value: Integer);
    procedure OpenFileDialog(AEdit: TEdit; AKeyFile: Boolean);
    function ValidateFileExists(AEdit: TEdit): Boolean;
    function GetCertFileInfo: TDSExpertCertFileInfo;
  protected
    { IExpertsWizardPageFrame }
    function ExpertsFrameValidatePage(ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
    procedure ExpertsFrameUpdateInfo(ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
    procedure ExpertsFrameCreated(APage: TCustomExpertsFrameWizardPage);
    procedure ExpertsFrameEnterPage(APage: TCustomExpertsFrameWizardPage);
    function GetWizardInfo: string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
//    class function CreateFrame(AOwner: TComponent): TInetCertFilesWizardFrame; static;
    procedure TestCertFiles(APort: Integer);
    function ValidateFields: Boolean;
    property FocusField: TDSCertFilesFocusField read FCertFilesFocusField;
    property OnFocusChange: TNotifyEvent read FOnFocusChange write FOnFocusChange;
    property OnTest: TNotifyEvent read FOnTest write FOnTest;
    property CertFileInfo: TDSExpertCertFileInfo read GetCertFileInfo;
  end;


implementation

{$R *.dfm}

uses InetDesignResStrs, IPPeerAPI;

function SlashSep(const Path, S: string): string;
begin
  if Path <> '' then
    Result := IncludeTrailingPathDelimiter(Path) + S
  else
    Result := S;
end;

procedure TestCertificateFiles(APort: Integer; const ACertFileName, AKeyFileName, ARootCertFile: string;
  AKeyFilePassword: string);
var
  LTestServer: IIPTestServer;
begin
  LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
  LTestServer.TestCertificateFiles(APort, ACertFileName, AKeyFileName, ARootCertFile, AKeyFilePassword);
end;

procedure TInetCertFilesWizardFrame.ExpertsFrameCreated(
  APage: TCustomExpertsFrameWizardPage);
begin
  SetLeftMargin(cExpertsLeftMargin);
  FPage := APage;
  FPage.Title := sCertFilesPageTitle;
  FPage.Description := sCertFilesPageDescription;
end;

procedure TInetCertFilesWizardFrame.ExpertsFrameEnterPage(
  APage: TCustomExpertsFrameWizardPage);
begin
  //APage.UpdateInfo;
end;

procedure TInetCertFilesWizardFrame.ExpertsFrameUpdateInfo(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
begin
  AHandled := True;
  ASender.WizardInfo := GetWizardInfo;
end;

function TInetCertFilesWizardFrame.ExpertsFrameValidatePage(
  ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
begin
  AHandled := True;
  Result := ValidateFields;
end;

function TInetCertFilesWizardFrame.GetCertFileInfo: TDSExpertCertFileInfo;
begin
    Result.CertFile := CertFileEdit.Text;
    Result.KeyFile := KeyFileEdit.Text;
    Result.KeyFilePassword := KeyPasswordEdit.Text;
    Result.RootCertFile := RootCertFileEdit.Text;
end;

procedure TInetCertFilesWizardFrame.OpenFileDialog(AEdit: TEdit; AKeyFile: Boolean);
begin
  if AKeyFile then
    OpenDialog1.Filter := sPEMKeyFileFilter
  else
    OpenDialog1.Filter := sPEMFileFilter;
  OpenDialog1.Title := sPEMOpenFileTitle;
  OpenDialog1.HelpContext := 0;                         
  OpenDialog1.Options := OpenDialog1.Options + [ofShowHelp, ofPathMustExist, ofHideReadonly, ofFileMustExist];
  OpenDialog1.FileName := AEdit.Text;
  if OpenDialog1.Execute(Self.Handle) then
  begin
    AEdit.Text := OpenDialog1.FileName;
  end;
end;

procedure TInetCertFilesWizardFrame.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
var
  LFocus: TDSCertFilesFocusField;
begin
  if not Self.Visible then
    Exit;
  if CertFileEdit.Focused or BrowseCertFileBtn.Focused then
    LFocus := focCertFile
  else if RootCertFileEdit.Focused or BrowseRootCertFileBtn.Focused then
    LFocus := focRootCertFile
  else if KeyFileEdit.Focused or BrowseKeyFileBtn.Focused then
    LFocus := focKeyFile
  else if KeyPasswordEdit.Focused then
    LFocus := focKeyFilePassword
  else if ButtonTest.Focused then
    LFocus := focTestButton
  else
    LFocus := FocusField;
  if LFocus <> FocusField then
  begin
    Self.FCertFilesFocusField := LFocus;
    if Assigned(FOnFocusChange) then
      FOnFocusChange(Self);
    if FPage <> nil then
      FPage.UpdateInfo;
  end;
  ButtonTest.Enabled :=
    (CertFileEdit.Text <> '') and (KeyFileEdit.Text <> '');
end;

procedure TInetCertFilesWizardFrame.BrowseCertFileBtnClick(Sender: TObject);
begin
  OpenFileDialog(CertFileEdit, False);
end;

function TInetCertFilesWizardFrame.GetWizardInfo: string;
begin
  case FocusField of
    focCertFile:
      Result := sCertFileInfo;
    focRootCertFile:
      Result := sRootCertFileInfo;
    focTestButton:
      Result := sCertFilesTestInfo;
    focKeyFilePassword:
      Result := sKeyFilePasswordInfo;
    focKeyFile:
      Result := sKeyFileInfo;
  else
    Result := sCertFilesPageInfo;
  end
end;

procedure TInetCertFilesWizardFrame.BrowseKeyFileBtnClick(Sender: TObject);
begin
  OpenFileDialog(KeyFileEdit, True);
end;

procedure TInetCertFilesWizardFrame.BrowseRootCertFileBtnClick(Sender: TObject);
begin
  OpenFileDialog(RootCertFileEdit, False);
end;

procedure TInetCertFilesWizardFrame.ButtonTestClick(Sender: TObject);
begin
  Assert(Assigned(FOnTest));
  if ValidateFields then
    if Assigned(FOnTest) then
      FOnTest(Self)
end;

procedure TInetCertFilesWizardFrame.TestCertFiles(APort: Integer);
var
  LCertFileInfo: TDSExpertCertFileInfo;
begin
  LCertFileInfo := CertFileInfo;
  try
    Screen.Cursor := crHourGlass;
    try
      TestCertificateFiles(APort,
        LCertFileInfo.CertFile, LCertFileInfo.KeyFile,
        LCertFileInfo.RootCertFile, LCertFileInfo.KeyFilePassword);
    finally
      Screen.Cursor := crDefault;
    end;
    MessageDlg(sTestCertFilesOK, mtInformation, [mbOK], 0);
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

constructor TInetCertFilesWizardFrame.Create(AOwner: TComponent);
begin
  inherited;
  FCertFilesFocusField := focCertFile;
end;

function TInetCertFilesWizardFrame.GetLeftMargin: Integer;
begin
  Result := CertFileEdit.Left;
end;

procedure TInetCertFilesWizardFrame.SetLeftMargin(const Value: Integer);
begin
  CertFileEdit.Width := CertFileEdit.Width - (Value - CertFileEdit.Left);
  CertFileEdit.Left := Value;
  LabelCertFile.Left := Value;

  KeyFileEdit.Width := KeyFileEdit.Width - (Value - KeyFileEdit.Left);
  KeyFileEdit.Left := Value;
  LabelKeyFile.Left := Value;

  RootCertFileEdit.Width := RootCertFileEdit.Width - (Value - RootCertFileEdit.Left);
  RootCertFileEdit.Left := Value;
  LabelRootCertFile.Left := Value;

  KeyPasswordEdit.Left := Value;
  LabelKeyFilePassword.Left := Value;
end;

function TInetCertFilesWizardFrame.ValidateFileExists(AEdit: TEdit): Boolean;
var
  LFileName: string;
begin
  Result := True;
  LFileName := AEdit.Text;
  if Trim(LFileName) <> '' then
    if not FileExists(LFileName) then
    begin
      MessageDlg(Format(sPEMFileNotFound, [LFileName]), mtError, [mbOK], 0);
      AEdit.SetFocus;
      Exit(False);
    end;
end;

function TInetCertFilesWizardFrame.ValidateFields: Boolean;
begin
  Result := True;
  if not ValidateFileExists(CertFileEdit) then
    Exit(False);
  if not ValidateFileExists(KeyFileEdit) then
    Exit(False);
  if not ValidateFileExists(RootCertFileEdit) then
    Exit(False);
end;

end.

