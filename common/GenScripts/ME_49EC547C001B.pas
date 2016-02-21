unit dsGroupsList;
 {* Группы пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsGroupsList.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , AdminInterfaces
 , DynamicTreeUnit
 , l3TreeInterfaces
 , l3InternalInterfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = IdeNode;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 TdsGroupsList = {final} class(_dsSimpleTree_, IdsGroupsList)
  {* Группы пользователей }
  private
   f_Root: INodeBase;
   SDS: IsdsAdmin;
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function GroupsListNodeType(const aNode: Il3SimpleNode): TbsGroupNodeType;
    {* Тип ноды }
   procedure DeleteGroup(const aNode: Il3SimpleNode);
    {* Удалить группу }
   procedure CreateNewGroup;
    {* Создать группу }
   function ChangeBasesAccessForGroup(const aNode: Il3SimpleNode): Boolean;
   procedure RenameGroup(const aNode: Il3SimpleNode);
    {* Переименовать группу }
   function HasUsers(const aNode: Il3SimpleNode): Boolean;
    {* Есть ли пользователи в группе }
   procedure CheckUnsavedUserProperty;
    {* Если свойства не сохранены - спросить об этом }
   procedure NotifyTreeViewInvalidate;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); override;
    {* сменился текущий. }
   function MakeImageList: Il3ImageList; override;
    {* - создать иконки дерева. }
   procedure DoDataDropped; override;
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsGroupsList
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , AdminRes
 , nsGroupTreeStructWithDrop
 , SecurityUnit
 , SysUtils
 , l3Base
 , vtUtils
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsGroupsList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

function TdsGroupsList.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
//#UC START# *47F4C2B9014A_49EC547C001B_var*
//#UC END# *47F4C2B9014A_49EC547C001B_var*
begin
//#UC START# *47F4C2B9014A_49EC547C001B_impl*
 if Assigned(f_Root) then
  Result := TnsGroupTreeStructWithDrop.Make(f_Root, False)
 else
  Result := nil;
//#UC END# *47F4C2B9014A_49EC547C001B_impl*
end;//TdsGroupsList.MakeSimpleTree

function TdsGroupsList.GroupsListNodeType(const aNode: Il3SimpleNode): TbsGroupNodeType;
 {* Тип ноды }
//#UC START# *49EC50000093_49EC547C001B_var*
var
 l_Node: INodeBase;
 l_Type: TNodeType;
//#UC END# *49EC50000093_49EC547C001B_var*
begin
//#UC START# *49EC50000093_49EC547C001B_impl*
 if Supports(aNode, INodeBase, l_Node) then
 begin
  l_Type := l_Node.GetType;
  if (l_Type and PNT_SYSTEM_FLAG) <> 0 then
   Result := gntSystem
  else
   Result := gntUsual;
 end
 else
  Result := gntUnknown;
//#UC END# *49EC50000093_49EC547C001B_impl*
end;//TdsGroupsList.GroupsListNodeType

procedure TdsGroupsList.DeleteGroup(const aNode: Il3SimpleNode);
 {* Удалить группу }
//#UC START# *49EC50390132_49EC547C001B_var*
//#UC END# *49EC50390132_49EC547C001B_var*
begin
//#UC START# *49EC50390132_49EC547C001B_impl*
 SDS.DeleteGroup(aNode);
//#UC END# *49EC50390132_49EC547C001B_impl*
end;//TdsGroupsList.DeleteGroup

procedure TdsGroupsList.CreateNewGroup;
 {* Создать группу }
//#UC START# *49EC51CA014F_49EC547C001B_var*
//#UC END# *49EC51CA014F_49EC547C001B_var*
begin
//#UC START# *49EC51CA014F_49EC547C001B_impl*
 SDS.CreateNewGroup;
//#UC END# *49EC51CA014F_49EC547C001B_impl*
end;//TdsGroupsList.CreateNewGroup

function TdsGroupsList.ChangeBasesAccessForGroup(const aNode: Il3SimpleNode): Boolean;
//#UC START# *49EC52BD01EC_49EC547C001B_var*
//#UC END# *49EC52BD01EC_49EC547C001B_var*
begin
//#UC START# *49EC52BD01EC_49EC547C001B_impl*
 Result := SDS.ChangeBaseAccessForGroup(aNode)
//#UC END# *49EC52BD01EC_49EC547C001B_impl*
end;//TdsGroupsList.ChangeBasesAccessForGroup

procedure TdsGroupsList.RenameGroup(const aNode: Il3SimpleNode);
 {* Переименовать группу }
