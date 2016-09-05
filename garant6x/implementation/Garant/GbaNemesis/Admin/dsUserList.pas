unit dsUserList;
 {* бизнес объект формы efUserList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsUserList.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsUserList" MUID: (49246742002B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , AdminInterfaces
 , DynamicTreeUnit
 , l3TreeInterfaces
 , bsTypes
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
;

type
 _InitDataType_ = IdeNode;
 _FormDataSourceType_ = IdsUserList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 _nsContextFilter_Parent_ = _dsSimpleTree_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\nsContextFilter.imp.pas}
 TdsUserList = {final} class(_nsContextFilter_, IdsUserList)
  {* бизнес объект формы efUserList }
  private
   f_Root: INodeBase;
   SDS: IsdsAdmin;
    {* Прецедент Администрирование }
   f_CurrentFlagFilter: TUserListFilterTypes;
   f_CurrentGroupFilter: Integer;
  private
   function MakeSelectedList(const aTree: Il3SimpleTree): IadminUserNodeList;
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function UserListNodeType(const aNode: Il3SimpleNode): TbsUserNodeType;
   function GetFrosenNode(const aNode: Il3SimpleNode): IdeNode;
   function FindFrosenNode(const aNode: IdeNode;
    aShowRootFlag: Boolean): Integer;
   procedure DeleteUser(const aNode: Il3SimpleNode;
    out aFailed: Boolean);
   procedure DeleteUsers(const aUserTree: Il3SimpleTree;
    out aFailed: IadminUserNodeList);
    {* Удалить выделенных на дереве пользователей, вернуть список нод которые не удалось удалить }
   procedure CreateNewUser;
   function GetUserState(const aNode: Il3SimpleNode): TUserStates;
   procedure LogoutUser(const aNode: Il3SimpleNode);
   procedure LogoutUsers(const aUserTree: Il3SimpleTree);
    {* Отключить выделенных на дереве пользователей }
   function FiltrateByType(const aTreeSource: Il3SimpleTree;
    const aCurrentNode: Il3SimpleNode;
    aFilter: TUserListFilterTypes;
    out aCurrent: Integer): Il3SimpleTree;
   procedure SetConsultingPaymentForAll(IsAllowed: Boolean);
   procedure SetConsultingPayment(const aUserTree: Il3SimpleTree;
    IsAllowed: Boolean);
    {* Изменить возможность консалтинга для выделенных на дереве пользователей }
   procedure SetIsPrivileged(const aNode: Il3SimpleNode;
    IsPrivileged: Boolean);
   procedure SetPrivelegedRights(const aUserTree: Il3SimpleTree;
    IsPrivileged: Boolean);
    {* Изменить привилегированность для выделенных на дереве пользователей }
   procedure SelectNodes(const aUserTree: Il3SimpleTree;
    const aList: IadminUserNodeList);
    {* Выделить ноды по списку (Il3SimpleNode) }
   function pm_GetCurrentFlagFilter: TUserListFilterTypes;
   function pm_GetConsultingPaymentForNewbies: Boolean;
   procedure pm_SetConsultingPaymentForNewbies(aValue: Boolean);
   procedure NotifyCreateUserFinished(Successfull: Boolean);
    {* Нотификация об отскзе создания пользователя }
   procedure NotifyGroupChanged(aGroupUID: Integer);
    {* Сменилась группа }
   function FiltrateByGroup(const aTreeSource: Il3SimpleTree;
    const aCurrentNode: Il3SimpleNode;
    aFilter: Integer;
    out aCurrent: Integer): Il3SimpleTree;
   procedure CheckUnsavedUserProperty;
    {* Если свойства не сохранены - спросить об этом }
   procedure RequestUpdateCureent;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); override;
    {* сменился текущий. }
   function MakeImageList: Il3ImageList; override;
    {* - создать иконки дерева. }
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property CurrentFlagFilter: TUserListFilterTypes
    read f_CurrentFlagFilter;
   property CurrentGroupFilter: Integer
    read f_CurrentGroupFilter;
 end;//TdsUserList
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , SecurityUnit
 , vtUtils
 , AdminRes
 , l3InterfacedInterfaceList
 , l3Nodes
 , deNode
 , nsUserFlagsFilter
 , BaseTypesUnit
 , nsUserTreeStructWithDrag
 , nsGroupFilter
 , nsConst
 , deProfile
 , adminUserNodeList
 , l3Base
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
 {$If Defined(Nemesis)}
 , nscContextFilterState
 {$IfEnd} // Defined(Nemesis)
 //#UC START# *49246742002Bimpl_uses*
 //#UC END# *49246742002Bimpl_uses*
