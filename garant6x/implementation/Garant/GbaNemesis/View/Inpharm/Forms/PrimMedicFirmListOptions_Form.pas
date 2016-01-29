unit PrimMedicFirmListOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/PrimMedicFirmListOptions_Form.pas"
// Начат: 01.09.2010 15:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::PrimMedicFirmListOptions
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
  PrimMedicFirmList_Form,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  Common_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  Inpharm_Strange_Controls,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimMedicFirmListOptionsForm = {form} class(TPrimMedicFirmListForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
     {* Добавить закладку }
   procedure Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Добавить закладку }
   {$If not defined(NoVCM)}
   procedure Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
     {* Перенос по словам }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Перенос по словам }
   {$IfEnd} //not NoVCM
   procedure Document_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure MedicFirmList_CountryFilter_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicFirmList_CountryFilter_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_OpenInNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimMedicFirmListOptionsForm

 TvcmEntityFormRef = TPrimMedicFirmListOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsUtils,
  afwFacade,
  nsTypes,
  l3TreeInterfaces
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimMedicFirmListOptionsForm

procedure TPrimMedicFirmListOptionsForm.Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4989D06D014E_4C7E3A320074test_var*
//#UC END# *4989D06D014E_4C7E3A320074test_var*
begin
//#UC START# *4989D06D014E_4C7E3A320074test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsMedicFirmList) and HasCurrent;
//#UC END# *4989D06D014E_4C7E3A320074test_impl*
end;//TPrimMedicFirmListOptionsForm.Document_AddBookmark_Test

procedure TPrimMedicFirmListOptionsForm.Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4989D06D014E_4C7E3A320074exec_var*
//#UC END# *4989D06D014E_4C7E3A320074exec_var*
begin
//#UC START# *4989D06D014E_4C7E3A320074exec_impl*
 dsMedicFirmList.AddBookmark;
//#UC END# *4989D06D014E_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.Document_AddBookmark_Execute

