{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }

{$I gtDefines.inc}

unit gtSettingsDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, CheckLst, ComCtrls, Dialogs, gtPDFConsts, gtPDFResStrs,
  gtCstPDFDoc, gtPDFDoc, gtCrypt
{$IFDEF gtPro}
  , gtExPDFDoc
{$ENDIF}
  ;

type
  THackWinControl = class(TWinControl);

  TgtPDFSettingsDlg = class(TgtBaseDlg)
    btnOK: TButton;
    btnCancel: TButton;
    pcSettings: TPageControl;
    tsDocInfo: TTabSheet;
    gbGeneral: TGroupBox;
    chkOpenAfterSave: TCheckBox;
    gbDocInfo: TGroupBox;
    lblCreator: TLabel;
    lblProducer: TLabel;
    lblPDFVer: TLabel;
    lblNoOfPages: TLabel;
    lblTitle: TLabel;
    lblDocSubject: TLabel;
    lblAuthor: TLabel;
    lblKeywords: TLabel;
    edtCreator: TEdit;
    edtProducer: TEdit;
    edtVersion: TEdit;
    edtNoPages: TEdit;
    edtTitle: TEdit;
    edtDocSubject: TEdit;
    edtAuthor: TEdit;
    edtKeywords: TEdit;
    tsSecurity: TTabSheet;
    gbEncryption: TGroupBox;
    rgEncryptionLevel: TRadioGroup;
    gbUserPermissions: TGroupBox;
    chklstUserPermissions: TCheckListBox;
    chkEnableEncryption: TCheckBox;
    tsView: TTabSheet;
    GroupBox1: TGroupBox;
    lblPageLayout: TLabel;
    lblPageMode: TLabel;
    cbPageLayout: TComboBox;
    cbPageMode: TComboBox;
    gbPresentationMode: TGroupBox;
    lblPageTransitionEffect: TLabel;
    lblSecs: TLabel;
    lblPageTransitionDur: TLabel;
    cbPageTransitionEffect: TComboBox;
    edtDur: TEdit;
    gbPresentationPageRange: TGroupBox;
    lblPageExample: TLabel;
    rbAllPages: TRadioButton;
    rbPages: TRadioButton;
    edtPresentationPages: TEdit;
    gbViewerPreferences: TGroupBox;
    chklstViewerPreferences: TCheckListBox;
    tsEmailDoc: TTabSheet;
    GroupBox3: TGroupBox;
    chkEmailAfterSave: TCheckBox;
    gbConnection: TGroupBox;
    lblHost: TLabel;
    lblUserID: TLabel;
    lblPassword: TLabel;
    edtUserID: TEdit;
    edtHost: TEdit;
    edtPassword: TEdit;
    gbAddresses: TGroupBox;
    lblTo: TLabel;
    lblCC: TLabel;
    lblBCC: TLabel;
    lblFrom: TLabel;
    edtTo: TEdit;
    edtCC: TEdit;
    edtBCC: TEdit;
    edtFrom: TEdit;
    gbMessage: TGroupBox;
    lblMessage: TLabel;
    lblSubject: TLabel;
    memoBody: TMemo;
    edtSubject: TEdit;
    tsCompress: TTabSheet;
    gbComp: TGroupBox;
    gbCompType: TGroupBox;
    lblCompType: TLabel;
    lblCompLevel: TLabel;
    cbCompType: TComboBox;
    cbCompLevel: TComboBox;
    chkCompressDoc: TCheckBox;
    edtOwnerPassword: TEdit;
    edtConfirmOwnerPassword: TEdit;
    edtUserPassword: TEdit;
    edtConfirmUserPassword: TEdit;
    lblConfirmOwnerPswd: TLabel;
    lblUserPswd: TLabel;
    lblConfirmUserPswd: TLabel;
    lblOwnerPswd: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkEnableEncryptionClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkEmailAfterSaveClick(Sender: TObject);
    procedure edtDurKeyPress(Sender: TObject; var Key: Char);
    procedure edtPresentationPagesKeyPress(Sender: TObject; var Key: Char);
    procedure rbAllPagesClick(Sender: TObject);
    procedure rbPagesClick(Sender: TObject);
    procedure cbPageTransitionEffectChange(Sender: TObject);
    procedure cbPageLayoutChange(Sender: TObject);
    procedure chkCompressDocClick(Sender: TObject);
    procedure cbCompTypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure EnableEmailAfterSave(Value: Boolean);
    procedure EnableCompAfterSave(Value: Boolean);
  protected
    procedure Localize;
  public
    { Public declarations }
    procedure ClearAll;
  end;

