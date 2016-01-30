unit kwDiffFormWord;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwDiffFormWord.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , kwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , Diff_Form
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TkwDiffFormWord = {abstract} class(TkwFormFromControlWord)
  protected
   procedure DoDiffForm(aForm: TDiffForm;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoForm(aForm: TForm;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwDiffFormWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

{$If NOT Defined(NoVCL)}
procedure TkwDiffFormWord.DoForm(aForm: TForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4EB25E1501E1_var*
//#UC END# *4EB25DE00396_4EB25E1501E1_var*
begin
//#UC START# *4EB25DE00396_4EB25E1501E1_impl*
 Assert(aForm Is TDiffForm, Format('Форма %s не совместима с %s',
                                   [aForm.ClassName, TDiffForm.ClassName]));
 DoDiffForm(aForm As TDiffForm, aCtx);
//#UC END# *4EB25DE00396_4EB25E1501E1_impl*
end;//TkwDiffFormWord.DoForm
{$IfEnd} // NOT Defined(NoVCL)

initialization
 TkwDiffFormWord.RegisterClass;
 {* Регистрация TkwDiffFormWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
