unit ncsClientParamsStorage;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsClientParamsStorage.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsClientParamsStorage" MUID: (5507E6CB0165)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , htInterfaces
 {$If Defined(UsePostgres)}
 , pgInterfaces
 {$IfEnd} // Defined(UsePostgres)
 , ddAppConfig
;

const
 BaseSection = 'BaseDocPath';
 FamilySection = 'FamilyConst';
 DataSection = 'Postgress.Data';

type
 TncsClientParamsStorage = class(Tl3ProtoObject, IdaParamsStorage, IhtParamsStorage{$If Defined(UsePostgres)}
 , IpgParamsStorage
 {$IfEnd} // Defined(UsePostgres)
 )
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
   {$If Defined(UsePostgres)}
   function Get_DataServerHostName: AnsiString;
   {$IfEnd} // Defined(UsePostgres)
   {$If Defined(UsePostgres)}
   procedure Set_DataServerHostName(const aValue: AnsiString);
   {$IfEnd} // Defined(UsePostgres)
   {$If Defined(UsePostgres)}
   function Get_DataServerPort: Integer;
   {$IfEnd} // Defined(UsePostgres)
   {$If Defined(UsePostgres)}
   procedure Set_DataServerPort(aValue: Integer);
   {$IfEnd} // Defined(UsePostgres)
   function Get_DocImageCachePath: AnsiString;
   procedure Set_DocImageCachePath(const aValue: AnsiString);
  public
   class function Make: IdaParamsStorage; reintroduce;
 end;//TncsClientParamsStorage
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3IniFile
 , l3Utils
 , l3Base64
 , l3FileUtils
 , SysUtils
 //#UC START# *5507E6CB0165impl_uses*
 //#UC END# *5507E6CB0165impl_uses*
;

class function TncsClientParamsStorage.Make: IdaParamsStorage;
var
 l_Inst : TncsClientParamsStorage;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsClientParamsStorage.Make

function TncsClientParamsStorage.Get_ProviderKey: AnsiString;
//#UC START# *5507D9B100F7_5507E6CB0165get_var*
//#UC END# *5507D9B100F7_5507E6CB0165get_var*
begin
//#UC START# *5507D9B100F7_5507E6CB0165get_impl*
 Assert(ServerConfig <> nil);
 with ServerConfig do
 begin
  Section := 'Data';
  Result := ReadParamStrDef('Provider', '');
 end;
//#UC END# *5507D9B100F7_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_ProviderKey

procedure TncsClientParamsStorage.Set_ProviderKey(const aValue: AnsiString);
//#UC START# *5507D9B100F7_5507E6CB0165set_var*
//#UC END# *5507D9B100F7_5507E6CB0165set_var*
begin
//#UC START# *5507D9B100F7_5507E6CB0165set_impl*
 Assert(ServerConfig <> nil);
 ServerConfig.WriteParamStr('Provider', aValue);
//#UC END# *5507D9B100F7_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_ProviderKey

procedure TncsClientParamsStorage.InitStorage;
//#UC START# *55095596033F_5507E6CB0165_var*
//#UC END# *55095596033F_5507E6CB0165_var*
begin
//#UC START# *55095596033F_5507E6CB0165_impl*
 Assert((StationConfig <> nil) and (ServerConfig <> nil));

 ServerConfig.InitSubsts('FamilyConst');
//#UC END# *55095596033F_5507E6CB0165_impl*
end;//TncsClientParamsStorage.InitStorage

function TncsClientParamsStorage.Get_Login: AnsiString;
//#UC START# *550963930391_5507E6CB0165get_var*
//#UC END# *550963930391_5507E6CB0165get_var*
begin
//#UC START# *550963930391_5507E6CB0165get_impl*
 StationConfig.Section:='User';
 Result := StationConfig.ReadParamStrDef('UserName','');
//#UC END# *550963930391_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_Login

procedure TncsClientParamsStorage.Set_Login(const aValue: AnsiString);
//#UC START# *550963930391_5507E6CB0165set_var*
//#UC END# *550963930391_5507E6CB0165set_var*
begin
//#UC START# *550963930391_5507E6CB0165set_impl*
 StationConfig.Section:='User';
 StationConfig.WriteParamStr('UserName', aValue);
//#UC END# *550963930391_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_Login

function TncsClientParamsStorage.Get_Password: AnsiString;
//#UC START# *550963A60121_5507E6CB0165get_var*
//#UC END# *550963A60121_5507E6CB0165get_var*
begin
//#UC START# *550963A60121_5507E6CB0165get_impl*
 StationConfig.Section:='User';
 Result := l3Decrypt(l3DecodeBase64(StationConfig.ReadParamStrDef('UserPassword','')));
