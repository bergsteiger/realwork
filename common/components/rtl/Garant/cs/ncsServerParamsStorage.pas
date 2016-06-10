unit ncsServerParamsStorage;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsServerParamsStorage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsServerParamsStorage" MUID: (5507E70200AF)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , htInterfaces
 , ddAppConfig
;

type
 TncsServerParamsStorage = class(Tl3ProtoObject, IdaParamsStorage, IhtParamsStorage)
  protected
   function Get_ProviderKey: AnsiString;
   procedure Set_ProviderKey(const aValue: AnsiString);
   procedure InitStorage;
   function Get_Login: AnsiString;
   procedure Set_Login(const aValue: AnsiString);
   function Get_Password: AnsiString;
   procedure Set_Password(const aValue: AnsiString);
   function Get_DocStoragePath: AnsiString;
   procedure Set_DocStoragePath(const aValue: AnsiString);
   function Get_DocImagePath: AnsiString;
   procedure Set_DocImagePath(const aValue: AnsiString);
   function Get_HomeDirPath: AnsiString;
   procedure Set_HomeDirPath(const aValue: AnsiString);
   function Get_StationName: AnsiString;
   function Get_TablePath: AnsiString;
   procedure Set_TablePath(const aValue: AnsiString);
   function Get_LockPath: AnsiString;
   procedure Set_LockPath(const aValue: AnsiString);
   function Get_TempPath: AnsiString;
   procedure Set_TempPath(const aValue: AnsiString);
   function StationErrorMessage: AnsiString;
   function TablePathErrorMessage: AnsiString;
   function LockPathErrorMessage: AnsiString;
   function OuterConfigEdit: Boolean;
   procedure BuildConfig(aConfig: TddAppConfiguration;
    const aProviderKey: AnsiString); overload;
   function Get_DocImageCachePath: AnsiString;
   procedure Set_DocImageCachePath(const aValue: AnsiString);
  public
   class function Make: IdaParamsStorage; reintroduce;
 end;//TncsServerParamsStorage
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3FileUtils
 , StrUtils
 , ddUtils
 , SysUtils
 , evdTaskTypes
 , ddAppConfigConst
 , ddAppConfigStrings
 , ddAppConfigTypes
 , l3Base
 {$If Defined(UsePostgres)}
 , pgDataProviderFactory
 {$IfEnd} // Defined(UsePostgres)
 , htDataProviderFactory
;

class function TncsServerParamsStorage.Make: IdaParamsStorage;
var
 l_Inst : TncsServerParamsStorage;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsServerParamsStorage.Make

function TncsServerParamsStorage.Get_ProviderKey: AnsiString;
//#UC START# *5507D9B100F7_5507E70200AFget_var*
//#UC END# *5507D9B100F7_5507E70200AFget_var*
begin
//#UC START# *5507D9B100F7_5507E70200AFget_impl*
 Result := ddAppConfiguration.AsString['Provider'];
//#UC END# *5507D9B100F7_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_ProviderKey

procedure TncsServerParamsStorage.Set_ProviderKey(const aValue: AnsiString);
//#UC START# *5507D9B100F7_5507E70200AFset_var*
//#UC END# *5507D9B100F7_5507E70200AFset_var*
begin
//#UC START# *5507D9B100F7_5507E70200AFset_impl*
 ddAppConfiguration.AsString['Provider'] := aValue;
//#UC END# *5507D9B100F7_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_ProviderKey

procedure TncsServerParamsStorage.InitStorage;
//#UC START# *55095596033F_5507E70200AF_var*
//#UC END# *55095596033F_5507E70200AF_var*
begin
//#UC START# *55095596033F_5507E70200AF_impl*
 Assert(ddAppConfiguration <> nil);
//#UC END# *55095596033F_5507E70200AF_impl*
end;//TncsServerParamsStorage.InitStorage

function TncsServerParamsStorage.Get_Login: AnsiString;
//#UC START# *550963930391_5507E70200AFget_var*
//#UC END# *550963930391_5507E70200AFget_var*
begin
//#UC START# *550963930391_5507E70200AFget_impl*
 Result := '';
