unit mivSettings;

interface
uses
  IniFiles;

type
 TmivSettings = class(TObject)
 private
  f_Login: AnsiString;
  f_Data: AnsiString;
  f_FirstMenuItemURL: String;
  f_SecondMenuItemURL: String;
  procedure pm_SetData(const Value: AnsiString);
  procedure pm_SetFirstMenuItemURL(const Value: String);
  procedure pm_SetLogin(const Value: AnsiString);
  procedure pm_SetSecondMenuItemURL(const Value: String);
  function pm_GetIsValid: Boolean;
 public
  class function Instance: TmivSettings;
  property Login: AnsiString
   read f_Login
   write pm_SetLogin;
  property Data: AnsiString
   read f_Data
   write pm_SetData;
  property FirstMenuItemURL: String
   read f_FirstMenuItemURL
   write pm_SetFirstMenuItemURL;
  property SecondMenuItemURL: String
   read f_SecondMenuItemURL
   write pm_SetSecondMenuItemURL;
  property IsValid: Boolean
   read pm_GetIsValid;
 end;

 TmivSettingsIniValidationResult = (ivrNotExists, ivrNotValidIniFile, ivrOk);

 TmivSettingsLoader = class(TObject)
 private
  f_IniFileName: AnsiString;
  f_IniFile: TIniFile;
  function pm_GetIniFile: TIniFile;
  procedure LoadSettings;
 protected
  property IniFile: TIniFile
   read pm_GetIniFile;
 public
  function Validate: TmivSettingsIniValidationResult;
  constructor Create(const AIniFileName: AnsiString);
  destructor Destroy; override;
 public
  property IniFileName: AnsiString
   read f_IniFileName;
 end;

implementation
uses
 SysUtils;

const
 cGarantSectionName = 'garant';
 cLoginParamName    = 'login';
 cDataParamName     = 'data';

 cMenuSectionName            = 'menu';
 cFirstMenuItemURLParamName  = '1';
 cSecondMenuItemURLParamName = '2';

{ TmivSettings }

var
 g_mivSettingsInstance : TmivSettings = nil;

procedure TmivSettings_Delete;
begin
 if (g_mivSettingsInstance <> nil) then
  FreeAndNil(g_mivSettingsInstance);
end;//TmivSettings_Delete

class function TmivSettings.Instance: TmivSettings;
begin
 if (g_mivSettingsInstance = nil) then
 begin
  g_mivSettingsInstance := Create;
  AddExitProc(TmivSettings_Delete);
 end;
 Result := g_mivSettingsInstance;
end;//TmivSettings.Instance

function TmivSettings.pm_GetIsValid: Boolean;
begin
 Result := (f_FirstMenuItemURL <> EmptyStr) and (f_SecondMenuItemURL <> EmptyStr);
end;//TmivSettings.pm_GetIsValid

procedure TmivSettings.pm_SetData(const Value: AnsiString);
begin
 if (Value <> f_Data) then
  f_Data := Value;
end;//TmivSettings.pm_SetData

procedure TmivSettings.pm_SetFirstMenuItemURL(const Value: String);
begin
 if (Value <> f_FirstMenuItemURL) then
  f_FirstMenuItemURL := Value;
end;//TmivSettings.pm_SetFirstMenuItemURL

procedure TmivSettings.pm_SetLogin(const Value: AnsiString);
begin
 if (Value <> f_Login) then
  f_Login := Value;
end;//TmivSettings.pm_SetLogin

procedure TmivSettings.pm_SetSecondMenuItemURL(const Value: String);
begin
 if (Value <> f_SecondMenuItemURL) then
  f_SecondMenuItemURL := Value;
end;//TmivSettings.pm_SetSecondMenuItemURL

{ TmivSettingsLoader }

constructor TmivSettingsLoader.Create(const AIniFileName: AnsiString);
begin
 inherited Create;
 f_IniFileName := AIniFileName;
end;//TmivSettingsLoader.Create

destructor TmivSettingsLoader.Destroy;
begin
 FreeAndNil(f_IniFile);
 inherited;
end;//TmivSettingsLoader.Destroy

procedure TmivSettingsLoader.LoadSettings;
begin
 with TmivSettings.Instance do
 begin
  Login := IniFile.ReadString(cGarantSectionName, cLoginParamName, EmptyStr);
  Data := IniFile.ReadString(cGarantSectionName, cDataParamName, EmptyStr);
  FirstMenuItemURL := IniFile.ReadString(cMenuSectionName,
   cFirstMenuItemURLParamName, EmptyStr);
  SecondMenuItemURL := IniFile.ReadString(cMenuSectionName,
   cSecondMenuItemURLParamName, EmptyStr);
 end;//with TmivSettings.Instance
end;//TmivSettingsLoader.LoadSettings

function TmivSettingsLoader.pm_GetIniFile: TIniFile;
begin
 if (f_IniFile = nil) and (FileExists(f_IniFileName)) then
  f_IniFile := TIniFile.Create(f_IniFileName);
 Result := f_IniFile;
end;//TmivSettingsLoader.pm_GetIniFile

function TmivSettingsLoader.Validate: TmivSettingsIniValidationResult;

 function lp_ValidateSections: Boolean;
 begin
  Result := IniFile.SectionExists(cGarantSectionName) and
   IniFile.SectionExists(cMenuSectionName);
 end;//lp_ValidateSections

 function lp_ValidateKeys: Boolean;
 begin
  Result := IniFile.ValueExists(cGarantSectionname, cDataParamName) and
   IniFile.ValueExists(cMenuSectionName, cFirstMenuItemURLParamName) and
   IniFile.ValueExists(cMenuSectionName, cSecondMenuItemURLParamName) and
   IniFile.ValueExists(cGarantSectionName, cLoginParamName);
 end;//lp_ValidateKeys

begin
 Result := ivrOk;
 if not FileExists(f_IniFileName) then
 begin
  Result := ivrNotExists;
  Exit;
 end;//if not FileExists(f_IniFileName)
 if not (lp_ValidateSections and lp_ValidateKeys) then
 begin
  Result := ivrNotValidIniFile;
  Exit;
 end;//if not (lp_ValidateSections and lp_ValidateKeys)
 LoadSettings;
 if not TmivSettings.Instance.IsValid then
  Result := ivrNotValidIniFile;
end;//TmivSettingsLoader.Validate

end.
