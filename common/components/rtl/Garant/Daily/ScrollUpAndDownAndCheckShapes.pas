unit ScrollUpAndDownAndCheckShapes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ScrollUpAndDownAndCheckShapes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollUpAndDownAndCheckShapes
//
// Прокрутка вниз, потом вверх и сравнение разультатов.
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
 TScrollUpAndDownAndCheckShapes = {abstract} class(_ScrollSupport_)
  {* Прокрутка вниз, потом вверх и сравнение разультатов. }
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
   function GetScrollCount(aUp: Boolean): Integer; virtual; abstract;
 end;//TScrollUpAndDownAndCheckShapes
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

// start class TScrollUpAndDownAndCheckShapes

function TScrollUpAndDownAndCheckShapes.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollUpAndDownAndCheckShapes.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollUpAndDownAndCheckShapes.DoBeforeDrawing(aForm: TPrimTextLoadForm);
//#UC START# *4CAC45AE011E_4D9AE118015C_var*
var
 l_Count: Integer;
//#UC END# *4CAC45AE011E_4D9AE118015C_var*
begin
//#UC START# *4CAC45AE011E_4D9AE118015C_impl*
 l_Count := GetScrollCount(False);
 ScrollByLine(aForm, l_Count, False, False);
 l_Count := GetScrollCount(True);
 ScrollByLine(aForm, l_Count, True, False);
//#UC END# *4CAC45AE011E_4D9AE118015C_impl*
end;//TScrollUpAndDownAndCheckShapes.DoBeforeDrawing
{$IfEnd} //nsTest AND not NoVCM

function TScrollUpAndDownAndCheckShapes.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D9AE118015C';
end;//TScrollUpAndDownAndCheckShapes.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.