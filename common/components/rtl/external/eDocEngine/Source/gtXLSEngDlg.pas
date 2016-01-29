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

unit gtXLSEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtDocDlg, gtSpdDlg, gtDocResStrs, gtUtils3, gtCstDocEng, gtCstSpdEng,
  gtCstXLSEng
  {$IFDEF gtPro}
  , gtExXLSEng
  {$ENDIF}
  ;

type
  TgtExcelEngineDlg = class(TgtSpreadSheetDlg)
    lblPagesPerWorkSheet: TLabel;
    edPagePerWorkSheet: TEdit;
    chkPageMargins: TCheckBox;
    chkPrintGridLines: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkImageClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnSelectImageClick(Sender: TObject);
    procedure edPagePerWorkSheetKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

  protected
    procedure Localize; override;

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TgtExcelEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  //tsContent.TabVisible := True;
  SetControlsEnabled(gbDocInfo, False);
  gbDocInfo.Enabled := False;
  //tsBackground.TabVisible := True;
  lblBackgroundDisplayType.Enabled := False;
  cbBackgroundDisplayType.Enabled := False;
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifJPEG))));
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifGIF))));
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifPNG))));
  {$IFNDEF gtPro}
  chkShape.Enabled := False;
  chkImage.Enabled := False;
  SetControlsEnabled(gbImageSettings, False);
  {$ENDIF}
end;

procedure TgtExcelEngineDlg.FormShow(Sender: TObject);
begin
  {$IFDEF gtPro}
  with TgtExExcelEngine(Engine) do
  {$ELSE}
  with TgtCustomExcelEngine(Engine) do
  {$ENDIF}
  begin
    {$IFDEF gtPro}
    chkImage.Checked := irImage in ItemsToRender;
    {$ENDIF}
    imgBackgroundImage.Picture.Assign(BackgroundImage);    
    if (imgBackgroundImage.Picture.Graphic = nil) or
      imgBackgroundImage.Picture.Graphic.Empty then
      btnClearClick(Sender);
    shpBackgroundColor.Brush.Color := BackgroundColor;
    {$IFDEF gtPro}
    with ImageSettings do
    begin
      cbOutputImageFormat.ItemIndex := cbOutputImageFormat.Items.IndexOf(
        ImageFormats[TgtOutputImageFormat(OutputImageFormat)]);
      cbImagePixelFormat.ItemIndex := Integer(TPixelFormat(ImagePixelFormat));
      edSourceDPI.Text := IntToStr(SourceDPI);
      cbOutputImageFormatChange(Sender);
    end;
    {$ENDIF}
    with Preferences do
    begin
      edPagePerWorkSheet.Text := IntToStr(PagesPerWorksheet);
      chkPrintGridLines.Caption := SchkPrintGridLines;
      chkPageMargins.Caption := SchkPageMargins;
      lblPagesPerWorkSheet.Caption := SlblPagesPerWorkSheet;
      chkPageMargins.Checked := PageMargins;
      chkPrintGridLines.Checked := PrintGridLines; 
    end;      
  end;
  inherited;
end;

procedure TgtExcelEngineDlg.chkImageClick(Sender: TObject);
begin
	SetControlsEnabled(gbImageSettings, chkImage.Checked);
	cbOutputImageFormatChange(Sender);
end;

procedure TgtExcelEngineDlg.Localize;
begin
  inherited;
  Caption := SXLSDlgCaption;

  lblPagesPerWorkSheet.Caption;
  chkPageMargins.Caption;
  chkPrintGridLines.Caption;
end;

procedure TgtExcelEngineDlg.btnOKClick(Sender: TObject);
begin
  {$IFDEF gtPro}
  with TgtExExcelEngine(Engine) do
  {$ELSE}
  with TgtCustomExcelEngine(Engine) do
  {$ENDIF}
  begin
    if chkText.Checked then
      ItemsToRender := ItemsToRender + [irText]
    else
      ItemsToRender := ItemsToRender - [irText];

    {$IFDEF gtPro}
    if chkShape.Checked then
      ItemsToRender := ItemsToRender + [irShape]
    else
      ItemsToRender := ItemsToRender - [irShape];
    if chkImage.Checked then
      ItemsToRender := ItemsToRender + [irImage]
    else
      ItemsToRender := ItemsToRender - [irImage];

    with ImageSettings do
    begin
      OutputImageFormat :=
        TgtOutputImageFormat(cbOutputImageFormat.Items.Objects[
        cbOutputImageFormat.ItemIndex]);
      ImagePixelFormat := TPixelFormat(cbImagePixelFormat.Items.Objects[
        cbImagePixelFormat.ItemIndex]);
      SourceDPI := StrToInt(edSourceDPI.Text);
    end;
    {$ENDIF}
    BackgroundImage.Assign(imgBackgroundImage.Picture);
    BackgroundColor := shpBackgroundColor.Brush.Color;

    with Preferences do
    begin
      PagesPerWorksheet := TgtWorksheetPagesType(StrToInt(
        edPagePerWorkSheet.Text));
      PageMargins := chkPageMargins.Checked;
      PrintGridLines := chkPrintGridLines.Checked;
    end;      
  end;
  inherited;
end;

procedure TgtExcelEngineDlg.btnSelectImageClick(Sender: TObject);
begin
  inherited;
  lblBackgroundDisplayType.Enabled := False;
  cbBackgroundDisplayType.Enabled := False;
end;

procedure TgtExcelEngineDlg.edPagePerWorkSheetKeyPress(Sender: TObject;
  var Key: Char);
begin
{$IFDEF gtDelphi2009Up}
	if not(SysUtils.CharInSet(Key, ['0'..'9', #8])) then
{$ELSE}
	if not(Key in ['0'..'9', #8]) then
{$ENDIF}

		Key := #0;
end;

end.
