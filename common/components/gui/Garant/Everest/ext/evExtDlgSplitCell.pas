unit evExtDlgSplitCell;

{ $Id: evExtDlgSplitCell.pas,v 1.2 2001/09/14 09:40:24 law Exp $ }

// $Log: evExtDlgSplitCell.pas,v $
// Revision 1.2  2001/09/14 09:40:24  law
// - bug fix: при нажатии Cancel диалоги вызывались по три раза.
//
// Revision 1.1  2001/06/08 09:54:47  law
// - new: добавлены модули для "расширенной" обработки сообщений редактора.
//
// Revision 1.1  2001/06/06 14:59:23  law
// - часть диалогов переехало в Common/Dlg.
//
// Revision 1.1  2001/06/06 11:26:46  law
// - сделано разделение ячеек по горизонтали.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, vtSpin, Buttons, ExtCtrls, evEditorInterfaces, evExtDlgInsertTable;

type
  TevExtDlgSplitCell = class(TevExtDlgInsertTable)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function Execute(const aRange: IedRange): Bool;
  {-}

implementation

{$R *.DFM}

function Execute(const aRange: IedRange): Bool;
  {-}
var
 l_Table : IedTable;
 l_Cell  : IedCell;
begin
 Result := true;
 if (aRange <> nil) then begin
  l_Table := aRange.Table;
  if (l_Table <> nil) then begin
   l_Cell := l_Table.Cell;
   if (l_Cell <> nil) then
    with TevExtDlgSplitCell.Create(Application.MainForm) do
     try
      if (ShowModal = mrOk) then 
       l_Cell.Split(ColNumEdit.AsInteger, RowNumEdit.AsInteger);
     finally
      Free;
     end;//try..finally
  end;//l_Table <> nil
 end;//aRange <> nil
end;

end.
