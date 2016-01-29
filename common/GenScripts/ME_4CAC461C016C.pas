unit DeleteSectionBreakTest;

interface

uses
 l3IntfUses
 , DrawTestPrim
 , PrimTextLoad_Form
;

type
 TDeleteSectionBreakTest = class(TDrawTestPrim)
  {* “ест на удаление раздела. }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* ѕроизвести какие-нибудь операции перед отрисовкой. }
 end;//TDeleteSectionBreakTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , TestFrameWork
;

end.
