unit K404357586;
 {* [Requestlink:404357586] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K404357586.pas"
// Стереотип: "TestCase"
// Элемент модели: "K404357586" MUID: (50C9836002B6)
// Имя типа: "TK404357586"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK404357586 = class(TNSRCtoEVDTest)
  {* [Requestlink:404357586] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK404357586
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK404357586.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK404357586.GetFolder

function TK404357586.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50C9836002B6';
end;//TK404357586.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK404357586.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
