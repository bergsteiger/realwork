unit ArchiInsiderTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/ArchiInsiderTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$TestSupport::Archi Insider Test Support::ArchiScriptSupport::TArchiInsiderTest
//
// Скрипты "знакомые" со внутренними особенностями Арчи.
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
  CustomInsiderScripter
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TArchiInsiderTest = class(TCustomInsiderScripter)
  {* Скрипты "знакомые" со внутренними особенностями Арчи. }
 protected
 // realized methods
   procedure Run; override;
   procedure Prepare; override;
     {* Вызывается в начале DoIt }
 end;//TArchiInsiderTest
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwScriptEngine
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TArchiInsiderTest

procedure TArchiInsiderTest.Run;
//#UC START# *4DC3D2E00153_4DE4827600CA_var*
//#UC END# *4DC3D2E00153_4DE4827600CA_var*
begin
//#UC START# *4DC3D2E00153_4DE4827600CA_impl*
 OwnScriptFromFile;    
//#UC END# *4DC3D2E00153_4DE4827600CA_impl*
end;//TArchiInsiderTest.Run

procedure TArchiInsiderTest.Prepare;
//#UC START# *4DC3DE630030_4DE4827600CA_var*
//#UC END# *4DC3DE630030_4DE4827600CA_var*
begin
//#UC START# *4DC3DE630030_4DE4827600CA_impl*
//#UC END# *4DC3DE630030_4DE4827600CA_impl*
end;//TArchiInsiderTest.Prepare

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.