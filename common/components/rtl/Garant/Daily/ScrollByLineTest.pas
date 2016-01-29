unit ScrollByLineTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ScrollByLineTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollByLineTest
//
// Тест прокрутки вниз построчно
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
 TScrollByLineTest = {abstract} class(TTextEditorVisitor)
  {* Тест прокрутки вниз построчно }
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
 end;//TScrollByLineTest
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

// start class TScrollByLineTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollByLineTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4CB6E426014A_var*
//#UC END# *4BE419AF0217_4CB6E426014A_var*
begin
//#UC START# *4BE419AF0217_4CB6E426014A_impl*
 ScrollByLine(aForm, -1, False, False);
//#UC END# *4BE419AF0217_4CB6E426014A_impl*
end;//TScrollByLineTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TScrollByLineTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollByLineTest.GetFolder

function TScrollByLineTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CB6E426014A';
end;//TScrollByLineTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.