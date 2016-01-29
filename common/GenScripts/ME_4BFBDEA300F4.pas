unit ScrollBackTest;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollBackTest = class(TPrimScrollTest)
  {* Тест скроллирования документа в обратную сторону }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TScrollBackTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
