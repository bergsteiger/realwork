unit MergeAndCheck;

interface

uses
 l3IntfUses
 , DrawTestPrim
 , PrimTextLoad_Form
;

type
 TMergeAndCheck = class(TDrawTestPrim)
  {* Тест объединения ячеек и сравнения отрисованного }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* Произвести какие-нибудь операции перед отрисовкой. }
 end;//TMergeAndCheck
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evOp
 , evCursorTools
;

end.
