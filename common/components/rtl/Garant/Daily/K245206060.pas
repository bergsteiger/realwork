unit K245206060;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K245206060.pas"
// Начат: 06.12.2010 12:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRC 7.6::K245206060
//
// {RequestLink:245206060}
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
  NSRCtoNSRCTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK245206060 = class(TNSRCtoNSRCTest)
  {* [RequestLink:245206060] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function IsPlus: Boolean; override;
     {* NSRC+? }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK245206060
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK245206060

function TK245206060.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRC 7.6';
end;//TK245206060.GetFolder

function TK245206060.IsPlus: Boolean;
//#UC START# *4CE67DED0192_4CFCACFE0085_var*
//#UC END# *4CE67DED0192_4CFCACFE0085_var*
begin
//#UC START# *4CE67DED0192_4CFCACFE0085_impl*
 Result := false;
//#UC END# *4CE67DED0192_4CFCACFE0085_impl*
end;//TK245206060.IsPlus

function TK245206060.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CFCACFE0085';
end;//TK245206060.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK245206060.Suite);

end.