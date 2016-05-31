unit PrimUserList_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserList_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimUserList" MUID: (49480F0901B9)
// ��� ����: "TPrimUserListForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Admin_Users_Controls
 , AdminInterfaces
 , l3Types
 , L10nInterfaces
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , eeTreeView
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimUserListForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , IbsUserListViewListener)
  private
   f_PrevUID: Integer;
    {* ID ����������� ������������, �� �������� ���� ������ � ������ ������ �������� ������ ������������ }
   f_AutoRegistration: Tl3Bool;
   f_FilterMap: InsIntegerValueMap;
   f_NeedFillFilterList: Boolean;
   UseCase: IsdsAdmin;
   f_BackgroundPanel: TvtPanel;
   f_ContextFilter: TnscContextFilter;
   f_trUserList: TeeTreeView;
  protected
   f_InCreateNew: Boolean;
   ViewArea: IdsUserList;
  private
   procedure ContextFilterChange(Sender: TObject);
   procedure ContextFilterWrongContext(Sender: TObject);
   procedure trUserListCountChanged(Sender: TObject;
    NewCount: LongInt);
   function trUserListGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure trUserListCurrentChanged(aSender: TObject;
    aNewCurrent: Integer;
    aOldCurrent: Integer);
   procedure trUserListTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure trUserListSelectCountChanged(aSender: TObject;
    anOldCount: Integer;
    aNewCount: Integer);
   procedure trUserListFormatStatusInfo(aSender: TObject;
    var Info: Il3CString;
    aCurrent: Integer;
    aCount: Integer;
    aSelected: Integer);
   procedure trUserListNewCharPressed(aChar: AnsiChar);
  protected
   function pm_GetAutoRegistration: Boolean;
   procedure SetPrivilegedRightTest(const aParams: IvcmTestParamsPrim;
    TargetValue: Boolean);
   procedure SetPrivilegedRight(IsPrivileged: Boolean);
   procedure PrepareConsultingParams(const aParams: IvcmTestParamsPrim;
    aDisable: Boolean);
   procedure SetConsultingPayment(IsAllowed: Boolean;
    ForAll: Boolean);
    {* ���������/��������� ����������� �������� ������������ ��� ����
           ������������� }
   procedure SelectFailed(const aList: IadminUserNodeList);
    {* �������� ���������� ������������� }
   procedure UpdateCurrent;
   function IsApplyMultiOperations: Boolean;
   procedure CheckUnsavedUserProperty;
   procedure CreateUserFinished(Successfull: Boolean);
   procedure GroupChanged(aGroupUID: Integer);
    {* ��������� ������ }
   procedure RequestUpdateCurrent;
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Users_Add_Test(const aParams: IvcmTestParamsPrim);
    {* �������� }
   procedure Users_Add_Execute(const aParams: IvcmExecuteParamsPrim);
    {* �������� }
   procedure Users_LogoutUser_Test(const aParams: IvcmTestParamsPrim);
    {* ��������� ������������ }
   procedure Users_LogoutUser_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ��������� ������������ }
   procedure Users_LogoutUser_GetState(var State: TvcmOperationStateIndex);
    {* ��������� ������������ }
   procedure Users_ConsultingStateForNewbie_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
   procedure Users_ConsultingStateForNewbie_GetState(var State: TvcmOperationStateIndex);
    {* ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
   procedure Users_Autoregistration_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ���������/��������� ��������������� ����� ������������� }
   procedure Users_Autoregistration_GetState(var State: TvcmOperationStateIndex);
    {* ���������/��������� ��������������� ����� ������������� }
   procedure Users_AddPrivelegedRight_Test(const aParams: IvcmTestParamsPrim);
    {* ������� ���������� ������������� ������������������ }
   procedure Users_AddPrivelegedRight_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������� ���������� ������������� ������������������ }
   procedure Users_AddPrivelegedRight_GetState(var State: TvcmOperationStateIndex);
    {* ������� ���������� ������������� ������������������ }
   procedure Users_RemovePrivelegedRight_Test(const aParams: IvcmTestParamsPrim);
    {* �������� ��� ���������� ������������� ����� ���������� }
   procedure Users_RemovePrivelegedRight_Execute(const aParams: IvcmExecuteParamsPrim);
    {* �������� ��� ���������� ������������� ����� ���������� }
   procedure Users_RemovePrivelegedRight_GetState(var State: TvcmOperationStateIndex);
    {* �������� ��� ���������� ������������� ����� ���������� }
   procedure Users_UserFilter_Test(const aParams: IvcmTestParamsPrim);
   procedure Users_UserFilter_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Users_DisableConsulting_Test(const aParams: IvcmTestParamsPrim);
   procedure Users_DisableConsulting_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Users_EnableConsulting_Test(const aParams: IvcmTestParamsPrim);
   procedure Users_EnableConsulting_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Users_MakeFiltersShared_Test(const aParams: IvcmTestParamsPrim);
    {* ������� ������� ������� ������������ ������ }
   procedure Users_MakeFiltersShared_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������� ������� ������� ������������ ������ }
   procedure Users_DenyDeleteIdle_Test(const aParams: IvcmTestParamsPrim);
    {* �� ������� ��� ����������� }
   procedure Users_DenyDeleteIdle_Execute(const aParams: IvcmExecuteParamsPrim);
    {* �� ������� ��� ����������� }
  protected
   property AutoRegistration: Boolean
    read pm_GetAutoRegistration;
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
   property ContextFilter: TnscContextFilter
    read f_ContextFilter;
   property trUserList: TeeTreeView
    read f_trUserList;
 end;//TPrimUserListForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , nsUserNodes
 , ForbidAutoregistration_Form
 , DataAdapter
 , l3Utils
 , bsTypes
 , SecurityUnit
 , dsForbidAutoregistration
 , nsValueMaps
 , nsValueMapsIDs
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsUtils
 , AdminRes
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , ForbidAutoregistration_ut_ForbidAutoregistration_UserType
 , PrimUserList_admUserList_UserType
 //#UC START# *49480F0901B9impl_uses*
 , l3ControlsTypes
 //#UC END# *49480F0901B9impl_uses*
;

