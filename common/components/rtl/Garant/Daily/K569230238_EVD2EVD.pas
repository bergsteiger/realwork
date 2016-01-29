unit K569230238_EVD2EVD;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K569230238_EVD2EVD.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::K569230238_EVD2EVD
//
// {RequestLink:569230238}
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
  EVDtoEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK569230238_EVD2EVD = class(TEVDtoEVDWriterTest)
  {* [RequestLink:569230238] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK569230238_EVD2EVD
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK569230238_EVD2EVD

function TK569230238_EVD2EVD.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//TK569230238_EVD2EVD.GetFolder

function TK569230238_EVD2EVD.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5492DC8502F9';
end;//TK569230238_EVD2EVD.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK569230238_EVD2EVD.Suite);

end.