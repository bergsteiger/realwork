unit K200088144;
 {* [RequestLink:200088144] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K200088144.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK200088144 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:200088144] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK200088144
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK200088144.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK200088144.GetFolder

function TK200088144.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BB5E9BC00F4';
end;//TK200088144.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK200088144.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
