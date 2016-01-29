unit ScrollAndSelectPtTest;

interface

uses
 l3IntfUses
 , SelectPtTest
 , nevTools
 , PrimTextLoad_Form
;

type
 TScrollAndSelectPtTest = class(TSelectPtTest)
  {* тесты вида - загрузили, прокрутили и ткнули }
  function NeedScrollUp: Boolean;
  function NeedScrollByLine: Boolean;
  function GetScrollCount: Integer;
  procedure CheckAfterScroll(const aView: InevInputView);
   {* Операции после прокрутки }
 end;//TScrollAndSelectPtTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
