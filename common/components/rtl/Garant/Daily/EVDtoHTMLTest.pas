unit EVDtoHTMLTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoHTMLTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::HTML::EVDtoHTMLTest
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
  EVDtoHTMLWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoHTMLTest = {abstract} class(TEVDtoHTMLWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TEVDtoHTMLTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoHTMLTest

procedure TEVDtoHTMLTest.DoIt;
//#UC START# *516E73710182_516E734901D3_var*
//#UC END# *516E73710182_516E734901D3_var*
begin
//#UC START# *516E73710182_516E734901D3_impl*
 EVDtoHTML(KPage + '.evd');
//#UC END# *516E73710182_516E734901D3_impl*
end;//TEVDtoHTMLTest.DoIt

function TEVDtoHTMLTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'HTML';
end;//TEVDtoHTMLTest.GetFolder

function TEVDtoHTMLTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '516E734901D3';
end;//TEVDtoHTMLTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.