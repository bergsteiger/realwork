unit TableToolsTestPrim;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , evEditorInterfaces
 , PrimTextLoad_Form
;

type
 TTableToolsTestPrim = class(TTextViaEditorProcessor)
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
  procedure CheckOperation(aForm: TPrimTextLoadForm);
   {* Проверка после применения инструмента. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TTableToolsTestPrim
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
