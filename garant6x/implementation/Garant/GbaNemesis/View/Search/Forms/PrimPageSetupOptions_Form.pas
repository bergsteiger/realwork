unit PrimPageSetupOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimPageSetupOptions_Form.pas"
// Начат: 09.09.2010 16:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimPageSetupOptions
//
// Настройка страницы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimPageSetup_Form,
  Search_Strange_Controls,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TPrimPageSetupOptionsForm = {form} class(TPrimPageSetupForm)
  {* Настройка страницы }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure Result_Restore_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_Restore_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Result_SaveAsDefault_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_SaveAsDefault_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
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
   procedure ColontitulMacro_AppTitle_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_DocName_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_DocFullName_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_DocRedactionDate_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_DocCurrentPage_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_DocPagesCount_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_CurrentDate_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_CurrentTime_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_InternalDocNumber_Test(const aParams: IvcmTestParamsPrim);
   procedure ColontitulMacro_InternalDocNumber_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_DocumentSIze_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure ColontitulMacro_FilePosition_Test(const aParams: IvcmTestParamsPrim);
   procedure ColontitulMacro_FilePosition_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // protected methods
   procedure Save(SaveAsDefault: Boolean = False); virtual; abstract;
   procedure SetPageFormat(aOrientation: Integer); virtual; abstract;
   procedure MacroAdd(const aString: AnsiString); virtual; abstract;
   procedure ToGUIColontituls; virtual; abstract;
 end;//TPrimPageSetupOptionsForm

 TvcmEntityFormRef = TPrimPageSetupOptionsForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  evHAFPainterMacros
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TPrimPageSetupOptionsForm

procedure TPrimPageSetupOptionsForm.Result_Restore_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52B34E0125_4C88D233003Etest_var*
//#UC END# *4C52B34E0125_4C88D233003Etest_var*
begin
//#UC START# *4C52B34E0125_4C88D233003Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_PageSetup.Modified or f_PageSetup.IsDifferFromDefault;
//#UC END# *4C52B34E0125_4C88D233003Etest_impl*
end;//TPrimPageSetupOptionsForm.Result_Restore_Test

procedure TPrimPageSetupOptionsForm.Result_Restore_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52B34E0125_4C88D233003Eexec_var*
//#UC END# *4C52B34E0125_4C88D233003Eexec_var*
begin
//#UC START# *4C52B34E0125_4C88D233003Eexec_impl*
 if not Ask(qr_RestoreDefaultValuesPageSetup) then
  Exit;
 f_PageSetup.Load(True); 
 ToGUIColontituls;
 ToGUIMargins;
 with f_PageSetup do
  Self.SetPageFormat(Orientation);
//#UC END# *4C52B34E0125_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.Result_Restore_Execute

procedure TPrimPageSetupOptionsForm.Result_SaveAsDefault_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52B36B01B3_4C88D233003Etest_var*
//#UC END# *4C52B36B01B3_4C88D233003Etest_var*
begin
//#UC START# *4C52B36B01B3_4C88D233003Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not f_PageSetup.IsPredefined and (f_PageSetup.Modified or f_PageSetup.IsDifferFromDefault);
//#UC END# *4C52B36B01B3_4C88D233003Etest_impl*
end;//TPrimPageSetupOptionsForm.Result_SaveAsDefault_Test

procedure TPrimPageSetupOptionsForm.Result_SaveAsDefault_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52B36B01B3_4C88D233003Eexec_var*
//#UC END# *4C52B36B01B3_4C88D233003Eexec_var*
begin
//#UC START# *4C52B36B01B3_4C88D233003Eexec_impl*
 if not Ask(qr_SaveAsDefaultValuesPageSetup) then
  Exit;
 Save(True);
//#UC END# *4C52B36B01B3_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.Result_SaveAsDefault_Execute

