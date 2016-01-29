unit dsUserProperty;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/dsUserProperty.pas"
// Начат: 15.08.2005 20.30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Администратор::Admin::Admin::Admin::TdsUserProperty
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
  AdminInterfaces
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
  SecurityUnit,
  AdminDomainInterfaces,
  vcmControllers {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 _FormDataSourceType_ = IdsUserProperty;
 _InitDataType_ = IdeProfile;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _nsUserPropertyImpl_Parent_ = _vcmFormDataSource_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserPropertyImpl.imp.pas}
 TdsUserProperty = {final vac} class(_nsUserPropertyImpl_, IdsUserProperty)
 private
 // private fields
   SDS : IsdsAdmin;
   f_IsReadOnlyFor268342582 : Boolean;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
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
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure GotData; override;
     {* - данные изменились. }
   {$IfEnd} //not NoVCM
   procedure ClearNewUser; override;
 end;//TdsUserProperty
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  SysUtils,
  DataAdapter,
  nsTypes,
  IOUnit,
  nsConst,
  l3InterfacesMisc,
  l3Base
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

type _Instance_R_ = TdsUserProperty;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserPropertyImpl.imp.pas}

// start class TdsUserProperty

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
//#UC START# *479731C50290_491DA7AB0298_var*
//#UC END# *479731C50290_491DA7AB0298_var*
begin
//#UC START# *479731C50290_491DA7AB0298_impl*
 f_IsReadOnlyFor268342582 := False;
 inherited;
//#UC END# *479731C50290_491DA7AB0298_impl*
end;//TdsUserProperty.Cleanup

{$If not defined(NoVCM)}
procedure TdsUserProperty.GotData;
//#UC START# *492ACF630072_491DA7AB0298_var*
//#UC END# *492ACF630072_491DA7AB0298_var*
begin
//#UC START# *492ACF630072_491DA7AB0298_impl*
 inherited;
 SetProfileData(PartData.UserProfile, False, PartData.IsNewProfile);
//#UC END# *492ACF630072_491DA7AB0298_impl*
end;//TdsUserProperty.GotData
{$IfEnd} //not NoVCM

procedure TdsUserProperty.ClearNewUser;
//#UC START# *4B5049D901A9_491DA7AB0298_var*
//#UC END# *4B5049D901A9_491DA7AB0298_var*
begin
//#UC START# *4B5049D901A9_491DA7AB0298_impl*
 inherited;
 f_IsReadOnlyFor268342582 := False;
//#UC END# *4B5049D901A9_491DA7AB0298_impl*
end;//TdsUserProperty.ClearNewUser

procedure TdsUserProperty.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 SDS := aDS As IsdsAdmin;
end;

procedure TdsUserProperty.ClearRefs;
begin
 inherited;
 SDS := nil;
end;

{$IfEnd} //Admin

end.