procedure SetControlsEnabled(AControl: TWinControl; AState: Boolean);

var
  SettingsDlg: TgtPDFSettingsDlg;
  compLevel: TgtCompressionLevel;
  compFilter: TgtCompressionFilter;
const
  PDFPageLayout: array[TgtPageLayout] of string = (SNone, SPageLayoutSinglePage,
    SPageLayoutOneColoumn, SPageLayoutTwoColoumnLeft, SPageLayoutTwoColoumnRight,
    SPageLayoutTwoPageLeft, SPageLayoutTwoPageRight);

  PDFPageMode: array[TgtPageMode] of string = (SNone,
    SPageModeUseOutlines, SPageModeUseThumbs, SPageModeFullScreen,
    SPageModeUseAttachments, SPageModeUseOptionalContent);

  PDFTransitionEffects: array[TgtTransitionEffect] of string = (SNone,
    SSplitHorizontalInward, SSplitHorizontalOutward, SSplitVerticalInward,
    SSplitVerticalOutward, SBlindsHorizontal, SBlindsVertical,
    SBoxInward, SBoxOutward, SWipeLeftToRight, SWipeBottomToTop,
    SWipeRightToLeft, SWipeTopToBottom, SDissolve, SGlitterLeftToRight,
    SGlitterTopToBottom, SGlitterTopLeftToBottomRight);

  CompressionLevels: array[TgtCompressionLevel] of string = (SNone,
    SCompressionLevelFastest, SCompressionLevelNormal,
    SCompressionLevelMaximum);

  ViewerPreferences: array[0..5] of string = (SHideToolbars,
    SHideMenuBar, SHideWindowUI, SFitWindow, SCenterWindow,
    SDisplayDocumentTitle);

  UserPermissions: array[TgtUserPermissionsType] of string = (SPrint, SModify,
    SCopy, SAnnotation, SFormFill, SAccessibility, SDocumentAssembly,
    SHighResolutionPrinting);

  PDFEncryptionLevel: array[TgtPDFEncryptionLevel] of string = (Sel40Bit,
    Sel128Bit);

  CompressionFilter: array[TgtCompressionFilter] of string =
  (SCompressionTypeFlate, SCompressionTypeRunlength);
implementation

uses
  gtPDFUtils;

{$R *.dfm}

procedure SetControlsEnabled(AControl: TWinControl; AState: Boolean);
const
  StateColor: array[Boolean] of TColor = (clInactiveBorder, clWindow);
var
  I: Integer;
begin
  with AControl do
    for I := 0 to ControlCount - 1 do
    begin
      if ((Controls[I] is TWinControl) and
        (TWinControl(Controls[I]).ControlCount > 0)) then
        SetControlsEnabled(TWinControl(Controls[I]), AState);
      if (Controls[I] is TCustomEdit) then
        THackWinControl(Controls[I]).Color := StateColor[AState]
      else if (Controls[I] is TCustomComboBox) then
        THackWinControl(Controls[I]).Color := StateColor[AState];
      Controls[I].Enabled := AState;
    end;
end;


procedure TgtPDFSettingsDlg.FormCreate(Sender: TObject);
var
  K: TgtPageLayout;
  L: TgtPageMode;
  M: TgtTransitionEffect;
  N: TgtCompressionLevel;
  X: Integer;
  Y: TgtUserPermissionsType;
  Z: TgtPDFEncryptionLevel;
  I: TgtCompressionFilter;