{$If NOT Defined(NoVCM)}
const
 {* ������������ ������ PrimUserListConsts }
 str_DisableConsultingForAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DisableConsultingForAll'; rValue : '��������� ���� ������������� ������ ��������� �����������');
  {* '��������� ���� ������������� ������ ��������� �����������' }
 str_EnableConsultingForAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EnableConsultingForAll'; rValue : '��������� ���� ������������� ������ ��������� �����������');
  {* '��������� ���� ������������� ������ ��������� �����������' }
 str_DisableConsulting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DisableConsulting'; rValue : '��������� ������������� ������ ��������� �����������');
  {* '��������� ������������� ������ ��������� �����������' }
 str_EnableConsulting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EnableConsulting'; rValue : '��������� ������������� ������ ��������� �����������');
  {* '��������� ������������� ������ ��������� �����������' }
 str_FailedToDeleteUser: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FailedToDeleteUser'; rValue : '�� ������� ������� ������������ "%s"');
  {* '�� ������� ������� ������������ "%s"' }
 str_CannotDeleteActiveUser: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CannotDeleteActiveUser'; rValue : '���������� ������� ������������ "%s" ��� ��� �� �������� � �������');
  {* '���������� ������� ������������ "%s" ��� ��� �� �������� � �������' }

function TPrimUserListForm.pm_GetAutoRegistration: Boolean;
//#UC START# *4C7CE5B40225_49480F0901B9get_var*
//#UC END# *4C7CE5B40225_49480F0901B9get_var*
begin
//#UC START# *4C7CE5B40225_49480F0901B9get_impl*
 if not l3BoolCheck(f_AutoRegistration, Result) then
  Result := l3BoolSet(DefDataAdapter.Authorization.
   GetAutoregistrationStatus, f_AutoRegistration);
//#UC END# *4C7CE5B40225_49480F0901B9get_impl*
end;//TPrimUserListForm.pm_GetAutoRegistration

procedure TPrimUserListForm.SetPrivilegedRightTest(const aParams: IvcmTestParamsPrim;
 TargetValue: Boolean);
//#UC START# *4C7CE69202BD_49480F0901B9_var*
const
 c_States: array [Boolean] of TbsUserNodeTypes = ([untActivePrivileged, untInActivePrivileged], [untActiveNonSystem, untInActiveNonSystem]);
//#UC END# *4C7CE69202BD_49480F0901B9_var*
begin
//#UC START# *4C7CE69202BD_49480F0901B9_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.PrivelegedUsersAllowed and
 (IsApplyMultiOperations or
 (ViewArea.UserListNodeType(trUserList.GetCurrentNode) in c_States[TargetValue]));
//#UC END# *4C7CE69202BD_49480F0901B9_impl*
end;//TPrimUserListForm.SetPrivilegedRightTest

procedure TPrimUserListForm.SetPrivilegedRight(IsPrivileged: Boolean);
//#UC START# *4C7CE6BF018B_49480F0901B9_var*
//#UC END# *4C7CE6BF018B_49480F0901B9_var*
begin
//#UC START# *4C7CE6BF018B_49480F0901B9_impl*
 CheckUnsavedUserProperty;
 try
  if IsApplyMultiOperations then
  begin
   ViewArea.SetPrivelegedRights(trUserList.TreeStruct, IsPrivileged);
   Say(inf_MultiplyChangePrivilegedUsers);
  end
  else
   ViewArea.SetIsPrivileged(trUserList.GetCurrentNode, IsPrivileged);
 except
  on ENoMorePrivilegedProfiles do
   Say(err_PrivilegedUsersLicenceViolation);
 end;
 UpdateCurrent;
//#UC END# *4C7CE6BF018B_49480F0901B9_impl*
end;//TPrimUserListForm.SetPrivilegedRight

procedure TPrimUserListForm.PrepareConsultingParams(const aParams: IvcmTestParamsPrim;
 aDisable: Boolean);
//#UC START# *4C7CF2C0000D_49480F0901B9_var*
//#UC END# *4C7CF2C0000D_49480F0901B9_var*
begin
//#UC START# *4C7CF2C0000D_49480F0901B9_impl*
 with aParams.Op do
 begin
  if aDisable then
   if ViewArea.SimpleTree.SelectCount <= 1
    then Caption := str_DisableConsultingForAll.AsCStr
    else Caption := str_DisableConsulting.AsCStr
  else
   if ViewArea.SimpleTree.SelectCount <= 1
    then Caption := str_EnableConsultingForAll.AsCStr
    else Caption := str_EnableConsulting.AsCStr;
  with SubItems do
  begin
   Clear;
   if IsApplyMultiOperations then
   begin
    Add(vcmCStr(str_AllUsers));
    Add(vcmCStr(str_SelectedUsers));
   end;
  end;
 end;
//#UC END# *4C7CF2C0000D_49480F0901B9_impl*
end;//TPrimUserListForm.PrepareConsultingParams

procedure TPrimUserListForm.SetConsultingPayment(IsAllowed: Boolean;
 ForAll: Boolean);
 {* ���������/��������� ����������� �������� ������������ ��� ����
           ������������� }
//#UC START# *4C7CF2E301AC_49480F0901B9_var*
//#UC END# *4C7CF2E301AC_49480F0901B9_var*
begin
//#UC START# *4C7CF2E301AC_49480F0901B9_impl*
 CheckUnsavedUserProperty;
 if ForAll then
  ViewArea.SetConsultingPaymentForAll(IsAllowed)
 else
 begin
  ViewArea.SetConsultingPayment(trUserList.TreeStruct, IsAllowed);
  Say(inf_MultiplyChangeConsulting);
 end;
 UpdateCurrent;
//#UC END# *4C7CF2E301AC_49480F0901B9_impl*
end;//TPrimUserListForm.SetConsultingPayment

procedure TPrimUserListForm.ContextFilterChange(Sender: TObject);
//#UC START# *527BA0D70116_49480F0901B9_var*
var
 l_TreeSource: Il3SimpleTree;
 l_Current: Integer;
//#UC END# *527BA0D70116_49480F0901B9_var*
begin
//#UC START# *527BA0D70116_49480F0901B9_impl*
 with trUserList do
 begin
  l_TreeSource := ViewArea.FiltrateByContext(TreeStruct, GetCurrentNode,
   ContextFilter.MakeState, l_Current);
  if Assigned(l_TreeSource) and (l_TreeSource.CountView > 0) then
  begin
   Changing;
   try
    LockChangeSelected;
    try
     TreeStruct := l_TreeSource;
    finally
     UnLockChangeSelected;
    end;
   finally
    Changed;
   end;
   Current := l_Current;
  end;
 end;
//#UC END# *527BA0D70116_49480F0901B9_impl*
end;//TPrimUserListForm.ContextFilterChange

