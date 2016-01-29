{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       COM server support                              }
{*******************************************************}

unit System.Win.ComServ;

{$DENYPACKAGEUNIT}

{ Make sure C++ explicitly pull in ComServ.obj}
(*$HPPEMIT '#include <cstdlib>'*)
(*$HPPEMIT END 'namespace System {'*)
(*$HPPEMIT END 'namespace Win {'*)
(*$HPPEMIT END 'namespace Comserv {'*)
(*$HPPEMIT END '    // ------------------------------------------------------------------------- '*)
(*$HPPEMIT END '    // TCppActiveXModule '*)
(*$HPPEMIT END '    // ------------------------------------------------------------------------- '*)
(*$HPPEMIT END '     '*)
(*$HPPEMIT END '    template <typename T> '*)
(*$HPPEMIT END '    void __fastcall Comserv_TermProc() '*)
(*$HPPEMIT END '    { '*)
(*$HPPEMIT END '      std::exit(EXIT_SUCCESS); '*)
(*$HPPEMIT END '    } '*)
(*$HPPEMIT END '     '*)
(*$HPPEMIT END '    class TCppActiveXModule  '*)
(*$HPPEMIT END '    { '*)
(*$HPPEMIT END '    public: '*)
(*$HPPEMIT END '      TCppActiveXModule(bool isLocal) '*)
(*$HPPEMIT END '      { '*)
(*$HPPEMIT END '        if (isLocal) '*)
(*$HPPEMIT END '          Comserv::GetComServer()->TermProc = Comserv_TermProc<TCppActiveXModule>; '*)
(*$HPPEMIT END '      } '*)
(*$HPPEMIT END '     ~TCppActiveXModule() '*)
(*$HPPEMIT END '      { '*)
(*$HPPEMIT END '      } '*)
(*$HPPEMIT END '    }; '*)
(*$HPPEMIT END '} /* namespace Comserv */ ; '*)
(*$HPPEMIT END '} /* namespace Win */ ; '*)
(*$HPPEMIT END '} /* namespace System */ ; '*)


interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ActiveX, System.SysUtils, System.Win.ComObj;

type

{ Application start mode }

  TStartMode = (smStandalone, smAutomation, smRegServer, smUnregServer);

{ Class manager event types }

  TLastReleaseEvent = procedure(var Shutdown: Boolean) of object;

{ TComServer }

  TComServer = class(TComServerObject)
  private
    FObjectCount: Integer;
    FFactoryCount: Integer;
    FTypeLib: ITypeLib;
    FServerName: string;
    FHelpFileName: string;
    FIsInprocServer: Boolean;
    FStartMode: TStartMode;
    FStartSuspended: Boolean;
    FRegister: Boolean;
    FUIInteractive: Boolean;
    FOnLastRelease: TLastReleaseEvent;
    FTermProc: TProcedure;
    procedure FactoryFree(Factory: TComObjectFactory);
    procedure FactoryRegisterClassObject(Factory: TComObjectFactory);
    procedure FactoryUpdateRegistry(Factory: TComObjectFactory);
    procedure LastReleased;
  protected
    function CountObject(Created: Boolean): Integer; override;
    function CountFactory(Created: Boolean): Integer; override;
    function GetHelpFileName: string; override;
    function GetServerFileName: string; override;
    function GetServerKey: string; override;
    function GetServerName: string; override;
    function GetStartSuspended: Boolean; override;
    function GetTypeLib: ITypeLib; override;
    procedure SetHelpFileName(const Value: string); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Initialize;
    procedure LoadTypeLib;
    procedure SetServerName(const Name: string);
    procedure UpdateRegistry(Register: Boolean);
    property IsInprocServer: Boolean read FIsInprocServer write FIsInprocServer;
    property ObjectCount: Integer read FObjectCount;
    property FactoryCount: Integer read FFactoryCount;
    property StartMode: TStartMode read FStartMode;
    property UIInteractive: Boolean read FUIInteractive write FUIInteractive;
    property OnLastRelease: TLastReleaseEvent read FOnLastRelease write FOnLastRelease;
    property TermProc: TProcedure read FTermProc write FTermProc;
  end;

var
  ComServer: TComServer;

function GetComServer: TComServer;

function DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult; stdcall;
{$NODEFINE DllGetClassObject}
function DllCanUnloadNow: HResult; stdcall;
{$NODEFINE DllCanUnloadNow}
function DllRegisterServer: HResult; stdcall;
{$NODEFINE DllRegisterServer}
function DllUnregisterServer: HResult; stdcall;
{$NODEFINE DllUnregisterServer}
function DllInstall(bInstall: WordBool; pszCmdLine: LPCWSTR): HResult; stdcall;
{$NODEFINE DllInstall}
function LoadTypeLibrary(const ModuleName: string): ITypeLib;

