unit NSRCtoEVDTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/NSRCtoEVDTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::NSRCtoEVDTest
//
// Тест преобразования NSRC в EVD
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
  NSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TNSRCtoEVDTest = {abstract} class(TNSRCWriterTest)
  {* Тест преобразования NSRC в EVD }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TNSRCtoEVDTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TNSRCtoEVDTest

procedure TNSRCtoEVDTest.DoIt;
//#UC START# *4BED4080012C_4BED405E0256_var*
//#UC END# *4BED4080012C_4BED405E0256_var*
begin
//#UC START# *4BED4080012C_4BED405E0256_impl*
 NSRCtoEVD(KPage + '.nsr');
//#UC END# *4BED4080012C_4BED405E0256_impl*
end;//TNSRCtoEVDTest.DoIt

function TNSRCtoEVDTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TNSRCtoEVDTest.GetFolder

function TNSRCtoEVDTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BED405E0256';
end;//TNSRCtoEVDTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.