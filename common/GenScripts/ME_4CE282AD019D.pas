unit ScrollByArrow;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollByArrow = class(TPrimScrollTest)
  {* Прокрутка документа стрелкой на клавиатуре. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TScrollByArrow
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 , Forms
;

end.