//#UC END# *550963930391_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_Login

procedure TncsServerParamsStorage.Set_Login(const aValue: AnsiString);
//#UC START# *550963930391_5507E70200AFset_var*
//#UC END# *550963930391_5507E70200AFset_var*
begin
//#UC START# *550963930391_5507E70200AFset_impl*
// Do nothing
//#UC END# *550963930391_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_Login

function TncsServerParamsStorage.Get_Password: AnsiString;
//#UC START# *550963A60121_5507E70200AFget_var*
//#UC END# *550963A60121_5507E70200AFget_var*
begin
//#UC START# *550963A60121_5507E70200AFget_impl*
 Result := '';
//#UC END# *550963A60121_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_Password

procedure TncsServerParamsStorage.Set_Password(const aValue: AnsiString);
//#UC START# *550963A60121_5507E70200AFset_var*
//#UC END# *550963A60121_5507E70200AFset_var*
begin
//#UC START# *550963A60121_5507E70200AFset_impl*
// Do nothing
//#UC END# *550963A60121_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_Password

function TncsServerParamsStorage.Get_DocStoragePath: AnsiString;
//#UC START# *550963BC00B0_5507E70200AFget_var*
//#UC END# *550963BC00B0_5507E70200AFget_var*
begin
//#UC START# *550963BC00B0_5507E70200AFget_impl*
 Result := IfThen(ddAppConfiguration.AsBoolean['IsLocalBase'], ddAppConfiguration.AsString['LocalBasePath'], ddAppConfiguration.AsString['UNCBasePath'])
//#UC END# *550963BC00B0_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_DocStoragePath

procedure TncsServerParamsStorage.Set_DocStoragePath(const aValue: AnsiString);
//#UC START# *550963BC00B0_5507E70200AFset_var*
//#UC END# *550963BC00B0_5507E70200AFset_var*
begin
//#UC START# *550963BC00B0_5507E70200AFset_impl*
// Do nothing
//#UC END# *550963BC00B0_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_DocStoragePath

function TncsServerParamsStorage.Get_DocImagePath: AnsiString;
//#UC START# *550963CF0092_5507E70200AFget_var*
//#UC END# *550963CF0092_5507E70200AFget_var*
begin
//#UC START# *550963CF0092_5507E70200AFget_impl*
 Result := ddAppConfiguration.AsString['ImageStoragePath'];
//#UC END# *550963CF0092_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_DocImagePath

procedure TncsServerParamsStorage.Set_DocImagePath(const aValue: AnsiString);
//#UC START# *550963CF0092_5507E70200AFset_var*
//#UC END# *550963CF0092_5507E70200AFset_var*
begin
//#UC START# *550963CF0092_5507E70200AFset_impl*
// Do nothing
//#UC END# *550963CF0092_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_DocImagePath

function TncsServerParamsStorage.Get_HomeDirPath: AnsiString;
//#UC START# *550963EB02F8_5507E70200AFget_var*
//#UC END# *550963EB02F8_5507E70200AFget_var*
begin
//#UC START# *550963EB02F8_5507E70200AFget_impl*
 Result := ConcatDirName(Get_DocStoragePath, 'homes')
//#UC END# *550963EB02F8_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_HomeDirPath

procedure TncsServerParamsStorage.Set_HomeDirPath(const aValue: AnsiString);
//#UC START# *550963EB02F8_5507E70200AFset_var*
//#UC END# *550963EB02F8_5507E70200AFset_var*
begin
//#UC START# *550963EB02F8_5507E70200AFset_impl*
// Do nothing
//#UC END# *550963EB02F8_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_HomeDirPath

function TncsServerParamsStorage.Get_StationName: AnsiString;
//#UC START# *550981E5026A_5507E70200AFget_var*
//#UC END# *550981E5026A_5507E70200AFget_var*
begin
//#UC START# *550981E5026A_5507E70200AFget_impl*
 Result := IntToHex(usServerService, 8);
