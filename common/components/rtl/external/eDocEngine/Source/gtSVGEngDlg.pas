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

unit gtSVGEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtPlnDlg, gtDocResStrs, gtCstDocEng, gtSVGEng;

type
  TgtSVGEngineDlg = class(TgtPlainSheetDlg)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  protected
		procedure Localize; override;
        
  public
    { Public declarations }
  end;


implementation

uses gtDocDlg, gtCstPlnEng;

{$R *.dfm}

{ TgtSVGEngineDlg }

procedure TgtSVGEngineDlg.Localize;
begin
  inherited;
  Caption := SSVGDlgCaption;
end;

procedure TgtSVGEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifBMP))));
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifGIF))));
	cbOutputImageFormat.Items.Delete(
		cbOutputImageFormat.Items.IndexOfObject(TObject(Ord(ifMetafile))));

  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SBackground));
  //tsBackground.TabVisible := False;
end;

procedure TgtSVGEngineDlg.FormShow(Sender: TObject);
begin
  inherited FormShow(Sender);
  with TgtSVGEngine(Engine) do
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
  end;
end;

end.
