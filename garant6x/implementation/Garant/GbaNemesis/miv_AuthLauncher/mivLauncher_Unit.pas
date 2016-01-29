unit mivLauncher_Unit;

interface
uses
  MobileInternetVersionMenuForm_Unit,
  SysUtils,
  mivSettings;

type
  ELauncherError = class(Exception);

  EProtectionFailure = class(Exception);

  TmivConfigValidateResult = (cvrIniFileNotExists, cvrNotValidIniFile,
   cvrFlashValidationFailure, cvrOk);

  TmivLauncher = class(TObject)
  private
   f_LauncherMenuForm: TMobileInternetVersionMenuForm;
   f_ActualFlashID: String;
   function GetURLString(ACommand: TmivUserCommand): AnsiString;
   procedure ShowMenu;
   procedure ProcessUserCommand(ACommand: TmivUserCommand);
   procedure ErrorMessageBox(const AText: string);
   procedure NavigateURL(const anURL: String);
   procedure ShowValidationErrorMessage(aValidateResult: TmivConfigValidateResult);
   function ValidateConfig(ALoader: TmivSettingsLoader): TmivConfigValidateResult;
   function GetIniFileName: String;
   destructor Destroy; override;
  public
   class procedure Run;
  end;

implementation
uses
  Controls,
  Forms,
  Dialogs,
  Windows,
  ShellApi,
  l3Base,
  LocaleMessages,
  mivAuthSupport,
  mivUtils;

const
 // Заголовок формы меню
 C_MENU_FORM_CAPTION      = 'Мобильная интернет-версия системы ГАРАНТ';

{ TmivLauncher }

destructor TmivLauncher.Destroy;
begin
 FreeAndNil(f_LauncherMenuForm);
 inherited;
end;

procedure TmivLauncher.ErrorMessageBox(const AText: String);
begin
 MessageBox(Application.Handle, PChar(AText), PChar(Application.Title),
  MB_OK or MB_ICONERROR);
end;//TmivLauncher.ErrorMessageBox

function TmivLauncher.GetIniFileName: String;
begin
 Result := ChangeFileExt(Paramstr(0), '.ini');
end;//TmivLauncher.GetIniFileName

function TmivLauncher.GetURLString(ACommand: TmivUserCommand): AnsiString;
var
 l_OpenPart: String;
 l_ClosedPart: String;
 l_Drive: String;
begin
 case ACommand of
  mucStartWorkingWithInternetVersion:
   l_OpenPart := TmivSettings.Instance.FirstMenuItemURL;
  mucObtainRequisites:
   l_OpenPart := TmivSettings.Instance.SecondMenuItemURL;
  else
   Assert(False);
 end;//case ACommand
 with TmivSettings.Instance do
 begin
  Result := TmivAuthSupport.CreateURL(Login, l_OpenPart, Data,
   mivGetTime, f_ActualFlashID);
 end;//with TmivSettins
end;//TmivLauncher.GetURLString

procedure TmivLauncher.NavigateURL(const anURL: String);
var
 l_ShellExecuteInfo: TShellExecuteInfo;
begin
 l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
 with l_ShellExecuteInfo do
 begin
  cbSize := SizeOf(l_ShellExecuteInfo);
  lpVerb := 'open';
  lpFile := PChar(anURL);
  nShow := SW_SHOWNORMAL;
 end;//with l_ShellExecuteInfo
 ShellExecuteExA(@l_ShellExecuteInfo);
end;//TmivLauncher.NavigateURL

procedure TmivLauncher.ProcessUserCommand(ACommand: TmivUserCommand);
begin
 if ACommand in [mucStartWorkingWithInternetVersion, mucObtainRequisites] then
  NavigateURL(GetURLString(ACommand));
end;//TmivLauncher.ProcessUserCommand

class procedure TmivLauncher.Run;
var
 l_Launcher: TmivLauncher;
 l_SettingsLoader: TmivSettingsLoader;
 l_ValidateResult: TmivConfigValidateResult;
begin
 SetCurrentLocale('ru');
 l_Launcher := TmivLauncher.Create;
 l_SettingsLoader := TmivSettingsLoader.Create(l_Launcher.GetIniFileName);
 try
  l_ValidateResult := l_Launcher.ValidateConfig(l_SettingsLoader);
 finally
  FreeAndNil(l_SettingsLoader);
 end;//try..finally
 with l_Launcher do
 try
  if (l_ValidateResult <> cvrOk) then
   ShowValidationErrorMessage(l_ValidateResult)
  else
   ShowMenu;
 finally
  FreeAndNil(l_Launcher);
  Application.Terminate;
 end;//try..finally
end;//TmivLauncher.Run

procedure TmivLauncher.ShowMenu;
begin
 f_LauncherMenuForm := TMobileInternetVersionMenuForm.Create(Application);
 with f_LauncherMenuForm do
 begin
  Caption := C_MENU_FORM_CAPTION;
  OnCommand := ProcessUserCommand;
  ShowModal;
 end;//with f_LauncherMenuForm
end;//TmivLauncher.ShowMenu

procedure TmivLauncher.ShowValidationErrorMessage(
  aValidateResult: TmivConfigValidateResult);
const
 cValidationErrorCodes : array[Low(TmivConfigValidateResult)..High(TmivConfigValidateResult)] of Integer =
  (-1, -3, -2, 0);
var
 l_ErrCode: Integer;
 l_MsgText: String;
begin
 l_ErrCode := cValidationErrorCodes[aValidateResult];
 if (l_ErrCode <> 0) then
 begin
  l_MsgText := Format(GetCurrentLocaleMessage(c_ProtectionFailure), [l_ErrCode]);
  ErrorMessageBox(l_MsgText);
 end;
end;//TmivLauncher.ShowValidationErrorMessage

function TmivLauncher.ValidateConfig(ALoader: TmivSettingsLoader): TmivConfigValidateResult;
var
 l_ValidationResult: TmivSettingsIniValidationResult;
 l_ErrCode: Integer;
 l_IsValidIni: Boolean;
 l_IsValidFlash: Boolean;
begin
 Result := cvrOk;
 l_ValidationResult := ALoader.Validate;
 l_IsValidIni := (l_ValidationResult = ivrOk);
 if not l_IsValidIni then
 begin
  case l_ValidationResult of
   ivrNotExists:
    begin
     Result := cvrIniFileNotExists;
     Exit;
    end;
   ivrNotValidIniFile:
    begin
     Result := cvrNotValidIniFile;
     Exit;
    end;
  end;
 end;
 f_ActualFlashID := TmivAuthSupport.ValidateFlashEx(TmivSettings.Instance.Data, l_IsValidFlash);
 if not l_IsValidFlash then
  Result := cvrFlashValidationFailure;
end;//TmivLauncher.ValidateConfig

end.
