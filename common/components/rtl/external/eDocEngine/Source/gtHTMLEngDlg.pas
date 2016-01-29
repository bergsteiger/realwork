{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
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
unit gtHTMLEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  gtDocDlg, gtPlnDlg, gtDocResStrs,
  gtCstDocEng, gtCstHTMLEng, gtUtils3
  {$IFDEF gtPro}
  , gtExHTMLEng
  {$ENDIF};

type
  TgtHTMLEngineDlg = class(TgtPlainSheetDlg)
    chkAutoScrollDocument: TCheckBox;
    tsFileLocationAndOptimization: TTabSheet;
    gbOthers: TGroupBox;
    chkOptimizeforIE: TCheckBox;
    gbExtCSSFile: TGroupBox;
    lblCSSFile: TLabel;
    sbtnCSSFileName: TSpeedButton;
    edCSSFile: TEdit;
    chkOutputStylesToCSSFile: TCheckBox;
    chkPageEndLines: TCheckBox;
    gbOuputJSFile: TGroupBox;
    lblJSFile: TLabel;
    sbtnJSFileName: TSpeedButton;
    edJSFileName: TEdit;
    chkOutputScriptsToJSFile: TCheckBox;
    tsNavigatorOptions: TTabSheet;
    gbShowNavigator: TGroupBox;
    lblNavigatorBackgroundColor: TLabel;
    lblHoverForeColor: TLabel;
    lblHoverBackColor: TLabel;
    shpNavigatorBackgroundColor: TShape;
    shpHoverForeColor: TShape;
    shpHoverBackColor: TShape;
    lblNavigatorType: TLabel;
    lblNavigatorOrientation: TLabel;
    lblNavigatorPosition: TLabel;
    gbUseLinks: TGroupBox;
    pcShowNavigator: TPageControl;
    tsUseTextLinks: TTabSheet;
    lblFirst: TLabel;
    lblLast: TLabel;
    lblNext: TLabel;
    lblPrevious: TLabel;
    lblLinkCaptions: TLabel;
    btnSetFont: TButton;
    edFirst: TEdit;
    edPrevious: TEdit;
    edNext: TEdit;
    edLast: TEdit;
    tsUseGraphicLinks: TTabSheet;
    lblUseGraphicLinksFirst: TLabel;
    lblUseGraphicLinksPrevious: TLabel;
    lblUseGraphicLinksNext: TLabel;
    lblUseGraphicLinksLast: TLabel;
    sbtnFirst: TSpeedButton;
    sbtnPrevious: TSpeedButton;
    sbtnNext: TSpeedButton;
    sbtnLast: TSpeedButton;
    lblImageSource: TLabel;
    edUseGraphicLinksFirst: TEdit;
    edUseGraphicLinksPrevious: TEdit;
    edUseGraphicLinksLast: TEdit;
    edUseGraphicLinksNext: TEdit;
    rbtnUseTextLinks: TRadioButton;
    rbtnUseGraphicLinks: TRadioButton;
    cbNavigatorType: TComboBox;
    cbNavigatorOrientation: TComboBox;
    cbNavigatorPosition: TComboBox;
    chkShowNavigator: TCheckBox;
    chkSingleFile: TCheckBox;
    FontDialog: TFontDialog;
    OpenDialog: TOpenDialog;
    tsTOCPageSettings: TTabSheet;
    gbTOCPageSettings: TGroupBox;
    lblItemFont: TLabel;
    pnlTOCItemFont: TPanel;
    sbtnTOCItemFont: TSpeedButton;
    lblTOCTitle: TLabel;
    lblAlignment: TLabel;
    edTOCTitle: TEdit;
    cbAlignment: TComboBox;
    lblTitleFont: TLabel;
    pnlTOCTitleFont: TPanel;
    sbtnTOCTitleFont: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkSingleFileClick(Sender: TObject);
    procedure chkShowNavigatorClick(Sender: TObject);
    procedure rbtnUseLinksClick(Sender: TObject);
    procedure sbtnCSSFileNameClick(Sender: TObject);
    procedure sbtnJSFileNameClick(Sender: TObject);
    procedure sbtnSetFontClick(Sender: TObject);
    procedure btnImageSourceClick(Sender: TObject);
    procedure chkOutputStylesToCSSFileClick(Sender: TObject);
    procedure chkOutputScriptsToJSFileClick(Sender: TObject);
    procedure btnSetFontClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure shpNavigatorColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure shpNavigatorColorMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
		FLinkFont: TFont;
    HTMLMousePoint: TPoint;    

  protected
		procedure Localize; override;

  public
    { Public declarations }
  end;

const
  NavigatorType: array[TgtHTMLNavigatorType] of String = (SntFixedToScreen,
    SntFixedToPage);

  NavigatorOrientation: array[TgtHTMLNavigatorOrientation] of String =
    (SnoHorizontal, SnoVertical);

  NavigatorPosition: array[TgtHTMLNavigatorPosition] of String = (SnpTopLeft,
    SnpTopCenter, SnpTopRight, SnpCenterLeft, SnpCenter, SnpCenterRight,
		SnpBottomLeft, SnpBottomCenter, SnpBottomRight);

  HAlignment: array[TgtHAlignment] of String = ( ShaLeft, ShaRight, ShaCenter,
    ShaJustify, ShaGeneral);
  
implementation

{$R *.dfm}

{ TgtHTMLEngineDlg }

procedure TgtHTMLEngineDlg.Localize;
begin
  inherited;
  Caption := SHTMLDlgCaption;
  chkAutoScrollDocument.Caption := SchkAutoScrollDocument;
  tsFileLocationAndOptimization.Caption := StsFileLocationAndOptimization;
  chkOptimizeforIE.Caption := SchkOptimizeforIE;
  lblCSSFile.Caption := SlblCSSFile;
  sbtnCSSFileName.Caption := SsbtnCSSFileName;
  chkOutputStylesToCSSFile.Caption := SchkOutputStylesToCSSFile;
  chkPageEndLines.Caption := SchkPageEndLines;
  lblJSFile.Caption := SlblJSFile;
  sbtnJSFileName.Caption := SsbtnJSFileName;
  chkOutputScriptsToJSFile.Caption := SchkOutputScriptsToJSFile;
  tsNavigatorOptions.Caption := StsNavigatorOptions;
  lblNavigatorBackgroundColor.Caption := SlblNavigatorBackgroundColor;
  lblHoverForeColor.Caption := SlblHoverForeColor;
  lblHoverBackColor.Caption := SlblHoverBackColor;
  lblNavigatorType.Caption := SlblNavigatorType;
  lblNavigatorOrientation.Caption := SlblNavigatorOrientation;
  lblNavigatorPosition.Caption := SlblNavigatorPosition;
  tsUseTextLinks.Caption := StsUseTextLinks;
  lblFirst.Caption := SlblFirst;
  lblLast.Caption := SlblLast;
  lblNext.Caption := SlblNext;
  lblPrevious.Caption := SlblPrevious;
  lblLinkCaptions.Caption := SlblLinkCaptions;
  btnSetFont.Caption := SbtnSetFont;
  tsUseGraphicLinks.Caption := StsUseGraphicLinks;
  lblUseGraphicLinksFirst.Caption := SlblUseGraphicLinksFirst;
  lblUseGraphicLinksPrevious.Caption := SlblUseGraphicLinksPrevious;
  lblUseGraphicLinksNext.Caption := SlblUseGraphicLinksNext;
  lblUseGraphicLinksLast.Caption := SlblUseGraphicLinksLast;
  sbtnFirst.Caption := SsbtnFirst;
  sbtnPrevious.Caption := SsbtnPrevious;
  sbtnNext.Caption := SsbtnNext;
  sbtnLast.Caption := SsbtnLast;
  lblImageSource.Caption := SlblImageSource;
  rbtnUseTextLinks.Caption := SrbtnUseTextLinks;
  rbtnUseGraphicLinks.Caption := SrbtnUseGraphicLinks;
  chkShowNavigator.Caption := SchkShowNavigator;
  chkSingleFile.Caption := SchkSingleFile;
  
  {$IFDEF gtPro}
  tsTOCPageSettings.Caption := StsTOCPageSettings;
  lblItemFont.Caption := SlblItemFont;
  lblTOCTitle.Caption := SlblTOCTitle;
  lblAlignment.Caption := SlblAlignment;
  lblTitleFont.Caption := SlblTitleFont;
  
  {$ENDIF}
end;

procedure TgtHTMLEngineDlg.FormCreate(Sender: TObject);
var
  I: TgtHTMLNavigatorType;
  J: TgtHTMLNavigatorOrientation;
  K: TgtHTMLNavigatorPosition;
  {$IFDEF gtPro}
  L: TgtHAlignment;
  {$ENDIF}
begin
	inherited FormCreate(Sender);
	FLinkFont := TFont.Create;  
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifMetafile))));

  for I := Low(TgtHTMLNavigatorType) to High(TgtHTMLNavigatorType) do
    cbNavigatorType.Items.AddObject(NavigatorType[I], TObject(I));
  for J := Low(TgtHTMLNavigatorOrientation) to
    High(TgtHTMLNavigatorOrientation) do
    cbNavigatorOrientation.Items.AddObject(NavigatorOrientation[J], TObject(J));
  for K := Low(TgtHTMLNavigatorPosition) to High(TgtHTMLNavigatorPosition) do
    cbNavigatorPosition.Items.AddObject(NavigatorPosition[K], TObject(K));

