unit K598136171;
 {* [RequestLink:598136171] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K598136171.pas"
// Стереотип: "TestCase"
// Элемент модели: "K598136171" MUID: (561CF15C039F)
// Имя типа: "TK598136171"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK598136171 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:598136171] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK598136171
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK598136171.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK598136171.GetFolder

function TK598136171.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561CF15C039F';
end;//TK598136171.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK598136171.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
