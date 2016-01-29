unit ScrollAndLinesTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/ScrollAndLinesTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TScrollAndLinesTest
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
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  LinesTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TScrollAndLinesTest = {abstract} class(TLinesTest)
 private
 // private methods
   procedure DoScroll(aForm: TPrimTextLoadForm);
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function GetScrollCount: Integer; virtual; abstract;
 end;//TScrollAndLinesTest
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

// start class TScrollAndLinesTest

procedure TScrollAndLinesTest.DoScroll(aForm: TPrimTextLoadForm);
//#UC START# *4E54DE74026A_4E54DE280369_var*
//#UC END# *4E54DE74026A_4E54DE280369_var*
begin
//#UC START# *4E54DE74026A_4E54DE280369_impl*
 ScrollByWeel(aForm, GetScrollCount);
//#UC END# *4E54DE74026A_4E54DE280369_impl*
end;//TScrollAndLinesTest.DoScroll

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollAndLinesTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4E54DE280369_var*
//#UC END# *4BE419AF0217_4E54DE280369_var*
begin
//#UC START# *4BE419AF0217_4E54DE280369_impl*
 DoScroll(aForm);
 inherited DoVisit(aForm);
//#UC END# *4BE419AF0217_4E54DE280369_impl*
end;//TScrollAndLinesTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TScrollAndLinesTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollAndLinesTest.GetFolder

function TScrollAndLinesTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E54DE280369';
end;//TScrollAndLinesTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.