unit PrimFiltersOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimFiltersOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimFiltersOptions" MUID: (4C7F5A5800CD)
// Имя типа: "TPrimFiltersOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFilters_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Filters_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimFiltersOptionsForm = class(TPrimFiltersForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
    {* Перенос по словам }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Перенос по словам }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Filters_Clear_Test(const aParams: IvcmTestParamsPrim);
   procedure Filters_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Filters_New_Test(const aParams: IvcmTestParamsPrim);
   procedure Filters_New_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filters_Refresh_Test(const aParams: IvcmTestParamsPrim);
   procedure Filters_Refresh_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filter_Edit_Test(const aParams: IvcmTestParamsPrim);
   procedure Filter_Edit_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filter_PersistentFilter_Test(const aParams: IvcmTestParamsPrim);
   procedure Filter_PersistentFilter_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filter_RenameFilter_Test(const aParams: IvcmTestParamsPrim);
    {* Переименовать }
   procedure Filter_RenameFilter_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Переименовать }
   procedure Filters_InternalClear_Execute;
   procedure Filters_InternalClear(const aParams: IvcmExecuteParams);
 end;//TPrimFiltersOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , eeInterfaces
 , BaseTreeSupportUnit
 , nsFiltersInterfaces
 , SimpleListInterfaces
 , SysUtils
 , nsFolders
 , nsOpenUtils
 , nsUtils
 , nsFolderFilterInfo
 , bsTypes
 , FoldersDomainInterfaces
 , deFilter
 , FiltersUnit
 , l3Tree_TLB
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C7F5A5800CDimpl_uses*
 , Base_Operations_F1Services_Contracts
 //#UC END# *4C7F5A5800CDimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C7F5A5800CDtest_var*
//#UC END# *4BDAF7880236_4C7F5A5800CDtest_var*
begin
//#UC START# *4BDAF7880236_4C7F5A5800CDtest_impl*
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Tree_ExpandAll_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C7F5A5800CDexec_var*
//#UC END# *4BDAF7880236_4C7F5A5800CDexec_var*
begin
//#UC START# *4BDAF7880236_4C7F5A5800CDexec_impl*
 aParams.CallControl;
//#UC END# *4BDAF7880236_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Tree_ExpandAll_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C7F5A5800CDtest_var*
//#UC END# *4BDAF7A2005C_4C7F5A5800CDtest_var*
begin
//#UC START# *4BDAF7A2005C_4C7F5A5800CDtest_impl*
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Tree_CollapseAll_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C7F5A5800CDexec_var*
//#UC END# *4BDAF7A2005C_4C7F5A5800CDexec_var*
begin
//#UC START# *4BDAF7A2005C_4C7F5A5800CDexec_impl*
 aParams.CallControl;
//#UC END# *4BDAF7A2005C_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Tree_CollapseAll_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_4C7F5A5800CDtest_var*
//#UC END# *4BDAF7B803CF_4C7F5A5800CDtest_var*
begin
//#UC START# *4BDAF7B803CF_4C7F5A5800CDtest_impl*
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7B803CF_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Tree_Wrap_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Tree_Wrap_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_4C7F5A5800CDexec_var*
//#UC END# *4BDAF7B803CF_4C7F5A5800CDexec_var*
begin
//#UC START# *4BDAF7B803CF_4C7F5A5800CDexec_impl*
 aParams.CallControl;
//#UC END# *4BDAF7B803CF_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Tree_Wrap_Execute
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFiltersOptionsForm.Filters_Clear_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52AA040095_4C7F5A5800CDtest_var*
//#UC END# *4C52AA040095_4C7F5A5800CDtest_var*
begin
//#UC START# *4C52AA040095_4C7F5A5800CDtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (FiltersList.TreeView.Tree.SelectedCount > 0);
//#UC END# *4C52AA040095_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Filters_Clear_Test

procedure TPrimFiltersOptionsForm.Filters_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52AA040095_4C7F5A5800CDexec_var*
//#UC END# *4C52AA040095_4C7F5A5800CDexec_var*
begin
//#UC START# *4C52AA040095_4C7F5A5800CDexec_impl*
 ClearFilters;