implementation

uses
  System.Win.ComConst;

type
  TFNGetLongPathName = function(lpszShortName: LPCTSTR; lpszLongName: LPTSTR;
    cchBuffer: DWORD): DWORD; stdcall;

var
  GetLongPathName: TFNGetLongPathName = nil;

function ShortToLongFileName(FileName: string): string;
var
  FindData: TWin32FindData;
  Search: THandle;
begin
  // Use GetLongPathName where available (Win98 and later) to avoid
  // Win98 SE problems accessing UNC paths on NT/2K/XP based systems
  if Assigned(GetLongPathName) then
  begin
    SetLength(Result, MAX_PATH + 1);
    SetLength(Result, GetLongPathName(PChar(FileName), @Result[1], MAX_PATH));
  end
  else
  begin
    Result := '';

    // Strip off one directory level at a time starting with the file name
    // and store it into the result. FindFirstFile will return the long file
    // name from the short file name.
    while (True) do
    begin
      Search := Winapi.Windows.FindFirstFile(PChar(FileName), FindData);

      if Search = INVALID_HANDLE_VALUE then
      begin
        Result := '';
        Break;
      end;

      Result := string('\') + FindData.cFileName + Result;
      FileName := ExtractFileDir(FileName);
      Winapi.Windows.FindClose(Search);

      // Found the drive letter followed by the colon.
      if Length(FileName) <= 2 then
        Break;
    end;

    if Result <> '' then
      Result := ExtractFileDrive(FileName) + Result;
  end;
end;

function GetModuleFileName: string;
var
  Buffer: array[0..261] of Char;
  Temp : string;
begin
  SetString(Result, Buffer, Winapi.Windows.GetModuleFileName(HInstance,
    Buffer, Length(Buffer)));
  Temp := ShortToLongFileName(Result);
  if Temp <> '' then
    Result := Temp;
end;

function GetModuleName: string;
begin
  Result := ChangeFileExt(ExtractFileName(GetModuleFileName), '');
end;

function LoadTypeLibrary(const ModuleName: string): ITypeLib;
begin
  OleCheck(LoadTypeLibEx(PWideChar(WideString(ModuleName)), REGKIND_NONE, Result));
end;

procedure RegisterTypeLibrary(const TypeLib: ITypeLib;
                              const ModuleName: string;
                              PerUser: Boolean = False);
type
  TRegisterProc = function(TypeLib: ITypeLib; szFullPath, szHelpDir: POleStr): HResult; stdcall;
var
  Name: WideString;
  HelpPath: WideString;
  Handle: THandle;
  RegisterProc: TRegisterProc;
begin
  Name := ModuleName;
  HelpPath := ExtractFilePath(ModuleName);
  if (PerUser) then
  begin
    Handle := GetModuleHandle('OLEAUT32.DLL');
    if Handle <> 0 then
    begin
      @RegisterProc := GetProcAddress(Handle, 'RegisterTypeLibForUser');
      if (@RegisterProc <> nil) then
      begin
        OleCheck(RegisterProc(TypeLib, PWideChar(Name), PWideChar(HelpPath)));
        Exit;
      end;
    end;
  end;
  OleCheck(RegisterTypeLib(TypeLib, PWideChar(Name), PWideChar(HelpPath)));
end;

procedure UnregisterTypeLibrary(const TypeLib: ITypeLib;
                                PerUser: Boolean = False);
type
  TUnregisterProc = function(const GUID: TGUID; VerMajor, VerMinor: Word;
    LCID: TLCID; SysKind: TSysKind): HResult stdcall;
var
  Handle: THandle;
  UnregisterProc: TUnregisterProc;
  LibAttr: PTLibAttr;
begin
  Handle := GetModuleHandle('OLEAUT32.DLL');
  if Handle <> 0 then
  begin
    @UnregisterProc := nil;
    if (PerUser) then
      @UnregisterProc := GetProcAddress(Handle, 'UnRegisterTypeLibForUser');
    if @UnregisterProc = nil then
      @UnregisterProc := GetProcAddress(Handle, 'UnRegisterTypeLib');
    if @UnregisterProc <> nil then
    begin
      OleCheck(ComServer.TypeLib.GetLibAttr(LibAttr));
      with LibAttr^ do
        UnregisterProc(guid, wMajorVerNum, wMinorVerNum, lcid, syskind);
      ComServer.TypeLib.ReleaseTLibAttr(LibAttr);
    end;
  end;
end;

function GetTypeLibName(const TypeLib: ITypeLib): string;
var
  Name: WideString;
begin
  OleCheck(TypeLib.GetDocumentation(-1, @Name, nil, nil, nil));
  Result := Name;
end;

function DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult;
var
  Factory: TComObjectFactory;
begin
  Factory := ComClassManager.GetFactoryFromClassID(CLSID);
  if Factory <> nil then
    if Factory.GetInterface(IID, Obj) then
      Result := S_OK
    else
      Result := E_NOINTERFACE
  else
  begin
    Pointer(Obj) := nil;
    Result := CLASS_E_CLASSNOTAVAILABLE;
  end;
end;

function DllCanUnloadNow: HResult;
begin
  if (ComServer = nil) or
    ((ComServer.FObjectCount = 0) and (ComServer.FFactoryCount = 0)) then
    Result := S_OK
  else
    Result := S_FALSE;
end;

function DllRegisterServer: HResult;
begin
  Result := S_OK;
  try
    ComServer.UpdateRegistry(True);
  except
    Result := E_FAIL;
  end;
end;

function DllUnregisterServer: HResult;
begin
  Result := S_OK;
  try
    ComServer.UpdateRegistry(False);
  except
    Result := E_FAIL;
  end;
end;

function DllInstall(bInstall: WordBool; pszCmdLine: LPCWSTR): HResult; stdcall;
var
  SavePerUserVal: Boolean;
begin
  SavePerUserVal := ComServer.PerUserRegistration;
  if StrIComp(pszCmdLine, PWideChar('user')) = 0 then
    ComServer.PerUserRegistration := True
  else
    ComServer.PerUserRegistration := False;
  if (bInstall) then
  begin
    Result := DllRegisterServer();
    if Result = E_FAIL then
      DllUnregisterServer();
  end
  else
    Result := DllUnregisterServer();
  ComServer.PerUserRegistration := SavePerUserVal;
end;


{ Automation TerminateProc }

function AutomationTerminateProc: Boolean;
begin
  Result := True;
  if (ComServer <> nil) and (ComServer.ObjectCount > 0) and ComServer.UIInteractive then
  begin
    Result := MessageBox(0, PChar(SNoCloseActiveServer1 + SNoCloseActiveServer2),
      PChar(SAutomationWarning), MB_YESNO or MB_TASKMODAL or
      MB_ICONWARNING or MB_DEFBUTTON2) = IDYES;
  end;
end;


{ GetComServer }

function GetComServer: TComServer;
begin
  Result := ComServer;
end;

procedure DefaultTermProc;
begin
  Halt;
end;

{ TComServer }

constructor TComServer.Create;

  function FindSwitch(const Switch: string): Boolean;
  begin
    Result := FindCmdLineSwitch(Switch, ['-', '/'], True);
  end;

begin
  FTypeLib := nil;
  FTermProc := @DefaultTermProc;
  FIsInprocServer := ModuleIsLib;
  if FindSwitch('AUTOMATION') or FindSwitch('EMBEDDING') then
    FStartMode := smAutomation
  else if FindSwitch('REGSERVER') then
  begin
    PerUserRegistration := False;
    FStartMode := smRegServer;
  end
  else if FindSwitch('UNREGSERVER') then
  begin
    PerUserRegistration := False;
    FStartMode := smUnregServer;
  end
  else if FindSwitch('REGSERVERPERUSER') then
  begin
    PerUserRegistration := True;
    FStartMode := smRegServer;
  end
  else if FindSwitch('UNREGSERVERPERUSER') then
  begin
    PerUserRegistration := True;
    FStartMode := smUnregServer;
  end;
  FUIInteractive := True;
end;

destructor TComServer.Destroy;
begin
  ComClassManager.ForEachFactory(Self, FactoryFree);
end;

function TComServer.CountObject(Created: Boolean): Integer;
begin
  if Created then
  begin
    Result := AtomicIncrement(FObjectCount);
    if (not IsInProcServer) and (StartMode = smAutomation)
      and Assigned(System.Win.ComObj.CoAddRefServerProcess) then
      System.Win.ComObj.CoAddRefServerProcess;
  end
  else
  begin
    Result := AtomicDecrement(FObjectCount);
    if (not IsInProcServer) and (StartMode = smAutomation)
      and Assigned(System.Win.ComObj.CoReleaseServerProcess) then
    begin
      if System.Win.ComObj.CoReleaseServerProcess = 0 then
        LastReleased;
    end
    else if Result = 0 then
      LastReleased;
  end;
end;

function TComServer.CountFactory(Created: Boolean): Integer;
begin
  if Created then
    Result := AtomicIncrement(FFactoryCount)
  else
    Result := AtomicDecrement(FFactoryCount);
end;

procedure TComServer.FactoryFree(Factory: TComObjectFactory);
begin
  Factory.Free;
end;

procedure TComServer.FactoryRegisterClassObject(Factory: TComObjectFactory);
begin
  Factory.RegisterClassObject;
end;

procedure TComServer.FactoryUpdateRegistry(Factory: TComObjectFactory);
begin
  if Factory.Instancing <> ciInternal then
    Factory.UpdateRegistry(FRegister);
end;

function TComServer.GetHelpFileName: string;
begin
  Result := FHelpFileName;
end;

function TComServer.GetServerFileName: string;
begin
  Result := GetModuleFileName;
end;

function TComServer.GetServerKey: string;
begin
  if FIsInprocServer then
    Result := 'InprocServer32'
  else
    Result := 'LocalServer32';
end;

function TComServer.GetServerName: string;
begin
  if FServerName <> '' then
    Result := FServerName
  else
    if FTypeLib <> nil then
      Result := GetTypeLibName(FTypeLib)
    else
      Result := GetModuleName;
end;

procedure TComServer.SetServerName(const Name: string);
begin
  if FTypeLib = nil then
    FServerName := Name;
end;

function TComServer.GetTypeLib: ITypeLib;
begin
  LoadTypeLib;
  Result := FTypeLib;
end;

procedure TComServer.Initialize;
begin
  try
    if((FStartMode = smRegServer) or (FStartMode = smUnregServer)) then
      UpdateRegistry(FStartMode <> smUnregServer);
  except
    on E: EOleRegistrationError do
      // User may not have write access to the registry.
      // Squelch the exception unless we were explicitly told to register.
      if (E.ErrorCode <> TYPE_E_REGISTRYACCESS) or (FStartMode = smRegServer) then
        raise;
  end;
  if FStartMode in [smRegServer, smUnregServer] then
    FTermProc;
  ComClassManager.ForEachFactory(Self, FactoryRegisterClassObject);
end;

procedure TComServer.LastReleased;
var
  Shutdown: Boolean;
begin
  if not FIsInprocServer then
  begin
    Shutdown := FStartMode = smAutomation;
    try
      if Assigned(FOnLastRelease) then FOnLastRelease(Shutdown);
    finally
      if Shutdown then PostThreadMessage(MainThreadID, WM_QUIT, 0, 0);
    end;
  end;
end;

procedure TComServer.LoadTypeLib;
var
  Temp: ITypeLib;
begin
  if FTypeLib = nil then
  begin
  // this may load typelib more than once, but avoids need for critical section
  // and releases the interface correctly
    Temp := LoadTypeLibrary(GetModuleFileName);
    Pointer(Temp) := AtomicExchange(Pointer(FTypeLib), Pointer(Temp));
  end;
end;

procedure TComServer.UpdateRegistry(Register: Boolean);
begin
  if FTypeLib <> nil then
    if Register then
      RegisterTypeLibrary(FTypeLib, GetModuleFileName, PerUserRegistration)
    else
      UnregisterTypeLibrary(FTypeLib, PerUserRegistration);
  FRegister := Register;
  ComClassManager.ForEachFactory(Self, FactoryUpdateRegistry);
end;

var
  SaveInitProc: Pointer = nil;
  OleAutHandle: HMODULE;

procedure InitComServer;
begin
  if SaveInitProc <> nil then
    TProcedure(SaveInitProc);
  ComServer.FStartSuspended := (CoInitFlags <> -1) and
    Assigned(System.Win.ComObj.CoInitializeEx) and Assigned(System.Win.ComObj.CoResumeClassObjects);
  ComServer.Initialize;
  if ComServer.FStartSuspended then
    System.Win.ComObj.CoResumeClassObjects;
end;

function TComServer.GetStartSuspended: Boolean;
begin
  Result := FStartSuspended;
end;

procedure TComServer.SetHelpFileName(const Value: string);
begin
  FHelpFileName := Value;
end;

var
  KernelHandle: THandle;
initialization
begin
  OleAutHandle := SafeLoadLibrary('OLEAUT32.DLL');
  ComServer := TComServer.Create;
  if not ModuleIsLib then
  begin
    SaveInitProc := InitProc;
    InitProc := @InitComServer;
    AddTerminateProc(@AutomationTerminateProc);
  end;
  KernelHandle := GetModuleHandle('KERNEL32');
  if KernelHandle <> 0 then
    @GetLongPathName := GetProcAddress(KernelHandle, 'GetLongPathNameW');
end;

finalization
begin
  ComServer.Free;
  ComServer := nil;
  FreeLibrary(OleAutHandle);
end;

end.
