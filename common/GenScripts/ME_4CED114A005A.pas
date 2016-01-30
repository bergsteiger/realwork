unit K111739572;
 {* [$111739572] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K111739572.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CellMouseSelectionTest
;

type
 TK111739572 = class(TCellMouseSelectionTest)
  {* [$111739572] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK111739572
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK111739572.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK111739572.GetFolder

function TK111739572.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CED114A005A';
end;//TK111739572.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK111739572.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
