unit SelectColumnAndDelete;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
 , PrimTextLoad_Form
;

type
 TSelectColumnAndDelete = class(TTableToolsTest)
  {* Тест выделения и удаления колонки. }
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//TSelectColumnAndDelete
 
implementation

uses
 l3ImplUses
 , nevTools
 , TestFrameWork
;

end.
