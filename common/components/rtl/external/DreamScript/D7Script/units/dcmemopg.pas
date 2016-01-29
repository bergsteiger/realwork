{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcMemoPg;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ComCtrls, ExtCtrls, Consts, dcConsts;

type
  TMemoPrintProgress = class(TForm)
    btnCancel: TButton;
    pnlInfo: TPanel;
    lblPrinter: TLabel;
    lblProgress: TLabel;
    lblFileName: TLabel;
    ProgressBar: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MemoPrintProgress: TMemoPrintProgress;

implementation

{$R *.DFM}

procedure TMemoPrintProgress.FormCreate(Sender: TObject);
begin
  if Assigned(Application.MainForm) then
    Font := Application.MainForm.Font;
  Caption:=SPrintStatus;
  lblPrinter.Caption:=SSearchPrinters;
  lblProgress.Caption:=SPrintProgress;
  btnCancel.Caption:=SCancelButton;
end;

end.
