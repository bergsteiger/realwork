unit nsSplashVisualizer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Splash\nsSplashVisualizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSplashVisualizer" MUID: (499D5F560195)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , SplashInterfaces
 , Windows
 , Classes
 , l3Interfaces
;

type
 TnsSplashVisualizer = class(Tl3SimpleObject, InsSplashClient)
  private
   f_Process: THandle;
   f_MemFile: THandle;
   f_Guard: THandle;
   f_CanCloseEvent: THandle;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make(aPicture: TStream;
    aLogo: TStream;
    aMinShowTime: Cardinal;
    aWnd: THandle;
    const anAppTitle: AnsiString;
    const aUserInfo: Il3CString;
    const aWarning: Il3CString): InsSplashClient; reintroduce;
   constructor Create(aPicture: TStream;
    aLogo: TStream;
    aMinShowTime: Cardinal;
    aWnd: THandle;
    const anAppTitle: AnsiString;
    const aUserInfo: Il3CString;
    const aWarning: Il3CString); reintroduce;
 end;//TnsSplashVisualizer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , SysUtils
 , SplashTypes
 , l3Base
 , l3String
;

class function TnsSplashVisualizer.Make(aPicture: TStream;
 aLogo: TStream;
 aMinShowTime: Cardinal;
 aWnd: THandle;
 const anAppTitle: AnsiString;
 const aUserInfo: Il3CString;
 const aWarning: Il3CString): InsSplashClient;
var
 l_Inst : TnsSplashVisualizer;
begin
 l_Inst := Create(aPicture, aLogo, aMinShowTime, aWnd, anAppTitle, aUserInfo, aWarning);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsSplashVisualizer.Make

constructor TnsSplashVisualizer.Create(aPicture: TStream;
 aLogo: TStream;
 aMinShowTime: Cardinal;
 aWnd: THandle;
 const anAppTitle: AnsiString;
 const aUserInfo: Il3CString;
 const aWarning: Il3CString);
//#UC START# *499D5FDA0332_499D5F560195_var*
var
 l_MemSize: Cardinal;
 l_Name: String;
 l_StartupInfo: TStartupInfo;
 l_ProcessInfo: TProcessInformation;
 l_ProcID: Cardinal;
 l_Header: PnsSplashData;
 l_Data: Pointer;
 l_CurrentOffset: Cardinal;
 l_Warning: WideString;
 l_UserInfo: WideString;
const
 cSpashName = 'F1SplashScreen.run';
