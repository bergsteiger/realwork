unit MouseSelectPtTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/MouseSelectPtTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TMouseSelectPtTest
//
// Тест щелканья мышью по определенной точке.
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
  ,
  evCustomEditorWindow,
  l3Units,
  nevTools,
  nevGUIInterfaces
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _MouseClickOnPoint_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickOnPoint.imp.pas}
 TMouseSelectPtTest = {abstract} class(_MouseClickOnPoint_)
  {* Тест щелканья мышью по определенной точке. }
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
 end;//TMouseSelectPtTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  l3Base
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickOnPoint.imp.pas}

// start class TMouseSelectPtTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TMouseSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D8890B102E6_var*
//#UC END# *4BE419AF0217_4D8890B102E6_var*
begin
//#UC START# *4BE419AF0217_4D8890B102E6_impl*
 ClickOnPoint(aForm.Text, False);
//#UC END# *4BE419AF0217_4D8890B102E6_impl*
end;//TMouseSelectPtTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TMouseSelectPtTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TMouseSelectPtTest.GetFolder

function TMouseSelectPtTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D8890B102E6';
end;//TMouseSelectPtTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.