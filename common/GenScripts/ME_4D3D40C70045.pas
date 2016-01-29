unit MouseMoveSelectionTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TMouseMoveSelectionTest = class(TTextViaEditorProcessor)
  {* Выделение с помощью движения мыши. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TMouseMoveSelectionTest
 
implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
;

end.
