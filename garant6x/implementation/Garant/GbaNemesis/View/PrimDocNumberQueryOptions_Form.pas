unit PrimDocNumberQueryOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocNumberQueryOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimDocNumberQueryOptions" MUID: (4C863B1E0196)
// Имя типа: "TPrimDocNumberQueryOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocNumberQuery_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimDocNumberQueryOptionsForm = class(TPrimDocNumberQueryForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimDocNumberQueryOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C863B1E0196impl_uses*
 //#UC END# *4C863B1E0196impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimDocNumberQueryOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4C863B1E0196exec_var*
//#UC END# *4C762A1501FC_4C863B1E0196exec_var*
begin
//#UC START# *4C762A1501FC_4C863B1E0196exec_impl*
 if Save then
  ModalResult := mrOk;
//#UC END# *4C762A1501FC_4C863B1E0196exec_impl*
end;//TPrimDocNumberQueryOptionsForm.Result_Ok_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDocNumberQueryOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4C863B1E0196exec_var*
//#UC END# *4C762C910358_4C863B1E0196exec_var*
begin
//#UC START# *4C762C910358_4C863B1E0196exec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762C910358_4C863B1E0196exec_impl*
end;//TPrimDocNumberQueryOptionsForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDocNumberQueryOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Ok, True);
  ShowInToolbar(en_Result, op_Ok, True);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, True);
  ShowInToolbar(en_Result, op_Cancel, True);
 end;//with Entities.Entities
end;//TPrimDocNumberQueryOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocNumberQueryOptionsForm);
 {* Регистрация PrimDocNumberQueryOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
