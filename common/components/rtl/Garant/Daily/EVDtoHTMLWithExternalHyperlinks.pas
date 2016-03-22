unit EVDtoHTMLWithExternalHyperlinks;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLWithExternalHyperlinks.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDtoHTMLWithExternalHyperlinks" MUID: (56D9305C01DD)
// Имя типа: "TEVDtoHTMLWithExternalHyperlinks"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLTest
 , ddHTMLWriter
;

type
 TEVDtoHTMLWithExternalHyperlinks = {abstract} class(TEVDtoHTMLTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   procedure TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator); override;
 end;//TEVDtoHTMLWithExternalHyperlinks
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TEVDtoHTMLWithExternalHyperlinks.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'HTML';
end;//TEVDtoHTMLWithExternalHyperlinks.GetFolder

function TEVDtoHTMLWithExternalHyperlinks.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56D9305C01DD';
end;//TEVDtoHTMLWithExternalHyperlinks.GetModelElementGUID

procedure TEVDtoHTMLWithExternalHyperlinks.TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator);
//#UC START# *56D9300D018D_56D9305C01DD_var*
//#UC END# *56D9300D018D_56D9305C01DD_var*
begin
//#UC START# *56D9300D018D_56D9305C01DD_impl*
 aHTMLReader.UseExternalLinks := True;
 aHTMLReader.WriteFirstHyperlink := True;
//#UC END# *56D9300D018D_56D9305C01DD_impl*
end;//TEVDtoHTMLWithExternalHyperlinks.TuningHTMLGenerator
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
