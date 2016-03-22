unit K207388924;
 {* [RequestLink:207388924] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K207388924.pas"
// Стереотип: "TestCase"
// Элемент модели: "K207388924" MUID: (4BD83715018F)
// Имя типа: "TK207388924"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK207388924 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:207388924] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK207388924
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK207388924.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK207388924.GetFolder

function TK207388924.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BD83715018F';
end;//TK207388924.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK207388924.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
