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

unit gtRTFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtPlnDlg, gtDocResStrs, gtCstDocEng, gtRTFEng;

type
  TgtRTFEngineDlg = class(TgtPlainSheetDlg)
    chkGraphicDataInBinary: TCheckBox;
    rgpEncodingType: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  protected
		procedure Localize; override;
        
  public
    { Public declarations }
  end;

const
  EncodingType: array[TgtRTFEncodingType] of String = (SetPositionalAccuracy,
    SetEaseOfEditing);
    
implementation

uses gtDocDlg;

{$R *.dfm}

procedure TgtRTFEngineDlg.FormCreate(Sender: TObject);
begin
	inherited FormCreate(Sender);
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifGIF))));
  cbBackgroundDisplayType.Items.Delete(
    cbBackgroundDisplayType.Items.IndexOfObject(TObject(Ord(dtTile))));
  lblBackgroundColor.Visible := False;
  shpBackgroundColor.Visible := False;
end;

procedure TgtRTFEngineDlg.Localize;
var
  LI: TgtRTFEncodingType;
begin
  inherited;
  Caption := SRTFDlgCaption;

  chkGraphicDataInBinary.Caption := SchkGraphicDataInBinary;
  rgpEncodingType.Caption := SrgpEncodingType;

  rgpEncodingType.Items.Clear;
  for LI := Low(TgtRTFEncodingType) to High(TgtRTFEncodingType) do
    rgpEncodingType.Items.AddObject(EncodingType[LI], TObject(LI));
end;

procedure TgtRTFEngineDlg.FormShow(Sender: TObject);
begin
  with TgtRTFEngine(Engine) do
  begin
    chkGraphicDataInBinary.Checked := Preferences.GraphicDataInBinary;
    rgpEncodingType.ItemIndex :=
      Integer(TgtRTFEncodingType(DocumentEncodingType));
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
    if (imgBackgroundImage.Picture.Graphic = nil) or
      imgBackgroundImage.Picture.Graphic.Empty then
      btnClearClick(Sender);
  end;
  inherited FormShow(Sender);
end;

procedure TgtRTFEngineDlg.btnOKClick(Sender: TObject);
begin
  inherited;
  with TgtRTFEngine(Engine) do
  begin
    Preferences.GraphicDataInBinary := chkGraphicDataInBinary.Checked;
    DocumentEncodingType :=
      TgtRTFEncodingType(rgpEncodingType.Items.Objects[
      rgpEncodingType.ItemIndex]);
    BackgroundImage.Assign(imgBackgroundImage.Picture);
		BackgroundImageDisplayType := TgtBackgroundDisplayType(
			cbBackgroundDisplayType.Items.Objects[
			cbBackgroundDisplayType.ItemIndex]);
  end;
end;

end.
