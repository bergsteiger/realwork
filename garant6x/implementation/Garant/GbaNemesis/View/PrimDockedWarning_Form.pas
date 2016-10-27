unit PrimDockedWarning_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDockedWarning_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimDockedWarning" MUID: (4EA59DA70226)
// Имя типа: "TPrimDockedWarningForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningOptions_Form
 , Document_Strange_Controls
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _WarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes.imp.pas}
 TPrimDockedWarningForm = class(_WarningUserTypes_)
  protected
   procedure WarningQueryClose(aSender: TObject); override;
    {* Обработчик события Warning.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Warning_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_BecomeActive_Execute(aSubID: TnsWarningSub);
   procedure Warning_BecomeActive(const aParams: IvcmExecuteParams);
   procedure Warning_SwitchActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_SwitchActive_Execute(aSubID: TnsWarningSub);
   procedure Warning_SwitchActive(const aParams: IvcmExecuteParams);
 end;//TPrimDockedWarningForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , WarningUserTypes_Warning_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , F1Like_InternalOperations_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4EA59DA70226impl_uses*
 //#UC END# *4EA59DA70226impl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes.imp.pas}

procedure TPrimDockedWarningForm.WarningQueryClose(aSender: TObject);
 {* Обработчик события Warning.OnQueryClose }
//#UC START# *2FE2CD3A0C24_4EA59DA70226_var*
//#UC END# *2FE2CD3A0C24_4EA59DA70226_var*
begin
//#UC START# *2FE2CD3A0C24_4EA59DA70226_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *2FE2CD3A0C24_4EA59DA70226_impl*
end;//TPrimDockedWarningForm.WarningQueryClose

procedure TPrimDockedWarningForm.Warning_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AE9DF12018A_4EA59DA70226test_var*
//#UC END# *4AE9DF12018A_4EA59DA70226test_var*
begin
//#UC START# *4AE9DF12018A_4EA59DA70226test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (UserType = Warning);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269081712
 // http://mdp.garant.ru/pages/viewpage.action?pageId=274464961
//#UC END# *4AE9DF12018A_4EA59DA70226test_impl*
end;//TPrimDockedWarningForm.Warning_BecomeActive_Test

procedure TPrimDockedWarningForm.Warning_BecomeActive_Execute(aSubID: TnsWarningSub);
//#UC START# *4AE9DF12018A_4EA59DA70226exec_var*
//#UC END# *4AE9DF12018A_4EA59DA70226exec_var*
begin
//#UC START# *4AE9DF12018A_4EA59DA70226exec_impl*
 PositionOnRequestedSub(aSubID);
//#UC END# *4AE9DF12018A_4EA59DA70226exec_impl*
end;//TPrimDockedWarningForm.Warning_BecomeActive_Execute

procedure TPrimDockedWarningForm.Warning_BecomeActive(const aParams: IvcmExecuteParams);
begin
 with IWarning_BecomeActive_Params(aParams.Data) do
  Self.Warning_BecomeActive_Execute(SubID);
end;//TPrimDockedWarningForm.Warning_BecomeActive

procedure TPrimDockedWarningForm.Warning_SwitchActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AE9DF3602B2_4EA59DA70226test_var*
//#UC END# *4AE9DF3602B2_4EA59DA70226test_var*
begin
//#UC START# *4AE9DF3602B2_4EA59DA70226test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (UserType = Warning);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269081712
 // http://mdp.garant.ru/pages/viewpage.action?pageId=274464961
//#UC END# *4AE9DF3602B2_4EA59DA70226test_impl*
end;//TPrimDockedWarningForm.Warning_SwitchActive_Test

procedure TPrimDockedWarningForm.Warning_SwitchActive_Execute(aSubID: TnsWarningSub);
//#UC START# *4AE9DF3602B2_4EA59DA70226exec_var*
//#UC END# *4AE9DF3602B2_4EA59DA70226exec_var*
begin
//#UC START# *4AE9DF3602B2_4EA59DA70226exec_impl*
 PositionOnRequestedSub(aSubID);
//#UC END# *4AE9DF3602B2_4EA59DA70226exec_impl*
end;//TPrimDockedWarningForm.Warning_SwitchActive_Execute

procedure TPrimDockedWarningForm.Warning_SwitchActive(const aParams: IvcmExecuteParams);
begin
 with IWarning_SwitchActive_Params(aParams.Data) do
  Self.Warning_SwitchActive_Execute(SubID);
end;//TPrimDockedWarningForm.Warning_SwitchActive

{$If NOT Defined(NoVCM)}
procedure TPrimDockedWarningForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Warning, nil);
  PublishOpWithResult(en_Warning, op_BecomeActive, Warning_BecomeActive, Warning_BecomeActive_Test, nil);
  PublishOpWithResult(en_Warning, op_SwitchActive, Warning_SwitchActive, Warning_SwitchActive_Test, nil);
  ShowInContextMenu(en_File, op_Print, False);
  ShowInToolbar(en_File, op_Print, False);
 end;//with Entities.Entities
 AddUserTypeExclude(WarningName, en_File, op_Print, False);
 AddUserTypeExclude(WarningName, en_File, op_PrintDialog, False);
 AddUserTypeExclude(WarningName, en_File, op_PrintPreview, False);
end;//TPrimDockedWarningForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDockedWarningForm);
 {* Регистрация PrimDockedWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