//#UC END# *4C52AA040095_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Filters_Clear_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7F5A5800CDtest_var*
//#UC END# *4C7D0CC90052_4C7F5A5800CDtest_var*
begin
//#UC START# *4C7D0CC90052_4C7F5A5800CDtest_impl*
 Filter_Edit_Test(aParams);
//#UC END# *4C7D0CC90052_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Edit_Delete_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7F5A5800CDexec_var*
var
 l_CurNode: Il3Node;
 l_ConfirmationResult: Boolean;
 l_Node: InsFilterNode;
//#UC END# *4C7D0CC90052_4C7F5A5800CDexec_var*
begin
//#UC START# *4C7D0CC90052_4C7F5A5800CDexec_impl*
 with FiltersList do
 begin
  l_CurNode := CurrentCNode;
  try
   if Supports(l_CurNode, InsFilterNode, l_Node) and l_Node.CanModify then
   begin
    l_ConfirmationResult := Ask(qr_DeleteFilter, [l3CStr(l_CurNode)]);
    if l_ConfirmationResult then
    begin
     //ChangeActiveStatus(FiltersList, l_CurNode, False);  убрано. СМ: http://mdp.garant.ru/pages/viewpage.action?pageId=450293671
     l_CurNode := nil;
     l_Node.MarkToDelete;
    end;//l_ConfirmationResult
   end;
  finally
   l_CurNode := nil;
  end;//try..finally
 end;//with FiltersList
//#UC END# *4C7D0CC90052_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Edit_Delete_Execute
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFiltersOptionsForm.Filters_New_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F5CBD0071_4C7F5A5800CDtest_var*
//#UC END# *4C7F5CBD0071_4C7F5A5800CDtest_var*
begin
//#UC START# *4C7F5CBD0071_4C7F5A5800CDtest_impl*
//#UC END# *4C7F5CBD0071_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Filters_New_Test

procedure TPrimFiltersOptionsForm.Filters_New_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F5CBD0071_4C7F5A5800CDexec_var*
var
 l_Tree: InsFiltersTree;
//#UC END# *4C7F5CBD0071_4C7F5A5800CDexec_var*
begin
//#UC START# *4C7F5CBD0071_4C7F5A5800CDexec_impl*
 if Supports(FiltersList.TreeStruct, InsFiltersTree, l_Tree) then
  TSearchService.Instance.MakeNewFilter(l_Tree.FiltersType)
 else
  TSearchService.Instance.MakeNewFilter(bs_ltDocument);
//#UC END# *4C7F5CBD0071_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Filters_New_Execute

procedure TPrimFiltersOptionsForm.Filters_Refresh_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F5CCB00B3_4C7F5A5800CDtest_var*
//#UC END# *4C7F5CCB00B3_4C7F5A5800CDtest_var*
begin
//#UC START# *4C7F5CCB00B3_4C7F5A5800CDtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (FiltersList.TreeView.Tree.SelectedCount > 0);
//#UC END# *4C7F5CCB00B3_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Filters_Refresh_Test

procedure TPrimFiltersOptionsForm.Filters_Refresh_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F5CCB00B3_4C7F5A5800CDexec_var*
//#UC END# *4C7F5CCB00B3_4C7F5A5800CDexec_var*
begin
//#UC START# *4C7F5CCB00B3_4C7F5A5800CDexec_impl*
 if (Aggregate <> nil) then
  if not op_Filterable_Refresh.Call(Aggregate) then
   if Ask(qr_EmptyListFiltersChanged) then
    ClearFilters;
//#UC END# *4C7F5CCB00B3_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Filters_Refresh_Execute

procedure TPrimFiltersOptionsForm.Filter_Edit_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F5E030232_4C7F5A5800CDtest_var*
var
 l_Filter: InsFilterNode;
