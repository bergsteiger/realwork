unit nsSplashInfo;
 {* Информация о том что показывать }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Splash\nsSplashInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSplashInfo" MUID: (499D24A503A6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , SplashServerInterfaces
 , SplashTypes
 , Windows
 , Classes
 , l3Interfaces
;

type
 TnsSplashInfo = class(Tl3SimpleObject, InsSplashInfo)
  {* Информация о том что показывать }
  private
   f_Header: PnsSplashData;
   f_Guard: THandle;
   f_CanCloseEvent: THandle;
   f_Valid: Boolean;
   f_MemFile: THandle;
   f_Waiter: Pointer;
    {* Сдабая ссылка на InsSplashWaiter }
   f_WaiterGuard: TRTLCriticalSection;
   f_Thread: TThread;
    {* Ждет сообщения от клиента }
   f_CanClose: Boolean;
  private
   function SplashDataPointer: Pointer;
    {* Указатель на данные SplashData в файле проецируемом в память }
   function UserInfoPointer: Pointer;
   function WarningPointer: Pointer;
   function ApplicationTitlePointer: Pointer;
   procedure SignalCanClose;
   function LogoPointer: Pointer;
  protected
   function Get_Waiter: InsSplashWaiter;
   procedure Set_Waiter(const aValue: InsSplashWaiter);
   procedure SwitchToParent;
    {* Переключиться на окно клиента (в конце показа) }
   function Get_IsValid: Boolean;
   function Get_MinimalShowTime: Cardinal;
   function Get_Warning: Il3CString;
   function Get_UserInfo: Il3CString;
   function Get_ApplicationTitle: PAnsiChar;
   function MakeSplashDataStream: IStream;
   function MakeLogoStream: IStream;
    {* Создает поток для вычитывания TvtPngImageList в котормо лежит лого }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: InsSplashInfo; reintroduce;
 end;//TnsSplashInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Memory
 , SysUtils
 , l3Base
 , l3String
;

type
 TnsWaitThread = class(TThread)
  private
   f_Info: TnsSplashInfo;
  private
   procedure DoDone; virtual;
  protected
   procedure Execute; override;
  public
   constructor Create(aInfo: TnsSplashInfo); reintroduce;
 end;//TnsWaitThread

constructor TnsWaitThread.Create(aInfo: TnsSplashInfo);
//#UC START# *499D3BA602BC_499D3B52019D_var*
//#UC END# *499D3BA602BC_499D3B52019D_var*
begin
//#UC START# *499D3BA602BC_499D3B52019D_impl*
 Assert(Assigned(aInfo));
 inherited Create(True);
 f_Info := aInfo;
//#UC END# *499D3BA602BC_499D3B52019D_impl*
end;//TnsWaitThread.Create

procedure TnsWaitThread.DoDone;
//#UC START# *499D3C000104_499D3B52019D_var*
//#UC END# *499D3C000104_499D3B52019D_var*
begin
//#UC START# *499D3C000104_499D3B52019D_impl*
 f_Info.SignalCanClose;
//#UC END# *499D3C000104_499D3B52019D_impl*
end;//TnsWaitThread.DoDone

procedure TnsWaitThread.Execute;
//#UC START# *499D3BE0004D_499D3B52019D_var*
//#UC END# *499D3BE0004D_499D3B52019D_var*
begin
//#UC START# *499D3BE0004D_499D3B52019D_impl*
 WaitForSingleObject(f_Info.f_CanCloseEvent, INFINITE);
 Synchronize(DoDone);
//#UC END# *499D3BE0004D_499D3B52019D_impl*
end;//TnsWaitThread.Execute

constructor TnsSplashInfo.Create;
//#UC START# *499D25B501C4_499D24A503A6_var*
var
 l_Size: Cardinal;
