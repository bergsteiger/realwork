unit PrimRedactionsOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimRedactionsOptions_Form.pas"
// Начат: 07.09.2010 15:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Redactions::PrimRedactionsOptions
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
  PrimRedactions_Form,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimRedactionsOptionsForm = {form} class(TPrimRedactionsForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   procedure Edition_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Edition_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Edition_OpenNewTab_Test(const aParams: IvcmTestParamsPrim);
   procedure Edition_OpenNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimRedactionsOptionsForm

 TvcmEntityFormRef = TPrimRedactionsOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Common_Strange_Controls,
  DocumentUserTypes_dftDocument_UserType
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimRedactionsOptionsForm

{$If not defined(NoVCM)}
procedure TPrimRedactionsOptionsForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7880236_4C86253E00C5test_var*
//#UC END# *4BDAF7880236_4C86253E00C5test_var*
begin
//#UC START# *4BDAF7880236_4C86253E00C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Tree_ExpandAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimRedactionsOptionsForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7A2005C_4C86253E00C5test_var*
//#UC END# *4BDAF7A2005C_4C86253E00C5test_var*
begin
//#UC START# *4BDAF7A2005C_4C86253E00C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Tree_CollapseAll_Test
{$IfEnd} //not NoVCM

procedure TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C862614021C_4C86253E00C5test_var*
//#UC END# *4C862614021C_4C86253E00C5test_var*
begin
//#UC START# *4C862614021C_4C86253E00C5test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsModalForm;
//#UC END# *4C862614021C_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Test

procedure TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C862614021C_4C86253E00C5exec_var*
//#UC END# *4C862614021C_4C86253E00C5exec_var*
begin
//#UC START# *4C862614021C_4C86253E00C5exec_impl*
 Op_Document_CommonDocumentOpenNewWindow.Call(Aggregate, dftDocument);
//#UC END# *4C862614021C_4C86253E00C5exec_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewWindow_Execute

procedure TPrimRedactionsOptionsForm.Edition_OpenNewTab_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *55544CF2027E_4C86253E00C5test_var*
//#UC END# *55544CF2027E_4C86253E00C5test_var*
begin
//#UC START# *55544CF2027E_4C86253E00C5test_impl*
 Edition_OpenNewWindow_Test(aParams);
//#UC END# *55544CF2027E_4C86253E00C5test_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewTab_Test

procedure TPrimRedactionsOptionsForm.Edition_OpenNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *55544CF2027E_4C86253E00C5exec_var*
//#UC END# *55544CF2027E_4C86253E00C5exec_var*
begin
//#UC START# *55544CF2027E_4C86253E00C5exec_impl*
 Op_Document_CommonDocumentOpenNewTab.Call(Aggregate, dftDocument);
//#UC END# *55544CF2027E_4C86253E00C5exec_impl*
end;//TPrimRedactionsOptionsForm.Edition_OpenNewTab_Execute

procedure TPrimRedactionsOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_Edition, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_Wrap, nil, nil, nil);
  {$IfEnd} //not NoVCM

  PublishOp(en_Edition, op_OpenNewWindow, Edition_OpenNewWindow_Execute, Edition_OpenNewWindow_Test, nil);
  ShowInContextMenu(en_Edition, op_OpenNewWindow, true);
  ShowInToolbar(en_Edition, op_OpenNewWindow, false);
  ContextMenuWeight(en_Edition, op_OpenNewWindow, 20);
  PublishOp(en_Edition, op_OpenNewTab, Edition_OpenNewTab_Execute, Edition_OpenNewTab_Test, nil);
  ShowInContextMenu(en_Edition, op_OpenNewTab, true);
  ContextMenuWeight(en_Edition, op_OpenNewTab, 10);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimRedactionsOptions
 TtfwClassRef.Register(TPrimRedactionsOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.