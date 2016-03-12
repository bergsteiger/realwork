unit PrimQueryCardOptions_Form;
 {* Карточка запросов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCardOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
;

type
 TPrimQueryCardOptionsForm = class(TPrimQueryCardForm)
  {* Карточка запросов }
  public
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure SubPanelSettings_ShowSpecial_Test(const aParams: IvcmTestParamsPrim);
    {* Показывать спецсимволы }
   procedure SubPanelSettings_ShowSpecial_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Показывать спецсимволы }
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimQueryCardOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , DataAdapter
 , SysUtils
 , nsQueryInterfaces
 , evControlParaTools
 , l3String
 , evControlParaConst
 , evQueryCardInt
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4C87C62302CFtest_var*
//#UC END# *49521D8E0295_4C87C62302CFtest_var*
begin
//#UC START# *49521D8E0295_4C87C62302CFtest_impl*
 File_PrintPreview_Test(aParams);
 {$IFDEF Monitorings}
 if aParams.Op.Flag[vcm_ofEnabled] then
  if (afw.Application = nil) OR (afw.Application.PrintManager = nil) OR
     not afw.Application.PrintManager.CanPrint then
   aParams.Op.Flag[vcm_ofEnabled] := false;
 {$ENDIF Monitorings}
//#UC END# *49521D8E0295_4C87C62302CFtest_impl*
end;//TPrimQueryCardOptionsForm.File_Print_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
 {* Вставка }
//#UC START# *49EDFA3701B0_4C87C62302CFtest_var*
var
 l_Control : IevCustomEditorControl;
//#UC END# *49EDFA3701B0_4C87C62302CFtest_var*
begin
//#UC START# *49EDFA3701B0_4C87C62302CFtest_impl*
 if aParams.CallControl and aParams.Op.Flag[vcm_ofEnabled] then
 begin
  l_Control := evGetCustomControl(Editor.Selection.Cursor.MostInner.Obj^.AsObject);
  aParams.Op.Flag[vcm_ofEnabled] := Assigned(l_Control) and
   l_Control.Visible and (l_Control.ControlType in evEditControls);
 end;
//#UC END# *49EDFA3701B0_4C87C62302CFtest_impl*
end;//TPrimQueryCardOptionsForm.Edit_Paste_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *49EDFCA2006D_4C87C62302CFtest_var*
var
 l_CustControl: IevCustomEditorControl;
 l_Control: IevEditorControl;
//#UC END# *49EDFCA2006D_4C87C62302CFtest_var*
begin
//#UC START# *49EDFCA2006D_4C87C62302CFtest_impl*
 if aParams.CallControl and aParams.Op.Flag[vcm_ofEnabled] then
 begin
  l_CustControl := evGetCustomControl(Editor.Selection.Cursor.MostInner.Obj^.AsObject);
  aParams.Op.Flag[vcm_ofEnabled] := Assigned(l_CustControl)
                                and l_CustControl.Visible
                                and (l_CustControl.ControlType in evEditControls);
  if Supports(l_CustControl, IevEditorControl, l_Control) then
   aParams.Op.Flag[vcm_ofEnabled] := aParams.Op.Flag[vcm_ofEnabled] and l_Control.Enabled;
 end;
//#UC END# *49EDFCA2006D_4C87C62302CFtest_impl*
end;//TPrimQueryCardOptionsForm.Edit_Undo_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
 {* Возврат }
//#UC START# *49EDFCB100BC_4C87C62302CFtest_var*
var
 l_CustControl: IevCustomEditorControl;
 l_Control: IevEditorControl;
//#UC END# *49EDFCB100BC_4C87C62302CFtest_var*
begin
//#UC START# *49EDFCB100BC_4C87C62302CFtest_impl*
 if aParams.CallControl and aParams.Op.Flag[vcm_ofEnabled] then
 begin
  l_CustControl := evGetCustomControl(Editor.Selection.Cursor.MostInner.Obj^.AsObject);
  aParams.Op.Flag[vcm_ofEnabled] := Assigned(l_CustControl)
                                and l_CustControl.Visible
                                and (l_CustControl.ControlType in evEditControls);
  if Supports(l_CustControl, IevEditorControl, l_Control) then
   aParams.Op.Flag[vcm_ofEnabled] := aParams.Op.Flag[vcm_ofEnabled] and l_Control.Enabled;
 end;
//#UC END# *49EDFCB100BC_4C87C62302CFtest_impl*
end;//TPrimQueryCardOptionsForm.Edit_Redo_Test
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimQueryCardOptionsForm.SubPanelSettings_ShowSpecial_Test(const aParams: IvcmTestParamsPrim);
 {* Показывать спецсимволы }
//#UC START# *4A7C18B20241_4C87C62302CFtest_var*
//#UC END# *4A7C18B20241_4C87C62302CFtest_var*
begin
//#UC START# *4A7C18B20241_4C87C62302CFtest_impl*
 aParams.Op.Flag[vcm_ofVisible] := DefDataAdapter.IsInternal;
 aParams.Op.Flag[vcm_ofChecked] := Editor.Canvas.DrawSpecial;
