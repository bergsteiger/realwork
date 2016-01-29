unit mivLauncher_Unit;

interface
uses
  MobileInternetVersionMenuForm_Unit,
  SysUtils;

type
  ELauncherError = class(Exception);

  TmivLauncher = class(TObject)
  private
   f_LauncherMenuForm: TMobileInternetVersionMenuForm;
   function MakeCommandString: String;
   function NeedShowMenu: Boolean;
   procedure ShowMenu;
   procedure ProcessUserCommand(ACommand: TmivUserCommand);
   procedure ExecuteShell(const ACommandLine: String);
   procedure RunProcess(const AApplication: string; const ACommandLine: string; const ACurrentDirectory: string);
   procedure ErrorMessageBox(const AText: string);
  public
   class procedure Run;
   destructor Destroy; override;
  end;

implementation
uses
  Controls,
  Forms,
  Dialogs,
  Windows,
  ShellApi,
  l3Base,
  LocaleMessages;

const
 C_APPLICATION_FILENAME   = 'garant.run';

 C_OPEN_BY_NUMBER         = '-OpenByNumber %s';
 C_SILENT_RUN_AND_EXIT    = '-SilentRunAndExit';

 // Топик для "Начать работу с Интернет-версией"
 C_INTERNET_VERSION_TOPIC = '890941.100011';
 // Топик для "Сгенерировать реквизиты для доступа"
 C_REQUISITES_TOPIC       = '890941.100012';
 // Топик для перехода на конструкторы договоров
 C_CONTRACT_CONSTRUCTOR_TOPIC = '890941.100013';

 // Заголовок формы меню
 C_MENU_FORM_CAPTION      = 'Мобильная интернет-версия системы ГАРАНТ';

{ TmivLauncher }

destructor TmivLauncher.Destroy;
begin
  FreeAndNil(f_LauncherMenuForm);
  inherited;
end;

procedure TmivLauncher.ErrorMessageBox(const AText: string);
begin
 MessageBox(Application.Handle, PChar(AText), PChar(Application.Title),
  MB_OK or MB_ICONERROR);
end;//TmivLauncher.ErrorMessageBox

procedure TmivLauncher.ExecuteShell(const ACommandLine: String);
begin
 try
  RunProcess(C_APPLICATION_FILENAME, ACommandLine, GetCurrentDir)
 except
  on E: ELauncherError do
  begin
   ErrorMessageBox(Format(GetCurrentLocaleMessage(c_CommonUnexpectedException), [E.Message]));
   f_LauncherMenuForm.ModalResult := mrOK;
  end;
 end;//try..except
end;//TmivLauncher.ExecuteShell

function TmivLauncher.MakeCommandString: String;

 function lp_QuoteString(const AString: string): string;
 begin
   Result := Format('"%s"', [AString]);
 end;//lp_QuoteStringIfNeeded

 function lp_AddParamStrToCommandString(const ACommandString: String;
  const AParamStr: String): String;
 begin
  Result := Format('%s %s', [ACommandString, lp_QuoteString(AParamStr)]);
 end;//lp_AddParamStrToCommandString

var
 l_Index: Integer;
begin
 Result := EmptyStr;
 for l_Index := 1 to ParamCount do
  Result := lp_AddParamStrToCommandString(Result, ParamStr(l_Index));
end;//TmivLauncher.MakeCommandString

function TmivLauncher.NeedShowMenu: Boolean;
begin
 Result := ParamCount = 0;
end;//TmivLauncher.NeedShowMenu

procedure TmivLauncher.ProcessUserCommand(ACommand: TmivUserCommand);

 function lp_MakeOpenByNumberString(const ATopicStr: String): String;
 begin
  Result := Format(C_OPEN_BY_NUMBER, [ATopicStr]) + ' ' + C_SILENT_RUN_AND_EXIT;
 end;//lp_MakeOpenByNumberString

var
 l_CommandStr: String;
 l_NeedRun: Boolean;