;

type _Instance_R_ = TdsUserList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\nsContextFilter.imp.pas}

function TdsUserList.MakeSelectedList(const aTree: Il3SimpleTree): IadminUserNodeList;
//#UC START# *49246C70028F_49246742002B_var*
var
 l_ResultList: TadminUserNodeList;

 function lpIterator(const aNode: Il3SimpleNode): Boolean;
 begin
  Result := False;
  l_ResultList.Add(aNode);
 end;

var
 l_Tree: Il3ExpandedSimpleTree;
//#UC END# *49246C70028F_49246742002B_var*
begin
//#UC START# *49246C70028F_49246742002B_impl*
 l_ResultList := TadminUserNodeList.Create;
 try
  Result := l_ResultList;
  Supports(aTree, Il3ExpandedSimpleTree, l_Tree);
  Assert(Assigned(l_Tree));
  l_Tree.FlagIterateF(l3L2SNA(@lpIterator), FM_SELECTION);
 finally
  FreeAndNil(l_ResultList);
 end;
//#UC END# *49246C70028F_49246742002B_impl*
end;//TdsUserList.MakeSelectedList

function TdsUserList.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
//#UC START# *47F4C2B9014A_49246742002B_var*
//#UC END# *47F4C2B9014A_49246742002B_var*
begin
//#UC START# *47F4C2B9014A_49246742002B_impl*
 if Assigned(f_Root) then
  Result := TnsUserTreeStructWithDrag.Make(f_Root, False)
 else
  Result := nil;
//#UC END# *47F4C2B9014A_49246742002B_impl*
end;//TdsUserList.MakeSimpleTree

function TdsUserList.UserListNodeType(const aNode: Il3SimpleNode): TbsUserNodeType;
//#UC START# *49245EB103E1_49246742002B_var*
var
 l_Node: INodeBase;
 l_Type: TNodeType;
//#UC END# *49245EB103E1_49246742002B_var*
begin
//#UC START# *49245EB103E1_49246742002B_impl*
 if Supports(aNode, INodeBase, l_Node) then
 begin
  l_Type := l_Node.GetType;
  if (l_Type and PNT_EXIT_FLAG) <> 0 then
   Result := untExiting
  else
   if (l_Type and PNT_SYSTEM_FLAG) <> 0 then
   begin
    if (l_Type and PNT_LOGGED_FLAG) <> 0 then
     Result := untActiveSystem
    else
     Result := untInactiveSystem;
   end
   else
   begin
    if (l_Type and PNT_PRIVILEGED_FLAG) <> 0 then
    begin
     if (l_Type and PNT_LOGGED_FLAG) <> 0 then
      Result := untActivePrivileged
     else
      Result := untInactivePrivileged;
    end
    else
    begin
     if (l_Type and PNT_LOGGED_FLAG) <> 0 then
      Result := untActiveNonSystem
     else
      Result := untInactiveNonSystem;
    end
   end;
 end
 else
  Result := untUnknownUser;
//#UC END# *49245EB103E1_49246742002B_impl*
end;//TdsUserList.UserListNodeType

function TdsUserList.GetFrosenNode(const aNode: Il3SimpleNode): IdeNode;
//#UC START# *49245EC10119_49246742002B_var*
var
 l_Node,
 l_Frosen: INodeBase;
//#UC END# *49245EC10119_49246742002B_var*
begin
//#UC START# *49245EC10119_49246742002B_impl*
 if Supports(aNode, INodeBase, l_Node) then
 begin
  l_Node.GetFrozenNode(l_Frosen);
  Result := TdeNode.Make(l_Frosen);
 end
 else
  Result := TdeNode.Make(nil);
//#UC END# *49245EC10119_49246742002B_impl*
end;//TdsUserList.GetFrosenNode

function TdsUserList.FindFrosenNode(const aNode: IdeNode;
 aShowRootFlag: Boolean): Integer;
//#UC START# *49245ECB01E9_49246742002B_var*
var
 l_Node: INodeBase;
