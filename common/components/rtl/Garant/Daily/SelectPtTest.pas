unit SelectPtTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/SelectPtTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TSelectPtTest
//
// Тест вида - загрузили и ткнули в точку со смещением относительно какого-нибудь параграфа
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
  ,
  l3Units,
  nevTools,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _Para2Point_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}
 TSelectPtTest = {abstract} class(_Para2Point_)
  {* Тест вида - загрузили и ткнули в точку со смещением относительно какого-нибудь параграфа }
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
 end;//TSelectPtTest
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas}

// start class TSelectPtTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4BF4E6650245_var*
//#UC END# *4BE419AF0217_4BF4E6650245_var*
begin
//#UC START# *4BE419AF0217_4BF4E6650245_impl*
 {$R+}
 aForm.Text.View.Control.Selection.SelectPt(TranslatePara2Point(aForm.Text), True);
 {$R-}
//#UC END# *4BE419AF0217_4BF4E6650245_impl*
end;//TSelectPtTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TSelectPtTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TSelectPtTest.GetFolder

function TSelectPtTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BF4E6650245';
end;//TSelectPtTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.