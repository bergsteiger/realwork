unit SuccessTest;
 {* Успешный тест }

// Модуль: "w:\common\components\rtl\Garant\TestForTFW\SuccessTest.pas"
// Стереотип: "TestCase"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TSuccessTest = class(TBaseTest)
  {* Успешный тест }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
 end;//TSuccessTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TSuccessTest.DoIt;
//#UC START# *4CA0B2AC0096_4CA0B27401E4_var*
//#UC END# *4CA0B2AC0096_4CA0B27401E4_var*
begin
//#UC START# *4CA0B2AC0096_4CA0B27401E4_impl*
 Check(true);
//#UC END# *4CA0B2AC0096_4CA0B27401E4_impl*
end;//TSuccessTest.DoIt

function TSuccessTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TFWTests';
end;//TSuccessTest.GetFolder

function TSuccessTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA0B27401E4';
end;//TSuccessTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TSuccessTest.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
