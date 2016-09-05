unit K244712164;
 {* [RequestLink:244712164] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K244712164.pas"
// Стереотип: "TestCase"
// Элемент модели: "K244712164" MUID: (4D11F843033C)
// Имя типа: "TK244712164"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK244712164 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:244712164] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK244712164
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4D11F843033Cimpl_uses*
 //#UC END# *4D11F843033Cimpl_uses*
;

function TK244712164.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK244712164.GetFolder

function TK244712164.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D11F843033C';
end;//TK244712164.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK244712164.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
