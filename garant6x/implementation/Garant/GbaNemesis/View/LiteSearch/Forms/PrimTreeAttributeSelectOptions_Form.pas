unit PrimTreeAttributeSelectOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelectOptions_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimTreeAttributeSelectOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
  PrimTreeAttributeSelect_Form
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  SearchLite_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

type
 TPrimTreeAttributeSelectOptionsForm = {form} class(TPrimTreeAttributeSelectForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   procedure Attribute_LogicOr_Test(const aParams: IvcmTestParamsPrim);
   procedure Attribute_LogicOr_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Attribute_LogicAnd_Test(const aParams: IvcmTestParamsPrim);
   procedure Attribute_LogicAnd_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Attribute_LogicNot_Test(const aParams: IvcmTestParamsPrim);
   procedure Attribute_LogicNot_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   procedure Attribute_LogicOrShortcut_Test(const aParams: IvcmTestParamsPrim);
   procedure Attribute_LogicOrShortcut_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Selection_DropSelection_Test(const aParams: IvcmTestParamsPrim);
   procedure Selection_DropSelection_Execute(const aParams: IvcmExecuteParamsPrim);
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   function EntitiesenSelectionGetTarget(aControl: TComponent;
     aX: Integer;
     aY: Integer;
     out theTarget: IUnknown): Boolean;
 end;//TPrimTreeAttributeSelectOptionsForm

 TvcmEntityFormRef = TPrimTreeAttributeSelectOptionsForm;

implementation

uses
  DynamicTreeUnit,
  SysUtils,
  SearchDomainInterfaces,
  nsLogicOperationToFlags
  {$If not defined(NoVCM)}
  ,
  vcmBaseOperationsCollectionItem
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimTreeAttributeSelect_astFirstLevel_UserType
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;

// start class TPrimTreeAttributeSelectOptionsForm

function TPrimTreeAttributeSelectOptionsForm.EntitiesenSelectionGetTarget(aControl: TComponent;
  aX: Integer;
  aY: Integer;
  out theTarget: IUnknown): Boolean;
//#UC START# *4F88607901F5_4C443A570168_var*
//#UC END# *4F88607901F5_4C443A570168_var*
begin
//#UC START# *4F88607901F5_4C443A570168_impl*
 // Это нужно для того, чтобы в логических операциях вызывались OnContextTest
 Result := True;
 // Отдавать нужно обязательно так, поэтому что IInterface может умереть не
 // зависимо от IvcmEntityForm
 theTarget := (Self.as_IvcmEntityForm);
//#UC END# *4F88607901F5_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.EntitiesenSelectionGetTarget

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *494F89C30197_4C443A570168test_var*
//#UC END# *494F89C30197_4C443A570168test_var*
begin
//#UC START# *494F89C30197_4C443A570168test_impl*
 if (aParams.Control = AttributeTree) then
  aParams.Op.Flag[vcm_ofVisible] := False
 else
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *494F89C30197_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Edit_Delete_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
//#UC START# *494F89C30197_4C443A570168getstate_var*
//#UC END# *494F89C30197_4C443A570168getstate_var*
begin
//#UC START# *494F89C30197_4C443A570168getstate_impl*
 // - ничего не делаем
//#UC END# *494F89C30197_4C443A570168getstate_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *494F89C30197_4C443A570168exec_var*
var
 l_Current: INodeBase;
//#UC END# *494F89C30197_4C443A570168exec_var*
begin
//#UC START# *494F89C30197_4C443A570168exec_impl*
 if (aParams.Control = AttributeTree) then
 begin
  with AttributeTree do
  begin
   if (TreeStruct.SelectCount > 1) then
   begin
    DropSelectedOperation;
   end//TreeStruct.SelectCount > 1
   else
   if Supports(GetCurrentNode, INodeBase, l_Current) then
   begin
    FormLogicOperation(l_Current, loNone);
    if Current + 1 < TreeStruct.CountView then
     Current := Current + 1;
   end//Supports(GetCurrentNode, INodeBase, l_Current)
   else
    Exit;
   Invalidate;
   InvalidateOtherTree;
  end;//with AttributeTree
 end//aParams.Control = AttributeTree
 else
  aParams.CallControl;
//#UC END# *494F89C30197_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Edit_Delete_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4951284902BD_4C443A570168test_var*
//#UC END# *4951284902BD_4C443A570168test_var*
begin
//#UC START# *4951284902BD_4C443A570168test_impl*
 if aParams.Control = AttributeTree then
  aParams.Op.Flag[vcm_ofEnabled] := False
 else
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4951284902BD_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Edit_Copy_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4951284902BD_4C443A570168exec_var*
//#UC END# *4951284902BD_4C443A570168exec_var*
begin
//#UC START# *4951284902BD_4C443A570168exec_impl*
 if aParams.Control <> AttributeTree then
  aParams.CallControl;
//#UC END# *4951284902BD_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Edit_Copy_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4C443A570168test_var*
//#UC END# *4A97EBE702F8_4C443A570168test_var*
begin
//#UC START# *4A97EBE702F8_4C443A570168test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A97EBE702F8_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4C443A570168exec_var*
//#UC END# *4A97EBE702F8_4C443A570168exec_var*
begin
//#UC START# *4A97EBE702F8_4C443A570168exec_impl*
 (* закроем форму, или начнём поиск *)
 if Assigned(Aggregate) then
  Aggregate.Operation(TdmStdRes.opcode_Result_OkExt);
//#UC END# *4A97EBE702F8_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOr_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AFAFB4602D9_4C443A570168test_var*
//#UC END# *4AFAFB4602D9_4C443A570168test_var*
begin
//#UC START# *4AFAFB4602D9_4C443A570168test_impl*
 //LOToolbarTest(aParams, loOr);
 LogicOperationTest(aParams, loOr);
//#UC END# *4AFAFB4602D9_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOr_Test

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOr_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AFAFB4602D9_4C443A570168exec_var*
var
 l_Node: INodeBase;
//#UC END# *4AFAFB4602D9_4C443A570168exec_var*
begin
//#UC START# *4AFAFB4602D9_4C443A570168exec_impl*
 if (AttributeTree.TreeStruct.SelectCount <= 1) and
    (AttributeTree.Current >= 0) then
 begin
  if Supports(AttributeTree.GetCurrentNode, INodeBase, l_Node) then
   FormLogicOperation(l_Node, loOr);
 end
 else
  if f_OrState then
   DropSelectedOperation
  else
   ChangeOperationOnSelected(loOr);
 AttributeTree.Invalidate;
 InvalidateOtherTree;
//#UC END# *4AFAFB4602D9_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOr_Execute

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicAnd_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AFAFB5800B9_4C443A570168test_var*
//#UC END# *4AFAFB5800B9_4C443A570168test_var*
begin
//#UC START# *4AFAFB5800B9_4C443A570168test_impl*
 //LOToolbarTest(aParams, loAnd);
 LogicOperationTest(aParams, loAnd);
//#UC END# *4AFAFB5800B9_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicAnd_Test

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicAnd_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AFAFB5800B9_4C443A570168exec_var*
var
 l_Node: INodeBase;
//#UC END# *4AFAFB5800B9_4C443A570168exec_var*
begin
//#UC START# *4AFAFB5800B9_4C443A570168exec_impl*
 if (AttributeTree.TreeStruct.SelectCount <= 1) and
    (AttributeTree.Current >= 0) then
 begin
  if Supports(AttributeTree.GetCurrentNode, INodeBase, l_Node) then
   FormLogicOperation(l_Node, loAnd);
 end
 else
  if f_AndState then
   DropSelectedOperation
  else
   ChangeOperationOnSelected(loAnd);
 AttributeTree.Invalidate;
 InvalidateOtherTree;
//#UC END# *4AFAFB5800B9_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicAnd_Execute

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicNot_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AFAFB7002B5_4C443A570168test_var*
//#UC END# *4AFAFB7002B5_4C443A570168test_var*
begin
//#UC START# *4AFAFB7002B5_4C443A570168test_impl*
 //LOToolbarTest(aParams, loNot);
 LogicOperationTest(aParams, loNot);
//#UC END# *4AFAFB7002B5_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicNot_Test

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicNot_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AFAFB7002B5_4C443A570168exec_var*
var
 l_Node: INodeBase;
//#UC END# *4AFAFB7002B5_4C443A570168exec_var*
begin
//#UC START# *4AFAFB7002B5_4C443A570168exec_impl*
 if (AttributeTree.TreeStruct.SelectCount <= 1) and
    (AttributeTree.Current >= 0) then
 begin
  if Supports(AttributeTree.GetCurrentNode, INodeBase, l_Node) then
   FormLogicOperation(AttributeTree.GetCurrentNode as INodeBase, loNot);
 end
 else
  if f_NotState then
   DropSelectedOperation
  else
   ChangeOperationOnSelected(loNot);
 AttributeTree.Invalidate;
 InvalidateOtherTree; 
//#UC END# *4AFAFB7002B5_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicNot_Execute

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7880236_4C443A570168test_var*
//#UC END# *4BDAF7880236_4C443A570168test_var*
begin
//#UC START# *4BDAF7880236_4C443A570168test_impl*
 if UserType = astFirstLevel then
  aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4BDAF7880236_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Tree_ExpandAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimTreeAttributeSelectOptionsForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7A2005C_4C443A570168test_var*
//#UC END# *4BDAF7A2005C_4C443A570168test_var*
begin
//#UC START# *4BDAF7A2005C_4C443A570168test_impl*
 if UserType = astFirstLevel then
  aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4BDAF7A2005C_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Tree_CollapseAll_Test
{$IfEnd} //not NoVCM

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOrShortcut_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C44444E0066_4C443A570168test_var*
//#UC END# *4C44444E0066_4C443A570168test_var*
begin
//#UC START# *4C44444E0066_4C443A570168test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4C44444E0066_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOrShortcut_Test

procedure TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOrShortcut_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C44444E0066_4C443A570168exec_var*
var
 l_Current: INodeBase;
 l_OldOp: TLogicOperation;
//#UC END# *4C44444E0066_4C443A570168exec_var*
begin
//#UC START# *4C44444E0066_4C443A570168exec_impl*
 with AttributeTree do
 begin
  if (TreeStruct.SelectCount > 1) then
  begin
   ChangeOperationOnSelected(loOr);
  end//TreeStruct.SelectCount > 1
  else
  if Supports(GetCurrentNode, INodeBase, l_Current) then
  begin
   l_OldOp := GetLogicOperation(l_Current);
   if (l_OldOp = loNone) then
   begin
    if not l_Current.HasFilteredChildren then
     SetLogicOperation(l_Current, loOr);
    NotifyOperationChange(l_Current, l_OldOp, loOr);
   end;//l_OldOp = loNone
   if Current + 1 < TreeStruct.CountView then
    Current := Current + 1;
  end//Supports(GetCurrentNode, INodeBase, l_Current)
  else
   Exit;
  Invalidate;
  InvalidateOtherTree;
 end;//with AttributeTree
//#UC END# *4C44444E0066_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Attribute_LogicOrShortcut_Execute

procedure TPrimTreeAttributeSelectOptionsForm.Selection_DropSelection_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4445300216_4C443A570168test_var*
//#UC END# *4C4445300216_4C443A570168test_var*
begin
//#UC START# *4C4445300216_4C443A570168test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := AttributeTree.TreeStruct.SelectCount >= 1;
//#UC END# *4C4445300216_4C443A570168test_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Selection_DropSelection_Test

procedure TPrimTreeAttributeSelectOptionsForm.Selection_DropSelection_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4445300216_4C443A570168exec_var*
//#UC END# *4C4445300216_4C443A570168exec_var*
begin
//#UC START# *4C4445300216_4C443A570168exec_impl*
 DropSelectedOperation;
 AttributeTree.Invalidate;
 InvalidateOtherTree;
//#UC END# *4C4445300216_4C443A570168exec_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Selection_DropSelection_Execute

constructor TPrimTreeAttributeSelectOptionsForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4C443A570168_var*
//#UC END# *47D1602000C6_4C443A570168_var*
begin
//#UC START# *47D1602000C6_4C443A570168_impl*
 inherited;
{$If defined(Monitorings) or defined(Admin)}
  with dmStdRes.MenuManager.GetItemByName('enEdit') do
  begin
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opFindContext')) do
    Options := Options - [vcm_ooShowInMainMenu];
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opFindNext')) do
    Options := Options - [vcm_ooShowInMainMenu];
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opFindPrev')) do
    Options := Options - [vcm_ooShowInMainMenu];
  end;
{$IfEnd defined(Monitorings) or defined(Admin)}

//#UC END# *47D1602000C6_4C443A570168_impl*
end;//TPrimTreeAttributeSelectOptionsForm.Create

procedure TPrimTreeAttributeSelectOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_Selection, EntitiesenSelectionGetTarget);
  ContextMenuWeight(en_Tree, 50);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  ShowInContextMenu(en_Edit, op_Delete, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  ShowInContextMenu(en_Edit, op_Copy, true);
  ShowInToolbar(en_Edit, op_Copy, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Cut, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Cut, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindContext, nil, nil, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindNext, nil, nil, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Undo, nil, nil, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Redo, nil, nil, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_SelectAll, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_SelectAll, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Deselect, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Deselect, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindPrev, nil, nil, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, nil);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_Attribute, op_LogicOr, Attribute_LogicOr_Execute, Attribute_LogicOr_Test, nil);
  PublishOp(en_Attribute, op_LogicAnd, Attribute_LogicAnd_Execute, Attribute_LogicAnd_Test, nil);
  PublishOp(en_Attribute, op_LogicNot, Attribute_LogicNot_Execute, Attribute_LogicNot_Test, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOp(en_Attribute, op_LogicOrShortcut, Attribute_LogicOrShortcut_Execute, Attribute_LogicOrShortcut_Test, nil);
  ShowInContextMenu(en_Attribute, op_LogicOrShortcut, true);
  PublishOp(en_Selection, op_DropSelection, Selection_DropSelection_Execute, Selection_DropSelection_Test, nil);
  ShowInContextMenu(en_Selection, op_DropSelection, true);
  ShowInToolbar(en_Selection, op_DropSelection, false);
  ShowInContextMenu(en_Folder, op_FindFirstSelected, true);
  ShowInToolbar(en_Folder, op_FindFirstSelected, false);
 end;//with Entities.Entities
end;

initialization
{$If not defined(NoScripts)}
// Регистрация PrimTreeAttributeSelectOptions
 TtfwClassRef.Register(TPrimTreeAttributeSelectOptionsForm);
{$IfEnd} //not NoScripts

end.