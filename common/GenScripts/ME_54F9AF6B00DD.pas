unit htDataProviderParams;

// Модуль: "w:\common\components\rtl\Garant\HT\htDataProviderParams.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , daDataProviderParams
 , HyTechProviderParams_Const
 , dt_Types
 , k2Base
;

type
 ThtDataProviderParams = class(TdaDataProviderParams)
  protected
   function pm_GetStationName: AnsiString;
   procedure pm_SetStationName(const aValue: AnsiString);
   function pm_GetTablePath: AnsiString;
   procedure pm_SetTablePath(const aValue: AnsiString);
   function pm_GetTmpDirPath: AnsiString;
   procedure pm_SetTmpDirPath(const aValue: AnsiString);
   function pm_GetLockPath: AnsiString;
   procedure pm_SetLockPath(const aValue: AnsiString);
  public
   function MakePathRec: TPathRec;
   class function GetTaggedDataType: Tk2Type; override;
   procedure ChangeBasePath(const aPath: AnsiString); override;
   procedure AssignParams(aParams: TdaDataProviderParams); override;
  public
   property StationName: AnsiString
    read pm_GetStationName
    write pm_SetStationName;
   property TablePath: AnsiString
    read pm_GetTablePath
    write pm_SetTablePath;
   property TmpDirPath: AnsiString
    read pm_GetTmpDirPath
    write pm_SetTmpDirPath;
   property LockPath: AnsiString
    read pm_GetLockPath
    write pm_SetLockPath;
 end;//ThtDataProviderParams

implementation

uses
 l3ImplUses
 , l3FileUtils
 , ddUtils
 , SysUtils
;

function ThtDataProviderParams.pm_GetStationName: AnsiString;
//#UC START# *818595D6D5F9_54F9AF6B00DDget_var*
//#UC END# *818595D6D5F9_54F9AF6B00DDget_var*
begin
//#UC START# *818595D6D5F9_54F9AF6B00DDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *818595D6D5F9_54F9AF6B00DDget_impl*
end;//ThtDataProviderParams.pm_GetStationName

procedure ThtDataProviderParams.pm_SetStationName(const aValue: AnsiString);
//#UC START# *818595D6D5F9_54F9AF6B00DDset_var*
//#UC END# *818595D6D5F9_54F9AF6B00DDset_var*
begin
//#UC START# *818595D6D5F9_54F9AF6B00DDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *818595D6D5F9_54F9AF6B00DDset_impl*
end;//ThtDataProviderParams.pm_SetStationName

function ThtDataProviderParams.pm_GetTablePath: AnsiString;
//#UC START# *C4877C0D468E_54F9AF6B00DDget_var*
//#UC END# *C4877C0D468E_54F9AF6B00DDget_var*
begin
//#UC START# *C4877C0D468E_54F9AF6B00DDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4877C0D468E_54F9AF6B00DDget_impl*
end;//ThtDataProviderParams.pm_GetTablePath

procedure ThtDataProviderParams.pm_SetTablePath(const aValue: AnsiString);
//#UC START# *C4877C0D468E_54F9AF6B00DDset_var*
//#UC END# *C4877C0D468E_54F9AF6B00DDset_var*
begin
//#UC START# *C4877C0D468E_54F9AF6B00DDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4877C0D468E_54F9AF6B00DDset_impl*
end;//ThtDataProviderParams.pm_SetTablePath

function ThtDataProviderParams.pm_GetTmpDirPath: AnsiString;
//#UC START# *98857C6A95A2_54F9AF6B00DDget_var*
//#UC END# *98857C6A95A2_54F9AF6B00DDget_var*
begin
//#UC START# *98857C6A95A2_54F9AF6B00DDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *98857C6A95A2_54F9AF6B00DDget_impl*
end;//ThtDataProviderParams.pm_GetTmpDirPath

procedure ThtDataProviderParams.pm_SetTmpDirPath(const aValue: AnsiString);
//#UC START# *98857C6A95A2_54F9AF6B00DDset_var*
//#UC END# *98857C6A95A2_54F9AF6B00DDset_var*
begin
//#UC START# *98857C6A95A2_54F9AF6B00DDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *98857C6A95A2_54F9AF6B00DDset_impl*
end;//ThtDataProviderParams.pm_SetTmpDirPath

function ThtDataProviderParams.pm_GetLockPath: AnsiString;
//#UC START# *CD710F71E829_54F9AF6B00DDget_var*
//#UC END# *CD710F71E829_54F9AF6B00DDget_var*
begin
//#UC START# *CD710F71E829_54F9AF6B00DDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *CD710F71E829_54F9AF6B00DDget_impl*
end;//ThtDataProviderParams.pm_GetLockPath

procedure ThtDataProviderParams.pm_SetLockPath(const aValue: AnsiString);
//#UC START# *CD710F71E829_54F9AF6B00DDset_var*
//#UC END# *CD710F71E829_54F9AF6B00DDset_var*
begin
//#UC START# *CD710F71E829_54F9AF6B00DDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *CD710F71E829_54F9AF6B00DDset_impl*
end;//ThtDataProviderParams.pm_SetLockPath

function ThtDataProviderParams.MakePathRec: TPathRec;
//#UC START# *55114DCA0351_54F9AF6B00DD_var*
//#UC END# *55114DCA0351_54F9AF6B00DD_var*
begin
//#UC START# *55114DCA0351_54F9AF6B00DD_impl*
 Result.TblPath := TablePath;
 Result.HomePath := HomeDirPath;
 Result.LockPath := LockPath;
 Result.TmpPath := TmpDirPath;
 Result.DocImgPath := DocImagePath;
 Result.DocsPath := DocStoragePath;
//#UC END# *55114DCA0351_54F9AF6B00DD_impl*
end;//ThtDataProviderParams.MakePathRec

class function ThtDataProviderParams.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_54F9AF6B00DD_var*
//#UC END# *53AC03EE01FD_54F9AF6B00DD_var*
begin
//#UC START# *53AC03EE01FD_54F9AF6B00DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_54F9AF6B00DD_impl*
end;//ThtDataProviderParams.GetTaggedDataType

procedure ThtDataProviderParams.ChangeBasePath(const aPath: AnsiString);
//#UC START# *55195AE803E0_54F9AF6B00DD_var*
//#UC END# *55195AE803E0_54F9AF6B00DD_var*
begin
//#UC START# *55195AE803E0_54F9AF6B00DD_impl*
 inherited;
 TablePath := ConcatDirName(aPath, 'main');
 LockPath:= ConcatDirName(aPath, 'share');
 if TmpDirPath = '' then
  TmpDirPath := GetWindowsTempFolder;
//#UC END# *55195AE803E0_54F9AF6B00DD_impl*
end;//ThtDataProviderParams.ChangeBasePath

procedure ThtDataProviderParams.AssignParams(aParams: TdaDataProviderParams);
//#UC START# *553A37E902C9_54F9AF6B00DD_var*
//#UC END# *553A37E902C9_54F9AF6B00DD_var*
begin
//#UC START# *553A37E902C9_54F9AF6B00DD_impl*
 inherited;
 if aParams is ThtDataProviderParams then
 begin
  AliasesList.Assign(ThtDataProviderParams(aParams).AliasesList);
  StationName := ThtDataProviderParams(aParams).StationName;
  TablePath := ThtDataProviderParams(aParams).TablePath;
  TmpDirPath := ThtDataProviderParams(aParams).TmpDirPath;
  LockPath := ThtDataProviderParams(aParams).LockPath;
 end;
//#UC END# *553A37E902C9_54F9AF6B00DD_impl*
end;//ThtDataProviderParams.AssignParams

end.