//#UC END# *49245ECB01E9_49246742002B_var*
begin
//#UC START# *49245ECB01E9_49246742002B_impl*
 Result := -1;
 if Assigned(aNode) and
    Assigned(aNode.Node) and
    Assigned(f_Root) then
 begin
  f_Root.FindNode(aNode.Node, l_Node);
  try
   Result := f_Root.GetVisibleDelta(l_Node);
   if (Result <> -1) and
      not aShowRootFlag then
    dec(Result);
  except
   on ENotFound do ; // Ничего не нашли, вернем -1
  end;
 end;
//#UC END# *49245ECB01E9_49246742002B_impl*
end;//TdsUserList.FindFrosenNode

procedure TdsUserList.DeleteUser(const aNode: Il3SimpleNode;
 out aFailed: Boolean);
//#UC START# *49245EDB0225_49246742002B_var*
//#UC END# *49245EDB0225_49246742002B_var*
begin
//#UC START# *49245EDB0225_49246742002B_impl*
 SDS.DeleteUser(aNode, aFailed);
//#UC END# *49245EDB0225_49246742002B_impl*
end;//TdsUserList.DeleteUser

procedure TdsUserList.DeleteUsers(const aUserTree: Il3SimpleTree;
 out aFailed: IadminUserNodeList);
 {* Удалить выделенных на дереве пользователей, вернуть список нод которые не удалось удалить }
//#UC START# *49245EE602A0_49246742002B_var*
//#UC END# *49245EE602A0_49246742002B_var*
begin
//#UC START# *49245EE602A0_49246742002B_impl*
 SDS.DeleteUsers(aUserTree, MakeSelectedList(aUserTree), aFailed);
//#UC END# *49245EE602A0_49246742002B_impl*
end;//TdsUserList.DeleteUsers

procedure TdsUserList.CreateNewUser;
//#UC START# *49245EF90140_49246742002B_var*
//#UC END# *49245EF90140_49246742002B_var*
begin
//#UC START# *49245EF90140_49246742002B_impl*
 SDS.ChangeUser(TdeProfile.Make(nil, True));
//#UC END# *49245EF90140_49246742002B_impl*
end;//TdsUserList.CreateNewUser

function TdsUserList.GetUserState(const aNode: Il3SimpleNode): TUserStates;
//#UC START# *49245F730020_49246742002B_var*
var
 l_Node: INodeBase;
//#UC END# *49245F730020_49246742002B_var*
begin
//#UC START# *49245F730020_49246742002B_impl*
 Result := [];
 if Supports(aNode, INodeBase, l_Node) then
 begin
  if (l_Node.GetType and PNT_EXIT_FLAG) <> 0 then
   Result := [usExiting]
  else
  begin
   if (l_Node.GetType and PNT_LOGGED_FLAG) <> 0 then
    Include(Result, usActive);
   if (l_Node.GetType and PNT_SYSTEM_FLAG) <> 0 then
    Include(Result, usSystem);
  end;
 end;
//#UC END# *49245F730020_49246742002B_impl*
end;//TdsUserList.GetUserState

procedure TdsUserList.LogoutUser(const aNode: Il3SimpleNode);
//#UC START# *49245FA201D9_49246742002B_var*
//#UC END# *49245FA201D9_49246742002B_var*
begin
//#UC START# *49245FA201D9_49246742002B_impl*
 SDS.LogoutUser(aNode);
//#UC END# *49245FA201D9_49246742002B_impl*
end;//TdsUserList.LogoutUser

procedure TdsUserList.LogoutUsers(const aUserTree: Il3SimpleTree);
 {* Отключить выделенных на дереве пользователей }
//#UC START# *49245FC30050_49246742002B_var*
//#UC END# *49245FC30050_49246742002B_var*
begin
//#UC START# *49245FC30050_49246742002B_impl*
 SDS.LogoutUsers(MakeSelectedList(aUserTree));
//#UC END# *49245FC30050_49246742002B_impl*
end;//TdsUserList.LogoutUsers

function TdsUserList.FiltrateByType(const aTreeSource: Il3SimpleTree;
 const aCurrentNode: Il3SimpleNode;
 aFilter: TUserListFilterTypes;
 out aCurrent: Integer): Il3SimpleTree;
