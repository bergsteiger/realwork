unit K444236481;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K444236481.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.8::K444236481
//
// {Requestlink:444236481}
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
 TK444236481 = class(THTMLtoEVDTest)
  {* [Requestlink:444236481] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK444236481
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK444236481

function TK444236481.GetFolder: AnsiString;
 {-}
begin
 Result := '7.8';
end;//TK444236481.GetFolder

function TK444236481.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5153D3EB035A';
end;//TK444236481.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK444236481.Suite);

end.