begin
  Localize;

  for K := Low(TgtPageLayout) to High(TgtPageLayOut) do
    cbPageLayout.Items.AddObject(PDFPageLayout[K], TObject(K));

  for L := Low(TgtPageMode) to High(TgtPageMode) do
    cbPageMode.Items.AddObject(PDFPageMode[L], TObject(L));

  for M := Low(TgtTransitionEffect) to High(TgtTransitionEffect) do
    cbPageTransitionEffect.Items.AddObject(PDFTransitionEffects[M], TObject(M));

  for N := Low(TgtCompressionLevel) to High(TgtCompressionLevel) do
    cbCompLevel.Items.AddObject(CompressionLevels[N], TObject(N));

  for X := 0 to 5 do
    chklstViewerPreferences.Items.AddObject(ViewerPreferences[X], TObject(X));

  for Y := Low(TgtUserPermissionsType) to High(TgtUserPermissionsType) do
    chklstUserPermissions.Items.AddObject(UserPermissions[Y], TObject(Y));

  for Z := Low(TgtPDFEncryptionLevel) to High(TgtPDFEncryptionLevel) do
    rgEncryptionLevel.Items.AddObject(PDFEncryptionLevel[Z], TObject(Z));
  rgEncryptionLevel.ItemIndex := 0;

  for I := Low(TgtCompressionFilter) to High(TgtCompressionFilter) do
    cbCompType.Items.AddObject(CompressionFilter[I], TObject(I));

  cbPageLayout.ItemIndex := 0;
  cbPageMode.ItemIndex := 0;
  cbPageTransitionEffect.ItemIndex := 0;
  SetControlsEnabled(gbEncryption, False);

  EnableEmailAfterSave(False);
  EnableCompAfterSave(False);
end;

procedure TgtPDFSettingsDlg.FormShow(Sender: TObject);
begin
  pcSettings.ActivePage := tsDocInfo;
  edtTitle.Text := PDFDoc.DocInfo.Title;
  edtProducer.Text := SProductName;
  edtDocSubject.Text := PDFDoc.DocInfo.Subject;
{$IFNDEF gtRegistered}
  edtAuthor.Text := 'Gnostice Information Technologies';
  edtAuthor.Enabled := False;
{$ENDIF}
{$IFDEF gtRegistered}
  edtAuthor.Text := PDFDoc.DocInfo.Author;
{$ENDIF}
  edtCreator.Text := PDFDoc.DocInfo.Creator;
  edtKeywords.Text := PDFDoc.DocInfo.Keywords;
  chkCompressDoc.Checked := True;
  chkCompressDocClick(Sender);

  cbCompType.ItemIndex := 0;
  cbCompLevel.ItemIndex := 1;
  chkEmailAfterSave.Checked := False;
  chkEnableEncryption.Checked := False;
  {if ((PDFDoc.Encryption.Enabled = True) or (PDFDoc.IsEncrypted = True)) then
  begin
     if(PDFDoc.Encryption.OwnerPassword = '') then
       chkEnableEncryption.Checked := False
     else
       chkEnableEncryption.Checked := True;

    with PDFDoc do
    begin
      edtOwnerPassword.Text := Encryption.OwnerPassword;
      edtConfirmOwnerPassword.Text := Encryption.OwnerPassword;
      edtUserPassword.Text := Encryption.UserPassword;
      edtConfirmUserPassword.Text := Encryption.UserPassword;

      if (Encryption.Level = el128bit) then
        rgEncryptionLevel.ItemIndex := 1
      else
        rgEncryptionLevel.ItemIndex := 0;

      chklstUserPermissions.Checked[0] := (AllowPrint in Encryption.UserPermissions);
      chklstUserPermissions.Checked[1] := (AllowModify in Encryption.UserPermissions);
      chklstUserPermissions.Checked[2] := (AllowCopy in Encryption.UserPermissions);
      chklstUserPermissions.Checked[3] := (AllowAnnotation in Encryption.UserPermissions);
      chklstUserPermissions.Checked[4] := (AllowFormFill in Encryption.UserPermissions);
      chklstUserPermissions.Checked[5] := (AllowAccessibility in Encryption.UserPermissions);
      chklstUserPermissions.Checked[6] := (AllowDocAssembly in Encryption.UserPermissions);
      chklstUserPermissions.Checked[7] := (AllowHighResPrint in Encryption.UserPermissions);
    end;
  end;
  case PDFDoc.PDFVersion of
    pvPDF10: edtVersion.Text := '1.0 (Acrobat 1.x)';
    pvPDF11: edtVersion.Text := '1.1 (Acrobat 2.x)';
    pvPDF12: edtVersion.Text := '1.2 (Acrobat 3.x)';
    pvPDF13: edtVersion.Text := '1.3 (Acrobat 4.x)';
    pvPDF14: edtVersion.Text := '1.4 (Acrobat 5.x)';
    pvPDF15: edtVersion.Text := '1.5 (Acrobat 6.x)';
  end;}

  edtNoPages.Text := IntToStr(PDFDoc.PageCount);
