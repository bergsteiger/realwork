unit K565862557;
 {* [Requestlink:565862557] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K565862557.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK565862557 = class(TNSRCtoEVDTest)
  {* [Requestlink:565862557] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK565862557
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK565862557.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK565862557.GetFolder

function TK565862557.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '542C069B017A';
end;//TK565862557.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK565862557.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
