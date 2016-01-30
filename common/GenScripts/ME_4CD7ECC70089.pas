unit K239372528;
 {* [$239372528] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K239372528.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , InsertBreakInTextTableTest
;

type
 TK239372528 = class(TInsertBreakInTextTableTest)
  {* [$239372528] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK239372528
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK239372528.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK239372528.GetFolder

function TK239372528.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CD7ECC70089';
end;//TK239372528.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK239372528.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
