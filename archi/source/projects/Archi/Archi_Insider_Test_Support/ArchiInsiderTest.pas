unit ArchiInsiderTest;
 {* Скрипты "знакомые" со внутренними особенностями Арчи. }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\ArchiInsiderTest.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TArchiInsiderTest" MUID: (4DE4827600CA)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomInsiderScripter
;

type
 TArchiInsiderTest = class(TCustomInsiderScripter)
  {* Скрипты "знакомые" со внутренними особенностями Арчи. }
  protected
   procedure Run; override;
   procedure Prepare; override;
    {* Вызывается в начале DoIt }
 end;//TArchiInsiderTest
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptEngine
 //#UC START# *4DE4827600CAimpl_uses*
 //#UC END# *4DE4827600CAimpl_uses*
;

procedure TArchiInsiderTest.Run;
//#UC START# *4DC3D2E00153_4DE4827600CA_var*
//#UC END# *4DC3D2E00153_4DE4827600CA_var*
begin
//#UC START# *4DC3D2E00153_4DE4827600CA_impl*
 OwnScriptFromFile;    
//#UC END# *4DC3D2E00153_4DE4827600CA_impl*
end;//TArchiInsiderTest.Run

procedure TArchiInsiderTest.Prepare;
 {* Вызывается в начале DoIt }
//#UC START# *4DC3DE630030_4DE4827600CA_var*
//#UC END# *4DC3DE630030_4DE4827600CA_var*
begin
//#UC START# *4DC3DE630030_4DE4827600CA_impl*
//#UC END# *4DC3DE630030_4DE4827600CA_impl*
end;//TArchiInsiderTest.Prepare
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
