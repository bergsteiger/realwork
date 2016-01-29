unit ColumnResizeByMousePrimTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TColumnResizeByMousePrimTest = class(TTextViaEditorProcessor)
  {* Тест изменения колонок с помощью мыши }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TColumnResizeByMousePrimTest
 
implementation

uses
 l3ImplUses
 , evConst
 , TestFrameWork
 , nevTools
 , l3Base
;

end.
