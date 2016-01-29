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

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtXHTMLEngDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  gtHTMLEngDlg, gtDocResStrs;

type

  TgtXHTMLEngineDlg = class(TgtHTMLEngineDlg)
  private
    { Private declarations }

  protected
		procedure Localize; override;
        
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TgtXHTMLEngineDlg }

procedure TgtXHTMLEngineDlg.Localize;
begin
  inherited;
  Caption := SXHTMLDlgCaption;
end;

end.
