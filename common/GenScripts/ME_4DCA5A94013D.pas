unit kwExTextFormWord;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwExTextFormWord.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , kwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , ExText_Form
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TkwExTextFormWord = {abstract} class(TkwFormFromControlWord)
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoForm(aForm: TForm;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwExTextFormWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , afwFacade
 , SysUtils
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

{$If NOT Defined(NoVCL)}
procedure TkwExTextFormWord.DoForm(aForm: TForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4DCA5A94013D_var*
//#UC END# *4EB25DE00396_4DCA5A94013D_var*
begin
//#UC START# *4EB25DE00396_4DCA5A94013D_impl*
 Assert(aForm Is TExTextForm, Format('Форма %s не совместима с %s',
                                   [aForm.ClassName, TExTextForm.ClassName]));
 DoTextForm(aForm As TExTextForm, aCtx);
//#UC END# *4EB25DE00396_4DCA5A94013D_impl*
end;//TkwExTextFormWord.DoForm

initialization
 TkwExTextFormWord.RegisterClass;
 {* Регистрация TkwExTextFormWord }
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(NoScripts)
end.
