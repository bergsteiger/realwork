unit kwDiffIteratorWord;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwDiffIteratorWord.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwDiffFormWord
 , DocumentUnit
 , tfwScriptingInterfaces
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , Diff_Form
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
;

type
 TkwDiffIteratorWord = {abstract} class(TkwDiffFormWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); virtual; abstract;
   procedure DoDiffForm(aForm: TDiffForm;
    const aCtx: TtfwContext); override;
 end;//TkwDiffIteratorWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TDiffFormHack = {abstract} class(TDiffForm)
 end;//TDiffFormHack

procedure TkwDiffIteratorWord.DoDiffForm(aForm: TDiffForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25F0701B5_4EB2632A02DD_var*
//#UC END# *4EB25F0701B5_4EB2632A02DD_var*
begin
//#UC START# *4EB25F0701B5_4EB2632A02DD_impl*
 DoIterator(TDiffFormHack(aForm).CompareEditions.ChangedParas, aCtx);
//#UC END# *4EB25F0701B5_4EB2632A02DD_impl*
end;//TkwDiffIteratorWord.DoDiffForm

initialization
 TkwDiffIteratorWord.RegisterClass;
 {* Регистрация TkwDiffIteratorWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
