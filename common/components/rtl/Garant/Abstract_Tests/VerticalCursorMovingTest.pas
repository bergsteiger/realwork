unit VerticalCursorMovingTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/VerticalCursorMovingTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TVerticalCursorMovingTest
//
// Тест вертикального перемещения курсора.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextEditorVisitor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TVerticalCursorMovingTest = {abstract} class(_CursorMover_)
  {* Тест вертикального перемещения курсора. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TVerticalCursorMovingTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevBase,
  TestFrameWork,
  evMsgCode,
  evOp
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

// start class TVerticalCursorMovingTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TVerticalCursorMovingTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D79E1800396_var*
var
 l_Op : InevOp;
//#UC END# *4BE419AF0217_4D79E1800396_var*
begin
//#UC START# *4BE419AF0217_4D79E1800396_impl*
 l_Op := aForm.Text.StartOp;
 try
  aForm.Text.Selection.Cursor.MostInner.SetEntryPoint(10, l_Op);
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown, l_Op);
 finally
  l_Op := nil;
 end;
 Check(aForm.Text.Selection.Cursor.MostInner.Position = 10);
//#UC END# *4BE419AF0217_4D79E1800396_impl*
end;//TVerticalCursorMovingTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TVerticalCursorMovingTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TVerticalCursorMovingTest.GetFolder

function TVerticalCursorMovingTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D79E1800396';
end;//TVerticalCursorMovingTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.