//#UC END# *550963A60121_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_Password

procedure TncsClientParamsStorage.Set_Password(const aValue: AnsiString);
//#UC START# *550963A60121_5507E6CB0165set_var*
//#UC END# *550963A60121_5507E6CB0165set_var*
begin
//#UC START# *550963A60121_5507E6CB0165set_impl*
// StationConfig.Section:='User';
// StationConfig.WriteParamStr('UserPassword',l3EncodeBase64(l3Encrypt(aValue)));
//#UC END# *550963A60121_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_Password

function TncsClientParamsStorage.Get_DocStoragePath: AnsiString;
//#UC START# *550963BC00B0_5507E6CB0165get_var*
//#UC END# *550963BC00B0_5507E6CB0165get_var*
begin
//#UC START# *550963BC00B0_5507E6CB0165get_impl*
 ServerConfig.Section:= FamilySection;
 Result := ServerConfig.ReadParamStrDef('FamilyPath', ''); // Invalid
//#UC END# *550963BC00B0_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_DocStoragePath

procedure TncsClientParamsStorage.Set_DocStoragePath(const aValue: AnsiString);
//#UC START# *550963BC00B0_5507E6CB0165set_var*
//#UC END# *550963BC00B0_5507E6CB0165set_var*
begin
//#UC START# *550963BC00B0_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= FamilySection;
  ServerConfig.WriteParamStr('FamilyPath', aValue);
 end; 
//#UC END# *550963BC00B0_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_DocStoragePath

function TncsClientParamsStorage.Get_DocImagePath: AnsiString;
//#UC START# *550963CF0092_5507E6CB0165get_var*
var
 l_Path: AnsiString;
//#UC END# *550963CF0092_5507E6CB0165get_var*
begin
//#UC START# *550963CF0092_5507E6CB0165get_impl*
 Result := '';
 ServerConfig.Section:= BaseSection;
 if ServerConfig.ReadParamString('ImageStoragePath', l_Path) then
 begin
  if not l3CheckPath(l_Path, True, False) then
   l_Path:= '';
  Result := NormalizedPath(l_Path);
 end;
//#UC END# *550963CF0092_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_DocImagePath

procedure TncsClientParamsStorage.Set_DocImagePath(const aValue: AnsiString);
//#UC START# *550963CF0092_5507E6CB0165set_var*
//#UC END# *550963CF0092_5507E6CB0165set_var*
begin
//#UC START# *550963CF0092_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= BaseSection;
  ServerConfig.WriteParamStr('ImageStoragePath', aValue);
 end;
//#UC END# *550963CF0092_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_DocImagePath

function TncsClientParamsStorage.Get_HomeDirPath: AnsiString;
//#UC START# *550963EB02F8_5507E6CB0165get_var*
var
 l_Path: AnsiString;
//#UC END# *550963EB02F8_5507E6CB0165get_var*
begin
//#UC START# *550963EB02F8_5507E6CB0165get_impl*
 Result := '';
 ServerConfig.Section:= BaseSection;
 if ServerConfig.ReadParamString('HomeDirPath', l_Path) then
 begin
  if not l3CheckPath(l_Path, False, True) then // Invalid
   l_Path := '';
  Result := NormalizedPath(l_Path);
 end;
//#UC END# *550963EB02F8_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_HomeDirPath

procedure TncsClientParamsStorage.Set_HomeDirPath(const aValue: AnsiString);
//#UC START# *550963EB02F8_5507E6CB0165set_var*
//#UC END# *550963EB02F8_5507E6CB0165set_var*
begin
//#UC START# *550963EB02F8_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= BaseSection;
  ServerConfig.WriteParamStr('HomeDirPath', aValue);
 end;
//#UC END# *550963EB02F8_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_HomeDirPath

function TncsClientParamsStorage.Get_StationName: AnsiString;
//#UC START# *550981E5026A_5507E6CB0165get_var*
//#UC END# *550981E5026A_5507E6CB0165get_var*
begin
//#UC START# *550981E5026A_5507E6CB0165get_impl*
 Result := StationConfig.ReadParamStrDef('StationName', ''); // Invalid
//#UC END# *550981E5026A_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_StationName

function TncsClientParamsStorage.Get_TablePath: AnsiString;
//#UC START# *550981FF0138_5507E6CB0165get_var*
var
 l_Path: AnsiString;
