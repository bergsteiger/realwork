unit BtnDlg;

{ $Id: BtnDlg.pas,v 1.1 2003/07/30 10:08:31 narry Exp $ }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, vtForm;

type
  TBtnDlg = class(TvtForm)
    ButtonPanel: TPanel;
    OK: TBitBtn;
    Cancel: TBitBtn;
    Help: TBitBtn;
    procedure HelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TBtnDlg.HelpClick(Sender: TObject);
begin
 Application.HelpContext(HelpContext);
end;

end.
 
