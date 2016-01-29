unit d_AttrCopyEdit;

{ $Id: d_AttrCopyEdit.pas,v 1.1 2007/01/22 07:59:08 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, vtSpin, Buttons, ExtCtrls;

type
 TAttrCopyEditDlg = class(TBottomBtnDlg)
   edtDonorDocID: TvtSpinEdit;
   edtAcceptorDocID: TvtSpinEdit;
   Label1: TLabel;
   Label2: TLabel;
 end;

function RequestAttrCopyData(var aDonorDocID, aAcceptorDocID : Integer;
                             AOwner: TComponent;
                             aCaption : String = '') : Boolean;

implementation

{$R *.DFM}

function RequestAttrCopyData(var aDonorDocID, aAcceptorDocID : Integer;
                             AOwner: TComponent;
                             aCaption : String = '') : Boolean;
begin
 With TAttrCopyEditDlg.Create(AOwner) do
 try
  Caption := aCaption;
  edtDonorDocID.Value := aDonorDocID;
  edtAcceptorDocID.Value := aAcceptorDocID;

  Result := Execute;
  if not Result then Exit;

  aDonorDocID :=  edtDonorDocID.AsInteger;
  aAcceptorDocID := edtAcceptorDocID.AsInteger;
 finally
  Free;
 end;
end;

end.
