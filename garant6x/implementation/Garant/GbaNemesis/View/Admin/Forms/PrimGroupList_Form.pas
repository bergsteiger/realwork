unit PrimGroupList_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupList_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Администратор::Admin::View::Admin::PrimGroupList
//
// Группы пользователей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  l3Interfaces,
  l3TreeInterfaces,
  l3ControlsTypes,
  AdminInterfaces,
  eeTreeView
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  Admin_Users_Controls
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  eeTreeViewExport
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  l3StringIDEx,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  F1Like_InternalOperations_Controls,
  vtOutliner,
  PrimGroupList_admGroupList_UserType
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimGroupListForm = {form} class(TvcmEntityForm, IbsGroupListViewListener)
  {* Группы пользователей }
 private
 // private fields
   f_BackgroundPanel : TvtPanel;
    {* Поле для свойства BackgroundPanel}
   f_GroupsTree : TeeTreeView;
    {* Поле для свойства GroupsTree}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure GroupsTreeCountChanged(Sender: TObject;
     NewCount: LongInt);
   function GroupsTreeGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure GroupsTreeCurrentChanged(Sender: TObject;
     aNewCurrent: LongInt;
     aOldCurrent: LongInt);
   procedure GroupsTreeTreeChanged(aSender: TObject;
     const anOldTree: Il3SimpleTree;
     const aNewTree: Il3SimpleTree);
   procedure GroupsTreeSelectCountChanged(aSender: TObject;
     anOldCount: Integer;
     aNewCount: Integer);
   procedure GroupsTreeFormatStatusInfo(aSender: TObject;
     var Info: Il3CString;
     aCurrent: Integer;
     aCount: Integer;
     aSelected: Integer);
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
   procedure Groups_Add_Test(const aParams: IvcmTestParamsPrim);
     {* Добавить }
   procedure Groups_Add_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Добавить }
   procedure Groups_ChangeBaseAccess_Test(const aParams: IvcmTestParamsPrim);
   procedure Groups_ChangeBaseAccess_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Groups_Rename_Test(const aParams: IvcmTestParamsPrim);
     {* Переименовать группу }
   procedure Groups_Rename_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Переименовать группу }
   procedure Switcher_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Switcher_BecomeActive_Execute(const aForm: IvcmEntityForm);
   procedure Switcher_BecomeActive(const aParams: IvcmExecuteParams);
   procedure TreeViewInvalidate;
     {* Сигнатура метода TreeViewInvalidate }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   ViewArea : IdsGroupsList;
 protected
 // protected methods
   procedure UpdateCurrent;
     {* Сигнатура метода UpdateCurrent }
   function IsCurrentUsual: Boolean;
 public
 // public properties
   property BackgroundPanel: TvtPanel
     read f_BackgroundPanel;
   property GroupsTree: TeeTreeView
     read f_GroupsTree;
 end;//TPrimGroupListForm
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  nsTypes,
  AdminRes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsUserNodes,
  SecurityUnit
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

var
   { Локализуемые строки admGroupListLocalConstants }
  str_admGroupListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListCaption'; rValue : 'Группы пользователей');
   { Заголовок пользовательского типа "Группы пользователей" }
  str_admGroupListSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admGroupListSettingsCaption'; rValue : 'Группы пользователей (вкладка)');
   { Заголовок пользовательского типа "Группы пользователей" для настройки панелей инструментов }

// start class TPrimGroupListForm

procedure TPrimGroupListForm.GroupsTreeCountChanged(Sender: TObject;
  NewCount: LongInt);
//#UC START# *5236E2780163_49EC75B5022C_var*
//#UC END# *5236E2780163_49EC75B5022C_var*
begin
//#UC START# *5236E2780163_49EC75B5022C_impl*
 UpdateStatusInfo;
//#UC END# *5236E2780163_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeCountChanged

function TPrimGroupListForm.GroupsTreeGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *5236E28202F7_49EC75B5022C_var*
const
 cImageIndexMap: array [TbsGroupNodeType] of Integer = (
  ciiGroup, // gntUnknown,
  ciiSystemGroup, // gntSystem,
  ciiGroup // gntUsual
 );
//#UC END# *5236E28202F7_49EC75B5022C_var*
begin
//#UC START# *5236E28202F7_49EC75B5022C_impl*
 if Assigned(ViewArea) then
  Result := cImageIndexMap[ViewArea.GroupsListNodeType(GroupsTree.GetNode(Index))]
 else
  Result := ciiUser_NA;
//#UC END# *5236E28202F7_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeGetItemImage

procedure TPrimGroupListForm.GroupsTreeCurrentChanged(Sender: TObject;
  aNewCurrent: LongInt;
  aOldCurrent: LongInt);