procedure TPrimUserListForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *527BA0DF0208_49480F0901B9_var*
//#UC END# *527BA0DF0208_49480F0901B9_var*
begin
//#UC START# *527BA0DF0208_49480F0901B9_impl*
 nsBeepWrongContext;
//#UC END# *527BA0DF0208_49480F0901B9_impl*
end;//TPrimUserListForm.ContextFilterWrongContext

procedure TPrimUserListForm.trUserListCountChanged(Sender: TObject;
 NewCount: LongInt);
//#UC START# *527BA0F301B9_49480F0901B9_var*
//#UC END# *527BA0F301B9_49480F0901B9_var*
begin
//#UC START# *527BA0F301B9_49480F0901B9_impl*
 UpdateStatusInfo;
//#UC END# *527BA0F301B9_49480F0901B9_impl*
end;//TPrimUserListForm.trUserListCountChanged

function TPrimUserListForm.trUserListGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *527BA0FC02E6_49480F0901B9_var*
const
 cImageIndexMap: array [TbsUserNodeType] of Integer = (
  ciiUser, // untUnknownUser,
  ciiAdmin, // untActiveSystem,
  ciiUser, // untActiveNonSystem,
  ciiAdmin_NA, // untInactiveSystem,
  ciiUser_NA, // untInactiveNonSystem,
  ciiExiting, // untExiting
  ciiPriveleged, // untActivePrivileged
  ciiPriveleged_NA // untInActivePrivileged
 );
//#UC END# *527BA0FC02E6_49480F0901B9_var*
begin
//#UC START# *527BA0FC02E6_49480F0901B9_impl*
 if Assigned(ViewArea) then
  Result := cImageIndexMap[ViewArea.UserListNodeType(trUserList.GetNode(Index))]
 else
  Result := ciiUser_NA;
//#UC END# *527BA0FC02E6_49480F0901B9_impl*
end;//TPrimUserListForm.trUserListGetItemImage

procedure TPrimUserListForm.trUserListCurrentChanged(aSender: TObject;
 aNewCurrent: Integer;
 aOldCurrent: Integer);
//#UC START# *527BA10403A2_49480F0901B9_var*
//#UC END# *527BA10403A2_49480F0901B9_var*
begin
//#UC START# *527BA10403A2_49480F0901B9_impl*
 UpdateCurrent;
//#UC END# *527BA10403A2_49480F0901B9_impl*
end;//TPrimUserListForm.trUserListCurrentChanged

procedure TPrimUserListForm.trUserListTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *527BA10C0374_49480F0901B9_var*
//#UC END# *527BA10C0374_49480F0901B9_var*
begin
//#UC START# *527BA10C0374_49480F0901B9_impl*
 UpdateStatusInfo;
//#UC END# *527BA10C0374_49480F0901B9_impl*
end;//TPrimUserListForm.trUserListTreeChanged

procedure TPrimUserListForm.trUserListSelectCountChanged(aSender: TObject;
 anOldCount: Integer;
 aNewCount: Integer);
//#UC START# *527BA116033D_49480F0901B9_var*
//#UC END# *527BA116033D_49480F0901B9_var*
begin
//#UC START# *527BA116033D_49480F0901B9_impl*
 UpdateStatusInfo;
//#UC END# *527BA116033D_49480F0901B9_impl*
end;//TPrimUserListForm.trUserListSelectCountChanged

procedure TPrimUserListForm.trUserListFormatStatusInfo(aSender: TObject;
 var Info: Il3CString;
 aCurrent: Integer;
 aCount: Integer;
 aSelected: Integer);
//#UC START# *527BA11F00E0_49480F0901B9_var*
//#UC END# *527BA11F00E0_49480F0901B9_var*
begin
//#UC START# *527BA11F00E0_49480F0901B9_impl*
 if trUserList.TreeStruct.RootNode.HasChild then
  Info := vcmFmt(vcmCStr(str_UserListStatus), [trUserList.TreeStruct.RootNode.ThisChildrenCount, aSelected])
 else
  Info := nil;
//#UC END# *527BA11F00E0_49480F0901B9_impl*
end;//TPrimUserListForm.trUserListFormatStatusInfo

procedure TPrimUserListForm.trUserListNewCharPressed(aChar: AnsiChar);
//#UC START# *527BA12D0073_49480F0901B9_var*
//#UC END# *527BA12D0073_49480F0901B9_var*
begin
//#UC START# *527BA12D0073_49480F0901B9_impl*
 ContextFilter.PressChar(aChar);
//#UC END# *527BA12D0073_49480F0901B9_impl*
end;//TPrimUserListForm.trUserListNewCharPressed

procedure TPrimUserListForm.SelectFailed(const aList: IadminUserNodeList);
 {* �������� ���������� ������������� }
//#UC START# *494FC4EF0305_49480F0901B9_var*
//#UC END# *494FC4EF0305_49480F0901B9_var*
begin
//#UC START# *494FC4EF0305_49480F0901B9_impl*
 Assert(aList.Count > 0);
 with trUserList do
 begin
  Changing;
  try
   vlbDeselectAllItems;
   ViewArea.SelectNodes(TreeStruct, aList);
   GotoOnNode(aList[0]);
  finally
   Changed;
   UpdateCurrent;
  end;
 end;
//#UC END# *494FC4EF0305_49480F0901B9_impl*
end;//TPrimUserListForm.SelectFailed

procedure TPrimUserListForm.UpdateCurrent;
//#UC START# *494FC5BF03BD_49480F0901B9_var*
//#UC END# *494FC5BF03BD_49480F0901B9_var*
begin
//#UC START# *494FC5BF03BD_49480F0901B9_impl*
 if not f_InCreateNew then
  ViewArea.CurrentChanged(trUserList.GetCurrentNode);
 UpdateStatusInfo;
//#UC END# *494FC5BF03BD_49480F0901B9_impl*
end;//TPrimUserListForm.UpdateCurrent

function TPrimUserListForm.IsApplyMultiOperations: Boolean;
//#UC START# *494FC5D003DD_49480F0901B9_var*
//#UC END# *494FC5D003DD_49480F0901B9_var*
begin
//#UC START# *494FC5D003DD_49480F0901B9_impl*
 Result := trUserList.TreeStruct.SelectCount > 1;
//#UC END# *494FC5D003DD_49480F0901B9_impl*
end;//TPrimUserListForm.IsApplyMultiOperations

