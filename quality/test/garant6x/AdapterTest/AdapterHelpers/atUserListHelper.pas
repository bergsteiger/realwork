unit atUserListHelper;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atUserListHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatUserListHelper" MUID: (4B6C27F50058)

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , BaseTypesUnit
 , SecurityUnit
;

type
 TatArrayOfUID = array of TUid;

 TatBaseNB2AoUHlpr = {abstract} class
  public
   ArrOfUID: TatArrayOfUID;
  protected
   function IsAdd(const aProfileNode: IProfileNode): Boolean; virtual; abstract;
  public
   procedure Proc(const aNode: INodeBase); virtual;
 end;//TatBaseNB2AoUHlpr

 TatUserListHelper = class
  public
   class function UserTree2TatArrayOfUID(const aRoot: INodeBase): TatArrayOfUID; virtual;
   class function GetFilteredUserTree(const aRoot: INodeBase;
    aFlags: Longword): INodeBase; virtual;
   class function GetAdapterTestUIDs(isActiveOnly: Boolean = False): TatArrayOfUID; virtual;
   class function GetOnlyAdapterTestUIDs(const aRoot: INodeBase): TatArrayOfUID; virtual;
   class function GetMyUID: TUid; virtual;
 end;//TatUserListHelper

implementation

uses
 l3ImplUses
 , atNodeHelper
 , SysUtils
 , atGblAdapterWorker
 , atStringHelper
 , IOUnit
 //#UC START# *4B6C27F50058impl_uses*
 //#UC END# *4B6C27F50058impl_uses*
;

type
 TatNB2AoUHlpr = class(TatBaseNB2AoUHlpr)
  protected
   function IsAdd(const aProfileNode: IProfileNode): Boolean; override;
 end;//TatNB2AoUHlpr

 TatNB2AoUByNameHlpr = class(TatNB2AoUHlpr)
  public
   UserName: AnsiString;
  protected
   function IsAdd(const aProfileNode: IProfileNode): Boolean; override;
 end;//TatNB2AoUByNameHlpr

procedure TatBaseNB2AoUHlpr.Proc(const aNode: INodeBase);
//#UC START# *4B6C3A240321_4B6C39F4013F_var*
  var
    l_ProfileNode : IProfileNode;
    l_Length : Integer;
//#UC END# *4B6C3A240321_4B6C39F4013F_var*
begin
//#UC START# *4B6C3A240321_4B6C39F4013F_impl*
  if Supports(aNode, IProfileNode, l_ProfileNode) AND IsAdd(l_ProfileNode) then
  begin
    l_Length := Length(ArrOfUID);
    SetLength(ArrOfUID, l_Length+1);
    ArrOfUID[l_Length] := l_ProfileNode.GetUid;
  end;
//#UC END# *4B6C3A240321_4B6C39F4013F_impl*
end;//TatBaseNB2AoUHlpr.Proc

function TatNB2AoUHlpr.IsAdd(const aProfileNode: IProfileNode): Boolean;
//#UC START# *4B71720A0019_4B716F4402A1_var*
//#UC END# *4B71720A0019_4B716F4402A1_var*
begin
//#UC START# *4B71720A0019_4B716F4402A1_impl*
  Result := true;
//#UC END# *4B71720A0019_4B716F4402A1_impl*
end;//TatNB2AoUHlpr.IsAdd

function TatNB2AoUByNameHlpr.IsAdd(const aProfileNode: IProfileNode): Boolean;
//#UC START# *4B71720A0019_4B716F69018B_var*
  var
    l_Entity : IEntityBase;
    l_UserProfile : IUserProfile;
    l_Name : IString;
//#UC END# *4B71720A0019_4B716F69018B_var*
begin
//#UC START# *4B71720A0019_4B716F69018B_impl*
  Result := false;
  if NOT inherited IsAdd(aProfileNode) then Exit;
  //
  aProfileNode.GetEntity(l_Entity);
  if (l_Entity <> nil) AND Supports(l_Entity, IUserProfile, l_UserProfile) then
  begin
    l_UserProfile.GetName(l_Name);
    Result := (l_Name <> nil) AND (TatStringHelper.AStr2DStr(l_Name) = UserName);
  end;
//#UC END# *4B71720A0019_4B716F69018B_impl*
end;//TatNB2AoUByNameHlpr.IsAdd

class function TatUserListHelper.UserTree2TatArrayOfUID(const aRoot: INodeBase): TatArrayOfUID;
//#UC START# *4B6C321A01F5_4B6C27F50058_var*
//#UC END# *4B6C321A01F5_4B6C27F50058_var*
begin
//#UC START# *4B6C321A01F5_4B6C27F50058_impl*
  Assert(aRoot <> nil, 'aRoot <> nil');
  with TatNB2AoUHlpr.Create do
  try
    TatNodeHelper.LoadNodesThrough(aRoot, FM_SHARED_NONE, -1, Proc);
    Result := ArrOfUID;
  finally
    Free;
  end;
