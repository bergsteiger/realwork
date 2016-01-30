unit K590528525;
 {* [Requestlink:590528525] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K590528525.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK590528525 = class(TNSRCtoEVDTest)
  {* [Requestlink:590528525] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK590528525
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590528525.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK590528525.GetFolder

function TK590528525.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54F9A112029C';
end;//TK590528525.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590528525.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
