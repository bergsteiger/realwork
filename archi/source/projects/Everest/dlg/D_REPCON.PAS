unit D_RepCon;

{ $Id: D_REPCON.PAS,v 1.5 2003/10/13 15:06:41 law Exp $ }

// $Log: D_REPCON.PAS,v $
// Revision 1.5  2003/10/13 15:06:41  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.4  2001/04/02 11:30:27  law
// - убраны ненужные AutoCreat формы.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

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
  {-}

implementation

{$R *.DFM}

var
  l_ReplaceConfirmDlg: TReplaceConfirmDlg = nil;

function ReplaceConfirmDlg: TReplaceConfirmDlg;
  {-}
begin
 if (l_ReplaceConfirmDlg = nil) then
  l_ReplaceConfirmDlg := TReplaceConfirmDlg.Create(Application);
 Result := l_ReplaceConfirmDlg; 
end;

end.
