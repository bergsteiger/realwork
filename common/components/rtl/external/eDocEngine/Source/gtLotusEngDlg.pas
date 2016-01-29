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

unit gtLotusEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtSpdDlg, gtDocResStrs;

type
  TgtLotusEngineDlg = class(TgtSpreadSheetDlg)
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

{ TgtLotusEngineDlg }

procedure TgtLotusEngineDlg.Localize;
begin
  inherited;
  Caption := SLotusDlgCaption;
end;

procedure TgtLotusEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SContent));
  lbDocumentDlg.Items.Delete(lbDocumentDlg.Items.IndexOf(SBackground));
  //tsFormatting.PageIndex := tsFormatting.PageIndex - 2;
end;

end.