//  {$IFDEF EMailSupport}
//  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1, SlbDocumentDlgFileSettings); //File Location && Optimization
//  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1, SlbDocumentDlgNavigatorOptions);
//  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1, SlbDocumentDlgTOCPageSettings);
//  {$ELSE}
  lbDocumentDlg.Items.Append(SlbDocumentDlgFileSettings); //File Location && Optimization
  lbDocumentDlg.Items.Append(SlbDocumentDlgNavigatorOptions);
  lbDocumentDlg.Items.Append(SlbDocumentDlgTOCPageSettings);
//  {$ENDIF}

  {$IFDEF gtPro}
  for L := Low(TgtHAlignment) to High(TgtHAlignment) do
    cbAlignment.Items.AddObject(HAlignment[L], TObject(L));
  {$ELSE}
  tsTOCPageSettings.TabVisible := False;
  {$ENDIF}
end;

procedure TgtHTMLEngineDlg.FormShow(Sender: TObject);
begin
  {$IFDEF gtPro}
  with TgtExHTMLEngine(Engine) do
  {$ELSE}
  with TgtCustomHTMLEngine(Engine) do
  {$ENDIF}
  begin

    with ImageSettings do
    begin
      cbOutputImageFormat.ItemIndex := cbOutputImageFormat.Items.IndexOf(
        ImageFormats[TgtOutputImageFormat(OutputImageFormat)]);
      edJPEGQuality.Text := IntToStr(JPEGQuality);
      if OutputImageFormat = ifJPEG then
        edJPEGQuality.Enabled := True
      else
        edJPEGQuality.Enabled := False;
      cbOutputImageFormatChange(Sender);
    end;  
    imgBackgroundImage.Picture.Assign(BackgroundImage);
    cbBackgroundDisplayType.ItemIndex :=
      cbBackgroundDisplayType.Items.IndexOfObject(
      TObject(Ord(BackgroundImageDisplayType)));
    shpBackgroundColor.Brush.Color := BackgroundColor;
    if (imgBackgroundImage.Picture.Graphic = nil) or
      imgBackgroundImage.Picture.Graphic.Empty then
      btnClearClick(Sender);

    with Preferences do
    begin
      chkAutoScrollDocument.Checked := AutoScroll;
      chkPageEndLines.Checked := PageEndLines;
      chkOptimizeforIE.Checked := OptimizeForIE;
    end;
    chkOutputStylesToCSSFile.Checked := OutputStylesToCSSFile;
    edCSSFile.Text := CSSFileName;
    chkOutputScriptsToJSFile.Checked := OutputScriptsToJSFile;
    edJSFileName.Text := JSFileName;

    chkSingleFile.Checked := Preferences.SingleFile;
    chkShowNavigator.Checked := Navigator.Enabled;
    shpNavigatorBackgroundColor.Brush.Color := Navigator.LinkBackColor;
    shpHoverForeColor.Brush.Color := Navigator.LinkHoverForeColor;
    shpHoverBackColor.Brush.Color := Navigator.LinkHoverBackColor;

		rbtnUseTextLinks.Checked := Navigator.UseTextLinks;
		rbtnUseGraphicLinks.Checked := not Navigator.UseTextLinks;
    
		edFirst.Text := Navigator.LinkTextFirst;
		edPrevious.Text := Navigator.LinkTextPrev;
		edNext.Text := Navigator.LinkTextNext;
		edLast.Text := Navigator.LinkTextLast;

		edUseGraphicLinksFirst.Text := Navigator.LinkImageFirst;
		edUseGraphicLinksPrevious.Text := Navigator.LinkImagePrev;
		edUseGraphicLinksNext.Text := Navigator.LinkImageNext;
		edUseGraphicLinksLast.Text := Navigator.LinkImageLast;

    FLinkFont.Assign(Navigator.LinkFont);
    edFirst.Font.Name := FLinkFont.Name;
    edFirst.Font.Color := FLinkFont.Color;
    edFirst.Font.Style := FLinkFont.Style;
    edPrevious.Font.Name := FLinkFont.Name;
    edPrevious.Font.Color := FLinkFont.Color;
    edPrevious.Font.Style := FLinkFont.Style;
    edNext.Font.Name := FLinkFont.Name;
    edNext.Font.Color := FLinkFont.Color;
    edNext.Font.Style := FLinkFont.Style;
    edLast.Font.Name := FLinkFont.Name;
    edLast.Font.Color := FLinkFont.Color;
    edLast.Font.Style := FLinkFont.Style;

		cbNavigatorType.ItemIndex := cbNavigatorType.Items.IndexOfObject(
			TObject(Ord(Navigator.NavigatorType)));
		cbNavigatorOrientation.ItemIndex := cbNavigatorOrientation.Items.
			IndexOfObject(TObject(Ord(Navigator.NavigatorOrientation)));
		cbNavigatorPosition.ItemIndex := cbNavigatorPosition.Items.IndexOfObject(
			TObject(Ord(Navigator.NavigatorPosition)));    

    pcShowNavigator.ActivePage := tsUseTextLinks;
    chkSingleFileClick(Sender);

    {$IFDEF gtPro}
    with TOCPageSettings do
    begin
      edTOCTitle.Text := Title;
      cbAlignment.ItemIndex := cbAlignment.Items.IndexOfObject(
        TObject(Ord(TitleAlignment)));
      pnlTOCItemFont.Font := ItemFont;
      pnlTOCTitleFont.Font := TitleFont;
    end;
    {$ENDIF}        
  end;
  inherited FormShow(Sender);
