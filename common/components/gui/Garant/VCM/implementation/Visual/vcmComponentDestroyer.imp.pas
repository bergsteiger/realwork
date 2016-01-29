{$IfNDef vcmComponentDestroyer_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmComponentDestroyer.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GUIControlMixIn::Class>> Shared Delphi::VCM$Visual::Visual::vcmComponentDestroyer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmComponentDestroyer_imp}
{$If not defined(NoVCM)}
 _vcmComponentDestroyer_ = {mixin} class(_vcmComponentDestroyer_Parent_)
 private
 // private methods
   procedure VcmMsgClearPopup(var aMessage: TMessage); message vcm_msgClearPopup;
   procedure VcmMsgCloseChildForm(var aMessage: TMessage); message vcm_MsgCloseChildForm;
   procedure VcmMsgFreeComponent(var aMessage: TMessage); message vcm_msgFreeComponent;
 end;//_vcmComponentDestroyer_
{$Else}

 _vcmComponentDestroyer_ = _vcmComponentDestroyer_Parent_;

{$IfEnd} //not NoVCM

{$Else vcmComponentDestroyer_imp}

{$If not defined(NoVCM)}

// start class _vcmComponentDestroyer_

procedure _vcmComponentDestroyer_.VcmMsgClearPopup(var aMessage: TMessage);
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
end;//_vcmComponentDestroyer_.VcmMsgClearPopup

procedure _vcmComponentDestroyer_.VcmMsgCloseChildForm(var aMessage: TMessage);
//#UC START# *53BFCBF50125_53BFC8CF0329_var*
//#UC END# *53BFCBF50125_53BFC8CF0329_var*
begin
//#UC START# *53BFCBF50125_53BFC8CF0329_impl*
 if (aMessage.LParam <> 0) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=425036429
  if TvcmSlayedEntityFormsList.Instance.IndexOf(TvcmEntityForm(aMessage.LParam)) >= 0 then
   TvcmInterfacedForm(aMessage.LParam).KillMe;
//#UC END# *53BFCBF50125_53BFC8CF0329_impl*
end;//_vcmComponentDestroyer_.VcmMsgCloseChildForm

procedure _vcmComponentDestroyer_.VcmMsgFreeComponent(var aMessage: TMessage);
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
end;//_vcmComponentDestroyer_.VcmMsgFreeComponent

{$IfEnd} //not NoVCM

{$EndIf vcmComponentDestroyer_imp}
