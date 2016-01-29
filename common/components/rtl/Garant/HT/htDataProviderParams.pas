unit htDataProviderParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HT"
// Модуль: "w:/common/components/rtl/Garant/HT/htDataProviderParams.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtDataProviderParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  Classes,
  dt_Types,
  daDataProviderParams,
  k2Base
  ;

type
 ThtDataProviderParams = class(TdaDataProviderParams)
 private
 // private fields
   f_AliasesList : TStringList;
    {* Поле для свойства AliasesList}
 protected
 // property methods
   function pm_GetStationName: AnsiString;
   procedure pm_SetStationName(const aValue: AnsiString);
   function pm_GetTablePath: AnsiString;
   procedure pm_SetTablePath(const aValue: AnsiString);
   function pm_GetTmpDirPath: AnsiString;
   procedure pm_SetTmpDirPath(const aValue: AnsiString);
   function pm_GetLockPath: AnsiString;
   procedure pm_SetLockPath(const aValue: AnsiString);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   class function GetTaggedDataType: Tk2Type; override;
 public
 // overridden public methods
   procedure CorrectAfterSet; override;
     {* Сигнатура метода CorrectAfterSet }
   procedure ChangeBasePath(const aPath: AnsiString); override;
   procedure AssignParams(aParams: TdaDataProviderParams); override;
 public
 // public methods
   function MakePathRec: TPathRec;
 public
 // public properties
   property AliasesList: TStringList
     read f_AliasesList;
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
  l3FileUtils,
  ddUtils,
  SysUtils,
  HyTechProviderParams_Const
  ;

// start class ThtDataProviderParams

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

function ThtDataProviderParams.pm_GetStationName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrStationName]);
end;//ThtDataProviderParams.pm_GetStationName

procedure ThtDataProviderParams.pm_SetStationName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrStationName, nil] := (aValue);
end;//ThtDataProviderParams.pm_SetStationName

function ThtDataProviderParams.pm_GetTablePath: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTablePath]);
end;//ThtDataProviderParams.pm_GetTablePath

procedure ThtDataProviderParams.pm_SetTablePath(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTablePath, nil] := (aValue);
end;//ThtDataProviderParams.pm_SetTablePath

function ThtDataProviderParams.pm_GetTmpDirPath: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTmpDirPath]);
end;//ThtDataProviderParams.pm_GetTmpDirPath

procedure ThtDataProviderParams.pm_SetTmpDirPath(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTmpDirPath, nil] := (aValue);
end;//ThtDataProviderParams.pm_SetTmpDirPath

function ThtDataProviderParams.pm_GetLockPath: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLockPath]);
end;//ThtDataProviderParams.pm_GetLockPath

procedure ThtDataProviderParams.pm_SetLockPath(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrLockPath, nil] := (aValue);
end;//ThtDataProviderParams.pm_SetLockPath

procedure ThtDataProviderParams.Cleanup;
//#UC START# *479731C50290_54F9AF6B00DD_var*
//#UC END# *479731C50290_54F9AF6B00DD_var*
begin
//#UC START# *479731C50290_54F9AF6B00DD_impl*
 FreeAndNil(f_AliasesList);
 inherited;
//#UC END# *479731C50290_54F9AF6B00DD_impl*
end;//ThtDataProviderParams.Cleanup

procedure ThtDataProviderParams.InitFields;
//#UC START# *47A042E100E2_54F9AF6B00DD_var*
//#UC END# *47A042E100E2_54F9AF6B00DD_var*
begin
//#UC START# *47A042E100E2_54F9AF6B00DD_impl*
 inherited;
 f_AliasesList := TStringList.Create;
//#UC END# *47A042E100E2_54F9AF6B00DD_impl*
end;//ThtDataProviderParams.InitFields

class function ThtDataProviderParams.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typHyTechProviderParams;
end;//ThtDataProviderParams.GetTaggedDataType

procedure ThtDataProviderParams.CorrectAfterSet;
//#UC START# *55194F830311_54F9AF6B00DD_var*
//#UC END# *55194F830311_54F9AF6B00DD_var*
begin
//#UC START# *55194F830311_54F9AF6B00DD_impl*
 f_AliasesList.Clear;
 if DocStoragePath <> '' then
  f_AliasesList.Add(Format('FamilyPath=%s', [DocStoragePath]));
//#UC END# *55194F830311_54F9AF6B00DD_impl*
end;//ThtDataProviderParams.CorrectAfterSet

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