procedure TPrimUserListForm.CheckUnsavedUserProperty;
//#UC START# *49F6DCF102A7_49480F0901B9_var*
//#UC END# *49F6DCF102A7_49480F0901B9_var*
begin
//#UC START# *49F6DCF102A7_49480F0901B9_impl*
 ViewArea.CheckUnsavedUserProperty;
//#UC END# *49F6DCF102A7_49480F0901B9_impl*
end;//TPrimUserListForm.CheckUnsavedUserProperty

procedure TPrimUserListForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* ������� }
//#UC START# *494F89C30197_49480F0901B9test_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *494F89C30197_49480F0901B9test_var*
begin
//#UC START# *494F89C30197_49480F0901B9test_impl*
 if aParams.Control = trUserList then
 begin
  l_Node := trUserList.GetCurrentNode;
  aParams.Op.Flag[vcm_ofEnabled] := IsApplyMultiOperations or
                                    (Assigned(l_Node) and (ViewArea.GetUserState(l_Node)=[]));
 end
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *494F89C30197_49480F0901B9test_impl*
end;//TPrimUserListForm.Edit_Delete_Test

procedure TPrimUserListForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������� }
//#UC START# *494F89C30197_49480F0901B9exec_var*
var
 l_CurrentNode: Il3SimpleNode;
 l_ErrList: IadminUserNodeList;
 l_Failed: Boolean;
//#UC END# *494F89C30197_49480F0901B9exec_var*
begin
//#UC START# *494F89C30197_49480F0901B9exec_impl*
 if aParams.Control = trUserList then
 begin
  if IsApplyMultiOperations then
  begin
   if Ask(qr_DeleteUsers, [trUserList.TreeStruct.SelectCount]) then
   begin
    ViewArea.DeleteUsers(trUserList.TreeStruct, l_ErrList);
    if (l_ErrList.Count > 0) then
    begin
     if Ask(qr_UsersDeleteFailed) then
      SelectFailed(l_ErrList);
    end
    else
     Say(inf_UsersDeleted);
   end;
  end
  else
  begin
   l_CurrentNode := trUserList.GetCurrentNode;
   if Assigned(l_CurrentNode) and Ask(qr_DeleteUser, [l3CStr(l_CurrentNode)]) then
   begin
    // ���� ����� ������ � �������� ������� ��� ��� - ������������ ��� ������������,
    // � ��� �� ����� ������.
    // http://mdp.garant.ru/pages/viewpage.action?pageId=508180160
    if (ViewArea.GetUserState(l_CurrentNode) = []) then
    begin
     ViewArea.DeleteUser(l_CurrentNode, l_Failed);
     if l_Failed then
      vcmSay(str_FailedToDeleteUser, [l3CStr(l_CurrentNode)]);
    end
    else
     vcmSay(str_CannotDeleteActiveUser, [l3CStr(l_CurrentNode)]);
   end;
  end;
 end
 else
  aParams.CallControl;
//#UC END# *494F89C30197_49480F0901B9exec_impl*
end;//TPrimUserListForm.Edit_Delete_Execute

procedure TPrimUserListForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
 {* ������� }
//#UC START# *494F89C30197_49480F0901B9getstate_var*
//#UC END# *494F89C30197_49480F0901B9getstate_var*
begin
//#UC START# *494F89C30197_49480F0901B9getstate_impl*
 //if aParams.Control = trUserList then
 begin
  if IsApplyMultiOperations then
   State := st_user_Edit_Delete_MultiUsers
  else
   State := st_user_Edit_Delete_User;
 end;  
//#UC END# *494F89C30197_49480F0901B9getstate_impl*
end;//TPrimUserListForm.Edit_Delete_GetState

procedure TPrimUserListForm.Users_Add_Test(const aParams: IvcmTestParamsPrim);
 {* �������� }
//#UC START# *494FD65902BF_49480F0901B9test_var*
//#UC END# *494FD65902BF_49480F0901B9test_var*
begin
//#UC START# *494FD65902BF_49480F0901B9test_impl*
 // - ������ �� ������
//#UC END# *494FD65902BF_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_Add_Test

procedure TPrimUserListForm.Users_Add_Execute(const aParams: IvcmExecuteParamsPrim);
 {* �������� }
//#UC START# *494FD65902BF_49480F0901B9exec_var*
//#UC END# *494FD65902BF_49480F0901B9exec_var*
begin
//#UC START# *494FD65902BF_49480F0901B9exec_impl*
 f_InCreateNew := True;
 try
  f_PrevUID := GetUserID(trUserList.GetCurrentNode);
  trUserList.AllowWithoutCurrent := True;
  trUserList.Current := -1;
  ViewArea.CreateNewUser;
 finally
  f_InCreateNew := False;
 end;
//#UC END# *494FD65902BF_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_Add_Execute

procedure TPrimUserListForm.CreateUserFinished(Successfull: Boolean);
//#UC START# *49E5B915022D_49480F0901B9_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *49E5B915022D_49480F0901B9_var*
begin
//#UC START# *49E5B915022D_49480F0901B9_impl*
 if not Successfull then
 begin
  l_Node := GetUserByID(f_PrevUID, trUserList.TreeStruct);
  if Assigned(l_Node) then
   trUserList.GotoOnNode(l_Node)
  else
   trUserList.Current := 0;
 end;  
 trUserList.AllowWithoutCurrent := False;
//#UC END# *49E5B915022D_49480F0901B9_impl*
end;//TPrimUserListForm.CreateUserFinished

procedure TPrimUserListForm.GroupChanged(aGroupUID: Integer);
 {* ��������� ������ }
//#UC START# *49F02DCF0116_49480F0901B9_var*
var
 l_TreeSource: Il3SimpleTree;
 l_Current: Integer;
//#UC END# *49F02DCF0116_49480F0901B9_var*
begin
//#UC START# *49F02DCF0116_49480F0901B9_impl*
 with trUserList do
 begin
  l_TreeSource := ViewArea.FiltrateByGroup(TreeStruct, GetCurrentNode, aGroupUID, l_Current);
  if Assigned(l_TreeSource) then
  begin
   Changing;
   try
    LockChangeSelected;
    try
     ContextFilter.BeginAssignState;
     try
      TreeStruct := l_TreeSource;
     finally
      ContextFilter.EndAssignState;
     end;
    finally
     UnLockChangeSelected;
    end;
   finally
    Changed;
   end;
   Current := l_Current;
   UpdateCurrent;
  end;
  ContextFilter.UpdateIsContextWrong;
 end;
//#UC END# *49F02DCF0116_49480F0901B9_impl*
end;//TPrimUserListForm.GroupChanged

