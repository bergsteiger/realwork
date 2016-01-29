unit d_ReplCorresp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  d_AddrEdit, vtSpin, StdCtrls, Buttons, ExtCtrls;

type
  TReplaceCorrespDlg = class(TAddressEditDlg)
    rbSelectedSubs: TRadioButton;
    rbOneSub: TRadioButton;
    edtSubNumber: TvtSpinEdit;
    procedure rbOneSubClick(Sender: TObject);
    procedure rbSelectedSubsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function RequestReplaceCorrespData(var AHandleSub : Integer; var aDocID, aSubID : Integer; AOwner: TComponent) : Boolean;
//  AHandleSub = -1 - для выделенных
implementation

{$R *.dfm}

uses
 AddrSup;

function RequestReplaceCorrespData(var aHandleSub : Integer;
                                   var aDocID, aSubID : Integer;
                                   AOwner: TComponent) : Boolean;
begin
 With TReplaceCorrespDlg.Create(AOwner) do
 try
  //Caption := aCaption;
  //LabelText := aLabel;

  AddressStr := DocAddrToStr(aDocID, aSubID);

  Result := Execute;

  if Result then
  begin
   StrToDocAddr(AddressStr, aDocID, aSubID);
   if rbSelectedSubs.Checked then
    aHandleSub := -1
   else
    aHandleSub := edtSubNumber.AsInteger;
  end;
 finally
  Free;
 end;
end;

procedure TReplaceCorrespDlg.rbOneSubClick(Sender: TObject);
begin
 inherited;
 edtSubNumber.Enabled := True;
 ActiveControl := edtSubNumber;
end;

procedure TReplaceCorrespDlg.rbSelectedSubsClick(Sender: TObject);
begin
 inherited;
 edtSubNumber.Enabled := False;
end;

end.
 