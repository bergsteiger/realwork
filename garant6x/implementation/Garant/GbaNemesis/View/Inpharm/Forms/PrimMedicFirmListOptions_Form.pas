unit PrimMedicFirmListOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicFirmListOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimMedicFirmListOptions" MUID: (4C7E3A320074)
// Имя типа: "TPrimMedicFirmListOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicFirmList_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Strange_Controls
 , Inpharm_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimMedicFirmListOptionsForm = class(TPrimMedicFirmListForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
    {* Добавить закладку }
   procedure Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Добавить закладку }
   {$If NOT Defined(NoVCM)}
   procedure Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
    {* Перенос по словам }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Перенос по словам }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Document_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure MedicFirmList_CountryFilter_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicFirmList_CountryFilter_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_OpenInNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimMedicFirmListOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsUtils
 , afwFacade
 , nsTypes
 , l3TreeInterfaces
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C7E3A320074impl_uses*
 , Base_Operations_F1Services_Contracts
 //#UC END# *4C7E3A320074impl_uses*
;

procedure TPrimMedicFirmListOptionsForm.Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
 {* Добавить закладку }
//#UC START# *4989D06D014E_4C7E3A320074test_var*
//#UC END# *4989D06D014E_4C7E3A320074test_var*
begin
//#UC START# *4989D06D014E_4C7E3A320074test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsMedicFirmList) and HasCurrent;
//#UC END# *4989D06D014E_4C7E3A320074test_impl*
end;//TPrimMedicFirmListOptionsForm.Document_AddBookmark_Test

procedure TPrimMedicFirmListOptionsForm.Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Добавить закладку }
//#UC START# *4989D06D014E_4C7E3A320074exec_var*
//#UC END# *4989D06D014E_4C7E3A320074exec_var*
begin
//#UC START# *4989D06D014E_4C7E3A320074exec_impl*
 dsMedicFirmList.AddBookmark;
//#UC END# *4989D06D014E_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.Document_AddBookmark_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_4C7E3A320074test_var*
//#UC END# *4BDAF7B803CF_4C7E3A320074test_var*
begin
//#UC START# *4BDAF7B803CF_4C7E3A320074test_impl*
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7B803CF_4C7E3A320074test_impl*
end;//TPrimMedicFirmListOptionsForm.Tree_Wrap_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_4C7E3A320074exec_var*
//#UC END# *4BDAF7B803CF_4C7E3A320074exec_var*
begin
//#UC START# *4BDAF7B803CF_4C7E3A320074exec_impl*
 aParams.CallControl;
//#UC END# *4BDAF7B803CF_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.Tree_Wrap_Execute
{$IfEnd} // NOT Defined(NoVCM)

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
   TDocumentService.Instance.OpenDocument(dsMedicFirmList.MakeNewDocInfo, l_Container);
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
   TDocumentService.Instance.OpenDocument(dsMedicFirmList.MakeNewDocInfo, l_Container);
  finally
   l_Container := nil;
  end;
 end;
//#UC END# *54A2AF9C0157_4C7E3A320074exec_impl*
end;//TPrimMedicFirmListOptionsForm.Document_OpenInNewTab_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
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
  PublishOp(en_Edit, op_Cut, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Cut, True);
  ShowInToolbar(en_Edit, op_Cut, False);
  PublishOp(en_Document, op_AddBookmark, Document_AddBookmark_Execute, Document_AddBookmark_Test, nil);
  ContextMenuWeight(en_Document, op_AddBookmark, 30);
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, True);
  ShowInToolbar(en_Edit, op_Paste, False);
  PublishOp(en_Edit, op_Undo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Undo, True);
  ShowInToolbar(en_Edit, op_Undo, False);
  PublishOp(en_Edit, op_Redo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Redo, True);
  ShowInToolbar(en_Edit, op_Redo, False);
  PublishOp(en_Edit, op_SelectAll, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_SelectAll, True);
  ShowInToolbar(en_Edit, op_SelectAll, False);
  PublishOp(en_Edit, op_Deselect, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Deselect, True);
  ShowInToolbar(en_Edit, op_Deselect, False);
  PublishOp(en_Tree, op_Wrap, Tree_Wrap_Execute, Tree_Wrap_Test, nil);
  ContextMenuWeight(en_Tree, op_Wrap, 10);
  PublishOp(en_Document, op_OpenNewWindow, Document_OpenNewWindow_Execute, Document_OpenNewWindow_Test, nil);
  ShowInContextMenu(en_Document, op_OpenNewWindow, True);
  ContextMenuWeight(en_Document, op_OpenNewWindow, 20);
  PublishOp(en_Edit, op_Copy, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Copy, True);
  ShowInToolbar(en_Edit, op_Copy, False);
  PublishOp(en_MedicFirmList, op_CountryFilter, MedicFirmList_CountryFilter_Execute, MedicFirmList_CountryFilter_Test, nil);
  ShowInContextMenu(en_MedicFirmList, op_CountryFilter, False);
  ShowInToolbar(en_MedicFirmList, op_CountryFilter, True);
  PublishOp(en_Document, op_OpenInNewTab, Document_OpenInNewTab_Execute, nil, nil);
  ShowInContextMenu(en_Document, op_OpenInNewTab, True);
  ShowInToolbar(en_Document, op_OpenInNewTab, False);
  ContextMenuWeight(en_Document, op_OpenInNewTab, 10);
 end;//with Entities.Entities
end;//TPrimMedicFirmListOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMedicFirmListOptionsForm);
 {* Регистрация PrimMedicFirmListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