procedure TPrimUserListForm.RequestUpdateCurrent;
//#UC START# *49F6E0C101AC_49480F0901B9_var*
//#UC END# *49F6E0C101AC_49480F0901B9_var*
begin
//#UC START# *49F6E0C101AC_49480F0901B9_impl*
 UpdateCurrent;
//#UC END# *49F6E0C101AC_49480F0901B9_impl*
end;//TPrimUserListForm.RequestUpdateCurrent

procedure TPrimUserListForm.Users_LogoutUser_Test(const aParams: IvcmTestParamsPrim);
 {* ��������� ������������ }
//#UC START# *4C7CDF1B0192_49480F0901B9test_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *4C7CDF1B0192_49480F0901B9test_var*
begin
//#UC START# *4C7CDF1B0192_49480F0901B9test_impl*
 l_Node := trUserList.GetCurrentNode;
 aParams.Op.Flag[vcm_ofEnabled] := IsApplyMultiOperations or (usActive in ViewArea.GetUserState(l_Node));
//#UC END# *4C7CDF1B0192_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_LogoutUser_Test

procedure TPrimUserListForm.Users_LogoutUser_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ��������� ������������ }
//#UC START# *4C7CDF1B0192_49480F0901B9exec_var*
//#UC END# *4C7CDF1B0192_49480F0901B9exec_var*
begin
//#UC START# *4C7CDF1B0192_49480F0901B9exec_impl*
 try
  if IsApplyMultiOperations then
  begin
   if Ask(qr_LogoutUsers, [trUserList.TreeStruct.SelectCount]) then
   begin
    ViewArea.LogoutUsers(trUserList.TreeStruct);
    Say(inf_LogoutUsersNotify);
   end;
  end
  else
  begin
   ViewArea.LogoutUser(trUserList.GetCurrentNode);
   Say(inf_LogoutUserNotify);
  end;
 except
  on ETryLogoutCurrentUser do
   Say(war_TryLogoutCurrent);
 end;
//#UC END# *4C7CDF1B0192_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_LogoutUser_Execute

procedure TPrimUserListForm.Users_LogoutUser_GetState(var State: TvcmOperationStateIndex);
 {* ��������� ������������ }
//#UC START# *4C7CDF1B0192_49480F0901B9getstate_var*
//#UC END# *4C7CDF1B0192_49480F0901B9getstate_var*
begin
//#UC START# *4C7CDF1B0192_49480F0901B9getstate_impl*
 if IsApplyMultiOperations then
  State := st_user_Users_LogoutUser_MultiUsers
 else
  State := st_user_Users_LogoutUser_SingleUser;
//#UC END# *4C7CDF1B0192_49480F0901B9getstate_impl*
end;//TPrimUserListForm.Users_LogoutUser_GetState

procedure TPrimUserListForm.Users_ConsultingStateForNewbie_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
//#UC START# *4C7CDF570361_49480F0901B9exec_var*
//#UC END# *4C7CDF570361_49480F0901B9exec_var*
begin
//#UC START# *4C7CDF570361_49480F0901B9exec_impl*
 ViewArea.ConsultingPaymentForNewbies := not ViewArea.ConsultingPaymentForNewbies;
//#UC END# *4C7CDF570361_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_ConsultingStateForNewbie_Execute

procedure TPrimUserListForm.Users_ConsultingStateForNewbie_GetState(var State: TvcmOperationStateIndex);
 {* ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
//#UC START# *4C7CDF570361_49480F0901B9getstate_var*
//#UC END# *4C7CDF570361_49480F0901B9getstate_var*
begin
//#UC START# *4C7CDF570361_49480F0901B9getstate_impl*
 if ViewArea.ConsultingPaymentForNewbies then
  State := st_user_Users_ConsultingStateForNewbie_Enabled
 else
  State := st_user_Users_ConsultingStateForNewbie_Disabled;
//#UC END# *4C7CDF570361_49480F0901B9getstate_impl*
end;//TPrimUserListForm.Users_ConsultingStateForNewbie_GetState

procedure TPrimUserListForm.Users_Autoregistration_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ���������/��������� ��������������� ����� ������������� }
//#UC START# *4C7CDFE10330_49480F0901B9exec_var*
var
 l_ForbidAutoregistration: IdsForbidAutoregistration;
//#UC END# *4C7CDFE10330_49480F0901B9exec_var*
begin
//#UC START# *4C7CDFE10330_49480F0901B9exec_impl*
 // ������������� ����� ��������� �������������� ����������� �������������.
 // ����� �������� �������������� ������������ �����, � ������� �� ���������
 // ���� ����������, � ����� ������������ ������ �������� �� ����� "OK". ����
 // ������������ ������ ����� �� "Cancel", �� ������ �� ���������������
 // (CQ: OIT5-25328):
 if AutoRegistration then
 begin
  l_ForbidAutoregistration := TdsForbidAutoregistration.Make(nil);
  try
   TefForbidAutoregistration.Make(nil,
                                  vcm_ztModal,
                                  0,
                                  l_ForbidAutoregistration);
   if not l_ForbidAutoregistration.NeedForbid then
    Exit;
  finally
   l_ForbidAutoregistration := nil;
  end;//try..finally
 end;//if AutoRegistration then
 DefDataAdapter.Authorization.
  SetAutoregistrationStatus(not AutoRegistration);
 l3BoolReset(f_AutoRegistration);
//#UC END# *4C7CDFE10330_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_Autoregistration_Execute

procedure TPrimUserListForm.Users_Autoregistration_GetState(var State: TvcmOperationStateIndex);
 {* ���������/��������� ��������������� ����� ������������� }
//#UC START# *4C7CDFE10330_49480F0901B9getstate_var*
//#UC END# *4C7CDFE10330_49480F0901B9getstate_var*
begin
//#UC START# *4C7CDFE10330_49480F0901B9getstate_impl*
 if AutoRegistration then
  State := st_user_Users_Autoregistration_Enabled
   // - ��������� ���������������;
 else
  State := st_user_Users_Autoregistration_Disabled;
   // - ��������� ���������������;
//#UC END# *4C7CDFE10330_49480F0901B9getstate_impl*
end;//TPrimUserListForm.Users_Autoregistration_GetState

procedure TPrimUserListForm.Users_AddPrivelegedRight_Test(const aParams: IvcmTestParamsPrim);
 {* ������� ���������� ������������� ������������������ }
