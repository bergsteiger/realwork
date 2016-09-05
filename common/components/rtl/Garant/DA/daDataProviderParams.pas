unit daDataProviderParams;

// Модуль: "w:\common\components\rtl\Garant\DA\daDataProviderParams.pas"
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
   f_AliasesList: TStringList;
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
   function pm_GetDocImageCachePath: AnsiString;
   procedure pm_SetDocImageCachePath(const aValue: AnsiString);
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
   property DocImageCachePath: AnsiString
    read pm_GetDocImageCachePath
    write pm_SetDocImageCachePath;
 end;//TdaDataProviderParams

implementation

uses
 l3ImplUses
 , l3FileUtils
 , daUtils
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
 , DataProviderParams_Const
 //#UC START# *54F9A60200A8impl_uses*
 //#UC END# *54F9A60200A8impl_uses*
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
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogin]);
end;//TdaDataProviderParams.pm_GetLogin

procedure TdaDataProviderParams.pm_SetLogin(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrLogin, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetLogin

function TdaDataProviderParams.pm_GetPassword: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrPassword]);
end;//TdaDataProviderParams.pm_GetPassword

procedure TdaDataProviderParams.pm_SetPassword(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrPassword, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetPassword

function TdaDataProviderParams.pm_GetDocStoragePath: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocStoragePath]);
end;//TdaDataProviderParams.pm_GetDocStoragePath

procedure TdaDataProviderParams.pm_SetDocStoragePath(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDocStoragePath, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetDocStoragePath

function TdaDataProviderParams.pm_GetDocImagePath: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocImagePath]);
end;//TdaDataProviderParams.pm_GetDocImagePath

procedure TdaDataProviderParams.pm_SetDocImagePath(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDocImagePath, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetDocImagePath

function TdaDataProviderParams.pm_GetHomeDirPath: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrHomeDirPath]);
end;//TdaDataProviderParams.pm_GetHomeDirPath

procedure TdaDataProviderParams.pm_SetHomeDirPath(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrHomeDirPath, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetHomeDirPath

function TdaDataProviderParams.pm_GetDocBaseVersion: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocBaseVersion]);
end;//TdaDataProviderParams.pm_GetDocBaseVersion

procedure TdaDataProviderParams.pm_SetDocBaseVersion(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDocBaseVersion, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetDocBaseVersion

function TdaDataProviderParams.pm_GetAdminBaseVersion: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrAdminBaseVersion]);
end;//TdaDataProviderParams.pm_GetAdminBaseVersion

procedure TdaDataProviderParams.pm_SetAdminBaseVersion(aValue: Integer);
begin
 TaggedData.IntW[k2_attrAdminBaseVersion, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetAdminBaseVersion

function TdaDataProviderParams.pm_GetDocImageCachePath: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocImageCachePath]);
end;//TdaDataProviderParams.pm_GetDocImageCachePath

procedure TdaDataProviderParams.pm_SetDocImageCachePath(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDocImageCachePath, nil] := (aValue);
end;//TdaDataProviderParams.pm_SetDocImageCachePath

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
 DocImageCachePath := ConcatDirName(aPath, 'images_cache');
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
 DocImageCachePath := aParams.DocImageCachePath;
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
begin
 Result := k2_typDataProviderParams;
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