//#UC END# *499D25B501C4_499D24A503A6_var*
begin
//#UC START# *499D25B501C4_499D24A503A6_impl*
 inherited Create;
 InitializeCriticalSection(f_WaiterGuard);
 f_Valid := False;
 f_Guard := OpenMutex(MUTEX_MODIFY_STATE or SYNCHRONIZE, true, cGuardName);
 if (f_Guard = 0) then
  Exit;
 f_CanCloseEvent := OpenEvent(SYNCHRONIZE, True, cFinishEventName);
 if (f_CanCloseEvent = 0) then
  Exit;
 WaitForSingleObject(f_Guard, Infinite);
 try
  f_MemFile := OpenFileMapping(FILE_MAP_READ, true, cMemFileName);
  f_Header := MapViewOfFile(f_MemFile, FILE_MAP_READ, 0, 0, SizeOf(f_Header^));
  try
   if f_Header^.Version <> cSplashVersion then
    exit;
   if f_Header^.ProcessID <> GetCurrentProcessID then
    exit;
   l_Size := f_Header^.Size;
   f_Thread := TnsWaitThread.Create(Self);
  finally
   UnmapViewOfFile(f_Header);
  end;
  f_Header := MapViewOfFile(f_MemFile, FILE_MAP_READ, 0, 0, l_Size);
  f_Valid := True;
  f_Thread.Resume;
 finally
  if not f_Valid then
  begin
   if Assigned(f_Header) then
    UnmapViewOfFile(f_Header);
   ReleaseMutex(f_Guard);
  end;
 end;
//#UC END# *499D25B501C4_499D24A503A6_impl*
end;//TnsSplashInfo.Create

class function TnsSplashInfo.Make: InsSplashInfo;
var
 l_Inst : TnsSplashInfo;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsSplashInfo.Make

function TnsSplashInfo.SplashDataPointer: Pointer;
 {* Указатель на данные SplashData в файле проецируемом в память }
//#UC START# *499D3344000F_499D24A503A6_var*
//#UC END# *499D3344000F_499D24A503A6_var*
begin
//#UC START# *499D3344000F_499D24A503A6_impl*
 if Get_IsValid then
  Result := Pointer(Cardinal(f_Header) + f_Header^.SplashDataOffset)
 else
  Result := nil;
//#UC END# *499D3344000F_499D24A503A6_impl*
end;//TnsSplashInfo.SplashDataPointer

function TnsSplashInfo.UserInfoPointer: Pointer;
//#UC START# *499D37120197_499D24A503A6_var*
//#UC END# *499D37120197_499D24A503A6_var*
begin
//#UC START# *499D37120197_499D24A503A6_impl*
 if Get_IsValid then
  Result := Pointer(Cardinal(f_Header) + f_Header^.UserInfoOffset)
 else
  Result := nil;
//#UC END# *499D37120197_499D24A503A6_impl*
end;//TnsSplashInfo.UserInfoPointer

function TnsSplashInfo.WarningPointer: Pointer;
//#UC START# *499D372A02A8_499D24A503A6_var*
//#UC END# *499D372A02A8_499D24A503A6_var*
begin
//#UC START# *499D372A02A8_499D24A503A6_impl*
 if Get_IsValid then
  Result := Pointer(Cardinal(f_Header) + f_Header^.WarningOffset)
 else
  Result := nil;
//#UC END# *499D372A02A8_499D24A503A6_impl*
end;//TnsSplashInfo.WarningPointer

function TnsSplashInfo.ApplicationTitlePointer: Pointer;
//#UC START# *499D374D0203_499D24A503A6_var*
//#UC END# *499D374D0203_499D24A503A6_var*
begin
//#UC START# *499D374D0203_499D24A503A6_impl*
 if Get_IsValid then
  Result := Pointer(Cardinal(f_Header) + f_Header^.ApplicationTitleOffset)
 else
  Result := nil;
//#UC END# *499D374D0203_499D24A503A6_impl*
end;//TnsSplashInfo.ApplicationTitlePointer