end;

procedure TgtHTMLEngineDlg.chkSingleFileClick(Sender: TObject);
begin
	chkShowNavigator.Enabled := not chkSingleFile.Checked;
	chkPageEndLines.Enabled := chkSingleFile.Checked;
	chkShowNavigatorClick(Sender);
end;

procedure TgtHTMLEngineDlg.chkShowNavigatorClick(Sender: TObject);
begin
	SetControlsEnabled(gbShowNavigator, (chkShowNavigator.Checked and
		chkShowNavigator.Enabled));
end;

procedure TgtHTMLEngineDlg.rbtnUseLinksClick(Sender: TObject);
begin
	pcShowNavigator.ActivePage := pcShowNavigator.Pages[
		(Sender as TRadioButton).Tag];
end;

procedure TgtHTMLEngineDlg.sbtnCSSFileNameClick(Sender: TObject);
begin
	OpenDialog.Filter := SOpenDialogFilterCSSFile;
	if OpenDialog.Execute then
		edCSSFile.Text := OpenDialog.FileName;
end;

procedure TgtHTMLEngineDlg.sbtnJSFileNameClick(Sender: TObject);
begin
	OpenDialog.Filter := SOpenDialogFilterJSSFile;
	if OpenDialog.Execute then
		edJSFileName.Text := OpenDialog.FileName;
