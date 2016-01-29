unit K288788279;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K288788279.pas"
// Начат: 29.09.2011 18:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7 Lulin::K288788279
//
// {RequestLink:288788279}
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
  HTMLtoEVDTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK288788279 = class(THTMLtoEVDTest)
  {* [RequestLink:288788279] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK288788279
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK288788279

function TK288788279.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7 Lulin';
end;//TK288788279.GetFolder

function TK288788279.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E847F620320';
end;//TK288788279.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK288788279.Suite);

end.