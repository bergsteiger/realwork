unit dsGroupsList;
 {* ������ ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsGroupsList.pas"
// ���������: "ViewAreaControllerImp"

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
  {* ������ ������������� }
  private
   f_Root: INodeBase;
   SDS: IsdsAdmin;
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* ������� ������ ������ }
   function GroupsListNodeType(const aNode: Il3SimpleNode): TbsGroupNodeType;
    {* ��� ���� }
   procedure DeleteGroup(const aNode: Il3SimpleNode);
    {* ������� ������ }
   procedure CreateNewGroup;
    {* ������� ������ }
   function ChangeBasesAccessForGroup(const aNode: Il3SimpleNode): Boolean;
   procedure RenameGroup(const aNode: Il3SimpleNode);
    {* ������������� ������ }
   function HasUsers(const aNode: Il3SimpleNode): Boolean;
    {* ���� �� ������������ � ������ }
   procedure CheckUnsavedUserProperty;
    {* ���� �������� �� ��������� - �������� �� ���� }
   procedure NotifyTreeViewInvalidate;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); override;
    {* �������� �������. }
   function MakeImageList: Il3ImageList; override;
    {* - ������� ������ ������. }
   procedure DoDataDropped; override;
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - ������ ����������. }
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
 {* ������� ������ ������ }
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
 {* ��� ���� }
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
 {* ������� ������ }
//#UC START# *49EC50390132_49EC547C001B_var*
//#UC END# *49EC50390132_49EC547C001B_var*
begin
//#UC START# *49EC50390132_49EC547C001B_impl*
 SDS.DeleteGroup(aNode);
//#UC END# *49EC50390132_49EC547C001B_impl*
end;//TdsGroupsList.DeleteGroup

procedure TdsGroupsList.CreateNewGroup;
 {* ������� ������ }
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
 {* ������������� ������ }
//#UC START# *49EEEBB4002A_49EC547C001B_var*
//#UC END# *49EEEBB4002A_49EC547C001B_var*
begin
//#UC START# *49EEEBB4002A_49EC547C001B_impl*
 SDS.RenameGroup(aNode);
//#UC END# *49EEEBB4002A_49EC547C001B_impl*
end;//TdsGroupsList.RenameGroup

function TdsGroupsList.HasUsers(const aNode: Il3SimpleNode): Boolean;
 {* ���� �� ������������ � ������ }
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
 {* ���� �������� �� ��������� - �������� �� ���� }
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
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_49EC547C001B_var*
//#UC END# *479731C50290_49EC547C001B_var*
begin
//#UC START# *479731C50290_49EC547C001B_impl*
 f_Root := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49EC547C001B_impl*
end;//TdsGroupsList.Cleanup

procedure TdsGroupsList.DoCurrentChanged(const aNode: Il3SimpleNode);
 {* �������� �������. }
//#UC START# *47F0C1BF0314_49EC547C001B_var*
//#UC END# *47F0C1BF0314_49EC547C001B_var*
begin
//#UC START# *47F0C1BF0314_49EC547C001B_impl*
 SDS.ChangeGroup(aNode);
//#UC END# *47F0C1BF0314_49EC547C001B_impl*
end;//TdsGroupsList.DoCurrentChanged

function TdsGroupsList.MakeImageList: Il3ImageList;
 {* - ������� ������ ������. }
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
 {* - ������ ����������. }
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
