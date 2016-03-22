unit K207013375;
 {* [RequestLink:207013375] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K207013375.pas"
// Стереотип: "TestCase"
// Элемент модели: "K207013375" MUID: (4BD823F0001F)
// Имя типа: "TK207013375"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK207013375 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:207013375] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK207013375
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK207013375.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK207013375.GetFolder

function TK207013375.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BD823F0001F';
end;//TK207013375.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK207013375.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
