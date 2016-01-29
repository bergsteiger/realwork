unit SuccessTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestForTFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/TestForTFW/SuccessTest.pas"
// Начат: 27.09.2010 19:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::TestForTFW::TFWTests::TSuccessTest
//
// Успешный тест
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
 TSuccessTest = class(TBaseTest)
  {* Успешный тест }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TSuccessTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TSuccessTest

procedure TSuccessTest.DoIt;
//#UC START# *4CA0B2AC0096_4CA0B27401E4_var*
//#UC END# *4CA0B2AC0096_4CA0B27401E4_var*
begin
//#UC START# *4CA0B2AC0096_4CA0B27401E4_impl*
 Check(true);
//#UC END# *4CA0B2AC0096_4CA0B27401E4_impl*
end;//TSuccessTest.DoIt

function TSuccessTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TFWTests';
end;//TSuccessTest.GetFolder

function TSuccessTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CA0B27401E4';
end;//TSuccessTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TSuccessTest.Suite);

end.