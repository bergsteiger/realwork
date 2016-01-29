unit ChangeAllTablesTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , evCustomEditor
 , PrimTextLoad_Form
;

type
 TChangeAllTablesTest = class(TTextViaEditorProcessor)
  {* Работа со всеми таблицами документа. }
  procedure ApplyEditorTool(aEditor: TevCustomEditor);
   {* Вызов инструмента из редактора }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TChangeAllTablesTest
 
implementation

uses
 l3ImplUses
 , evTypes
 , TestFrameWork
;

end.