//#UC END# *4B6C321A01F5_4B6C27F50058_impl*
end;//TatUserListHelper.UserTree2TatArrayOfUID

class function TatUserListHelper.GetFilteredUserTree(const aRoot: INodeBase;
 aFlags: Longword): INodeBase;
//#UC START# *4B70115C0096_4B6C27F50058_var*
  var
    l_UserFilter : IUserFilter;
    l_FilterList : IFilterList;
    l_SyncIndex : Integer;
//#UC END# *4B70115C0096_4B6C27F50058_var*
begin
//#UC START# *4B70115C0096_4B6C27F50058_impl*
  Assert(aRoot <> nil, 'aRoot <> nil');
  l_UserFilter := TatGblAdapterWorker.Instance.GblAdapterDll.MakeUserFilter;
  Assert(l_UserFilter <> nil, 'l_UserFilter <> nil');
  l_UserFilter.SetFlags(aFlags);
  l_FilterList := TatGblAdapterWorker.Instance.GblAdapterDll.MakeFilterList;
  Assert(l_FilterList <> nil, 'l_FilterList <> nil');
  l_FilterList.Add(l_UserFilter);
  //
  aRoot.CreateViewEx(
    l_FilterList,
    FM_USER_FLAG_MASK,
    nil, l_SyncIndex, 0, False, False, False,
    Result);
//#UC END# *4B70115C0096_4B6C27F50058_impl*
end;//TatUserListHelper.GetFilteredUserTree

class function TatUserListHelper.GetAdapterTestUIDs(isActiveOnly: Boolean = False): TatArrayOfUID;
//#UC START# *4B716C2601D4_4B6C27F50058_var*
  var
    l_UserManager : IUserManager;
    l_Root : INodeBase;
    l_Flags : Longword;
//#UC END# *4B716C2601D4_4B6C27F50058_var*
begin
//#UC START# *4B716C2601D4_4B6C27F50058_impl*
  l_UserManager := TatGblAdapterWorker.Instance.GblAdapterDll.MakeUserManager;
  Assert(l_UserManager <> nil, 'l_UserManager <> nil');
  l_UserManager.GetUsersTree(l_Root);
  Assert(l_Root <> nil, 'l_Root <> nil');
  //
  l_Flags := UFF_USER_NOT_SYSTEM or UFF_USER_NOT_CURRENT;
  if isActiveOnly then
    l_Flags := l_Flags OR UFF_USER_ACTIVE;
  //
  l_Root := GetFilteredUserTree(l_Root, l_Flags);
  Assert(l_Root <> nil, 'l_Root <> nil 2');
  //
  Result := GetOnlyAdapterTestUIDs(l_Root);
//#UC END# *4B716C2601D4_4B6C27F50058_impl*
end;//TatUserListHelper.GetAdapterTestUIDs

class function TatUserListHelper.GetOnlyAdapterTestUIDs(const aRoot: INodeBase): TatArrayOfUID;
//#UC START# *4B72B96C019B_4B6C27F50058_var*
//#UC END# *4B72B96C019B_4B6C27F50058_var*
begin
//#UC START# *4B72B96C019B_4B6C27F50058_impl*
  Assert(aRoot <> nil, 'aRoot <> nil');
  with TatNB2AoUByNameHlpr.Create do
  try
    UserName := TAT_USER_NAME;
    TatNodeHelper.LoadNodesThrough(aRoot, FM_SHARED_NONE, -1, Proc);
    Result := ArrOfUID;
  finally
    Free;
  end;
//#UC END# *4B72B96C019B_4B6C27F50058_impl*
end;//TatUserListHelper.GetOnlyAdapterTestUIDs

class function TatUserListHelper.GetMyUID: TUid;
//#UC START# *4B758B3100BF_4B6C27F50058_var*
  var
    l_UserManager : IUserManager;
    l_MyProfile : IUserProfile;
//#UC END# *4B758B3100BF_4B6C27F50058_var*
begin
//#UC START# *4B758B3100BF_4B6C27F50058_impl*
  l_UserManager := TatGblAdapterWorker.Instance.GblAdapterDll.MakeUserManager;
  Assert(l_UserManager <> nil, 'l_UserManager <> nil');
  l_UserManager.GetSelfProfile(l_MyProfile);
  Assert(l_MyProfile <> nil, 'l_MyProfile <> nil');
  Result := l_MyProfile.GetUid;
//#UC END# *4B758B3100BF_4B6C27F50058_impl*
end;//TatUserListHelper.GetMyUID

end.
