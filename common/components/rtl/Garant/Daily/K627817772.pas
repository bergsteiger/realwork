unit K627817772;
 {* [Requestlink:627817772] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K627817772.pas"
// Стереотип: "TestCase"
// Элемент модели: "K627817772" MUID: (5799DC420209)
// Имя типа: "TK627817772"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK627817772 = class(THTMLtoEVDFull)
  {* [Requestlink:627817772] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK627817772
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5799DC420209impl_uses*
 //#UC END# *5799DC420209impl_uses*
;

function TK627817772.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK627817772.GetFolder

function TK627817772.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5799DC420209';
end;//TK627817772.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK627817772.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
