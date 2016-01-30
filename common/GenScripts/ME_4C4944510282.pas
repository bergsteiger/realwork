unit K227972911;
 {* [$227972911] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K227972911.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
;

type
 TK227972911 = class(TMergeCellsTest)
  {* [$227972911] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK227972911
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK227972911.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK227972911.GetFolder

function TK227972911.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C4944510282';
end;//TK227972911.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK227972911.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