//#UC END# *550981FF0138_5507E6CB0165get_var*
begin
//#UC START# *550981FF0138_5507E6CB0165get_impl*
 Result := '';
 ServerConfig.Section:= BaseSection;
 If ServerConfig.ReadParamString('TablePath', l_Path) then
  if l3CheckPath(l_Path, False, False) then
   Result := NormalizedPath(l_Path); // Инвалид
//#UC END# *550981FF0138_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_TablePath

procedure TncsClientParamsStorage.Set_TablePath(const aValue: AnsiString);
//#UC START# *550981FF0138_5507E6CB0165set_var*
//#UC END# *550981FF0138_5507E6CB0165set_var*
begin
//#UC START# *550981FF0138_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= BaseSection;
  ServerConfig.WriteParamStr('TablePath', aValue);
 end;
//#UC END# *550981FF0138_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_TablePath

function TncsClientParamsStorage.Get_LockPath: AnsiString;
//#UC START# *550982210098_5507E6CB0165get_var*
var
 l_Path: AnsiString;
//#UC END# *550982210098_5507E6CB0165get_var*
begin
//#UC START# *550982210098_5507E6CB0165get_impl*
 Result := '';
 ServerConfig.Section:= BaseSection;
 If ServerConfig.ReadParamString('LockPath', l_Path) then
  if l3CheckPath(l_Path, False, False) then
   Result := NormalizedPath(l_Path); // Инвалид
//#UC END# *550982210098_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_LockPath

procedure TncsClientParamsStorage.Set_LockPath(const aValue: AnsiString);
//#UC START# *550982210098_5507E6CB0165set_var*
//#UC END# *550982210098_5507E6CB0165set_var*
begin
//#UC START# *550982210098_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= BaseSection;
  ServerConfig.WriteParamStr('LockPath', aValue);
 end;
//#UC END# *550982210098_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_LockPath

function TncsClientParamsStorage.Get_TempPath: AnsiString;
//#UC START# *550982360334_5507E6CB0165get_var*
var
 l_Path: AnsiString;
//#UC END# *550982360334_5507E6CB0165get_var*
begin
//#UC START# *550982360334_5507E6CB0165get_impl*
 Result := '';
 ServerConfig.Section:= BaseSection;
 If ServerConfig.ReadParamString('TmpDirPath',l_Path) then
  if l3CheckPath(l_Path, False, True) then
   Result := NormalizedPath(l_Path); // Инвалид
//#UC END# *550982360334_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_TempPath

procedure TncsClientParamsStorage.Set_TempPath(const aValue: AnsiString);
//#UC START# *550982360334_5507E6CB0165set_var*
//#UC END# *550982360334_5507E6CB0165set_var*
begin
//#UC START# *550982360334_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= BaseSection;
  ServerConfig.WriteParamStr('TmpDirPath', aValue);
 end;
//#UC END# *550982360334_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_TempPath

function TncsClientParamsStorage.StationErrorMessage: AnsiString;
//#UC START# *5512621F0352_5507E6CB0165_var*
//#UC END# *5512621F0352_5507E6CB0165_var*
begin
//#UC START# *5512621F0352_5507E6CB0165_impl*
 Result := Format('Не задно имя станции! Задайте параметр StationName в секции [%s] файла %s.', [BaseSection, StationConfig.GetCfgFile]);
//#UC END# *5512621F0352_5507E6CB0165_impl*
end;//TncsClientParamsStorage.StationErrorMessage

function TncsClientParamsStorage.TablePathErrorMessage: AnsiString;
//#UC START# *551262410001_5507E6CB0165_var*
//#UC END# *551262410001_5507E6CB0165_var*
begin
//#UC START# *551262410001_5507E6CB0165_impl*
 Result := Format('Не задан путь к базам! Задайте параметр TablePath в секции [%s] файла %s.', [BaseSection, StationConfig.GetCfgFile])
//#UC END# *551262410001_5507E6CB0165_impl*
end;//TncsClientParamsStorage.TablePathErrorMessage

function TncsClientParamsStorage.LockPathErrorMessage: AnsiString;
//#UC START# *551262530061_5507E6CB0165_var*
//#UC END# *551262530061_5507E6CB0165_var*
begin
//#UC START# *551262530061_5507E6CB0165_impl*
 Result := Format('Не задан путь к разделяемым ресурсам! Задайте параметр LockPath в секции [%s] файла %s.', [BaseSection, ServerConfig.GetCfgFile])
//#UC END# *551262530061_5507E6CB0165_impl*
end;//TncsClientParamsStorage.LockPathErrorMessage

function TncsClientParamsStorage.OuterConfigEdit: Boolean;
//#UC START# *5515121F0358_5507E6CB0165_var*
//#UC END# *5515121F0358_5507E6CB0165_var*
begin
//#UC START# *5515121F0358_5507E6CB0165_impl*
 Result := False;