procedure TnsSplashInfo.SignalCanClose;
//#UC START# *499D40ED018C_499D24A503A6_var*
//#UC END# *499D40ED018C_499D24A503A6_var*
begin
//#UC START# *499D40ED018C_499D24A503A6_impl*
 f_CanClose := True;
 EnterCriticalSection(f_WaiterGuard);
 try
  if Get_Waiter <> nil then
   Get_Waiter.CanCloseSplash;
 finally
  LeaveCriticalSection(f_WaiterGuard);
 end;
//#UC END# *499D40ED018C_499D24A503A6_impl*
end;//TnsSplashInfo.SignalCanClose

function TnsSplashInfo.LogoPointer: Pointer;
//#UC START# *499E5F9102A0_499D24A503A6_var*
//#UC END# *499E5F9102A0_499D24A503A6_var*
begin
//#UC START# *499E5F9102A0_499D24A503A6_impl*
 if Get_IsValid then
  Result := Pointer(Cardinal(f_Header) + f_Header^.LogoOffset)
 else
  Result := nil;
//#UC END# *499E5F9102A0_499D24A503A6_impl*
end;//TnsSplashInfo.LogoPointer

function TnsSplashInfo.Get_Waiter: InsSplashWaiter;
//#UC START# *499D074100CF_499D24A503A6get_var*
//#UC END# *499D074100CF_499D24A503A6get_var*
begin
//#UC START# *499D074100CF_499D24A503A6get_impl*
 Result := InsSplashWaiter(f_Waiter);
//#UC END# *499D074100CF_499D24A503A6get_impl*
end;//TnsSplashInfo.Get_Waiter

procedure TnsSplashInfo.Set_Waiter(const aValue: InsSplashWaiter);
//#UC START# *499D074100CF_499D24A503A6set_var*
//#UC END# *499D074100CF_499D24A503A6set_var*
begin
//#UC START# *499D074100CF_499D24A503A6set_impl*
 EnterCriticalSection(f_WaiterGuard);
 try
  f_Waiter := Pointer(aValue);
  if Assigned(aValue) and f_CanClose then
   aValue.CanCloseSplash;
 finally
  LeaveCriticalSection(f_WaiterGuard);
 end;
//#UC END# *499D074100CF_499D24A503A6set_impl*
end;//TnsSplashInfo.Set_Waiter

procedure TnsSplashInfo.SwitchToParent;
 {* Переключиться на окно клиента (в конце показа) }
//#UC START# *499D076503E0_499D24A503A6_var*
//#UC END# *499D076503E0_499D24A503A6_var*
begin
//#UC START# *499D076503E0_499D24A503A6_impl*
 if Get_IsValid and (f_Header^.ParentWnd <> 0) then
 begin
  if (GetWindowThreadProcessId(GetForegroundWindow, nil) = GetCurrentThreadID) then
   SetForegroundWindow(f_Header^.ParentWnd);
 end;
//#UC END# *499D076503E0_499D24A503A6_impl*
end;//TnsSplashInfo.SwitchToParent

function TnsSplashInfo.Get_IsValid: Boolean;
//#UC START# *499D121F01A1_499D24A503A6get_var*
//#UC END# *499D121F01A1_499D24A503A6get_var*
begin
//#UC START# *499D121F01A1_499D24A503A6get_impl*
 Result := f_Valid;
//#UC END# *499D121F01A1_499D24A503A6get_impl*
end;//TnsSplashInfo.Get_IsValid

function TnsSplashInfo.Get_MinimalShowTime: Cardinal;
//#UC START# *499D12390040_499D24A503A6get_var*
//#UC END# *499D12390040_499D24A503A6get_var*
begin
//#UC START# *499D12390040_499D24A503A6get_impl*
 if Get_IsValid then
  Result := f_Header^.MinimalShowTime
 else
  Result := 0;
//#UC END# *499D12390040_499D24A503A6get_impl*
end;//TnsSplashInfo.Get_MinimalShowTime

