unit kwPopEditorPrintTableCellsParams;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorPrintTableCellsParams = class(TkwEditorFromStackWord)
  {* *‘ормат:* anEditorControl pop:editor:PrintTableCellsParams
*ќписание:* ѕечатает структуру информацию €чеек таблицы: тип объединени€, если объединенна€, то номер €чейки в строке сверху, номер €чейки в строке снизу и номер начальной €чейки/номер строки, где эта €чейка. –езультат выводитс€ в обычный файл вывода результатов.
*ѕример:*
[code] 
focused:control:push pop:editor:PrintTableCellsParams
[code] }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorPrintTableCellsParams
 
implementation

uses
 l3ImplUses
 , nevBase
 , nevFormatInfoUtils
 , l3Base
 , SysUtils
 , nevFacade
;

end.
