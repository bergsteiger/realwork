unit K331186919;
 {* [RequestLink:331186919] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K331186919.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK331186919 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:331186919] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK331186919
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK331186919.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK331186919.GetFolder

function TK331186919.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F265D9A02E9';
end;//TK331186919.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK331186919.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