//#UC END# *5515121F0358_5507E6CB0165_impl*
end;//TncsClientParamsStorage.OuterConfigEdit

procedure TncsClientParamsStorage.BuildConfig(aConfig: TddAppConfiguration;
 const aProviderKey: AnsiString);
//#UC START# *551512370064_5507E6CB0165_var*
//#UC END# *551512370064_5507E6CB0165_var*
begin
//#UC START# *551512370064_5507E6CB0165_impl*
 Assert(False);
//#UC END# *551512370064_5507E6CB0165_impl*
end;//TncsClientParamsStorage.BuildConfig

{$If Defined(UsePostgres)}
function TncsClientParamsStorage.Get_DataServerHostName: AnsiString;
//#UC START# *55DAD43B00AF_5507E6CB0165get_var*
//#UC END# *55DAD43B00AF_5507E6CB0165get_var*
begin
//#UC START# *55DAD43B00AF_5507E6CB0165get_impl*
 ServerConfig.Section:= DataSection;
 Result := ServerConfig.ReadParamStrDef('DataServerHostName', '');
//#UC END# *55DAD43B00AF_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_DataServerHostName
{$IfEnd} // Defined(UsePostgres)

{$If Defined(UsePostgres)}
procedure TncsClientParamsStorage.Set_DataServerHostName(const aValue: AnsiString);
//#UC START# *55DAD43B00AF_5507E6CB0165set_var*
//#UC END# *55DAD43B00AF_5507E6CB0165set_var*
begin
//#UC START# *55DAD43B00AF_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= DataSection;
  ServerConfig.WriteParamStr('DataServerHostName', aValue);
 end;
//#UC END# *55DAD43B00AF_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_DataServerHostName
{$IfEnd} // Defined(UsePostgres)

{$If Defined(UsePostgres)}
function TncsClientParamsStorage.Get_DataServerPort: Integer;
//#UC START# *55DAD44D036F_5507E6CB0165get_var*
//#UC END# *55DAD44D036F_5507E6CB0165get_var*
begin
//#UC START# *55DAD44D036F_5507E6CB0165get_impl*
 ServerConfig.Section:= DataSection;
 Result := ServerConfig.ReadParamIntDef('DataServerPort', c_DefaultPostgresPort);
//#UC END# *55DAD44D036F_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_DataServerPort
{$IfEnd} // Defined(UsePostgres)

{$If Defined(UsePostgres)}
procedure TncsClientParamsStorage.Set_DataServerPort(aValue: Integer);
//#UC START# *55DAD44D036F_5507E6CB0165set_var*
//#UC END# *55DAD44D036F_5507E6CB0165set_var*
begin
//#UC START# *55DAD44D036F_5507E6CB0165set_impl*
 if (StationConfig.CfgFileName = ServerConfig.CfgFileName) then
 begin
  ServerConfig.Section:= DataSection;
  ServerConfig.WriteParamInt('DataServerPort', aValue);
 end;
//#UC END# *55DAD44D036F_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_DataServerPort
{$IfEnd} // Defined(UsePostgres)

function TncsClientParamsStorage.Get_DocImageCachePath: AnsiString;
//#UC START# *5756BD40014A_5507E6CB0165get_var*
var
 l_Path: AnsiString;
//#UC END# *5756BD40014A_5507E6CB0165get_var*
begin
//#UC START# *5756BD40014A_5507E6CB0165get_impl*
 Result := '';
 ServerConfig.Section:= BaseSection;
 if ServerConfig.ReadParamString('ImageCachePath', l_Path) then
 begin
  if not l3CheckPath(l_Path, True, False) then
   l_Path:= '';
  Result := NormalizedPath(l_Path);
 end;
//#UC END# *5756BD40014A_5507E6CB0165get_impl*
end;//TncsClientParamsStorage.Get_DocImageCachePath

procedure TncsClientParamsStorage.Set_DocImageCachePath(const aValue: AnsiString);
//#UC START# *5756BD40014A_5507E6CB0165set_var*
//#UC END# *5756BD40014A_5507E6CB0165set_var*
begin
//#UC START# *5756BD40014A_5507E6CB0165set_impl*
 ServerConfig.Section:= BaseSection;
 ServerConfig.WriteParamStr('ImageCachePath', aValue);
//#UC END# *5756BD40014A_5507E6CB0165set_impl*
end;//TncsClientParamsStorage.Set_DocImageCachePath
{$IfEnd} // NOT Defined(Nemesis)

end.
