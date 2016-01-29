unit BtnDlg;

{ $Id: BtnDlg.pas,v 1.7 2010/07/23 10:29:35 voba Exp $ }

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
  protected
    function DefaultCloseAction : TCloseAction; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.DFM}

constructor TBtnDlg.Create(AOwner: TComponent);
begin
 Inherited;
 If BorderStyle = bsSizeable then
  with Constraints do
  begin
   if MinHeight = 0 then MinHeight := Height;
   if MinWidth = 0 then MinWidth := Width;
  end;
end;

procedure TBtnDlg.HelpClick(Sender: TObject);
begin
 Application.HelpContext(HelpContext);
end;

function TBtnDlg.DefaultCloseAction : TCloseAction;
begin
 Result := caHide;
end;

end.

