unit d_AddrEdit;
{see also D_DocAddr}

{ $Id: d_AddrEdit.pas,v 1.1 2004/03/02 14:42:41 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vtSpin, Buttons, ExtCtrls, BottomBtnDlg;

type
  TAddressEditDlg = class(TBottomBtnDlg)
    edtAddress: TEdit;
    lblText: TLabel;
    procedure OKClick(Sender: TObject);
  private
   procedure SetLabelText(aValue : String);
   procedure SetAddressText(aValue : String);
   function  GetAddressText : String;
  public
    property LabelText : string write SetLabelText;
    property AddressStr : string read GetAddressText write SetAddressText;
  end;

function RequestDocAddress(var aDocID, aSubID : Integer; AOwner: TComponent;
                               aCaption : String = ''; aLabel : String = '') : Boolean;

implementation

{$R *.DFM}

uses
 AddrSup;

procedure TAddressEditDlg.SetLabelText(aValue : String);
begin
 lblText.Caption := aValue;
end;

procedure TAddressEditDlg.SetAddressText(aValue : String);
begin
 edtAddress.Text := aValue;
end;

function  TAddressEditDlg.GetAddressText : String;
begin
 Result := edtAddress.Text;
end;

function RequestDocAddress(var aDocID, aSubID : Integer; AOwner: TComponent;
                               aCaption : String = ''; aLabel : String = '') : Boolean;
begin
 With TAddressEditDlg.Create(AOwner) do
 try
  Caption := aCaption;
  LabelText := aLabel;

  AddressStr := DocAddrToStr(aDocID, aSubID);

  Result := Execute;

  if Result then
   StrToDocAddr(AddressStr, aDocID, aSubID);
 finally
  Free;
 end;
end;

procedure TAddressEditDlg.OKClick(Sender: TObject);
var
 aDocID, aSubID : Integer;
begin
 if not StrToDocAddr(AddressStr, aDocID, aSubID)
    or (aDocID <= 0) then
 begin
  ModalResult := mrNone;
  ACtiveControl := edtAddress;
 end;

end;

end.
