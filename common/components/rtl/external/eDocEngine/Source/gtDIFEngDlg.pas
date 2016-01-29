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

unit gtDIFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtSpdDlg, gtDocResStrs;

type
  TgtDIFEngineDlg = class(TgtSpreadSheetDlg)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure Localize; override;
    
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TgtDIFEngineDlg }

procedure TgtDIFEngineDlg.Localize;
begin
  inherited;
  Caption := SDIFDlgCaption;
end;

procedure TgtDIFEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SContent));
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SBackground));
end;

end.
