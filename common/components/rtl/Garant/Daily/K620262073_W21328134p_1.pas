unit K620262073_W21328134p_1;
 {* [RequestLink:620262073] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620262073_W21328134p_1.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620262073_W21328134p_1" MUID: (56F5422E0273)
// Имя типа: "TK620262073_W21328134p_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_W21328134p_1 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620262073_W21328134p_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56F5422E0273impl_uses*
 //#UC END# *56F5422E0273impl_uses*
;

function TK620262073_W21328134p_1.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620262073_W21328134p_1.GetFolder

function TK620262073_W21328134p_1.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F5422E0273';
end;//TK620262073_W21328134p_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_W21328134p_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
