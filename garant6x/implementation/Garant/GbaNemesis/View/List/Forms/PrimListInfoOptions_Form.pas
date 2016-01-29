unit PrimListInfoOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/PrimListInfoOptions_Form.pas"
// Начат: 09.09.2010 15:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::PrimListInfoOptions
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
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimListInfo_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimListInfoOptionsForm = {form} class(TPrimListInfoForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
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
 end;//TPrimListInfoOptionsForm

 TvcmEntityFormRef = TPrimListInfoOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwInterfaces,
  afwFacade
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimListInfoOptionsForm

{$If not defined(NoVCM)}
procedure TPrimListInfoOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4951284902BD_4C88CB3E009Ctest_var*
//#UC END# *4951284902BD_4C88CB3E009Ctest_var*
begin
//#UC START# *4951284902BD_4C88CB3E009Ctest_impl*
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4951284902BD_4C88CB3E009Ctest_impl*
end;//TPrimListInfoOptionsForm.Edit_Copy_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListInfoOptionsForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4951284902BD_4C88CB3E009Cexec_var*
//#UC END# *4951284902BD_4C88CB3E009Cexec_var*
begin
//#UC START# *4951284902BD_4C88CB3E009Cexec_impl*
 aParams.CallControl;
//#UC END# *4951284902BD_4C88CB3E009Cexec_impl*
end;//TPrimListInfoOptionsForm.Edit_Copy_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListInfoOptionsForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49521D8E0295_4C88CB3E009Ctest_var*
//#UC END# *49521D8E0295_4C88CB3E009Ctest_var*
begin
//#UC START# *49521D8E0295_4C88CB3E009Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *49521D8E0295_4C88CB3E009Ctest_impl*
end;//TPrimListInfoOptionsForm.File_Print_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListInfoOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_4C88CB3E009Cexec_var*
//#UC END# *495220DE0298_4C88CB3E009Cexec_var*
begin
//#UC START# *495220DE0298_4C88CB3E009Cexec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(MakePreview);
//#UC END# *495220DE0298_4C88CB3E009Cexec_impl*
end;//TPrimListInfoOptionsForm.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListInfoOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_4C88CB3E009Cexec_var*
//#UC END# *495220F2033A_4C88CB3E009Cexec_var*
begin
//#UC START# *495220F2033A_4C88CB3E009Cexec_impl*
 TdmStdRes.MakePreview(MakePreview);
//#UC END# *495220F2033A_4C88CB3E009Cexec_impl*
end;//TPrimListInfoOptionsForm.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

procedure TPrimListInfoOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  ShowInContextMenu(en_Edit, op_Copy, true);
  ShowInToolbar(en_Edit, op_Copy, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, nil, File_Print_Test, nil);
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

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, true);
  ShowInToolbar(en_Edit, op_Paste, false);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimListInfoOptions
 TtfwClassRef.Register(TPrimListInfoOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.