//  cbPageLayout.ItemIndex := ord(PDFDoc.PageLayout);
//  cbPageMode.ItemIndex := ord(PDFDoc.PageMode);
  chkEmailAfterSave.Checked := PDFDoc.EMailAfterSave;
  edtDur.Text := '1';
  with chklstViewerPreferences do
  begin
    Checked[0] := PDFDoc.ViewerPreferences.HideToolbar;
    Checked[1] := PDFDoc.ViewerPreferences.HideMenubar;
    Checked[2] := PDFDoc.ViewerPreferences.HideWindowUI;
    Checked[3] := PDFDoc.ViewerPreferences.FitWindow;
    Checked[4] := PDFDoc.ViewerPreferences.CenterWindow;
    Checked[5] := PDFDoc.ViewerPreferences.DisplayDocTitle;
  end;
  //PDFDoc.PageLayout := TgtPageLayout(cbPageLayout.ItemIndex);
  //PDFDoc.PageMode := TgtPageMode(cbPageMode.ItemIndex);
end;

procedure TgtPDFSettingsDlg.chkEnableEncryptionClick(Sender: TObject);
begin
  if PDFDoc.IsOwner then
    SetControlsEnabled(gbEncryption, chkEnableEncryption.Checked)
  else
  begin
    MessageDlg(SOnlyOwner, mtInformation, [mbOK], 0);
    chkEnableEncryption.Checked := True;
  end;
end;

procedure TgtPDFSettingsDlg.btnOKClick(Sender: TObject);
//var
//  LPages: string;
//  LStr: string;
begin
  // Encryption
  {if chkEnableEncryption.Checked then
  begin
    if (AnsiCompareStr(edtOwnerPassword.Text, edtConfirmOwnerPassword.Text) <> 0)  then
    begin
      LStr := Format(SPasswordMissMatch ,['Owner']);
      MessageDlg(LStr, mtError, [mbOK], 0);
      edtOwnerPassword.SetFocus;
      ModalResult := mrNone;
      Exit;
    end;

    if (AnsiCompareStr(edtUserPassword.Text, edtConfirmUserPassword.Text) <> 0) then
    begin
      LStr := Format(SPasswordMissMatch ,['User']);
      MessageDlg(LStr, mtError, [mbOK], 0);
      edtUserPassword.SetFocus;
      ModalResult := mrNone;
      Exit;
    end;

    with PDFDoc.Encryption do
    begin
      Enabled := True;
      Level := TgtPDFEncryptionLevel(rgEncryptionLevel.ItemIndex);
      if edtOwnerPassword.Text <> '' then
      OwnerPassword := edtOwnerPassword.Text;
      UserPassword := edtUserPassword.Text;
      UserPermissions :=[AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
      AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];
      if not chklstUserPermissions.Checked[0] then
        UserPermissions := UserPermissions - [AllowPrint];

      If not chklstUserPermissions.Checked[1] then
        UserPermissions := UserPermissions - [AllowModify];

      If not chklstUserPermissions.Checked[2] then
        UserPermissions := UserPermissions - [AllowCopy];

      If not chklstUserPermissions.Checked[3] then
        UserPermissions := UserPermissions - [AllowAnnotation];

      If not chklstUserPermissions.Checked[4] then
        UserPermissions := UserPermissions - [AllowFormFill];

      If not chklstUserPermissions.Checked[5] then
        UserPermissions := UserPermissions - [AllowAccessibility];

      If not chklstUserPermissions.Checked[6] then
        UserPermissions := UserPermissions - [AllowDocAssembly];

      If not chklstUserPermissions.Checked[7] then
        UserPermissions := UserPermissions - [AllowHighResPrint];
    end;
 end;
  else  if ((PDFDoc.Encryption.OwnerPassword='')
                                  and (PDFDoc.Encryption.UserPassword=''))  then
   PDFDoc.Encryption.Enabled := False;   }

  // Document Information
  {PDFDoc.DocInfo.Title    := edtTitle.Text;
  PDFDoc.DocInfo.Subject  := edtDocSubject.Text;
  PDFDoc.DocInfo.Author   := edtAuthor.Text;
  PDFDoc.DocInfo.Keywords := edtKeywords.Text;
  PDFDoc.DocInfo.Creator := edtCreator.Text;}

  if chkOpenAfterSave.Checked then
    PDFDoc.OpenAfterSave := True
  else
    PDFDoc.OpenAfterSave := False;

  // Presentations
  {if edtDur.Text = '' then edtDur.Text := '1';
  if cbPageTransitionEffect.ItemIndex <> 0 then
  begin
    if rbAllPages.Checked then
      LPages := '1-' + IntToStr(PDFDoc.PageCount)
    else LPages := edtPresentationPages.Text;
    PDFDoc.SetPageTransitionEffect(LPages, StrToFloatLocale(edtDur.Text),
      TgtTransitionEffect(cbPageTransitionEffect.ItemIndex));
  end; }

  {if cbPageLayout.ItemIndex <> -1 then
    PDFDoc.PageLayout := TgtPageLayout(cbPageLayout.ItemIndex); }

  {if cbPageMode.ItemIndex <> -1 then
    PDFDoc.PageMode   := TgtPageMode(cbPageMode.ItemIndex);}

  // Viewer Preferences
  {if chklstViewerPreferences.Checked[0] then
    PDFDoc.ViewerPreferences.HideToolbar := True;
  if chklstViewerPreferences.Checked[1] then
    PDFDoc.ViewerPreferences.HideMenubar := True;
  if chklstViewerPreferences.Checked[2] then
    PDFDoc.ViewerPreferences.HideWindowUI := True;
  if chklstViewerPreferences.Checked[3] then
    PDFDoc.ViewerPreferences.FitWindow := True;
  if chklstViewerPreferences.Checked[4] then
    PDFDoc.ViewerPreferences.CenterWindow := True;
  if chklstViewerPreferences.Checked[5] then
    PDFDoc.ViewerPreferences.DisplayDocTitle := True;}


  // EMail Document
  if chkEmailAfterSave.Checked then
  begin
    PDFDoc.EMailAfterSave := True;
    with PDFDoc.EMailInfo do
    begin
      Host := edtHost.Text;
      UserID := edtUserID.Text;
      Password := edtPassword.Text;
      Body.Add(memoBody.Text);
      FromAddress := edtFrom.Text;
      Subject := edtSubject.Text;
      RecipientList.CommaText := edtTo.Text;
      CCList.CommaText := edtCC.Text;
      BCCList.CommaText := edtBCC.Text;
    end;
  end
  else PDFDoc.EMailAfterSave := False;

  // Compress Document

  if chkCompressDoc.Checked then
  begin
    case cbCompType.ItemIndex of
      0: compFilter := cfFlate;

      1: compFilter := cfRunLength;

    end;

    case cbCompLevel.ItemIndex of
      0: compLevel := clNone;

      1: compLevel := clMax;

      2: compLevel := clFastest;

      3: compLevel := clDefault;
    end;
          //PDFDoc.CompressDocument(compFilter,compLevel);
  end;
