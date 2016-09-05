unit K598131874;
 {* [RequestLink:598131874] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K598131874.pas"
// Стереотип: "TestCase"
// Элемент модели: "K598131874" MUID: (561CE690036B)
// Имя типа: "TK598131874"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK598131874 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:598131874] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK598131874
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *561CE690036Bimpl_uses*
 //#UC END# *561CE690036Bimpl_uses*
;

function TK598131874.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK598131874.GetFolder

function TK598131874.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561CE690036B';
end;//TK598131874.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598131874.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
