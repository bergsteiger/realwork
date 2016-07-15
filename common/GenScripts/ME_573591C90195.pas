unit EVDtoHTMLwoCSS;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLwoCSS.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDtoHTMLwoCSS" MUID: (573591C90195)
// Имя типа: "TEVDtoHTMLwoCSS"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLTest
 , ddHTMLWriter
;

type
 TEVDtoHTMLwoCSS = {abstract} class(TEVDtoHTMLTest)
  protected
   procedure TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator); override;
   function GetHTMLWriter: TddHTMLGenerator; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoHTMLwoCSS
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ddProfNewsHTMLWriter
 , TestFrameWork
;

procedure TEVDtoHTMLwoCSS.TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator);
//#UC START# *56D9300D018D_573591C90195_var*
//#UC END# *56D9300D018D_573591C90195_var*
begin
//#UC START# *56D9300D018D_573591C90195_impl*
 aHTMLReader.HTMLOptions := aHTMLReader.HTMLOptions + [dd_hwoWriteGarantCSSLink];
//#UC END# *56D9300D018D_573591C90195_impl*
end;//TEVDtoHTMLwoCSS.TuningHTMLGenerator

function TEVDtoHTMLwoCSS.GetHTMLWriter: TddHTMLGenerator;
//#UC START# *57613C5F000C_573591C90195_var*
//#UC END# *57613C5F000C_573591C90195_var*
begin
//#UC START# *57613C5F000C_573591C90195_impl*
 Result := TddProfNewsHTMLWriter.Create;
//#UC END# *57613C5F000C_573591C90195_impl*
end;//TEVDtoHTMLwoCSS.GetHTMLWriter

function TEVDtoHTMLwoCSS.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'HTML';
end;//TEVDtoHTMLwoCSS.GetFolder

function TEVDtoHTMLwoCSS.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '573591C90195';
end;//TEVDtoHTMLwoCSS.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
