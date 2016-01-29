unit K595976509;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K595976509.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::K595976509
//
// {Requestlink:595976509}
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
  RTFtoEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK595976509 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:595976509] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK595976509
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK595976509

function TK595976509.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//TK595976509.GetFolder

function TK595976509.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '551E2B850024';
end;//TK595976509.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK595976509.Suite);

end.