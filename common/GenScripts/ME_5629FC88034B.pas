unit pgUserManager;

// Модуль: "w:\common\components\rtl\Garant\PG\pgUserManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgUserManager" MUID: (5629FC88034B)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daUserManager
 , daInterfaces
 , l3DatLst
 , daTypes
;

type
 TpgUserManager = class(TdaUserManager)
  private
   f_Factory: IdaTableQueryFactory;
   f_PasswordQuery: IdaTabledQuery;
   f_UserFlagsQuery: IdaTabledQuery;
  protected
   procedure FillAllUsers(aList: Tl3StringDataList); override;
   procedure FillAllGroups(aList: Tl3StringDataList); override;
   function DoCheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError; override;
   function DoIsUserAdmin(anUserID: TdaUserID): Boolean; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory): IdaUserManager; reintroduce;
 end;//TpgUserManager
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , SysUtils
 , daScheme
;

constructor TpgUserManager.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *562A074E0321_5629FC88034B_var*
//#UC END# *562A074E0321_5629FC88034B_var*
begin
//#UC START# *562A074E0321_5629FC88034B_impl*
 inherited Create;
 f_Factory := aFactory;

 f_PasswordQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtPassword));
 f_PasswordQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtPassword)['Password']));
 f_PasswordQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtPassword)['User_ID']));
 f_PasswordQuery.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtPassword)['ShortName'], da_copEqual, 'p_ShortName');
 f_PasswordQuery.Prepare;

 f_UserFlagsQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtUsers));
 f_UserFlagsQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtUsers)['Active']));
 f_UserFlagsQuery.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtUsers)['ID'], da_copEqual, 'p_UserID');
 f_UserFlagsQuery.Prepare;
//#UC END# *562A074E0321_5629FC88034B_impl*
end;//TpgUserManager.Create

class function TpgUserManager.Make(const aFactory: IdaTableQueryFactory): IdaUserManager;
var
 l_Inst : TpgUserManager;
begin
 l_Inst := Create(aFactory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgUserManager.Make

procedure TpgUserManager.FillAllUsers(aList: Tl3StringDataList);
//#UC START# *5715E71600DD_5629FC88034B_var*
//#UC END# *5715E71600DD_5629FC88034B_var*
begin
//#UC START# *5715E71600DD_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E71600DD_5629FC88034B_impl*
end;//TpgUserManager.FillAllUsers

procedure TpgUserManager.FillAllGroups(aList: Tl3StringDataList);
//#UC START# *5715E74402CA_5629FC88034B_var*
//#UC END# *5715E74402CA_5629FC88034B_var*
begin
//#UC START# *5715E74402CA_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E74402CA_5629FC88034B_impl*
end;//TpgUserManager.FillAllGroups

function TpgUserManager.DoCheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5715E767013D_5629FC88034B_var*
//#UC END# *5715E767013D_5629FC88034B_var*
begin
//#UC START# *5715E767013D_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E767013D_5629FC88034B_impl*
end;//TpgUserManager.DoCheckPassword

function TpgUserManager.DoIsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *5715E78F013E_5629FC88034B_var*
//#UC END# *5715E78F013E_5629FC88034B_var*
begin
//#UC START# *5715E78F013E_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E78F013E_5629FC88034B_impl*
end;//TpgUserManager.DoIsUserAdmin

procedure TpgUserManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5629FC88034B_var*
//#UC END# *479731C50290_5629FC88034B_var*
begin
//#UC START# *479731C50290_5629FC88034B_impl*
 f_PasswordQuery := nil;
 f_UserFlagsQuery := nil;
 f_Factory := nil;
 inherited;
//#UC END# *479731C50290_5629FC88034B_impl*
end;//TpgUserManager.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
