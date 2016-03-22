unit K398275085;
 {* [RequestLink:398275085] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K398275085.pas"
// Стереотип: "TestCase"
// Элемент модели: "K398275085" MUID: (50BDEB6F008B)
// Имя типа: "TK398275085"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK398275085 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:398275085] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK398275085
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK398275085.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK398275085.GetFolder

function TK398275085.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50BDEB6F008B';
end;//TK398275085.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK398275085.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