//#UC START# *49EEEBB4002A_49EC547C001B_var*
//#UC END# *49EEEBB4002A_49EC547C001B_var*
begin
//#UC START# *49EEEBB4002A_49EC547C001B_impl*
 SDS.RenameGroup(aNode);
//#UC END# *49EEEBB4002A_49EC547C001B_impl*
end;//TdsGroupsList.RenameGroup

function TdsGroupsList.HasUsers(const aNode: Il3SimpleNode): Boolean;
 {* Есть ли пользователи в группе }
//#UC START# *49F04DCE0166_49EC547C001B_var*
var
 l_Node: IGroupNode;
//#UC END# *49F04DCE0166_49EC547C001B_var*
begin
//#UC START# *49F04DCE0166_49EC547C001B_impl*
 Result := Supports(aNode, IGroupNode, l_Node) and l_Node.HasUsers;
//#UC END# *49F04DCE0166_49EC547C001B_impl*
end;//TdsGroupsList.HasUsers

procedure TdsGroupsList.CheckUnsavedUserProperty;
 {* Если свойства не сохранены - спросить об этом }
//#UC START# *49F6DBB30002_49EC547C001B_var*
//#UC END# *49F6DBB30002_49EC547C001B_var*
begin
//#UC START# *49F6DBB30002_49EC547C001B_impl*
 SDS.CheckUnsavedUserProperty;
//#UC END# *49F6DBB30002_49EC547C001B_impl*
end;//TdsGroupsList.CheckUnsavedUserProperty

procedure TdsGroupsList.NotifyTreeViewInvalidate;
//#UC START# *5492ECBC01A5_49EC547C001B_var*
var
 I: Integer;
 l_Listener: IbsGroupListViewListener;
//#UC END# *5492ECBC01A5_49EC547C001B_var*
begin
//#UC START# *5492ECBC01A5_49EC547C001B_impl*
 if Assigned(NotifiedObjList) then
  for I := 0 to NotifiedObjList.Count - 1 do
  begin
   if Supports(NotifiedObjList.Items[I], IbsGroupListViewListener, l_Listener) then
    l_Listener.TreeViewInvalidate;
  end;//if (NotifiedObjList <> nil)
//#UC END# *5492ECBC01A5_49EC547C001B_impl*
end;//TdsGroupsList.NotifyTreeViewInvalidate

procedure TdsGroupsList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49EC547C001B_var*
//#UC END# *479731C50290_49EC547C001B_var*
begin
//#UC START# *479731C50290_49EC547C001B_impl*
 f_Root := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49EC547C001B_impl*
end;//TdsGroupsList.Cleanup

procedure TdsGroupsList.DoCurrentChanged(const aNode: Il3SimpleNode);
 {* сменился текущий. }
//#UC START# *47F0C1BF0314_49EC547C001B_var*
//#UC END# *47F0C1BF0314_49EC547C001B_var*
begin
//#UC START# *47F0C1BF0314_49EC547C001B_impl*
 SDS.ChangeGroup(aNode);
//#UC END# *47F0C1BF0314_49EC547C001B_impl*
end;//TdsGroupsList.DoCurrentChanged

function TdsGroupsList.MakeImageList: Il3ImageList;
 {* - создать иконки дерева. }
//#UC START# *47F465F80149_49EC547C001B_var*
//#UC END# *47F465F80149_49EC547C001B_var*
begin
//#UC START# *47F465F80149_49EC547C001B_impl*
 Result := vtMakeImageListWrapper(dmAdmin.ilUsers);
//#UC END# *47F465F80149_49EC547C001B_impl*
end;//TdsGroupsList.MakeImageList

procedure TdsGroupsList.DoDataDropped;
//#UC START# *49215CE702B9_49EC547C001B_var*
//#UC END# *49215CE702B9_49EC547C001B_var*
begin
//#UC START# *49215CE702B9_49EC547C001B_impl*
 SDS.RequestUpdateCurrent;
 NotifyTreeViewInvalidate;
//#UC END# *49215CE702B9_49EC547C001B_impl*
end;//TdsGroupsList.DoDataDropped

{$If NOT Defined(NoVCM)}
procedure TdsGroupsList.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_49EC547C001B_var*
//#UC END# *492ACF630072_49EC547C001B_var*
begin
//#UC START# *492ACF630072_49EC547C001B_impl*
 inherited GotData;
 f_Root := PartData.Node;
//#UC END# *492ACF630072_49EC547C001B_impl*
end;//TdsGroupsList.GotData
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
