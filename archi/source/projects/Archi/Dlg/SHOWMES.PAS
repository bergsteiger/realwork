unit ShowMes;

{ $Id: SHOWMES.PAS,v 1.10 2010/07/21 10:38:44 voba Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, OvcBase, evEditorWindow, evEditor, evMemo, ExtCtrls, 
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations,
  afwControlPrim, afwBaseControl, afwControl, nevControl, evCustomMemo;

type
  TShowLongMessageDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OKBtn: TBitBtn;
    evMemo1: TevMemo;
  private
    Procedure SetText(Value : PChar);
  public
    Property Text : PChar Write SetText;
    Procedure ShowMessage;
    Procedure AppendText(Value : PChar);
  end;

implementation

{$R *.DFM}

Uses l3Chars,
     l3String,
     evOp;

  Procedure TShowLongMessageDlg.SetText(Value : PChar);
   Begin
    evMemo1.Buffer:=l3PCharLen(Value);
   end;

  Procedure TShowLongMessageDlg.AppendText(Value : PChar);
   Begin
    With evMemo1 do
     Begin
      MoveLeafCursor(ev_ocBottomRight);
      InsertBuf(cc_EOLStr);
      InsertBuf(l3PCharLen(Value));
     end;
   end;

  Procedure TShowLongMessageDlg.ShowMessage;
   Begin
    ShowModal;
   end;

 end.
