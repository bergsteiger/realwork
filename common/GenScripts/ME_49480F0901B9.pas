unit PrimUserList_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserList_Form.pas"
// Стереотип: "VCMForm"

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
;

type
 TPrimUserListForm = class(TvcmEntityForm, IbsUserListViewListener)
  private
   f_PrevUID: Integer;
    {* ID предыдущего пользователя, но которого надо встать в случае отмены создания нового пользователя }
   f_AutoRegistration: Tl3Bool;
   f_FilterMap: InsIntegerValueMap;
   f_NeedFillFilterList: Boolean;
   UseCase: IsdsAdmin;
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_ContextFilter: TnscContextFilter;
    {* Поле для свойства ContextFilter }
   f_trUserList: TeeTreeView;
    {* Поле для свойства trUserList }
  protected
   f_InCreateNew: Boolean;
   : IdsUserList;
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
    {* запретить/разрешить пользование правовым консалтингов для всех
           пользователей }
   procedure SelectFailed(const aList: IadminUserNodeList);
    {* Выделяет неудалённых пользователей }
   procedure UpdateCurrent;
   function IsApplyMultiOperations: Boolean;
   procedure CheckUnsavedUserProperty;
   procedure CreateUserFinished(Successfull: Boolean);
   procedure GroupChanged(aGroupUID: Integer);
    {* Сменилась группа }
   procedure RequestUpdateCurrent;
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Add; override;
    {* Добавить }
   procedure LogoutUser; override;
    {* Отключить пользователя }
   procedure ConsultingStateForNewbie; override;
    {* Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга }
   procedure Autoregistration; override;
    {* Разрешить/Запретить авторегистрацию новых пользователей }
   procedure AddPrivelegedRight; override;
    {* Сделать выделенных пользователей привилегированными }
   procedure RemovePrivelegedRight; override;
    {* Отменить для выделенных пользователей режим привилегий }
   procedure UserFilter; override;
   procedure DisableConsulting; override;
   procedure EnableConsulting; override;
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure MakeFiltersShared; override;
    {* Сделать фильтры данного пользователя общими }
   procedure DenyDeleteIdle; override;
    {* Не удалять при бездействии }
  protected
   property AutoRegistration: Boolean
    read pm_GetAutoRegistration;
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
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
 , Admin_Module
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
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки admUserListLocalConstants }
 str_admUserListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admUserListCaption'; rValue : 'Список пользователей');
  {* Заголовок пользовательского типа "Список пользователей" }
 {* Локализуемые строки PrimUserListConsts }
 str_DisableConsultingForAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DisableConsultingForAll'; rValue : 'Запретить всем использование услуги Правового консалтинга');
  {* 'Запретить всем использование услуги Правового консалтинга' }
 str_EnableConsultingForAll: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EnableConsultingForAll'; rValue : 'Разрешить всем использование услуги Правового консалтинга');
  {* 'Разрешить всем использование услуги Правового консалтинга' }
 str_DisableConsulting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DisableConsulting'; rValue : 'Запретить использование услуги Правового консалтинга');
  {* 'Запретить использование услуги Правового консалтинга' }
 str_EnableConsulting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EnableConsulting'; rValue : 'Разрешить использование услуги Правового консалтинга');
  {* 'Разрешить использование услуги Правового консалтинга' }
 str_FailedToDeleteUser: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FailedToDeleteUser'; rValue : 'Не удалось удалить пользователя "%s"');
  {* 'Не удалось удалить пользователя "%s"' }
 str_CannotDeleteActiveUser: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CannotDeleteActiveUser'; rValue : 'Невозможно удалить пользователя "%s" так как он работает в системе');
  {* 'Невозможно удалить пользователя "%s" так как он работает в системе' }

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
 {* запретить/разрешить пользование правовым консалтингов для всех
           пользователей }
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
 {* Выделяет неудалённых пользователей }
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

{$If NOT Defined(NoVCM)}
procedure TPrimUserListForm.Delete;
 {* Удалить }
//#UC START# *494F89C30197_49480F0901B9_var*
//#UC END# *494F89C30197_49480F0901B9_var*
begin
//#UC START# *494F89C30197_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_49480F0901B9_impl*
end;//TPrimUserListForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUserListForm.Add;
 {* Добавить }
//#UC START# *494FD65902BF_49480F0901B9_var*
//#UC END# *494FD65902BF_49480F0901B9_var*
begin
//#UC START# *494FD65902BF_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *494FD65902BF_49480F0901B9_impl*
end;//TPrimUserListForm.Add

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
 {* Сменилась группа }
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

procedure TPrimUserListForm.LogoutUser;
 {* Отключить пользователя }
//#UC START# *4C7CDF1B0192_49480F0901B9_var*
//#UC END# *4C7CDF1B0192_49480F0901B9_var*
begin
//#UC START# *4C7CDF1B0192_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDF1B0192_49480F0901B9_impl*
end;//TPrimUserListForm.LogoutUser

