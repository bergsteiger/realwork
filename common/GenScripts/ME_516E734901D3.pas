unit EVDtoHTMLTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDtoHTMLTest" MUID: (516E734901D3)
// Имя типа: "TEVDtoHTMLTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWriterTest
;

type
 TEVDtoHTMLTest = {abstract} class(TEVDtoHTMLWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TEVDtoHTMLTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TEVDtoHTMLTest.DoIt;
//#UC START# *516E73710182_516E734901D3_var*
//#UC END# *516E73710182_516E734901D3_var*
begin
//#UC START# *516E73710182_516E734901D3_impl*
 EVDtoHTML(KPage + '.evd');
//#UC END# *516E73710182_516E734901D3_impl*
end;//TEVDtoHTMLTest.DoIt

function TEVDtoHTMLTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'HTML';
end;//TEVDtoHTMLTest.GetFolder

function TEVDtoHTMLTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516E734901D3';
end;//TEVDtoHTMLTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
