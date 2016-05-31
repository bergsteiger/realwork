unit PrimPageSetupOptions_Form;
 {* Настройка страницы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetupOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimPageSetupOptions" MUID: (4C88D233003E)
// Имя типа: "TPrimPageSetupOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPageSetup_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimPageSetupOptionsForm = class(TPrimPageSetupForm)
  {* Настройка страницы }
  protected
   procedure Save(SaveAsDefault: Boolean = False); virtual; abstract;
   procedure SetPageFormat(aOrientation: Integer); virtual; abstract;
   procedure MacroAdd(const aString: AnsiString); virtual; abstract;
   procedure ToGUIColontituls; virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Result_Restore_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_Restore_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Result_SaveAsDefault_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_SaveAsDefault_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
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
 end;//TPrimPageSetupOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , evHAFPainterMacros
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C88D233003Eimpl_uses*
 //#UC END# *4C88D233003Eimpl_uses*
;

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

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4C88D233003Etest_var*
//#UC END# *4C762A1501FC_4C88D233003Etest_var*
begin
//#UC START# *4C762A1501FC_4C88D233003Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := f_PageSetup.Modified;
//#UC END# *4C762A1501FC_4C88D233003Etest_impl*
end;//TPrimPageSetupOptionsForm.Result_Ok_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4C88D233003Eexec_var*
//#UC END# *4C762A1501FC_4C88D233003Eexec_var*
begin
//#UC START# *4C762A1501FC_4C88D233003Eexec_impl*
 Save;
 ModalResult := mrOk;
//#UC END# *4C762A1501FC_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.Result_Ok_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4C88D233003Eexec_var*
//#UC END# *4C762C910358_4C88D233003Eexec_var*
begin
//#UC START# *4C762C910358_4C88D233003Eexec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762C910358_4C88D233003Eexec_impl*
end;//TPrimPageSetupOptionsForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

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

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_ColontitulMacro, nil);
  PublishOp(en_File, op_Print, nil, nil, nil);
  ShowInContextMenu(en_File, op_Print, False);
  ShowInToolbar(en_File, op_Print, True);
  PublishOp(en_File, op_PrintDialog, nil, nil, nil);
  ShowInContextMenu(en_File, op_PrintDialog, False);
  ShowInToolbar(en_File, op_PrintDialog, True);
  PublishOp(en_File, op_PrintPreview, nil, nil, nil);
  ShowInContextMenu(en_File, op_PrintPreview, False);
  ShowInToolbar(en_File, op_PrintPreview, True);
  PublishOp(en_Result, op_Restore, Result_Restore_Execute, Result_Restore_Test, nil);
  ShowInContextMenu(en_Result, op_Restore, False);
  ShowInToolbar(en_Result, op_Restore, True);
  PublishOp(en_Result, op_SaveAsDefault, Result_SaveAsDefault_Execute, Result_SaveAsDefault_Test, nil);
  ShowInContextMenu(en_Result, op_SaveAsDefault, False);
  ShowInToolbar(en_Result, op_SaveAsDefault, True);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, nil);
  ShowInContextMenu(en_Result, op_Ok, False);
  ShowInToolbar(en_Result, op_Ok, True);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  PublishOp(en_ColontitulMacro, op_AppTitle, ColontitulMacro_AppTitle_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_AppTitle, True);
  ShowInToolbar(en_ColontitulMacro, op_AppTitle, False);
  PublishOp(en_ColontitulMacro, op_DocName, ColontitulMacro_DocName_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocName, True);
  ShowInToolbar(en_ColontitulMacro, op_DocName, False);
  PublishOp(en_ColontitulMacro, op_DocFullName, ColontitulMacro_DocFullName_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocFullName, True);
  ShowInToolbar(en_ColontitulMacro, op_DocFullName, True);
  PublishOp(en_ColontitulMacro, op_DocRedactionDate, ColontitulMacro_DocRedactionDate_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocRedactionDate, True);
  ShowInToolbar(en_ColontitulMacro, op_DocRedactionDate, False);
  PublishOp(en_ColontitulMacro, op_DocCurrentPage, ColontitulMacro_DocCurrentPage_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocCurrentPage, True);
  ShowInToolbar(en_ColontitulMacro, op_DocCurrentPage, False);
  PublishOp(en_ColontitulMacro, op_DocPagesCount, ColontitulMacro_DocPagesCount_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocPagesCount, True);
  ShowInToolbar(en_ColontitulMacro, op_DocPagesCount, False);
  PublishOp(en_ColontitulMacro, op_CurrentDate, ColontitulMacro_CurrentDate_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_CurrentDate, True);
  ShowInToolbar(en_ColontitulMacro, op_CurrentDate, False);
  PublishOp(en_ColontitulMacro, op_CurrentTime, ColontitulMacro_CurrentTime_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_CurrentTime, True);
  ShowInToolbar(en_ColontitulMacro, op_CurrentTime, False);
  PublishOp(en_ColontitulMacro, op_InternalDocNumber, ColontitulMacro_InternalDocNumber_Execute, ColontitulMacro_InternalDocNumber_Test, nil);
  ShowInContextMenu(en_ColontitulMacro, op_InternalDocNumber, True);
  ShowInToolbar(en_ColontitulMacro, op_InternalDocNumber, False);
  PublishOp(en_ColontitulMacro, op_DocumentSIze, ColontitulMacro_DocumentSIze_Execute, nil, nil);
  ShowInContextMenu(en_ColontitulMacro, op_DocumentSIze, True);
  ShowInToolbar(en_ColontitulMacro, op_DocumentSIze, False);
  PublishOp(en_ColontitulMacro, op_FilePosition, ColontitulMacro_FilePosition_Execute, ColontitulMacro_FilePosition_Test, nil);
  ShowInContextMenu(en_ColontitulMacro, op_FilePosition, True);
  ShowInToolbar(en_ColontitulMacro, op_FilePosition, False);
 end;//with Entities.Entities
end;//TPrimPageSetupOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPageSetupOptionsForm);
 {* Регистрация PrimPageSetupOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
