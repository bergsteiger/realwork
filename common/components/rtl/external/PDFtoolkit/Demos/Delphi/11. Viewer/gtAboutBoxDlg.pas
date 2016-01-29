
{******************************************************************************}
{                                                                              }
{  Gnostice PDFtoolkit Demo                                                    }
{                                                                              }
{  Copyright © 2002-2004 Gnostice Information Technologies Private Limited     }
{  http://www.gnostice.com                                                     }
{                                                                              }
{******************************************************************************}

unit gtAboutBoxDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ShellAPI, jpeg;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Label2: TLabel;
    lblGnostice: TLabel;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    procedure lblGnosticeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

procedure TAboutBox.lblGnosticeClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'Open', 'http://www.gnostice.com', nil, nil, SW_SHOWNORMAL);
end;

end.




