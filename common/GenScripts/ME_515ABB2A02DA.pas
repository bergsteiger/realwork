unit K446824679;
 {* [Requestlink:446824679] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K446824679.pas"
// Стереотип: "TestCase"
// Элемент модели: "K446824679" MUID: (515ABB2A02DA)
// Имя типа: "TK446824679"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK446824679 = class(TNSRCtoEVDTest)
  {* [Requestlink:446824679] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK446824679
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK446824679.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK446824679.GetFolder

function TK446824679.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '515ABB2A02DA';
end;//TK446824679.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK446824679.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
