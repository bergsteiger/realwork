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

unit gtImgPrvwDlg;

interface

uses
	Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, ComCtrls, ExtCtrls;

type

{ TgtImgPrvwDlg class }

	TgtImgPrvwDlg = class(TForm)
		pnlBgImgPrvw: TPanel;
		imgBgImgPrvw: TImage;

		procedure FormCreate(Sender: TObject);

	protected
		procedure Localize;

	end;

implementation

uses gtDocResStrs;

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TgtImgPrvwDlg }
{------------------------------------------------------------------------------}

procedure TgtImgPrvwDlg.FormCreate(Sender: TObject);
begin
	Localize;
end;

{------------------------------------------------------------------------------}

procedure TgtImgPrvwDlg.Localize;
begin
// Set Form caption.
	Caption := SImgPrvwDlgCaption;
end;

{------------------------------------------------------------------------------}

end.
