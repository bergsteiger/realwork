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

{$I gtDocDefines.inc}
unit gtJPEGEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtGfxDlg, gtDocResStrs, gtJPEGEng, jpeg;

type
  TgtJPEGEngineDlg = class(TgtGraphicsDlg)
    chkProgressiveEncoding: TCheckBox;
    lblQuality: TLabel;
    edQuality: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure Localize; override;

  public
    { Public declarations }
  end;

implementation

uses gtCstDocEng;

{$R *.dfm}

{ TgtJPEGEngineDlg }

procedure TgtJPEGEngineDlg.Localize;
begin
  inherited;
  Caption := SJPEGDlgCaption;
  
  chkProgressiveEncoding.Caption := SchkProgressiveEncoding;
  lblQuality.Caption := SlblQuality;
end;

procedure TgtJPEGEngineDlg.FormShow(Sender: TObject);
begin
  with TgtJPEGEngine(Engine) do
  begin
    cbPixelFormat.ItemIndex := cbPixelFormat.Items.IndexOfObject(
      TObject(Ord(PixelFormat)));
    chkMonochrome.Checked := Monochrome;

    chkProgressiveEncoding.Checked := ProgressiveEncoding;
    edQuality.Text := IntToStr(Quality);
  end;
  inherited;
end;

procedure TgtJPEGEngineDlg.btnOKClick(Sender: TObject);
begin
  with TgtJPEGEngine(Engine) do
  begin
    PixelFormat := TPixelFormat(cbPixelFormat.Items.Objects[
      cbPixelFormat.ItemIndex]);
    Monochrome := chkMonochrome.Checked;
    
    ProgressiveEncoding := chkProgressiveEncoding.Checked;
    Quality := TJPEGQualityRange(StrToInt(edQuality.Text));
  end;
  inherited;
end;

procedure TgtJPEGEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  {$IFDEF EMailSupport}
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1 ,SQualityScaling);
  {$ELSE}
  lbDocumentDlg.Items.Append(SQualityScaling);
  {$ENDIF}
end;

end.
