unit PrimQueryCardWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PrimQueryCardWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PrimQueryCardWordsPack" MUID: (571A23EE0196)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *571A23EE0196intf_uses*
 //#UC END# *571A23EE0196intf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , kwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 , PrimQueryCard_Form
 , tfwScriptingInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwRegisterableWord
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *571A23EE0196impl_uses*
 , StdRes
 //#UC END# *571A23EE0196impl_uses*
;

type
 TkwQueryCardFormWord = {abstract} class({$If NOT Defined(NoVCL)}
 TkwFormFromControlWord
 {$IfEnd} // NOT Defined(NoVCL)
 )
  protected
   procedure DoQueryCardForm(aForm: TPrimQueryCardForm;
    const aCtx: TtfwContext); virtual; abstract;
   {$If NOT Defined(NoVCL)}
   procedure DoForm(aForm: TForm;
    const aCtx: TtfwContext); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TkwQueryCardFormWord

 TkwQueryCardSetCanSaveState = {final} class(TkwQueryCardFormWord)
  {* Устанавливает флаг того может ли карточка запроса писать своё состояние }
  protected
   procedure DoQueryCardForm(aForm: TPrimQueryCardForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwQueryCardSetCanSaveState

 TkwOk = {final} class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwOk

{$If NOT Defined(NoVCL)}
procedure TkwQueryCardFormWord.DoForm(aForm: TForm;
 const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4F69AE35012F_var*
//#UC END# *4EB25DE00396_4F69AE35012F_var*
begin
//#UC START# *4EB25DE00396_4F69AE35012F_impl*
 DoQueryCardForm(aForm As TPrimQueryCardForm, aCtx);
//#UC END# *4EB25DE00396_4F69AE35012F_impl*
end;//TkwQueryCardFormWord.DoForm
{$IfEnd} // NOT Defined(NoVCL)

procedure TkwQueryCardSetCanSaveState.DoQueryCardForm(aForm: TPrimQueryCardForm;
 const aCtx: TtfwContext);
//#UC START# *4F69AE600137_4F69AF3E01C0_var*
//#UC END# *4F69AE600137_4F69AF3E01C0_var*
begin
//#UC START# *4F69AE600137_4F69AF3E01C0_impl*
 aForm.CanWriteMgrSettings := aCtx.rEngine.PopBool;
//#UC END# *4F69AE600137_4F69AF3E01C0_impl*
end;//TkwQueryCardSetCanSaveState.DoQueryCardForm

class function TkwQueryCardSetCanSaveState.GetWordNameForRegister: AnsiString;
begin
 Result := 'QueryCard:SetCanSaveState';
end;//TkwQueryCardSetCanSaveState.GetWordNameForRegister

class function TkwOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ok';
end;//TkwOk.GetWordNameForRegister

procedure TkwOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DAF1DD9017F_var*
//#UC END# *4DAEEDE10285_4DAF1DD9017F_var*
begin
//#UC START# *4DAEEDE10285_4DAF1DD9017F_impl*
 aCtx.rCaller.Check(vcmDispatcher.EntityOperation(TdmStdRes.opcode_Result_OkExt, vcmParams), 'Операция Result OkExt не выполнилась');
//#UC END# *4DAEEDE10285_4DAF1DD9017F_impl*
end;//TkwOk.DoDoIt

initialization
 TkwQueryCardFormWord.RegisterClass;
 {* Регистрация TkwQueryCardFormWord }
 TkwQueryCardSetCanSaveState.RegisterInEngine;
 {* Регистрация QueryCard_SetCanSaveState }
 TkwOk.RegisterInEngine;
 {* Регистрация Ok }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
