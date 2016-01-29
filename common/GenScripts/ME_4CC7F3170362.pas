unit DrawTest;

interface

uses
 l3IntfUses
 , DrawTestPrim
 , PrimTextLoad_Form
;

type
 TDrawTest = class(TDrawTestPrim, TDrawTestPrim)
  {* “ест вида: нарисовали и сравнили с эталоном. }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* ѕроизвести какие-нибудь операции перед отрисовкой. }
 end;//TDrawTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