//#UC END# *4C7F5E030232_4C7F5A5800CDtest_var*
begin
//#UC START# *4C7F5E030232_4C7F5A5800CDtest_impl*
 with FiltersList.TreeView do
  if Tree.Root.HasChild then
   aParams.Op.Flag[vcm_ofEnabled] := (CurrentNode <> nil) and Supports(CurrentNode, InsFilterNode, l_Filter) and
    l_Filter.CanModify
  else
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C7F5E030232_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Filter_Edit_Test

procedure TPrimFiltersOptionsForm.Filter_Edit_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F5E030232_4C7F5A5800CDexec_var*
var
 l_Data   : IdeFilter;
 l_Filter : IFilterFromQuery;
//#UC END# *4C7F5E030232_4C7F5A5800CDexec_var*
begin
//#UC START# *4C7F5E030232_4C7F5A5800CDexec_impl*
 if (Filters <> nil) then
  l_Data := Filters.OpenFilter(FiltersList.GetCurrentNode)
 else
 if Supports(FiltersList.GetCurrentNode, IFilterFromQuery, l_Filter) then
  l_Data := TdeFilter.Make(l_Filter)
 else
  l_Data := nil;
 TSearchService.Instance.EditFilter(l_Data, aParams.ItemIndex);
//#UC END# *4C7F5E030232_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Filter_Edit_Execute

procedure TPrimFiltersOptionsForm.Filter_PersistentFilter_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7F5E7E01D6_4C7F5A5800CDtest_var*
var
 l_Filter: InsFilterNode;
//#UC END# *4C7F5E7E01D6_4C7F5A5800CDtest_var*
begin
//#UC START# *4C7F5E7E01D6_4C7F5A5800CDtest_impl*
 aParams.Op.Flag[vcm_ofChecked] := Supports(FiltersList.GetCurrentNode,
  InsFilterNode, l_Filter) and l_Filter.AutoApplied;
//#UC END# *4C7F5E7E01D6_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Filter_PersistentFilter_Test

procedure TPrimFiltersOptionsForm.Filter_PersistentFilter_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7F5E7E01D6_4C7F5A5800CDexec_var*
var
 l_Filter: InsFilterNode;
//#UC END# *4C7F5E7E01D6_4C7F5A5800CDexec_var*
begin
//#UC START# *4C7F5E7E01D6_4C7F5A5800CDexec_impl*
 if Supports(FiltersList.GetCurrentNode, InsFilterNode, l_Filter) then
  with l_Filter, FiltersList do
  begin
   Changing;
   try
    AutoApplied := not AutoApplied;
   finally
    Changed;
   end; 
  end;
//#UC END# *4C7F5E7E01D6_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Filter_PersistentFilter_Execute

procedure TPrimFiltersOptionsForm.Filter_RenameFilter_Test(const aParams: IvcmTestParamsPrim);
 {* Переименовать }
//#UC START# *4CB7004603CF_4C7F5A5800CDtest_var*
var
 l_Filter : InsFilterNode;
//#UC END# *4CB7004603CF_4C7F5A5800CDtest_var*
begin
//#UC START# *4CB7004603CF_4C7F5A5800CDtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Supports(FiltersList.GetCurrentNode, InsFilterNode, l_Filter) AND l_Filter.CanModify;
//#UC END# *4CB7004603CF_4C7F5A5800CDtest_impl*
end;//TPrimFiltersOptionsForm.Filter_RenameFilter_Test

procedure TPrimFiltersOptionsForm.Filter_RenameFilter_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Переименовать }
//#UC START# *4CB7004603CF_4C7F5A5800CDexec_var*
var
 l_Filter: IFilterFromQuery;
//#UC END# *4CB7004603CF_4C7F5A5800CDexec_var*
begin
//#UC START# *4CB7004603CF_4C7F5A5800CDexec_impl*
 if Supports(FiltersList.GetCurrentNode, IFilterFromQuery, l_Filter) then
  TFiltersService.Instance.RenameFilter(l_Filter);
//#UC END# *4CB7004603CF_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Filter_RenameFilter_Execute

procedure TPrimFiltersOptionsForm.Filters_InternalClear_Execute;
//#UC START# *4DBA95ED03B7_4C7F5A5800CDexec_var*
//#UC END# *4DBA95ED03B7_4C7F5A5800CDexec_var*
begin
//#UC START# *4DBA95ED03B7_4C7F5A5800CDexec_impl*
 ClearFilters;
