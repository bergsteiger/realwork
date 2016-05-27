unit caDataProviderParams;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caDataProviderParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaDataProviderParams" MUID: (56A86B450218)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , htDataProviderParams
 , pgDataProviderParams
 , daDataProviderParams
 , k2Base
;

type
 TcaDataProviderParams = class(ThtDataProviderParams)
  private
   f_HTParams: ThtDataProviderParams;
   f_PGParams: TpgDataProviderParams;
  protected
   function pm_GetDataServerHostName: AnsiString;
   procedure pm_SetDataServerHostName(const aValue: AnsiString);
   function pm_GetDataServerPort: Integer;
   procedure pm_SetDataServerPort(aValue: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aHTParams: ThtDataProviderParams;
    aPGParams: TpgDataProviderParams); reintroduce;
   procedure LoadFromAlienParams;
   procedure SaveToAlienParams;
   procedure ChangeBasePath(const aPath: AnsiString); override;
   procedure AssignParams(aParams: TdaDataProviderParams); override;
   class function GetTaggedDataType: Tk2Type; override;
  public
   property HTParams: ThtDataProviderParams
    read f_HTParams;
   property PGParams: TpgDataProviderParams
    read f_PGParams;
   property DataServerHostName: AnsiString
    read pm_GetDataServerHostName
    write pm_SetDataServerHostName;
   property DataServerPort: Integer
    read pm_GetDataServerPort
    write pm_SetDataServerPort;
 end;//TcaDataProviderParams
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , SysUtils
 , ComboAccessProviderParams_Const
;

function TcaDataProviderParams.pm_GetDataServerHostName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDataServerHostName]);
end;//TcaDataProviderParams.pm_GetDataServerHostName

procedure TcaDataProviderParams.pm_SetDataServerHostName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDataServerHostName, nil] := (aValue);
end;//TcaDataProviderParams.pm_SetDataServerHostName

function TcaDataProviderParams.pm_GetDataServerPort: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDataServerPort]);
end;//TcaDataProviderParams.pm_GetDataServerPort

procedure TcaDataProviderParams.pm_SetDataServerPort(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDataServerPort, nil] := (aValue);
end;//TcaDataProviderParams.pm_SetDataServerPort

constructor TcaDataProviderParams.Create(aHTParams: ThtDataProviderParams;
 aPGParams: TpgDataProviderParams);
//#UC START# *56B9C44F02BE_56A86B450218_var*
//#UC END# *56B9C44F02BE_56A86B450218_var*
begin
//#UC START# *56B9C44F02BE_56A86B450218_impl*
 inherited Create;
 aHTParams.SetRefTo(f_HTParams);
 aPGParams.SetRefTo(f_PGParams);
//#UC END# *56B9C44F02BE_56A86B450218_impl*
end;//TcaDataProviderParams.Create

procedure TcaDataProviderParams.LoadFromAlienParams;
//#UC START# *56B9D5D8017F_56A86B450218_var*
//#UC END# *56B9D5D8017F_56A86B450218_var*
begin
//#UC START# *56B9D5D8017F_56A86B450218_impl*
 Login := f_HTParams.Login;
 Password := f_HTParams.Password;
 DocStoragePath := f_HTParams.DocStoragePath;
 DocImagePath := f_HTParams.DocImagePath;
 HomeDirPath := f_HTParams.HomeDirPath;
 DocBaseVersion := f_HTParams.DocBaseVersion;
 AdminBaseVersion := f_HTParams.AdminBaseVersion;
 UserID := f_HTParams.UserID;

 StationName := f_HTParams.StationName;
 TablePath := f_HTParams.TablePath;
 LockPath := f_HTParams.LockPath;
 TmpDirPath := f_HTParams.TmpDirPath;

 DataServerHostName := f_PGParams.DataServerHostName;
 DataServerPort := f_PGParams.DataServerPort;
//#UC END# *56B9D5D8017F_56A86B450218_impl*
end;//TcaDataProviderParams.LoadFromAlienParams

procedure TcaDataProviderParams.SaveToAlienParams;
//#UC START# *56B9E3810358_56A86B450218_var*
 procedure lp_SaveCommon(const aTarget: TdaDataProviderParams);
 begin
  aTarget.Login := Login;
  aTarget.Password := Password;
  aTarget.DocStoragePath := DocStoragePath;
  aTarget.DocImagePath := DocImagePath;
  aTarget.HomeDirPath := HomeDirPath;
  aTarget.DocBaseVersion := DocBaseVersion;
  aTarget.AdminBaseVersion := AdminBaseVersion;
  aTarget.UserID := UserID;
 end;
//#UC END# *56B9E3810358_56A86B450218_var*
begin
//#UC START# *56B9E3810358_56A86B450218_impl*
 lp_SaveCommon(f_HTParams);
 lp_SaveCommon(f_PGParams);

 f_HTParams.StationName := StationName;
 f_HTParams.TablePath := TablePath;
 f_HTParams.LockPath := LockPath;
 f_HTParams.TmpDirPath := TmpDirPath;

 f_PGParams.DataServerHostName := DataServerHostName;
 f_PGParams.DataServerPort := DataServerPort;
//#UC END# *56B9E3810358_56A86B450218_impl*
end;//TcaDataProviderParams.SaveToAlienParams

procedure TcaDataProviderParams.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56A86B450218_var*
//#UC END# *479731C50290_56A86B450218_var*
begin
//#UC START# *479731C50290_56A86B450218_impl*
 FreeAndNil(f_HTParams);
 FreeAndNil(f_PGParams);
 inherited;
//#UC END# *479731C50290_56A86B450218_impl*
end;//TcaDataProviderParams.Cleanup

procedure TcaDataProviderParams.ChangeBasePath(const aPath: AnsiString);
//#UC START# *55195AE803E0_56A86B450218_var*
//#UC END# *55195AE803E0_56A86B450218_var*
begin
//#UC START# *55195AE803E0_56A86B450218_impl*
 SaveToAlienParams;
 inherited;
 HTParams.ChangeBasePath(aPath);
 PGParams.ChangeBasePath(aPath);
 LoadFromAlienParams;
//#UC END# *55195AE803E0_56A86B450218_impl*
end;//TcaDataProviderParams.ChangeBasePath

procedure TcaDataProviderParams.AssignParams(aParams: TdaDataProviderParams);
//#UC START# *553A37E902C9_56A86B450218_var*
//#UC END# *553A37E902C9_56A86B450218_var*
begin
//#UC START# *553A37E902C9_56A86B450218_impl*
 inherited;
 if aParams is TcaDataProviderParams then
 begin
  SaveToAlienParams;
  HTParams.AssignParams(TcaDataProviderParams(aParams).HTParams);
  PGParams.AssignParams(TcaDataProviderParams(aParams).PGParams);
  LoadFromAlienParams;
 end;
//#UC END# *553A37E902C9_56A86B450218_impl*
end;//TcaDataProviderParams.AssignParams

class function TcaDataProviderParams.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typComboAccessProviderParams;
end;//TcaDataProviderParams.GetTaggedDataType
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
