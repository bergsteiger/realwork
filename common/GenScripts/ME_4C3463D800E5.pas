unit Translate2TextTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TTranslate2TextTest = class(TTableToolsTest)
  {* Преобразовать таблицу или её часть в текст }
  procedure ApplyTools(const aRange: IedRange);
   {* Вызвать инструмент для таблицы }
 end;//TTranslate2TextTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