end;

procedure TgtHTMLEngineDlg.sbtnSetFontClick(Sender: TObject);
begin
  {$IFDEF gtPro}
	with FontDialog do
	begin
    if (Sender = sbtnTOCItemFont) then
      Font := pnlTOCItemFont.Font
    else if (Sender = sbtnTOCTitleFont) then
      Font := pnlTOCTitleFont.Font;
		if Execute then
    begin
      if (Sender = sbtnTOCItemFont) then
        pnlTOCItemFont.Font.Assign(FontDialog.Font)
      else if (Sender = sbtnTOCTitleFont) then
        pnlTOCTitleFont.Font.Assign(FontDialog.Font);
    end;
	end;
  {$ENDIF}
end;

procedure TgtHTMLEngineDlg.btnImageSourceClick(Sender: TObject);
begin
	if OpenPictureDialog.Execute then
	begin
		if (Sender = sbtnFirst) then
			edUseGraphicLinksFirst.Text := OpenPictureDialog.FileName
		else if (Sender = sbtnPrevious) then
			edUseGraphicLinksPrevious.Text := OpenPictureDialog.FileName
		else if (Sender = sbtnNext) then
			edUseGraphicLinksNext.Text := OpenPictureDialog.FileName
		else if (Sender = sbtnLast) then
			edUseGraphicLinksLast.Text := OpenPictureDialog.FileName;
	end;
end;

procedure TgtHTMLEngineDlg.chkOutputStylesToCSSFileClick(Sender: TObject);
begin
	SetControlsEnabled(gbExtCSSFile, (chkOutputStylesToCSSFile.Enabled and
		chkOutputStylesToCSSFile.Checked));
end;

procedure TgtHTMLEngineDlg.chkOutputScriptsToJSFileClick(Sender: TObject);
begin
	SetControlsEnabled(gbOuputJSFile, (chkOutputScriptsToJSFile.Enabled and
		chkOutputScriptsToJSFile.Checked));
