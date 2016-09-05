unit K618678791;
 {* [Requestlink:618678791] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K618678791.pas"
// Стереотип: "TestCase"
// Элемент модели: "K618678791" MUID: (56D6CE2102FA)
// Имя типа: "TK618678791"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK618678791 = class(THTMLtoEVDFull)
  {* [Requestlink:618678791] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK618678791
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *56D6CE2102FAimpl_uses*
 //#UC END# *56D6CE2102FAimpl_uses*
;

function TK618678791.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK618678791.GetFolder

function TK618678791.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56D6CE2102FA';
end;//TK618678791.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK618678791.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