//#UC END# *550981E5026A_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_StationName

function TncsServerParamsStorage.Get_TablePath: AnsiString;
//#UC START# *550981FF0138_5507E70200AFget_var*
//#UC END# *550981FF0138_5507E70200AFget_var*
begin
//#UC START# *550981FF0138_5507E70200AFget_impl*
 Result := ConcatDirName(Get_DocStoragePath, 'main');
//#UC END# *550981FF0138_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_TablePath

procedure TncsServerParamsStorage.Set_TablePath(const aValue: AnsiString);
//#UC START# *550981FF0138_5507E70200AFset_var*
//#UC END# *550981FF0138_5507E70200AFset_var*
begin
//#UC START# *550981FF0138_5507E70200AFset_impl*
// Do nothing
//#UC END# *550981FF0138_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_TablePath

function TncsServerParamsStorage.Get_LockPath: AnsiString;
//#UC START# *550982210098_5507E70200AFget_var*
//#UC END# *550982210098_5507E70200AFget_var*
begin
//#UC START# *550982210098_5507E70200AFget_impl*
 Result := ConcatDirName(Get_DocStoragePath, 'share');
//#UC END# *550982210098_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_LockPath

procedure TncsServerParamsStorage.Set_LockPath(const aValue: AnsiString);
//#UC START# *550982210098_5507E70200AFset_var*
//#UC END# *550982210098_5507E70200AFset_var*
begin
//#UC START# *550982210098_5507E70200AFset_impl*
// Do nothing
//#UC END# *550982210098_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_LockPath

function TncsServerParamsStorage.Get_TempPath: AnsiString;
//#UC START# *550982360334_5507E70200AFget_var*
//#UC END# *550982360334_5507E70200AFget_var*
begin
//#UC START# *550982360334_5507E70200AFget_impl*
 Result := GetWindowsTempFolder;
//#UC END# *550982360334_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_TempPath

procedure TncsServerParamsStorage.Set_TempPath(const aValue: AnsiString);
//#UC START# *550982360334_5507E70200AFset_var*
//#UC END# *550982360334_5507E70200AFset_var*
begin
//#UC START# *550982360334_5507E70200AFset_impl*
// Do nothing
//#UC END# *550982360334_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_TempPath

function TncsServerParamsStorage.StationErrorMessage: AnsiString;
//#UC START# *5512621F0352_5507E70200AF_var*
//#UC END# *5512621F0352_5507E70200AF_var*
begin
//#UC START# *5512621F0352_5507E70200AF_impl*
 Result := 'Не задно имя станции! Задайте параметр StationName';
//#UC END# *5512621F0352_5507E70200AF_impl*
end;//TncsServerParamsStorage.StationErrorMessage

function TncsServerParamsStorage.TablePathErrorMessage: AnsiString;
//#UC START# *551262410001_5507E70200AF_var*
//#UC END# *551262410001_5507E70200AF_var*
begin
//#UC START# *551262410001_5507E70200AF_impl*
 Result := 'Не задан путь к базам! Задайте параметр TablePath';
//#UC END# *551262410001_5507E70200AF_impl*
end;//TncsServerParamsStorage.TablePathErrorMessage

function TncsServerParamsStorage.LockPathErrorMessage: AnsiString;
//#UC START# *551262530061_5507E70200AF_var*
//#UC END# *551262530061_5507E70200AF_var*
begin
//#UC START# *551262530061_5507E70200AF_impl*
 Result := 'Не задан путь к разделяемым ресурсам! Задайте параметр LockPath';
//#UC END# *551262530061_5507E70200AF_impl*
end;//TncsServerParamsStorage.LockPathErrorMessage

function TncsServerParamsStorage.OuterConfigEdit: Boolean;
//#UC START# *5515121F0358_5507E70200AF_var*
//#UC END# *5515121F0358_5507E70200AF_var*
begin
//#UC START# *5515121F0358_5507E70200AF_impl*
 Result := True;