//#UC START# *49246092009E_49246742002B_var*
var
 l_FilterableTree: Il3FilterableTree;
 l_TreeFilters: InsUserFlagsFilters;

 function lp_MakeFilter: InsUserFlagsFilter;
 begin
  case CurrentFlagFilter of
   ulftNone:
    Result := nil;
   ulftActive:
    Result := TnsUserFlagsFilter.Make(UFF_USER_ACTIVE);
   ulftUsual:
    Result := TnsUserFlagsFilter.Make(UFF_USER_NOT_SYSTEM);
   ulftSystem:
    Result := TnsUserFlagsFilter.Make(UFF_USER_SYSTEM);
   ulftConsultingEnabled:
    Result := TnsUserFlagsFilter.Make(UFF_USER_CAN_BUY_CONSULTING);
   ulftConsultingDisabled:
    Result := TnsUserFlagsFilter.Make(UFF_USER_CANT_BUY_CONSULTING);
   ulftPrivileged:
    Result := TnsUserFlagsFilter.Make(UFF_USER_PRIVILEGED);
   ulftNonPrivileged:
    Result := TnsUserFlagsFilter.Make(UFF_USER_NOT_PRIVILEGED);
   ulftWithoutGroup:
    Result := TnsUserFlagsFilter.Make(UFF_NOT_GROUPPED_USERS);
   else
   begin
    Result := nil;
    Assert(False);
   end;
  end;
 end;

//#UC END# *49246092009E_49246742002B_var*
begin
//#UC START# *49246092009E_49246742002B_impl*
 if (aFilter <> CurrentFlagFilter) and
    Supports(aTreeSource, Il3FilterableTree, l_FilterableTree) and
    Supports(l_FilterableTree.CloneFilters, InsUserFlagsFilters, l_TreeFilters) then
 begin
  f_CurrentFlagFilter := aFilter;
  Result := l_FilterableTree.MakeFiltered(l_TreeFilters.
                                          SetUserFlag(lp_MakeFilter).
                                          SetContext(pm_GetCurrentContextFilter.ActiveContext),
                                          aCurrentNode,
                                          aCurrent,
                                          True,
                                          True);


 end
 else
  Result := aTreeSource;
//#UC END# *49246092009E_49246742002B_impl*
end;//TdsUserList.FiltrateByType

procedure TdsUserList.SetConsultingPaymentForAll(IsAllowed: Boolean);
//#UC START# *49246116033D_49246742002B_var*
//#UC END# *49246116033D_49246742002B_var*
begin
//#UC START# *49246116033D_49246742002B_impl*
 SDS.SetConsultingPaymentForAll(IsAllowed);
//#UC END# *49246116033D_49246742002B_impl*
end;//TdsUserList.SetConsultingPaymentForAll

procedure TdsUserList.SetConsultingPayment(const aUserTree: Il3SimpleTree;
 IsAllowed: Boolean);
 {* Изменить возможность консалтинга для выделенных на дереве пользователей }
//#UC START# *4924612E0296_49246742002B_var*
//#UC END# *4924612E0296_49246742002B_var*
begin
//#UC START# *4924612E0296_49246742002B_impl*
 SDS.SetConsultingPayment(MakeSelectedList(aUserTree), IsAllowed);
//#UC END# *4924612E0296_49246742002B_impl*
end;//TdsUserList.SetConsultingPayment

procedure TdsUserList.SetIsPrivileged(const aNode: Il3SimpleNode;
 IsPrivileged: Boolean);
//#UC START# *4924614D0345_49246742002B_var*
//#UC END# *4924614D0345_49246742002B_var*
begin
//#UC START# *4924614D0345_49246742002B_impl*
 SDS.SetIsPrivileged(aNode, IsPrivileged);
//#UC END# *4924614D0345_49246742002B_impl*
end;//TdsUserList.SetIsPrivileged

procedure TdsUserList.SetPrivelegedRights(const aUserTree: Il3SimpleTree;
 IsPrivileged: Boolean);
 {* Изменить привилегированность для выделенных на дереве пользователей }
//#UC START# *4924615E0279_49246742002B_var*
//#UC END# *4924615E0279_49246742002B_var*
begin
//#UC START# *4924615E0279_49246742002B_impl*
 SDS.SetPrivelegedRights(MakeSelectedList(aUserTree), IsPrivileged);
//#UC END# *4924615E0279_49246742002B_impl*
end;//TdsUserList.SetPrivelegedRights

procedure TdsUserList.SelectNodes(const aUserTree: Il3SimpleTree;
 const aList: IadminUserNodeList);
 {* Выделить ноды по списку (Il3SimpleNode) }
//#UC START# *492461970357_49246742002B_var*
var
 l_IDX: Integer;
 l_Node: INodeBase;