{$If not defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7B803CF_4C7E3A320074test_var*
//#UC END# *4BDAF7B803CF_4C7E3A320074test_var*
begin
//#UC START# *4BDAF7B803CF_4C7E3A320074test_impl*
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7B803CF_4C7E3A320074test_impl*
end;//TPrimMedicFirmListOptionsForm.Tree_Wrap_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BDAF7B803CF_4C7E3A320074exec_var*
//#UC END# *4BDAF7B803CF_4C7E3A320074exec_var*
begin
//#UC START# *4BDAF7B803CF_4C7E3A320074exec_impl*
 aParams.CallControl;
//#UC END# *4BDAF7B803CF_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.Tree_Wrap_Execute
{$IfEnd} //not NoVCM

procedure TPrimMedicFirmListOptionsForm.Document_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4EAC20007F_4C7E3A320074test_var*
//#UC END# *4C4EAC20007F_4C7E3A320074test_var*
begin
//#UC START# *4C4EAC20007F_4C7E3A320074test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := HasCurrent;
//#UC END# *4C4EAC20007F_4C7E3A320074test_impl*
end;//TPrimMedicFirmListOptionsForm.Document_OpenNewWindow_Test

procedure TPrimMedicFirmListOptionsForm.Document_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4EAC20007F_4C7E3A320074exec_var*
var
 l_Container: IvcmContainer;
//#UC END# *4C4EAC20007F_4C7E3A320074exec_var*
begin
//#UC START# *4C4EAC20007F_4C7E3A320074exec_impl*
 if Assigned(dsMedicFirmList) then
 begin
  // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
  l_Container := nsNewWindow(NativeMainForm);
  if (l_Container <> nil) then
  try
   TdmStdRes.OpenDocument(dsMedicFirmList.MakeNewDocInfo, l_Container);
  finally
   l_Container := nil;
  end;
 end;
//#UC END# *4C4EAC20007F_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.Document_OpenNewWindow_Execute

procedure TPrimMedicFirmListOptionsForm.MedicFirmList_CountryFilter_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E4168031D_4C7E3A320074test_var*
var
 l_List : IvcmNodes;
//#UC END# *4C7E4168031D_4C7E3A320074test_var*
begin
//#UC START# *4C7E4168031D_4C7E3A320074test_impl*
 if Assigned(dsMedicFirmList) then
 begin
  with aParams do
  begin
   l_List := Op.SubNodes;
   if (l_List <> nil) then
   begin
    with l_List do
    begin
     ShowRoot := false;
     Tree := dsMedicFirmList.CountryFilterTree;
     if ((l_List.count = 0)) then
      Add(dsMedicFirmList.CountryFilterTree.RootNode);
     Current := dsMedicFirmList.CurrentCountryFilter;
     Op.SelectedString := nsCStr(dsMedicFirmList.CurrentCountryFilter.Text);
    end;//with l_List do
   end;//l_List <> nil
  end;//with aParams
 end;//if Assigned(CoDS) then
//#UC END# *4C7E4168031D_4C7E3A320074test_impl*
end;//TPrimMedicFirmListOptionsForm.MedicFirmList_CountryFilter_Test

procedure TPrimMedicFirmListOptionsForm.MedicFirmList_CountryFilter_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E4168031D_4C7E3A320074exec_var*
var
 l_TreeSource: Il3SimpleTree;
 l_Current: Integer;
//#UC END# *4C7E4168031D_4C7E3A320074exec_var*
begin
//#UC START# *4C7E4168031D_4C7E3A320074exec_impl*
 with ListTree do
 begin
  l_TreeSource := dsMedicFirmList.FiltrateByCountry(TreeStruct, GetCurrentNode,
   aParams.CurrentNode, l_Current);
  if Assigned(l_TreeSource) then
  begin
   Changing;
   try
    ContextFilter.BeginAssignState;
    try
     TreeStruct := l_TreeSource;
    finally
     ContextFilter.EndAssignState;
    end;
    vlbMakeItemVisible(Current);
   finally
    Changed;
   end;{try..finally}
  end;
 end;
//#UC END# *4C7E4168031D_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.MedicFirmList_CountryFilter_Execute

procedure TPrimMedicFirmListOptionsForm.Document_OpenInNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *54A2AF9C0157_4C7E3A320074exec_var*
var
 l_Container: IvcmContainer;
//#UC END# *54A2AF9C0157_4C7E3A320074exec_var*
begin
//#UC START# *54A2AF9C0157_4C7E3A320074exec_impl*
 if Assigned(dsMedicFirmList) then
 begin
  // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
  l_Container := nsNewWindow(NativeMainForm, vcm_okInNewTab);
  if (l_Container <> nil) then
  try
   TdmStdRes.OpenDocument(dsMedicFirmList.MakeNewDocInfo, l_Container);
  finally
   l_Container := nil;
  end;
 end;
//#UC END# *54A2AF9C0157_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.Document_OpenInNewTab_Execute

procedure TPrimMedicFirmListOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Document, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_MedicFirmList, nil);
  ContextMenuWeight(en_Document, 20);
  ContextMenuWeight(en_Tree, 30);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Cut, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Cut, true);
  ShowInToolbar(en_Edit, op_Cut, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_Document, op_AddBookmark, Document_AddBookmark_Execute, Document_AddBookmark_Test, nil);
  ContextMenuWeight(en_Document, op_AddBookmark, 30);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, true);
  ShowInToolbar(en_Edit, op_Paste, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Undo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Undo, true);
  ShowInToolbar(en_Edit, op_Undo, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Redo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Redo, true);
  ShowInToolbar(en_Edit, op_Redo, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_SelectAll, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_SelectAll, true);
  ShowInToolbar(en_Edit, op_SelectAll, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Deselect, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Deselect, true);
  ShowInToolbar(en_Edit, op_Deselect, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_Wrap, Tree_Wrap_Execute, Tree_Wrap_Test, nil);
  ContextMenuWeight(en_Tree, op_Wrap, 10);
  {$IfEnd} //not NoVCM

  PublishOp(en_Document, op_OpenNewWindow, Document_OpenNewWindow_Execute, Document_OpenNewWindow_Test, nil);
  ShowInContextMenu(en_Document, op_OpenNewWindow, true);
  ContextMenuWeight(en_Document, op_OpenNewWindow, 20);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Copy, true);
  ShowInToolbar(en_Edit, op_Copy, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_MedicFirmList, op_CountryFilter, MedicFirmList_CountryFilter_Execute, MedicFirmList_CountryFilter_Test, nil);
  ShowInContextMenu(en_MedicFirmList, op_CountryFilter, false);
  ShowInToolbar(en_MedicFirmList, op_CountryFilter, true);
  PublishOp(en_Document, op_OpenInNewTab, Document_OpenInNewTab_Execute, nil, nil);
  ShowInContextMenu(en_Document, op_OpenInNewTab, true);
  ShowInToolbar(en_Document, op_OpenInNewTab, false);
  ContextMenuWeight(en_Document, op_OpenInNewTab, 10);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimMedicFirmListOptions
 TtfwClassRef.Register(TPrimMedicFirmListOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.