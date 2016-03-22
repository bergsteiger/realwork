{$IfNDef vcmComponentDestroyer_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmComponentDestroyer.imp.pas"
// Стереотип: "GUIControlMixIn"
// Элемент модели: "vcmComponentDestroyer" MUID: (53BFC8CF0329)
// Имя типа: "_vcmComponentDestroyer_"

{$Define vcmComponentDestroyer_imp}

{$If NOT Defined(NoVCM)}
 _vcmComponentDestroyer_ = class(_vcmComponentDestroyer_Parent_)
  private
   procedure vcmMsgClearPopup(var aMessage: TMessage); message vcm_msgClearPopup;
   procedure vcmMsgCloseChildForm(var aMessage: TMessage); message vcm_MsgCloseChildForm;
   procedure vcmMsgFreeComponent(var aMessage: TMessage); message vcm_msgFreeComponent;
 end;//_vcmComponentDestroyer_

{$Else NOT Defined(NoVCM)}

_vcmComponentDestroyer_ = _vcmComponentDestroyer_Parent_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmComponentDestroyer_imp}

{$IfNDef vcmComponentDestroyer_imp_impl}

{$Define vcmComponentDestroyer_imp_impl}

{$If NOT Defined(NoVCM)}
procedure _vcmComponentDestroyer_.vcmMsgClearPopup(var aMessage: TMessage);
//#UC START# *53BFCB9A00F4_53BFC8CF0329_var*
//#UC END# *53BFCB9A00F4_53BFC8CF0329_var*
begin
//#UC START# *53BFCB9A00F4_53BFC8CF0329_impl*
 if (aMessage.LParam <> 0) then
 begin
  TPopupMenu(aMessage.LParam).Items.Clear;
  {$IfDef vcmExportHelp}
  if (TPopupMenu(aMessage.LParam) Is TvcmPopupMenu) then
   TvcmPopupMenu(aMessage.LParam).ClearInPopup;
  {$EndIf}
  if (TPopupMenu(aMessage.LParam).Owner = nil) then
  begin
   //Assert(false, 'А такое бывает, что контекстное меню ни к кому не привязано?');
   // - бывает для TvcmButtonPopupMenu - тесты не прошли
   TPopupMenu(aMessage.LParam).Free;
  end;//TPopupMenu(aMessage.LParam).Owner = nil
 end;//Message.LParam <> 0
//#UC END# *53BFCB9A00F4_53BFC8CF0329_impl*
end;//_vcmComponentDestroyer_.vcmMsgClearPopup

procedure _vcmComponentDestroyer_.vcmMsgCloseChildForm(var aMessage: TMessage);
//#UC START# *53BFCBF50125_53BFC8CF0329_var*
//#UC END# *53BFCBF50125_53BFC8CF0329_var*
begin
//#UC START# *53BFCBF50125_53BFC8CF0329_impl*
 if (aMessage.LParam <> 0) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=425036429
  if TvcmSlayedEntityFormsList.Instance.IndexOf(TvcmEntityForm(aMessage.LParam)) >= 0 then
   TvcmInterfacedForm(aMessage.LParam).KillMe;
//#UC END# *53BFCBF50125_53BFC8CF0329_impl*
end;//_vcmComponentDestroyer_.vcmMsgCloseChildForm

procedure _vcmComponentDestroyer_.vcmMsgFreeComponent(var aMessage: TMessage);
//#UC START# *53BFCC34005D_53BFC8CF0329_var*
//#UC END# *53BFCC34005D_53BFC8CF0329_var*
begin
//#UC START# *53BFCC34005D_53BFC8CF0329_impl*
 if (aMessage.LParam <> 0) then
 begin
  if (Dispatcher = nil) OR not Dispatcher.InOp then
   FreeAndNil(TObject(aMessage.LParam))
  else
   Dispatcher.AddObjectForFree(TObject(aMessage.LParam));
 end;//aMessage.LParam <> 0
//#UC END# *53BFCC34005D_53BFC8CF0329_impl*
end;//_vcmComponentDestroyer_.vcmMsgFreeComponent
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmComponentDestroyer_imp_impl}

{$EndIf vcmComponentDestroyer_imp}