//#UC END# *492461970357_49246742002B_var*
begin
//#UC START# *492461970357_49246742002B_impl*
 if Supports(aUserTree.RootNode, INodeBase, l_Node) then
  l_Node.SetAllFlag(FM_SELECTION, False);
 for l_IDX := 0 to aList.Count - 1 do
  if Supports(aList[l_IDX], INodeBase, l_Node) then
   l_Node.SetFlag(FM_SELECTION, True);
//#UC END# *492461970357_49246742002B_impl*
end;//TdsUserList.SelectNodes

function TdsUserList.pm_GetCurrentFlagFilter: TUserListFilterTypes;
//#UC START# *492461B60284_49246742002Bget_var*
//#UC END# *492461B60284_49246742002Bget_var*
begin
//#UC START# *492461B60284_49246742002Bget_impl*
 Result := f_CurrentFlagFilter;
//#UC END# *492461B60284_49246742002Bget_impl*
end;//TdsUserList.pm_GetCurrentFlagFilter

function TdsUserList.pm_GetConsultingPaymentForNewbies: Boolean;
//#UC START# *492461FE0363_49246742002Bget_var*
//#UC END# *492461FE0363_49246742002Bget_var*
begin
//#UC START# *492461FE0363_49246742002Bget_impl*
 Result := SDS.ConsultingPaymentForNewbies;
//#UC END# *492461FE0363_49246742002Bget_impl*
end;//TdsUserList.pm_GetConsultingPaymentForNewbies

procedure TdsUserList.pm_SetConsultingPaymentForNewbies(aValue: Boolean);
//#UC START# *492461FE0363_49246742002Bset_var*
//#UC END# *492461FE0363_49246742002Bset_var*
begin
//#UC START# *492461FE0363_49246742002Bset_impl*
 SDS.ConsultingPaymentForNewbies := aValue
//#UC END# *492461FE0363_49246742002Bset_impl*
end;//TdsUserList.pm_SetConsultingPaymentForNewbies

procedure TdsUserList.NotifyCreateUserFinished(Successfull: Boolean);
 {* Нотификация об отскзе создания пользователя }
//#UC START# *49E5B8C7024C_49246742002B_var*
var
 l_Index    : Integer;
 l_Listener : IbsUserListViewListener;
 l_Item     : IUnknown;
//#UC END# *49E5B8C7024C_49246742002B_var*
begin
//#UC START# *49E5B8C7024C_49246742002B_impl*
 if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := NotifiedObjList.Items[l_Index];
   if Supports(l_Item, IbsUserListViewListener, l_Listener) and
     (l_Item = l_Listener) then
    l_Listener.CreateUserFinished(Successfull);
  end;//if (NotifiedObjList <> nil)
//#UC END# *49E5B8C7024C_49246742002B_impl*
end;//TdsUserList.NotifyCreateUserFinished

procedure TdsUserList.NotifyGroupChanged(aGroupUID: Integer);
 {* Сменилась группа }
//#UC START# *49F02BA70361_49246742002B_var*
var
 l_Index    : Integer;
 l_Listener : IbsUserListViewListener;
 l_Item     : IUnknown;
//#UC END# *49F02BA70361_49246742002B_var*
begin
//#UC START# *49F02BA70361_49246742002B_impl*
 if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := NotifiedObjList.Items[l_Index];
   if Supports(l_Item, IbsUserListViewListener, l_Listener) and
     (l_Item = l_Listener) then
    l_Listener.GroupChanged(aGroupUID);
  end;//if (NotifiedObjList <> nil)
//#UC END# *49F02BA70361_49246742002B_impl*
end;//TdsUserList.NotifyGroupChanged

function TdsUserList.FiltrateByGroup(const aTreeSource: Il3SimpleTree;
 const aCurrentNode: Il3SimpleNode;
 aFilter: Integer;
 out aCurrent: Integer): Il3SimpleTree;
//#UC START# *49F02C0400AA_49246742002B_var*
var
 l_FilterableTree: Il3FilterableTree;
 l_TreeFilters: InsUserFlagsFilters;

 function lp_MakeFilter: InsGroupFilter;
 begin
  if (CurrentGroupFilter <> GROUP_ALL_ID) and (CurrentGroupFilter <> cBadUID) then
   Result := TnsGroupFilter.Make(CurrentGroupFilter)
  else
   Result := nil;
 end;