//#UC START# *5236E28B0222_49EC75B5022C_var*
//#UC END# *5236E28B0222_49EC75B5022C_var*
begin
//#UC START# *5236E28B0222_49EC75B5022C_impl*
 UpdateCurrent;
//#UC END# *5236E28B0222_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeCurrentChanged

procedure TPrimGroupListForm.GroupsTreeTreeChanged(aSender: TObject;
  const anOldTree: Il3SimpleTree;
  const aNewTree: Il3SimpleTree);
//#UC START# *5236E2940127_49EC75B5022C_var*
//#UC END# *5236E2940127_49EC75B5022C_var*
begin
//#UC START# *5236E2940127_49EC75B5022C_impl*
 UpdateStatusInfo;
//#UC END# *5236E2940127_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeTreeChanged

procedure TPrimGroupListForm.GroupsTreeSelectCountChanged(aSender: TObject;
  anOldCount: Integer;
  aNewCount: Integer);
//#UC START# *5236E29C02A7_49EC75B5022C_var*
//#UC END# *5236E29C02A7_49EC75B5022C_var*
begin
//#UC START# *5236E29C02A7_49EC75B5022C_impl*
 UpdateStatusInfo;
//#UC END# *5236E29C02A7_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeSelectCountChanged

procedure TPrimGroupListForm.GroupsTreeFormatStatusInfo(aSender: TObject;
  var Info: Il3CString;
  aCurrent: Integer;
  aCount: Integer;
  aSelected: Integer);
//#UC START# *5236E2A600F9_49EC75B5022C_var*
//#UC END# *5236E2A600F9_49EC75B5022C_var*
begin
//#UC START# *5236E2A600F9_49EC75B5022C_impl*
 if GroupsTree.TreeStruct.RootNode.HasChild then
  Info := vcmFmt(vcmCStr(str_GroupsListStatus),[GroupsTree.TreeStruct.RootNode.ThisChildrenCount])
 else
  Info := nil;
//#UC END# *5236E2A600F9_49EC75B5022C_impl*
end;//TPrimGroupListForm.GroupsTreeFormatStatusInfo

procedure TPrimGroupListForm.UpdateCurrent;
//#UC START# *5236F5A00279_49EC75B5022C_var*
//#UC END# *5236F5A00279_49EC75B5022C_var*
begin
//#UC START# *5236F5A00279_49EC75B5022C_impl*
 ViewArea.CurrentChanged(GroupsTree.GetCurrentNode);
 UpdateStatusInfo;
//#UC END# *5236F5A00279_49EC75B5022C_impl*
end;//TPrimGroupListForm.UpdateCurrent

function TPrimGroupListForm.IsCurrentUsual: Boolean;
//#UC START# *5236F5CD009F_49EC75B5022C_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *5236F5CD009F_49EC75B5022C_var*
begin
//#UC START# *5236F5CD009F_49EC75B5022C_impl*
 l_Node := GroupsTree.GetCurrentNode;
 Result := ViewArea.GroupsListNodeType(l_Node) = gntUsual;
//#UC END# *5236F5CD009F_49EC75B5022C_impl*
end;//TPrimGroupListForm.IsCurrentUsual

{$If not defined(NoVCM)}
procedure TPrimGroupListForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *494F89C30197_49EC75B5022Ctest_var*
//#UC END# *494F89C30197_49EC75B5022Ctest_var*
begin
//#UC START# *494F89C30197_49EC75B5022Ctest_impl*
 if aParams.Control = GroupsTree then
  aParams.Op.Flag[vcm_ofEnabled] := IsCurrentUsual
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *494F89C30197_49EC75B5022Ctest_impl*
end;//TPrimGroupListForm.Edit_Delete_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimGroupListForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
//#UC START# *494F89C30197_49EC75B5022Cgetstate_var*
//#UC END# *494F89C30197_49EC75B5022Cgetstate_var*
begin
//#UC START# *494F89C30197_49EC75B5022Cgetstate_impl*
 State := st_user_Edit_Delete_Group;
//#UC END# *494F89C30197_49EC75B5022Cgetstate_impl*
end;//TPrimGroupListForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimGroupListForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *494F89C30197_49EC75B5022Cexec_var*
var
 l_CurrentNode: Il3SimpleNode;
 l_HasUsers: Boolean;
