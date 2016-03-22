unit K205357352;
 {* [$205357352] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K205357352.pas"
// Стереотип: "TestCase"
// Элемент модели: "K205357352" MUID: (4BCEF18800CE)
// Имя типа: "TK205357352"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK205357352 = class(TEVDtoBothNSRCWriterTest)
  {* [$205357352] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK205357352
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK205357352.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK205357352.GetFolder

function TK205357352.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BCEF18800CE';
end;//TK205357352.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK205357352.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
