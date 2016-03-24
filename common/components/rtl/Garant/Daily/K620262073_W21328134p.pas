unit K620262073_W21328134p;
 {* [RequestLink:620262073] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K620262073_W21328134p.pas"
// Стереотип: "TestCase"
// Элемент модели: "K620262073_W21328134p" MUID: (56F416E50126)
// Имя типа: "TK620262073_W21328134p"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK620262073_W21328134p = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:620262073] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK620262073_W21328134p
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK620262073_W21328134p.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK620262073_W21328134p.GetFolder

function TK620262073_W21328134p.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56F416E50126';
end;//TK620262073_W21328134p.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK620262073_W21328134p.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
