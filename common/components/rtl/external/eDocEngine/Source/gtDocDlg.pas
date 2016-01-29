{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2013 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtDocDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtDlgs, ExtCtrls, ShellAPI, Printers,
  gtDocResStrs, gtCstDocEng, gtImgPrvwDlg, gtDocConsts, gtConsts3, gtUtils3;

type
  {$IFDEF gtFileMaker}
  TgtHackEngine = class(TgtCustomDocumentEngine)
  end;
  {$ENDIF}

  TgtDocumentDlg = class(TgtBaseDlg)
    OpenPictureDialog: TOpenPictureDialog;
    ColorDialog: TColorDialog;
    btnOK: TButton;
    btnCancel: TButton;
    lblGnostice: TLabel;
    pnlDocDlg: TPanel;
    Panel1: TPanel;
    lbDocumentDlg: TListBox;
    Panel2: TPanel;
    Panel3: TPanel;
    pcDocument: TPageControl;
    tsPreferences: TTabSheet;
    gbPreferences: TGroupBox;
    chkOpenAfterCreate: TCheckBox;
    chkProcessAfterEachPage: TCheckBox;
    gbPageRange: TGroupBox;
    lblPageExample: TLabel;
    rbtnAll: TRadioButton;
    rbtnPages: TRadioButton;
    edPages: TEdit;
    tsContent: TTabSheet;
    gbContentOptions: TGroupBox;
    gbItemsToRender: TGroupBox;
    chkText: TCheckBox;
    chkShape: TCheckBox;
    gbImageSettings: TGroupBox;
    lblOutputImageFormat: TLabel;
    lblJPEGQuality: TLabel;
    lblImagePixelFormat: TLabel;
    lblSourceDPI: TLabel;
    cbOutputImageFormat: TComboBox;
    edJPEGQuality: TEdit;
    cbImagePixelFormat: TComboBox;
    edSourceDPI: TEdit;
    chkImage: TCheckBox;
    gbDocInfo: TGroupBox;
    lblAuthor: TLabel;
    lblCreator: TLabel;
    lblKeywords: TLabel;
    lblSubject: TLabel;
    lblTitle: TLabel;
    edAuthor: TEdit;
    edCreator: TEdit;
    edKeywords: TEdit;
    edSubject: TEdit;
    edTitle: TEdit;
    tsBackground: TTabSheet;
    gbBackground: TGroupBox;
    lblBackgroundImage: TLabel;
    lblBackgroundDisplayType: TLabel;
    lblBackgroundColor: TLabel;
    shpBackgroundColor: TShape;
    btnSelectImage: TButton;
    btnClear: TButton;
    pnlBackgroundImage: TPanel;
    imgBackgroundImage: TImage;
    cbBackgroundDisplayType: TComboBox;
    btnImgPrvw: TButton;
    tsEMailInfo: TTabSheet;
    gbEMailInfo: TGroupBox;
    lblHost: TLabel;
    Label1: TLabel;
    lblFrom: TLabel;
    lblTo: TLabel;
    lblCC: TLabel;
    lblBCC: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    edHost: TEdit;
    edPort: TEdit;
    chkAuthentication: TCheckBox;
    edFrom: TEdit;
    edTo: TEdit;
    edCC: TEdit;
    edBCC: TEdit;
    edEMailSubject: TEdit;
    memoBody: TMemo;
    lblDialogCaption: TLabel;
    chkEMailAfterCreate: TCheckBox;
    gbAuthentication: TGroupBox;
    edPassword: TEdit;
    lblUserID: TLabel;
    edUserID: TEdit;
    lblPassword: TLabel;
    chkUseImagesAsResources: TCheckBox;
    OpenFileDialog: TOpenDialog;
    procedure btnSelectImageClick(Sender: TObject);
    procedure btnImgPrvwClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure shpBackgroundColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpBackgroundColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lblGnosticeClick(Sender: TObject);
    procedure cbOutputImageFormatChange(Sender: TObject);
    procedure edKeyPress(Sender: TObject; var Key: Char);
    procedure rbtnAllClick(Sender: TObject);
    procedure rbtnPagesClick(Sender: TObject);
    procedure edPagesChange(Sender: TObject);
    procedure edPagesKeyPress(Sender: TObject; var Key: Char);
    procedure edSourceDPIKeyPress(Sender: TObject; var Key: Char);
    procedure lbDocumentDlgClick(Sender: TObject);
    procedure chkEMailAfterCreateClick(Sender: TObject);
    procedure chkAuthenticationClick(Sender: TObject);
    procedure UpdateEMailInfo(Sender: TObject);
  private
    { Private declarations }

  protected
    { Protected declarations }
    MousePoint: TPoint;
		procedure Localize; virtual;

  public
    { Public declarations }

  end;

const
	ImageFormats: array[TgtOutputImageFormat] of String = (
		SImageFormatBMP, SImageFormatJPEG, SImageFormatGIF, SImageFormatPNG,
    SImageFormatMetafile {$IFDEF gtPro}, SImageFormatCCITT3, SImageFormatCCITT4 {$ENDIF});

	PixelFormats: array[TPixelFormat] of String = (SPFDevice, SPF1bit, SPF4bit,
		SPF8bit, SPF15bit, SPF16bit, SPF24bit, SPF32bit, SPFCustom);

	BackgroundDisplayTypes: array[TgtBackgroundDisplayType] of String = (
		SBGDispTypTile, SBGDispTypTopLeft, SBGDispTypTopCenter,
		SBGDispTypTopRight, SBGDispTypCenterLeft, SBGDispTypCenter,
		SBGDispTypCenterRight, SBGDispTypBottomLeft, SBGDispTypBottomCenter,
		SBGDispTypBottomRight);

  PageOrientation: array[TPrinterOrientation] of String = (SpoLandScape,
    SpoPortrait);

  PaperSize: array[TgtPaperSize] of String = (SpsLetter, SpsLetterSmall,
    SpsTabloid, SpsLedger, SpsLegal, SpsStatement, SpsExecutive, SpsA3, SpsA4,
    SpsA4Small, SpsA5, SpsB4, SpsB5, SpsFolio, SpsQuarto, Sps10X14, Sps11X17,
    SpsNote, SpsEnv10, SpsEnv11, SpsEnv12, SpsEnv14, SpsCSheet, SpsDSheet,
    SpsESheet, SpsEnvDL,SpsEnvC5, SpsEnvC3, SpsEnvC4, SpsEnvC6, SpsEnvC65,
    SpsEnvB4, SpsEnvB5, SpsEnvB6, SpsEnvItaly, SpsEnvMonarch, SpsEnvPersonal,
    SpsFanfoldUS, SpsFanfoldStdGerman, SpsISOB4, SpsCustom);
    
implementation

{$R *.dfm}

procedure TgtDocumentDlg.btnSelectImageClick(Sender: TObject);
begin
	if OpenPictureDialog.Execute then
	begin
		imgBackgroundImage.Picture.LoadFromFile(OpenPictureDialog.FileName);
		btnImgPrvw.Enabled := True;
		btnClear.Enabled := True;
		lblBackgroundDisplayType.Enabled := True;
		cbBackgroundDisplayType.Enabled := True;
	end;
end;

procedure TgtDocumentDlg.btnImgPrvwClick(Sender: TObject);
begin
	with TgtImgPrvwDlg.Create(Self) do
		try
			imgBgImgPrvw.Picture.Assign(imgBackgroundImage.Picture);
			imgBgImgPrvw.Width := imgBackgroundImage.Picture.Width;
			imgBgImgPrvw.Height := imgBackgroundImage.Picture.Height;
			ClientWidth := imgBgImgPrvw.Width + pnlBgImgPrvw.BorderWidth * 2;
			ClientHeight := imgBgImgPrvw.Height + pnlBgImgPrvw.BorderWidth * 2;
			ShowModal;
		finally
			Free;
		end;
end;

procedure TgtDocumentDlg.btnClearClick(Sender: TObject);
begin
	imgBackgroundImage.Picture.Graphic := nil;
	btnClear.Enabled := False;
	btnImgPrvw.Enabled := False;
	lblBackgroundDisplayType.Enabled := False;
	cbBackgroundDisplayType.Enabled := False;
end;

procedure TgtDocumentDlg.Localize;
begin
  gbPageRange.Caption := SgbPageRange;
  rbtnAll.Caption := SrbtnAll;
  rbtnPages.Caption := SrbtnPages;
  tsPreferences.Caption := StsPreferences;
  tsContent.Caption := StsContent;
  chkOpenAfterCreate.Caption := SchkOpenAfterCreate;
  chkEMailAfterCreate.Caption := SchkEMailAfterCreate;
  chkProcessAfterEachPage.Caption := SchkProcessAfterEachPage;
  chkUseImagesAsResources.Caption := SchkUseImagesAsResources;
  gbItemsToRender.Caption := SgbItemsToRender;
  chkText.Caption := SchkText;
  chkShape.Caption := SchkShape;
  lblOutputImageFormat.Caption := SlblOutputImageFormat;
  lblJPEGQuality.Caption := SlblJPEGQuality;
  lblImagePixelFormat.Caption := SlblImagePixelFormat;
  lblSourceDPI.Caption := SlblSourceDPI;
  chkImage.Caption := SchkImage;
  tsBackground.Caption := StsBackground;
  lblBackgroundImage.Caption := SlblBackgroundImage;
  lblBackgroundDisplayType.Caption := SlblBackgroundDisplayType;
  btnSelectImage.Caption := SbtnSelectImage;
  btnClear.Caption := SbtnClear;
  btnImgPrvw.Caption := SbtnImgPrvw;
  lblBackgroundColor.Caption := SlblBackgroundColor;
  gbDocInfo.Caption := SgbDocInfo;
  lblAuthor.Caption := SlblAuthor;
  lblCreator.Caption := SlblCreator;
  lblKeywords.Caption := SlblKeywords;
  lblSubject.Caption := SlblSubject;
  lblTitle.Caption := SlblTitle;
  btnOK.Caption := SbtnOK;
  btnCancel.Caption := SbtnCancel;
  lbDocumentDlg.Items.Add(SPreferences);
  lbDocumentDlg.Items.Add(SContent);
  lbDocumentDlg.Items.Add(SBackground);
end;

procedure TgtDocumentDlg.FormCreate(Sender: TObject);
var
	I: TgtBackgroundDisplayType;
  J: TgtOutputImageFormat;
  K: TPixelFormat;
begin
  Localize;
	cbBackgroundDisplayType.Items.Clear;
	for I := Low(TgtBackgroundDisplayType) to High(TgtBackgroundDisplayType) do
		cbBackgroundDisplayType.Items.AddObject(BackgroundDisplayTypes[I],
			TObject(I));
	pcDocument.ActivePage := tsPreferences;
	cbOutputImageFormat.Items.Clear;
	for J := Low(TgtOutputImageFormat) to High(TgtOutputImageFormat) do
		cbOutputImageFormat.Items.AddObject(Imageformats[J], TObject(J));

	for K := Low(TPixelFormat) to High(TPixelFormat)  do
		cbImagePixelFormat.Items.AddObject(PixelFormats[K], TObject(K));
  K := High(TPixelFormat);
  cbImagePixelFormat.Items.Delete(Integer(K));

	cbOutputImageFormatChange(Sender);
  lbDocumentDlg.ItemIndex := 0;
  pcDocument.ActivePageIndex := lbDocumentDlg.ItemIndex;

  tsEMailInfo.Visible := False;

{  lbDocumentDlg.Items.Append(SEMailSettings);
  tsEMailInfo.Visible := True;
  chkEMailAfterCreateClick(Sender);
  chkAuthenticationClick(Sender);
 }

{$IFDEF gtRegistered}
	lblGnostice.Visible := False;
{$ENDIF}
end;

procedure TgtDocumentDlg.FormShow(Sender: TObject);
begin
  with IgtDocumentEngine(Engine) do
  begin
    {$IFDEF gtFileMaker}
      lblGnostice.Visible := (not (TgtHackEngine(Engine).StatusMgr.IsException));
    {$ENDIF}
    chkEMailAfterCreate.Checked := Preferences.EMailAfterCreate;
    chkOpenAfterCreate.Checked := Preferences.OpenAfterCreate;
    chkProcessAfterEachPage.Checked := Preferences.ProcessAfterEachPage;
    chkUseImagesAsResources.Checked := Preferences.UseImagesAsResources;
    lblDialogCaption.Caption := lbDocumentDlg.Items.Strings[0];
    lblPageExample.Caption := SlblPageExample;
    {$IFDEF EMailSupport}
    chkEMailAfterCreate.Checked := Preferences.EMailAfterCreate;
    {$ENDIF}
  end;
  with Engine do
  begin
    {$IFDEF EMailSupport}
    with EMailSettings do
    begin
      edHost.Text := Host;
      edPort.Text := IntToStr(Port);
      chkAuthentication.Checked := AuthenticationRequired;
      edUserID.Text := UserID;
      edPassword.Text := Password;
      edFrom.Text := EMailSettings.FromAddress;
      edTo.Text := EMailSettings.RecipientList.CommaText;
      edCC.Text := EMailSettings.CCList.CommaText;
      edBCC.Text := EMailSettings.BCCList.CommaText;
      edEMailSubject.Text := EMailSettings.Subject;
      memoBody.Lines.Assign(EMailSettings.Body);
    end;
    {$ENDIF}

		rbtnPages.Checked := (PagesToRender <> '');
		if rbtnPages.Checked then
			edPages.Text := PagesToRender;
  end;
end;

procedure TgtDocumentDlg.btnOKClick(Sender: TObject);
begin
	with IgtDocumentEngine(Engine) do
	begin
    with Preferences do
    begin
      OpenAfterCreate := chkOpenAfterCreate.Checked;
      EMailAfterCreate := chkEMailAfterCreate.Checked;
      if EMailAfterCreate then
      begin
        {$IFDEF EMailSupport}
        Engine.EMailSettings.Body.Assign(memoBody.Lines);
        Engine.EMailSettings.RecipientList.CommaText := edTo.Text;
        Engine.EMailSettings.CCList.CommaText := edCC.Text;
        Engine.EMailSettings.BCCList.CommaText := edBCC.Text;
        Engine.EMailSettings.Host := edHost.Text;
        Engine.EMailSettings.UserID := edUserID.Text;
        Engine.EMailSettings.Password := edPassword.Text;
        Engine.EMailSettings.AuthenticationRequired := chkAuthentication.Checked;
        Engine.EMailSettings.FromAddress := edFrom.Text;
        Engine.EMailSettings.Subject := edEMailSubject.Text;
        Engine.EMailSettings.Port := StrToInt(edPort.Text);
        {$ENDIF}
      end;
      ProcessAfterEachPage := chkProcessAfterEachPage.Checked;
      UseImagesAsResources := chkUseImagesAsResources.Checked;
    end;
  end;
  with Engine do
  begin
		if rbtnAll.Checked then
			PagesToRender := ''
		else if rbtnPages.Checked then
		begin
			PagesToRender := edPages.Text;
			if PagesToRender <> edPages.Text then Exit;
		end;
  end;
  ModalResult := mrOk;
end;

procedure TgtDocumentDlg.shpBackgroundColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	MousePoint.X := X;
	MousePoint.Y := Y;
end;

procedure TgtDocumentDlg.shpBackgroundColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	ColorDialog.Color := (Sender as TShape).Brush.Color;
	if (((X = MousePoint.x) and (Y = MousePoint.y)) and (Button = mbleft)) then
		if ColorDialog.Execute then
			(Sender as TShape).Brush.Color := ColorDialog.Color;
end;

procedure TgtDocumentDlg.lblGnosticeClick(Sender: TObject);
begin
	ShellExecute(Handle, nil, 'http://www.gnostice.com', nil, nil,
		SW_SHOWNORMAL);
end;

procedure TgtDocumentDlg.edKeyPress(Sender: TObject;
  var Key: Char);
begin
  {$IFDEF gtDelphi2009Up}
  	if not(SysUtils.CharInSet(Key, ['0'..'9', '.', #8])) then
  {$ELSE}
	if not(Key in ['0'..'9', '.', #8]) then
  {$ENDIF}
		Key := #0;
end;

procedure TgtDocumentDlg.cbOutputImageFormatChange(Sender: TObject);
begin
	lblJPEGQuality.Enabled := (chkImage.Checked and
		(cbOutputImageFormat.Text = ImageFormats[ifJPEG]));
	edJPEGQuality.Enabled := lblJPEGQuality.Enabled;
	edJPEGQuality.Color := EditColor[edJPEGQuality.Enabled];
end;

procedure TgtDocumentDlg.rbtnAllClick(Sender: TObject);
begin
  edPages.Text := '';
end;

procedure TgtDocumentDlg.rbtnPagesClick(Sender: TObject);
begin
  edPages.SetFocus;
end;

procedure TgtDocumentDlg.edPagesChange(Sender: TObject);
begin
	if (edPages.Text = '') then
		rbtnAll.SetFocus
	else
		rbtnPages.Checked := True;
end;

procedure TgtDocumentDlg.edPagesKeyPress(Sender: TObject; var Key: Char);
begin
{$IFDEF gtDelphi2009Up}
	if not(SysUtils.CharInSet(Key,['0'..'9', #8, '-', ','])) then
{$ELSE}
	if not(Key in ['0'..'9', #8, '-', ',']) then
{$ENDIF}
    Key := #0;
end;

procedure TgtDocumentDlg.edSourceDPIKeyPress(Sender: TObject;
  var Key: Char);
begin
{$IFDEF gtDelphi2009Up}
	if not(SysUtils.CharInSet(Key,['0'..'9', #8])) then
{$ELSE}
	if not(Key in ['0'..'9', #8]) then
{$ENDIF}

		Key := #0;
end;

procedure TgtDocumentDlg.lbDocumentDlgClick(Sender: TObject);
begin
  pcDocument.ActivePageIndex := lbDocumentDlg.ItemIndex;
  lblDialogCaption.Caption := lbDocumentDlg.Items.Strings[lbDocumentDlg.ItemIndex]
end;

procedure TgtDocumentDlg.chkEMailAfterCreateClick(Sender: TObject);
begin
	SetControlsEnabled(gbEMailInfo, chkEMailAfterCreate.Checked);
  chkAuthenticationClick(Sender)
end;

procedure TgtDocumentDlg.chkAuthenticationClick(Sender: TObject);
begin
	SetControlsEnabled(gbAuthentication, chkAuthentication.Checked);
end;

procedure TgtDocumentDlg.UpdateEMailInfo(Sender: TObject);
begin
  if chkEMailAfterCreate.Checked then
  begin
    //
  end;
end;

end.
