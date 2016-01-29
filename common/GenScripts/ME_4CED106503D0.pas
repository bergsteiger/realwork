unit HotSpotSelectionTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 THotSpotSelectionTest = class(TTextViaEditorProcessor)
  {* Тест выделения с помощью хотспота. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//THotSpotSelectionTest
 
implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , Types
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , nevTools
;

end.
