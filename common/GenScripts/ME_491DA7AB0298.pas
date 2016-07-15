unit dsUserProperty;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsUserProperty.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsUserProperty" MUID: (491DA7AB0298)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , AdminInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , AdminDomainInterfaces
 , SecurityUnit
;

type
 _InitDataType_ = IdeProfile;
 _FormDataSourceType_ = IdsUserProperty;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _nsUserPropertyImpl_Parent_ = _vcmFormDataSource_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserPropertyImpl.imp.pas}
 TdsUserProperty = {final} class(_nsUserPropertyImpl_, IdsUserProperty)
  private
   SDS: IsdsAdmin;
   f_IsReadOnlyFor268342582: Boolean;
  protected
   procedure CreateUserProfile(const aLogin: Tl3WString;
    const aName: Tl3WString;
    const aMail: Tl3WString;
    const aPassword: Tl3WString;
    aCanBuyConsulting: Boolean;
    aIsPrivileged: Boolean;
    aGroupUID: Integer);
   procedure CreateUserFinished(Successfull: Boolean);
    {* Нотификация об отскзе создания пользователя }
   procedure CheckUnsavedUserProperty;
   function DefaultGroupID: Integer; override;
   function Get_IsReadOnlyFor268342582: Boolean;
   procedure Set_IsReadOnlyFor268342582(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearNewUser; override;
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsUserProperty
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , DataAdapter
 , nsTypes
 , IOUnit
 , nsConst
 , l3InterfacesMisc
 , l3Base
;

type _Instance_R_ = TdsUserProperty;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserPropertyImpl.imp.pas}

procedure TdsUserProperty.CreateUserProfile(const aLogin: Tl3WString;
 const aName: Tl3WString;
 const aMail: Tl3WString;
 const aPassword: Tl3WString;
 aCanBuyConsulting: Boolean;
 aIsPrivileged: Boolean;
 aGroupUID: Integer);
//#UC START# *491DA41B00E4_491DA7AB0298_var*
var
 l_UserManager: IUserManager;
//#UC END# *491DA41B00E4_491DA7AB0298_var*
begin
//#UC START# *491DA41B00E4_491DA7AB0298_impl*
 l_UserManager := defDataAdapter.NativeAdapter.MakeUserManager;
 try
  l_UserManager.CreateUserWithRights(nsAStr(aName).S, nsAStr(aLogin).S,
                                     nsAStr(aPassword).S, nsAStr(aMail).S,
                                     aCanBuyConsulting, aIsPrivileged,
                                     aGroupUID);
  ClearNewUser;
 finally
  l_UserManager := nil;
 end;
//#UC END# *491DA41B00E4_491DA7AB0298_impl*
end;//TdsUserProperty.CreateUserProfile

procedure TdsUserProperty.CreateUserFinished(Successfull: Boolean);
 {* Нотификация об отскзе создания пользователя }
//#UC START# *49E5B86D002D_491DA7AB0298_var*
//#UC END# *49E5B86D002D_491DA7AB0298_var*
begin
//#UC START# *49E5B86D002D_491DA7AB0298_impl*
 SDS.CreateUserFinished(Successfull);
//#UC END# *49E5B86D002D_491DA7AB0298_impl*
end;//TdsUserProperty.CreateUserFinished

procedure TdsUserProperty.CheckUnsavedUserProperty;
//#UC START# *49F6E60E0293_491DA7AB0298_var*
var
 l_Index    : Integer;
 l_Listener : IbsUserPropertyListener;
 l_Item     : IUnknown;
//#UC END# *49F6E60E0293_491DA7AB0298_var*
begin
//#UC START# *49F6E60E0293_491DA7AB0298_impl*
 if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
  for l_Index := 0 to Pred(NotifiedObjList.Count) do
  begin
   l_Item := NotifiedObjList.Items[l_Index];
   if Supports(l_Item, IbsUserPropertyListener, l_Listener) and
     (l_Item = l_Listener) then
    l_Listener.CheckUnsavedProperties;
  end;//if (NotifiedObjList <> nil)
//#UC END# *49F6E60E0293_491DA7AB0298_impl*
end;//TdsUserProperty.CheckUnsavedUserProperty

function TdsUserProperty.DefaultGroupID: Integer;
//#UC START# *4B50439D03B6_491DA7AB0298_var*
//#UC END# *4B50439D03B6_491DA7AB0298_var*
begin
//#UC START# *4B50439D03B6_491DA7AB0298_impl*
 Result := SDS.CurrentGroupUID;
//#UC END# *4B50439D03B6_491DA7AB0298_impl*
end;//TdsUserProperty.DefaultGroupID

function TdsUserProperty.Get_IsReadOnlyFor268342582: Boolean;
//#UC START# *4F1D3E8501B0_491DA7AB0298get_var*
//#UC END# *4F1D3E8501B0_491DA7AB0298get_var*
begin
//#UC START# *4F1D3E8501B0_491DA7AB0298get_impl*
 Result := f_IsReadOnlyFor268342582;
//#UC END# *4F1D3E8501B0_491DA7AB0298get_impl*
end;//TdsUserProperty.Get_IsReadOnlyFor268342582

procedure TdsUserProperty.Set_IsReadOnlyFor268342582(aValue: Boolean);
//#UC START# *4F1D3E8501B0_491DA7AB0298set_var*
//#UC END# *4F1D3E8501B0_491DA7AB0298set_var*
begin
//#UC START# *4F1D3E8501B0_491DA7AB0298set_impl*
 f_IsReadOnlyFor268342582 := aValue;
//#UC END# *4F1D3E8501B0_491DA7AB0298set_impl*
end;//TdsUserProperty.Set_IsReadOnlyFor268342582

procedure TdsUserProperty.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_491DA7AB0298_var*
//#UC END# *479731C50290_491DA7AB0298_var*
begin
//#UC START# *479731C50290_491DA7AB0298_impl*
 f_IsReadOnlyFor268342582 := False;
 inherited;
//#UC END# *479731C50290_491DA7AB0298_impl*
end;//TdsUserProperty.Cleanup

{$If NOT Defined(NoVCM)}
procedure TdsUserProperty.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_491DA7AB0298_var*
//#UC END# *492ACF630072_491DA7AB0298_var*
begin
//#UC START# *492ACF630072_491DA7AB0298_impl*
 inherited;
 SetProfileData(PartData.UserProfile, False, PartData.IsNewProfile);
//#UC END# *492ACF630072_491DA7AB0298_impl*
end;//TdsUserProperty.GotData
{$IfEnd} // NOT Defined(NoVCM)

procedure TdsUserProperty.ClearNewUser;
//#UC START# *4B5049D901A9_491DA7AB0298_var*
//#UC END# *4B5049D901A9_491DA7AB0298_var*
begin
//#UC START# *4B5049D901A9_491DA7AB0298_impl*
 inherited;
 f_IsReadOnlyFor268342582 := False;
//#UC END# *4B5049D901A9_491DA7AB0298_impl*
end;//TdsUserProperty.ClearNewUser

{$If NOT Defined(NoVCM)}
procedure TdsUserProperty.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 SDS := aDS As IsdsAdmin;
end;//TdsUserProperty.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsUserProperty.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 SDS := nil;
end;//TdsUserProperty.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
