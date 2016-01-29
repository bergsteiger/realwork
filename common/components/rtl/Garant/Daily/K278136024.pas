unit K278136024;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K278136024.pas"
// Начат: 03.08.2011 19:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7 Lulin::K278136024
//
// {RequestLink:278136024}
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
  WikiToEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK278136024 = class(TWikiToEVDWriterTest)
  {* [RequestLink:278136024] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK278136024
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK278136024

function TK278136024.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7 Lulin';
end;//TK278136024.GetFolder

function TK278136024.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E396B1F03D0';
end;//TK278136024.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK278136024.Suite);

end.