unit FailedTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestForTFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/TestForTFW/FailedTest.pas"
// Начат: 27.09.2010 19:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::TestForTFW::TFWTests::TFailedTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TFailedTest = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TFailedTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TFailedTest

procedure TFailedTest.DoIt;
//#UC START# *4CA0B2E40378_4CA0B2BA01AC_var*
//#UC END# *4CA0B2E40378_4CA0B2BA01AC_var*
begin
//#UC START# *4CA0B2E40378_4CA0B2BA01AC_impl*
 Check(false);
//#UC END# *4CA0B2E40378_4CA0B2BA01AC_impl*
end;//TFailedTest.DoIt

function TFailedTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TFWTests';
end;//TFailedTest.GetFolder

function TFailedTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CA0B2BA01AC';
end;//TFailedTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TFailedTest.Suite);

end.