//#UC END# *5515121F0358_5507E70200AF_impl*
end;//TncsServerParamsStorage.OuterConfigEdit

procedure TncsServerParamsStorage.BuildConfig(aConfig: TddAppConfiguration;
 const aProviderKey: AnsiString);
//#UC START# *551512370064_5507E70200AF_var*
var
 l_Default: TddConfigValue;
 l_Item: TddBooleanConfigItem;

 function lp_AddFolderNameItem(const aAlias: AnsiString;
   const aCaption: AnsiString;
   const aHint: AnsiString
   ): TddBaseConfigItem;
 begin
  l3FillChar(l_Default, SizeOf(l_Default), 0);
  l_Default.Kind := dd_vkString;
  l_Default.AsString := '';
  Result := TddFolderNameConfigItem.Create(aAlias, aCaption, l_Default, nil);
  TddFolderNameConfigItem(Result).Hint := aHint;
  TddFolderNameConfigItem(Result).Required := True;
  TddFolderNameConfigItem(Result).AllowProcessDir := False;
 end;

//#UC END# *551512370064_5507E70200AF_var*
begin
//#UC START# *551512370064_5507E70200AF_impl*
 if (ThtDataProviderFactory.Key = aProviderKey) then
 begin
  aConfig.AddItem(lp_AddFolderNameItem('UNCBasePath', 'UNC-путь к базе данных',
   'Используя этот путь, программа выполняет подключение к базе данных в штатном (многопользовательском) режиме'));
  aConfig.AddItem(lp_AddFolderNameItem('LocalBasePath', 'Локальный путь к базе данных',
   'Используя этот путь, программа выполняет подключение к базе данных для выполнения регламентных работ'));
  aConfig.AddItem(lp_AddFolderNameItem('ImageStoragePath', 'Образы документов',
   'Папка для хранения сканированных образов документов'));
  aConfig.AddItem(lp_AddFolderNameItem('ImageCachePath', 'Кэш образов документов',
   'Папка для кэширования образов документов'));
  l3FillChar(l_Default, SizeOf(l_Default), 0);
  l_Default.Kind := dd_vkBoolean;
  l_Default.AsBoolean := False;
  l_Item := TddBooleanConfigItem.Create('IsLocalBase', 'Работа по локальным путям', l_Default, nil);
  l_Item.Hint := 'ВНИМАНИЕ! Работа по локальным путям происходит быстрее, но не допускает совместного использования базы данных';
  aConfig.AddItem(l_Item);
 end; 
{$If defined(UsePostgres)}
 if (TpgDataProviderFactory.Key = aProviderKey) then
 begin
  aConfig.AddStringItem('DataServerHostName', 'Адрес сервера БД', '');
  aConfig.AddIntegerItem(l3CStr('DataServerPort'), l3CStr('Порт сервера БД'), 5432);
 end;
{$IfEnd defined(UsePostgres)}
//#UC END# *551512370064_5507E70200AF_impl*
end;//TncsServerParamsStorage.BuildConfig

function TncsServerParamsStorage.Get_DocImageCachePath: AnsiString;
//#UC START# *5756BD40014A_5507E70200AFget_var*
//#UC END# *5756BD40014A_5507E70200AFget_var*
begin
//#UC START# *5756BD40014A_5507E70200AFget_impl*
 Result := ddAppConfiguration.AsString['ImageCachePath'];
//#UC END# *5756BD40014A_5507E70200AFget_impl*
end;//TncsServerParamsStorage.Get_DocImageCachePath

procedure TncsServerParamsStorage.Set_DocImageCachePath(const aValue: AnsiString);
//#UC START# *5756BD40014A_5507E70200AFset_var*
//#UC END# *5756BD40014A_5507E70200AFset_var*
begin
//#UC START# *5756BD40014A_5507E70200AFset_impl*
 // do nothing
//#UC END# *5756BD40014A_5507E70200AFset_impl*
end;//TncsServerParamsStorage.Set_DocImageCachePath
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
