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

unit gtSLKEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtSpdDlg, gtDocResStrs;

type
  TgtSYLKEngineDlg = class(TgtSpreadSheetDlg)
    procedure FormCreate(Sender: TObject);
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

{ TgtSYLKEngineDlg }

procedure TgtSYLKEngineDlg.Localize;
begin
  inherited;
  Caption := SSLKDlgCaption;
end;

procedure TgtSYLKEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SContent));
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SBackground));
  //tsFormatting.PageIndex := tsFormatting.PageIndex - 2;
end;

end.
