unit K460275638;

// Модуль: "w:\common\components\rtl\Garant\Daily\K460275638.pas"
// Стереотип: "TestCase"
// Элемент модели: "TK460275638" MUID: (51BB006C01A6)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RegExpTest
 , TestFrameWork
;

type
 TK460275638 = class(TRegExpTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   class function Suite: ITestSuite; override;
 end;//TK460275638
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , K460275638Suite
 //#UC START# *51BB006C01A6impl_uses*
 //#UC END# *51BB006C01A6impl_uses*
;

function TK460275638.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RegExp';
end;//TK460275638.GetFolder

function TK460275638.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51BB006C01A6';
end;//TK460275638.GetModelElementGUID

class function TK460275638.Suite: ITestSuite;
//#UC START# *4EA553E901DB_51BB006C01A6_var*
//#UC END# *4EA553E901DB_51BB006C01A6_var*
begin
//#UC START# *4EA553E901DB_51BB006C01A6_impl*
 Result := TK460275638Suite.Create(Self);
//#UC END# *4EA553E901DB_51BB006C01A6_impl*
end;//TK460275638.Suite

initialization
 TestFramework.RegisterTest(TK460275638.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
