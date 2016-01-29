{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: shellapi.h                             }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       Win32 Shell API Interface Unit                  }
{*******************************************************}

unit Winapi.ShellAPI;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

 { _WIN32_WINNT >= 0x0600 }

interface

uses Winapi.Windows, Winapi.WinSock2, Winapi.IpExport;
// Winapi.WinSock2 is used only for NET_ADDRESS_INFO_ (this record is defined for winsock2 only)

(*$HPPEMIT '#include <shellapi.h>'*)

{$IF not defined(WIN64)}
// WinAPI header uses byte alignment.
{$A1}
{$ENDIF}

type
  HDROP = THandle;
  {$EXTERNALSYM HDROP}
  PPWideChar = ^PWideChar;

{$EXTERNALSYM DragQueryFile}
function DragQueryFile(Drop: HDROP; FileIndex: UINT; FileName: LPWSTR; cb: UINT): UINT; stdcall;
{$EXTERNALSYM DragQueryFileA}
function DragQueryFileA(Drop: HDROP; FileIndex: UINT; FileName: LPSTR; cb: UINT): UINT; stdcall;
{$EXTERNALSYM DragQueryFileW}
function DragQueryFileW(Drop: HDROP; FileIndex: UINT; FileName: LPWSTR; cb: UINT): UINT; stdcall;
{$EXTERNALSYM DragQueryPoint}
function DragQueryPoint(Drop: HDROP; var Point: TPoint): BOOL; stdcall;
{$EXTERNALSYM DragFinish}
procedure DragFinish(Drop: HDROP); stdcall;
{$EXTERNALSYM DragAcceptFiles}
procedure DragAcceptFiles(Wnd: HWND; Accept: BOOL); stdcall;
{$EXTERNALSYM ShellExecute}
function ShellExecute(hWnd: HWND; Operation, FileName, Parameters,
  Directory: LPWSTR; ShowCmd: Integer): HINST; stdcall;
{$EXTERNALSYM ShellExecuteA}
function ShellExecuteA(hWnd: HWND; Operation, FileName, Parameters,
  Directory: LPSTR; ShowCmd: Integer): HINST; stdcall;
{$EXTERNALSYM ShellExecuteW}
function ShellExecuteW(hWnd: HWND; Operation, FileName, Parameters,
  Directory: LPWSTR; ShowCmd: Integer): HINST; stdcall;
{$EXTERNALSYM FindExecutable}
function FindExecutable(FileName, Directory: LPCWSTR; Result: LPWSTR): HINST; stdcall;
{$EXTERNALSYM FindExecutableA}
function FindExecutableA(FileName, Directory: LPCSTR; Result: LPSTR): HINST; stdcall;
{$EXTERNALSYM FindExecutableW}
function FindExecutableW(FileName, Directory: LPCWSTR; Result: LPWSTR): HINST; stdcall;
{$EXTERNALSYM CommandLineToArgvW}
function CommandLineToArgvW(lpCmdLine: LPCWSTR; var pNumArgs: Integer): PPWideChar; stdcall;
{$EXTERNALSYM ShellAbout}
function ShellAbout(Wnd: HWND; szApp, szOtherStuff: LPCWSTR; Icon: HICON): Integer; stdcall;
{$EXTERNALSYM ShellAboutA}
function ShellAboutA(Wnd: HWND; szApp, szOtherStuff: LPCSTR; Icon: HICON): Integer; stdcall;
{$EXTERNALSYM ShellAboutW}
function ShellAboutW(Wnd: HWND; szApp, szOtherStuff: LPCWSTR; Icon: HICON): Integer; stdcall;
{$EXTERNALSYM DuplicateIcon}
function DuplicateIcon(hInst: HINST; Icon: HICON): HICON; stdcall;
{$EXTERNALSYM ExtractAssociatedIcon}
function ExtractAssociatedIcon(hInst: HINST; lpIconPath: LPWSTR;
  var lpiIcon: Word): HICON; stdcall;
{$EXTERNALSYM ExtractAssociatedIconA}
function ExtractAssociatedIconA(hInst: HINST; lpIconPath: LPSTR;
  var lpiIcon: Word): HICON; stdcall;
{$EXTERNALSYM ExtractAssociatedIconW}
function ExtractAssociatedIconW(hInst: HINST; lpIconPath: LPWSTR;
  var lpiIcon: Word): HICON; stdcall;
function ExtractAssociatedIconEx(hInst: HINST; 
  pszIconPath: LPWSTR; var piIconIndex: WORD; var piIconID: WORD): HICON; stdcall;
{$EXTERNALSYM ExtractAssociatedIconEx}
function ExtractAssociatedIconExA(hInst: HINST; 
  pszIconPath: LPSTR; var piIconIndex: WORD; var piIconID: WORD): HICON; stdcall;
{$EXTERNALSYM ExtractAssociatedIconExA}
function ExtractAssociatedIconExW(hInst: HINST; 
  pszIconPath: LPWSTR; var piIconIndex: WORD; var piIconID: WORD): HICON; stdcall;
{$EXTERNALSYM ExtractAssociatedIconExW}
{$EXTERNALSYM ExtractIcon}
function ExtractIcon(hInst: HINST; lpszExeFileName: LPCWSTR;
  nIconIndex: UINT): HICON; stdcall;
{$EXTERNALSYM ExtractIconA}
function ExtractIconA(hInst: HINST; lpszExeFileName: LPCSTR;
  nIconIndex: UINT): HICON; stdcall;
{$EXTERNALSYM ExtractIconW}
function ExtractIconW(hInst: HINST; lpszExeFileName: LPCWSTR;
  nIconIndex: UINT): HICON; stdcall;

type
  PDragInfoA = ^_DRAGINFOA;
  PDragInfoW = ^_DRAGINFOW;
  PDragInfo = PDragInfoW;
  _DRAGINFOA = record
    uSize: UINT;                 { init with SizeOf(DRAGINFO) }
    pt: TPoint;
    fNC: BOOL;
    lpFileList: LPSTR;
    grfKeyState: DWORD;
  end;
  TDragInfoA = _DRAGINFOA;
  LPDRAGINFOA = PDragInfoA;
  _DRAGINFOW = record
    uSize: UINT;                 { init with SizeOf(DRAGINFO) }
    pt: TPoint;
    fNC: BOOL;
    lpFileList: LPWSTR;
    grfKeyState: DWORD;
  end;
  TDragInfoW = _DRAGINFOW;
  LPDRAGINFOW = PDragInfoW;
  _DRAGINFO = _DRAGINFOW;

const
{ AppBar stuff }

  {$EXTERNALSYM ABM_NEW}
  ABM_NEW           = $00000000;
  {$EXTERNALSYM ABM_REMOVE}
  ABM_REMOVE        = $00000001;
  {$EXTERNALSYM ABM_QUERYPOS}
  ABM_QUERYPOS      = $00000002;
  {$EXTERNALSYM ABM_SETPOS}
  ABM_SETPOS        = $00000003;
  {$EXTERNALSYM ABM_GETSTATE}
  ABM_GETSTATE      = $00000004;
  {$EXTERNALSYM ABM_GETTASKBARPOS}
  ABM_GETTASKBARPOS = $00000005;
  {$EXTERNALSYM ABM_ACTIVATE}
  ABM_ACTIVATE      = $00000006;  { lParam = True/False means activate/deactivate }
  {$EXTERNALSYM ABM_GETAUTOHIDEBAR}
  ABM_GETAUTOHIDEBAR = $00000007;
  {$EXTERNALSYM ABM_SETAUTOHIDEBAR}
  ABM_SETAUTOHIDEBAR = $00000008;  { this can fail at any time.  MUST check the result
                                     lParam = TRUE/FALSE  Set/Unset
                                     uEdge = what edge }
  {$EXTERNALSYM ABM_WINDOWPOSCHANGED}
  ABM_WINDOWPOSCHANGED = $0000009;
  ABM_SETSTATE = $0000000a; 
  {$EXTERNALSYM ABM_SETSTATE}

{ these are put in the wparam of callback messages }

  {$EXTERNALSYM ABN_STATECHANGE}
  ABN_STATECHANGE    = $0000000;
  {$EXTERNALSYM ABN_POSCHANGED}
  ABN_POSCHANGED     = $0000001;
  {$EXTERNALSYM ABN_FULLSCREENAPP}
  ABN_FULLSCREENAPP  = $0000002;
  {$EXTERNALSYM ABN_WINDOWARRANGE}
  ABN_WINDOWARRANGE  = $0000003; { lParam = True means hide }

{ flags for get state }

  {$EXTERNALSYM ABS_AUTOHIDE}
  ABS_AUTOHIDE    = $0000001;
  {$EXTERNALSYM ABS_ALWAYSONTOP}
  ABS_ALWAYSONTOP = $0000002;

  {$EXTERNALSYM ABE_LEFT}
  ABE_LEFT        = 0;
  {$EXTERNALSYM ABE_TOP}
  ABE_TOP         = 1;
  {$EXTERNALSYM ABE_RIGHT}
  ABE_RIGHT       = 2;
  {$EXTERNALSYM ABE_BOTTOM}
  ABE_BOTTOM      = 3;

type
  PAppBarData = ^TAppBarData;
  {$EXTERNALSYM _AppBarData}
  _AppBarData = record
    cbSize: DWORD;
    hWnd: HWND;
    uCallbackMessage: UINT;
    uEdge: UINT;
    rc: TRect;
    lParam: LPARAM; { message specific }
  end;
  TAppBarData = _AppBarData;
  {$EXTERNALSYM APPBARDATA}
  APPBARDATA = _AppBarData;

{$EXTERNALSYM SHAppBarMessage}
function SHAppBarMessage(dwMessage: DWORD; var pData: TAppBarData): UINT; stdcall;
// //  EndAppBar

{$EXTERNALSYM DoEnvironmentSubst}
function DoEnvironmentSubst(szString: LPWSTR; cbString: UINT): DWORD; stdcall;
{$EXTERNALSYM DoEnvironmentSubstA}
function DoEnvironmentSubstA(szString: LPSTR; cbString: UINT): DWORD; stdcall;
{$EXTERNALSYM DoEnvironmentSubstW}
function DoEnvironmentSubstW(szString: LPWSTR; cbString: UINT): DWORD; stdcall;
{$EXTERNALSYM ExtractIconEx}
function ExtractIconEx(lpszFile: LPCWSTR; nIconIndex: Integer;
  var phiconLarge, phiconSmall: HICON; nIcons: UINT): UINT; stdcall;
{$EXTERNALSYM ExtractIconExA}
function ExtractIconExA(lpszFile: LPCSTR; nIconIndex: Integer;
  var phiconLarge, phiconSmall: HICON; nIcons: UINT): UINT; stdcall;
{$EXTERNALSYM ExtractIconExW}
function ExtractIconExW(lpszFile: LPCWSTR; nIconIndex: Integer;
  var phiconLarge, phiconSmall: HICON; nIcons: UINT): UINT; stdcall;


{ Shell File Operations }

const
  {$EXTERNALSYM FO_MOVE}
  FO_MOVE           = $0001;
  {$EXTERNALSYM FO_COPY}
  FO_COPY           = $0002;
  {$EXTERNALSYM FO_DELETE}
  FO_DELETE         = $0003;
  {$EXTERNALSYM FO_RENAME}
  FO_RENAME         = $0004;

