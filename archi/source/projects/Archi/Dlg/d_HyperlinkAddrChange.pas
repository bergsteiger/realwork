unit d_HyperlinkAddrChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls;

type
  TChangeHLAddrDlg = class(TBottomBtnDlg)
    lblAddrFrom: TLabel;
    edtAddrFrom: TEdit;
    edtAddrTo: TEdit;
    lblAddrTo: TLabel;
    procedure edtAddrFromChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
   { Private declarations }
   procedure CheckAddrValidity;
  public
    { Public declarations }
  end;

var
  ChangeHLAddrDlg: TChangeHLAddrDlg;

implementation
uses
 AddrSup;

{$R *.dfm}

{ TChangeHLAddrDlg }

procedure TChangeHLAddrDlg.CheckAddrValidity;
var
 l_AddrFromValid: Boolean;
 l_AddrToValid: Boolean;
begin
 l_AddrFromValid := IsValidAddressStr(edtAddrFrom.Text);
 l_AddrToValid   := IsValidAddressStr(edtAddrTo.Text);
 OK.Enabled := l_AddrFromValid and l_AddrToValid;
end;

procedure TChangeHLAddrDlg.edtAddrFromChange(Sender: TObject);
begin
 CheckAddrValidity;
end;

procedure TChangeHLAddrDlg.FormShow(Sender: TObject);
begin
 inherited;
 CheckAddrValidity;
end;

end.
