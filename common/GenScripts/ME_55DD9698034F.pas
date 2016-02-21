unit K606129271;
 {* [RequestLink:606129271] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K606129271.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK606129271 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:606129271] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK606129271
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606129271.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK606129271.GetFolder

function TK606129271.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55DD9698034F';
end;//TK606129271.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606129271.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
