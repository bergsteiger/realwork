unit D_HLReplace;

{ $Id: D_HLReplace.pas,v 1.1 2007/04/03 08:04:24 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, StdCtrls, vtSpin, Buttons, ExtCtrls;

type
  THLReplaceDlg = class(TBottomBtnDlg)
    lblText: TLabel;
    lblOldDoc: TLabel;
    edtOldDoc: TvtSpinEdit;
    edtNewDoc: TvtSpinEdit;

  end;

 function RequestHLReplaceData(out aOldDocIdValue : Integer;
                               out aNewDocIdValue : Integer;
                               AOwner: TComponent) : Boolean;

implementation

{$R *.DFM}

 function RequestHLReplaceData(out aOldDocIdValue : Integer;
                               out aNewDocIdValue : Integer;
                               AOwner: TComponent) : Boolean;
  begin
   With THLReplaceDlg.Create(AOwner) do
    try
     //edtOldDoc.Value := aOldDocIdValue;
     //edtNewDoc.Value := aNewDocIdValue;
     Result := Execute;
     if Result then
     begin
      aOldDocIdValue := edtOldDoc.AsInteger;
      aNewDocIdValue := edtNewDoc.AsInteger;
     end;
    finally
     Free;
    end;
  end;
end.
