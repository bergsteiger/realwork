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

unit gtEMFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtGfxDlg, gtDocResStrs;

type
  TgtEMFEngineDlg = class(TgtGraphicsDlg)
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

procedure TgtEMFEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  tsQualityAndScaling.TabVisible := False;
end;

procedure TgtEMFEngineDlg.Localize;
begin
  inherited;
  Caption := SEMFDlgCaption;
end;

end.