end;

procedure TgtPDFSettingsDlg.EnableEmailAfterSave(Value: Boolean);
begin
  SetControlsEnabled(gbConnection, Value);
  SetControlsEnabled(gbAddresses, Value);
  SetControlsEnabled(gbMessage, Value);
end;

procedure TgtPDFSettingsDlg.chkEmailAfterSaveClick(Sender: TObject);
begin
  EnableEmailAfterSave(chkEmailAfterSave.Checked);
end;

procedure TgtPDFSettingsDlg.edtDurKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key >= '0') and (Key <= '9')) then
    if (Key <> #8) then
      Key := #0;
end;

procedure TgtPDFSettingsDlg.edtPresentationPagesKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #44, #45]) then
    Key := #0
  else
  begin
    rbPages.Checked := True;
    rbAllPages.Checked := False;
  end;
end;

procedure TgtPDFSettingsDlg.ClearAll;
begin
  edtTitle.Clear;
  edtSubject.Clear;
  edtSubject.Clear;
  edtKeywords.Clear;
  edtVersion.Clear;
  edtNoPages.Clear;
  edtOwnerPassword.Clear;
  edtConfirmOwnerPassword.Clear;
  edtUserPassword.Clear;
  edtConfirmUserPassword.Clear;
  //for LI := 0 to chklstUserPermissions.Count-1 do
   // chklstUserPermissions.Checked[LI] := False;
  cbPageLayout.ItemIndex := -1;
  cbPageMode.ItemIndex := -1;
  cbPageTransitionEffect.ItemIndex := -1;
  edtDur.Text := '1';
  edtPresentationPages.Clear;
  rbAllPages.Checked := False;
  //for LI := 0 to chklstViewerPreferences.Count-1 do
   // chklstViewerPreferences.Checked[LI] := False;

  // Email
  edtHost.Clear;
  edtUserID.Clear;
  edtPassword.Clear;
  edtFrom.Clear;
  edtTo.Clear;
  edtCC.Clear;
  edtBCC.Clear;
  edtSubject.Clear;
  memoBody.Clear;
end;

procedure TgtPDFSettingsDlg.rbAllPagesClick(Sender: TObject);
begin
  if rbAllPages.Checked then
  begin
    edtPresentationPages.Clear;
  end
end;

procedure TgtPDFSettingsDlg.rbPagesClick(Sender: TObject);
begin
  edtPresentationPages.Enabled := True;
  edtPresentationPages.Color := clWhite;
end;

procedure TgtPDFSettingsDlg.cbPageTransitionEffectChange(Sender: TObject);
begin
  if cbPageTransitionEffect.ItemIndex <> 0 then
    cbPageLayout.ItemIndex := 1;
end;

procedure TgtPDFSettingsDlg.cbPageLayoutChange(Sender: TObject);
begin
  if cbPageTransitionEffect.ItemIndex <> 0 then
    cbPageLayout.ItemIndex := 1;
end;

procedure TgtPDFSettingsDlg.EnableCompAfterSave(Value: Boolean);
begin
  SetControlsEnabled(gbCompType, Value);
end;

procedure TgtPDFSettingsDlg.chkCompressDocClick(Sender: TObject);
begin
  EnableCompAfterSave(chkCompressDoc.Checked);
end;

procedure TgtPDFSettingsDlg.cbCompTypeChange(Sender: TObject);
begin
  if cbCompType.ItemIndex = 1 then
  begin
    cbCompLevel.Enabled := False;
    cbCompLevel.ItemIndex := 0;
  end
  else
  begin
    cbCompLevel.Enabled := True;
    cbCompLevel.ItemIndex := 3;
  end;
end;

procedure TgtPDFSettingsDlg.Localize;
begin
  Caption := SPDFSettingsDlg;
  btnOK.Caption := SbtnOK;
  btnCancel.Caption := SbtnCancel;
  tsDocInfo.Caption := StsDocInfo;
  chkOpenAfterSave.Caption := SchkOpenAfterSave;
  gbDocInfo.Caption := SgbDocInfo;
  lblCreator.Caption := SlblCreator;
  lblProducer.Caption := SlblProducer;
  lblPDFVer.Caption := SlblPDFVer;
  lblNoOfPages.Caption := SlblNoOfPages;
  lblTitle.Caption := SlblTitle;
  lblDocSubject.Caption := SlblDocSubject;
  lblAuthor.Caption := SlblAuthor;
  lblKeywords.Caption := SlblKeywords;
  tsSecurity.Caption := StsSecurity;
  gbUserPermissions.Caption := SgbUserPermissions;
  chkEnableEncryption.Caption := SchkEnableEncryption;
  tsView.Caption := StsView;
  lblPageLayout.Caption := SlblPageLayout;
  lblPageMode.Caption := SlblPageMode;
  gbPresentationMode.Caption := SgbPresentationMode;
  lblPageTransitionEffect.Caption := SlblPageTransitionEffect;
  lblSecs.Caption := SlblSecs;
  lblPageTransitionDur.Caption := SlblPageTransitionDur;
  gbPresentationPageRange.Caption := SgbPresentationPageRange;
  lblPageExample.Caption := SlblPageExample;
  rbAllPages.Caption := SrbAllPages;
  rbPages.Caption := SrbPages;
  gbViewerPreferences.Caption := SgbViewerPreferences;
  tsEmailDoc.Caption := StsEmailDoc;
  chkEmailAfterSave.Caption := SchkEmailAfterSave;
  lblHost.Caption := SlblHost;
  lblUserID.Caption := SlblUserID;
  lblPassword.Caption := SlblPassword;
  lblTo.Caption := SlblTo;
  lblCC.Caption := SlblCC;
  lblBCC.Caption := SlblBCC;
  lblFrom.Caption := SlblFrom;
  lblMessage.Caption := SlblMessage;
  lblSubject.Caption := SlblSubject;
  tsCompress.Caption := StsCompress;
  lblCompType.Caption := SlblCompType;
  lblCompLevel.Caption := SlblCompLevel;
  chkCompressDoc.Caption := SchkCompressDoc;
  lblConfirmOwnerPswd.Caption := SlblConfirmOwnerPswd;
  lblUserPswd.Caption := SlblUserPswd;
  lblConfirmUserPswd.Caption := SlblConfirmUserPswd;
  lblOwnerPswd.Caption := SlblOwnerPswd;
end;

end.
