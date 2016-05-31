{$IfNDef UnderControlResetter_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControlResetter.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "UnderControlResetter" MUID: (4BA0A2CC0305)
// Имя типа: "_UnderControlResetter_"

{$Define UnderControlResetter_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _UnderControlResetter_ = {abstract} class(_UnderControlResetter_Parent_)
  protected
   ucpUnderControl: IucpUnderControl;
  protected
   procedure CheckControllableState(aInspect: TnsDropControlStatusSet);
   function CanUnControl: Boolean; virtual; abstract;
   procedure UpdateUnderControlList;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_UnderControlResetter_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_UnderControlResetter_ = _UnderControlResetter_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else UnderControlResetter_imp}

{$IfNDef UnderControlResetter_imp_impl}

{$Define UnderControlResetter_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _UnderControlResetter_.CheckControllableState(aInspect: TnsDropControlStatusSet);
//#UC START# *4BA0A3BC028F_4BA0A2CC0305_var*
var
 l_Action : Il3CString;
//#UC END# *4BA0A3BC028F_4BA0A2CC0305_var*
begin
//#UC START# *4BA0A3BC028F_4BA0A2CC0305_impl*
 // Сбрасываем только если документ открыли в основной области
 if Assigned(ucpUnderControl) and CanUnControl and ucpUnderControl.HasControlStatus then
 begin
  l_Action := afw.Settings.LoadString(pi_DropChangeStatus, dv_DropChangeStatus);
  if (dcsAfterReview in aInspect) and
   // - cбрасывать автоматически при открытии
   l3Same(l_Action, li_DropChangeStatus_OnOpen) then
  begin
   ucpUnderControl.ClearControlStatus;
   UpdateUnderControlList;
   // - обновим список документов на контроле (CQ: 00019007)
  end//if l3Same(l_Action, li_DropChangeStatus1) then
  else
  if (dcsExitFromSystem in aInspect) and
     l3Same(l_Action, li_DropChangeStatus_OnClose) then
   // - сбрасывать для всех просмотренных при выходе из системы
   TdmStdRes.MarkControlledAsOpen(ucpUnderControl.Controllable);
 end;//Assigned(ucpUnderControl) and CanUnControl and ucpUnderControl.HasControlStatus
//#UC END# *4BA0A3BC028F_4BA0A2CC0305_impl*
end;//_UnderControlResetter_.CheckControllableState

procedure _UnderControlResetter_.UpdateUnderControlList;
//#UC START# *4BA0B0F4001D_4BA0A2CC0305_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *4BA0B0F4001D_4BA0A2CC0305_var*
begin
//#UC START# *4BA0B0F4001D_4BA0A2CC0305_impl*
 NativeMainForm.HasForm(fm_enUnderControl.rFormID, vcm_ztAny, True, @l_Form);
 if Assigned(l_Form) then
 try
  op_ControlCenter_Refresh.Call(l_Form);
 finally
  l_Form := nil;
 end;{try..finally}
//#UC END# *4BA0B0F4001D_4BA0A2CC0305_impl*
end;//_UnderControlResetter_.UpdateUnderControlList

procedure _UnderControlResetter_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4BA0A2CC0305_var*
//#UC END# *479731C50290_4BA0A2CC0305_var*
begin
//#UC START# *479731C50290_4BA0A2CC0305_impl*
 CheckControllableState([dcsAfterReview]);
 inherited;
//#UC END# *479731C50290_4BA0A2CC0305_impl*
end;//_UnderControlResetter_.Cleanup

{$If NOT Defined(NoVCM)}
procedure _UnderControlResetter_.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4BA0A2CC0305_var*
//#UC END# *497469C90140_4BA0A2CC0305_var*
begin
//#UC START# *497469C90140_4BA0A2CC0305_impl*
 inherited;
 CheckControllableState([dcsExitFromSystem]);
//#UC END# *497469C90140_4BA0A2CC0305_impl*
end;//_UnderControlResetter_.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function _UnderControlResetter_.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
//#UC START# *49806ED503D5_4BA0A2CC0305_var*
//#UC END# *49806ED503D5_4BA0A2CC0305_var*
begin
//#UC START# *49806ED503D5_4BA0A2CC0305_impl*
 Result := inherited DoSaveState(theState, aStateType, aForClone);
 if (aStateType = vcm_stContent) then
  CheckControllableState([dcsAfterReview]);
//#UC END# *49806ED503D5_4BA0A2CC0305_impl*
end;//_UnderControlResetter_.DoSaveState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _UnderControlResetter_.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  ucpUnderControl := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IucpUnderControl, ucpUnderControl);
 end;//aNew = nil
end;//_UnderControlResetter_.SignalDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf UnderControlResetter_imp_impl}

{$EndIf UnderControlResetter_imp}

