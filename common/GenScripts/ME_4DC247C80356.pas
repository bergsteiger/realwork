unit AutoTest;

// Модуль: "w:\common\components\rtl\Garant\ScriptTestLibrary\AutoTest.pas"
// Стереотип: "SimpleClass"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomInsiderScripter
;

type
 TAutoTest = class(TCustomInsiderScripter)
  protected
   procedure Run; override;
   procedure Prepare; override;
    {* Вызывается в начале DoIt }
 end;//TAutoTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 , tfwScriptEngine
;

procedure TAutoTest.Run;
//#UC START# *4DC3D2E00153_4DC247C80356_var*
//#UC END# *4DC3D2E00153_4DC247C80356_var*
begin
//#UC START# *4DC3D2E00153_4DC247C80356_impl*
 OwnScriptFromFile;
//#UC END# *4DC3D2E00153_4DC247C80356_impl*
end;//TAutoTest.Run

procedure TAutoTest.Prepare;
 {* Вызывается в начале DoIt }
//#UC START# *4DC3DE630030_4DC247C80356_var*
//#UC END# *4DC3DE630030_4DC247C80356_var*
begin
//#UC START# *4DC3DE630030_4DC247C80356_impl*
//#UC END# *4DC3DE630030_4DC247C80356_impl*
end;//TAutoTest.Prepare
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
