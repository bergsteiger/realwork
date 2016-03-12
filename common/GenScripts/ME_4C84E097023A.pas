unit PrimConsultationMarkOptions_Form;
 {* Оценка ответа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMarkOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimConsultationMark_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimConsultationMarkOptionsForm = class(TPrimConsultationMarkForm)
  {* Оценка ответа }
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimConsultationMarkOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ConsultingUnit
 , DataAdapter
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4C84E097023Atest_var*
//#UC END# *4C762A1501FC_4C84E097023Atest_var*
begin
//#UC START# *4C762A1501FC_4C84E097023Atest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsMark) and dsMark.CanSend;
//#UC END# *4C762A1501FC_4C84E097023Atest_impl*
end;//TPrimConsultationMarkOptionsForm.Result_Ok_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4C84E097023Aexec_var*
//#UC END# *4C762A1501FC_4C84E097023Aexec_var*
begin
//#UC START# *4C762A1501FC_4C84E097023Aexec_impl*
 if Assigned(dsMark) and dsMark.CanSend then
 begin
  if mComment.TextLen > c_TextCommentLen then
  begin
   Say(err_LimitCharsReached, [c_TextCommentLen]);
   Exit;
  end;
  dsMark.Comment := mComment.Buffer;
  try
   dsMark.Send;
   ModalResult := mrOk;
  except
   on ENoConnection do
    Say(war_NoConnection);
   on ENoSubscription do
    Say(war_NoSubscription, [defDataAdapter.GetDealerInfo]);
  end;
 end;//if Assigned(dsMark) and dsMark.CanSend then
//#UC END# *4C762A1501FC_4C84E097023Aexec_impl*
end;//TPrimConsultationMarkOptionsForm.Result_Ok_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4C762A1501FC_4C84E097023Agetstate_var*
//#UC END# *4C762A1501FC_4C84E097023Agetstate_var*
begin
//#UC START# *4C762A1501FC_4C84E097023Agetstate_impl*
 State := st_user_Result_Ok_ConsultationMark; 
//#UC END# *4C762A1501FC_4C84E097023Agetstate_impl*
end;//TPrimConsultationMarkOptionsForm.Result_Ok_GetState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4C762AB601E1_4C84E097023Aexec_var*
//#UC END# *4C762AB601E1_4C84E097023Aexec_var*
begin
//#UC START# *4C762AB601E1_4C84E097023Aexec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762AB601E1_4C84E097023Aexec_impl*
end;//TPrimConsultationMarkOptionsForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimConsultationMarkOptionsForm);
 {* Регистрация PrimConsultationMarkOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
