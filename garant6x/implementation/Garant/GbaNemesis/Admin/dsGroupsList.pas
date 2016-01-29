unit dsGroupsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/dsGroupsList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Администратор::Admin::Admin::Admin::TdsGroupsList
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
  DynamicTreeUnit,
  AdminInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 _FormDataSourceType_ = IdsGroupsList;
 _InitDataType_ = IdeNode;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 TdsGroupsList = {final vac} class(_dsSimpleTree_, IdsGroupsList)
  {* Группы пользователей }
 private
 // private fields
   f_Root : INodeBase;
   SDS : IsdsAdmin;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
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
     {* Сигнатура метода NotifyTreeViewInvalidate }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); override;
     {* сменился текущий. }
   function MakeImageList: Il3ImageList; override;
     {* - создать иконки дерева. }
   procedure DoDataDropped; override;
   {$If not defined(NoVCM)}
   procedure GotData; override;
     {* - данные изменились. }
   {$IfEnd} //not NoVCM
 end;//TdsGroupsList
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  AdminRes,
  nsGroupTreeStructWithDrop,
  SecurityUnit,
  SysUtils,
  l3Base,
  vtUtils,
  vtStdRes,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

type _Instance_R_ = TdsGroupsList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

// start class TdsGroupsList

function TdsGroupsList.MakeSimpleTree: Il3SimpleTree;
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
//#UC START# *49EC50390132_49EC547C001B_var*
//#UC END# *49EC50390132_49EC547C001B_var*
begin
//#UC START# *49EC50390132_49EC547C001B_impl*
 SDS.DeleteGroup(aNode);
//#UC END# *49EC50390132_49EC547C001B_impl*
end;//TdsGroupsList.DeleteGroup

procedure TdsGroupsList.CreateNewGroup;
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
//#UC START# *49EEEBB4002A_49EC547C001B_var*
//#UC END# *49EEEBB4002A_49EC547C001B_var*
begin
//#UC START# *49EEEBB4002A_49EC547C001B_impl*
 SDS.RenameGroup(aNode);
//#UC END# *49EEEBB4002A_49EC547C001B_impl*
end;//TdsGroupsList.RenameGroup

function TdsGroupsList.HasUsers(const aNode: Il3SimpleNode): Boolean;
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
//#UC START# *479731C50290_49EC547C001B_var*
//#UC END# *479731C50290_49EC547C001B_var*
begin
//#UC START# *479731C50290_49EC547C001B_impl*
 f_Root := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49EC547C001B_impl*
end;//TdsGroupsList.Cleanup

procedure TdsGroupsList.DoCurrentChanged(const aNode: Il3SimpleNode);
//#UC START# *47F0C1BF0314_49EC547C001B_var*
//#UC END# *47F0C1BF0314_49EC547C001B_var*
begin
//#UC START# *47F0C1BF0314_49EC547C001B_impl*
 SDS.ChangeGroup(aNode);
//#UC END# *47F0C1BF0314_49EC547C001B_impl*
end;//TdsGroupsList.DoCurrentChanged

function TdsGroupsList.MakeImageList: Il3ImageList;
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

{$If not defined(NoVCM)}
procedure TdsGroupsList.GotData;
//#UC START# *492ACF630072_49EC547C001B_var*
//#UC END# *492ACF630072_49EC547C001B_var*
begin
//#UC START# *492ACF630072_49EC547C001B_impl*
 inherited GotData;
 f_Root := PartData.Node;
//#UC END# *492ACF630072_49EC547C001B_impl*
end;//TdsGroupsList.GotData
{$IfEnd} //not NoVCM

procedure TdsGroupsList.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 SDS := aDS As IsdsAdmin;
end;

procedure TdsGroupsList.ClearRefs;
begin
 inherited;
 SDS := nil;
end;

{$IfEnd} //Admin

end.