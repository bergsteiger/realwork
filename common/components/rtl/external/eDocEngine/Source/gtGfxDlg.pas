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

unit gtGfxDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtCstGfxEng, gtDocDlg, gtDocResStrs, gtUtils3;

type
  TgtGraphicsDlg = class(TgtDocumentDlg)
    tsQualityAndScaling: TTabSheet;
    gbQualityAndScaling: TGroupBox;
    lblPixelFormat: TLabel;
    cbPixelFormat: TComboBox;
    edScaleX: TEdit;
    edScaleY: TEdit;
    lblScaleX: TLabel;
    lblScaleY: TLabel;
    chkMonochrome: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure Localize; override;
    
  public
    { Public declarations }
  end;

const
	PixelFormats: array[TPixelFormat] of String = (SPFDevice, SPF1bit, SPF4bit,
		SPF8bit, SPF15bit, SPF16bit, SPF24bit, SPF32bit, SPFCustom);

implementation

uses gtCstDocEng;

{$R *.dfm}

{ TgtGraphicsDlg }

procedure TgtGraphicsDlg.Localize;
begin
  inherited;
  tsQualityAndScaling.Caption := StsQualityAndScaling;
  chkMonochrome.Caption := SchkMonochrome;
  lblPixelFormat.Caption := SlblPixelFormat;
  lblScaleX.Caption := SlblScaleX;
  lblScaleY.Caption := SlblScaleY;
end;

procedure TgtGraphicsDlg.FormCreate(Sender: TObject);
var
  I: TPixelFormat;
begin
  inherited;
  SetControlsEnabled(gbDocInfo, False);
	for I := Low(TPixelFormat) to High(TPixelFormat)  do
		cbPixelFormat.Items.AddObject(PixelFormats[I], TObject(I));
  I := High(TPixelFormat);
  cbPixelFormat.Items.Delete(Integer(I));
end;

procedure TgtGraphicsDlg.btnOKClick(Sender: TObject);
begin
  with TgtCustomGraphicsEngine(Engine) do
  begin
    if chkText.Checked then
      ItemsToRender := ItemsToRender + [irText]
    else
      ItemsToRender := ItemsToRender - [irText];
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
      ImagePixelFormat := TPixelFormat(cbImagePixelFormat.Items.Objects[
        cbImagePixelFormat.ItemIndex]);
      SourceDPI := StrToInt(edSourceDPI.Text);
    end;

    BackgroundColor := shpBackgroundColor.Brush.Color;
    BackgroundImage.Assign(imgBackgroundImage.Picture);
		BackgroundImageDisplayType := TgtBackgroundDisplayType(
			cbBackgroundDisplayType.Items.Objects[
			cbBackgroundDisplayType.ItemIndex]);
    ScaleX := StrToFloat(edScaleX.Text);
    ScaleY := StrToFloat(edScaleY.Text);
  end;
  inherited btnOKClick(Sender);
end;

procedure TgtGraphicsDlg.chkImageClick(Sender: TObject);
begin
	SetControlsEnabled(gbImageSettings, chkImage.Checked);
  lblOutputImageFormat.Enabled := False;
  cbOutputImageFormat.Enabled := False;
  cbOutputImageFormat.Color := clInactiveBorder;
  lblJPEGQuality.Enabled := False;
  edJPEGQuality.Enabled := False;
  edJPEGQuality.Color := clInactiveBorder;
end;

procedure TgtGraphicsDlg.FormShow(Sender: TObject);
begin
  with TgtCustomGraphicsEngine(Engine) do
  begin
    chkText.Checked := irText in ItemsToRender;
    chkShape.Checked := irShape in ItemsToRender;
    chkImage.Checked := irImage in ItemsToRender;
    with ImageSettings do
    begin
      cbImagePixelFormat.ItemIndex := Integer(TPixelFormat(ImagePixelFormat));
      edSourceDPI.Text := IntToStr(SourceDPI);
    end;
    chkImageClick(Sender);    
    imgBackgroundImage.Picture.Assign(BackgroundImage);
    cbBackgroundDisplayType.ItemIndex :=
      cbBackgroundDisplayType.Items.IndexOfObject(
      TObject(Ord(BackgroundImageDisplayType)));
    shpBackgroundColor.Brush.Color := BackgroundColor;
    if (imgBackgroundImage.Picture.Graphic = nil) or
      imgBackgroundImage.Picture.Graphic.Empty then
      btnClearClick(Sender);
    edScaleX.Text := FloatToStr(ScaleX);
    edScaleY.Text := FloatToStr(ScaleY);
  end;
  inherited;
end;

end.
