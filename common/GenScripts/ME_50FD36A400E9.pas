unit K424399558;
 {* [RequestLink:424399558] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K424399558.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoXMLWiterTest
;

type
 TK424399558 = class(TEVDtoXMLWiterTest)
  {* [RequestLink:424399558] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK424399558
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK424399558.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK424399558.GetFolder

function TK424399558.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50FD36A400E9';
end;//TK424399558.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK424399558.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
