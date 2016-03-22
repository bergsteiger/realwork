unit K619559603;
 {* [Requestlink:619559603] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619559603.pas"
// Стереотип: "TestCase"
// Элемент модели: "K619559603" MUID: (56E01A9F0388)
// Имя типа: "TK619559603"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK619559603 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:619559603] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619559603
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619559603.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619559603.GetFolder

function TK619559603.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E01A9F0388';
end;//TK619559603.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619559603.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