//#UC END# *4A7C18B20241_4C87C62302CFtest_impl*
end;//TPrimQueryCardOptionsForm.SubPanelSettings_ShowSpecial_Test

procedure TPrimQueryCardOptionsForm.SubPanelSettings_ShowSpecial_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Показывать спецсимволы }
//#UC START# *4A7C18B20241_4C87C62302CFexec_var*
//#UC END# *4A7C18B20241_4C87C62302CFexec_var*
begin
//#UC START# *4A7C18B20241_4C87C62302CFexec_impl*
 Editor.Canvas.DrawSpecial := not Editor.Canvas.DrawSpecial;
//#UC END# *4A7C18B20241_4C87C62302CFexec_impl*
end;//TPrimQueryCardOptionsForm.SubPanelSettings_ShowSpecial_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C87C62302CFtest_var*
var
 l_Control : IevCustomEditorControl;
 l_Field   : IevEditorControlField; 
//#UC END# *4C7D0C7B0185_4C87C62302CFtest_var*
begin
//#UC START# *4C7D0C7B0185_4C87C62302CFtest_impl*
 if aParams.CallControl and aParams.Op.Flag[vcm_ofEnabled] then
 begin
  l_Control := evGetCustomControl(Editor.Selection.Cursor.MostInner.Obj^.AsObject);
  if (l_Control <> nil) and l_Control.Visible then
   aParams.Op.Flag[vcm_ofEnabled] := (l_Control.ControlType in evEditControls)
    and Supports(l_Control, IevEditorControlField, l_Field)
    and not l_Field.IsFieldEmpty;
 end;//if Assigned(f_MgrSearch) then
//#UC END# *4C7D0C7B0185_4C87C62302CFtest_impl*
end;//TPrimQueryCardOptionsForm.Edit_Copy_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C87C62302CFtest_var*
var
 l_Req: IqaReq; 

 function lp_CheckPanel: Boolean;
 begin//lp_CheckPanel
  aParams.Op.Flag[vcm_ofEnabled] := (evIsFieldSet(f_MgrSearch.GetCurrentField, true) or
   (l_Req.EditorReq.FieldsCount > 1));
  Result := True;
 end;//lp_CheckPanel

 function lp_CheckDatePanel : Boolean;
 begin
  Result := Supports(l_Req, IqaDateReq);
  if Result then
   aParams.Op.Flag[vcm_ofEnabled] := evIsSomeFieldFilled(f_MgrSearch.GetCurrentField.Req, true);
 end;

 function lp_CheckPhonePanel : Boolean;
 var
  l_PhoneReq : IqaPhoneReq;
 begin
  Result := Supports(l_Req, IqaPhoneReq, l_PhoneReq);
  if Result then
   aParams.Op.Flag[vcm_ofEnabled] := not l3IsNil(l_PhoneReq.Code) or
    not l3IsNil(l_PhoneReq.Number);
 end;

 function lp_CheckMemoPanel : Boolean;
 var
  l_Button  : IevEditorControlButton;
 begin
  Result := l_Req.EditorReq.FirstField.ControlType in evSimpleEditors;
  if Result then
  begin
   l_Button := f_MgrSearch.GetCurrentField.FindButton(ev_btDelete);
   if (l_Button <> nil) then
    aParams.Op.Flag[vcm_ofEnabled] := l_Button.Visible
   else
    aParams.Op.Flag[vcm_ofEnabled] := not l_Req.EditorReq.FirstField.IsFieldEmpty;
  end;//Result
 end;

//#UC END# *4C7D0CC90052_4C87C62302CFtest_var*
begin
//#UC START# *4C7D0CC90052_4C87C62302CFtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
 if Assigned(f_MgrSearch) then
 begin
  l_Req := f_MgrSearch.GetCurrentReq;
  if l_Req <> nil then
   (* Атрибутов выбор диапазона дат *)
   if not lp_CheckDatePanel then
   (* Телефон *)
    if not lp_CheckPhonePanel then
    (* Панель строковый атрибут *)
     if not lp_CheckMemoPanel then
     (* Словарный атрибут *)
      lp_CheckPanel;
 end;//if Assigned(f_MgrSearch) then   
//#UC END# *4C7D0CC90052_4C87C62302CFtest_impl*
end;//TPrimQueryCardOptionsForm.Edit_Delete_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimQueryCardOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C87C62302CFexec_var*
//#UC END# *4C7D0CC90052_4C87C62302CFexec_var*
begin
//#UC START# *4C7D0CC90052_4C87C62302CFexec_impl*
 if Assigned(f_MgrSearch) then
  f_MgrSearch.DeleteValue(Editor.View);
//#UC END# *4C7D0CC90052_4C87C62302CFexec_impl*
end;//TPrimQueryCardOptionsForm.Edit_Delete_Execute
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimQueryCardOptionsForm);
 {* Регистрация PrimQueryCardOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
