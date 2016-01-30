unit K210043101;
 {* [RequestLink:210043101] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210043101.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK210043101 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:210043101] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210043101
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210043101.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210043101.GetFolder

function TK210043101.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE2BC4900C7';
end;//TK210043101.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043101.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
