unit K224135562;
 {* [RequestLink:224135562] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K224135562.pas"
// Стереотип: "TestCase"
// Элемент модели: "K224135562" MUID: (4C355396032F)
// Имя типа: "TK224135562"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK224135562 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:224135562] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK224135562
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK224135562.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK224135562.GetFolder

function TK224135562.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C355396032F';
end;//TK224135562.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK224135562.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
