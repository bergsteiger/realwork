unit PrimConsultationMarkOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Consultation/Forms/PrimConsultationMarkOptions_Form.pas"
// Начат: 06.09.2010 16:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Пользовательские сервисы::Consultation::View::Consultation::PrimConsultationMarkOptions
//
// Оценка ответа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PrimConsultationMark_Form
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimConsultationMarkOptionsForm = {form} class(TPrimConsultationMarkForm)
  {* Оценка ответа }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
 end;//TPrimConsultationMarkOptionsForm

 TvcmEntityFormRef = TPrimConsultationMarkOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  ConsultingUnit,
  DataAdapter
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimConsultationMarkOptionsForm

{$If not defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762A1501FC_4C84E097023Atest_var*
//#UC END# *4C762A1501FC_4C84E097023Atest_var*
begin
//#UC START# *4C762A1501FC_4C84E097023Atest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsMark) and dsMark.CanSend;
//#UC END# *4C762A1501FC_4C84E097023Atest_impl*
end;//TPrimConsultationMarkOptionsForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C762A1501FC_4C84E097023Agetstate_var*
//#UC END# *4C762A1501FC_4C84E097023Agetstate_var*
begin
//#UC START# *4C762A1501FC_4C84E097023Agetstate_impl*
 State := st_user_Result_Ok_ConsultationMark; 
//#UC END# *4C762A1501FC_4C84E097023Agetstate_impl*
end;//TPrimConsultationMarkOptionsForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimConsultationMarkOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762AB601E1_4C84E097023Aexec_var*
//#UC END# *4C762AB601E1_4C84E097023Aexec_var*
begin
//#UC START# *4C762AB601E1_4C84E097023Aexec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762AB601E1_4C84E097023Aexec_impl*
end;//TPrimConsultationMarkOptionsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

procedure TPrimConsultationMarkOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimConsultationMarkOptions
 TtfwClassRef.Register(TPrimConsultationMarkOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.