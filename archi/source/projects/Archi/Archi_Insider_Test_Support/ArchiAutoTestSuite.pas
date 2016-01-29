unit ArchiAutoTestSuite;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/ArchiAutoTestSuite.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$TestSupport::Archi Insider Test Support::ArchiScriptSupport::TArchiAutoTestSuite
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  CustomAutoTestsSuite
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TArchiAutoTestSuite = class(TCustomAutoTestSuite)
 protected
 // overridden protected methods
   procedure DoReReadAbstractTests; override;
     {* Сигнатура метода DoReReadAbstractTests }
 public
 // public methods
   class procedure Register;
 end;//TArchiAutoTestSuite
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  ArchiAutoTest,
  TestFrameWork,
  kwKeyWordsPack,
  kwArchiEverestWordsPack,
  l3ComponentInfoHelper
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TArchiAutoTestSuite

class procedure TArchiAutoTestSuite.Register;
//#UC START# *4DE368140094_4DE342FA0300_var*
//#UC END# *4DE368140094_4DE342FA0300_var*
begin
//#UC START# *4DE368140094_4DE342FA0300_impl*
 TestFramework.RegisterTest(Self.Create(TArchiAutoTest));
//#UC END# *4DE368140094_4DE342FA0300_impl*
end;//TArchiAutoTestSuite.Register

procedure TArchiAutoTestSuite.DoReReadAbstractTests;
//#UC START# *5040A3CE0118_4DE342FA0300_var*
//#UC END# *5040A3CE0118_4DE342FA0300_var*
begin
//#UC START# *5040A3CE0118_4DE342FA0300_impl*
 AddTests(TArchiAutoTest);
//#UC END# *5040A3CE0118_4DE342FA0300_impl*
end;//TArchiAutoTestSuite.DoReReadAbstractTests

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.