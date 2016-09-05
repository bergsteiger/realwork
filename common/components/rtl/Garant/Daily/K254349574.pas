unit K254349574;
 {* [Requestlink:252524299]. Вторичный тест на поведение табуляции. Первый находится [Requestlink:254349574] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K254349574.pas"
// Стереотип: "TestCase"
// Элемент модели: "K254349574" MUID: (4E3FDDF10075)
// Имя типа: "TK254349574"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTest
;

type
 TK254349574 = class(TAutoTest)
  {* [Requestlink:252524299]. Вторичный тест на поведение табуляции. Первый находится [Requestlink:254349574] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK254349574
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E3FDDF10075impl_uses*
 //#UC END# *4E3FDDF10075impl_uses*
;

function TK254349574.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScriptTest';
end;//TK254349574.GetFolder

function TK254349574.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E3FDDF10075';
end;//TK254349574.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK254349574.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
