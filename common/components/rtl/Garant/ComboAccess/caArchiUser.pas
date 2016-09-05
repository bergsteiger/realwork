unit caArchiUser;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caArchiUser.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaArchiUser" MUID: (57566B200124)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , Classes
;

type
 TcaArchiUser = class(Tl3ProtoObject, IdaArchiUser)
  private
   f_HTUser: IdaArchiUser;
   f_PGUser: IdaArchiUser;
  private
   function IsUsersEqual(const aLeft: IdaArchiUser;
    const aRight: IdaArchiUser): Boolean;
  protected
   procedure Save(aStream: TStream);
   procedure Load(aStream: TStream);
   function Get_ID: TdaUserID;
   procedure Set_ID(aValue: TdaUserID);
   function Get_Active: Boolean;
   procedure Set_Active(aValue: Boolean);
   function Get_HasAdminRights: Boolean;
   procedure Set_HasAdminRights(aValue: Boolean);
   function Get_ExportPriority: TdaPriority;
   procedure Set_ExportPriority(aValue: TdaPriority);
   function Get_ImportPriority: TdaPriority;
   procedure Set_ImportPriority(aValue: TdaPriority);
   function Get_IP: AnsiString;
   procedure Set_IP(const aValue: AnsiString);
   function Get_LoginDate: TDateTime;
   procedure Set_LoginDate(aValue: TDateTime);
   function Get_LoginName: AnsiString;
   procedure Set_LoginName(const aValue: AnsiString);
   function Get_Password: AnsiString;
   procedure Set_Password(const aValue: AnsiString);
   function Get_UserName: AnsiString;
   procedure Set_UserName(const aValue: AnsiString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aHTUser: IdaArchiUser;
    const aPGUser: IdaArchiUser); reintroduce;
   class function Make(const aHTUser: IdaArchiUser;
    const aPGUser: IdaArchiUser): IdaArchiUser; reintroduce;
 end;//TcaArchiUser
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 //#UC START# *57566B200124impl_uses*
 //#UC END# *57566B200124impl_uses*
;

constructor TcaArchiUser.Create(const aHTUser: IdaArchiUser;
 const aPGUser: IdaArchiUser);
//#UC START# *57566B3E0317_57566B200124_var*
//#UC END# *57566B3E0317_57566B200124_var*
begin
//#UC START# *57566B3E0317_57566B200124_impl*
 inherited Create;
 Assert(IsUsersEqual(aHTUser, aPGUser));
 f_HTUser := aHTUser;
 f_PGUser := aPGUser;
//#UC END# *57566B3E0317_57566B200124_impl*
end;//TcaArchiUser.Create

class function TcaArchiUser.Make(const aHTUser: IdaArchiUser;
 const aPGUser: IdaArchiUser): IdaArchiUser;
var
 l_Inst : TcaArchiUser;
begin
 l_Inst := Create(aHTUser, aPGUser);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaArchiUser.Make

function TcaArchiUser.IsUsersEqual(const aLeft: IdaArchiUser;
 const aRight: IdaArchiUser): Boolean;
//#UC START# *57359E8903CF_57566B200124_var*
//#UC END# *57359E8903CF_57566B200124_var*
begin
//#UC START# *57359E8903CF_57566B200124_impl*
 Result := (aLeft = nil) = (aRight = nil);
 if Result and Assigned(aLeft) then
  Result := (aLeft.ID = aRight.ID) and
   (aLeft.Active = aRight.Active) and
   (aLeft.HasAdminRights = aRight.HasAdminRights) and
   (aLeft.IP = aRight.IP) and
   (aLeft.LoginName = aRight.LoginName) and
   (aLeft.Password = aRight.Password) and
   (aLeft.UserName = aRight.UserName);
//#UC END# *57359E8903CF_57566B200124_impl*
end;//TcaArchiUser.IsUsersEqual

procedure TcaArchiUser.Save(aStream: TStream);
//#UC START# *5729DCF300FC_57566B200124_var*
//#UC END# *5729DCF300FC_57566B200124_var*
begin
//#UC START# *5729DCF300FC_57566B200124_impl*
 f_HTUser.Save(aStream);
//#UC END# *5729DCF300FC_57566B200124_impl*
end;//TcaArchiUser.Save

procedure TcaArchiUser.Load(aStream: TStream);
//#UC START# *572B08330098_57566B200124_var*
var
 l_Pos: Int64;
//#UC END# *572B08330098_57566B200124_var*
begin
//#UC START# *572B08330098_57566B200124_impl*
 l_Pos := aStream.Position;
 f_HTUser.Load(aStream);
 aStream.Position := l_Pos;
 f_HTUser.Load(aStream);
//#UC END# *572B08330098_57566B200124_impl*
end;//TcaArchiUser.Load