// SHFILEOPSTRUCT.fFlags and IFileOperation::SetOperationFlags() flag values
  {$EXTERNALSYM FOF_MULTIDESTFILES}
  FOF_MULTIDESTFILES         = $0001;
  {$EXTERNALSYM FOF_CONFIRMMOUSE}
  FOF_CONFIRMMOUSE           = $0002;
  {$EXTERNALSYM FOF_SILENT}
  FOF_SILENT                 = $0004;  { don't create progress/report }
  {$EXTERNALSYM FOF_RENAMEONCOLLISION}
  FOF_RENAMEONCOLLISION      = $0008;
  {$EXTERNALSYM FOF_NOCONFIRMATION}
  FOF_NOCONFIRMATION         = $0010;  { Don't prompt the user. }
  {$EXTERNALSYM FOF_WANTMAPPINGHANDLE}
  FOF_WANTMAPPINGHANDLE      = $0020;  { Fill in SHFILEOPSTRUCT.hNameMappings
                                         Must be freed using SHFreeNameMappings }
  {$EXTERNALSYM FOF_ALLOWUNDO}
  FOF_ALLOWUNDO              = $0040;
  {$EXTERNALSYM FOF_FILESONLY}
  FOF_FILESONLY              = $0080;  { on *.*, do only files }
  {$EXTERNALSYM FOF_SIMPLEPROGRESS}
  FOF_SIMPLEPROGRESS         = $0100;  { means don't show names of files }
  {$EXTERNALSYM FOF_NOCONFIRMMKDIR}
  FOF_NOCONFIRMMKDIR         = $0200;  { don't confirm making any needed dirs }
  {$EXTERNALSYM FOF_NOERRORUI}
  FOF_NOERRORUI              = $0400;  { don't put up error UI }
  {$EXTERNALSYM FOF_NOCOPYSECURITYATTRIBS}
  FOF_NOCOPYSECURITYATTRIBS  = $0800;  // dont copy file security attributes (ACLs)
  {$EXTERNALSYM FOF_NORECURSION}
  FOF_NORECURSION            = $1000;  // don't recurse into directories for operations that would recurse
  {$EXTERNALSYM FOF_NO_CONNECTED_ELEMENTS}
  FOF_NO_CONNECTED_ELEMENTS  = $2000;  // don't operate on connected elements ("xxx_files" folders that go with .htm files)
  {$EXTERNALSYM FOF_WANTNUKEWARNING}
  FOF_WANTNUKEWARNING        = $4000;  // during delete operation, warn if nuking instead of recycling (partially overrides FOF_NOCONFIRMATION)
  {$EXTERNALSYM FOF_NORECURSEREPARSE}
  FOF_NORECURSEREPARSE       = $8000;  // deprecated; the operations engine always does the right thing on FolderLink objects (symlinks, reparse points, folder shortcuts)
  {$EXTERNALSYM FOF_NO_UI}
  FOF_NO_UI                  = FOF_SILENT or FOF_NOCONFIRMATION or FOF_NOERRORUI or FOF_NOCONFIRMMKDIR; // don't display any UI at all

type
  {$EXTERNALSYM FILEOP_FLAGS}
  FILEOP_FLAGS = Word;

const
  {$EXTERNALSYM PO_DELETE}
  PO_DELETE       = $0013;  { printer is being deleted }
  {$EXTERNALSYM PO_RENAME}
  PO_RENAME       = $0014;  { printer is being renamed }
  {$EXTERNALSYM PO_PORTCHANGE}
  PO_PORTCHANGE   = $0020;  { port this printer connected to is being changed
                              if this id is set, the strings received by
                              the copyhook are a doubly-null terminated
                              list of strings.  The first is the printer
                              name and the second is the printer port. }
  {$EXTERNALSYM PO_REN_PORT}
  PO_REN_PORT     = $0034;  { PO_RENAME and PO_PORTCHANGE at same time. }

{ no POF_ flags currently defined }

type
  {$EXTERNALSYM PRINTEROP_FLAGS}
  PRINTEROP_FLAGS = Word;

{ implicit parameters are:
      if pFrom or pTo are unqualified names the current directories are
      taken from the global current drive/directory settings managed
      by Get/SetCurrentDrive/Directory

      the global confirmation settings }

  PSHFileOpStructA = ^TSHFileOpStructA;
  PSHFileOpStructW = ^TSHFileOpStructW;
  PSHFileOpStruct = PSHFileOpStructW;
  {$EXTERNALSYM _SHFILEOPSTRUCTA}
  _SHFILEOPSTRUCTA = record
    Wnd: HWND;
    wFunc: UINT;
    pFrom: LPCSTR;
    pTo: LPCSTR;
    fFlags: FILEOP_FLAGS;
    fAnyOperationsAborted: BOOL;
    hNameMappings: Pointer;
    lpszProgressTitle: LPCSTR; { only used if FOF_SIMPLEPROGRESS }
  end;
  {$EXTERNALSYM _SHFILEOPSTRUCTW}
  _SHFILEOPSTRUCTW = record
    Wnd: HWND;
    wFunc: UINT;
    pFrom: LPCWSTR;
    pTo: LPCWSTR;
    fFlags: FILEOP_FLAGS;
    fAnyOperationsAborted: BOOL;
    hNameMappings: Pointer;
    lpszProgressTitle: LPCWSTR; { only used if FOF_SIMPLEPROGRESS }
  end;
  {$EXTERNALSYM _SHFILEOPSTRUCT}
  _SHFILEOPSTRUCT = _SHFILEOPSTRUCTW;
  TSHFileOpStructA = _SHFILEOPSTRUCTA;
  TSHFileOpStructW = _SHFILEOPSTRUCTW;
  TSHFileOpStruct = TSHFileOpStructW;
  {$EXTERNALSYM SHFILEOPSTRUCTA}
  SHFILEOPSTRUCTA = _SHFILEOPSTRUCTA;
  {$EXTERNALSYM SHFILEOPSTRUCTW}
  SHFILEOPSTRUCTW = _SHFILEOPSTRUCTW;
  {$EXTERNALSYM SHFILEOPSTRUCT}
  SHFILEOPSTRUCT = SHFILEOPSTRUCTW;

{$EXTERNALSYM SHFileOperation}
function SHFileOperation(const lpFileOp: TSHFileOpStruct): Integer; stdcall;
{$EXTERNALSYM SHFileOperationA}
function SHFileOperationA(const lpFileOp: TSHFileOpStructA): Integer; stdcall;
{$EXTERNALSYM SHFileOperationW}
function SHFileOperationW(const lpFileOp: TSHFileOpStructW): Integer; stdcall;
{$EXTERNALSYM SHFreeNameMappings}
procedure SHFreeNameMappings(hNameMappings: THandle); stdcall;

type
  PSHNameMappingA = ^TSHNameMappingA;
  PSHNameMappingW = ^TSHNameMappingW;
  PSHNameMapping = PSHNameMappingW;
  {$EXTERNALSYM _SHNAMEMAPPINGA}
  _SHNAMEMAPPINGA = record
    pszOldPath: LPSTR;
    pszNewPath: LPSTR;
    cchOldPath: Integer;
    cchNewPath: Integer;
  end;
  {$EXTERNALSYM _SHNAMEMAPPINGW}
  _SHNAMEMAPPINGW = record
    pszOldPath: LPWSTR;
    pszNewPath: LPWSTR;
    cchOldPath: Integer;
    cchNewPath: Integer;
  end;
  {$EXTERNALSYM _SHNAMEMAPPING}
  _SHNAMEMAPPING = _SHNAMEMAPPINGW;
  TSHNameMappingA = _SHNAMEMAPPINGA;
  TSHNameMappingW = _SHNAMEMAPPINGW;
  TSHNameMapping = TSHNameMappingW;
  {$EXTERNALSYM SHNAMEMAPPINGA}
  SHNAMEMAPPINGA = _SHNAMEMAPPINGA;
  {$EXTERNALSYM SHNAMEMAPPINGW}
  SHNAMEMAPPINGW = _SHNAMEMAPPINGW;
  {$EXTERNALSYM SHNAMEMAPPING}
  SHNAMEMAPPING = SHNAMEMAPPINGW;
// // End Shell File Operations

// //  Begin ShellExecuteEx and family
{ ShellExecute() and ShellExecuteEx() error codes }
const
{ regular WinExec() codes }
  {$EXTERNALSYM SE_ERR_FNF}
  SE_ERR_FNF              = 2;       { file not found }
  {$EXTERNALSYM SE_ERR_PNF}
  SE_ERR_PNF              = 3;       { path not found }
  {$EXTERNALSYM SE_ERR_ACCESSDENIED}
  SE_ERR_ACCESSDENIED     = 5;       { access denied }
  {$EXTERNALSYM SE_ERR_OOM}
  SE_ERR_OOM              = 8;       { out of memory }
  {$EXTERNALSYM SE_ERR_DLLNOTFOUND}
  SE_ERR_DLLNOTFOUND      = 32;

{ error values for ShellExecute() beyond the regular WinExec() codes }
  {$EXTERNALSYM SE_ERR_SHARE}
  SE_ERR_SHARE                    = 26;
  {$EXTERNALSYM SE_ERR_ASSOCINCOMPLETE}
  SE_ERR_ASSOCINCOMPLETE          = 27;
  {$EXTERNALSYM SE_ERR_DDETIMEOUT}
  SE_ERR_DDETIMEOUT               = 28;
  {$EXTERNALSYM SE_ERR_DDEFAIL}
  SE_ERR_DDEFAIL                  = 29;
  {$EXTERNALSYM SE_ERR_DDEBUSY}
  SE_ERR_DDEBUSY                  = 30;
  {$EXTERNALSYM SE_ERR_NOASSOC}
  SE_ERR_NOASSOC                  = 31;

{ Note CLASSKEY overrides CLASSNAME }
  {$EXTERNALSYM SEE_MASK_DEFAULT}
  SEE_MASK_DEFAULT        = $00000000; 
  {$EXTERNALSYM SEE_MASK_CLASSNAME}
  SEE_MASK_CLASSNAME      = $00000001;
  {$EXTERNALSYM SEE_MASK_CLASSKEY}
  SEE_MASK_CLASSKEY       = $00000003;
{ Note INVOKEIDLIST overrides IDLIST }
  {$EXTERNALSYM SEE_MASK_IDLIST}
  SEE_MASK_IDLIST         = $00000004;
  {$EXTERNALSYM SEE_MASK_INVOKEIDLIST}
  SEE_MASK_INVOKEIDLIST   = $0000000c;
  {$EXTERNALSYM SEE_MASK_ICON}
  SEE_MASK_ICON           = $00000010;
  {$EXTERNALSYM SEE_MASK_HOTKEY}
  SEE_MASK_HOTKEY         = $00000020;
  {$EXTERNALSYM SEE_MASK_NOCLOSEPROCESS}
  SEE_MASK_NOCLOSEPROCESS = $00000040;
  {$EXTERNALSYM SEE_MASK_CONNECTNETDRV}
  SEE_MASK_CONNECTNETDRV  = $00000080;
  {$EXTERNALSYM SEE_MASK_NOASYNC}
  SEE_MASK_NOASYNC   = $00000100;
  {$EXTERNALSYM SEE_MASK_FLAG_DDEWAIT}
  SEE_MASK_FLAG_DDEWAIT   = SEE_MASK_NOASYNC;
  {$EXTERNALSYM SEE_MASK_DOENVSUBST}
  SEE_MASK_DOENVSUBST     = $00000200;
  {$EXTERNALSYM SEE_MASK_FLAG_NO_UI}
  SEE_MASK_FLAG_NO_UI     = $00000400;
  {$EXTERNALSYM SEE_MASK_UNICODE}
  SEE_MASK_UNICODE        = $00004000;
  {$EXTERNALSYM SEE_MASK_NO_CONSOLE}
  SEE_MASK_NO_CONSOLE     = $00008000;
  {$EXTERNALSYM SEE_MASK_ASYNCOK}
  SEE_MASK_ASYNCOK        = $00100000;
  {$EXTERNALSYM SEE_MASK_HMONITOR}
  SEE_MASK_HMONITOR       = $00200000;            // SHELLEXECUTEINFO.hMonitor
  {$EXTERNALSYM SEE_MASK_NOZONECHECKS}
  SEE_MASK_NOZONECHECKS   = $00800000;
  {$EXTERNALSYM SEE_MASK_NOQUERYCLASSSTORE}
  SEE_MASK_NOQUERYCLASSSTORE = $01000000; 
  {$EXTERNALSYM SEE_MASK_WAITFORINPUTIDLE}
  SEE_MASK_WAITFORINPUTIDLE = $02000000; 
  {$EXTERNALSYM SEE_MASK_FLAG_LOG_USAGE}
  SEE_MASK_FLAG_LOG_USAGE = $04000000; 

type
  PShellExecuteInfoA = ^TShellExecuteInfoA;
  PShellExecuteInfoW = ^TShellExecuteInfoW;
  PShellExecuteInfo = PShellExecuteInfoW;
  {$EXTERNALSYM _SHELLEXECUTEINFOA}
  _SHELLEXECUTEINFOA = record
    cbSize: DWORD;
    fMask: ULONG;
    Wnd: HWND;
    lpVerb: LPCSTR;
    lpFile: LPCSTR;
    lpParameters: LPCSTR;
    lpDirectory: LPCSTR;
    nShow: Integer;
    hInstApp: HINST;
    { Optional fields }
    lpIDList: Pointer;
    lpClass: LPCSTR;
    hkeyClass: HKEY;
    dwHotKey: DWORD;
    case Integer of 
      0: (
        hIcon: THandle);
      1: (
        hMonitor: THandle;
        hProcess: THandle;);
  end;
  {$EXTERNALSYM _SHELLEXECUTEINFOW}
  _SHELLEXECUTEINFOW = record
    cbSize: DWORD;
    fMask: ULONG;
    Wnd: HWND;
    lpVerb: LPCWSTR;
    lpFile: LPCWSTR;
    lpParameters: LPCWSTR;
    lpDirectory: LPCWSTR;
    nShow: Integer;
    hInstApp: HINST;
    { Optional fields }
    lpIDList: Pointer;
    lpClass: LPCWSTR;
    hkeyClass: HKEY;
    dwHotKey: DWORD;
    case Integer of 
      0: (
        hIcon: THandle);
      1: (
        hMonitor: THandle;
        hProcess: THandle;);
  end;
  {$EXTERNALSYM _SHELLEXECUTEINFO}
  _SHELLEXECUTEINFO = _SHELLEXECUTEINFOW;
  TShellExecuteInfoA = _SHELLEXECUTEINFOA;
  TShellExecuteInfoW = _SHELLEXECUTEINFOW;
  TShellExecuteInfo = TShellExecuteInfoW;
  {$EXTERNALSYM SHELLEXECUTEINFOA}
  SHELLEXECUTEINFOA = _SHELLEXECUTEINFOA;
  {$EXTERNALSYM SHELLEXECUTEINFOW}
  SHELLEXECUTEINFOW = _SHELLEXECUTEINFOW;
  {$EXTERNALSYM SHELLEXECUTEINFO}
  SHELLEXECUTEINFO = SHELLEXECUTEINFOW;

{$EXTERNALSYM ShellExecuteEx}
function ShellExecuteEx(lpExecInfo: PShellExecuteInfo):BOOL; stdcall;
{$EXTERNALSYM ShellExecuteExA}
function ShellExecuteExA(lpExecInfo: PShellExecuteInfoA):BOOL; stdcall;
{$EXTERNALSYM ShellExecuteExW}
function ShellExecuteExW(lpExecInfo: PShellExecuteInfoW):BOOL; stdcall;

//  SHCreateProcessAsUser()
type 
  _SHCREATEPROCESSINFOW = record
        cbSize: DWORD;
        fMask: ULONG;
        hwnd: HWND;
        pszFile: LPCWSTR;
        pszParameters: LPCWSTR;
        pszCurrentDirectory: LPCWSTR;
        hUserToken: THandle;
        lpProcessAttributes: PSecurityAttributes;
        lpThreadAttributes: PSecurityAttributes;
        bInheritHandles: BOOL;
        dwCreationFlags: DWORD;
        lpStartupInfo: PStartupInfoW;
        lpProcessInformation: PProcessInformation;
  end;
  SHCREATEPROCESSINFOW = _SHCREATEPROCESSINFOW;
  TSHCreateProcessInfoW = SHCREATEPROCESSINFOW;

function SHCreateProcessAsUserW(var pscpi: TSHCreateProcessInfoW): BOOL; stdcall;
{$EXTERNALSYM SHCreateProcessAsUserW}

function SHEvaluateSystemCommandTemplate(pszCmdTemplate: LPCWSTR; 
  var ppszApplication: LPWSTR; var ppszCommandLine: LPWSTR; 
  var ppszParameters: LPWSTR): HResult; stdcall;
{$EXTERNALSYM SHEvaluateSystemCommandTemplate}

type
  ASSOCCLASS = Integer;    
  {$EXTERNALSYM ASSOCCLASS}
  TAssocClass = ASSOCClass;
const
  ASSOCCLASS_SHELL_KEY  = 0;    //  hkeyClass
  {$EXTERNALSYM ASSOCCLASS_SHELL_KEY}
  ASSOCCLASS_PROGID_KEY = 1;    //  hkeyClass
  {$EXTERNALSYM ASSOCCLASS_PROGID_KEY}
  ASSOCCLASS_PROGID_STR = 2;    //  pszClass (HKCR\pszClass)
  {$EXTERNALSYM ASSOCCLASS_PROGID_STR}
  ASSOCCLASS_CLSID_KEY  = 3;    //  hkeyClass
  {$EXTERNALSYM ASSOCCLASS_CLSID_KEY}
  ASSOCCLASS_CLSID_STR  = 4;    //  pszClass (HKCR\CLSID\pszClass)
  {$EXTERNALSYM ASSOCCLASS_CLSID_STR}
  ASSOCCLASS_APP_KEY    = 5;    //  hkeyClass
  {$EXTERNALSYM ASSOCCLASS_APP_KEY}
  ASSOCCLASS_APP_STR    = 6;    //  pszClass (HKCR\Applications\PathFindFileName(pszClass))
  {$EXTERNALSYM ASSOCCLASS_APP_STR}
  ASSOCCLASS_SYSTEM_STR = 7;    //  pszClass
  {$EXTERNALSYM ASSOCCLASS_SYSTEM_STR}
  ASSOCCLASS_FOLDER     = 8;    //  none
  {$EXTERNALSYM ASSOCCLASS_FOLDER}
  ASSOCCLASS_STAR       = 9;    //  none
  {$EXTERNALSYM ASSOCCLASS_STAR}
type
  ASSOCIATIONELEMENT = record 
    ac: TAssocClass;            // required
    hkClass: HKEY;              // may be NULL
    pszClass: LPCWSTR;          // may be NULL
  end;
  {$EXTERNALSYM ASSOCIATIONELEMENT}
  ASSOCIATIONELEMENT_ = ASSOCIATIONELEMENT;
  {$EXTERNALSYM ASSOCIATIONELEMENT_}
  TAssociationElement = ASSOCIATIONELEMENT;
  PAssociationElement = ^TASSOCIATIONELEMENT;

// the object returned from this API implements IQueryAssociations
function AssocCreateForClasses(var rgClasses: TAssociationElement; 
  cClasses: Cardinal; const riid: TGUID; var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM AssocCreateForClasses}
// //  End ShellExecuteEx and family

// RecycleBin

// struct for query recycle bin info
type
  LPSHQUERYRBINFO = ^SHQUERYRBINFO;
  {$EXTERNALSYM LPSHQUERYRBINFO}
  SHQUERYRBINFO = record 
    cbSize: DWORD;
    i64Size: DWORDLONG;
    i64NumItems: DWORDLONG;
  end;
  {$EXTERNALSYM SHQUERYRBINFO}
  _SHQUERYRBINFO = SHQUERYRBINFO;
  {$EXTERNALSYM _SHQUERYRBINFO}
  TSHQueryRBInfo = SHQUERYRBINFO;
  PSHQueryRBInfo = ^TSHQueryRBInfo;

// flags for SHEmptyRecycleBin
// 
const
  SHERB_NOCONFIRMATION = $00000001; 
  {$EXTERNALSYM SHERB_NOCONFIRMATION}
  SHERB_NOPROGRESSUI = $00000002; 
  {$EXTERNALSYM SHERB_NOPROGRESSUI}
  SHERB_NOSOUND = $00000004; 
  {$EXTERNALSYM SHERB_NOSOUND}

function SHQueryRecycleBin(pszRootPath: LPCWSTR; 
  pSHQueryRBInfo: LPSHQUERYRBINFO): HResult; stdcall;
{$EXTERNALSYM SHQueryRecycleBin}
function SHQueryRecycleBinA(pszRootPath: LPCSTR; 
  pSHQueryRBInfo: LPSHQUERYRBINFO): HResult; stdcall;
{$EXTERNALSYM SHQueryRecycleBinA}
function SHQueryRecycleBinW(pszRootPath: LPCWSTR; 
  pSHQueryRBInfo: LPSHQUERYRBINFO): HResult; stdcall;
{$EXTERNALSYM SHQueryRecycleBinW}
function SHEmptyRecycleBin(hwnd: HWND; pszRootPath: LPCWSTR; 
  dwFlags: DWORD): HResult; stdcall;
{$EXTERNALSYM SHEmptyRecycleBin}
function SHEmptyRecycleBinA(hwnd: HWND; pszRootPath: LPCSTR; 
  dwFlags: DWORD): HResult; stdcall;
{$EXTERNALSYM SHEmptyRecycleBinA}
function SHEmptyRecycleBinW(hwnd: HWND; pszRootPath: LPCWSTR; 
  dwFlags: DWORD): HResult; stdcall;
{$EXTERNALSYM SHEmptyRecycleBinW}
// // end of RecycleBin

// // Taskbar notification definitions
type
  QUERY_USER_NOTIFICATION_STATE = Integer; 
  {$EXTERNALSYM QUERY_USER_NOTIFICATION_STATE}
const
  QUNS_NOT_PRESENT             = 1;  // The user is not present.  Heuristic check for modes like: screen saver, locked machine, non-active FUS session
  {$EXTERNALSYM QUNS_NOT_PRESENT}
  QUNS_BUSY                    = 2;  // The user is busy.  Heuristic check for modes like: full-screen app
  {$EXTERNALSYM QUNS_BUSY}
  QUNS_RUNNING_D3D_FULL_SCREEN = 3;  // full-screen (exlusive-mode) D3D app
  {$EXTERNALSYM QUNS_RUNNING_D3D_FULL_SCREEN}
  QUNS_PRESENTATION_MODE       = 4;  // Windows presentation mode (laptop feature) is turned on
  {$EXTERNALSYM QUNS_PRESENTATION_MODE}
  QUNS_ACCEPTS_NOTIFICATIONS   = 5;  // notifications can be freely sent
  {$EXTERNALSYM QUNS_ACCEPTS_NOTIFICATIONS}
  QUNS_QUIET_TIME              = 6;   // We are in OOBE quiet period
  {$EXTERNALSYM QUNS_QUIET_TIME}

function SHQueryUserNotificationState(
  var pquns: QUERY_USER_NOTIFICATION_STATE): HResult; stdcall;
{$EXTERNALSYM SHQueryUserNotificationState}

// This api retrieves an IPropertyStore that stores the window's properties. 
function SHGetPropertyStoreForWindow(hwnd: HWND; const riid: TGUID; 
  var ppv: Pointer): HResult; stdcall;
{$EXTERNALSYM SHGetPropertyStoreForWindow}

type
  PNotifyIconDataA = ^TNotifyIconDataA;
  PNotifyIconDataW = ^TNotifyIconDataW;
  PNotifyIconData = PNotifyIconDataW;
  {$EXTERNALSYM _NOTIFYICONDATAA}
  _NOTIFYICONDATAA = record
  private
    class constructor Create;
  public
    class function SizeOf: Integer; static;
  public
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of AnsiChar;
    case Integer of
      0: (
        uTimeout: UINT);
      1: (uVersion: UINT;
        szInfoTitle: array [0..63] of AnsiChar;
        dwInfoFlags: DWORD;
        guidItem: TGUID;        // Requires Windows Vista or later
        hBalloonIcon: HICON);   // Requires Windows Vista or later
  end;
  {$EXTERNALSYM _NOTIFYICONDATAW}
  _NOTIFYICONDATAW = record
  private
    class constructor Create;
  public
    class function SizeOf: Integer; static;
  public
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of WideChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of WideChar;
    case Integer of
      0: (
        uTimeout: UINT);
      1: (uVersion: UINT;
        szInfoTitle: array [0..63] of WideChar;
        dwInfoFlags: DWORD;
        guidItem: TGUID;        // Requires Windows Vista or later
        hBalloonIcon: HICON);   // Requires Windows Vista or later
  end;
  {$EXTERNALSYM _NOTIFYICONDATA}
  _NOTIFYICONDATA = _NOTIFYICONDATAW;
  TNotifyIconDataA = _NOTIFYICONDATAA;
  TNotifyIconDataW = _NOTIFYICONDATAW;
  TNotifyIconData = TNotifyIconDataW;
  {$EXTERNALSYM NOTIFYICONDATAA}
  NOTIFYICONDATAA = _NOTIFYICONDATAA;
  {$EXTERNALSYM NOTIFYICONDATAW}
  NOTIFYICONDATAW = _NOTIFYICONDATAW;
  {$EXTERNALSYM NOTIFYICONDATA}
  NOTIFYICONDATA = NOTIFYICONDATAW;

const
  {$EXTERNALSYM NIM_ADD}
  NIM_ADD         = $00000000;
  {$EXTERNALSYM NIM_MODIFY}
  NIM_MODIFY      = $00000001;
  {$EXTERNALSYM NIM_DELETE}
  NIM_DELETE      = $00000002;
  {$EXTERNALSYM NIM_SETFOCUS}
  NIM_SETFOCUS    = $00000003;
  {$EXTERNALSYM NIM_SETVERSION}
  NIM_SETVERSION  = $00000004;

// set NOTIFYICONDATA.uVersion with 0, 3 or 4
// please read the documentation on the behavior difference that the different versions imply
  NOTIFYICON_VERSION = 3; 
  {$EXTERNALSYM NOTIFYICON_VERSION}
  NOTIFYICON_VERSION_4 = 4; 
  {$EXTERNALSYM NOTIFYICON_VERSION_4}

  {$EXTERNALSYM NIF_MESSAGE}
  NIF_MESSAGE     = $00000001;
  {$EXTERNALSYM NIF_ICON}
  NIF_ICON        = $00000002;
  {$EXTERNALSYM NIF_TIP}
  NIF_TIP         = $00000004;
  {$EXTERNALSYM NIF_STATE}
  NIF_STATE       = $00000008;
  {$EXTERNALSYM NIF_INFO}
  NIF_INFO        = $00000010;
  {$EXTERNALSYM NIF_GUID}
  NIF_GUID = $00000020; 
  {$EXTERNALSYM NIF_REALTIME}
  NIF_REALTIME = $00000040; 
  {$EXTERNALSYM NIF_SHOWTIP}
  NIF_SHOWTIP = $00000080; 

  NIS_HIDDEN = $00000001; 
  {$EXTERNALSYM NIS_HIDDEN}
  NIS_SHAREDICON = $00000002; 
  {$EXTERNALSYM NIS_SHAREDICON}
// says this is the source of a shared icon

// Notify Icon Infotip flags
  {$EXTERNALSYM NIIF_NONE}
  NIIF_NONE       = $00000000;
// icon flags are mutually exclusive
// and take only the lowest 2 bits
  {$EXTERNALSYM NIIF_INFO}
  NIIF_INFO       = $00000001;
  {$EXTERNALSYM NIIF_WARNING}
  NIIF_WARNING    = $00000002;
  {$EXTERNALSYM NIIF_ERROR}
  NIIF_ERROR      = $00000003;
  {$EXTERNALSYM NIIF_ICON_MASK}
  NIIF_USER       = $00000004; 
  {$EXTERNALSYM NIIF_USER}
  NIIF_ICON_MASK  = $0000000F;
  {$EXTERNALSYM NIIF_NOSOUND}
  NIIF_NOSOUND    = $00000010; 
  {$EXTERNALSYM NIIF_LARGE_ICON}
  NIIF_LARGE_ICON = $00000020; 
  {$EXTERNALSYM NIIF_RESPECT_QUIET_TIME}
  NIIF_RESPECT_QUIET_TIME = $00000080; 

  {$EXTERNALSYM NIN_SELECT}
  NIN_SELECT      = $0400;
  {$EXTERNALSYM NINF_KEY}
  NINF_KEY        =  $1;
  {$EXTERNALSYM NIN_KEYSELECT}
  NIN_KEYSELECT   = NIN_SELECT or NINF_KEY;

  {$EXTERNALSYM NIN_BALLOONSHOW}
  NIN_BALLOONSHOW       = $0400 + 2;
  {$EXTERNALSYM NIN_BALLOONHIDE}
  NIN_BALLOONHIDE       = $0400 + 3;
  {$EXTERNALSYM NIN_BALLOONTIMEOUT}
  NIN_BALLOONTIMEOUT    = $0400 + 4;
  {$EXTERNALSYM NIN_BALLOONUSERCLICK}
  NIN_BALLOONUSERCLICK  = $0400 + 5;
  {$EXTERNALSYM NIN_POPUPOPEN}
  NIN_POPUPOPEN         = $0400 + 6; 
  {$EXTERNALSYM NIN_POPUPCLOSE}
  NIN_POPUPCLOSE        = $0400 + 7; 

type
  PNOTIFYICONIDENTIFIER = ^NOTIFYICONIDENTIFIER;
  {$EXTERNALSYM PNOTIFYICONIDENTIFIER}
  NOTIFYICONIDENTIFIER = record 
    cbSize: DWORD;
    hWnd: HWND;
    uID: UINT;
    guidItem: TGUID;
  end;
  {$EXTERNALSYM NOTIFYICONIDENTIFIER}
  _NOTIFYICONIDENTIFIER = NOTIFYICONIDENTIFIER;
  {$EXTERNALSYM _NOTIFYICONIDENTIFIER}
  TNotifyIconIdentifier = NOTIFYICONIDENTIFIER;

{$EXTERNALSYM Shell_NotifyIcon}
function Shell_NotifyIcon(dwMessage: DWORD; lpData: PNotifyIconData): BOOL; stdcall;
{$EXTERNALSYM Shell_NotifyIconA}
function Shell_NotifyIconA(dwMessage: DWORD; lpData: PNotifyIconDataA): BOOL; stdcall;
{$EXTERNALSYM Shell_NotifyIconW}
function Shell_NotifyIconW(dwMessage: DWORD; lpData: PNotifyIconDataW): BOOL; stdcall;
function Shell_NotifyIconGetRect(var identifier: NOTIFYICONIDENTIFIER; 
  var iconLocation: TRect): HResult; stdcall;
{$EXTERNALSYM Shell_NotifyIconGetRect}
// // End Taskbar Notification Icons

{ Begin SHGetFileInfo }

(*
 * The SHGetFileInfo API provides an easy way to get attributes
 * for a file given a pathname.
 *
 *   PARAMETERS
 *
 *     pszPath              file name to get info about
 *     dwFileAttributes     file attribs, only used with SHGFI_USEFILEATTRIBUTES
 *     psfi                 place to return file info
 *     cbFileInfo           size of structure
 *     uFlags               flags
 *
 *   RETURN
 *     TRUE if things worked
 *)

type
  PSHFileInfoA = ^TSHFileInfoA;
  PSHFileInfoW = ^TSHFileInfoW;
  PSHFileInfo = PSHFileInfoW;
  {$EXTERNALSYM _SHFILEINFOA}
  _SHFILEINFOA = record
    hIcon: HICON;                      { out: icon }
    iIcon: Integer;                    { out: icon index }
    dwAttributes: DWORD;               { out: SFGAO_ flags }
    szDisplayName: array [0..MAX_PATH-1] of  AnsiChar; { out: display name (or path) }
    szTypeName: array [0..79] of AnsiChar;             { out: type name }
  end;
  {$EXTERNALSYM _SHFILEINFOW}
  _SHFILEINFOW = record
    hIcon: HICON;                      { out: icon }
    iIcon: Integer;                    { out: icon index }
    dwAttributes: DWORD;               { out: SFGAO_ flags }
    szDisplayName: array [0..MAX_PATH-1] of  WideChar; { out: display name (or path) }
    szTypeName: array [0..79] of WideChar;             { out: type name }
  end;
  {$EXTERNALSYM _SHFILEINFO}
  _SHFILEINFO = _SHFILEINFOW;
  TSHFileInfoA = _SHFILEINFOA;
  TSHFileInfoW = _SHFILEINFOW;
  TSHFileInfo = TSHFileInfoW;
  {$EXTERNALSYM SHFILEINFOA}
  SHFILEINFOA = _SHFILEINFOA;
  {$EXTERNALSYM SHFILEINFOW}
  SHFILEINFOW = _SHFILEINFOW;
  {$EXTERNALSYM SHFILEINFO}
  SHFILEINFO = SHFILEINFOW;

const
  {$EXTERNALSYM SHGFI_ICON}
  SHGFI_ICON              = $000000100;     { get icon }
  {$EXTERNALSYM SHGFI_DISPLAYNAME}
  SHGFI_DISPLAYNAME       = $000000200;     { get display name }
  {$EXTERNALSYM SHGFI_TYPENAME}
  SHGFI_TYPENAME          = $000000400;     { get type name }
  {$EXTERNALSYM SHGFI_ATTRIBUTES}
  SHGFI_ATTRIBUTES        = $000000800;     { get attributes }
  {$EXTERNALSYM SHGFI_ICONLOCATION}
  SHGFI_ICONLOCATION      = $000001000;     { get icon location }
  {$EXTERNALSYM SHGFI_EXETYPE}
  SHGFI_EXETYPE           = $000002000;     { return exe type }
  {$EXTERNALSYM SHGFI_SYSICONINDEX}
  SHGFI_SYSICONINDEX      = $000004000;     { get system icon index }
  {$EXTERNALSYM SHGFI_LINKOVERLAY}
  SHGFI_LINKOVERLAY       = $000008000;     { put a link overlay on icon }
  {$EXTERNALSYM SHGFI_SELECTED}
  SHGFI_SELECTED          = $000010000;     { show icon in selected state }
  {$EXTERNALSYM SHGFI_ATTR_SPECIFIED}
  SHGFI_ATTR_SPECIFIED    = $000020000;     { get only specified attributes }
  {$EXTERNALSYM SHGFI_LARGEICON}
  SHGFI_LARGEICON         = $000000000;     { get large icon }
  {$EXTERNALSYM SHGFI_SMALLICON}
  SHGFI_SMALLICON         = $000000001;     { get small icon }
  {$EXTERNALSYM SHGFI_OPENICON}
  SHGFI_OPENICON          = $000000002;     { get open icon }
  {$EXTERNALSYM SHGFI_SHELLICONSIZE}
  SHGFI_SHELLICONSIZE     = $000000004;     { get shell size icon }
  {$EXTERNALSYM SHGFI_PIDL}
  SHGFI_PIDL              = $000000008;     { pszPath is a pidl }
  {$EXTERNALSYM SHGFI_USEFILEATTRIBUTES}
  SHGFI_USEFILEATTRIBUTES = $000000010;     { use passed dwFileAttribute }
  {$EXTERNALSYM SHGFI_ADDOVERLAYS}
  SHGFI_ADDOVERLAYS = $000000020;           { apply the appropriate overlays }
  {$EXTERNALSYM SHGFI_OVERLAYINDEX}
  SHGFI_OVERLAYINDEX = $000000040;          { Get the index of the overlay
                                              in the upper 8 bits of the iIcon }

{$EXTERNALSYM SHGetFileInfo}
function SHGetFileInfo(pszPath: LPCWSTR; dwFileAttributes: DWORD;
  var psfi: TSHFileInfo; cbFileInfo, uFlags: UINT): DWORD_PTR; stdcall;
{$EXTERNALSYM SHGetFileInfoA}
function SHGetFileInfoA(pszPath: LPCSTR; dwFileAttributes: DWORD;
  var psfi: TSHFileInfoA; cbFileInfo, uFlags: UINT): DWORD_PTR; stdcall;
{$EXTERNALSYM SHGetFileInfoW}
function SHGetFileInfoW(pszPath: LPCWSTR; dwFileAttributes: DWORD;
  var psfi: TSHFileInfoW; cbFileInfo, uFlags: UINT): DWORD_PTR; stdcall;

type
  SHSTOCKICONINFO = record 
    cbSize: DWORD;
    hIcon: HICON;
    iSysImageIndex: Integer;
    iIcon: Integer;
    szPath: packed array[0..MAX_PATH-1] of WCHAR;
  end;
  {$EXTERNALSYM SHSTOCKICONINFO}
  _SHSTOCKICONINFO = SHSTOCKICONINFO;
  {$EXTERNALSYM _SHSTOCKICONINFO}
  TSHStockIconInfo = SHSTOCKICONINFO;
  PSHStockIconInfo = ^TSHSTockIconInfo;

const
  SHGSI_ICONLOCATION = 0;     // you always get the icon location
  {$EXTERNALSYM SHGSI_ICONLOCATION}
  SHGSI_ICON = SHGFI_ICON; 
  {$EXTERNALSYM SHGSI_ICON}
  SHGSI_SYSICONINDEX = SHGFI_SYSICONINDEX; 
  {$EXTERNALSYM SHGSI_SYSICONINDEX}
  SHGSI_LINKOVERLAY = SHGFI_LINKOVERLAY; 
  {$EXTERNALSYM SHGSI_LINKOVERLAY}
  SHGSI_SELECTED = SHGFI_SELECTED; 
  {$EXTERNALSYM SHGSI_SELECTED}
  SHGSI_LARGEICON = SHGFI_LARGEICON; 
  {$EXTERNALSYM SHGSI_LARGEICON}
  SHGSI_SMALLICON = SHGFI_SMALLICON; 
  {$EXTERNALSYM SHGSI_SMALLICON}
  SHGSI_SHELLICONSIZE = SHGFI_SHELLICONSIZE; 
  {$EXTERNALSYM SHGSI_SHELLICONSIZE}

//  Shell icons
type
  SHSTOCKICONID = Integer; 
  {$EXTERNALSYM SHSTOCKICONID}
const
  SIID_DOCNOASSOC        = 0;     // document (blank page), no associated program
  {$EXTERNALSYM SIID_DOCNOASSOC}
  SIID_DOCASSOC          = 1;     // document with an associated program
  {$EXTERNALSYM SIID_DOCASSOC}
  SIID_APPLICATION       = 2;     // generic application with no custom icon
  {$EXTERNALSYM SIID_APPLICATION}
  SIID_FOLDER            = 3;     // folder (closed)
  {$EXTERNALSYM SIID_FOLDER}
  SIID_FOLDEROPEN        = 4;     // folder (open)
  {$EXTERNALSYM SIID_FOLDEROPEN}
  SIID_DRIVE525          = 5;     // 5.25" floppy disk drive
  {$EXTERNALSYM SIID_DRIVE525}
  SIID_DRIVE35           = 6;     // 3.5" floppy disk drive
  {$EXTERNALSYM SIID_DRIVE35}
  SIID_DRIVEREMOVE       = 7;     // removable drive
  {$EXTERNALSYM SIID_DRIVEREMOVE}
  SIID_DRIVEFIXED        = 8;     // fixed (hard disk) drive
  {$EXTERNALSYM SIID_DRIVEFIXED}
  SIID_DRIVENET          = 9;     // network drive
  {$EXTERNALSYM SIID_DRIVENET}
  SIID_DRIVENETDISABLED  = 10;    // disconnected network drive
  {$EXTERNALSYM SIID_DRIVENETDISABLED}
  SIID_DRIVECD           = 11;    // CD drive
  {$EXTERNALSYM SIID_DRIVECD}
  SIID_DRIVERAM          = 12;    // RAM disk drive
  {$EXTERNALSYM SIID_DRIVERAM}
  SIID_WORLD             = 13;    // entire network
  {$EXTERNALSYM SIID_WORLD}
  SIID_SERVER            = 15;    // a computer on the network
  {$EXTERNALSYM SIID_SERVER}
  SIID_PRINTER           = 16;    // printer
  {$EXTERNALSYM SIID_PRINTER}
  SIID_MYNETWORK         = 17;    // My network places
  {$EXTERNALSYM SIID_MYNETWORK}
  SIID_FIND              = 22;    // Find
  {$EXTERNALSYM SIID_FIND}
  SIID_HELP              = 23;    // Help
  {$EXTERNALSYM SIID_HELP}
  SIID_SHARE             = 28;    // overlay for shared items
  {$EXTERNALSYM SIID_SHARE}
  SIID_LINK              = 29;    // overlay for shortcuts to items
  {$EXTERNALSYM SIID_LINK}
  SIID_SLOWFILE          = 30;    // overlay for slow items
  {$EXTERNALSYM SIID_SLOWFILE}
  SIID_RECYCLER          = 31;    // empty recycle bin
  {$EXTERNALSYM SIID_RECYCLER}
  SIID_RECYCLERFULL      = 32;    // full recycle bin
  {$EXTERNALSYM SIID_RECYCLERFULL}
  SIID_MEDIACDAUDIO      = 40;    // Audio CD Media
  {$EXTERNALSYM SIID_MEDIACDAUDIO}
  SIID_LOCK              = 47;    // Security lock
  {$EXTERNALSYM SIID_LOCK}
  SIID_AUTOLIST          = 49;    // AutoList
  {$EXTERNALSYM SIID_AUTOLIST}
  SIID_PRINTERNET        = 50;    // Network printer
  {$EXTERNALSYM SIID_PRINTERNET}
  SIID_SERVERSHARE       = 51;    // Server share
  {$EXTERNALSYM SIID_SERVERSHARE}
  SIID_PRINTERFAX        = 52;    // Fax printer
  {$EXTERNALSYM SIID_PRINTERFAX}
  SIID_PRINTERFAXNET     = 53;    // Networked Fax Printer
  {$EXTERNALSYM SIID_PRINTERFAXNET}
  SIID_PRINTERFILE       = 54;    // Print to File
  {$EXTERNALSYM SIID_PRINTERFILE}
  SIID_STACK             = 55;    // Stack
  {$EXTERNALSYM SIID_STACK}
  SIID_MEDIASVCD         = 56;    // SVCD Media
  {$EXTERNALSYM SIID_MEDIASVCD}
  SIID_STUFFEDFOLDER     = 57;    // Folder containing other items
  {$EXTERNALSYM SIID_STUFFEDFOLDER}
  SIID_DRIVEUNKNOWN      = 58;    // Unknown drive
  {$EXTERNALSYM SIID_DRIVEUNKNOWN}
  SIID_DRIVEDVD          = 59;    // DVD Drive
  {$EXTERNALSYM SIID_DRIVEDVD}
  SIID_MEDIADVD          = 60;    // DVD Media
  {$EXTERNALSYM SIID_MEDIADVD}
  SIID_MEDIADVDRAM       = 61;    // DVD-RAM Media
  {$EXTERNALSYM SIID_MEDIADVDRAM}
  SIID_MEDIADVDRW        = 62;    // DVD-RW Media
  {$EXTERNALSYM SIID_MEDIADVDRW}
  SIID_MEDIADVDR         = 63;    // DVD-R Media
  {$EXTERNALSYM SIID_MEDIADVDR}
  SIID_MEDIADVDROM       = 64;    // DVD-ROM Media
  {$EXTERNALSYM SIID_MEDIADVDROM}
  SIID_MEDIACDAUDIOPLUS  = 65;    // CD+ (Enhanced CD) Media
  {$EXTERNALSYM SIID_MEDIACDAUDIOPLUS}
  SIID_MEDIACDRW         = 66;    // CD-RW Media
  {$EXTERNALSYM SIID_MEDIACDRW}
  SIID_MEDIACDR          = 67;    // CD-R Media
  {$EXTERNALSYM SIID_MEDIACDR}
  SIID_MEDIACDBURN       = 68;    // Burning CD
  {$EXTERNALSYM SIID_MEDIACDBURN}
  SIID_MEDIABLANKCD      = 69;    // Blank CD Media
  {$EXTERNALSYM SIID_MEDIABLANKCD}
  SIID_MEDIACDROM        = 70;    // CD-ROM Media
  {$EXTERNALSYM SIID_MEDIACDROM}
  SIID_AUDIOFILES        = 71;    // Audio files
  {$EXTERNALSYM SIID_AUDIOFILES}
  SIID_IMAGEFILES        = 72;    // Image files
  {$EXTERNALSYM SIID_IMAGEFILES}
  SIID_VIDEOFILES        = 73;    // Video files
  {$EXTERNALSYM SIID_VIDEOFILES}
  SIID_MIXEDFILES        = 74;    // Mixed files
  {$EXTERNALSYM SIID_MIXEDFILES}
  SIID_FOLDERBACK        = 75;    // Folder back
  {$EXTERNALSYM SIID_FOLDERBACK}
  SIID_FOLDERFRONT       = 76;    // Folder front
  {$EXTERNALSYM SIID_FOLDERFRONT}
  SIID_SHIELD            = 77;    // Security shield. Use for UAC prompts only.
  {$EXTERNALSYM SIID_SHIELD}
  SIID_WARNING           = 78;    // Warning
  {$EXTERNALSYM SIID_WARNING}
  SIID_INFO              = 79;    // Informational
  {$EXTERNALSYM SIID_INFO}
  SIID_ERROR             = 80;    // Error
  {$EXTERNALSYM SIID_ERROR}
  SIID_KEY               = 81;    // Key / Secure
  {$EXTERNALSYM SIID_KEY}
  SIID_SOFTWARE          = 82;    // Software
  {$EXTERNALSYM SIID_SOFTWARE}
  SIID_RENAME            = 83;    // Rename
  {$EXTERNALSYM SIID_RENAME}
  SIID_DELETE            = 84;    // Delete
  {$EXTERNALSYM SIID_DELETE}
  SIID_MEDIAAUDIODVD     = 85;    // Audio DVD Media
  {$EXTERNALSYM SIID_MEDIAAUDIODVD}
  SIID_MEDIAMOVIEDVD     = 86;    // Movie DVD Media
  {$EXTERNALSYM SIID_MEDIAMOVIEDVD}
  SIID_MEDIAENHANCEDCD   = 87;    // Enhanced CD Media
  {$EXTERNALSYM SIID_MEDIAENHANCEDCD}
  SIID_MEDIAENHANCEDDVD  = 88;    // Enhanced DVD Media
  {$EXTERNALSYM SIID_MEDIAENHANCEDDVD}
  SIID_MEDIAHDDVD        = 89;    // HD-DVD Media
  {$EXTERNALSYM SIID_MEDIAHDDVD}
  SIID_MEDIABLURAY       = 90;    // BluRay Media
  {$EXTERNALSYM SIID_MEDIABLURAY}
  SIID_MEDIAVCD          = 91;    // VCD Media
  {$EXTERNALSYM SIID_MEDIAVCD}
  SIID_MEDIADVDPLUSR     = 92;    // DVD+R Media
  {$EXTERNALSYM SIID_MEDIADVDPLUSR}
  SIID_MEDIADVDPLUSRW    = 93;    // DVD+RW Media
  {$EXTERNALSYM SIID_MEDIADVDPLUSRW}
  SIID_DESKTOPPC         = 94;    // desktop computer
  {$EXTERNALSYM SIID_DESKTOPPC}
  SIID_MOBILEPC          = 95;    // mobile computer (laptop/notebook)
  {$EXTERNALSYM SIID_MOBILEPC}
  SIID_USERS             = 96;    // users
  {$EXTERNALSYM SIID_USERS}
  SIID_MEDIASMARTMEDIA   = 97;    // Smart Media
  {$EXTERNALSYM SIID_MEDIASMARTMEDIA}
  SIID_MEDIACOMPACTFLASH = 98;    // Compact Flash
  {$EXTERNALSYM SIID_MEDIACOMPACTFLASH}
  SIID_DEVICECELLPHONE   = 99;    // Cell phone
  {$EXTERNALSYM SIID_DEVICECELLPHONE}
  SIID_DEVICECAMERA      = 100;   // Camera
  {$EXTERNALSYM SIID_DEVICECAMERA}
  SIID_DEVICEVIDEOCAMERA = 101;   // Video camera
  {$EXTERNALSYM SIID_DEVICEVIDEOCAMERA}
  SIID_DEVICEAUDIOPLAYER = 102;   // Audio player
  {$EXTERNALSYM SIID_DEVICEAUDIOPLAYER}
  SIID_NETWORKCONNECT    = 103;   // Connect to network
  {$EXTERNALSYM SIID_NETWORKCONNECT}
  SIID_INTERNET          = 104;   // Internet
  {$EXTERNALSYM SIID_INTERNET}
  SIID_ZIPFILE           = 105;   // ZIP file
  {$EXTERNALSYM SIID_ZIPFILE}
  SIID_SETTINGS          = 106;   // Settings
  {$EXTERNALSYM SIID_SETTINGS}
    // 107-131 are internal Vista RTM icons
    // 132-159 for SP1 icons
  SIID_DRIVEHDDVD        = 132;   // HDDVD Drive (all types)
  {$EXTERNALSYM SIID_DRIVEHDDVD}
  SIID_DRIVEBD           = 133;   // BluRay Drive (all types)
  {$EXTERNALSYM SIID_DRIVEBD}
  SIID_MEDIAHDDVDROM     = 134;   // HDDVD-ROM Media
  {$EXTERNALSYM SIID_MEDIAHDDVDROM}
  SIID_MEDIAHDDVDR       = 135;   // HDDVD-R Media
  {$EXTERNALSYM SIID_MEDIAHDDVDR}
  SIID_MEDIAHDDVDRAM     = 136;   // HDDVD-RAM Media
  {$EXTERNALSYM SIID_MEDIAHDDVDRAM}
  SIID_MEDIABDROM        = 137;   // BluRay ROM Media
  {$EXTERNALSYM SIID_MEDIABDROM}
  SIID_MEDIABDR          = 138;   // BluRay R Media
  {$EXTERNALSYM SIID_MEDIABDR}
  SIID_MEDIABDRE         = 139;   // BluRay RE Media (Rewriable and RAM)
  {$EXTERNALSYM SIID_MEDIABDRE}
  SIID_CLUSTEREDDRIVE    = 140;   // Clustered disk
  {$EXTERNALSYM SIID_CLUSTEREDDRIVE}
    // 160+ are for Windows 7 icons
  SIID_MAX_ICONS         = 174; 
  {$EXTERNALSYM SIID_MAX_ICONS}

  SIID_INVALID           = -1; 
  {$EXTERNALSYM SIID_INVALID}

function SHGetStockIconInfo(siid: SHSTOCKICONID; uFlags: UINT; 
  var psii: TSHStockIconInfo): HResult; stdcall;
{$EXTERNALSYM SHGetStockIconInfo}

function SHGetDiskFreeSpace(pszDirectoryName: LPCWSTR; 
  var pulFreeBytesAvailableToCaller: ULARGE_INTEGER; 
  var pulTotalNumberOfBytes: ULARGE_INTEGER; 
  var pulTotalNumberOfFreeBytes: ULARGE_INTEGER): BOOL; stdcall;
{$EXTERNALSYM SHGetDiskFreeSpaceEx}
function SHGetDiskFreeSpaceA(pszDirectoryName: LPCSTR; 
  var pulFreeBytesAvailableToCaller: ULARGE_INTEGER; 
  var pulTotalNumberOfBytes: ULARGE_INTEGER; 
  var pulTotalNumberOfFreeBytes: ULARGE_INTEGER): BOOL; stdcall;
{$EXTERNALSYM SHGetDiskFreeSpaceExA}
function SHGetDiskFreeSpaceW(pszDirectoryName: LPCWSTR; 
  var pulFreeBytesAvailableToCaller: ULARGE_INTEGER; 
  var pulTotalNumberOfBytes: ULARGE_INTEGER; 
  var pulTotalNumberOfFreeBytes: ULARGE_INTEGER): BOOL; stdcall;
{$EXTERNALSYM SHGetDiskFreeSpaceExW}
function SHGetDiskFreeSpaceEx(pszDirectoryName: LPCWSTR; 
  var pulFreeBytesAvailableToCaller: ULARGE_INTEGER; 
  var pulTotalNumberOfBytes: ULARGE_INTEGER; 
  var pulTotalNumberOfFreeBytes: ULARGE_INTEGER): BOOL; stdcall;
{$EXTERNALSYM SHGetDiskFreeSpaceEx}
function SHGetDiskFreeSpaceExA(pszDirectoryName: LPCSTR; 
  var pulFreeBytesAvailableToCaller: ULARGE_INTEGER; 
  var pulTotalNumberOfBytes: ULARGE_INTEGER; 
  var pulTotalNumberOfFreeBytes: ULARGE_INTEGER): BOOL; stdcall;
{$EXTERNALSYM SHGetDiskFreeSpaceExA}
function SHGetDiskFreeSpaceExW(pszDirectoryName: LPCWSTR; 
  var pulFreeBytesAvailableToCaller: ULARGE_INTEGER; 
  var pulTotalNumberOfBytes: ULARGE_INTEGER; 
  var pulTotalNumberOfFreeBytes: ULARGE_INTEGER): BOOL; stdcall;
{$EXTERNALSYM SHGetDiskFreeSpaceExW}

function SHGetNewLinkInfo(pszLinkTo: LPCWSTR; pszDir: LPCWSTR; pszName: LPWSTR; 
  var pfMustCopy: BOOL; uFlags: UINT): BOOL; stdcall
{$EXTERNALSYM SHGetNewLinkInfo}
function SHGetNewLinkInfoA(pszLinkTo: LPCSTR; pszDir: LPCSTR; pszName: LPSTR; 
  var pfMustCopy: BOOL; uFlags: UINT): BOOL; stdcall
{$EXTERNALSYM SHGetNewLinkInfoA}
function SHGetNewLinkInfoW(pszLinkTo: LPCWSTR; pszDir: LPCWSTR; pszName: LPWSTR; 
  var pfMustCopy: BOOL; uFlags: UINT): BOOL; stdcall
{$EXTERNALSYM SHGetNewLinkInfoW}

const
  {$EXTERNALSYM SHGNLI_PIDL}
  SHGNLI_PIDL             = $000000001;     { pszLinkTo is a pidl }
  {$EXTERNALSYM SHGNLI_PREFIXNAME}
  SHGNLI_PREFIXNAME       = $000000002;     { Make name "Shortcut to xxx" }
  {$EXTERNALSYM SHGNLI_NOUNIQUE}
  SHGNLI_NOUNIQUE         = $000000004;     { don't do the unique name generation }
  {$EXTERNALSYM SHGNLI_NOLNK}
  SHGNLI_NOLNK = $000000008;                { don't add ".lnk" extension }
  {$EXTERNALSYM SHGNLI_NOLOCNAME}
  SHGNLI_NOLOCNAME = $000000010;            { use non localized (parsing) name from the target}
  {$EXTERNALSYM SHGNLI_USEURLEXT}
  SHGNLI_USEURLEXT = $000000020;            { use ".url" extension instead of ".lnk" }

  PRINTACTION_OPEN = 0;                 // pszBuf1:<PrinterName>
  {$EXTERNALSYM PRINTACTION_OPEN}
  PRINTACTION_PROPERTIES = 1;           // pszBuf1:<PrinterName>, pszBuf2:optional <PageName>
  {$EXTERNALSYM PRINTACTION_PROPERTIES}
  PRINTACTION_NETINSTALL = 2;           // pszBuf1:<NetPrinterName>
  {$EXTERNALSYM PRINTACTION_NETINSTALL}
  PRINTACTION_NETINSTALLLINK = 3;       // pszBuf1:<NetPrinterName>, pszBuf2:<path to store link>
  {$EXTERNALSYM PRINTACTION_NETINSTALLLINK}
  PRINTACTION_TESTPAGE = 4;             // pszBuf1:<PrinterName>
  {$EXTERNALSYM PRINTACTION_TESTPAGE}
  PRINTACTION_OPENNETPRN = 5;           // pszBuf1:<NetPrinterName>
  {$EXTERNALSYM PRINTACTION_OPENNETPRN}
  PRINTACTION_DOCUMENTDEFAULTS = 6;     // pszBuf1:<PrinterName>
  {$EXTERNALSYM PRINTACTION_DOCUMENTDEFAULTS}
  PRINTACTION_SERVERPROPERTIES = 7;     // pszBuf1:<Server> or <NetPrinterName>
  {$EXTERNALSYM PRINTACTION_SERVERPROPERTIES}

// deprecated, instead invoke verbs on printers/netprinters using IContextMenu or ShellExecute()

function SHInvokePrinterCommand(hwnd: HWND; uAction: UINT; lpBuf1: LPCWSTR; 
  lpBuf2: LPCWSTR; fModal: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHInvokePrinterCommand}
function SHInvokePrinterCommandA(hwnd: HWND; uAction: UINT; lpBuf1: LPCSTR; 
  lpBuf2: LPCSTR; fModal: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHInvokePrinterCommandA}
function SHInvokePrinterCommandW(hwnd: HWND; uAction: UINT; lpBuf1: LPCWSTR; 
  lpBuf2: LPCWSTR; fModal: BOOL): BOOL; stdcall;
{$EXTERNALSYM SHInvokePrinterCommandW}

type
  OPEN_PRINTER_PROPS_INFOA = record 
    dwSize: DWORD;
    pszSheetName: LPSTR;
    uSheetIndex: UINT;
    dwFlags: DWORD;
    bModal: BOOL;
  end;
  {$EXTERNALSYM OPEN_PRINTER_PROPS_INFOA}
  OPEN_PRINTER_PROPS_INFOW = record 
    dwSize: DWORD;
    pszSheetName: LPWSTR;
    uSheetIndex: UINT;
    dwFlags: DWORD;
    bModal: BOOL;
  end;
  {$EXTERNALSYM OPEN_PRINTER_PROPS_INFOW}
  OPEN_PRINTER_PROPS_INFO = OPEN_PRINTER_PROPS_INFOW;
  _OPEN_PRINTER_PROPS_INFOA = OPEN_PRINTER_PROPS_INFOA;
  {$EXTERNALSYM _OPEN_PRINTER_PROPS_INFOA}
  _OPEN_PRINTER_PROPS_INFOW = OPEN_PRINTER_PROPS_INFOW;
  {$EXTERNALSYM _OPEN_PRINTER_PROPS_INFOW}
  _OPEN_PRINTER_PROPS_INFO = _OPEN_PRINTER_PROPS_INFOW;
  TOpenPrinterPropsInfoA = OPEN_PRINTER_PROPS_INFOA;
  TOpenPrinterPropsInfoW = OPEN_PRINTER_PROPS_INFOW;
  TOpenPrinterPropsInfo = TOpenPrinterPropsInfoW;
  POpenPrinterPropsInfoA = ^TOpenPrinterPropsInfoA;
  POpenPrinterPropsInfoW = ^TOpenPrinterPropsInfoW;
  POpenPrinterPropsInfo = POpenPrinterPropsInfoW;

const
  PRINT_PROP_FORCE_NAME = $01; 
  {$EXTERNALSYM PRINT_PROP_FORCE_NAME}

  shell32 = 'shell32.dll';

// 
// The SHLoadNonloadedIconOverlayIdentifiers API causes the shell's
// icon overlay manager to load any registered icon overlay
// identifers that are not currently loaded.  This is useful if an
// overlay identifier did not load at shell startup but is needed
// and can be loaded at a later time.  Identifiers already loaded
// are not affected.  Overlay identifiers implement the
// IShellIconOverlayIdentifier interface.
// 
// Returns:
//      S_OK
// 
function SHLoadNonloadedIconOverlayIdentifiers: HResult; stdcall;
{$EXTERNALSYM SHLoadNonloadedIconOverlayIdentifiers}

// 
// The SHIsFileAvailableOffline API determines whether a file
// or folder is available for offline use.
// 
// Parameters:
//     pwszPath             file name to get info about
//     pdwStatus            (optional) OFFLINE_STATUS_* flags returned here
// 
// Returns:
//     S_OK                 File/directory is available offline, unless
//                            OFFLINE_STATUS_INCOMPLETE is returned.
//     E_INVALIDARG         Path is invalid, or not a net path
//     E_FAIL               File/directory is not available offline
// 
// Notes:
//     OFFLINE_STATUS_INCOMPLETE is never returned for directories.
//     Both OFFLINE_STATUS_LOCAL and OFFLINE_STATUS_REMOTE may be returned,
//     indicating "open in both places." This is common when the server is online.
// 
function SHIsFileAvailableOffline(pwszPath: LPCWSTR; 
  pdwStatus: LPDWORD): HResult; stdcall;
{$EXTERNALSYM SHIsFileAvailableOffline} 

const
  OFFLINE_STATUS_LOCAL = $0001;         // If open, it's open locally
  {$EXTERNALSYM OFFLINE_STATUS_LOCAL}
  OFFLINE_STATUS_REMOTE = $0002;        // If open, it's open remotely
  {$EXTERNALSYM OFFLINE_STATUS_REMOTE}
  OFFLINE_STATUS_INCOMPLETE = $0004;    // The local copy is currently imcomplete.
  {$EXTERNALSYM OFFLINE_STATUS_INCOMPLETE}
                                            // The file will not be available offline
                                            // until it has been synchronized.

//  sets the specified path to use the string resource
//  as the UI instead of the file system name
function SHSetLocalizedName(pszPath: LPCWSTR; pszResModule: LPCWSTR; 
  idsRes: Integer): HResult; stdcall;
{$EXTERNALSYM SHSetLocalizedName}

//  sets the specified path to use the string resource
//  as the UI instead of the file system name
function SHRemoveLocalizedName(pszPath: LPCWSTR): HResult; stdcall;
{$EXTERNALSYM SHRemoveLocalizedName}

//  gets the string resource for the specified path
function SHGetLocalizedName(pszPath: LPCWSTR; pszResModule: LPWSTR; cch: UINT; 
  var pidsRes: Integer): HResult; stdcall;
{$EXTERNALSYM SHGetLocalizedName}

// ====== ShellMessageBox ================================================

// If lpcTitle is NULL, the title is taken from hWnd
// If lpcText is NULL, this is assumed to be an Out Of Memory message
// If the selector of lpcTitle or lpcText is NULL, the offset should be a
//     string resource ID
// The variable arguments must all be 32-bit values (even if fewer bits
//     are actually used)
// lpcText (or whatever string resource it causes to be loaded) should
//     be a formatting string similar to wsprintf except that only the
//     following formats are available:
//         %%              formats to a single '%'
//         %nn%s           the nn-th arg is a string which is inserted
//         %nn%ld          the nn-th arg is a DWORD, and formatted decimal
//         %nn%lx          the nn-th arg is a DWORD, and formatted hex
//     note that lengths are allowed on the %s, %ld, and %lx, just
//                         like wsprintf
// 
function ShellMessageBox(hAppInst: HINST;  hWnd: HWND; pcText: LPCWSTR;
  lpcTitle: LPCWSTR; fuStyle: UINT): Integer; cdecl; varargs;
{$EXTERNALSYM ShellMessageBox}
function ShellMessageBoxA(hAppInst: HINST;  hWnd: HWND; pcText: LPCSTR;
  lpcTitle: LPCSTR; fuStyle: UINT): Integer; cdecl; varargs;
{$EXTERNALSYM ShellMessageBoxA}
function ShellMessageBoxW(hAppInst: HINST;  hWnd: HWND; pcText: LPCWSTR;
  lpcTitle: LPCWSTR; fuStyle: UINT): Integer; cdecl; varargs;
{$EXTERNALSYM ShellMessageBoxW}

function IsLFNDrive(pszPath: LPCWSTR): BOOL;
{$EXTERNALSYM IsLFNDrive}
function IsLFNDriveA(pszPath: LPCSTR): BOOL;
{$EXTERNALSYM IsLFNDriveA}
function IsLFNDriveW(pszPath: LPCWSTR): BOOL;
{$EXTERNALSYM IsLFNDriveW}

function SHEnumerateUnreadMailAccounts(hKeyUser: HKEY; dwIndex: DWORD; 
  pszMailAddress: LPWSTR; cchMailAddress: Integer): HResult; stdcall;
{$EXTERNALSYM SHEnumerateUnreadMailAccounts}
function SHEnumerateUnreadMailAccountsA(hKeyUser: HKEY; dwIndex: DWORD; 
  pszMailAddress: LPSTR; cchMailAddress: Integer): HResult; stdcall;
{$EXTERNALSYM SHEnumerateUnreadMailAccountsA}
function SHEnumerateUnreadMailAccountsW(hKeyUser: HKEY; dwIndex: DWORD; 
  pszMailAddress: LPWSTR; cchMailAddress: Integer): HResult; stdcall;
{$EXTERNALSYM SHEnumerateUnreadMailAccountsW}
function SHGetUnreadMailCount(hKeyUser: HKEY; pszMailAddress: LPCWSTR; 
  var pdwCount: DWORD; var pFileTime: FILETIME; pszShellExecuteCommand: LPWSTR; 
  cchShellExecuteCommand: Integer): HResult; stdcall;
{$EXTERNALSYM SHGetUnreadMailCount}
function SHGetUnreadMailCountA(hKeyUser: HKEY; pszMailAddress: LPCSTR; 
  var pdwCount: DWORD; var pFileTime: FILETIME; pszShellExecuteCommand: LPSTR; 
  cchShellExecuteCommand: Integer): HResult; stdcall;
{$EXTERNALSYM SHGetUnreadMailCountA}
function SHGetUnreadMailCountW(hKeyUser: HKEY; pszMailAddress: LPCWSTR; 
  var pdwCount: DWORD; var pFileTime: FILETIME; pszShellExecuteCommand: LPWSTR; 
  cchShellExecuteCommand: Integer): HResult; stdcall;
{$EXTERNALSYM SHGetUnreadMailCountW}
function SHSetUnreadMailCount(pszMailAddress: LPCWSTR; dwCount: DWORD; 
  pszShellExecuteCommand: LPCWSTR): HResult; stdcall;
{$EXTERNALSYM SHSetUnreadMailCount}
function SHSetUnreadMailCountA(pszMailAddress: LPCSTR; dwCount: DWORD; 
  pszShellExecuteCommand: LPCSTR): HResult; stdcall;
{$EXTERNALSYM SHSetUnreadMailCountA}
function SHSetUnreadMailCountW(pszMailAddress: LPCWSTR; dwCount: DWORD; 
  pszShellExecuteCommand: LPCWSTR): HResult; stdcall;
{$EXTERNALSYM SHSetUnreadMailCountW}

function SHTestTokenMembership(hToken: THandle; ulRID: ULONG): HResult; stdcall;
{$EXTERNALSYM SHTestTokenMembership}

function SHGetImageList(iImageList: Integer; const riid: TGUID; 
  var ppvObj: Pointer): HResult;
{$EXTERNALSYM SHGetImageList}

const
  SHIL_LARGE = 0;           // normally 32x32
  {$EXTERNALSYM SHIL_LARGE}
  SHIL_SMALL = 1;           // normally 16x16
  {$EXTERNALSYM SHIL_SMALL}
  SHIL_EXTRALARGE = 2; 
  {$EXTERNALSYM SHIL_EXTRALARGE}
  SHIL_SYSSMALL = 3;        // like SHIL_SMALL, but tracks system small icon metric correctly
  {$EXTERNALSYM SHIL_SYSSMALL}
  SHIL_JUMBO = 4;           // normally 256x256
  {$EXTERNALSYM SHIL_JUMBO}
  SHIL_LAST = SHIL_JUMBO; 
  {$EXTERNALSYM SHIL_LAST}

// Function call types for ntshrui folder sharing helpers
type
  PFNCANSHAREFOLDERW = function(pszPath: LPCWSTR): HRESULT;
{$EXTERNALSYM PFNCANSHAREFOLDERW}
type
  PFNSHOWSHAREFOLDERUIW = function(hwndParent: HWND; 
    pszPath: LPCWSTR): HRESULT;
{$EXTERNALSYM PFNSHOWSHAREFOLDERUIW}

// API for new Network Address Control

// Instantiation
const
  WC_NETADDRESS = 'msctls_netaddress'; 
  {$EXTERNALSYM WC_NETADDRESS}
function InitNetworkAddressControl: BOOL; stdcall;
{$EXTERNALSYM InitNetworkAddressControl}
// Address Control Messages

type
  // typedef enum NET_ADDRESS_FORMAT_  { // from iphlpapi.h
  //   NET_ADDRESS_FORMAT_UNSPECIFIED = 0,
  //   NET_ADDRESS_DNS_NAME,
  //   NET_ADDRESS_IPV4,
  //   NET_ADDRESS_IPV6
  // } NET_ADDRESS_FORMAT;
  NET_ADDRESS_FORMAT_ = Integer;
  {$EXTERNALSYM NET_ADDRESS_FORMAT_}
  NET_ADDRESS_FORMAT = NET_ADDRESS_FORMAT_;
  {$EXTERNALSYM NET_ADDRESS_FORMAT}
const
  NET_ADDRESS_FORMAT_UNSPECIFIED = 0;
  {$EXTERNALSYM NET_ADDRESS_FORMAT_UNSPECIFIED}
  NET_ADDRESS_DNS_NAME = 1;
  {$EXTERNALSYM NET_ADDRESS_DNS_NAME}
  NET_ADDRESS_IPV4     = 2;
  {$EXTERNALSYM NET_ADDRESS_IPV4}
  NET_ADDRESS_IPV6     = 3;
  {$EXTERNALSYM NET_ADDRESS_IPV6}

type

// from ws2def.h
//#if(_WIN32_WINNT >= 0x0600)
// Address families.
//typedef USHORT ADDRESS_FAMILY;
//#endif//(_WIN32_WINNT >= 0x0600)
  
  ADDRESS_FAMILY = USHORT; { ADDRESS_FAMILI values see in Winapi.Winsock2.pas: AF_xxx }
  {$EXTERNALSYM ADDRESS_FAMILY}
  

// from ws2def.h
//typedef struct {
//    union {
//        struct {
//            ULONG Zone : 28;
//            ULONG Level : 4;
//        };
//        ULONG Value;
//    };
//} SCOPE_ID, *PSCOPE_ID;
  SCOPE_ID = record
    private
      function GetULong(Index: Integer): ULong;
      procedure SetULong(Index: Integer; value1: ULong);
    public
      Value: ULONG;
      property Zone:  ULONG Index $0FFFFFFF read GetULong write SetULong; // mask $0FFFFFFF ( offset 0 )
      property Level: ULONG Index $0000000F read GetULong write SetULong; // mask $0000000F ( offset 28 )
  end;                                       
  {$EXTERNALSYM SCOPE_ID}
  PSCOPE_ID = ^SCOPE_ID;
  {$EXTERNALSYM PSCOPE_ID}

  // from ws2ipdef.h
  // NB: The LH version of sockaddr_in6 has the struct tag sockaddr_in6 rather
  // than sockaddr_in6_lh.  This is to make sure that standard sockets apps
  // that conform to RFC 2553 (Basic Socket Interface Extensions for IPv6).
  //typedef struct sockaddr_in6 {
  //    ADDRESS_FAMILY sin6_family; // AF_INET6.
  //    USHORT sin6_port;           // Transport level port number.
  //    ULONG  sin6_flowinfo;       // IPv6 flow information.
  //    IN6_ADDR sin6_addr;         // IPv6 address.
  //    union {
  //        ULONG sin6_scope_id;     // Set of interfaces for a scope.
  //        SCOPE_ID sin6_scope_struct; 
  //    };
  //} SOCKADDR_IN6_LH, *PSOCKADDR_IN6_LH, FAR *LPSOCKADDR_IN6_LH;
  sockaddr_in6 = record
    private
      function GetULong(Index: Integer): ULong;
      procedure SetULong(Index: Integer; value1: ULong);
    public
      sin6_family:   ADDRESS_FAMILY; // AF_INET6. ADDRESS_FAMILY values see in Winapi.Winsock2.pas: AF_xxx } 
      sin6_port:     USHORT;         // Transport level port number.
      sin6_flowinfo: ULONG;          // IPv6 flow information.
      sin6_addr: IN6_ADDR;           // IPv6 address, IN6_ADDR defined in Winapi.IpExport.pas.
      Value: ULONG;
      property sin6_scope_id: ULONG read Value write Value;
      property Zone:  ULONG Index $0FFFFFFF read GetULong write SetULong; // mask $0FFFFFFF ( offset 0 )
      property Level: ULONG Index $0000000F read GetULong write SetULong; // mask $0000000F ( offset 28 )
  end;
  {$EXTERNALSYM sockaddr_in6}
  SOCKADDR_IN6_LH = sockaddr_in6;
  {$EXTERNALSYM SOCKADDR_IN6_LH}
  PSOCKADDR_IN6_LH = ^SOCKADDR_IN6_LH;
  {$EXTERNALSYM PSOCKADDR_IN6_LH}
  LPSOCKADDR_IN6_LH = ^SOCKADDR_IN6_LH;
  {$EXTERNALSYM LPSOCKADDR_IN6_LH}

  // This struct is defined only for winsock2
  //typedef struct NET_ADDRESS_INFO_ 
  //    NET_ADDRESS_FORMAT Format;
  //    union {
  //      struct {
  //        WCHAR Address[DNS_MAX_NAME_BUFFER_LENGTH];   
  //        WCHAR Port[6];
  //      } NamedAddress;
  //      SOCKADDR_IN  Ipv4Address;
  //      SOCKADDR_IN6 Ipv6Address;
  //      SOCKADDR     IpAddress;
  //    };
  //  } NET_ADDRESS_INFO, *PNET_ADDRESS_INFO;
  NET_ADDRESS_INFO_ = record
    Format: NET_ADDRESS_FORMAT;
    case Integer of
      4:
        (Ipv4Address: SOCKADDR_IN);  // type defined in Winapi.Winsock2.pas (iphlapi.h for winsock2)
      6:
        (Ipv6Address: SOCKADDR_IN6); // type defined in this unit
      1:
        (IpAddress:   SOCKADDR);     // type defined in Winapi.Winsock2.pas
      0:
        (Address: array[0 .. 256-1] of WCHAR;
        Port: array[0 .. 6-1] of WCHAR);
  end;

  {$EXTERNALSYM NET_ADDRESS_INFO_}
  PNET_ADDRESS_INFO_ = ^NET_ADDRESS_INFO_;
  {$EXTERNALSYM PNET_ADDRESS_INFO_}

{$IF not defined(WIN64)}
{$A+}
{$ENDIF}
  PNC_ADDRESS = ^NC_ADDRESS;
  {$EXTERNALSYM PNC_ADDRESS}

  NC_ADDRESS = record
    pAddrInfo: PNET_ADDRESS_INFO_;      // defined in iphlpapi.h
    PortNumber: USHORT;
    PrefixLength: Byte;
  end;
  {$EXTERNALSYM NC_ADDRESS}
  tagNC_ADDRESS = NC_ADDRESS;
  {$EXTERNALSYM tagNC_ADDRESS}
  TNcAddress = NC_ADDRESS;
  PNcAddress = ^TNcAddress;

// NCM_GETADDRESS returns the type of address that is present in the
// control (based on TBD Net Address flags).  If the input string has
// not been validated using this message will force the validation of
// the input string.  The WPARAM is a BOOL to determine to show the
// balloon tip.  The LPARAM is a pointer to the structure to fill in
// with the address type and address string.
const
// constants for NetAddr_... operations
  NCM_GETADDRESS = $0400+1; 
  {$EXTERNALSYM NCM_GETADDRESS}
// NCM_SETALLOWTYPE sets the type of addresses that the control will allow.
// The address flags are defined in iphlpapi.h
  NCM_SETALLOWTYPE = $0400+2; 
  {$EXTERNALSYM NCM_SETALLOWTYPE}
// NCM_GETALLOWTYPE returns the currently allowed type mask.
  NCM_GETALLOWTYPE = $0400+3; 
  {$EXTERNALSYM NCM_GETALLOWTYPE}
// NCM_DISPLAYERRORTIP displays the error balloon tip with the correct
// error string (based on the last failure from the NCM_GETADDRESS call
  NCM_DISPLAYERRORTIP = $0400+4; 
  {$EXTERNALSYM NCM_DISPLAYERRORTIP}

//
// Network String parsing API (for NetAddr_... operations)
//
const
  NET_STRING_IPV4_ADDRESS = $00000001;
  {$EXTERNALSYM NET_STRING_IPV4_ADDRESS}
   // The string identifies an IPv4 Host/router using literal address.
   // (port or prefix not allowed) 
  NET_STRING_IPV4_SERVICE = $00000002;
  {$EXTERNALSYM NET_STRING_IPV4_SERVICE}
   // The string identifies an IPv4 service using literal address.
   // (port required; prefix not allowed) 
  NET_STRING_IPV4_NETWORK = $00000004;
  {$EXTERNALSYM NET_STRING_IPV4_NETWORK}
   // The string identifies an IPv4 network.
   // (prefix required; port not allowed) 
  NET_STRING_IPV6_ADDRESS = $00000008;
  {$EXTERNALSYM NET_STRING_IPV6_ADDRESS}
   // The string identifies an IPv6 Host/router using literal address.
   // (port or prefix not allowed; scope-id allowed) 
  NET_STRING_IPV6_ADDRESS_NO_SCOPE = $00000010;
  {$EXTERNALSYM NET_STRING_IPV6_ADDRESS_NO_SCOPE}
   // The string identifies an IPv6 Host/router using literal address
   // where the interface context is already known.
   // (port or prefix not allowed; scope-id not allowed) 
  NET_STRING_IPV6_SERVICE = $00000020;
  {$EXTERNALSYM NET_STRING_IPV6_SERVICE}
   // The string identifies an IPv6 service using literal address.
   // (port required; prefix not allowed; scope-id allowed) 
  NET_STRING_IPV6_SERVICE_NO_SCOPE = $00000040;
  {$EXTERNALSYM NET_STRING_IPV6_SERVICE_NO_SCOPE}
   // The string identifies an IPv6 service using literal address
   // where the interface context is already known.
   // (port required; prefix not allowed; scope-id not allowed) 
  NET_STRING_IPV6_NETWORK = $00000080;
  {$EXTERNALSYM NET_STRING_IPV6_NETWORK}
   // The string identifies an IPv6 network.
   // (prefix required; port or scope-id not allowed) 
  NET_STRING_NAMED_ADDRESS = $00000100;
  {$EXTERNALSYM NET_STRING_NAMED_ADDRESS}
   // The string identifies an Internet Host using DNS.
   // (port or prefix or scope-id not allowed) 
  NET_STRING_NAMED_SERVICE = $00000200;
  {$EXTERNALSYM NET_STRING_NAMED_SERVICE}
   // The string identifies an Internet service using DNS.
   // (port required; prefix or scope-id not allowed)

  NET_STRING_IP_ADDRESS = NET_STRING_IPV4_ADDRESS or NET_STRING_IPV6_ADDRESS;
  {$EXTERNALSYM NET_STRING_IP_ADDRESS}

  NET_STRING_IP_ADDRESS_NO_SCOPE = NET_STRING_IPV4_ADDRESS or NET_STRING_IPV6_ADDRESS_NO_SCOPE;
  {$EXTERNALSYM NET_STRING_IP_ADDRESS_NO_SCOPE}

  NET_STRING_IP_SERVICE = NET_STRING_IPV4_SERVICE or NET_STRING_IPV6_SERVICE;
  {$EXTERNALSYM NET_STRING_IP_SERVICE}

  NET_STRING_IP_SERVICE_NO_SCOPE = NET_STRING_IPV4_SERVICE or NET_STRING_IPV6_SERVICE_NO_SCOPE;
  {$EXTERNALSYM NET_STRING_IP_SERVICE_NO_SCOPE}

  NET_STRING_IP_NETWORK = NET_STRING_IPV4_NETWORK or NET_STRING_IPV6_NETWORK;
  {$EXTERNALSYM NET_STRING_IP_NETWORK}

  NET_STRING_ANY_ADDRESS = NET_STRING_NAMED_ADDRESS or NET_STRING_IP_ADDRESS;
  {$EXTERNALSYM NET_STRING_ANY_ADDRESS}

  NET_STRING_ANY_ADDRESS_NO_SCOPE = NET_STRING_NAMED_ADDRESS or NET_STRING_IP_ADDRESS_NO_SCOPE;
  {$EXTERNALSYM NET_STRING_ANY_ADDRESS_NO_SCOPE}

  NET_STRING_ANY_SERVICE = NET_STRING_NAMED_SERVICE or NET_STRING_IP_SERVICE;
  {$EXTERNALSYM NET_STRING_ANY_SERVICE}

  NET_STRING_ANY_SERVICE_NO_SCOPE = NET_STRING_NAMED_SERVICE or NET_STRING_IP_SERVICE_NO_SCOPE;
  {$EXTERNALSYM NET_STRING_ANY_SERVICE_NO_SCOPE}

type
  NET_STRING = DWORD;
  {$EXTERNALSYM NET_STRING}

function NetAddr_GetAddress(hwnd: HWND; var pv: NC_ADDRESS): HResult; inline;
{$EXTERNALSYM NetAddr_GetAddress}

function NetAddr_SetAllowType(hwnd: HWND; addrMask: NET_STRING): HResult; inline;
{$EXTERNALSYM NetAddr_SetAllowType}

function NetAddr_GetAllowType(hwnd: HWND): DWORD; inline;
{$EXTERNALSYM NetAddr_GetAllowType}

function NetAddr_DisplayErrorTip(hwnd: HWND): HResult;
{$EXTERNALSYM NetAddr_DisplayErrorTip}

// Returns the type of media (CD, DVD, Blank, etc) that is in the drive.
// dwMediaContent is set to a combination of ARCONTENT flags.
function SHGetDriveMedia(pszDrive: LPCWSTR; 
  var pdwMediaContent: DWORD): HResult; stdcall;
{$EXTERNALSYM SHGetDriveMedia}

implementation

var
  Win32MajorVersion: Integer = 0;
  Win32MinorVersion: Integer = 0;
  Win32Platform: Integer = 0;

function NetAddr_GetAddress(hwnd: HWND; var pv: NC_ADDRESS): HResult;
begin
  Result := HResult(SendMessage(hwnd, NCM_GETADDRESS, 0, LPARAM(@pv)));
end;

function NetAddr_SetAllowType(hwnd: HWND; addrMask: NET_STRING): HResult;
begin
  Result := HResult(SendMessage(hwnd, NCM_SETALLOWTYPE, WPARAM(addrMask), 0));
end;

function NetAddr_GetAllowType(hwnd: HWND): DWORD;
begin
  Result := DWORD(SendMessage(hwnd, NCM_GETALLOWTYPE, 0, 0));
end;

function NetAddr_DisplayErrorTip(hwnd: HWND): HResult;
begin
  Result := HResult(SendMessage(hwnd, NCM_DISPLAYERRORTIP, 0, 0));
end;

function AssocCreateForClasses; external shell32 name 'AssocCreateForClasses' delayed;
function CommandLineToArgvW; external shell32 name 'CommandLineToArgvW';
function DoEnvironmentSubst; external shell32 name 'DoEnvironmentSubstW';
function DoEnvironmentSubstA; external shell32 name 'DoEnvironmentSubstA';
function DoEnvironmentSubstW; external shell32 name 'DoEnvironmentSubstW';
procedure DragAcceptFiles; external shell32 name 'DragAcceptFiles';
procedure DragFinish; external shell32 name 'DragFinish';
function DragQueryFile; external shell32 name 'DragQueryFileW';
function DragQueryFileA; external shell32 name 'DragQueryFileA';
function DragQueryFileW; external shell32 name 'DragQueryFileW';
function DragQueryPoint; external shell32 name 'DragQueryPoint';
function DuplicateIcon; external shell32 name 'DuplicateIcon';
function ExtractAssociatedIcon; external shell32 name 'ExtractAssociatedIconW';
function ExtractAssociatedIconA; external shell32 name 'ExtractAssociatedIconA';
function ExtractAssociatedIconW; external shell32 name 'ExtractAssociatedIconW';
function ExtractAssociatedIconEx; external shell32 name 'ExtractAssociatedIconExW';
function ExtractAssociatedIconExA; external shell32 name 'ExtractAssociatedIconExA';
function ExtractAssociatedIconExW; external shell32 name 'ExtractAssociatedIconExW';
function ExtractIcon; external shell32 name 'ExtractIconW';
function ExtractIconA; external shell32 name 'ExtractIconA';
function ExtractIconW; external shell32 name 'ExtractIconW';
function ExtractIconEx; external shell32 name 'ExtractIconExW';
function ExtractIconExA; external shell32 name 'ExtractIconExA';
function ExtractIconExW; external shell32 name 'ExtractIconExW';
function FindExecutable; external shell32 name 'FindExecutableW';
function FindExecutableA; external shell32 name 'FindExecutableA';
function FindExecutableW; external shell32 name 'FindExecutableW';
function InitNetworkAddressControl; external shell32 name 'InitNetworkAddressControl' delayed;
function IsLFNDrive; external shell32 name 'IsLFNDriveW' delayed;
function IsLFNDriveA; external shell32 name 'IsLFNDriveA' delayed;
function IsLFNDriveW; external shell32 name 'IsLFNDriveW' delayed;
function SHAppBarMessage; external shell32 name 'SHAppBarMessage';
function SHCreateProcessAsUserW; external shell32 name 'SHCreateProcessAsUserW';
function Shell_NotifyIcon; external shell32 name 'Shell_NotifyIconW';
function Shell_NotifyIconA; external shell32 name 'Shell_NotifyIconA';
function Shell_NotifyIconW; external shell32 name 'Shell_NotifyIconW';
function Shell_NotifyIconGetRect; external shell32 name 'Shell_NotifyIconGetRect' delayed;
function ShellAbout; external shell32 name 'ShellAboutW';
function ShellAboutA; external shell32 name 'ShellAboutA';
function ShellAboutW; external shell32 name 'ShellAboutW';
function ShellExecute; external shell32 name 'ShellExecuteW';
function ShellExecuteA; external shell32 name 'ShellExecuteA';
function ShellExecuteW; external shell32 name 'ShellExecuteW';
function ShellExecuteEx; external shell32 name 'ShellExecuteExW';
function ShellExecuteExA; external shell32 name 'ShellExecuteExA';
function ShellExecuteExW; external shell32 name 'ShellExecuteExW';
function ShellMessageBox; external shell32 name 'ShellMessageBoxW';
function ShellMessageBoxA; external shell32 name 'ShellMessageBoxA';
function ShellMessageBoxW; external shell32 name 'ShellMessageBoxW';
function SHEmptyRecycleBin; external shell32 name 'SHEmptyRecycleBinW';
function SHEmptyRecycleBinA; external shell32 name 'SHEmptyRecycleBinA';
function SHEmptyRecycleBinW; external shell32 name 'SHEmptyRecycleBinW';
function SHEnumerateUnreadMailAccounts; external shell32 name 'SHEnumerateUnreadMailAccountsW' delayed;
function SHEnumerateUnreadMailAccountsA; external shell32 name 'SHEnumerateUnreadMailAccountsA' delayed;
function SHEnumerateUnreadMailAccountsW; external shell32 name 'SHEnumerateUnreadMailAccountsW' delayed;
function SHEvaluateSystemCommandTemplate; external shell32 name 'SHEvaluateSystemCommandTemplate' delayed;
function SHFileOperation; external shell32 name 'SHFileOperationW';
function SHFileOperationA; external shell32 name 'SHFileOperationA';
function SHFileOperationW; external shell32 name 'SHFileOperationW';
procedure SHFreeNameMappings; external shell32 name 'SHFreeNameMappings';
function SHGetDiskFreeSpace; external shell32 name 'SHGetDiskFreeSpaceExW';
function SHGetDiskFreeSpaceA; external shell32 name 'SHGetDiskFreeSpaceExA';
function SHGetDiskFreeSpaceW; external shell32 name 'SHGetDiskFreeSpaceExW';
function SHGetDiskFreeSpaceEx; external shell32 name 'SHGetDiskFreeSpaceExW';
function SHGetDiskFreeSpaceExA; external shell32 name 'SHGetDiskFreeSpaceExA';
function SHGetDiskFreeSpaceExW; external shell32 name 'SHGetDiskFreeSpaceExW';
function SHGetDriveMedia; external shell32 name 'SHGetDriveMedia' delayed;
function SHGetImageList; external shell32 name 'SHGetImageList' delayed;
function SHGetLocalizedName; external shell32 name 'SHGetLocalizedName' delayed;
function SHGetFileInfo; external shell32 name 'SHGetFileInfoW';
function SHGetFileInfoA; external shell32 name 'SHGetFileInfoA';
function SHGetFileInfoW; external shell32 name 'SHGetFileInfoW';
function SHGetNewLinkInfo; external shell32 name 'SHGetNewLinkInfoW';
function SHGetNewLinkInfoA; external shell32 name 'SHGetNewLinkInfoA';
function SHGetNewLinkInfoW; external shell32 name 'SHGetNewLinkInfoW';
function SHGetPropertyStoreForWindow; external shell32 name 'SHGetPropertyStoreForWindow' delayed;
function SHGetStockIconInfo; external shell32 name 'SHGetStockIconInfo' delayed;
function SHGetUnreadMailCount; external shell32 name 'SHGetUnreadMailCountW' delayed;
function SHGetUnreadMailCountA; external shell32 name 'SHGetUnreadMailCountA' delayed;
function SHGetUnreadMailCountW; external shell32 name 'SHGetUnreadMailCountW' delayed;
function SHInvokePrinterCommand; external shell32 name 'SHInvokePrinterCommandW';
function SHInvokePrinterCommandA; external shell32 name 'SHInvokePrinterCommandA';
function SHInvokePrinterCommandW; external shell32 name 'SHInvokePrinterCommandW';
function SHIsFileAvailableOffline; external shell32 name 'SHIsFileAvailableOffline';
function SHLoadNonloadedIconOverlayIdentifiers; external shell32 name 'SHLoadNonloadedIconOverlayIdentifiers';
function SHQueryRecycleBin; external shell32 name 'SHQueryRecycleBinW'
function SHQueryRecycleBinA; external shell32 name 'SHQueryRecycleBinA'
function SHQueryRecycleBinW; external shell32 name 'SHQueryRecycleBinW'
function SHQueryUserNotificationState; external shell32 name 'SHQueryUserNotificationState' delayed;
function SHRemoveLocalizedName; external shell32 name 'SHRemoveLocalizedName' delayed;
function SHSetLocalizedName; external shell32 name 'SHSetLocalizedName' delayed;
function SHSetUnreadMailCount; external shell32 name 'SHSetUnreadMailCountW' delayed;
function SHSetUnreadMailCountA; external shell32 name 'SHSetUnreadMailCountA' delayed;
function SHSetUnreadMailCountW; external shell32 name 'SHSetUnreadMailCountW' delayed;
function SHTestTokenMembership; external shell32 name 'SHTestTokenMembership';

procedure InitVersionInfo;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
    with OSVersionInfo do
    begin
      Win32Platform := dwPlatformId;
      Win32MajorVersion := dwMajorVersion;
      Win32MinorVersion := dwMinorVersion;
    end;
end;

class constructor _NOTIFYICONDATAA.Create;
begin
  InitVersionInfo;
end;

class function _NOTIFYICONDATAA.SizeOf: Integer;
begin
  if Win32MajorVersion >= 6 then
    // Size of complete structure
    Result := System.SizeOf(_NOTIFYICONDATAA)
  else
    // Platforms prior to Vista do not recognize the fields guidItem and hBalloonIcon
    Result := System.SizeOf(_NOTIFYICONDATAA) - System.SizeOf(TGUID) - System.SizeOf(Winapi.Windows.HICON);
end;

class constructor _NOTIFYICONDATAW.Create;
begin
  InitVersionInfo;
end;

class function _NOTIFYICONDATAW.SizeOf: Integer;
begin
  if Win32MajorVersion >= 6 then
    // Size of complete structure
    Result := System.SizeOf(_NOTIFYICONDATAW)
  else
    // Platforms prior to Vista do not recognize the fields guidItem and hBalloonIcon
    Result := System.SizeOf(_NOTIFYICONDATAW) - System.SizeOf(TGUID) - System.SizeOf(Winapi.Windows.HICON);
end;

// Here Index=Mask is only $0FFFFFFF (offset=0) or $0000000F (offset=28)
function SCOPE_ID.GetULong(Index: Integer): ULONG;
begin
  if Index = $0000000F then
    Result := Value shr 28
  else
    Result := Value and Index;
end;
procedure SCOPE_ID.SetULong(Index: Integer; value1: ULong);
begin
  if Index = $0000000F then // Index=Mask=$0000000F, offset=28
    Value := (Value and $0FFFFFFF) or (value1 shl 28)
  else // Index=Mask=$0FFFFFFF, offset=0
    Value := (Value and $F0000000) or (value1 and $0FFFFFFF);
end;

// Here Index=Mask is only $0FFFFFFF (offset=0) or $0000000F (offset=28)
function sockaddr_in6.GetULong(Index: Integer): ULONG;
begin
  if Index = $0000000F then
    Result := Value shr 28
  else
    Result := Value and Index;
end;
procedure sockaddr_in6.SetULong(Index: Integer; value1: ULong);
begin
  if Index = $0000000F then // Index=Mask=$0000000F, offset=28
    Value := (Value and $0FFFFFFF) or (value1 shl 28)
  else // Index=Mask=$0FFFFFFF, offset=0
    Value := (Value and $F0000000) or (value1 and $0FFFFFFF);
end;



end.
