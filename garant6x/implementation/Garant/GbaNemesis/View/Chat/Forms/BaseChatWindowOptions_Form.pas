unit BaseChatWindowOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindowOptions_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "BaseChatWindowOptions" MUID: (4C84CB6F0007)
// Имя типа: "TBaseChatWindowOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseChatWindow_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Chat_Controls
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TBaseChatWindowOptionsForm = class(TBaseChatWindowForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Chat_History_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TBaseChatWindowOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Base_Operations_F1Services_Contracts
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C84CB6F0007impl_uses*
 //#UC END# *4C84CB6F0007impl_uses*
;

procedure TBaseChatWindowOptionsForm.Chat_History_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C84CC2E0253_4C84CB6F0007exec_var*
//#UC END# *4C84CC2E0253_4C84CB6F0007exec_var*
begin
//#UC START# *4C84CC2E0253_4C84CB6F0007exec_impl*
 TdmStdRes.MakeChatDispatcher.OpenChatHistoryByID(UserID);
//#UC END# *4C84CC2E0253_4C84CB6F0007exec_impl*
end;//TBaseChatWindowOptionsForm.Chat_History_Execute

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Chat, nil);
  ToolbarAtBottom(en_Chat);
  PublishOp(en_Edit, op_Delete, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Delete, True);
  ShowInToolbar(en_Edit, op_Delete, False);
  PublishOp(en_Chat, op_History, Chat_History_Execute, nil, nil);
  ShowInContextMenu(en_Chat, op_History, False);
  ShowInToolbar(en_Chat, op_History, True);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  ShowInContextMenu(en_Result, op_OkExt, False);
  ShowInToolbar(en_Result, op_OkExt, True);
 end;//with Entities.Entities
end;//TBaseChatWindowOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseChatWindowOptionsForm);
 {* Регистрация BaseChatWindowOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