function TcaArchiUser.Get_ID: TdaUserID;
//#UC START# *572B1204035B_57566B200124get_var*
//#UC END# *572B1204035B_57566B200124get_var*
begin
//#UC START# *572B1204035B_57566B200124get_impl*
 Result := f_HTUser.ID;
 Assert(Result = f_PGUser.ID);
//#UC END# *572B1204035B_57566B200124get_impl*
end;//TcaArchiUser.Get_ID

procedure TcaArchiUser.Set_ID(aValue: TdaUserID);
//#UC START# *572B1204035B_57566B200124set_var*
//#UC END# *572B1204035B_57566B200124set_var*
begin
//#UC START# *572B1204035B_57566B200124set_impl*
 f_HTUser.ID := aValue;
 f_PGUser.ID := aValue;
//#UC END# *572B1204035B_57566B200124set_impl*
end;//TcaArchiUser.Set_ID

function TcaArchiUser.Get_Active: Boolean;
//#UC START# *572B121B01DF_57566B200124get_var*
//#UC END# *572B121B01DF_57566B200124get_var*
begin
//#UC START# *572B121B01DF_57566B200124get_impl*
 Result := f_HTUser.Active;
 Assert(Result = f_PGUser.Active);
//#UC END# *572B121B01DF_57566B200124get_impl*
end;//TcaArchiUser.Get_Active

procedure TcaArchiUser.Set_Active(aValue: Boolean);
//#UC START# *572B121B01DF_57566B200124set_var*
//#UC END# *572B121B01DF_57566B200124set_var*
begin
//#UC START# *572B121B01DF_57566B200124set_impl*
 f_HTUser.Active := aValue;
 f_PGUser.Active := aValue;
//#UC END# *572B121B01DF_57566B200124set_impl*
end;//TcaArchiUser.Set_Active

function TcaArchiUser.Get_HasAdminRights: Boolean;
//#UC START# *572B123002B7_57566B200124get_var*
//#UC END# *572B123002B7_57566B200124get_var*
begin
//#UC START# *572B123002B7_57566B200124get_impl*
 Result := f_HTUser.HasAdminRights;
 Assert(Result = f_PGUser.HasAdminRights);
//#UC END# *572B123002B7_57566B200124get_impl*
end;//TcaArchiUser.Get_HasAdminRights

procedure TcaArchiUser.Set_HasAdminRights(aValue: Boolean);
//#UC START# *572B123002B7_57566B200124set_var*
//#UC END# *572B123002B7_57566B200124set_var*
begin
//#UC START# *572B123002B7_57566B200124set_impl*
 f_HTUser.HasAdminRights := aValue;
 f_PGUser.HasAdminRights := aValue;
//#UC END# *572B123002B7_57566B200124set_impl*
end;//TcaArchiUser.Set_HasAdminRights

function TcaArchiUser.Get_ExportPriority: TdaPriority;
//#UC START# *572B12420088_57566B200124get_var*
//#UC END# *572B12420088_57566B200124get_var*
begin
//#UC START# *572B12420088_57566B200124get_impl*
 Result := f_HTUser.ExportPriority;
 Assert(Result = f_PGUser.ExportPriority);
//#UC END# *572B12420088_57566B200124get_impl*
end;//TcaArchiUser.Get_ExportPriority

procedure TcaArchiUser.Set_ExportPriority(aValue: TdaPriority);
//#UC START# *572B12420088_57566B200124set_var*
//#UC END# *572B12420088_57566B200124set_var*
begin
//#UC START# *572B12420088_57566B200124set_impl*
 f_HTUser.ExportPriority := aValue;
 f_PGUser.ExportPriority := aValue;
//#UC END# *572B12420088_57566B200124set_impl*
end;//TcaArchiUser.Set_ExportPriority

function TcaArchiUser.Get_ImportPriority: TdaPriority;
//#UC START# *572B125E006C_57566B200124get_var*
//#UC END# *572B125E006C_57566B200124get_var*
begin
//#UC START# *572B125E006C_57566B200124get_impl*
 Result := f_HTUser.ImportPriority;
 Assert(Result = f_PGUser.ImportPriority);
//#UC END# *572B125E006C_57566B200124get_impl*
end;//TcaArchiUser.Get_ImportPriority

procedure TcaArchiUser.Set_ImportPriority(aValue: TdaPriority);
//#UC START# *572B125E006C_57566B200124set_var*
//#UC END# *572B125E006C_57566B200124set_var*
begin
//#UC START# *572B125E006C_57566B200124set_impl*
 f_HTUser.ImportPriority := aValue;
 f_PGUser.ImportPriority := aValue;
//#UC END# *572B125E006C_57566B200124set_impl*
end;//TcaArchiUser.Set_ImportPriority

