unit HTMLtoEVDTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/HTMLtoEVDTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::HTML::HTMLtoEVDTest
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
  HTMLtoEVDWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 THTMLtoEVDTest = {abstract} class(THTMLtoEVDWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//THTMLtoEVDTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class THTMLtoEVDTest

procedure THTMLtoEVDTest.DoIt;
//#UC START# *4E847F290293_4E847E770184_var*
//#UC END# *4E847F290293_4E847E770184_var*
begin
//#UC START# *4E847F290293_4E847E770184_impl*
 HTMLtoEVD(KPage + '.htm');
//#UC END# *4E847F290293_4E847E770184_impl*
end;//THTMLtoEVDTest.DoIt

function THTMLtoEVDTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'HTML';
end;//THTMLtoEVDTest.GetFolder

function THTMLtoEVDTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E847E770184';
end;//THTMLtoEVDTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.