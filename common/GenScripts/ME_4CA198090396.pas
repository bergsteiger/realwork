unit K235057437;
 {* [$235057437] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235057437.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , QueryCardAddAttributeTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK235057437 = class(TQueryCardAddAttributeTest)
  {* [$235057437] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235057437
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235057437.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235057437.GetFolder

function TK235057437.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA198090396';
end;//TK235057437.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235057437.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
