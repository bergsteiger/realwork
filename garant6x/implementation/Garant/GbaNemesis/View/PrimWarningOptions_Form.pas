unit PrimWarningOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarningOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimWarningOptions" MUID: (4C7F738D033E)
// Имя типа: "TPrimWarningOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarning_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Document_Strange_Controls
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimWarningOptionsForm = class(TPrimWarningForm)
  protected
   function MakePreview: IafwComplexDocumentPreview;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Warning_TimeMachineOffAndReset_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_TimeMachineOffAndReset_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Warning_ActualRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_ActualRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Warning_TimeMachineOff_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_TimeMachineOff_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimWarningOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , nsTypes
 , Base_Operations_Strange_Controls
 , nsDocInfoHAFMacroReplacer
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , evFormatHAFMacroReplacer
 , Common_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , WarningUserTypes_Warning_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C7F738D033Eimpl_uses*
 , Search_Services
 //#UC END# *4C7F738D033Eimpl_uses*
;

function TPrimWarningOptionsForm.MakePreview: IafwComplexDocumentPreview;
//#UC START# *4C7F77A50276_4C7F738D033E_var*
var
 l_HAF: IafwHAFMacroReplacer;
//#UC END# *4C7F77A50276_4C7F738D033E_var*
begin
//#UC START# *4C7F77A50276_4C7F738D033E_impl*
 if (ViewArea <> nil) then
  l_HAF := TnsDocInfoHAFMacroReplacer.Make(nil, ViewArea.DocInfo)
 else
  l_HAF := nil;
 Result := Viewer.Preview(TevFormatHAFMacroReplacer.Make(l_HAF, vcmCStr(str_WarningTitle)));
//#UC END# *4C7F77A50276_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.MakePreview

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4C7F738D033Eexec_var*
var
 l_Preview : IafwComplexDocumentPreview;
//#UC END# *49521D8E0295_4C7F738D033Eexec_var*
begin
//#UC START# *49521D8E0295_4C7F738D033Eexec_impl*
 l_Preview := MakePreview;
 if (l_Preview <> nil) then
  l_Preview.Print;
//#UC END# *49521D8E0295_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.File_Print_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_4C7F738D033Eexec_var*
//#UC END# *495220DE0298_4C7F738D033Eexec_var*
begin
//#UC START# *495220DE0298_4C7F738D033Eexec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(MakePreview);
//#UC END# *495220DE0298_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.File_PrintDialog_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C7F738D033Eexec_var*
//#UC END# *495220F2033A_4C7F738D033Eexec_var*
begin
//#UC START# *495220F2033A_4C7F738D033Eexec_impl*
 TPrintingService.Instance.MakePreview(MakePreview);
//#UC END# *495220F2033A_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.File_PrintPreview_Execute
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimWarningOptionsForm.Warning_TimeMachineOffAndReset_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F753E02BC_4C7F738D033Etest_var*
//#UC END# *4C7F753E02BC_4C7F738D033Etest_var*
begin
//#UC START# *4C7F753E02BC_4C7F738D033Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (wtTimeMachineWarning in ViewArea.WarningContent) or
                                  (wtNotSure in ViewArea.WarningContent);
//#UC END# *4C7F753E02BC_4C7F738D033Etest_impl*
end;//TPrimWarningOptionsForm.Warning_TimeMachineOffAndReset_Test

procedure TPrimWarningOptionsForm.Warning_TimeMachineOffAndReset_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F753E02BC_4C7F738D033Eexec_var*
//#UC END# *4C7F753E02BC_4C7F738D033Eexec_var*
begin
//#UC START# *4C7F753E02BC_4C7F738D033Eexec_impl*
 op_TimeMachine_TimeMachineOffAndReset.Call(Aggregate);
//#UC END# *4C7F753E02BC_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.Warning_TimeMachineOffAndReset_Execute

procedure TPrimWarningOptionsForm.Warning_ActualRedaction_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F7552010A_4C7F738D033Etest_var*
//#UC END# *4C7F7552010A_4C7F738D033Etest_var*
begin
//#UC START# *4C7F7552010A_4C7F738D033Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := wtNotActualEdition in ViewArea.WarningContent;
//#UC END# *4C7F7552010A_4C7F738D033Etest_impl*
end;//TPrimWarningOptionsForm.Warning_ActualRedaction_Test

procedure TPrimWarningOptionsForm.Warning_ActualRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F7552010A_4C7F738D033Eexec_var*
//#UC END# *4C7F7552010A_4C7F738D033Eexec_var*
begin
//#UC START# *4C7F7552010A_4C7F738D033Eexec_impl*
 if (Aggregate <> nil) then
  Aggregate.Operation(opcode_Redactions_ActualRedaction);
//#UC END# *4C7F7552010A_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.Warning_ActualRedaction_Execute

procedure TPrimWarningOptionsForm.Warning_TimeMachineOff_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F75660342_4C7F738D033Etest_var*
//#UC END# *4C7F75660342_4C7F738D033Etest_var*
begin
//#UC START# *4C7F75660342_4C7F738D033Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (wtTimeMachineWarning in ViewArea.WarningContent) or
                                  (wtNotSure in ViewArea.WarningContent);
//#UC END# *4C7F75660342_4C7F738D033Etest_impl*
end;//TPrimWarningOptionsForm.Warning_TimeMachineOff_Test

procedure TPrimWarningOptionsForm.Warning_TimeMachineOff_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F75660342_4C7F738D033Eexec_var*
//#UC END# *4C7F75660342_4C7F738D033Eexec_var*
begin
//#UC START# *4C7F75660342_4C7F738D033Eexec_impl*
 op_TimeMachine_TimeMachineOnOff.Call(Aggregate);
//#UC END# *4C7F75660342_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.Warning_TimeMachineOff_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4C7F738D033E_var*
//#UC END# *497469C90140_4C7F738D033E_var*
begin
//#UC START# *497469C90140_4C7F738D033E_impl*
 inherited;
//#UC END# *497469C90140_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Warning, nil);
  PublishOp(en_File, op_Print, File_Print_Execute, nil, nil);
  ShowInContextMenu(en_File, op_Print, True);
  ShowInToolbar(en_File, op_Print, False);
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, nil, nil);
  ShowInContextMenu(en_File, op_PrintDialog, True);
  ShowInToolbar(en_File, op_PrintDialog, False);
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, nil, nil);
  ShowInContextMenu(en_File, op_PrintPreview, True);
  ShowInToolbar(en_File, op_PrintPreview, False);
  PublishOp(en_Warning, op_TimeMachineOffAndReset, Warning_TimeMachineOffAndReset_Execute, Warning_TimeMachineOffAndReset_Test, nil);
  ShowInContextMenu(en_Warning, op_TimeMachineOffAndReset, True);
  ShowInToolbar(en_Warning, op_TimeMachineOffAndReset, True);
  PublishOp(en_Warning, op_ActualRedaction, Warning_ActualRedaction_Execute, Warning_ActualRedaction_Test, nil);
  ShowInContextMenu(en_Warning, op_ActualRedaction, True);
  ShowInToolbar(en_Warning, op_ActualRedaction, False);
  PublishOp(en_Warning, op_TimeMachineOff, Warning_TimeMachineOff_Execute, Warning_TimeMachineOff_Test, nil);
  ShowInContextMenu(en_Warning, op_TimeMachineOff, True);
  ShowInToolbar(en_Warning, op_TimeMachineOff, False);
 end;//with Entities.Entities
end;//TPrimWarningOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWarningOptionsForm);
 {* Регистрация PrimWarningOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
