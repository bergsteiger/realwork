unit D_RepCon;

{ $Id: D_REPCON.PAS,v 1.4 2003/11/06 09:09:43 voba Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, OvcBase, evEditorWindow, evEditor, evMemo, evTypes;

type
  TReplaceConfirmDlg = class(TForm)
    btYes: TBitBtn;
    btNo: TBitBtn;
    btHelp: TBitBtn;
    lbQuestion: TLabel;
    btCancel: TBitBtn;
    btAll: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ReplaceConfirmDlg: TReplaceConfirmDlg;

implementation
 const
  lReplaceConfirmDlg: TReplaceConfirmDlg = nil;

 function ReplaceConfirmDlg: TReplaceConfirmDlg;
  begin
   If lReplaceConfirmDlg = nil
    then Application.CreateForm(TReplaceConfirmDlg, lReplaceConfirmDlg);
   Result := lReplaceConfirmDlg;
  end;

{$R *.DFM}
//finalization
// lReplaceConfirmDlg.Free;
end.
