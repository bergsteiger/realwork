unit K586185519;
 {* [Requestlink:586185519] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K586185519.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK586185519 = class(THTMLtoEVDTest)
  {* [Requestlink:586185519] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK586185519
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK586185519.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK586185519.GetFolder

function TK586185519.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54C646FE0345';
end;//TK586185519.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK586185519.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
