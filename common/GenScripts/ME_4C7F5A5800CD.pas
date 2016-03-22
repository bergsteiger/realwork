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
;

type
 TPrimFiltersOptionsForm = class(TPrimFiltersForm)
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
   procedure Filters_InternalClear(const aParams: IvcmExecuteParamsPrim);
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
  TdmStdRes.MakeNewFilter(l_Tree.FiltersType)
 else
  TdmStdRes.MakeNewFilter(bs_ltDocument);
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
 TdmStdRes.EditFilter(l_Data, aParams.ItemIndex);
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
  TdmStdRes.RenameFilter(l_Filter);
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

procedure TPrimFiltersOptionsForm.Filters_InternalClear(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Filters_InternalClear_Execute;
end;//TPrimFiltersOptionsForm.Filters_InternalClear

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFiltersOptionsForm);
 {* Регистрация PrimFiltersOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
