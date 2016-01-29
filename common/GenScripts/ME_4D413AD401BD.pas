unit SelectionCellTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TSelectionCellTest = class(TTextViaEditorProcessor)
  {* Тест на выделение ячейки. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TSelectionCellTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3Base
 , l3InternalInterfaces
 , evTypes
;

end.
