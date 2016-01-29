unit CheckTopAnchorTest;

interface

uses
 l3IntfUses
 , ScrollAndSelectPtTest
 , nevTools
 , PrimTextLoad_Form
;

type
 TCheckTopAnchorTest = class(TScrollAndSelectPtTest)
  {* Тест для выбора точки после прокрутки и проверки изменился ли TopAnchor }
 end;//TCheckTopAnchorTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