//#UC START# *4C7CE03100BF_49480F0901B9test_var*
//#UC END# *4C7CE03100BF_49480F0901B9test_var*
begin
//#UC START# *4C7CE03100BF_49480F0901B9test_impl*
 SetPrivilegedRightTest(aParams, true);
//#UC END# *4C7CE03100BF_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_AddPrivelegedRight_Test

procedure TPrimUserListForm.Users_AddPrivelegedRight_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������� ���������� ������������� ������������������ }
//#UC START# *4C7CE03100BF_49480F0901B9exec_var*
//#UC END# *4C7CE03100BF_49480F0901B9exec_var*
begin
//#UC START# *4C7CE03100BF_49480F0901B9exec_impl*
 SetPrivilegedRight(True);
//#UC END# *4C7CE03100BF_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_AddPrivelegedRight_Execute

procedure TPrimUserListForm.Users_AddPrivelegedRight_GetState(var State: TvcmOperationStateIndex);
 {* ������� ���������� ������������� ������������������ }
//#UC START# *4C7CE03100BF_49480F0901B9getstate_var*
//#UC END# *4C7CE03100BF_49480F0901B9getstate_var*
begin
//#UC START# *4C7CE03100BF_49480F0901B9getstate_impl*
 if IsApplyMultiOperations then
  State := st_user_Users_AddPrivelegedRight_MultiUsers
 else
  State := st_user_Users_AddPrivelegedRight_SingleUser;
//#UC END# *4C7CE03100BF_49480F0901B9getstate_impl*
end;//TPrimUserListForm.Users_AddPrivelegedRight_GetState

procedure TPrimUserListForm.Users_RemovePrivelegedRight_Test(const aParams: IvcmTestParamsPrim);
 {* �������� ��� ���������� ������������� ����� ���������� }
//#UC START# *4C7CE0710199_49480F0901B9test_var*
//#UC END# *4C7CE0710199_49480F0901B9test_var*
begin
//#UC START# *4C7CE0710199_49480F0901B9test_impl*
 SetPrivilegedRightTest(aParams, false);
//#UC END# *4C7CE0710199_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_RemovePrivelegedRight_Test

procedure TPrimUserListForm.Users_RemovePrivelegedRight_Execute(const aParams: IvcmExecuteParamsPrim);
 {* �������� ��� ���������� ������������� ����� ���������� }
//#UC START# *4C7CE0710199_49480F0901B9exec_var*
//#UC END# *4C7CE0710199_49480F0901B9exec_var*
begin
//#UC START# *4C7CE0710199_49480F0901B9exec_impl*
 SetPrivilegedRight(False);
//#UC END# *4C7CE0710199_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_RemovePrivelegedRight_Execute

procedure TPrimUserListForm.Users_RemovePrivelegedRight_GetState(var State: TvcmOperationStateIndex);
 {* �������� ��� ���������� ������������� ����� ���������� }
//#UC START# *4C7CE0710199_49480F0901B9getstate_var*
//#UC END# *4C7CE0710199_49480F0901B9getstate_var*
begin
//#UC START# *4C7CE0710199_49480F0901B9getstate_impl*
 if IsApplyMultiOperations then
  State := st_user_Users_RemovePrivelegedRight_MultiUsers
 else
  State := st_user_Users_RemovePrivelegedRight_SingleUser;
//#UC END# *4C7CE0710199_49480F0901B9getstate_impl*
end;//TPrimUserListForm.Users_RemovePrivelegedRight_GetState

procedure TPrimUserListForm.Users_UserFilter_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7CEDAC0209_49480F0901B9test_var*
var
 l_Strings: IvcmStrings;
 l_StringSource: InsStringsSource;
//#UC END# *4C7CEDAC0209_49480F0901B9test_var*
begin
//#UC START# *4C7CEDAC0209_49480F0901B9test_impl*
 l_Strings := aParams.Op.SubItems;
 if Assigned(l_Strings) then
 begin
  if (l_Strings.Count = 0) or f_NeedFillFilterList then
   if Supports(f_FilterMap, InsStringsSource, l_StringSource) then
   begin
    l_StringSource.FillStrings(l_Strings);
    f_NeedFillFilterList := False;
   end;
  aParams.Op.SelectedString := f_FilterMap.
   ValueToDisplayName(Ord(ViewArea.CurrentFlagFilter));
 end;//if Assigned(l_Strings) then
//#UC END# *4C7CEDAC0209_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_UserFilter_Test

procedure TPrimUserListForm.Users_UserFilter_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7CEDAC0209_49480F0901B9exec_var*
var
 l_TreeSource: Il3SimpleTree;
 l_Current: Integer;
//#UC END# *4C7CEDAC0209_49480F0901B9exec_var*
begin
//#UC START# *4C7CEDAC0209_49480F0901B9exec_impl*
 with trUserList do
 begin
  l_TreeSource := ViewArea.FiltrateByType(TreeStruct, GetCurrentNode,
   TUserListFilterTypes(f_FilterMap.DisplayNameToValue(aParams.SelectedString)),
   l_Current);
  if Assigned(l_TreeSource) then
  begin
   Changing;
   try
    LockChangeSelected;
    try
     ContextFilter.BeginAssignState;
     try
      TreeStruct := l_TreeSource;
     finally
      ContextFilter.EndAssignState;
     end;
    finally
     UnLockChangeSelected;
    end;
   finally
    Changed;
   end;
   Current := l_Current;
  end;
  ContextFilter.UpdateIsContextWrong;
 end;
//#UC END# *4C7CEDAC0209_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_UserFilter_Execute

procedure TPrimUserListForm.Users_DisableConsulting_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7CEDB701D6_49480F0901B9test_var*
//#UC END# *4C7CEDB701D6_49480F0901B9test_var*
begin
//#UC START# *4C7CEDB701D6_49480F0901B9test_impl*
 PrepareConsultingParams(aParams, True);
//#UC END# *4C7CEDB701D6_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_DisableConsulting_Test

procedure TPrimUserListForm.Users_DisableConsulting_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7CEDB701D6_49480F0901B9exec_var*
//#UC END# *4C7CEDB701D6_49480F0901B9exec_var*
begin
//#UC START# *4C7CEDB701D6_49480F0901B9exec_impl*
 SetConsultingPayment(False, aParams.ItemIndex < 2);
//#UC END# *4C7CEDB701D6_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_DisableConsulting_Execute

procedure TPrimUserListForm.Users_EnableConsulting_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7CEDC20353_49480F0901B9test_var*
//#UC END# *4C7CEDC20353_49480F0901B9test_var*
begin
//#UC START# *4C7CEDC20353_49480F0901B9test_impl*
 PrepareConsultingParams(aParams, False);