{$If not defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C762A1501FC_4C88D233003Etest_var*
//#UC END# *4C762A1501FC_4C88D233003Etest_var*
begin
//#UC START# *4C762A1501FC_4C88D233003Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_PageSetup.Modified;
//#UC END# *4C762A1501FC_4C88D233003Etest_impl*
end;//TPrimPageSetupOptionsForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762A1501FC_4C88D233003Eexec_var*
//#UC END# *4C762A1501FC_4C88D233003Eexec_var*
begin
//#UC START# *4C762A1501FC_4C88D233003Eexec_impl*
 Save;
 ModalResult := mrOk;
//#UC END# *4C762A1501FC_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762C910358_4C88D233003Eexec_var*
//#UC END# *4C762C910358_4C88D233003Eexec_var*
begin
//#UC START# *4C762C910358_4C88D233003Eexec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762C910358_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

procedure TPrimPageSetupOptionsForm.ColontitulMacro_AppTitle_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D40C0029_4C88D233003Eexec_var*
//#UC END# *4C88D40C0029_4C88D233003Eexec_var*
begin
//#UC START# *4C88D40C0029_4C88D233003Eexec_impl*
 MacroAdd(SAppTitle);
//#UC END# *4C88D40C0029_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_AppTitle_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_DocName_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D42001C2_4C88D233003Eexec_var*
//#UC END# *4C88D42001C2_4C88D233003Eexec_var*
begin
//#UC START# *4C88D42001C2_4C88D233003Eexec_impl*
 MacroAdd(SDocName);
//#UC END# *4C88D42001C2_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_DocName_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_DocFullName_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D43300C7_4C88D233003Eexec_var*
//#UC END# *4C88D43300C7_4C88D233003Eexec_var*
begin
//#UC START# *4C88D43300C7_4C88D233003Eexec_impl*
 MacroAdd(SDocFullName);
//#UC END# *4C88D43300C7_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_DocFullName_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_DocRedactionDate_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D44401B5_4C88D233003Eexec_var*
//#UC END# *4C88D44401B5_4C88D233003Eexec_var*
begin
//#UC START# *4C88D44401B5_4C88D233003Eexec_impl*
 MacroAdd(SDocRedactionDate);
//#UC END# *4C88D44401B5_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_DocRedactionDate_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_DocCurrentPage_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D46203BD_4C88D233003Eexec_var*
//#UC END# *4C88D46203BD_4C88D233003Eexec_var*
begin
//#UC START# *4C88D46203BD_4C88D233003Eexec_impl*
 MacroAdd(SDocCurrentPage);
//#UC END# *4C88D46203BD_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_DocCurrentPage_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_DocPagesCount_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D4770266_4C88D233003Eexec_var*
//#UC END# *4C88D4770266_4C88D233003Eexec_var*
begin
//#UC START# *4C88D4770266_4C88D233003Eexec_impl*
 MacroAdd(SDocPagesCount);
//#UC END# *4C88D4770266_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_DocPagesCount_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_CurrentDate_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D48B0325_4C88D233003Eexec_var*
//#UC END# *4C88D48B0325_4C88D233003Eexec_var*
begin
//#UC START# *4C88D48B0325_4C88D233003Eexec_impl*
 MacroAdd(SCurrentDate);
//#UC END# *4C88D48B0325_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_CurrentDate_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_CurrentTime_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D4A6032C_4C88D233003Eexec_var*
//#UC END# *4C88D4A6032C_4C88D233003Eexec_var*
begin
//#UC START# *4C88D4A6032C_4C88D233003Eexec_impl*
 MacroAdd(SCurrentTime);
//#UC END# *4C88D4A6032C_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_CurrentTime_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_InternalDocNumber_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C88D4BF0213_4C88D233003Etest_var*
//#UC END# *4C88D4BF0213_4C88D233003Etest_var*
begin
//#UC START# *4C88D4BF0213_4C88D233003Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4C88D4BF0213_4C88D233003Etest_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_InternalDocNumber_Test

procedure TPrimPageSetupOptionsForm.ColontitulMacro_InternalDocNumber_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D4BF0213_4C88D233003Eexec_var*
//#UC END# *4C88D4BF0213_4C88D233003Eexec_var*
begin
//#UC START# *4C88D4BF0213_4C88D233003Eexec_impl*
 MacroAdd(SInternalNumber);
//#UC END# *4C88D4BF0213_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_InternalDocNumber_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_DocumentSIze_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D4D202BA_4C88D233003Eexec_var*
//#UC END# *4C88D4D202BA_4C88D233003Eexec_var*
begin
//#UC START# *4C88D4D202BA_4C88D233003Eexec_impl*
 MacroAdd(SDataSize);
//#UC END# *4C88D4D202BA_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_DocumentSIze_Execute

procedure TPrimPageSetupOptionsForm.ColontitulMacro_FilePosition_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C88D4E8007C_4C88D233003Etest_var*
//#UC END# *4C88D4E8007C_4C88D233003Etest_var*
begin
//#UC START# *4C88D4E8007C_4C88D233003Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4C88D4E8007C_4C88D233003Etest_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_FilePosition_Test

procedure TPrimPageSetupOptionsForm.ColontitulMacro_FilePosition_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C88D4E8007C_4C88D233003Eexec_var*
//#UC END# *4C88D4E8007C_4C88D233003Eexec_var*
begin
//#UC START# *4C88D4E8007C_4C88D233003Eexec_impl*
 MacroAdd(SFilePosition);
//#UC END# *4C88D4E8007C_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.ColontitulMacro_FilePosition_Execute

procedure TPrimPageSetupOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_ColontitulMacro, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, nil, nil, nil);
  ShowInContextMenu(en_File, op_Print, false);
  ShowInToolbar(en_File, op_Print, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, nil, nil, nil);
  ShowInContextMenu(en_File, op_PrintDialog, false);
  ShowInToolbar(en_File, op_PrintDialog, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, nil, nil, nil);
  ShowInContextMenu(en_File, op_PrintPreview, false);
  ShowInToolbar(en_File, op_PrintPreview, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_Result, op_Restore, Result_Restore_Execute, Result_Restore_Test, nil);
  ShowInContextMenu(en_Result, op_Restore, false);
  ShowInToolbar(en_Result, op_Restore, true);
  PublishOp(en_Result, op_SaveAsDefault, Result_SaveAsDefault_Execute, Result_SaveAsDefault_Test, nil);
  ShowInContextMenu(en_Result, op_SaveAsDefault, false);
  ShowInToolbar(en_Result, op_SaveAsDefault, true);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, nil);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_ColontitulMacro, op_AppTitle, ColontitulMacro_AppTitle_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_AppTitle, true);
  ShowInToolbar(en_ColontitulMacro, op_AppTitle, false);
  PublishOp(en_ColontitulMacro, op_DocName, ColontitulMacro_DocName_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocName, true);
  ShowInToolbar(en_ColontitulMacro, op_DocName, false);
  PublishOp(en_ColontitulMacro, op_DocFullName, ColontitulMacro_DocFullName_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocFullName, true);
  ShowInToolbar(en_ColontitulMacro, op_DocFullName, true);
  PublishOp(en_ColontitulMacro, op_DocRedactionDate, ColontitulMacro_DocRedactionDate_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocRedactionDate, true);
  ShowInToolbar(en_ColontitulMacro, op_DocRedactionDate, false);
  PublishOp(en_ColontitulMacro, op_DocCurrentPage, ColontitulMacro_DocCurrentPage_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocCurrentPage, true);
  ShowInToolbar(en_ColontitulMacro, op_DocCurrentPage, false);
  PublishOp(en_ColontitulMacro, op_DocPagesCount, ColontitulMacro_DocPagesCount_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocPagesCount, true);
  ShowInToolbar(en_ColontitulMacro, op_DocPagesCount, false);
  PublishOp(en_ColontitulMacro, op_CurrentDate, ColontitulMacro_CurrentDate_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_CurrentDate, true);
  ShowInToolbar(en_ColontitulMacro, op_CurrentDate, false);
  PublishOp(en_ColontitulMacro, op_CurrentTime, ColontitulMacro_CurrentTime_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_CurrentTime, true);
  ShowInToolbar(en_ColontitulMacro, op_CurrentTime, false);
  PublishOp(en_ColontitulMacro, op_InternalDocNumber, ColontitulMacro_InternalDocNumber_Execute, ColontitulMacro_InternalDocNumber_Test, nil);
  ShowInContextMenu(en_ColontitulMacro, op_InternalDocNumber, true);
  ShowInToolbar(en_ColontitulMacro, op_InternalDocNumber, false);
  PublishOp(en_ColontitulMacro, op_DocumentSIze, ColontitulMacro_DocumentSIze_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocumentSIze, true);
  ShowInToolbar(en_ColontitulMacro, op_DocumentSIze, false);
  PublishOp(en_ColontitulMacro, op_FilePosition, ColontitulMacro_FilePosition_Execute, ColontitulMacro_FilePosition_Test, nil);
  ShowInContextMenu(en_ColontitulMacro, op_FilePosition, true);
  ShowInToolbar(en_ColontitulMacro, op_FilePosition, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimPageSetupOptions
 TtfwClassRef.Register(TPrimPageSetupOptionsForm);
{$IfEnd} //not Admin AND not NoScripts

end.