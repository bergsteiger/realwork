unit ScrollAndCheckCursorTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ScrollAndCheckCursorTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollAndCheckCursorTest
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
 TScrollAndCheckCursorTest = {abstract} class(TTextEditorVisitor)
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
   {$If defined(nsTest) AND not defined(NoVCM)}
   function F1Like: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollAndCheckCursorTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
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

// start class TScrollAndCheckCursorTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollAndCheckCursorTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D6B85E6037B_var*
var
 i : Integer;
//#UC END# *4BE419AF0217_4D6B85E6037B_var*
begin
//#UC START# *4BE419AF0217_4D6B85E6037B_impl*
 for i := 0 to 1 do
  PageDown(aForm);
 aForm.Text.GotoTop;
 Check(aForm.Text.Selection.Cursor.AtStart);
//#UC END# *4BE419AF0217_4D6B85E6037B_impl*
end;//TScrollAndCheckCursorTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TScrollAndCheckCursorTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollAndCheckCursorTest.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
function TScrollAndCheckCursorTest.F1Like: Boolean;
//#UC START# *4C9B31F6015E_4D6B85E6037B_var*
//#UC END# *4C9B31F6015E_4D6B85E6037B_var*
begin
//#UC START# *4C9B31F6015E_4D6B85E6037B_impl*
 Result := True;
//#UC END# *4C9B31F6015E_4D6B85E6037B_impl*
end;//TScrollAndCheckCursorTest.F1Like
{$IfEnd} //nsTest AND not NoVCM

function TScrollAndCheckCursorTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D6B85E6037B';
end;//TScrollAndCheckCursorTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.