//#UC END# *4C7CEDC20353_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_EnableConsulting_Test

procedure TPrimUserListForm.Users_EnableConsulting_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7CEDC20353_49480F0901B9exec_var*
//#UC END# *4C7CEDC20353_49480F0901B9exec_var*
begin
//#UC START# *4C7CEDC20353_49480F0901B9exec_impl*
 SetConsultingPayment(True, aParams.ItemIndex < 2);
//#UC END# *4C7CEDC20353_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_EnableConsulting_Execute

procedure TPrimUserListForm.Users_MakeFiltersShared_Test(const aParams: IvcmTestParamsPrim);
 {* ������� ������� ������� ������������ ������ }
//#UC START# *4E807746035F_49480F0901B9test_var*
var
 l_UID : Integer;
//#UC END# *4E807746035F_49480F0901B9test_var*
begin
//#UC START# *4E807746035F_49480F0901B9test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (trUserList.GetCurrentNode <> nil) and
                                   (trUserList.SelectedCount = 1);
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  l_UID := GetUserID(trUserList.GetCurrentNode);
  aParams.Op.Flag[vcm_ofChecked] := defDataAdapter.NativeAdapter.MakeUserManager.HasSharedFilters(l_UID);
 end;//aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *4E807746035F_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_MakeFiltersShared_Test

procedure TPrimUserListForm.Users_MakeFiltersShared_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������� ������� ������� ������������ ������ }
//#UC START# *4E807746035F_49480F0901B9exec_var*
var
 l_UID : Integer;
 l_Has : Boolean;
//#UC END# *4E807746035F_49480F0901B9exec_var*
begin
//#UC START# *4E807746035F_49480F0901B9exec_impl*
 l_UID := GetUserID(trUserList.GetCurrentNode);
 with defDataAdapter.NativeAdapter.MakeUserManager do
 begin
  l_Has := HasSharedFilters(l_UID);
  SetSharedFiltersState(l_UID, not l_Has);
 end;//with defDataAdapter.NativeAdapter.MakeUserManager
 ViewArea.RequestUpdateCureent;
//#UC END# *4E807746035F_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_MakeFiltersShared_Execute

procedure TPrimUserListForm.Users_DenyDeleteIdle_Test(const aParams: IvcmTestParamsPrim);
 {* �� ������� ��� ����������� }
//#UC START# *4F3D030901C3_49480F0901B9test_var*
var
 l_UID: Integer;
 l_Node: Il3SimpleNode;
//#UC END# *4F3D030901C3_49480F0901B9test_var*
begin
//#UC START# *4F3D030901C3_49480F0901B9test_impl*
 aParams.Op.Flag[vcm_ofVisible] := defDataAdapter.CommonInterfaces.IsEraseOfInactiveUsersEnabled;
 l_Node := trUserList.GetCurrentNode;
 aParams.Op.Flag[vcm_ofEnabled] := not UseCase.dsUserProperty.IsSystem
                                   and (l_Node <> nil)
                                   and (trUserList.SelectedCount = 1);
 if l_Node <> nil then
 begin
  l_UID := GetUserID(l_Node);
  aParams.Op.Flag[vcm_ofChecked] := UseCase.dsUserProperty.IsSystem or not defDataAdapter.NativeAdapter.MakeUserManager.IsErasable(l_UID);
 end;
//#UC END# *4F3D030901C3_49480F0901B9test_impl*
end;//TPrimUserListForm.Users_DenyDeleteIdle_Test

procedure TPrimUserListForm.Users_DenyDeleteIdle_Execute(const aParams: IvcmExecuteParamsPrim);
 {* �� ������� ��� ����������� }
//#UC START# *4F3D030901C3_49480F0901B9exec_var*
var
 l_UID : Integer;
 l_CanDelete : Boolean;
//#UC END# *4F3D030901C3_49480F0901B9exec_var*
begin
//#UC START# *4F3D030901C3_49480F0901B9exec_impl*
 l_UID := GetUserID(trUserList.GetCurrentNode);
 with defDataAdapter.NativeAdapter.MakeUserManager do
 begin
  l_CanDelete := IsErasable(l_UID);
  SetErasableState(l_UID, not l_CanDelete);
 end;//with defDataAdapter.NativeAdapter.MakeUserManager
 ViewArea.RequestUpdateCureent;
//#UC END# *4F3D030901C3_49480F0901B9exec_impl*
end;//TPrimUserListForm.Users_DenyDeleteIdle_Execute

procedure TPrimUserListForm.InitFields;
//#UC START# *47A042E100E2_49480F0901B9_var*
//#UC END# *47A042E100E2_49480F0901B9_var*
begin
//#UC START# *47A042E100E2_49480F0901B9_impl*
 inherited;
 f_FilterMap := nsIntegerMapManager.Map[imap_UserListFilterTypes];
//#UC END# *47A042E100E2_49480F0901B9_impl*
end;//TPrimUserListForm.InitFields

procedure TPrimUserListForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_49480F0901B9_var*
//#UC END# *47EA4E9002C6_49480F0901B9_var*
begin
//#UC START# *47EA4E9002C6_49480F0901B9_impl*
 inherited;
 f_NeedFillFilterList := True;
//#UC END# *47EA4E9002C6_49480F0901B9_impl*
end;//TPrimUserListForm.FinishDataUpdate

procedure TPrimUserListForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* ��������� �������� ������. ��� ���������� � �������� }
//#UC START# *497469C90140_49480F0901B9_var*
var
 l_CurrentNode: IdeNode;
 l_Current: LongInt;
//#UC END# *497469C90140_49480F0901B9_var*
begin
//#UC START# *497469C90140_49480F0901B9_impl*
 inherited;
 if (anOld <> nil) then
  anOld.Unsubscribe(IbsUserListViewListener(Self));
 if (aNew <> nil) then
  aNew.Subscribe(IbsUserListViewListener(Self));

 if Assigned(ViewArea) then
 begin
  l_CurrentNode := ViewArea.GetFrosenNode(trUserList.GetCurrentNode);
  with trUserList do
  begin
   Images := ViewArea.ImageList.Hack;
   if not Dispatcher.History.InBF then
   begin
    TreeStruct := ViewArea.SimpleTree;
    ContextFilter.AssignState(ViewArea.CurrentContextFilter);
   end;
   UpdateStatusInfo;
   if Assigned(l_CurrentNode) then
   begin
    // ������ ����������� ���� ������������ ������� � ��������� ������ �� ����
    l_Current := ViewArea.FindFrosenNode(l_CurrentNode, ShowRoot);
    if l_Current >= 0 then
     Current := l_Current;
    ViewArea.CurrentChanged(trUserList.GetCurrentNode);
   end;
  end;

  ContextFilter.UpdateIsContextWrong;
 end;
