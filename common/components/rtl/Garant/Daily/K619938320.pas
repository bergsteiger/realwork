unit K619938320;
 {* [RequestLink:619938320] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619938320.pas"
// Стереотип: "TestCase"
// Элемент модели: "K619938320" MUID: (56E7EEBF0217)
// Имя типа: "TK619938320"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK619938320 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:619938320] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619938320
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619938320.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'CrossSegments';
end;//TK619938320.GetFolder

function TK619938320.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E7EEBF0217';
end;//TK619938320.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619938320.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
