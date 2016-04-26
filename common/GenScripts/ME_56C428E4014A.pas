unit caUserManager;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caUserManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaUserManager" MUID: (56C428E4014A)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , l3DatLst
;

type
 TcaUserManager = class(Tl3ProtoObject, IdaUserManager)
  private
   f_HTManager: IdaUserManager;
   f_PGManager: IdaUserManager;
  protected
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
   function IsUserAdmin(anUserID: TdaUserID): Boolean;
   function Get_AllUsers: Tl3StringDataList;
   function Get_AllGroups: Tl3StringDataList;
   function GetUserName(anUserID: TdaUserID): AnsiString;
   function GetUserPriorities(aGrouId: TdaUserID;
    var aImportPriority: TdaPriority;
    var aExportPriority: TdaPriority): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aHTManager: IdaUserManager;
    const aPGManager: IdaUserManager); reintroduce;
   class function Make(const aHTManager: IdaUserManager;
    const aPGManager: IdaUserManager): IdaUserManager; reintroduce;
 end;//TcaUserManager
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
;

constructor TcaUserManager.Create(const aHTManager: IdaUserManager;
 const aPGManager: IdaUserManager);
//#UC START# *56C429340002_56C428E4014A_var*
//#UC END# *56C429340002_56C428E4014A_var*
begin
//#UC START# *56C429340002_56C428E4014A_impl*
 inherited Create;
 f_HTManager := aHTManager;
 f_PGManager := aPGManager;
//#UC END# *56C429340002_56C428E4014A_impl*
end;//TcaUserManager.Create

class function TcaUserManager.Make(const aHTManager: IdaUserManager;
 const aPGManager: IdaUserManager): IdaUserManager;
var
 l_Inst : TcaUserManager;
begin
 l_Inst := Create(aHTManager, aPGManager);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaUserManager.Make

function TcaUserManager.CheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5628D14D0151_56C428E4014A_var*
var
 l_Result: TdaLoginError;
 l_UserID: TdaUserID;
//#UC END# *5628D14D0151_56C428E4014A_var*
begin
//#UC START# *5628D14D0151_56C428E4014A_impl*
 Result := f_HTManager.CheckPassword(aLogin, aPassword, RequireAdminRights, theUserID);
 l_Result := f_PGManager.CheckPassword(aLogin, aPassword, RequireAdminRights, l_UserID);
 Assert((Result = l_Result) and (theUserID = l_UserID))
//#UC END# *5628D14D0151_56C428E4014A_impl*
end;//TcaUserManager.CheckPassword

function TcaUserManager.IsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *56EA993D0218_56C428E4014A_var*
//#UC END# *56EA993D0218_56C428E4014A_var*
begin
//#UC START# *56EA993D0218_56C428E4014A_impl*
 Result := f_HTManager.IsUserAdmin(anUserID);
 Assert(Result = f_PGManager.IsUserAdmin(anUserID));
//#UC END# *56EA993D0218_56C428E4014A_impl*
end;//TcaUserManager.IsUserAdmin

function TcaUserManager.Get_AllUsers: Tl3StringDataList;
//#UC START# *5715DEF20209_56C428E4014Aget_var*
//#UC END# *5715DEF20209_56C428E4014Aget_var*
begin
//#UC START# *5715DEF20209_56C428E4014Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715DEF20209_56C428E4014Aget_impl*
end;//TcaUserManager.Get_AllUsers

function TcaUserManager.Get_AllGroups: Tl3StringDataList;
//#UC START# *5715DF0D03C2_56C428E4014Aget_var*
//#UC END# *5715DF0D03C2_56C428E4014Aget_var*
begin
//#UC START# *5715DF0D03C2_56C428E4014Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715DF0D03C2_56C428E4014Aget_impl*
end;//TcaUserManager.Get_AllGroups

function TcaUserManager.GetUserName(anUserID: TdaUserID): AnsiString;
//#UC START# *5718B5CF0399_56C428E4014A_var*
//#UC END# *5718B5CF0399_56C428E4014A_var*
begin
//#UC START# *5718B5CF0399_56C428E4014A_impl*
 Result := f_HTManager.GetUserName(anUserID);
 Assert(Result = f_PGManager.GetUserName(anUserID));
//#UC END# *5718B5CF0399_56C428E4014A_impl*
end;//TcaUserManager.GetUserName

function TcaUserManager.GetUserPriorities(aGrouId: TdaUserID;
 var aImportPriority: TdaPriority;
 var aExportPriority: TdaPriority): Boolean;
//#UC START# *571DCFB50217_56C428E4014A_var*
//#UC END# *571DCFB50217_56C428E4014A_var*
begin
//#UC START# *571DCFB50217_56C428E4014A_impl*
 !!! Needs to be implemented !!!
//#UC END# *571DCFB50217_56C428E4014A_impl*
end;//TcaUserManager.GetUserPriorities

procedure TcaUserManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56C428E4014A_var*
//#UC END# *479731C50290_56C428E4014A_var*
begin
//#UC START# *479731C50290_56C428E4014A_impl*
 f_HTManager := nil;
 f_PGManager := nil;
 inherited;
//#UC END# *479731C50290_56C428E4014A_impl*
end;//TcaUserManager.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
