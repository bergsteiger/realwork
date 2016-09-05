unit PrimListInfoOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListInfoOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimListInfoOptions" MUID: (4C88CB3E009C)
// Имя типа: "TPrimListInfoOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimListInfo_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimListInfoOptionsForm = class(TPrimListInfoForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
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
 end;//TPrimListInfoOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwInterfaces
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C88CB3E009Cimpl_uses*
 , Search_Services
 //#UC END# *4C88CB3E009Cimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать }
//#UC START# *4951284902BD_4C88CB3E009Ctest_var*
//#UC END# *4951284902BD_4C88CB3E009Ctest_var*
begin
//#UC START# *4951284902BD_4C88CB3E009Ctest_impl*
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4951284902BD_4C88CB3E009Ctest_impl*
end;//TPrimListInfoOptionsForm.Edit_Copy_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Копировать }
//#UC START# *4951284902BD_4C88CB3E009Cexec_var*
//#UC END# *4951284902BD_4C88CB3E009Cexec_var*
begin
//#UC START# *4951284902BD_4C88CB3E009Cexec_impl*
 aParams.CallControl;
//#UC END# *4951284902BD_4C88CB3E009Cexec_impl*
end;//TPrimListInfoOptionsForm.Edit_Copy_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4C88CB3E009Ctest_var*
//#UC END# *49521D8E0295_4C88CB3E009Ctest_var*
begin
//#UC START# *49521D8E0295_4C88CB3E009Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *49521D8E0295_4C88CB3E009Ctest_impl*
end;//TPrimListInfoOptionsForm.File_Print_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_4C88CB3E009Cexec_var*
//#UC END# *495220DE0298_4C88CB3E009Cexec_var*
begin
//#UC START# *495220DE0298_4C88CB3E009Cexec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(MakePreview);
//#UC END# *495220DE0298_4C88CB3E009Cexec_impl*
end;//TPrimListInfoOptionsForm.File_PrintDialog_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C88CB3E009Cexec_var*
//#UC END# *495220F2033A_4C88CB3E009Cexec_var*
begin
//#UC START# *495220F2033A_4C88CB3E009Cexec_impl*
 TPrintingService.Instance.MakePreview(MakePreview);
//#UC END# *495220F2033A_4C88CB3E009Cexec_impl*
end;//TPrimListInfoOptionsForm.File_PrintPreview_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListInfoOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  ShowInContextMenu(en_Edit, op_Copy, True);
  ShowInToolbar(en_Edit, op_Copy, False);
  PublishOp(en_File, op_Print, nil, File_Print_Test, nil);
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, nil, nil);
  ShowInContextMenu(en_File, op_PrintDialog, True);
  ShowInToolbar(en_File, op_PrintDialog, False);
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, nil, nil);
  ShowInContextMenu(en_File, op_PrintPreview, True);
  ShowInToolbar(en_File, op_PrintPreview, False);
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, True);
  ShowInToolbar(en_Edit, op_Paste, False);
 end;//with Entities.Entities
end;//TPrimListInfoOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListInfoOptionsForm);
 {* Регистрация PrimListInfoOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
