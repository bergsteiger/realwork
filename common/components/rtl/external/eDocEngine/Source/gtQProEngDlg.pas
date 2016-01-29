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

unit gtQProEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtSpdDlg, gtQProEng, gtDocResStrs;

type
  TgtQuattroProEngineDlg = class(TgtSpreadSheetDlg)
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

implementation

uses gtDocDlg;

{$R *.dfm}

{ TgtQuattroProEngineDlg }

procedure TgtQuattroProEngineDlg.Localize;
begin
  inherited;
  Caption := SQProDlgCaption;
end;

procedure TgtQuattroProEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SContent));
  //tsBackground.TabVisible := True;
  lblBackgroundImage.Enabled := False;
  pnlBackgroundImage.Enabled := False;
  btnSelectImage.Enabled := False;
  btnImgPrvw.Enabled := False;
  btnClear.Enabled := False;
  lblBackgroundDisplayType.Enabled := False;
  cbBackgroundDisplayType.Enabled := False;
end;

procedure TgtQuattroProEngineDlg.FormShow(Sender: TObject);
begin
  inherited;
  with TgtQuattroProEngine(Engine) do
    shpBackgroundColor.Brush.Color := BackgroundColor;
end;

procedure TgtQuattroProEngineDlg.btnOKClick(Sender: TObject);
begin
  inherited;
  with TgtQuattroProEngine(Engine) do
    BackgroundColor := shpBackgroundColor.Brush.Color;
end;

end.
 