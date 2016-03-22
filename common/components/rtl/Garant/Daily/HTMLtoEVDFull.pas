unit HTMLtoEVDFull;

// Модуль: "w:\common\components\rtl\Garant\Daily\HTMLtoEVDFull.pas"
// Стереотип: "TestCase"
// Элемент модели: "HTMLtoEVDFull" MUID: (56D6CCB60125)
// Имя типа: "THTMLtoEVDFull"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
 , ddHTMLReader
;

type
 THTMLtoEVDFull = {abstract} class(THTMLtoEVDTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   procedure TuningReader(aHTMLReader: TddHTMLReader); override;
 end;//THTMLtoEVDFull
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function THTMLtoEVDFull.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'HTML';
end;//THTMLtoEVDFull.GetFolder

function THTMLtoEVDFull.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56D6CCB60125';
end;//THTMLtoEVDFull.GetModelElementGUID

procedure THTMLtoEVDFull.TuningReader(aHTMLReader: TddHTMLReader);
//#UC START# *56A613A30375_56D6CCB60125_var*
//#UC END# *56A613A30375_56D6CCB60125_var*
begin
//#UC START# *56A613A30375_56D6CCB60125_impl*
 aHTMLReader.Lite := False;
//#UC END# *56A613A30375_56D6CCB60125_impl*
end;//THTMLtoEVDFull.TuningReader
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
