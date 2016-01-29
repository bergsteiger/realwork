unit ScrollTest;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollTest = class(TPrimScrollTest)
  {* Тест скроллирования документа }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TScrollTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
