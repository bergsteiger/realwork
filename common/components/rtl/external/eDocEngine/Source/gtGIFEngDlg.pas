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
unit gtGIFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtGfxDlg, gtDocResStrs, gtGIFEng;

type
  TgtGIFEngineDlg = class(TgtGraphicsDlg)
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

{ TgtGIFEngineDlg }

procedure TgtGIFEngineDlg.Localize;
begin
  inherited;
  Caption := SGIFDlgCaption;
end;

procedure TgtGIFEngineDlg.FormShow(Sender: TObject);
begin
  with TgtGIFEngine(Engine) do
  begin
    cbPixelFormat.ItemIndex := cbPixelFormat.Items.IndexOfObject(
      TObject(Ord(PixelFormat)));
    chkMonochrome.Checked := Monochrome;
  end;
  inherited;
end;

procedure TgtGIFEngineDlg.btnOKClick(Sender: TObject);
begin
  with TgtGIFEngine(Engine) do
  begin
    PixelFormat := TPixelFormat(cbPixelFormat.Items.Objects[
      cbPixelFormat.ItemIndex]);
    Monochrome := chkMonochrome.Checked;                               
  end;
  inherited;
end;

procedure TgtGIFEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  {$IFDEF EMailSupport}
  lbDocumentDlg.Items.Insert(lbDocumentDlg.Items.Count - 1 ,SQualityScaling);
  {$ELSE}
  lbDocumentDlg.Items.Append(SQualityScaling);
  {$ENDIF}
end;

end.