//#UC END# *497469C90140_49480F0901B9_impl*
end;//TPrimUserListForm.NotifyDataSourceChanged

procedure TPrimUserListForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_49480F0901B9_var*
//#UC END# *49803F5503AA_49480F0901B9_var*
begin
//#UC START# *49803F5503AA_49480F0901B9_impl*
 inherited;
 l3BoolReset(f_AutoRegistration);
 ContextFilter.Images := dmStdRes.SmallImageList;
 UpdateStatusInfo;

 Width := 696;
 Height := 480;
//#UC END# *49803F5503AA_49480F0901B9_impl*
end;//TPrimUserListForm.DoInit

procedure TPrimUserListForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_49480F0901B9_var*
//#UC END# *4A8E8F2E0195_49480F0901B9_var*
begin
//#UC START# *4A8E8F2E0195_49480F0901B9_impl*
 inherited;

 ActiveControl := trUserList;

 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ContextFilter do
 begin
  ImageIndex := 77;
  ContextFilterTarget := trUserList;
  OnChange := ContextFilterChange;
  OnWrongContext := ContextFilterWrongContext;
 end;
 with trUserList do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  DragAndDropSupported := True;
  MultiSelect := True;
  ViewOptions := [voShowIcons];
  NeedStatus := True;
  OnGetItemImage := trUserListGetItemImage;
  OnCurrentChanged := trUserListCurrentChanged;
  OnTreeChanged := trUserListTreeChanged;
  OnSelectCountChanged := trUserListSelectCountChanged;
  OnFormatStatusInfo := trUserListFormatStatusInfo;
  OnNewCharPressed := trUserListNewCharPressed;
  OnCountChanged := trUserListCountChanged;
 end;
//#UC END# *4A8E8F2E0195_49480F0901B9_impl*
end;//TPrimUserListForm.InitControls

procedure TPrimUserListForm.ClearFields;
begin
 f_FilterMap := nil;
 inherited;
end;//TPrimUserListForm.ClearFields

procedure TPrimUserListForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  ViewArea := nil;
  UseCase := nil;
 end//aNew = nil
 else
 begin
  ViewArea := aNew As IdsUserList;
  aNew.CastUCC(IsdsAdmin, UseCase);
 end;//aNew = nil
end;//TPrimUserListForm.SignalDataSourceChanged

procedure TPrimUserListForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Users, nil);
  MakeEntitySupportedByControl(en_Edit, ContextFilter);
  MakeEntitySupportedByControl(en_Edit, trUserList);
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  PublishOp(en_Users, op_Add, Users_Add_Execute, Users_Add_Test, nil);
  PublishOp(en_Users, op_LogoutUser, Users_LogoutUser_Execute, Users_LogoutUser_Test, Users_LogoutUser_GetState);
  PublishOp(en_Users, op_ConsultingStateForNewbie, Users_ConsultingStateForNewbie_Execute, nil, Users_ConsultingStateForNewbie_GetState);
  PublishOp(en_Users, op_Autoregistration, Users_Autoregistration_Execute, nil, Users_Autoregistration_GetState);
  PublishOp(en_Users, op_AddPrivelegedRight, Users_AddPrivelegedRight_Execute, Users_AddPrivelegedRight_Test, Users_AddPrivelegedRight_GetState);
  ContextMenuWeight(en_Users, op_AddPrivelegedRight, 1);
  PublishOp(en_Users, op_RemovePrivelegedRight, Users_RemovePrivelegedRight_Execute, Users_RemovePrivelegedRight_Test, Users_RemovePrivelegedRight_GetState);
  ContextMenuWeight(en_Users, op_RemovePrivelegedRight, 1);
  PublishOp(en_Users, op_UserFilter, Users_UserFilter_Execute, Users_UserFilter_Test, nil);
  PublishOp(en_Users, op_DisableConsulting, Users_DisableConsulting_Execute, Users_DisableConsulting_Test, nil);
  PublishOp(en_Users, op_EnableConsulting, Users_EnableConsulting_Execute, Users_EnableConsulting_Test, nil);
  PublishOp(en_Users, op_MakeFiltersShared, Users_MakeFiltersShared_Execute, Users_MakeFiltersShared_Test, nil);
  ShowInContextMenu(en_Users, op_MakeFiltersShared, True);
  ShowInToolbar(en_Users, op_MakeFiltersShared, False);
  ContextMenuWeight(en_Users, op_MakeFiltersShared, 2);
  PublishOp(en_Users, op_DenyDeleteIdle, Users_DenyDeleteIdle_Execute, Users_DenyDeleteIdle_Test, nil);
  ShowInContextMenu(en_Users, op_DenyDeleteIdle, True);
  ShowInToolbar(en_Users, op_DenyDeleteIdle, False);
 end;//with Entities.Entities
end;//TPrimUserListForm.InitEntities

procedure TPrimUserListForm.MakeControls;
begin
 inherited;
 with AddUsertype(admUserListName,
  str_admUserListCaption,
  str_admUserListCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(admUserListName
 f_BackgroundPanel := TvtPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_ContextFilter := TnscContextFilter.Create(Self);
 f_ContextFilter.Name := 'ContextFilter';
 f_ContextFilter.Parent := BackgroundPanel;
 f_trUserList := TeeTreeView.Create(Self);
 f_trUserList.Name := 'trUserList';
 f_trUserList.Parent := BackgroundPanel;
end;//TPrimUserListForm.MakeControls

initialization
 str_DisableConsultingForAll.Init;
 {* ������������� str_DisableConsultingForAll }
 str_EnableConsultingForAll.Init;
 {* ������������� str_EnableConsultingForAll }
 str_DisableConsulting.Init;
 {* ������������� str_DisableConsulting }
 str_EnableConsulting.Init;
 {* ������������� str_EnableConsulting }
 str_FailedToDeleteUser.Init;
 {* ������������� str_FailedToDeleteUser }
 str_CannotDeleteActiveUser.Init;
 {* ������������� str_CannotDeleteActiveUser }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUserListForm);
 {* ����������� PrimUserList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
