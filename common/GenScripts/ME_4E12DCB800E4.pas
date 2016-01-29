unit RowSelectionTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TRowSelectionTest = class(TTextViaEditorProcessor)
  {* Тест выделения строки. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TRowSelectionTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , nevTools
;

end.