function TnsSplashInfo.Get_Warning: Il3CString;
//#UC START# *499D12670256_499D24A503A6get_var*
//#UC END# *499D12670256_499D24A503A6get_var*
begin
//#UC START# *499D12670256_499D24A503A6get_impl*
 if Get_IsValid then
  Result := l3CStr(l3PCharLen(PAnsiChar(WarningPointer), (f_Header^.WarningSize - 2) div 2, CP_Unicode))
 else
  Result := nil;
//#UC END# *499D12670256_499D24A503A6get_impl*
end;//TnsSplashInfo.Get_Warning

function TnsSplashInfo.Get_UserInfo: Il3CString;
//#UC START# *499D128B028A_499D24A503A6get_var*
//#UC END# *499D128B028A_499D24A503A6get_var*
begin
//#UC START# *499D128B028A_499D24A503A6get_impl*
 if Get_IsValid then
  Result := l3CStr(l3PCharLen(PAnsiChar(UserInfoPointer), (f_Header^.UserInfoSize - 2) div 2, CP_Unicode))
 else
  Result := nil;
//#UC END# *499D128B028A_499D24A503A6get_impl*
end;//TnsSplashInfo.Get_UserInfo

function TnsSplashInfo.Get_ApplicationTitle: PAnsiChar;
//#UC START# *499D1298014D_499D24A503A6get_var*
//#UC END# *499D1298014D_499D24A503A6get_var*
begin
//#UC START# *499D1298014D_499D24A503A6get_impl*
 Result := PAnsiChar(ApplicationTitlePointer);
//#UC END# *499D1298014D_499D24A503A6get_impl*
end;//TnsSplashInfo.Get_ApplicationTitle

function TnsSplashInfo.MakeSplashDataStream: IStream;
//#UC START# *499D3E8A0270_499D24A503A6_var*
var
 l_Instance: Tl3ConstMemoryStream;
//#UC END# *499D3E8A0270_499D24A503A6_var*
begin
//#UC START# *499D3E8A0270_499D24A503A6_impl*
 if Get_IsValid then
 begin
  l_Instance := Tl3ConstMemoryStream.Create(SplashDataPointer, f_Header^.SplashDataSize);
  try
   Result := l_Instance
  finally
   FreeAndNil(l_Instance);
  end;
 end
 else
  Result := nil;
//#UC END# *499D3E8A0270_499D24A503A6_impl*
end;//TnsSplashInfo.MakeSplashDataStream

function TnsSplashInfo.MakeLogoStream: IStream;
 {* Создает поток для вычитывания TvtPngImageList в котормо лежит лого }
//#UC START# *499E5EA40035_499D24A503A6_var*
var
 l_Instance: Tl3ConstMemoryStream;
//#UC END# *499E5EA40035_499D24A503A6_var*
begin
//#UC START# *499E5EA40035_499D24A503A6_impl*
 if Get_IsValid then
 begin
  l_Instance := Tl3ConstMemoryStream.Create(LogoPointer, f_Header^.LogoSize);
  try
   Result := l_Instance
  finally
   FreeAndNil(l_Instance);
  end;
 end
 else
  Result := nil;
//#UC END# *499E5EA40035_499D24A503A6_impl*
end;//TnsSplashInfo.MakeLogoStream

procedure TnsSplashInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_499D24A503A6_var*
//#UC END# *479731C50290_499D24A503A6_var*
begin
//#UC START# *479731C50290_499D24A503A6_impl*
 f_Thread.WaitFor;
 FreeAndNil(f_Thread);
 Set_Waiter(nil);
 if f_Valid then
  ReleaseMutex(f_Guard);
 f_Valid := False;
 if f_Header <> nil then
  UnmapViewOfFile(f_Header);
 f_Header := nil;
 CloseHandle(f_Guard);
 CloseHandle(f_CanCloseEvent);
 CloseHandle(f_MemFile);
 DeleteCriticalSection(f_WaiterGuard);
 inherited Cleanup;
//#UC END# *479731C50290_499D24A503A6_impl*
end;//TnsSplashInfo.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