procedure TPrimUserListForm.ConsultingStateForNewbie;
 {* Разрешить/Запретить вновь созданным пользователям использование услуги Правового консалтинга }
//#UC START# *4C7CDF570361_49480F0901B9_var*
//#UC END# *4C7CDF570361_49480F0901B9_var*
begin
//#UC START# *4C7CDF570361_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDF570361_49480F0901B9_impl*
end;//TPrimUserListForm.ConsultingStateForNewbie

procedure TPrimUserListForm.Autoregistration;
 {* Разрешить/Запретить авторегистрацию новых пользователей }
//#UC START# *4C7CDFE10330_49480F0901B9_var*
//#UC END# *4C7CDFE10330_49480F0901B9_var*
begin
//#UC START# *4C7CDFE10330_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CDFE10330_49480F0901B9_impl*
end;//TPrimUserListForm.Autoregistration

procedure TPrimUserListForm.AddPrivelegedRight;
 {* Сделать выделенных пользователей привилегированными }
//#UC START# *4C7CE03100BF_49480F0901B9_var*
//#UC END# *4C7CE03100BF_49480F0901B9_var*
begin
//#UC START# *4C7CE03100BF_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CE03100BF_49480F0901B9_impl*
end;//TPrimUserListForm.AddPrivelegedRight

procedure TPrimUserListForm.RemovePrivelegedRight;
 {* Отменить для выделенных пользователей режим привилегий }
//#UC START# *4C7CE0710199_49480F0901B9_var*
//#UC END# *4C7CE0710199_49480F0901B9_var*
begin
//#UC START# *4C7CE0710199_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CE0710199_49480F0901B9_impl*
end;//TPrimUserListForm.RemovePrivelegedRight

procedure TPrimUserListForm.UserFilter;
//#UC START# *4C7CEDAC0209_49480F0901B9_var*
//#UC END# *4C7CEDAC0209_49480F0901B9_var*
begin
//#UC START# *4C7CEDAC0209_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CEDAC0209_49480F0901B9_impl*
end;//TPrimUserListForm.UserFilter

procedure TPrimUserListForm.DisableConsulting;
//#UC START# *4C7CEDB701D6_49480F0901B9_var*
//#UC END# *4C7CEDB701D6_49480F0901B9_var*
begin
//#UC START# *4C7CEDB701D6_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CEDB701D6_49480F0901B9_impl*
end;//TPrimUserListForm.DisableConsulting

procedure TPrimUserListForm.EnableConsulting;
//#UC START# *4C7CEDC20353_49480F0901B9_var*
//#UC END# *4C7CEDC20353_49480F0901B9_var*
begin
//#UC START# *4C7CEDC20353_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7CEDC20353_49480F0901B9_impl*
end;//TPrimUserListForm.EnableConsulting

{$If NOT Defined(NoVCM)}
procedure TPrimUserListForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_49480F0901B9_var*
//#UC END# *4C7D0CC90052_49480F0901B9_var*
begin
//#UC START# *4C7D0CC90052_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_49480F0901B9_impl*
end;//TPrimUserListForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUserListForm.MakeFiltersShared;
 {* Сделать фильтры данного пользователя общими }
//#UC START# *4E807746035F_49480F0901B9_var*
//#UC END# *4E807746035F_49480F0901B9_var*
begin
//#UC START# *4E807746035F_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E807746035F_49480F0901B9_impl*
end;//TPrimUserListForm.MakeFiltersShared

procedure TPrimUserListForm.DenyDeleteIdle;
 {* Не удалять при бездействии }
//#UC START# *4F3D030901C3_49480F0901B9_var*
//#UC END# *4F3D030901C3_49480F0901B9_var*
begin
//#UC START# *4F3D030901C3_49480F0901B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F3D030901C3_49480F0901B9_impl*
end;//TPrimUserListForm.DenyDeleteIdle

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

{$If NOT Defined(NoVCM)}
procedure TPrimUserListForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
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
    // Дерево перегружают надо восстановить текущий и уведомить других об этом
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUserListForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimUserListForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimUserListForm.ClearFields;
begin
 f_FilterMap := nil;
 inherited;
end;//TPrimUserListForm.ClearFields

initialization
 str_admUserListCaption.Init;
 {* Инициализация str_admUserListCaption }
 str_DisableConsultingForAll.Init;
 {* Инициализация str_DisableConsultingForAll }
 str_EnableConsultingForAll.Init;
 {* Инициализация str_EnableConsultingForAll }
 str_DisableConsulting.Init;
 {* Инициализация str_DisableConsulting }
 str_EnableConsulting.Init;
 {* Инициализация str_EnableConsulting }
 str_FailedToDeleteUser.Init;
 {* Инициализация str_FailedToDeleteUser }
 str_CannotDeleteActiveUser.Init;
 {* Инициализация str_CannotDeleteActiveUser }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimUserListForm);
 {* Регистрация PrimUserList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