//#UC END# *49F02C0400AA_49246742002B_var*
begin
//#UC START# *49F02C0400AA_49246742002B_impl*
 if (aFilter <> CurrentGroupFilter) and
    Supports(aTreeSource, Il3FilterableTree, l_FilterableTree) and
    Supports(l_FilterableTree.CloneFilters, InsUserFlagsFilters, l_TreeFilters) then
 begin
  f_CurrentGroupFilter := aFilter;
  Result := l_FilterableTree.MakeFiltered(l_TreeFilters.
                                          SetGroup(lp_MakeFilter).
                                          SetContext(pm_GetCurrentContextFilter.ActiveContext),
                                          aCurrentNode,
                                          aCurrent,
                                          True,
                                          True);


 end
 else
  Result := aTreeSource;
//#UC END# *49F02C0400AA_49246742002B_impl*
end;//TdsUserList.FiltrateByGroup

procedure TdsUserList.CheckUnsavedUserProperty;
 {* Если свойства не сохранены - спросить об этом }
//#UC START# *49F6DB9B02A8_49246742002B_var*
//#UC END# *49F6DB9B02A8_49246742002B_var*
begin
//#UC START# *49F6DB9B02A8_49246742002B_impl*
 SDS.CheckUnsavedUserProperty;
//#UC END# *49F6DB9B02A8_49246742002B_impl*
end;//TdsUserList.CheckUnsavedUserProperty

procedure TdsUserList.RequestUpdateCureent;
//#UC START# *49F6E0DB0163_49246742002B_var*
var
 l_Index    : Integer;
 l_Listener : IbsUserListViewListener;
 l_Item     : IUnknown;
//#UC END# *49F6E0DB0163_49246742002B_var*
begin
//#UC START# *49F6E0DB0163_49246742002B_impl*
 if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := NotifiedObjList.Items[l_Index];
   if Supports(l_Item, IbsUserListViewListener, l_Listener) and
     (l_Item = l_Listener) then
    l_Listener.RequestUpdateCurrent;
  end;//if (NotifiedObjList <> nil)
//#UC END# *49F6E0DB0163_49246742002B_impl*
end;//TdsUserList.RequestUpdateCureent

procedure TdsUserList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49246742002B_var*
//#UC END# *479731C50290_49246742002B_var*
begin
//#UC START# *479731C50290_49246742002B_impl*
 f_Root := nil;
 f_CurrentFlagFilter := ulftNone;
 inherited;
//#UC END# *479731C50290_49246742002B_impl*
end;//TdsUserList.Cleanup

procedure TdsUserList.DoCurrentChanged(const aNode: Il3SimpleNode);
 {* сменился текущий. }
//#UC START# *47F0C1BF0314_49246742002B_var*
var
 l_Node: INodeBase;
 l_Entity: IEntityBase;
 l_Profile: IUserProfile;
//#UC END# *47F0C1BF0314_49246742002B_var*
begin
//#UC START# *47F0C1BF0314_49246742002B_impl*
 if Supports(aNode, INodeBase, l_Node) then
 begin
  try
   l_Node.GetEntity(l_Entity);
   Supports(l_Entity, IUserProfile, l_Profile);
  except
   on ENoEntity do
    l_Profile := nil;
  end;
 end
 else
  l_Profile := nil;
 SDS.ChangeUser(TdeProfile.Make(l_Profile));
//#UC END# *47F0C1BF0314_49246742002B_impl*
end;//TdsUserList.DoCurrentChanged

function TdsUserList.MakeImageList: Il3ImageList;
 {* - создать иконки дерева. }
//#UC START# *47F465F80149_49246742002B_var*
//#UC END# *47F465F80149_49246742002B_var*
begin
//#UC START# *47F465F80149_49246742002B_impl*
 Result := vtMakeImageListWrapper(dmAdmin.ilUsers);
//#UC END# *47F465F80149_49246742002B_impl*
end;//TdsUserList.MakeImageList

{$If NOT Defined(NoVCM)}
procedure TdsUserList.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_49246742002B_var*
//#UC END# *492ACF630072_49246742002B_var*
begin
//#UC START# *492ACF630072_49246742002B_impl*
 inherited;
 f_Root := PartData.Node;
//#UC END# *492ACF630072_49246742002B_impl*
end;//TdsUserList.GotData
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsUserList.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 SDS := aDS As IsdsAdmin;
end;//TdsUserList.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsUserList.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 SDS := nil;
end;//TdsUserList.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
