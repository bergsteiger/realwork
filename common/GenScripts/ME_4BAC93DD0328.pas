unit K199589954;
 {* [$199590833] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K199589954.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK199589954 = class(TEVDtoBothNSRCWriterTest)
  {* [$199590833] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK199589954
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK199589954.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK199589954.GetFolder

function TK199589954.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BAC93DD0328';
end;//TK199589954.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK199589954.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
