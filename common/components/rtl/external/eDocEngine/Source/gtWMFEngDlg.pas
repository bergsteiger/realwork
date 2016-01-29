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

unit gtWMFEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, ExtCtrls, StdCtrls, ComCtrls,
  gtGfxDlg, gtDocResStrs;

type
  TgtWMFEngineDlg = class(TgtGraphicsDlg)
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

{ TgtWMFEngineDlg }

procedure TgtWMFEngineDlg.Localize;
begin
  inherited;
  Caption := SWMFDlgCaption;
end;

procedure TgtWMFEngineDlg.FormCreate(Sender: TObject);
begin
  inherited;
  tsQualityAndScaling.TabVisible := False;
end;

end.