end;

procedure TgtHTMLEngineDlg.btnSetFontClick(Sender: TObject);
begin
	FontDialog.Font.Assign(FLinkFont);
	if FontDialog.Execute then
		with FontDialog do
		begin
			edFirst.Font.Name := Font.Name;
			edFirst.Font.Color := Font.Color;
			edFirst.Font.Style := Font.Style;
			edPrevious.Font.Name := Font.Name;
			edPrevious.Font.Color := Font.Color;
			edPrevious.Font.Style := Font.Style;
			edNext.Font.Name := Font.Name;
			edNext.Font.Color := Font.Color;
			edNext.Font.Style := Font.Style;
			edLast.Font.Name := Font.Name;
			edLast.Font.Color := Font.Color;
			edLast.Font.Style := Font.Style;
			FLinkFont.Assign(Font);
		end;
end;

procedure TgtHTMLEngineDlg.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLinkFont);
  inherited;
end;

procedure TgtHTMLEngineDlg.btnOKClick(Sender: TObject);
begin
  {$IFDEF gtPro}
  with TgtExHTMLEngine(Engine) do
  {$ELSE}
  with TgtCustomHTMLEngine(Engine) do
  {$ENDIF}
  begin
    Preferences.AutoScroll := chkAutoScrollDocument.Checked;
    BackgroundColor := shpBackgroundColor.Brush.Color;
    BackgroundImage.Assign(imgBackgroundImage.Picture);
		BackgroundImageDisplayType := TgtBackgroundDisplayType(
			cbBackgroundDisplayType.Items.Objects[
			cbBackgroundDisplayType.ItemIndex]);
    with Preferences do
    begin
      PageEndLines := chkPageEndLines.Checked;
      OptimizeForIE := chkOptimizeforIE.Checked;
    end;
    OutputStylesToCSSFile := chkOutputStylesToCSSFile.Checked;
    CSSFileName := edCSSFile.Text;
    OutputScriptsToJSFile := chkOutputScriptsToJSFile.Checked;
    JSFileName := edJSFileName.Text;

    with Preferences do
      SingleFile := chkSingleFile.Checked;
    with Navigator do
    begin
	    Enabled := chkShowNavigator.Checked;
      LinkBackColor := shpNavigatorBackgroundColor.Brush.Color;
      LinkHoverForeColor := shpHoverForeColor.Brush.Color;
      LinkHoverBackColor := shpHoverBackColor.Brush.Color;
      UseTextLinks := rbtnUseTextLinks.Checked;
      LinkTextFirst := edFirst.Text;
      LinkTextNext := edNext.Text;
      LinkTextPrev := edPrevious.Text;
      LinkTextLast := edLast.Text;
      LinkFont.Assign(FLinkFont);
      LinkImageFirst := edUseGraphicLinksFirst.Text;
      LinkImageNext := edUseGraphicLinksNext.Text;
      LinkImagePrev := edUseGraphicLinksPrevious.Text;
      LinkImageLast := edUseGraphicLinksLast.Text;
      NavigatorType := TgtHTMLNavigatorType(cbNavigatorType.Items.Objects[
        cbNavigatorType.ItemIndex]);
      NavigatorOrientation :=
        TgtHTMLNavigatorOrientation(cbNavigatorOrientation.Items.Objects[
        cbNavigatorOrientation.ItemIndex]);
      NavigatorPosition :=
        TgtHTMLNavigatorPosition(cbNavigatorPosition.Items.Objects[
        cbNavigatorPosition.ItemIndex]);
    end;
    {$IFDEF gtPro}
    with TOCPageSettings do
    begin
      Title := edTOCTitle.Text;  
      TitleAlignment := TgtHAlignment(cbAlignment.Items.Objects[
        cbAlignment.ItemIndex]);
      ItemFont.Assign(pnlTOCItemFont.Font);
      TitleFont.Assign(pnlTOCTitleFont.Font);
    end;
    {$ENDIF}
  end;
  inherited;
end;

procedure TgtHTMLEngineDlg.shpNavigatorColorMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
	HTMLMousePoint.X := X;
	HTMLMousePoint.Y := Y;
end;

procedure TgtHTMLEngineDlg.shpNavigatorColorMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
	ColorDialog.Color := (Sender as TShape).Brush.Color;
	if (((X = HTMLMousePoint.x) and (Y = HTMLMousePoint.y)) and
    (Button = mbleft)) then
		if ColorDialog.Execute then
			(Sender as TShape).Brush.Color := ColorDialog.Color;
end;

end.

