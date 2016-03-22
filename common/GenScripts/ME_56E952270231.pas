unit K619944727_H11000224_2;
 {* [RequestLink:619944727] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619944727_H11000224_2.pas"
// Стереотип: "TestCase"
// Элемент модели: "K619944727_H11000224_2" MUID: (56E952270231)
// Имя типа: "TK619944727_H11000224_2"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619944727_H11000224_2 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619944727] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619944727_H11000224_2
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619944727_H11000224_2.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK619944727_H11000224_2.GetFolder

function TK619944727_H11000224_2.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E952270231';
end;//TK619944727_H11000224_2.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619944727_H11000224_2.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
