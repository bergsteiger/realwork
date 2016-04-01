unit NOT_COMPLETED_daDataProviderParams;

// Модуль: "w:\common\components\rtl\Garant\DA\NOT_COMPLETED_daDataProviderParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaDataProviderParams" MUID: (54F9A60200A8)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , daTypes
 , Classes
 , l3IniFile
 , k2Base
;

type
 TdaDataProviderParamsClass = class of TdaDataProviderParams;

 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TdaDataProviderParams = class(_evdTagHolder_)
  private
   f_UserID: TdaUserID;
    {* Поле для свойства UserID }
   f_AliasesList: TStringList;
    {* Поле для свойства AliasesList }
  protected
   function pm_GetFullHomeDirPath: AnsiString; virtual;
   function pm_GetLogin: AnsiString;
   procedure pm_SetLogin(const aValue: AnsiString);
   function pm_GetPassword: AnsiString;
   procedure pm_SetPassword(const aValue: AnsiString);
   function pm_GetDocStoragePath: AnsiString;
   procedure pm_SetDocStoragePath(const aValue: AnsiString);
   function pm_GetDocImagePath: AnsiString;
   procedure pm_SetDocImagePath(const aValue: AnsiString);
   function pm_GetHomeDirPath: AnsiString;
   procedure pm_SetHomeDirPath(const aValue: AnsiString);
   function pm_GetDocBaseVersion: Integer;
   procedure pm_SetDocBaseVersion(aValue: Integer);
   function pm_GetAdminBaseVersion: Integer;
   procedure pm_SetAdminBaseVersion(aValue: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure CorrectAfterSet;
   procedure ChangeBasePath(const aPath: AnsiString); virtual;
   procedure AssignParams(aParams: TdaDataProviderParams); virtual;
   function MakeBaseIni: TCfgList;
   class function ParamsKey: AnsiString;
   class function GetTaggedDataType: Tk2Type; override;
  public
   property UserID: TdaUserID
    read f_UserID
    write f_UserID;
   property FullHomeDirPath: AnsiString
    read pm_GetFullHomeDirPath;
    {* Полный путь к домашнему каталогу (с ID пользователя) }
   property AliasesList: TStringList
    read f_AliasesList;
   property Login: AnsiString
    read pm_GetLogin
    write pm_SetLogin;
   property Password: AnsiString
    read pm_GetPassword
    write pm_SetPassword;
   property DocStoragePath: AnsiString
    read pm_GetDocStoragePath
    write pm_SetDocStoragePath;
   property DocImagePath: AnsiString
    read pm_GetDocImagePath
    write pm_SetDocImagePath;
   property HomeDirPath: AnsiString
    read pm_GetHomeDirPath
    write pm_SetHomeDirPath;
   property DocBaseVersion: Integer
    read pm_GetDocBaseVersion
    write pm_SetDocBaseVersion;
   property AdminBaseVersion: Integer
    read pm_GetAdminBaseVersion
    write pm_SetAdminBaseVersion;
 end;//TdaDataProviderParams

implementation

uses
 l3ImplUses
 , l3FileUtils
 , daUtils
 , DataProviderParams_Const
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TdaDataProviderParams.pm_GetFullHomeDirPath: AnsiString;
//#UC START# *55C1ECC40309_54F9A60200A8get_var*
//#UC END# *55C1ECC40309_54F9A60200A8get_var*
begin
//#UC START# *55C1ECC40309_54F9A60200A8get_impl*
 if UserID <> 0 then
  Result := ConcatDirName(HomeDirPath, GetHomePathCode(UserID))
 else
  Result := HomeDirPath;
//#UC END# *55C1ECC40309_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetFullHomeDirPath

function TdaDataProviderParams.pm_GetLogin: AnsiString;
//#UC START# *B0886B1AD02D_54F9A60200A8get_var*
//#UC END# *B0886B1AD02D_54F9A60200A8get_var*
begin
//#UC START# *B0886B1AD02D_54F9A60200A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B0886B1AD02D_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetLogin

procedure TdaDataProviderParams.pm_SetLogin(const aValue: AnsiString);
//#UC START# *B0886B1AD02D_54F9A60200A8set_var*
//#UC END# *B0886B1AD02D_54F9A60200A8set_var*
begin
//#UC START# *B0886B1AD02D_54F9A60200A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *B0886B1AD02D_54F9A60200A8set_impl*
end;//TdaDataProviderParams.pm_SetLogin

function TdaDataProviderParams.pm_GetPassword: AnsiString;
//#UC START# *D5C03CDE39EF_54F9A60200A8get_var*
//#UC END# *D5C03CDE39EF_54F9A60200A8get_var*
begin
//#UC START# *D5C03CDE39EF_54F9A60200A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5C03CDE39EF_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetPassword

procedure TdaDataProviderParams.pm_SetPassword(const aValue: AnsiString);
//#UC START# *D5C03CDE39EF_54F9A60200A8set_var*
//#UC END# *D5C03CDE39EF_54F9A60200A8set_var*
begin
//#UC START# *D5C03CDE39EF_54F9A60200A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D5C03CDE39EF_54F9A60200A8set_impl*
end;//TdaDataProviderParams.pm_SetPassword

function TdaDataProviderParams.pm_GetDocStoragePath: AnsiString;
//#UC START# *831416B8EE51_54F9A60200A8get_var*
//#UC END# *831416B8EE51_54F9A60200A8get_var*
begin
//#UC START# *831416B8EE51_54F9A60200A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *831416B8EE51_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetDocStoragePath

procedure TdaDataProviderParams.pm_SetDocStoragePath(const aValue: AnsiString);
//#UC START# *831416B8EE51_54F9A60200A8set_var*
//#UC END# *831416B8EE51_54F9A60200A8set_var*
begin
//#UC START# *831416B8EE51_54F9A60200A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *831416B8EE51_54F9A60200A8set_impl*
end;//TdaDataProviderParams.pm_SetDocStoragePath

function TdaDataProviderParams.pm_GetDocImagePath: AnsiString;
//#UC START# *C7D4E9D7D086_54F9A60200A8get_var*
//#UC END# *C7D4E9D7D086_54F9A60200A8get_var*
begin
//#UC START# *C7D4E9D7D086_54F9A60200A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C7D4E9D7D086_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetDocImagePath

procedure TdaDataProviderParams.pm_SetDocImagePath(const aValue: AnsiString);
//#UC START# *C7D4E9D7D086_54F9A60200A8set_var*
//#UC END# *C7D4E9D7D086_54F9A60200A8set_var*
begin
//#UC START# *C7D4E9D7D086_54F9A60200A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *C7D4E9D7D086_54F9A60200A8set_impl*
end;//TdaDataProviderParams.pm_SetDocImagePath

function TdaDataProviderParams.pm_GetHomeDirPath: AnsiString;
//#UC START# *07F578763A7C_54F9A60200A8get_var*
//#UC END# *07F578763A7C_54F9A60200A8get_var*
begin
//#UC START# *07F578763A7C_54F9A60200A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *07F578763A7C_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetHomeDirPath

procedure TdaDataProviderParams.pm_SetHomeDirPath(const aValue: AnsiString);
//#UC START# *07F578763A7C_54F9A60200A8set_var*
//#UC END# *07F578763A7C_54F9A60200A8set_var*
begin
//#UC START# *07F578763A7C_54F9A60200A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *07F578763A7C_54F9A60200A8set_impl*
end;//TdaDataProviderParams.pm_SetHomeDirPath

function TdaDataProviderParams.pm_GetDocBaseVersion: Integer;
//#UC START# *FE0DB1805C11_54F9A60200A8get_var*
//#UC END# *FE0DB1805C11_54F9A60200A8get_var*
begin
//#UC START# *FE0DB1805C11_54F9A60200A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *FE0DB1805C11_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetDocBaseVersion

procedure TdaDataProviderParams.pm_SetDocBaseVersion(aValue: Integer);
//#UC START# *FE0DB1805C11_54F9A60200A8set_var*
//#UC END# *FE0DB1805C11_54F9A60200A8set_var*
begin
//#UC START# *FE0DB1805C11_54F9A60200A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *FE0DB1805C11_54F9A60200A8set_impl*
end;//TdaDataProviderParams.pm_SetDocBaseVersion

function TdaDataProviderParams.pm_GetAdminBaseVersion: Integer;
//#UC START# *F092404B3731_54F9A60200A8get_var*
//#UC END# *F092404B3731_54F9A60200A8get_var*
begin
//#UC START# *F092404B3731_54F9A60200A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F092404B3731_54F9A60200A8get_impl*
end;//TdaDataProviderParams.pm_GetAdminBaseVersion

procedure TdaDataProviderParams.pm_SetAdminBaseVersion(aValue: Integer);
//#UC START# *F092404B3731_54F9A60200A8set_var*
//#UC END# *F092404B3731_54F9A60200A8set_var*
begin
//#UC START# *F092404B3731_54F9A60200A8set_impl*
 !!! Needs to be implemented !!!
//#UC END# *F092404B3731_54F9A60200A8set_impl*
end;//TdaDataProviderParams.pm_SetAdminBaseVersion

procedure TdaDataProviderParams.CorrectAfterSet;
//#UC START# *55194F830311_54F9A60200A8_var*
//#UC END# *55194F830311_54F9A60200A8_var*
begin
//#UC START# *55194F830311_54F9A60200A8_impl*
 f_AliasesList.Clear;
 if DocStoragePath <> '' then
  f_AliasesList.Add(Format('FamilyPath=%s', [DocStoragePath]));
//#UC END# *55194F830311_54F9A60200A8_impl*
end;//TdaDataProviderParams.CorrectAfterSet

procedure TdaDataProviderParams.ChangeBasePath(const aPath: AnsiString);
//#UC START# *55195AE803E0_54F9A60200A8_var*
//#UC END# *55195AE803E0_54F9A60200A8_var*
begin
//#UC START# *55195AE803E0_54F9A60200A8_impl*
 Assert(aPath <> '');
 DocStoragePath := aPath;
 DocImagePath := ConcatDirName(aPath, 'images');
 HomeDirPath := ConcatDirName(aPath, 'homes');
//#UC END# *55195AE803E0_54F9A60200A8_impl*
end;//TdaDataProviderParams.ChangeBasePath

procedure TdaDataProviderParams.AssignParams(aParams: TdaDataProviderParams);
//#UC START# *553A37E902C9_54F9A60200A8_var*
//#UC END# *553A37E902C9_54F9A60200A8_var*
begin
//#UC START# *553A37E902C9_54F9A60200A8_impl*
 UserID := aParams.UserID;
 Login := aParams.Login;
 Password := aParams.Password;
 DocStoragePath := aParams.DocStoragePath;
 DocImagePath := aParams.DocImagePath;
 HomeDirPath := aParams.HomeDirPath;
 DocBaseVersion := aParams.DocBaseVersion;
 AdminBaseVersion := aParams.AdminBaseVersion;
 AliasesList.Assign(aParams.AliasesList);
//#UC END# *553A37E902C9_54F9A60200A8_impl*
end;//TdaDataProviderParams.AssignParams

function TdaDataProviderParams.MakeBaseIni: TCfgList;
//#UC START# *55F7DD1803E2_54F9A60200A8_var*
var
 l_BaseIniPath: AnsiString;
//#UC END# *55F7DD1803E2_54F9A60200A8_var*
begin
//#UC START# *55F7DD1803E2_54F9A60200A8_impl*
 l_BaseIniPath := ConcatDirName(DocStoragePath, 'garant\base.ini');
 if not FileExists(l_BaseIniPath) then
  raise Exception.Create('Не найден файл ' + l_BaseIniPath);

 Result := TCfgList.Create(l_BaseIniPath);
//#UC END# *55F7DD1803E2_54F9A60200A8_impl*
end;//TdaDataProviderParams.MakeBaseIni

class function TdaDataProviderParams.ParamsKey: AnsiString;
//#UC START# *550AB45B0179_54F9A60200A8_var*
//#UC END# *550AB45B0179_54F9A60200A8_var*
begin
//#UC START# *550AB45B0179_54F9A60200A8_impl*
 Result := GetTaggedDataType.TagType.AsString;
//#UC END# *550AB45B0179_54F9A60200A8_impl*
end;//TdaDataProviderParams.ParamsKey

class function TdaDataProviderParams.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54F9A60200A8_var*
//#UC END# *53AC03EE01FD_54F9A60200A8_var*
begin
//#UC START# *53AC03EE01FD_54F9A60200A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54F9A60200A8_impl*
end;//TdaDataProviderParams.GetTaggedDataType

procedure TdaDataProviderParams.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54F9A60200A8_var*
//#UC END# *479731C50290_54F9A60200A8_var*
begin
//#UC START# *479731C50290_54F9A60200A8_impl*
 FreeAndNil(f_AliasesList);
 inherited;
//#UC END# *479731C50290_54F9A60200A8_impl*
end;//TdaDataProviderParams.Cleanup

procedure TdaDataProviderParams.InitFields;
//#UC START# *47A042E100E2_54F9A60200A8_var*
//#UC END# *47A042E100E2_54F9A60200A8_var*
begin
//#UC START# *47A042E100E2_54F9A60200A8_impl*
 inherited;
 f_AliasesList := TStringList.Create;
//#UC END# *47A042E100E2_54F9A60200A8_impl*
end;//TdaDataProviderParams.InitFields

end.
