unit K235058888;
 {* [$235058888] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235058888.pas"
// Стереотип: "TestCase"
// Элемент модели: "K235058888" MUID: (4CA1AB5B0396)
// Имя типа: "TK235058888"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK235058888 = class(TEVDtoBothNSRCWriterTest)
  {* [$235058888] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235058888
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235058888.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235058888.GetFolder

function TK235058888.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA1AB5B0396';
end;//TK235058888.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235058888.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