function TcaArchiUser.Get_IP: AnsiString;
//#UC START# *572B126D0341_57566B200124get_var*
//#UC END# *572B126D0341_57566B200124get_var*
begin
//#UC START# *572B126D0341_57566B200124get_impl*
 Result := f_HTUser.IP;
 Assert(Result = f_PGUser.IP);
//#UC END# *572B126D0341_57566B200124get_impl*
end;//TcaArchiUser.Get_IP

procedure TcaArchiUser.Set_IP(const aValue: AnsiString);
//#UC START# *572B126D0341_57566B200124set_var*
//#UC END# *572B126D0341_57566B200124set_var*
begin
//#UC START# *572B126D0341_57566B200124set_impl*
 f_HTUser.IP := aValue;
 f_PGUser.IP := aValue;
//#UC END# *572B126D0341_57566B200124set_impl*
end;//TcaArchiUser.Set_IP

function TcaArchiUser.Get_LoginDate: TDateTime;
//#UC START# *572B127D0098_57566B200124get_var*
//#UC END# *572B127D0098_57566B200124get_var*
begin
//#UC START# *572B127D0098_57566B200124get_impl*
 Result := f_HTUser.LoginDate;
 Assert(Result = f_PGUser.LoginDate);
//#UC END# *572B127D0098_57566B200124get_impl*
end;//TcaArchiUser.Get_LoginDate

procedure TcaArchiUser.Set_LoginDate(aValue: TDateTime);
//#UC START# *572B127D0098_57566B200124set_var*
//#UC END# *572B127D0098_57566B200124set_var*
begin
//#UC START# *572B127D0098_57566B200124set_impl*
 f_HTUser.LoginDate := aValue;
 f_PGUser.LoginDate := aValue;
//#UC END# *572B127D0098_57566B200124set_impl*
end;//TcaArchiUser.Set_LoginDate

function TcaArchiUser.Get_LoginName: AnsiString;
//#UC START# *572B128D015A_57566B200124get_var*
//#UC END# *572B128D015A_57566B200124get_var*
begin
//#UC START# *572B128D015A_57566B200124get_impl*
 Result := f_HTUser.LoginName;
 Assert(Result = f_PGUser.LoginName);
//#UC END# *572B128D015A_57566B200124get_impl*
end;//TcaArchiUser.Get_LoginName

procedure TcaArchiUser.Set_LoginName(const aValue: AnsiString);
//#UC START# *572B128D015A_57566B200124set_var*
//#UC END# *572B128D015A_57566B200124set_var*
begin
//#UC START# *572B128D015A_57566B200124set_impl*
 f_HTUser.LoginName := aValue;
 f_PGUser.LoginName := aValue;
//#UC END# *572B128D015A_57566B200124set_impl*
end;//TcaArchiUser.Set_LoginName

function TcaArchiUser.Get_Password: AnsiString;
//#UC START# *572B129D021B_57566B200124get_var*
//#UC END# *572B129D021B_57566B200124get_var*
begin
//#UC START# *572B129D021B_57566B200124get_impl*
 Result := f_HTUser.Password;
 Assert(Result = f_PGUser.Password);
//#UC END# *572B129D021B_57566B200124get_impl*
end;//TcaArchiUser.Get_Password

procedure TcaArchiUser.Set_Password(const aValue: AnsiString);
//#UC START# *572B129D021B_57566B200124set_var*
//#UC END# *572B129D021B_57566B200124set_var*
begin
//#UC START# *572B129D021B_57566B200124set_impl*
 f_HTUser.Password := aValue;
 f_PGUser.Password := aValue;
//#UC END# *572B129D021B_57566B200124set_impl*
end;//TcaArchiUser.Set_Password

function TcaArchiUser.Get_UserName: AnsiString;
//#UC START# *572B12AE028C_57566B200124get_var*
//#UC END# *572B12AE028C_57566B200124get_var*
begin
//#UC START# *572B12AE028C_57566B200124get_impl*
 Result := f_HTUser.UserName;
 Assert(Result = f_PGUser.UserName);
//#UC END# *572B12AE028C_57566B200124get_impl*
end;//TcaArchiUser.Get_UserName

procedure TcaArchiUser.Set_UserName(const aValue: AnsiString);
//#UC START# *572B12AE028C_57566B200124set_var*
//#UC END# *572B12AE028C_57566B200124set_var*
begin
//#UC START# *572B12AE028C_57566B200124set_impl*
 f_HTUser.UserName := aValue;
 f_PGUser.UserName := aValue;
//#UC END# *572B12AE028C_57566B200124set_impl*
end;//TcaArchiUser.Set_UserName

procedure TcaArchiUser.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57566B200124_var*
//#UC END# *479731C50290_57566B200124_var*
begin
//#UC START# *479731C50290_57566B200124_impl*
 f_HTUser := nil;
 f_PGUser := nil;
 inherited;
//#UC END# *479731C50290_57566B200124_impl*
end;//TcaArchiUser.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
