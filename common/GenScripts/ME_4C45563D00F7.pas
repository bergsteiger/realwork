unit ScrollBackByLineTest;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollBackByLineTest = class(TPrimScrollTest)
  {* Прокрутка построчно снизу вверх }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TScrollBackByLineTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