//#UC END# *494F89C30197_49EC75B5022Cexec_var*
begin
//#UC START# *494F89C30197_49EC75B5022Cexec_impl*
 if aParams.Control = GroupsTree then
 begin
  l_CurrentNode := GroupsTree.GetCurrentNode;
  l_HasUsers := ViewArea.HasUsers(l_CurrentNode);
  if l_HasUsers and not Ask(qr_DeleteNotEmptyGroup) then
   Exit;
  if not l_HasUsers and not Ask(qr_DeleteGroup, [l3CStr(l_CurrentNode)]) then
   Exit;
  ViewArea.DeleteGroup(l_CurrentNode);
 end
 else
  aParams.CallControl;
//#UC END# *494F89C30197_49EC75B5022Cexec_impl*
end;//TPrimGroupListForm.Edit_Delete_Execute
{$IfEnd} //not NoVCM

procedure TPrimGroupListForm.Groups_Add_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EC7545036C_49EC75B5022Ctest_var*
//#UC END# *49EC7545036C_49EC75B5022Ctest_var*
begin
//#UC START# *49EC7545036C_49EC75B5022Ctest_impl*
// Do Nothing
//#UC END# *49EC7545036C_49EC75B5022Ctest_impl*
end;//TPrimGroupListForm.Groups_Add_Test

procedure TPrimGroupListForm.Groups_Add_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EC7545036C_49EC75B5022Cexec_var*
//#UC END# *49EC7545036C_49EC75B5022Cexec_var*
begin
//#UC START# *49EC7545036C_49EC75B5022Cexec_impl*
 try
  ViewArea.CreateNewGroup;
 except
  on E: EDuplicateGroupName do
   Say(war_GroupNameDuplicate, [nsCStr(E.Message)]);
 end;
//#UC END# *49EC7545036C_49EC75B5022Cexec_impl*
end;//TPrimGroupListForm.Groups_Add_Execute

procedure TPrimGroupListForm.Groups_ChangeBaseAccess_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EC755501FB_49EC75B5022Ctest_var*
//#UC END# *49EC755501FB_49EC75B5022Ctest_var*
begin
//#UC START# *49EC755501FB_49EC75B5022Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := IsCurrentUsual;
//#UC END# *49EC755501FB_49EC75B5022Ctest_impl*
end;//TPrimGroupListForm.Groups_ChangeBaseAccess_Test

procedure TPrimGroupListForm.Groups_ChangeBaseAccess_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EC755501FB_49EC75B5022Cexec_var*
//#UC END# *49EC755501FB_49EC75B5022Cexec_var*
begin
//#UC START# *49EC755501FB_49EC75B5022Cexec_impl*
 ViewArea.ChangeBasesAccessForGroup(GroupsTree.GetCurrentNode);
//#UC END# *49EC755501FB_49EC75B5022Cexec_impl*
end;//TPrimGroupListForm.Groups_ChangeBaseAccess_Execute

procedure TPrimGroupListForm.Groups_Rename_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EEF22D004A_49EC75B5022Ctest_var*
//#UC END# *49EEF22D004A_49EC75B5022Ctest_var*
begin
//#UC START# *49EEF22D004A_49EC75B5022Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := IsCurrentUsual;
//#UC END# *49EEF22D004A_49EC75B5022Ctest_impl*
end;//TPrimGroupListForm.Groups_Rename_Test

procedure TPrimGroupListForm.Groups_Rename_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EEF22D004A_49EC75B5022Cexec_var*
//#UC END# *49EEF22D004A_49EC75B5022Cexec_var*
begin
//#UC START# *49EEF22D004A_49EC75B5022Cexec_impl*
 try
  ViewArea.RenameGroup(GroupsTree.GetCurrentNode);
 except
  on E: EDuplicateGroupName do
   Say(war_GroupNameDuplicate, [nsCStr(E.Message)]);
 end;
//#UC END# *49EEF22D004A_49EC75B5022Cexec_impl*
end;//TPrimGroupListForm.Groups_Rename_Execute

procedure TPrimGroupListForm.Switcher_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AEF3E8C02F5_49EC75B5022Ctest_var*
//#UC END# *4AEF3E8C02F5_49EC75B5022Ctest_var*
begin
//#UC START# *4AEF3E8C02F5_49EC75B5022Ctest_impl*
 inherited;
//#UC END# *4AEF3E8C02F5_49EC75B5022Ctest_impl*
end;//TPrimGroupListForm.Switcher_BecomeActive_Test

procedure TPrimGroupListForm.Switcher_BecomeActive_Execute(const aForm: IvcmEntityForm);
//#UC START# *4AEF3E8C02F5_49EC75B5022Cexec_var*
//#UC END# *4AEF3E8C02F5_49EC75B5022Cexec_var*
begin
//#UC START# *4AEF3E8C02F5_49EC75B5022Cexec_impl*
 SetActiveInParent;
//#UC END# *4AEF3E8C02F5_49EC75B5022Cexec_impl*
end;//TPrimGroupListForm.Switcher_BecomeActive_Execute

