unit evExtDlgInsertTable;

{ $Id: evExtDlgInsertTable.pas,v 1.3 2004/11/25 07:37:43 lulin Exp $ }

// $Log: evExtDlgInsertTable.pas,v $
// Revision 1.3  2004/11/25 07:37:43  lulin
// - new unit: TevCustomEditor.
//
// Revision 1.2  2001/09/14 09:40:24  law
// - bug fix: при нажатии Cancel диалоги вызывались по три раза.
//
// Revision 1.1  2001/06/08 09:54:47  law
// - new: добавлены модули для "расширенной" обработки сообщений редактора.
//
// Revision 1.1  2001/06/06 14:59:22  law
// - часть диалогов переехало в Common/Dlg.
//
// Revision 1.5  2001/05/24 14:29:51  law
// - new behavior: подстраиваемся под изменения Вована, относительно PopupWindow.
//
// Revision 1.4  2001/04/09 11:34:13  law
// - cleanup: убрана ссылка на модуль RxSpin.
//
// Revision 1.3  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, vtSpin, evCustomEditor;

type
  TevExtDlgInsertTable = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    ColNumEdit: TvtSpinEdit;
    RowNumEdit: TvtSpinEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Execute(const anEditor: TevCustomEditor): Bool;
  {-}

implementation

{$R *.DFM}

function Execute(const anEditor: TevCustomEditor): Bool;
  {-}
begin
 Result := true;
 with TevExtDlgInsertTable.Create(Application.MainForm) do
  try
   if (ShowModal = mrOk) then 
    anEditor.InsertTable(ColNumEdit.AsInteger, RowNumEdit.AsInteger);
  finally
   Free;
  end;//try..finally
end;

end.
