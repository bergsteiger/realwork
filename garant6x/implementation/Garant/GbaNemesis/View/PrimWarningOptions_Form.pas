unit PrimWarningOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimWarningOptions_Form.pas"
// Начат: 02.09.2010 13:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Warning::PrimWarningOptions
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
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimWarning_Form,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimWarningOptionsForm = {form} class(TPrimWarningForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   procedure Warning_TimeMachineOffAndReset_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_TimeMachineOffAndReset_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Warning_ActualRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_ActualRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Warning_TimeMachineOff_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_TimeMachineOff_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function MakePreview: IafwComplexDocumentPreview;
 end;//TPrimWarningOptionsForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwFacade,
  nsTypes,
  Base_Operations_Strange_Controls,
  nsDocInfoHAFMacroReplacer
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  evFormatHAFMacroReplacer,
  Common_Strange_Controls,
  WarningUserTypes_Warning_UserType
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimWarningOptionsForm

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

{$If not defined(NoVCM)}
procedure TPrimWarningOptionsForm.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWarningOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_4C7F738D033Eexec_var*
//#UC END# *495220DE0298_4C7F738D033Eexec_var*
begin
//#UC START# *495220DE0298_4C7F738D033Eexec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(MakePreview);
//#UC END# *495220DE0298_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWarningOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_4C7F738D033Eexec_var*
//#UC END# *495220F2033A_4C7F738D033Eexec_var*
begin
//#UC START# *495220F2033A_4C7F738D033Eexec_impl*
 TdmStdRes.MakePreview(MakePreview);
//#UC END# *495220F2033A_4C7F738D033Eexec_impl*
end;//TPrimWarningOptionsForm.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

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
  Aggregate.Operation(TdmStdRes.opcode_Redactions_ActualRedaction);
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

{$If not defined(NoVCM)}
procedure TPrimWarningOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4C7F738D033E_var*
//#UC END# *497469C90140_4C7F738D033E_var*
begin
//#UC START# *497469C90140_4C7F738D033E_impl*
 inherited;
//#UC END# *497469C90140_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

procedure TPrimWarningOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Warning, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, File_Print_Execute, nil, nil);
  ShowInContextMenu(en_File, op_Print, true);
  ShowInToolbar(en_File, op_Print, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, nil, nil);
  ShowInContextMenu(en_File, op_PrintDialog, true);
  ShowInToolbar(en_File, op_PrintDialog, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, nil, nil);
  ShowInContextMenu(en_File, op_PrintPreview, true);
  ShowInToolbar(en_File, op_PrintPreview, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_Warning, op_TimeMachineOffAndReset, Warning_TimeMachineOffAndReset_Execute, Warning_TimeMachineOffAndReset_Test, nil);
  ShowInContextMenu(en_Warning, op_TimeMachineOffAndReset, true);
  ShowInToolbar(en_Warning, op_TimeMachineOffAndReset, true);
  PublishOp(en_Warning, op_ActualRedaction, Warning_ActualRedaction_Execute, Warning_ActualRedaction_Test, nil);
  ShowInContextMenu(en_Warning, op_ActualRedaction, true);
  ShowInToolbar(en_Warning, op_ActualRedaction, false);
  PublishOp(en_Warning, op_TimeMachineOff, Warning_TimeMachineOff_Execute, Warning_TimeMachineOff_Test, nil);
  ShowInContextMenu(en_Warning, op_TimeMachineOff, true);
  ShowInToolbar(en_Warning, op_TimeMachineOff, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimWarningOptions
 TtfwClassRef.Register(TPrimWarningOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.