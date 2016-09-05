unit HTMLtoEVDTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\HTMLtoEVDTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "HTMLtoEVDTest" MUID: (4E847E770184)
// Имя типа: "THTMLtoEVDTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDWriterTest
;

type
 THTMLtoEVDTest = {abstract} class(THTMLtoEVDWriterTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//THTMLtoEVDTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E847E770184impl_uses*
 //#UC END# *4E847E770184impl_uses*
;

procedure THTMLtoEVDTest.DoIt;
//#UC START# *4E847F290293_4E847E770184_var*
//#UC END# *4E847F290293_4E847E770184_var*
begin
//#UC START# *4E847F290293_4E847E770184_impl*
 HTMLtoEVD(KPage + '.htm');
//#UC END# *4E847F290293_4E847E770184_impl*
end;//THTMLtoEVDTest.DoIt

function THTMLtoEVDTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'HTML';
end;//THTMLtoEVDTest.GetFolder

function THTMLtoEVDTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E847E770184';
end;//THTMLtoEVDTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
