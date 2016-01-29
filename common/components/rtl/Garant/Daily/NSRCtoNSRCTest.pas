unit NSRCtoNSRCTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/NSRCtoNSRCTest.pas"
// Начат: 19.11.2010 16:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::NSRCtoNSRCTest
//
// Тест преобразования NSRC в NSRC
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
 TNSRCtoNSRCTest = {abstract} class(TNSRCWriterTest)
  {* Тест преобразования NSRC в NSRC }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function IsPlus: Boolean; virtual;
     {* NSRC+? }
 published
 // published methods
   procedure DoIt;
 end;//TNSRCtoNSRCTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TNSRCtoNSRCTest

procedure TNSRCtoNSRCTest.DoIt;
//#UC START# *4CE67DDC011B_4CE67D90013B_var*
//#UC END# *4CE67DDC011B_4CE67D90013B_var*
begin
//#UC START# *4CE67DDC011B_4CE67D90013B_impl*
 NSRCtoNSRC(KPage + '.nsr', IsPlus);
//#UC END# *4CE67DDC011B_4CE67D90013B_impl*
end;//TNSRCtoNSRCTest.DoIt

function TNSRCtoNSRCTest.IsPlus: Boolean;
//#UC START# *4CE67DED0192_4CE67D90013B_var*
//#UC END# *4CE67DED0192_4CE67D90013B_var*
begin
//#UC START# *4CE67DED0192_4CE67D90013B_impl*
 Result := true;
//#UC END# *4CE67DED0192_4CE67D90013B_impl*
end;//TNSRCtoNSRCTest.IsPlus

function TNSRCtoNSRCTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TNSRCtoNSRCTest.GetFolder

function TNSRCtoNSRCTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CE67D90013B';
end;//TNSRCtoNSRCTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.