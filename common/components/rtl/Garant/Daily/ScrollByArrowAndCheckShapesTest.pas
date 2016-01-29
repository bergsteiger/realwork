unit ScrollByArrowAndCheckShapesTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ScrollByArrowAndCheckShapesTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollByArrowAndCheckShapesTest
//
// Прокрутить стрелкой до определенной позиции и сравнить "картинку".
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  DrawTest
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TDrawTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _ScrollSupport_Parent_ = _CursorMover_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}
 TScrollByArrowAndCheckShapesTest = {abstract} class(_ScrollSupport_)
  {* Прокрутить стрелкой до определенной позиции и сравнить "картинку". }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
     {* Произвести какие-нибудь операции перед отрисовкой. }
   {$IfEnd} //nsTest AND not NoVCM
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function GetScrollCount: Integer; virtual; abstract;
 end;//TScrollByArrowAndCheckShapesTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp,
  l3InternalInterfaces
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nevTools
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\ScrollSupport.imp.pas}

// start class TScrollByArrowAndCheckShapesTest

function TScrollByArrowAndCheckShapesTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollByArrowAndCheckShapesTest.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollByArrowAndCheckShapesTest.DoBeforeDrawing(aForm: TPrimTextLoadForm);
//#UC START# *4CAC45AE011E_4D80B9060123_var*
var
 i : Integer;
//#UC END# *4CAC45AE011E_4D80B9060123_var*
begin
//#UC START# *4CAC45AE011E_4D80B9060123_impl*
 GotoDocumentBottom(aForm);
 for i := 0 to GetScrollCount - 1 do
 begin
  if QFLike then
  // - иначе редактор КЗ это как-то по-своему обрабатывает
  begin
   with aForm.Text do
    if not Selection.Cursor.MostInner.ParentPoint.Move(View, ev_ocParaUp{ev_ocLineUp}, StartOp(ev_msgMove)) then
     break;
  end//QFLike
  else
  begin
   if not Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocLineUp, True, 1) then
    Break;
  end;//QFLike
  Application.ProcessMessages;
 end;//while not Text.View.IsDocumentTailVisible
//#UC END# *4CAC45AE011E_4D80B9060123_impl*
end;//TScrollByArrowAndCheckShapesTest.DoBeforeDrawing
{$IfEnd} //nsTest AND not NoVCM

function TScrollByArrowAndCheckShapesTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D80B9060123';
end;//TScrollByArrowAndCheckShapesTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.