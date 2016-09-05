unit arEditorControl;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arEditorControl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarEditorControl" MUID: (4DE643F100CB)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TarEditorControl = {abstract} class(TtfwRegisterableWord)
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    const anEditor: TevCustomEditorWindow); virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TarEditorControl
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
 //#UC START# *4DE643F100CBimpl_uses*
 //#UC END# *4DE643F100CBimpl_uses*
;

procedure TarEditorControl.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DE643F100CB_var*
//#UC END# *4DAEEDE10285_4DE643F100CB_var*
begin
//#UC START# *4DAEEDE10285_4DE643F100CB_impl*
 DoWithEditor(aCtx, arGetDocumentEditor);
//#UC END# *4DAEEDE10285_4DE643F100CB_impl*
end;//TarEditorControl.DoDoIt

initialization
 TarEditorControl.RegisterClass;
 {* Регистрация TarEditorControl }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
