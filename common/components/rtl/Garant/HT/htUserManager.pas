unit htUserManager;

// Модуль: "w:\common\components\rtl\Garant\HT\htUserManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtUserManager" MUID: (5629E343023B)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , l3DatLst
;

type
 ThtUserManager = class(Tl3ProtoObject, IdaUserManager)
  protected
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
   function IsUserAdmin(anUserID: TdaUserID): Boolean;
   function Get_AllUsers: Tl3StringDataList;
   function Get_AllGroups: Tl3StringDataList;
   function GetUserName(anUserID: TdaUserID): AnsiString;
   function GetUserPriorities(aGroupId: TdaUserID;
    var aImportPriority: TdaPriority;
    var aExportPriority: TdaPriority): Boolean;
   procedure ReSortUserList;
  public
   constructor Create; reintroduce;
   class function Make: IdaUserManager; reintroduce;
 end;//ThtUserManager

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
;

constructor ThtUserManager.Create;
//#UC START# *5629F0F901C8_5629E343023B_var*
//#UC END# *5629F0F901C8_5629E343023B_var*
begin
//#UC START# *5629F0F901C8_5629E343023B_impl*
 inherited Create;
//#UC END# *5629F0F901C8_5629E343023B_impl*
end;//ThtUserManager.Create

class function ThtUserManager.Make: IdaUserManager;
var
 l_Inst : ThtUserManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtUserManager.Make

function ThtUserManager.CheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5628D14D0151_5629E343023B_var*
var
 l_Result: Boolean;
//#UC END# *5628D14D0151_5629E343023B_var*
begin
//#UC START# *5628D14D0151_5629E343023B_impl*
 l_Result:= GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, RequireAdminRights);
 if l_Result then
  Result := da_leOk
 else
 begin
  if RequireAdminRights and GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, False) then
   Result := da_leInsufficientRights
  else
   Result := da_leUserParamsWrong;
 end;
 theUserID := GlobalHTServer.xxxUserID;
//#UC END# *5628D14D0151_5629E343023B_impl*
end;//ThtUserManager.CheckPassword

function ThtUserManager.IsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *56EA993D0218_5629E343023B_var*
//#UC END# *56EA993D0218_5629E343023B_var*
begin
//#UC START# *56EA993D0218_5629E343023B_impl*
 Result := dt_User.UserManager.xxxIsUserAdmin(anUserID);
//#UC END# *56EA993D0218_5629E343023B_impl*
end;//ThtUserManager.IsUserAdmin

function ThtUserManager.Get_AllUsers: Tl3StringDataList;
//#UC START# *5715DEF20209_5629E343023Bget_var*
//#UC END# *5715DEF20209_5629E343023Bget_var*
begin
//#UC START# *5715DEF20209_5629E343023Bget_impl*
 Result := dt_User.UserManager.xxxAllUsers;
//#UC END# *5715DEF20209_5629E343023Bget_impl*
end;//ThtUserManager.Get_AllUsers

function ThtUserManager.Get_AllGroups: Tl3StringDataList;
//#UC START# *5715DF0D03C2_5629E343023Bget_var*
//#UC END# *5715DF0D03C2_5629E343023Bget_var*
begin
//#UC START# *5715DF0D03C2_5629E343023Bget_impl*
 Result := dt_User.UserManager.xxxAllGroups;
//#UC END# *5715DF0D03C2_5629E343023Bget_impl*
end;//ThtUserManager.Get_AllGroups

function ThtUserManager.GetUserName(anUserID: TdaUserID): AnsiString;
//#UC START# *5718B5CF0399_5629E343023B_var*
//#UC END# *5718B5CF0399_5629E343023B_var*
begin
//#UC START# *5718B5CF0399_5629E343023B_impl*
 Result := dt_User.UserManager.GetUserName(anUserID);
//#UC END# *5718B5CF0399_5629E343023B_impl*
end;//ThtUserManager.GetUserName

function ThtUserManager.GetUserPriorities(aGroupId: TdaUserID;
 var aImportPriority: TdaPriority;
 var aExportPriority: TdaPriority): Boolean;
//#UC START# *571DCFB50217_5629E343023B_var*
//#UC END# *571DCFB50217_5629E343023B_var*
begin
//#UC START# *571DCFB50217_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *571DCFB50217_5629E343023B_impl*
end;//ThtUserManager.GetUserPriorities

procedure ThtUserManager.ReSortUserList;
//#UC START# *5721F5E60367_5629E343023B_var*
//#UC END# *5721F5E60367_5629E343023B_var*
begin
//#UC START# *5721F5E60367_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5721F5E60367_5629E343023B_impl*
end;//ThtUserManager.ReSortUserList

end.
