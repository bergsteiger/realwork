unit ScrollParamsTest;

interface

uses
 l3IntfUses
 , ScrollerParamsTestPrim
 , PrimTextLoad_Form
 , Types
;

type
 TScrollParamsTest = class(TScrollerParamsTestPrim)
  {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }
  function GetSubNumber: Integer;
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TScrollParamsTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
