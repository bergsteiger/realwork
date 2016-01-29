unit AutoTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptTestLibrary"
// Модуль: "w:/common/components/rtl/Garant/ScriptTestLibrary/AutoTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::ScriptTestLibrary::AutoTests::TAutoTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  CustomInsiderScripter
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TAutoTest = class(TCustomInsiderScripter)
 protected
 // realized methods
   procedure Run; override;
   procedure Prepare; override;
     {* Вызывается в начале DoIt }
 end;//TAutoTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  TestFrameWork,
  tfwScriptEngine
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TAutoTest

procedure TAutoTest.Run;
//#UC START# *4DC3D2E00153_4DC247C80356_var*
//#UC END# *4DC3D2E00153_4DC247C80356_var*
begin
//#UC START# *4DC3D2E00153_4DC247C80356_impl*
 OwnScriptFromFile;
//#UC END# *4DC3D2E00153_4DC247C80356_impl*
end;//TAutoTest.Run

procedure TAutoTest.Prepare;
//#UC START# *4DC3DE630030_4DC247C80356_var*
//#UC END# *4DC3DE630030_4DC247C80356_var*
begin
//#UC START# *4DC3DE630030_4DC247C80356_impl*
//#UC END# *4DC3DE630030_4DC247C80356_impl*
end;//TAutoTest.Prepare

{$IfEnd} //nsTest AND not NoScripts

end.