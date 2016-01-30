unit K371639884;
 {* [RequestLink:371639884] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K371639884.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , FormulaRender
;

type
 TK371639884 = class(TFormulaRender)
  {* [RequestLink:371639884] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK371639884
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK371639884.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK371639884.GetFolder

function TK371639884.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '537B49A5027A';
end;//TK371639884.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK371639884.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