//#UC END# *4DBA95ED03B7_4C7F5A5800CDexec_impl*
end;//TPrimFiltersOptionsForm.Filters_InternalClear_Execute

procedure TPrimFiltersOptionsForm.Filters_InternalClear(const aParams: IvcmExecuteParams);
begin
 Self.Filters_InternalClear_Execute;
end;//TPrimFiltersOptionsForm.Filters_InternalClear

{$If NOT Defined(NoVCM)}
procedure TPrimFiltersOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Filters, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_Filter, nil);
  ContextMenuWeight(en_Filter, 30);
  ContextMenuWeight(en_Edit, 20);
  ContextMenuWeight(en_Filters, 10);
  ContextMenuWeight(en_Tree, 40);
  ContextMenuWeight(en_Filters, 10);
  PublishOp(en_Tree, op_ExpandAll, Tree_ExpandAll_Execute, Tree_ExpandAll_Test, nil);
  PublishOp(en_Tree, op_CollapseAll, Tree_CollapseAll_Execute, Tree_CollapseAll_Test, nil);
  PublishOp(en_Tree, op_Wrap, Tree_Wrap_Execute, Tree_Wrap_Test, nil);
  PublishOp(en_Filters, op_Clear, Filters_Clear_Execute, Filters_Clear_Test, nil);
  ShowInContextMenu(en_Filters, op_Clear, True);
  ShowInToolbar(en_Filters, op_Clear, True);
  ContextMenuWeight(en_Filters, op_Clear, 20);
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, nil);
  ShowInContextMenu(en_Edit, op_Delete, True);
  ShowInToolbar(en_Edit, op_Delete, True);
  ContextMenuWeight(en_Edit, op_Delete, -10);
  PublishOp(en_Filters, op_New, Filters_New_Execute, Filters_New_Test, nil);
  ContextMenuWeight(en_Filters, op_New, 10);
  PublishOp(en_Filters, op_Refresh, Filters_Refresh_Execute, Filters_Refresh_Test, nil);
  ContextMenuWeight(en_Filters, op_Refresh, 30);
  PublishOp(en_Filter, op_Activate, nil, nil, nil);
  ShowInContextMenu(en_Filter, op_Activate, True);
  ShowInToolbar(en_Filter, op_Activate, False);
  ContextMenuWeight(en_Filter, op_Activate, 10);
  PublishOp(en_Filter, op_Edit, Filter_Edit_Execute, Filter_Edit_Test, nil);
  ContextMenuWeight(en_Filter, op_Edit, 20);
  PublishOp(en_Filter, op_PersistentFilter, Filter_PersistentFilter_Execute, Filter_PersistentFilter_Test, nil);
  ShowInContextMenu(en_Filter, op_PersistentFilter, True);
  ShowInToolbar(en_Filter, op_PersistentFilter, False);
  ContextMenuWeight(en_Filter, op_PersistentFilter, 30);
  PublishOp(en_Filters, op_FiltersListOpen, nil, nil, nil);
  ShowInContextMenu(en_Filters, op_FiltersListOpen, False);
  ShowInToolbar(en_Filters, op_FiltersListOpen, False);
  ContextMenuWeight(en_Filters, op_FiltersListOpen, 20);
  PublishOp(en_Filter, op_RenameFilter, Filter_RenameFilter_Execute, Filter_RenameFilter_Test, nil);
  ShowInContextMenu(en_Filter, op_RenameFilter, True);
  ContextMenuWeight(en_Filter, op_RenameFilter, 50);
  PublishOpWithResult(en_Filters, op_InternalClear, Filters_InternalClear, nil, nil);
  ShowInContextMenu(en_Filter, op_CreateFilter, True);
  ShowInToolbar(en_Filter, op_CreateFilter, False);
  ContextMenuWeight(en_Filter, op_CreateFilter, 40);
 end;//with Entities.Entities
end;//TPrimFiltersOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFiltersOptionsForm);
 {* Регистрация PrimFiltersOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