begin
 l_NeedRun := True;
 case ACommand of
  mucStartWorkingWithInternetVersion:
   l_CommandStr := lp_MakeOpenByNumberString(C_INTERNET_VERSION_TOPIC);
  mucObtainRequisites:
   l_CommandStr := lp_MakeOpenByNumberString(C_REQUISITES_TOPIC);
  mucWorkLocal:
   l_CommandStr := '';
  mucRunContractConstructor:
   l_CommandStr := lp_MakeOpenByNumberString(C_CONTRACT_CONSTRUCTOR_TOPIC);
  mucCancel:
    l_NeedRun := False;
 end;//case ACommand
 if l_NeedRun then
  ExecuteShell(l_CommandStr);
end;//TmivLauncher.ProcessUserCommand

class procedure TmivLauncher.Run;
var
 l_Launcher: TmivLauncher;
begin
 SetCurrentLocale('ru');
 l_Launcher := TmivLauncher.Create;
 with l_Launcher do
 try
  if NeedShowMenu then
   ShowMenu
  else
   ExecuteShell(MakeCommandString);
 finally
  FreeAndNil(l_Launcher);
  Application.Terminate;
 end;//try..finally
end;//TmivLauncher.Run

procedure TmivLauncher.RunProcess(const AApplication: String;
 const ACommandLine: String; const ACurrentDirectory: string);

 function lp_GetCreationFlags: DWORD;
 begin
  Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
 end;//lp_GetCreationFlags

 function lp_QuoteStringIfNeed(const AString: string): string;
 begin
  if ((Pos(' ', AString) <> 0) or (Pos('''', AString) <> 0)) then
   Result := Format('"%s"', [AString])
  else
   Result := AString;
 end;//lp_QuoteStringIfNeeded

var
 l_ShellExecuteInfo: TShellExecuteInfo;
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
 l_Application: String;
 l_CommandLine: String;
 l_RunSuccess: BOOL;
 l_StructSize: Integer;
begin
 l_Application := Format('%s\%s', [ACurrentDirectory, AApplication]);
 if (FileExists(l_Application)) then
 begin
  l_CommandLine := lp_QuoteStringIfNeed(l_Application);

  if (ACommandLine <> '') then
   l_CommandLine := Format('%s %s', [l_CommandLine, ACommandLine]);

  l3FillChar(l_ProcessInformation, SizeOf(l_ProcessInformation), 0);

  l3FillChar(l_StartupInfo, SizeOf(l_StartupInfo), 0);
  with l_StartupInfo do
  begin
   cb := DWORD(SizeOf(l_StartupInfo));
   dwFlags := STARTF_USESTDHANDLES;
  end;//with l_StartupInfo

  l_RunSuccess := CreateProcess(nil, PChar(l_CommandLine), nil, nil, False,
   lp_GetCreationFlags, nil, PChar(ACurrentDirectory), l_StartupInfo, l_ProcessInformation);

  if l_RunSuccess then
  begin
   with l_ProcessInformation do
   begin
    CloseHandle(hThread);
    Application.Terminate;
   end;//with l_ProcessInformation
  end
  else//if l_RunSuccess
  begin
   l_StructSize := SizeOf(l_ShellExecuteInfo);
   l3FillChar(l_ShellExecuteInfo, l_StructSize, 0);
   with l_ShellExecuteInfo do
   begin
    cbSize := DWORD(l_StructSize);
    fMask := SEE_MASK_CLASSNAME or SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI
     or SEE_MASK_NOCLOSEPROCESS;
    lpVerb := 'runas';
    lpFile := PChar(AApplication);
    lpParameters := PChar(ACommandLine);
    nShow := SW_SHOWDEFAULT;
    lpClass := 'exefile';
   end;//with l_ShellExecuteInfo
   l_RunSuccess := ShellExecuteEx(@l_ShellExecuteInfo);

   if l_RunSuccess then
    Application.Terminate
   else
    raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonUnableStartProcess), [l_Application]));
  end;//if l_RunSuccess
 end
 else//if (FileExists(l_Application)
  raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonFileNotFound), [l_Application]));
end;//TmivLauncher.RunProcess

procedure TmivLauncher.ShowMenu;
begin
 f_LauncherMenuForm := TMobileInternetVersionMenuForm.Create(Application);
 with f_LauncherMenuForm do
 begin
  Caption := C_MENU_FORM_CAPTION;
  OnCommand := ProcessUserCommand;
  ShowModal;
 end;
end;//TmivLauncher.ShowMenu

end.
