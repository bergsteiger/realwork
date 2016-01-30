unit K565842263;
 {* [Requestlink:565842263] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K565842263.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK565842263 = class(TNSRCtoEVDTest)
  {* [Requestlink:565842263] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK565842263
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK565842263.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK565842263.GetFolder

function TK565842263.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '542BF156004C';
end;//TK565842263.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK565842263.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