procedure TPrimGroupListForm.Switcher_BecomeActive(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISwitcher_BecomeActive_Params) do
  Switcher_BecomeActive_Execute(Form);
end;

procedure TPrimGroupListForm.TreeViewInvalidate;
//#UC START# *5492EBB90042_49EC75B5022C_var*
//#UC END# *5492EBB90042_49EC75B5022C_var*
begin
//#UC START# *5492EBB90042_49EC75B5022C_impl*
 GroupsTree.Invalidate;
//#UC END# *5492EBB90042_49EC75B5022C_impl*
end;//TPrimGroupListForm.TreeViewInvalidate

{$If not defined(NoVCM)}
procedure TPrimGroupListForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_49EC75B5022C_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *497469C90140_49EC75B5022C_var*
begin
//#UC START# *497469C90140_49EC75B5022C_impl*
 if (anOld <> nil) then
  anOld.Unsubscribe(IbsGroupListViewListener(Self));
 if (aNew <> nil) then
  aNew.Subscribe(IbsGroupListViewListener(Self));

 if Assigned(ViewArea) then
 begin
  with GroupsTree do
  begin
   Images := ViewArea.ImageList.Hack;
   //if not aFromHistory then
   begin
    TreeStruct := ViewArea.SimpleTree;
    l_Node := GetUserByID(GROUP_ALL_ID, TreeStruct);
    if Assigned(l_Node) then
     GotoOnNode(l_Node);
   end;
   UpdateStatusInfo;
   ViewArea.CurrentChanged(GetCurrentNode)
  end;
 end;
//#UC END# *497469C90140_49EC75B5022C_impl*
end;//TPrimGroupListForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimGroupListForm.InitControls;
//#UC START# *4A8E8F2E0195_49EC75B5022C_var*
//#UC END# *4A8E8F2E0195_49EC75B5022C_var*
begin
//#UC START# *4A8E8F2E0195_49EC75B5022C_impl*
 ActiveControl := GroupsTree;
 FormStyle := fsStayOnTop;
 Scaled := False;

 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;

 with GroupsTree do
 begin
  ActionElementMode := l3_amSingleClick;
  Align := alClient;
  BorderStyle := bsNone;
  DragAndDropSupported := True;
  TabOrder := 0;
  ViewOptions := [voShowIcons];
  OnGetItemImage := GroupsTreeGetItemImage;
  OnCurrentChanged := GroupsTreeCurrentChanged;
  OnTreeChanged := GroupsTreeTreeChanged;
  OnSelectCountChanged := GroupsTreeSelectCountChanged;
  OnFormatStatusInfo := GroupsTreeFormatStatusInfo;
  OnCountChanged := GroupsTreeCountChanged;
 end;
 
 UpdateStatusInfo; 
//#UC END# *4A8E8F2E0195_49EC75B5022C_impl*
end;//TPrimGroupListForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimGroupListForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  ViewArea := nil;
 end//aDsNew = nil
 else
 begin
  ViewArea := aDsNew As IdsGroupsList;
 end;//aDsNew = nil
end;

procedure TPrimGroupListForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Groups, nil);
  PublishFormEntity(en_Switcher, nil);
  MakeEntitySupportedByControl(en_Edit, GroupsTree);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  {$IfEnd} //not NoVCM

  PublishOp(en_Groups, op_Add, Groups_Add_Execute, Groups_Add_Test, nil);
  PublishOp(en_Groups, op_ChangeBaseAccess, Groups_ChangeBaseAccess_Execute, Groups_ChangeBaseAccess_Test, nil);
  PublishOp(en_Groups, op_Rename, Groups_Rename_Execute, Groups_Rename_Test, nil);
  PublishOpWithResult(en_Switcher, op_BecomeActive, Switcher_BecomeActive, Switcher_BecomeActive_Test, nil);
 end;//with Entities.Entities
end;

procedure TPrimGroupListForm.MakeControls;
begin
 inherited;
 with AddUsertype(admGroupListName,
  str_admGroupListCaption,
  str_admGroupListSettingsCaption,
  true,
  -1,
  10,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(admGroupListName
 f_BackgroundPanel := TvtPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_GroupsTree := TeeTreeView.Create(Self);
 f_GroupsTree.Name := 'GroupsTree';
 f_GroupsTree.Parent := BackgroundPanel;
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin)}
// Инициализация str_admGroupListCaption
 str_admGroupListCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_admGroupListSettingsCaption
 str_admGroupListSettingsCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimGroupList
 TtfwClassRef.Register(TPrimGroupListForm);
{$IfEnd} //Admin AND not NoScripts

end.