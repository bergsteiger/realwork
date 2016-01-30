unit K412987699;
 {* [Requestlink:412987699] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K412987699.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK412987699 = class(TNSRCtoEVDTest)
  {* [Requestlink:412987699] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK412987699
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK412987699.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK412987699.GetFolder

function TK412987699.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50C09F4A02A0';
end;//TK412987699.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK412987699.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
