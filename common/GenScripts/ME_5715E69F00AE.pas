unit daUserManager;

// Модуль: "w:\common\components\rtl\Garant\DA\daUserManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaUserManager" MUID: (5715E69F00AE)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , l3DatLst
 , daTypes
;

type
 TdaUserManager = class(Tl3ProtoObject, IdaUserManager)
  private
   f_AllUsers: Tl3StringDataList;
   f_AllGroups: Tl3StringDataList;
  private
   procedure SortUsersInList(aList: Tl3StringDataList);
  protected
   procedure FillAllUsers(aList: Tl3StringDataList); virtual; abstract;
   procedure FillAllGroups(aList: Tl3StringDataList); virtual; abstract;
   function DoCheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError; virtual; abstract;
   function DoIsUserAdmin(anUserID: TdaUserID): Boolean; virtual; abstract;
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
   function IsUserAdmin(anUserID: TdaUserID): Boolean;
   function Get_AllUsers: Tl3StringDataList;
   function Get_AllGroups: Tl3StringDataList;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//TdaUserManager

implementation

uses
 l3ImplUses
 , SysUtils
 , daDataProvider
 , daUserManagerUtils
 , l3Base
;

procedure TdaUserManager.SortUsersInList(aList: Tl3StringDataList);
//#UC START# *5715ED0002E0_5715E69F00AE_var*
//#UC END# *5715ED0002E0_5715E69F00AE_var*
begin
//#UC START# *5715ED0002E0_5715E69F00AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715ED0002E0_5715E69F00AE_impl*
end;//TdaUserManager.SortUsersInList

function TdaUserManager.CheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5628D14D0151_5715E69F00AE_var*
//#UC END# *5628D14D0151_5715E69F00AE_var*
begin
//#UC START# *5628D14D0151_5715E69F00AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5628D14D0151_5715E69F00AE_impl*
end;//TdaUserManager.CheckPassword

function TdaUserManager.IsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *56EA993D0218_5715E69F00AE_var*
//#UC END# *56EA993D0218_5715E69F00AE_var*
begin
//#UC START# *56EA993D0218_5715E69F00AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *56EA993D0218_5715E69F00AE_impl*
end;//TdaUserManager.IsUserAdmin

function TdaUserManager.Get_AllUsers: Tl3StringDataList;
//#UC START# *5715DEF20209_5715E69F00AEget_var*
//#UC END# *5715DEF20209_5715E69F00AEget_var*
begin
//#UC START# *5715DEF20209_5715E69F00AEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715DEF20209_5715E69F00AEget_impl*
end;//TdaUserManager.Get_AllUsers

function TdaUserManager.Get_AllGroups: Tl3StringDataList;
//#UC START# *5715DF0D03C2_5715E69F00AEget_var*
//#UC END# *5715DF0D03C2_5715E69F00AEget_var*
begin
//#UC START# *5715DF0D03C2_5715E69F00AEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715DF0D03C2_5715E69F00AEget_impl*
end;//TdaUserManager.Get_AllGroups

procedure TdaUserManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5715E69F00AE_var*
//#UC END# *479731C50290_5715E69F00AE_var*
begin
//#UC START# *479731C50290_5715E69F00AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_5715E69F00AE_impl*
end;//TdaUserManager.Cleanup

end.