//#UC END# *499D5FDA0332_499D5F560195_var*
begin
//#UC START# *499D5FDA0332_499D5F560195_impl*
 inherited Create;
 f_Guard := CreateMutex(nil, True, cGuardName);
 f_CanCloseEvent := CreateEvent(nil, True, False, cFinishEventName);
 l_MemSize := SizeOf(l_Header^);
 l_Name := ExtractFilePath(ParamStr(0))+cSpashName;
 l_ProcID := 0;
 if FileExists(l_Name) then
 begin
  l3FillChar(l_StartupInfo, SizeOf(l_StartupInfo), 0);
  l_StartupInfo.cb := SizeOf(l_StartupInfo);
  l_StartupInfo.wShowWindow := SW_SHOW;
  l_StartupInfo.dwFlags := STARTF_USESTDHANDLES;
  if CreateProcess(PChar(l_Name), nil, nil, nil, False, NORMAL_PRIORITY_CLASS, nil, nil, l_StartupInfo, l_ProcessInfo) then
  begin
   f_Process := l_ProcessInfo.hProcess;
   CloseHandle(l_ProcessInfo.hThread);
   l_ProcID := l_ProcessInfo.dwProcessId;
  end;
 end;
 Inc(l_MemSIze, aPicture.Size);
 Inc(l_MemSIze, Length(anAppTitle) + 1);
 l_UserInfo := l3DStr(aUserInfo);
 Inc(l_MemSIze, Length(l_UserInfo)*2 + 2);
 l_Warning := l3DStr(aWarning);
 Inc(l_MemSIze, Length(l_Warning)*2 + 2);
 Inc(l_MemSIze, aLogo.Size);
 f_MemFile := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, l_MemSize, cMemFileName);
 l_Header := MapViewOfFile(f_MemFile, FILE_MAP_WRITE, 0, 0, l_MemSize);
 try
  l3FillChar(l_Header^, l_MemSize, 0);
  l_Header^.Version := cSplashVersion;
  l_Header^.ProcessID := l_ProcID;
  l_Header^.Size := l_MemSize;
  l_Header^.MinimalShowTime := aMinShowTime;
  l_Header^.ParentWnd := aWnd;
  // Пишем картинку
  l_CurrentOffset := SizeOf(l_Header^);
  l_Header^.SplashDataOffset := l_CurrentOffset;
  l_Header^.SplashDataSize := aPicture.Size;
  l_Data := Pointer(Cardinal(l_Header) + l_Header^.SplashDataOffset);
  aPicture.Position := 0;
  aPicture.ReadBuffer(l_Data^, aPicture.Size);
  // Пишем заголовок приложения
  inc(l_CurrentOffset, l_Header^.SplashDataSize);
  l_Header^.ApplicationTitleOffset := l_CurrentOffset;
  l_Header^.ApplicationTitleSize := Length(anAppTitle) + 1;
  l_Data := Pointer(Cardinal(l_Header) + l_Header^.ApplicationTitleOffset);
  l3Move(anAppTitle[1], l_Data^, Length(anAppTitle));
  // Пишем информацию о пользователе
  inc(l_CurrentOffset, l_Header^.ApplicationTitleSize);
  l_Header^.UserInfoOffset := l_CurrentOffset;
  l_Header^.UserInfoSize := Length(l_UserInfo)*2 + 2;
  l_Data := Pointer(Cardinal(l_Header) + l_Header^.UserInfoOffset);
  l3Move(l_UserInfo[1], l_Data^, Length(l_UserInfo)*2);
  // Пишем предупреждение
  inc(l_CurrentOffset, l_Header^.UserInfoSize);
  l_Header^.WarningOffset := l_CurrentOffset;
  l_Header^.WarningSize := Length(l_Warning)*2 + 2;
  l_Data := Pointer(Cardinal(l_Header) + l_Header^.WarningOffset);
  l3Move(l_Warning[1], l_Data^, Length(l_Warning)*2);
  // Пишем лого
  inc(l_CurrentOffset, l_Header^.WarningSize);
  l_Header^.LogoOffset := l_CurrentOffset;
  l_Header^.LogoSize := aLogo.Size;
  l_Data := Pointer(Cardinal(l_Header) + l_Header^.LogoOffset);
  aLogo.Position := 0;
  aLogo.ReadBuffer(l_Data^, aLogo.Size);
 finally
  UnmapViewOfFile(l_Header);
 end;
 ReleaseMutex(f_Guard);
//#UC END# *499D5FDA0332_499D5F560195_impl*
end;//TnsSplashVisualizer.Create

procedure TnsSplashVisualizer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_499D5F560195_var*
//#UC END# *479731C50290_499D5F560195_var*
begin
//#UC START# *479731C50290_499D5F560195_impl*
 if f_CanCloseEvent <> 0 then
  SetEvent(f_CanCloseEvent);
 if f_Process <> 0 then
  while WaitForSingleObject(f_Process, 100) <> WAIT_OBJECT_0 do
   afw.ProcessMessages;

 CloseHandle(f_Process);
 CloseHandle(f_MemFile);
 CloseHandle(f_Guard);
 CloseHandle(f_CanCloseEvent);

 f_Process := 0;
 f_MemFile := 0;
 f_Guard := 0;
 f_CanCloseEvent := 0;

 inherited Cleanup;
//#UC END# *479731C50290_499D5F560195_impl*
end;//TnsSplashVisualizer.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
