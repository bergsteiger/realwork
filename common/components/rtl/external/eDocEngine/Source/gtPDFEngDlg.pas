{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2013 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }
{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtPDFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls, gtPDFCrypt3,
  gtPlnDlg, gtDocDlg, gtDocResStrs, gtCstDocEng, gtCstPDFEng, gtDocConsts,
  Buttons, CheckLst, gtDigitalSignature3
  // gtEnvelope3, gtJwaWinCrypt3
{$IFDEF gtPro}
    , gtExPDFEng
{$ENDIF}
    ;

type
  TgtPDFEngineDlg = class(TgtPlainSheetDlg)
    tsPDFAdvanced: TTabSheet;
    gbPDFOptions: TGroupBox;
    lblFontEncoding: TLabel;
    gbEncryption: TGroupBox;
    lblOwnerPassword: TLabel;
    lblConfirmOwnerPassword: TLabel;
    lblUserPassword: TLabel;
    lblConfirmUserPassword: TLabel;
    edOwnerPassword: TEdit;
    edConfirmOwnerPassword: TEdit;
    gbUserPermissions: TGroupBox;
    chkPrint: TCheckBox;
    chkModify: TCheckBox;
    chkCopy: TCheckBox;
    edUserPassword: TEdit;
    edConfirmUserPassword: TEdit;
    gbUseCompression: TGroupBox;
    lblCompressionLevel: TLabel;
    cbCompressionLevel: TComboBox;
    chkCompressDocument: TCheckBox;
    cbEncoding: TComboBox;
    chkEnableEncryption: TCheckBox;
    tsViewerPreferences: TTabSheet;
    gbViewerPreferences: TGroupBox;
    lblPageLayout: TLabel;
    lblPageMode: TLabel;
    cbPageLayout: TComboBox;
    cbPageMode: TComboBox;
    gbHideUIElements: TGroupBox;
    chkMenuBar: TCheckBox;
    chkToolBar: TCheckBox;
    chkNavigationControls: TCheckBox;
    gbPresentationMode: TGroupBox;
    lblPageTransitionEffect: TLabel;
    lblPageTransitionDuration: TLabel;
    lblSecs: TLabel;
    edPageTransitionDuration: TEdit;
    cbPageTransitionEffect: TComboBox;
    lblEncryptionLevel: TLabel;
    cbEncryptionLevel: TComboBox;
    chkAnnotation: TCheckBox;
    chkFormFill: TCheckBox;
    chkAccessibility: TCheckBox;
    chkDocumentAssembly: TCheckBox;
    chkHighResolutionPrint: TCheckBox;
    rgpEmbedTrueTypeFonts: TRadioGroup;
    tsDigitalSign: TTabSheet;
    gbDigitalSign: TGroupBox;
    chkDigitallySign: TCheckBox;
    pgPropertyControl: TPageControl;
    pgtFieldProperties: TTabSheet;
    pgtSignatureProperties: TTabSheet;
    lblSigCertFileName: TLabel;
    lblSigCertPassword: TLabel;
    lblSigConfirmCertPassword: TLabel;
    btnSelectCertFile: TSpeedButton;
    lblSigAuthor: TLabel;
    lblSigContactInfo: TLabel;
    lblSigReason: TLabel;
    lblSigLocation: TLabel;
    edSigCertFileName: TEdit;
    edSigCertPassword: TEdit;
    edSigConfirmCertPassword: TEdit;
    edSigAuthor: TEdit;
    edSigContactInfo: TEdit;
    edSigReason: TEdit;
    edSigLocation: TEdit;
    lblSigFieldName: TLabel;
    edSigFieldName: TEdit;
    gbSigFieldPos: TGroupBox;
    lblSigFieldPageNo: TLabel;
    edSigFieldPageNo: TEdit;
    chkSigFieldVisible: TCheckBox;
    gbSigAppearenceText: TGroupBox;
    chkSigShowName: TCheckBox;
    chkSigShowReason: TCheckBox;
    chkSigShowLocation: TCheckBox;
    chkSigShowDate: TCheckBox;
    chkSigShowLabels: TCheckBox;
    shpSigFillColor: TShape;
    lblSigFillColor: TLabel;
    gbSigFieldBounds: TGroupBox;
    edSigFieldLeft: TEdit;
    lblSigFieldLeft: TLabel;
    edSigFieldTop: TEdit;
    lblSigFieldTop: TLabel;
    edSigFieldRight: TEdit;
    lblSigFieldRight: TLabel;
    edSigFieldBottom: TEdit;
    lblSigFieldBottom: TLabel;
    rgDate: TRadioGroup;
    datetimeSigDateTime: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edConfirmPasswordExit(Sender: TObject);
    procedure chkEnableEncryptionClick(Sender: TObject);
    procedure cbPageTransitionEffectChange(Sender: TObject);
    procedure cbEncryptionLevelChange(Sender: TObject);
    procedure chkCompressDocumentClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkDigitallySignClick(Sender: TObject);
    procedure edSigFieldNameKeyPress(Sender: TObject; var Key: Char);
    procedure chkSigFieldVisibleClick(Sender: TObject);
    procedure edSigFieldPageNoValidate(Sender: TObject; var Key: Char);
    procedure edSigFieldBoundsValidate(Sender: TObject; var Key: Char);
    procedure btnSelectCertFileClick(Sender: TObject);
    procedure edAutherValidate(Sender: TObject; var Key: Char);
    procedure edReasonValidate(Sender: TObject; var Key: Char);
    procedure edLocationValidate(Sender: TObject; var Key: Char);
    procedure edSigFieldBoundsRangeValidate(Sender: TObject);
    procedure datetimeSigDateTimeValidate(Sender: TObject);
    procedure chkSigCurrentDateClick(Sender: TObject);
    procedure rgDateClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Localize; override;

  public
    { Public declarations }
  end;

const
  TTFontEmbedding: array [TgtTTFontEmbedding] of String = (STTFENone, STTFEFull,
    STTFESubset);

  CompressionMethods: array [TgtCompressionLevel] of String =
    (SCompressionMethodFastest, SCompressionMethodNormal,
    SCompressionMethodMaximum);
  PDFPageLayout: array [TgtPageLayout] of String = (SPageLayoutSinglePage,
    SPageLayoutOneColoumn, SPageLayoutTwoColoumnLeft,
    SPageLayoutTwoColoumnRight);

  PDFPageMode: array [TgtPageMode] of String = (SPageModeUseNone,
    SPageModeUseOutlines, SPageModeUseThumbs, SPageModeFullScreen);

  PDFTransitionEffects: array [TgtTransitionEffect] of String = (SNone,
    SSplitHorizontalInward, SSplitHorizontalOutward, SSplitVerticalInward,
    SSplitVerticalOutward, SBlindsHorizontal, SBlindsVertical, SBoxInward,
    SBoxOutward, SWipeLeftToRight, SWipeBottomToTop, SWipeRightToLeft,
    SWipeTopToBottom, SDissolve, SGlitterLeftToRight, SGlitterTopToBottom,
    SGlitterTopLeftToBottomRight);

  PDFEncryptionLevel: array [TgtPDFEncryptionLevel] of String = (Sel40Bit,
    Sel128Bit);

implementation

uses gtUtils3;
{$R *.dfm}
{ TgtPDFEngineDlg }

procedure TgtPDFEngineDlg.Localize;
var
  LI: TgtTTFontEmbedding;
begin
  inherited;
  Caption := SPDFDlgCaption;

  rgpEmbedTrueTypeFonts.Caption := SrgpEmbedTrueTypeFonts;
  rgpEmbedTrueTypeFonts.Items.Clear;
  for LI := Low(TgtTTFontEmbedding) to High(TgtTTFontEmbedding) do
    rgpEmbedTrueTypeFonts.Items.AddObject(TTFontEmbedding[LI], TObject(LI));

  tsPDFAdvanced.Caption := StsPDFAdvanced;
  chkCompressDocument.Caption := SchkCompressDocument;
  lblCompressionLevel.Caption := SlblCompressionLevel;
  chkEnableEncryption.Caption := SchkEnableEncryption;
  lblOwnerPassword.Caption := SlblOwnerPassword;
  lblConfirmOwnerPassword.Caption := SlblConfirmOwnerPassword;
  lblUserPassword.Caption := SlblUserPassword;
  lblConfirmUserPassword.Caption := SlblConfirmUserPassword;
  lblEncryptionLevel.Caption := SlblEncryptionLevel;
  gbUserPermissions.Caption := SgbUserPermissions;
  chkCopy.Caption := SchkCopy;
  chkModify.Caption := SchkModify;
  chkPrint.Caption := SchkPrint;
  chkFormFill.Caption := SchkFormFill;
  chkAnnotation.Caption := SchkAnnotation;
  chkAccessibility.Caption := SchkAccessibility;
  chkDocumentAssembly.Caption := SchkDocumentAssembly;
  chkHighResolutionPrint.Caption := SchkHighResolutionPrint;
  lblFontEncoding.Caption := SlblFontEncoding;
  tsViewerPreferences.Caption := StsViewerPreferences;
  lblPageLayout.Caption := SlblPageLayout;
  lblPageMode.Caption := SlblPageMode;
  gbHideUIElements.Caption := SgbHideUIElements;
  chkMenuBar.Caption := SchkMenuBar;
  chkToolBar.Caption := SchkToolBar;
  chkNavigationControls.Caption := SchkNavigationControls;
  gbPresentationMode.Caption := SgbPresentationMode;
  lblPageTransitionEffect.Caption := SlblPageTransitionEffect;
  lblPageTransitionDuration.Caption := SlblPageTransitionDuration;

  { --------------------Digital Signature------------------------ }

  chkDigitallySign.Caption := SchkDigitallySignDocument;
  pgtFieldProperties.Caption := SpgtFieldProperties;
  pgtSignatureProperties.Caption := SpgtSignatureProperties;
  lblSigFieldName.Caption := SlblFieldName;
  chkSigFieldVisible.Caption := SchkFieldVisibleOnPage;
  lblSigFieldPageNo.Caption := SlblFieldPage;
  // gbSigFieldBounds.Caption := Format(SlblFieldBounds,
  // [CUnitNames[TgtCustomPDFEngine(Engine).MeasurementUnit]]) ;
  lblSigFieldLeft.Caption := SlblFieldLeft;
  lblSigFieldTop.Caption := SlblFieldTop;
  lblSigFieldRight.Caption := SlblFieldRight;
  lblSigFieldBottom.Caption := SlblFieldBottem;
  gbSigAppearenceText.Caption := SgbAppearenceText;
  lblSigFillColor.Caption := SlblFillColor;
  chkSigShowName.Caption := SchkShowName;
  chkSigShowReason.Caption := SchkShowReason;
  chkSigShowLocation.Caption := SchkShowLocation;
  chkSigShowDate.Caption := SchkShowLabels;
  lblSigCertFileName.Caption := SlblCertFileName;
  lblSigCertPassword.Caption := SlblCertPassword;
  lblSigConfirmCertPassword.Caption := SlblConfirmPassword;
  lblSigAuthor.Caption := SlblAuthor;
  lblSigContactInfo.Caption := SlblContactInformation;
  lblSigReason.Caption := SlblReason;
  lblSigLocation.Caption := SlblLocation;
  rgDate.Caption := SrgDate;

end;

procedure TgtPDFEngineDlg.rgDateClick(Sender: TObject);
begin
  inherited;
  if rgDate.ItemIndex = 0 then
    datetimeSigDateTime.Enabled := False;
  if rgDate.ItemIndex = 1 then
    datetimeSigDateTime.Enabled := True;
end;

procedure TgtPDFEngineDlg.FormCreate(Sender: TObject);
var
  I: TgtCompressionLevel;
  J: TgtPDFFontEncoding;
  K: TgtPageLayout;
  L: TgtPageMode;
  M: TgtTransitionEffect;
  N: TgtPDFEncryptionLevel;
begin
  inherited FormCreate(Sender);
{$IFNDEF GIFSupport}
  cbOutputImageFormat.Items.Delete(cbOutputImageFormat.Items.IndexOfObject
    (TObject(Ord(ifGIF))));
{$ENDIF}
  cbOutputImageFormat.Items.Delete(cbOutputImageFormat.Items.IndexOfObject
    (TObject(Ord(ifPNG))));
  cbOutputImageFormat.Items.Delete(cbOutputImageFormat.Items.IndexOfObject
    (TObject(Ord(ifMetafile))));

  for I := Low(TgtCompressionLevel) to High(TgtCompressionLevel) do
    cbCompressionLevel.Items.AddObject(CompressionMethods[I], TObject(I));

  for J := Low(TgtPDFFontEncoding) to High(TgtPDFFontEncoding) do
    cbEncoding.Items.AddObject(PDFFontEncodeStrings[J], TObject(J));

  for K := Low(TgtPageLayout) to High(TgtPageLayout) do
    cbPageLayout.Items.AddObject(PDFPageLayout[K], TObject(K));

  for L := Low(TgtPageMode) to High(TgtPageMode) do
    cbPageMode.Items.AddObject(PDFPageMode[L], TObject(L));

  for M := Low(TgtTransitionEffect) to High(TgtTransitionEffect) do
    cbPageTransitionEffect.Items.AddObject(PDFTransitionEffects[M], TObject(M));

  for N := Low(TgtPDFEncryptionLevel) to High(TgtPDFEncryptionLevel) do
    cbEncryptionLevel.Items.AddObject(PDFEncryptionLevel[N], TObject(N));

  lbDocumentDlg.Items.Append(SlblAdvanced);
  lbDocumentDlg.Items.Append(SlblViewerPreferences);
  lbDocumentDlg.Items.Append(SlblDigitalSignature);
  datetimeSigDateTime.Enabled := False;

end;

procedure TgtPDFEngineDlg.FormShow(Sender: TObject);
var
  LEnvelope: TgtDigitalIntf;
  // LCertContext: PCertContext;
begin
{$IFDEF gtPro}
  with TgtExPDFEngine(Engine) do
{$ELSE}
  with TgtCustomPDFEngine(Engine) do
{$ENDIF}
  begin
    with ImageSettings do
    begin
      cbOutputImageFormat.ItemIndex := cbOutputImageFormat.Items.IndexOf
        (ImageFormats[TgtOutputImageFormat(OutputImageFormat)]);
      edJPEGQuality.Text := IntToStr(JPEGQuality);
      if OutputImageFormat = ifJPEG then
        edJPEGQuality.Enabled := True
      else
        edJPEGQuality.Enabled := False;
      cbOutputImageFormatChange(Sender);
    end;
    gbSigFieldBounds.Caption := Format(SlblFieldBounds,
      [CUnitNames[TgtCustomPDFEngine(Engine).MeasurementUnit]]);
    // rgDate.ItemIndex := 0;
    imgBackgroundImage.Picture.Assign(BackgroundImage);
    cbBackgroundDisplayType.ItemIndex :=
      cbBackgroundDisplayType.Items.IndexOfObject
      (TObject(Ord(BackgroundImageDisplayType)));
    shpBackgroundColor.Brush.Color := BackgroundColor;
    if (imgBackgroundImage.Picture.Graphic = nil) or
      imgBackgroundImage.Picture.Graphic.Empty then
      btnClearClick(Sender);
    rgpEmbedTrueTypeFonts.ItemIndex :=
      Integer(TgtTTFontEmbedding(Preferences.EmbedTrueTypeFonts));
    chkCompressDocument.Checked := Compression.Enabled;
    cbCompressionLevel.ItemIndex := cbCompressionLevel.Items.IndexOfObject
      (TObject(Ord(Compression.Level)));
    cbEncoding.ItemIndex := cbEncoding.Items.IndexOfObject
      (TObject(Ord(FontEncoding)));
    chkEnableEncryption.Checked := Encryption.Enabled;
    edOwnerPassword.Text := String(Encryption.OwnerPassword);
    edConfirmOwnerPassword.Text := String(Encryption.OwnerPassword);
    edUserPassword.Text := String(Encryption.UserPassword);
    edConfirmUserPassword.Text := String(Encryption.UserPassword);
    cbEncryptionLevel.ItemIndex := cbEncryptionLevel.Items.IndexOfObject
      (TObject(Ord(Encryption.Level)));
    chkPrint.Checked := AllowPrint in Encryption.UserPermissions;
    chkModify.Checked := AllowModify in Encryption.UserPermissions;
    chkCopy.Checked := AllowCopy in Encryption.UserPermissions;
    chkFormFill.Checked := AllowFormFill in Encryption.UserPermissions;
    chkAnnotation.Checked := AllowAnnotation in Encryption.UserPermissions;
    chkAccessibility.Checked := AllowAccessibility
      in Encryption.UserPermissions;
    chkDocumentAssembly.Checked := AllowDocAssembly
      in Encryption.UserPermissions;
    chkHighResolutionPrint.Checked := AllowHighResPrint
      in Encryption.UserPermissions;

    cbPageLayout.ItemIndex := cbPageLayout.Items.IndexOfObject
      (TObject(Ord(ViewerPreferences.PageLayout)));
    cbPageMode.ItemIndex := cbPageMode.Items.IndexOfObject
      (TObject(Ord(ViewerPreferences.PageMode)));

    chkMenuBar.Checked := ViewerPreferences.HideMenuBar;
    chkToolBar.Checked := ViewerPreferences.HideToolBar;
    chkNavigationControls.Checked := ViewerPreferences.HideWindowUI;

    cbPageTransitionEffect.ItemIndex :=
      cbPageTransitionEffect.Items.IndexOfObject
      (TObject(Ord(ViewerPreferences.PresentationMode.TransitionEffect)));
    edPageTransitionDuration.Text :=
      IntToStr(ViewerPreferences.PresentationMode.Duration);

    cbEncryptionLevelChange(Sender);
    chkEnableEncryptionClick(Sender);
    cbPageTransitionEffectChange(Sender);

    // Read Digital Signature Properties
    chkDigitallySign.Checked := DigitalSignature.Enabled;
    chkSigFieldVisible.Checked := DigitalSignature.FieldProperties.Visible;
    edSigFieldName.Text := DigitalSignature.FieldProperties.FieldName;
    edSigFieldPageNo.Text :=
      IntToStr(DigitalSignature.FieldProperties.PageNumber);
    shpSigFillColor.Brush.Color := DigitalSignature.FieldProperties.FillColor;
    with DigitalSignature.FieldProperties.FieldBounds do
    begin
      edSigFieldLeft.Text := FloatToStr(FLLeft);
      edSigFieldTop.Text := FloatToStr(FLTop);
      edSigFieldRight.Text := FloatToStr(FLRight);
      edSigFieldBottom.Text := FloatToStr(FLBotom);
    end;
    edSigCertFileName.Text := DigitalSignature.SignatureProperties.CertFileName;
    edSigCertPassword.Text := DigitalSignature.SignatureProperties.CertPassword;
    edSigCertPassword.Text := DigitalSignature.SignatureProperties.CertPassword;
    if DigitalSignature.Enabled then
    begin
      if DigitalSignature.SignatureProperties.Author = '' then
      begin
        LEnvelope := TgtDigitalIntf.Create;
        LEnvelope.CertContext := (LEnvelope.PKCS7).GetPFXCertWithPvtKey
          (AnsiString(DigitalSignature.SignatureProperties.CertFileName),
          AnsiString(DigitalSignature.SignatureProperties.CertPassword));
        DigitalSignature.SignatureProperties.Author :=
          WideString((LEnvelope.PKCS7).GetCertificateName
          (LEnvelope.CertContext));
        LEnvelope.Free;
      end;
    end;
    edSigAuthor.Text := DigitalSignature.SignatureProperties.Author;
    edSigContactInfo.Text := DigitalSignature.SignatureProperties.ContactInfo;
    edSigReason.Text := DigitalSignature.SignatureProperties.Reason;
    edSigLocation.Text := DigitalSignature.SignatureProperties.Location;
    datetimeSigDateTime.DateTime :=
      DigitalSignature.SignatureProperties.DateTime;
    // add and check in appearence check list box
    with DigitalSignature.FieldProperties do
    begin
      if sfaoshowName in FieldAppearenceOptions then
        chkSigShowName.Checked := True;
      if sfaoshowReason in FieldAppearenceOptions then
        chkSigShowReason.Checked := True;
      if sfaoshowLocation in FieldAppearenceOptions then
        chkSigShowLocation.Checked := True;
      if sfaoshowDate in FieldAppearenceOptions then
        chkSigShowDate.Checked := True;
      if sfaoshowLabels in FieldAppearenceOptions then
        chkSigShowLabels.Checked := True;
    end;

    chkDigitallySignClick(Sender);
  end;
  inherited FormShow(Sender);
end;

procedure TgtPDFEngineDlg.edAutherValidate(Sender: TObject; var Key: Char);
begin
  // Validate for valid PDF field identifier names
{$IFDEF gtDelphi2009Up}
  if not(SysUtils.CharInSet(Key, ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '-', '.',
    '_', #8])) then
{$ELSE}
  if not(Key in ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '-', '.', '_', #8]) then
{$ENDIF}
    Key := #0;

end;

procedure TgtPDFEngineDlg.edConfirmPasswordExit(Sender: TObject);
var
  LEnvelope: TgtDigitalIntf;
  // LCertContext: PCertContext;
  Str: String;
begin
  if (chkEnableEncryption.Checked) then
  begin
    if (TEdit(Sender) = edConfirmOwnerPassword) then
    begin
      if (AnsiCompareStr(edOwnerPassword.Text, edConfirmOwnerPassword.Text)
        <> 0) then
      begin
        Str := Format(SPasswordMissMatch, ['Owner']);
        MessageDlg(Str, mtError, [mbOK], 0);
        edOwnerPassword.SetFocus;
        Exit;
      end;
    end;
    if (TEdit(Sender) = edConfirmUserPassword) then
    begin
      if (AnsiCompareStr(edUserPassword.Text, edConfirmUserPassword.Text)
        <> 0) then
      begin
        Str := Format(SPasswordMissMatch, ['User']);
        MessageDlg(Str, mtError, [mbOK], 0);
        edUserPassword.SetFocus;
        Exit;
      end;
    end;
  end;
  if (chkDigitallySign.Checked) then
  begin
    LEnvelope := TgtDigitalIntf.Create;
    LEnvelope.CertContext := (LEnvelope.PKCS7).GetPFXCertWithPvtKey
      (AnsiString(edSigCertFileName.Text), AnsiString(edSigCertPassword.Text));
    edSigAuthor.Text :=
      string((LEnvelope.PKCS7).GetCertificateName(LEnvelope.CertContext));
    LEnvelope.Free;
    if (TEdit(Sender) = edSigConfirmCertPassword) then
    begin
      if (AnsiCompareStr(edSigCertPassword.Text, edSigConfirmCertPassword.Text)
        <> 0) then
      begin
        Str := Format(SPasswordMissMatch, ['Certificate']);
        MessageDlg(Str, mtError, [mbOK], 0);
        edSigCertPassword.SetFocus;
        Exit;
      end;
    end;
  end;
  inherited;

end;

procedure TgtPDFEngineDlg.edLocationValidate(Sender: TObject; var Key: Char);
begin
  // Validate for valid PDF field identifier names
{$IFDEF gtDelphi2009Up}
  if not(SysUtils.CharInSet(Key, ['a' .. 'z', 'A' .. 'Z', #8])) then
{$ELSE}
  if not(Key in ['a' .. 'z', 'A' .. 'Z', #8]) then
{$ENDIF}
    Key := #0;
end;

procedure TgtPDFEngineDlg.edReasonValidate(Sender: TObject; var Key: Char);
begin
  // Validate for valid PDF field identifier names
{$IFDEF gtDelphi2009Up}
  if not(SysUtils.CharInSet(Key, ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '-', '.',
    '_', #8])) then
{$ELSE}
  if not(Key in ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '-', '.', '_', #8]) then
{$ENDIF}
    Key := #0;

end;

procedure TgtPDFEngineDlg.edSigFieldBoundsRangeValidate(Sender: TObject);
var
  StrTmp: string;
  ExtTmp: double;
  Str: string;
begin
  StrTmp := TEdit(Sender).Text;
  ExtTmp := StrToFloat(StrTmp);
  if ExtTmp > 8.25 then
  begin
    Str := SmsgValueShouldBeLessThan;
    MessageDlg(Str, mtError, [mbOK], 0);
    TEdit(Sender).Text := #0;
    TEdit(Sender).SetFocus;
  end;

end;

procedure TgtPDFEngineDlg.edSigFieldBoundsValidate(Sender: TObject;
  var Key: Char);
begin
  // Validate for numerals + '.' + backspace
{$IFDEF gtDelphi2009Up}
  if not(SysUtils.CharInSet(Key, ['0' .. '9', '.', #8])) then
{$ELSE}
  if not(Key in ['0' .. '9', '.', #8]) then
{$ENDIF}
    Key := #0;
end;

procedure TgtPDFEngineDlg.edSigFieldNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  // Validate for valid PDF field identifier names
{$IFDEF gtDelphi2009Up}
  if not(SysUtils.CharInSet(Key, ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '-', '.',
    '_', #8])) then
{$ELSE}
  if not(Key in ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '-', '.', '_', #8]) then
{$ENDIF}
    Key := #0;
end;

procedure TgtPDFEngineDlg.edSigFieldPageNoValidate(Sender: TObject;
  var Key: Char);
begin
  // Validate for numerals
{$IFDEF gtDelphi2009Up}
  if not(SysUtils.CharInSet(Key, ['1' .. '9', #8])) then
{$ELSE}
  if not(Key in ['1' .. '9', #8]) then
{$ENDIF}
    Key := #0;
end;

procedure TgtPDFEngineDlg.chkEnableEncryptionClick(Sender: TObject);
begin
  SetControlsEnabled(gbEncryption, chkEnableEncryption.Checked);
  if chkEnableEncryption.Checked then
    cbEncryptionLevelChange(Sender);
end;

procedure TgtPDFEngineDlg.chkSigFieldVisibleClick(Sender: TObject);
begin
  SetControlsEnabled(gbSigFieldPos, chkSigFieldVisible.Checked);
end;

procedure TgtPDFEngineDlg.datetimeSigDateTimeValidate(Sender: TObject);
var
  LCYear, LEYear, LCMonth, LEMonth, LCDay, LEDay: Word;
  Str: string;
begin
  DecodeDate(now, LCYear, LCMonth, LCDay);
  DecodeDate(TDateTimePicker(Sender).DateTime, LEYear, LEMonth, LEDay);
  Str := SmsgDateShouldNotExceed;
  if LCYear < LEYear then
  begin
    MessageDlg(Str, mtError, [mbOK], 0);
    TDateTimePicker(Sender).DateTime := now;
  end
  else if ((LCYear = LEYear) and (LCMonth < LEMonth)) then
  begin
    MessageDlg(Str, mtError, [mbOK], 0);
    TDateTimePicker(Sender).DateTime := now;
  end
  else if ((LCYear = LEYear) and (LCMonth = LEMonth) and (LCDay < LEDay)) then
  begin
    MessageDlg(Str, mtError, [mbOK], 0);
    TDateTimePicker(Sender).DateTime := now;
  end;
end;

procedure TgtPDFEngineDlg.cbPageTransitionEffectChange(Sender: TObject);
begin
  lblPageTransitionDuration.Enabled :=
    not(cbPageTransitionEffect.Text = PDFTransitionEffects[teNone]);
  edPageTransitionDuration.Enabled := lblPageTransitionDuration.Enabled;
  edPageTransitionDuration.Color := EditColor[edPageTransitionDuration.Enabled];
  lblSecs.Enabled :=
    not(cbPageTransitionEffect.Text = PDFTransitionEffects[teNone]);
end;

procedure TgtPDFEngineDlg.btnSelectCertFileClick(Sender: TObject);
begin
  if OpenFileDialog.Execute then
    edSigCertFileName.Text := OpenFileDialog.FileName;
end;

procedure TgtPDFEngineDlg.cbEncryptionLevelChange(Sender: TObject);
begin
  if TgtPDFEncryptionLevel(cbEncryptionLevel.ItemIndex) = el40Bit then
  begin
    chkAnnotation.Enabled := False;
    chkAccessibility.Enabled := False;
    chkDocumentAssembly.Enabled := False;
    chkHighResolutionPrint.Enabled := False;
  end
  else
  begin
    chkAnnotation.Enabled := True;
    chkAccessibility.Enabled := True;
    chkDocumentAssembly.Enabled := True;
    chkHighResolutionPrint.Enabled := True;
  end;
end;

procedure TgtPDFEngineDlg.chkCompressDocumentClick(Sender: TObject);
begin
  SetControlsEnabled(gbUseCompression, chkCompressDocument.Checked);
end;

procedure TgtPDFEngineDlg.chkSigCurrentDateClick(Sender: TObject);
begin
  datetimeSigDateTime.Visible := True;
  if (TCheckBox(Sender).Checked) then
  begin
    datetimeSigDateTime.Enabled := False;
  end
  else
    datetimeSigDateTime.Enabled := True;
end;

procedure TgtPDFEngineDlg.chkDigitallySignClick(Sender: TObject);
var
  LIgnoreList: TList;
begin
  LIgnoreList := TList.Create;
  try
    // If main option is enabled the inner option group boxes need to be
    // updated based on the inner option's state, so ignore relevant inner controls
    // if chkDigitallySign.Checked then
    // LIgnoreList.Add(gbSigFieldPos);
    SetControlsEnabled(gbDigitalSign, chkDigitallySign.Checked, LIgnoreList);
  finally
    LIgnoreList.Free;
    // Update inner controls based on relevant inner control state, if main option
    // is enabled
    if chkDigitallySign.Checked then
      SetControlsEnabled(gbSigFieldPos, chkSigFieldVisible.Checked);
  end;
end;

procedure TgtPDFEngineDlg.btnOKClick(Sender: TObject);
begin
{$IFDEF gtPro}
  with TgtExPDFEngine(Engine) do
{$ELSE}
  with TgtCustomPDFEngine(Engine) do
{$ENDIF}
  begin
    Preferences.EmbedTrueTypeFonts :=
      TgtTTFontEmbedding(rgpEmbedTrueTypeFonts.Items.Objects
      [rgpEmbedTrueTypeFonts.ItemIndex]);
    BackgroundColor := shpBackgroundColor.Brush.Color;
    BackgroundImage.Assign(imgBackgroundImage.Picture);
    BackgroundImageDisplayType := TgtBackgroundDisplayType
      (cbBackgroundDisplayType.Items.Objects
      [cbBackgroundDisplayType.ItemIndex]);
    with Compression do
    begin
      Enabled := chkCompressDocument.Checked;
      Level := TgtCompressionLevel(cbCompressionLevel.Items.Objects
        [cbCompressionLevel.ItemIndex]);
    end;
    FontEncoding := TgtPDFFontEncoding
      (cbEncoding.Items.Objects[cbEncoding.ItemIndex]);
    Encryption.Enabled := chkEnableEncryption.Checked;
    with Encryption do
    begin
      OwnerPassword := AnsiString(edOwnerPassword.Text);
      UserPassword := AnsiString(edUserPassword.Text);
      Level := TgtPDFEncryptionLevel(cbEncryptionLevel.Items.Objects
        [cbEncryptionLevel.ItemIndex]);
      if chkCopy.Checked then
        UserPermissions := UserPermissions + [AllowCopy]
      else
        UserPermissions := UserPermissions - [AllowCopy];
      if chkModify.Checked then
        UserPermissions := UserPermissions + [AllowModify]
      else
        UserPermissions := UserPermissions - [AllowModify];
      if chkPrint.Checked then
        UserPermissions := UserPermissions + [AllowPrint]
      else
        UserPermissions := UserPermissions - [AllowPrint];
      if chkFormFill.Checked then
        UserPermissions := UserPermissions + [AllowFormFill]
      else
        UserPermissions := UserPermissions - [AllowFormFill];
      if Level = el128Bit then
      begin
        if chkAnnotation.Checked then
          UserPermissions := UserPermissions + [AllowAnnotation]
        else
          UserPermissions := UserPermissions - [AllowAnnotation];
        if chkAccessibility.Checked then
          UserPermissions := UserPermissions + [AllowAccessibility]
        else
          UserPermissions := UserPermissions - [AllowAccessibility];
        if chkDocumentAssembly.Checked then
          UserPermissions := UserPermissions + [AllowDocAssembly]
        else
          UserPermissions := UserPermissions - [AllowDocAssembly];
        if chkHighResolutionPrint.Checked then
          UserPermissions := UserPermissions + [AllowHighResPrint]
        else
          UserPermissions := UserPermissions - [AllowHighResPrint];
      end;
    end;

    with ViewerPreferences do
    begin
      PageLayout := TgtPageLayout(cbPageLayout.Items.Objects
        [cbPageLayout.ItemIndex]);
      PageMode := TgtPageMode(cbPageMode.Items.Objects[cbPageMode.ItemIndex]);
      HideMenuBar := chkMenuBar.Checked;
      HideToolBar := chkToolBar.Checked;
      HideWindowUI := chkNavigationControls.Checked;
      with PresentationMode do
      begin
        TransitionEffect := TgtTransitionEffect
          (cbPageTransitionEffect.Items.Objects
          [cbPageTransitionEffect.ItemIndex]);
        Duration := StrToInt(edPageTransitionDuration.Text);
      end;
    end;

    // Write Digital Signature Properties
    with DigitalSignature do
    begin
      Enabled := chkDigitallySign.Checked;
      with FieldProperties do
      begin
        Visible := chkSigFieldVisible.Checked;
        FieldName := edSigFieldName.Text;
        FillColor := shpSigFillColor.Brush.Color;
        PageNumber := StrToInt(edSigFieldPageNo.Text);
        with FieldBounds do
        begin
          FLLeft := StrToFloat(edSigFieldLeft.Text);
          FLTop := StrToFloat(edSigFieldTop.Text);
          FLRight := StrToFloat(edSigFieldRight.Text);
          FLBotom := StrToFloat(edSigFieldBottom.Text);
        end;
        FieldAppearenceOptions := [];
        if chkSigShowName.Checked then
          FieldAppearenceOptions := FieldAppearenceOptions + [sfaoshowName];
        if chkSigShowReason.Checked then
          FieldAppearenceOptions := FieldAppearenceOptions + [sfaoshowReason];
        if chkSigShowLocation.Checked then
          FieldAppearenceOptions := FieldAppearenceOptions + [sfaoshowLocation];
        if chkSigShowDate.Checked then
          FieldAppearenceOptions := FieldAppearenceOptions + [sfaoshowDate];
        if chkSigShowLabels.Checked then
          FieldAppearenceOptions := FieldAppearenceOptions + [sfaoshowLabels];
      end;
      SignatureProperties.CertFileName := edSigCertFileName.Text;
      SignatureProperties.CertPassword := edSigCertPassword.Text;
      SignatureProperties.Author := edSigAuthor.Text;
      SignatureProperties.ContactInfo := edSigContactInfo.Text;
      SignatureProperties.Reason := edSigReason.Text;
      SignatureProperties.Location := edSigLocation.Text;
      if rgDate.ItemIndex = 0 then
        SignatureProperties.DateTime := now
      else
      begin
        SignatureProperties.DateTime := datetimeSigDateTime.DateTime;
      end;
    end;
  end;
  inherited btnOKClick(Sender);
end;

end.
