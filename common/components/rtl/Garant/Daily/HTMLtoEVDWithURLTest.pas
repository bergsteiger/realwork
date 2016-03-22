unit HTMLtoEVDWithURLTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\HTMLtoEVDWithURLTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "HTMLtoEVDWithURLTest" MUID: (56A613EC02A2)
// Имя типа: "THTMLtoEVDWithURLTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
 , ddHTMLReader
;

type
 THTMLtoEVDWithURLTest = {abstract} class(THTMLtoEVDTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   procedure TuningReader(aHTMLReader: TddHTMLReader); override;
 end;//THTMLtoEVDWithURLTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function THTMLtoEVDWithURLTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'HTML';
end;//THTMLtoEVDWithURLTest.GetFolder

function THTMLtoEVDWithURLTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56A613EC02A2';
end;//THTMLtoEVDWithURLTest.GetModelElementGUID

procedure THTMLtoEVDWithURLTest.TuningReader(aHTMLReader: TddHTMLReader);
//#UC START# *56A613A30375_56A613EC02A2_var*
//#UC END# *56A613A30375_56A613EC02A2_var*
begin
//#UC START# *56A613A30375_56A613EC02A2_impl*
 aHTMLReader.ReadURL := True;
//#UC END# *56A613A30375_56A613EC02A2_impl*
end;//THTMLtoEVDWithURLTest.TuningReader
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
