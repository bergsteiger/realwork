{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

05/02/2003

 Added some undocummented shell api functions.
 Increased perfomance for cached images (TElShellIconCache).
 Removed large icon cache.

*)

unit ElShellUtils;

interface

uses Windows,
     ComObj,
     ActiveX,
     ShellAPI,
     Registry,
     Graphics,
     ShlObj,

     CommCtrl,
     Controls,
     {$ifdef VCL_4_USED}
     ImgList,
     {$else}
     Menus,   // TShortCut =
     {$endif}
     Classes,
     SysUtils,
     Forms,
     {$ifdef VCL_6_USED}
     Types,
     {$endif}
     ElList,
     {$IFDEF MSWINDOWS}
     {$IFNDEF D_2}
     {$IFDEF BUILDER_USED}
     ElInprocHookAPI,
     {$ENDIF}
     {$ENDIF}
     {$ENDIF}
     ElTools,
     ElStrUtils,
     ElVCLUtils;

type

  TShellFolders =
     (sfoDesktopExpanded,sfoDesktop,sfoPrograms, sfoControlPanel,
      sfoPrinters,sfoPersonal,sfoFavorites,sfoStartup,sfoRecent,
      sfoSendto,sfoRecycleBin,sfoStartMenu,sfoDesktopDirectory,
      sfoMyComputer,
      sfoNetwork,sfoNetworkNeighborhood,sfoFonts,sfoTemplates,
      // sfoCommon is available starting from NT 4
      sfoCommonStartMenu, sfoCommonPrograms, sfoCommonStartup,
      sfoCommonDesktopDirectory, sfoAppData, sfoPrintHood,

      // other:
      sfoAltStartUp, sfoCommonAltStartUp, sfoCommonFavorites,
      sfoInternetCache, sfoCookies, sfoHistory,

      sfoCustom);

  TShellAttr =
     {$ifdef VCL_4_USED}
         Cardinal
     {$else}
       {$ifdef B_3_UP}
         Cardinal
       {$else}
         Integer
       {$endif}
     {$endif}
  ;

{$ifndef VCL_3_USED}
{$ifndef D_2}
{$HPPEMIT 'typedef UNALIGNED _ITEMIDLIST * LPITEMIDLIST;'}
{$HPPEMIT 'typedef const UNALIGNED _ITEMIDLIST * LPCITEMIDLIST;'}
{$HPPEMIT 'typedef struct _STRRET'}
{$HPPEMIT '{'}
{$HPPEMIT '    UINT uType; // One of the STRRET_* values'}
{$HPPEMIT '    union'}
{$HPPEMIT '    {'}
{$HPPEMIT '        LPWSTR          pOleStr;        // must be freed by caller of GetDisplayNameOf'}
{$HPPEMIT '        LPSTR           pStr;           // NOT USED'}
{$HPPEMIT '        UINT            uOffset;        // Offset into SHITEMID'}
{$HPPEMIT '        char            cStr[MAX_PATH]; // Buffer to fill in (ANSI)'}
(*$HPPEMIT '    } DUMMYUNIONNAME;'*)
(*$HPPEMIT '} STRRET, *LPSTRRET;'*)

{$HPPEMIT 'typedef struct {}
{$HPPEMIT '    GUID fmtid;'}
{$HPPEMIT '    DWORD pid;'}
(*$HPPEMIT '} SHCOLUMNID, *LPSHCOLUMNID;'*)

{$HPPEMIT 'typedef const SHCOLUMNID* LPCSHCOLUMNID;'}

{$HPPEMIT 'typedef SHCOLUMNID *PShColumnID;'}

{$HPPEMIT 'typedef struct _SHELLDETAILS'}
(*$HPPEMIT '{'*)
{$HPPEMIT '    int     fmt;            // LVCFMT_* value (header only)'}
{$HPPEMIT '    int     cxChar;         // Number of "average" characters (header only)'}
{$HPPEMIT '    STRRET  str;            // String information'}
(*$HPPEMIT '} SHELLDETAILS, *LPSHELLDETAILS;'*)

{$HPPEMIT 'typedef _SHELLDETAILS *PShellDetails;'}

{$HPPEMIT 'typedef _SHELLDETAILS  TShellDetails;'}

{$HPPEMIT 'DECLARE_INTERFACE_(IShellFolder, IUnknown)'}
{$HPPEMIT '{'}
{$HPPEMIT '    // *** IUnknown methods ***'}
{$HPPEMIT '    STDMETHOD(QueryInterface) (THIS_ REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD_(ULONG,AddRef) (THIS)  PURE;'}
{$HPPEMIT '    STDMETHOD_(ULONG,Release) (THIS) PURE;'}
{$HPPEMIT ''}
{$HPPEMIT '    // *** IShellFolder methods ***'}
{$HPPEMIT '    STDMETHOD(ParseDisplayName)(THIS_ HWND hwnd, LPBC pbc, LPOLESTR pszDisplayName,'}
{$HPPEMIT '                                ULONG *pchEaten, LPITEMIDLIST *ppidl, ULONG *pdwAttributes) PURE;'}
{$HPPEMIT ''}
{$HPPEMIT '    STDMETHOD(EnumObjects)(THIS_ HWND hwnd, DWORD grfFlags, IEnumIDList **ppenumIDList) PURE;'}
{$HPPEMIT ''}
{$HPPEMIT '    STDMETHOD(BindToObject)(THIS_ LPCITEMIDLIST pidl, LPBC pbc, REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(BindToStorage)(THIS_ LPCITEMIDLIST pidl, LPBC pbc, REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(CompareIDs)(THIS_ LPARAM lParam, LPCITEMIDLIST pidl1, LPCITEMIDLIST pidl2) PURE;'}
{$HPPEMIT '    STDMETHOD(CreateViewObject)(THIS_ HWND hwndOwner, REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(GetAttributesOf)(THIS_ UINT cidl, LPCITEMIDLIST * apidl, ULONG * rgfInOut) PURE;'}
{$HPPEMIT '    STDMETHOD(GetUIObjectOf)(THIS_ HWND hwndOwner, UINT cidl, LPCITEMIDLIST * apidl,'}
{$HPPEMIT '                             REFIID riid, UINT * prgfInOut, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(GetDisplayNameOf)(THIS_ LPCITEMIDLIST pidl, DWORD uFlags, LPSTRRET lpName) PURE;'}
{$HPPEMIT '    STDMETHOD(SetNameOf)(THIS_ HWND hwnd, LPCITEMIDLIST pidl, LPCOLESTR pszName,'}
{$HPPEMIT '                         DWORD uFlags, LPITEMIDLIST *ppidlOut) PURE;'}
(*$HPPEMIT '};'*)

{$HPPEMIT 'typedef IShellFolder * LPSHELLFOLDER;'}

{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IEnumExtraSearch);'}
{$endif}
{$endif}

{$ifndef D_2}

{$ifndef VCL_4_USED}
const
  INFOTIPSIZE = 1024;
type
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM IContextMenu2}
  {$ENDIF}
  IContextMenu2 = interface(IContextMenu)
    [SID_IContextMenu2]
    function HandleMenuMsg(uMsg: UINT; WParam, LParam: Integer): HResult; stdcall;
  end;
{$endif}

function  GetParentPIDL(PIDL: PItemIDList): PItemIDList;
function  GetOwnPIDL(PIDL: PItemIDList): PItemIDList;
function  GetItemIDOnly(PIDL: PItemIDList): PItemIDList;
function GetNextItemID(PIDL: PItemIDList): PItemIDList;
function  GetEmptyPIDL: PItemIDList;
function  PIDLContainsAt(PIDL, SubPIDL: PItemIDList; Pos: Integer): Boolean;
function  PIDLStartsWith(PIDL, SubPIDL: PItemIDList): Boolean;
function GetLastPIDL(PIDL: PItemIDList): PItemIDList;
function GetDesktopFolder: IShellFolder;
function GetShellMalloc: IMalloc;
function GetShellFolder(PIDL: PItemIDList): IShellFolder;
function GetParentFolder(PIDL: PItemIDList): IShellFolder;
function GetPIDLTypeName(PIDL: PItemIDList): String;

function  AppendPIDL(ParentPIDL, ChildPIDL: PItemIDList): PItemIDList;
function  ClonePIDL(PIDL: PItemIDList): PItemIDList;
function  GetFolderPIDL(FolderID: TShellFolders; const CustomName: String): PItemIDList;
function GetFolderPIDL2(FolderID: TShellFolders; const CustomName: String): PItemIDList;
function  CalcPIDLSize(PIDL: PItemIDList): Integer;
function  CompareIDLists(IDList1, IDList2: PItemIDList): Boolean;
procedure FreeIDList(var PIDL: PItemIDList);
function  GetPathFromPIDL(PIDL: PItemIDList; var Path: String): Boolean;
function  GetPathFromPIDL2(PIDL: PItemIDList): String;
function  GetPIDLFromPath(const Path: String): PItemIDList;
function SHGetPIDLFromPath(const ShellFolder:IShellFolder; const Path: String): PItemIDList;
function  StrRetToPas(const str: TStrRet; PIDL: PItemIDList): String;
procedure StrRetFree(const str: TStrRet);
function  IsDesktopPIDL(PIDL: PItemIDList): Boolean;
function ShellExecutePIDL(PIDL: PItemIDList): Boolean;
function ExecutePIDLContextMenuVerb(Handle: THandle; RelativePIDL: PItemIDList;
  const ParentFolder: IShellFolder; const Verb: String):Boolean;

{$endif ifndef D_2}

function FireURL (const URL: String): Boolean;

{$ifndef D_2}

// This mode is not recommended to usage:
{.$define _DoNotUseSystemCache_} // When it is used local cache of applications. It is slower mode !!!

type

  TElShellIconCache = class
  private
    FSmallImages  :TImageList;
    {$ifdef _DoNotUseSystemCache_}
    FNames        :TElList;
    DefSmallIcon  :HICON;
    procedure OnItemDelete(Sender: TObject; Item: Pointer);
    {$endif}
  public
    constructor Create;
    destructor Destroy; override;
    function AddFromPIDL(PIDL: PItemIDList; Flags: TShellAttr; OpenIcon: Boolean): Integer;
    property SmallImages: TImageList read FSmallImages;
  end;

function ShellIconCache: TElShellIconCache;

function GetCompressedColor: Integer;

const

  SID_IShellDetails       = '{000214EC-0000-0000-C000-000000000046}';
  SID_IShellFolder2       = '{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}';
  SID_IEnumExtraSearch    = '{0e700be1-9db6-11d1-A1CE-00C04FD75D13}';

  IID_IShellDetails:TGUID = '{000214EC-0000-0000-C000-000000000046}';
  IID_IShellFolder2:TGUID = '{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}';

type

  {$ifdef VCL_5_USED}
  {$EXTERNALSYM PExtraSearch}
  {$endif}
  PExtraSearch = ^TExtraSearch;
  {$ifdef VCL_5_USED}
  {$EXTERNALSYM tagExtraSearch}
  {$endif}
  tagExtraSearch = record
    guidSearch       :TGUID;
    wszFriendlyName,
    wszMenuText      :array[0..79] of WideChar;
    wszHelpText      :array[0..MAX_PATH] of WideChar;
    wszUrl           :array[0..2047] of WideChar;
    wszIcon,
    wszGreyIcon,
    wszClrIcon       :array[0..MAX_PATH+10] of WideChar;
  end;
  {$ifdef VCL_5_USED}
  {$EXTERNALSYM TExtraSearch}
  {$endif}
  TExtraSearch = tagExtraSearch;

  PShColumnID = ^TShColumnID;
  {$ifdef VCL_5_USED}
  {$EXTERNALSYM SHCOLUMNID}
  {$endif}
  SHCOLUMNID = record
    fmtid :TGUID;
    pid   :DWORD;
  end;
  {$ifdef VCL_5_USED}
  {$EXTERNALSYM TShColumnID}
  {$endif}
  TShColumnID = SHCOLUMNID;

  PShellDetails = ^TShellDetails;
  {$ifdef VCL_5_USED}
  {$EXTERNALSYM _SHELLDETAILS}
  {$endif}
  _SHELLDETAILS = record
    fmt,
    cxChar :Integer;
    str    :TSTRRET;
  end;
  TShellDetails = _SHELLDETAILS;
  {$ifdef VCL_5_USED}
  {$EXTERNALSYM SHELLDETAILS}
  {$endif}
  SHELLDETAILS = _SHELLDETAILS;

  {$ifdef VCL_5_USED}
  {$EXTERNALSYM IEnumExtraSearch}
  {$endif}
  IEnumExtraSearch = interface(IUnknown)
    [SID_IEnumExtraSearch]
    function Next(celt: ULONG; out rgelt: PExtraSearch; out pceltFetched: ULONG): HResult; stdcall;
    function Skip(celt: ULONG): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppEnum: IEnumExtraSearch): HResult; stdcall;
  end;

  {$ifdef VCL_3_USED}
  POleVariant = ^OleVariant;
  {$endif}

  IShellFolder2 = interface(IShellFolder)
    [SID_IShellFolder2]
    function GetDefaultSearchGUID(out pguid: TGUID): HResult; stdcall;
    function EnumSearches(out ppEnum: IEnumExtraSearch): HResult; stdcall;
    function GetDefaultColumn(dwRes: DWORD; var pSort: ULONG;
      var pDisplay: ULONG): HResult; stdcall;
    function GetDefaultColumnState(iColumn: UINT; var pcsFlags: DWORD): HResult; stdcall;
    function GetDetailsEx(pidl: PItemIDList; const pscid: SHCOLUMNID;
      pv: POleVariant): HResult; stdcall;
    function GetDetailsOf(pidl: PItemIDList; iColumn: UINT;
      var psd: TShellDetails): HResult; stdcall;
    function MapNameToSCID(pwszName: LPCWSTR; var pscid: TShColumnID): HResult; stdcall;
  end;

  IShellDetails = interface(IUnknown)
    [SID_IShellDetails]
    function GetDetailsOf(pidl: PItemIDList; iColumn: UINT;
      var pDetails: TShellDetails): HResult; stdcall;
    function ColumnClick(iColumn: UINT): HResult; stdcall;
  end;

{$IFDEF MSWINDOWS}


  PSHChangeNotifyEntry = ^TSHChangeNotifyEntry;
  TSHChangeNotifyEntry = packed record
    PIDL       :PItemIDList;
    fRecursive :BOOL;
  end;

  PSHDwordItemID = ^TSHDwordItemID;
  TSHDwordItemID = packed record
    dwItem1  :Pointer; //DWORD
    dwItem2  :Pointer; //DWORD
  end;

  PSHChangeDWORDAsIDList = ^TSHChangeDWORDAsIDList;
  TSHChangeDWORDAsIDList = packed record
    cb       :SHORT; // USHORT
    dwItem1  :DWORD;
    dwItem2  :DWORD;
    cbZero   :SHORT;  // USHORT
  end;

const

 SHCNF_ACCEPT_INTERRUPTS      = $0001;
 SHCNF_ACCEPT_NON_INTERRUPTS  = $0002;
 SHCNF_NO_PROXY               = $8000; // WinNT Only

var
  WM_SHCHANGENOTIFY : UINT;// ID = '{7EC0A8B0-F3CF-41E3-9345-C004F94A673F}'

type
  TSHChangeNotifyRegister = function (hWnd: HWND; fSources: DWORD; wEventMask: Cardinal;
    wMsg: UINT; cEntries: DWORD; const Items: TSHChangeNotifyEntry): ULONG; stdcall;
  TSHChangeNotifyDeregister = function (hNotify: ULONG): BOOL; stdcall;

function SHChangeNotifyRegister(hWnd: HWND; fSources: DWORD; wEventMask: Cardinal;
    wMsg: UINT; cEntries: DWORD; const Items: TSHChangeNotifyEntry): ULONG; stdcall;
function SHChangeNotifyDeregister(hNotify: ULONG): BOOL; stdcall;

function SetAutoComplete(Handle: THandle; bFileSystem, bURL: Boolean): Boolean;
function GetModule(const ModuleName: string): HMODULE;

function ElCreateShellLinkA(const sFileName, sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: string; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;

function ElCreateShellLinkW(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;

function ElCreateShellLink(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TElFString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;

function ElReadShellLinkA(const wsFileName: WideString; var sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: string; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;

function ElReadShellLinkW(const wsFileName: TElFString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TElFString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;

function ElReadShellLink(const wsFileName: TElFString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TElFString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;

{$ENDIF IFDEF MSWINDOWS}

{$endif ifndef D_2}

implementation

{$ifndef D_2}

const
{$IFDEF MSWINDOWS}
  shell32 = 'shell32.dll';
  shlwapi = 'shlwapi.dll';
{$ENDIF}
{$IFDEF LINUX}
  //shell32 = 'libshell32.borland.so';
{$ENDIF}

{$IFDEF MSWINDOWS}

const
  idxSHChangeNotifyRegister = 2;
  idxSHChangeNotifyDeregister = 4;

{$IFNDEF BUILDER_USED}
{$warnings off}
function SHChangeNotifyRegister(hWnd: HWND; fSources: DWORD; wEventMask: Cardinal;
    wMsg: UINT; cEntries: DWORD; const Items: TSHChangeNotifyEntry): ULONG; stdcall;
     external shell32 index idxSHChangeNotifyRegister;

function SHChangeNotifyDeregister(hNotify: ULONG): BOOL; stdcall;
     external shell32 index idxSHChangeNotifyDeregister;
{$warnings on}
{$ELSE}
var
  _SHChangeNotifyRegister: TSHChangeNotifyRegister;
  _SHChangeNotifyDeregister :TSHChangeNotifyDeregister;

function SHChangeNotifyRegister(hWnd: HWND; fSources: DWORD; wEventMask: Cardinal;
    wMsg: UINT; cEntries: DWORD; const Items: TSHChangeNotifyEntry): ULONG; stdcall;
var
  hShell32: THandle;
begin
  Result := 0;
  if @_SHChangeNotifyRegister=nil then
  begin
    hShell32 := GetModuleHandle(shell32);
    if hShell32=0 then
      hShell32 := SafeLoadLibrary(shell32);
    if hShell32=0 then
      exit;
    _SHChangeNotifyRegister := GetProcAddressETAOrd(hShell32, idxSHChangeNotifyRegister);
  end;
  if @_SHChangeNotifyRegister<>nil then
    Result := _SHChangeNotifyRegister(hWnd, fSources, wEventMask, wMsg, cEntries, Items);
end;

function SHChangeNotifyDeregister(hNotify: ULONG): BOOL; stdcall;
var
  hShell32: THandle;
begin
  Result := False;
  if @_SHChangeNotifyDeregister=nil then
  begin
    hShell32 := GetModuleHandle(shell32);
    if hShell32=0 then
      hShell32 := SafeLoadLibrary(shell32);
    if hShell32=0 then
      exit;
    _SHChangeNotifyDeregister := GetProcAddressETAOrd(hShell32, idxSHChangeNotifyDeregister);
  end;
  if @_SHChangeNotifyDeregister<>nil then
    Result := _SHChangeNotifyDeregister(hNotify);
end;
{$ENDIF}
{$ENDIF}

var

  ShellMalloc        :IMalloc;
  ShellDesktopFolder :IShellFolder;
  vShellIconCache    :TElShellIconCache;

const

  {$ifndef D_4UP}
  CSIDL_ALTSTARTUP        = $001D;
  CSIDL_COMMON_ALTSTARTUP = $001E;
  CSIDL_COMMON_FAVORITES  = $001F;
  CSIDL_INTERNET_CACHE    = $0020;
  CSIDL_COOKIES           = $0021;
  CSIDL_HISTORY           = $0022;
  {$endif}

  ShellFolderIDs: array[TShellFolders] of Integer=
   ($FEFE {cfoDesktopExpanded}, CSIDL_DESKTOP,
    CSIDL_PROGRAMS, CSIDL_CONTROLS, CSIDL_PRINTERS, CSIDL_PERSONAL, CSIDL_FAVORITES,
    CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_BITBUCKET, CSIDL_STARTMENU,
    CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_NETWORK, CSIDL_NETHOOD, CSIDL_FONTS,
    CSIDL_TEMPLATES,
    { CSIDL_COMMON_* is for NT 4.0+ }
    CSIDL_COMMON_STARTMENU, CSIDL_COMMON_PROGRAMS, CSIDL_COMMON_STARTUP,
    CSIDL_COMMON_DESKTOPDIRECTORY, CSIDL_APPDATA, CSIDL_PRINTHOOD,

    // other:
    CSIDL_ALTSTARTUP,  CSIDL_COMMON_ALTSTARTUP, CSIDL_COMMON_FAVORITES,
    CSIDL_INTERNET_CACHE, CSIDL_COOKIES, CSIDL_HISTORY,

    -1
    );

function GetFolderPIDL(FolderID: TShellFolders; const CustomName: String): PItemIDList;
begin
  if FolderID = sfoDesktopExpanded then
    FolderID := sfoDesktop;
  Result := GetFolderPIDL2(FolderID, CustomName);
end;

function GetFolderPIDL2(FolderID: TShellFolders; const CustomName: String): PItemIDList;
begin
  if FolderID = sfoCustom then
  begin
    if Length(CustomName)>0 then
      Result := GetPIDLFromPath(CustomName)
    else
      Result := nil;
  end
  else
  begin
    Result := nil;
    if (not Succeeded(SHGetSpecialFolderLocation(0, ShellFolderIDs[FolderID], Result))) and
       Assigned(Result)
    then
      FreeIDList(Result);
  end;
end;

procedure FreeIDList(var PIDL: PItemIDList);
begin
  if (PIDL<>nil)and Assigned(ShellMalloc) then
  begin
    if ShellMalloc.DidAlloc(PIDL) = 1 then
       ShellMalloc.Free(PIDL);
    PIDL := nil;
  end;
end;

function GetPathFromPIDL(PIDL: PItemIDList; var Path: String): Boolean;
  var
    APath: array [0..MAX_PATH] of char;
begin
  if PIDL=nil then
  begin
    Path := '';
    Result := False;
    exit;
  end;
  Result := SHGetPathFromIDList(PIDL, @APath);
  if Result then
    Path := StrPas(@APath)
  else
    Path := '';
end;

function  GetPathFromPIDL2(PIDL: PItemIDList): String;
begin
  GetPathFromPIDL(PIDL, Result);
end;

function GetPIDLFromPath(const Path: String): PItemIDList;
begin
  Result := SHGetPIDLFromPath(GetDesktopFolder, Path);
end;

function SHGetPIDLFromPath(const ShellFolder: IShellFolder; const Path: String): PItemIDList;
  var
    WSP             :PWideChar;
    Eaten, Attribs  :TShellAttr;
begin
  Result := nil;
  if (ShellFolder=nil) or (Length(Path)=0) then
    exit;
  GetMem(WSP, (Length(Path)+1) * SizeOf(WideChar));
  StringToWideChar(Path, WSP, (Length(Path)+1) * SizeOf(WideChar));
  Attribs := 0;
  Eaten := 0;
  if not Succeeded(ShellFolder.ParseDisplayName(0, nil, WSP, Eaten, Result, Attribs)) then
    FreeIDList(Result);
  FreeMem(WSP);
end;

function IsDesktopPIDL(PIDL :PItemIDList):Boolean;
begin
  Result := (PIDL<>nil) and (PIDL.mkid.cb = 0);
end;

function StrRetToPas(const str: TStrRet; PIDL: PItemIDList): String;
begin
  case Str.uType of
    STRRET_CSTR:
      Result := StrPas(@Str.cStr);
    STRRET_OFFSET:
      Result := StrPas(PChar(PIDL) + Str.uOffset);
    STRRET_WSTR:
      if Assigned(Str.pOLEStr) then
        Result := WideCharToString(Str.pOLEStr)
      else
        Result := '';
    else
        Result := '';
  end;
end;

function ShellExecutePIDL(PIDL: PItemIDList): Boolean;
  var
    ShellExecuteInfo: TShellExecuteInfo;
begin
  if PIDL=nil then
  begin
    Result := False;
    exit;
  end;
  FillChar(ShellExecuteInfo, SizeOf(ShellExecuteInfo), 0);
  with ShellExecuteInfo do
  begin
    cbSize := SizeOf(ShellExecuteInfo);
    wnd := Application.Handle;
    fMask := SEE_MASK_IDLIST or SEE_MASK_INVOKEIDLIST;
    lpIDList := PIDL;
    nShow := SW_SHOW;
  end;
  Result := ShellExecuteEx(@ShellExecuteInfo);
end;

function GetPIDLTypeName(PIDL: PItemIDList): String;
  var
    FileInfo: TSHFileInfo;
begin
  if PIDL=nil then
  begin
    Result := '';
    exit;
  end;
  SHGetFileInfo(PChar(PIDL), 0, FileInfo, SizeOf(FileInfo),
    SHGFI_PIDL or SHGFI_TYPENAME);
  Result := FileInfo.szTypeName;
end;

function GetLastPIDL(PIDL: PItemIDList): PItemIDList;
begin
  repeat
    Result := PIDL;
    PIDL := GetNextItemID(Result);
  until (PIDL=nil) or (PIDL^.mkid.cb = 0);
end;

function GetDesktopFolder: IShellFolder;
begin
  if not Assigned(ShellDesktopFolder) then
    SHGetDesktopFolder(ShellDesktopFolder);
  Result := ShellDesktopFolder;
end;

function GetShellMalloc: IMalloc;
begin
  if not Assigned(ShellMalloc) then
    SHGetMalloc(ShellMalloc);
  Result := ShellMalloc;
end;

function GetShellFolder(PIDL: PItemIDList): IShellFolder;
begin
  if IsDesktopPIDL(PIDL) then
    Result := GetDesktopFolder
  else
  begin
    Result := nil;
    if PIDL<>nil then
      GetDesktopFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(Result));
  end;
end;

procedure StripLastPIDL(PIDL: PItemIDList);
begin
  if Assigned(PIDL) then
    GetLastPIDL(PIDL)^.mkid.cb := 0;
end;

function GetParentFolder(PIDL: PItemIDList): IShellFolder;
var
  PrevPIDL: PItemIDList;
begin
  PrevPIDL := ClonePIDL(PIDL);
  try
    StripLastPIDL(PrevPIDL);
    Result := GetShellFolder(PrevPIDL);
  finally
    FreeIDList(PrevPIDL);
  end;
end;

function ExecutePIDLContextMenuVerb(Handle: THandle; RelativePIDL: PItemIDList;
  const ParentFolder: IShellFolder; const Verb: String): Boolean;
  var
    ContextMenu: IContextMenu;
    CMICI: TCMInvokeCommandInfo;
begin
  Result := Assigned(RelativePIDL) and (Length(Verb)>0);
  if not Result then
    exit;
  Result := ParentFolder.GetUIObjectOf(Handle, 1, RelativePIDL,
    IID_IContextMenu, nil, Pointer(ContextMenu)) = S_OK;
  if Result then
  begin
    FillChar(CMICI, SizeOf(CMICI), 0);
    with CMICI do
    begin
      cbSize := SizeOf(CMICI);
      hWnd := Handle;
      lpVerb := PChar(Verb);
      nShow := SW_SHOWNORMAL;
    end;
    Result := ContextMenu.InvokeCommand(CMICI) = S_OK;
  end;
end;

procedure StrRetFree(const str: TStrRet);
begin
  if (Str.uType = STRRET_WSTR) and (Str.pOLEStr <> nil) then
    CoTaskMemFree(Str.pOleStr);
end;

type

  TElShellIconCacheEntry = record
    Name  :PChar;
    Idx   :Integer;
  end;
  PElShellIconCacheEntry = ^TElShellIconCacheEntry;

constructor TElShellIconCache.Create;
  var
  {$ifdef _DoNotUseSystemCache_}
    Fl       :TShellAttr;
    FI       :TSHFileInfo;
    Flags    :Integer;
  const
    Mask     :array[Boolean] of Longint = (0, ILC_MASK);
  {$else}
    FileInfo :TSHFileInfo;
  {$endif}
begin
  inherited;
  FSmallImages := TImageList.Create(nil);
  {$ifdef _DoNotUseSystemCache_}
  FSmallImages.Width := GetSystemMetrics(SM_CXSMICON);
  FSmallImages.Height := GetSystemMetrics(SM_CYSMICON);

  Flags := Mask[FSmallImages.Masked];
  if IsWinXPUp then
    Flags := Flags or ILC_COLOR32
  else
    Flags := Flags or ILC_COLORDDB;

  FSmallImages.Handle := ImageList_Create(FSmallImages.Width, FSmallImages.Height, Flags, 16, 16);
  {$else}
  FSmallImages.ShareImages := True;
  FSmallImages.Handle := SHGetFileInfo(
    '', 0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  {$endif}
  FSmallImages.DrawingStyle := dsTransparent;

  {$ifdef _DoNotUseSystemCache_}
  FNames := TElList.Create;

  FNames.OnDelete := OnItemDelete;

  Fl := SHGFI_SMALLICON or SHGFI_USEFILEATTRIBUTES or SHGFI_ICON;
  SHGetFileInfo('', 0, FI, SizeOf(FI), Fl);
  DefSmallIcon := FI.hIcon;

  Fl := SHGFI_LARGEICON or SHGFI_USEFILEATTRIBUTES or SHGFI_ICON;
  SHGetFileInfo('', 0, FI, SizeOf(FI), Fl);
  {$endif}
end;

destructor TElShellIconCache.Destroy;
begin
  {$ifdef _DoNotUseSystemCache_}
  DestroyIcon(DefSmallIcon);
  FNames.Free;
  {$endif}
  FSmallImages.Free;
  inherited;
end;

{$ifdef _DoNotUseSystemCache_}
procedure TElShellIconCache.OnItemDelete(Sender: TObject; Item: Pointer);
begin
  if PElShellIconCacheEntry(Item).Name <> nil then
    FreeMem(PElShellIconCacheEntry(Item).Name);
  FreeMem(Item);
end;
{$endif}

function TElShellIconCache.AddFromPIDL(PIDL: PItemIDList; Flags: TShellAttr;
  OpenIcon: Boolean): Integer;
  var
  {$ifdef _DoNotUseSystemCache_}
    Fl : TShellAttr;
    FI : TSHFileInfo;
    Entry : PElShellIconCacheEntry;
    SmallIcon : HICON;
    S : String;
    i : Integer;
  {$else}
    FileInfo: TSHFileInfo;
  {$endif}
begin
{$ifdef _DoNotUseSystemCache_}
  Fl := SHGFI_SMALLICON;
  if OpenIcon then
    Fl := Fl or SHGFI_OPENICON;

  // get icon location
  SHGetFileInfo(PChar(PIDL),0, FI, SizeOf(FI), SHGFI_PIDL or SHGFI_ICONLOCATION or Fl);
  S := StrPas(FI.szDisplayName);
  i := FI.iIcon;
  SetLength(S, StrLen(PChar(S)));

  if OpenIcon then
    Fl := SHGFI_SMALLICON or SHGFI_OPENICON
  else
    Fl := SHGFI_SMALLICON;

  // get icons
  SHGetFileInfo(PChar(PIDL),0, FI, SizeOf(FI), SHGFI_PIDL or SHGFI_ICON or Fl);
  smallIcon := FI.hIcon;

  // allocate entry
  GetMem(Entry, SizeOf(TElShellIconCacheEntry));
  if Length(S) > 0 then
  begin
    GetMem(Entry.Name, Length(S) + 1);
    StrPCopy(Entry.Name, S);
  end
  else
    Entry.Name := nil;

  Entry.Idx := i;
  Result := FNames.Add(Entry);

  ImageList_AddIcon(FSmallImages.Handle, smallIcon);

  DestroyIcon(smallIcon);
{$else}
  Flags := SHGFI_PIDL or SHGFI_SYSICONINDEX;
  if OpenIcon then
    Flags := Flags or SHGFI_OPENICON;
  //if LargeIcon then
  //  Flags := Flags or SHGFI_LARGEICON
  //else
    Flags := Flags or SHGFI_SMALLICON;
  SHGetFileInfo(PChar(PIDL),
                0,
                FileInfo,
                SizeOf(FileInfo),
                Flags);
  Result := FileInfo.iIcon;
{$endif}
end;

function GetCompressedColor: Integer;
  var
    Reg :TRegistry;
    B   :Boolean;
begin
  if IsWinNTUp then
  begin
    try
      reg := TRegistry.Create;
      try
        Result := RGB(0, 0, 255);
        B := Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', False);
        if B then
        begin
          B := (Reg.ReadInteger('ShowCompColor') = 1);
          if B then
          begin
            B := Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer', False);
            if B and ( not
              (Reg.ReadBinaryData('AltColor', Result, SizeOf(Result)) <> SizeOf(Result)))
            then
              Result := RGB(0, 0, 255);
          end;
        end;
      finally
        Reg.free;
      end;
    except
      Result := RGB(0, 0, 255);
    end;
  end
  else
    Result := RGB(0, 0, 255);
end;

function ShellIconCache: TElShellIconCache;
begin
  Result := vShellIconCache;
end;

function GetNextItemID(PIDL :PItemIDList):PItemIDList;
  var
    cb :TShellAttr;
begin
   if(PIDL = nil) then
   begin
     Result := nil;
     exit;
   end;
   try
     // Get the size of the specified item identifier.
     cb := PIDL.mkid.cb;

     // If the size is zero, it is the end of the list.
     if (cb = 0) then
     begin
       Result := nil;
       exit;
     end;

     // Add cb to pidl (casting to increment by bytes).
     PIDL := PItemIDList(TShellAttr(PIDL) + cb);
     if PIDL.mkid.cb = 0 then
        Result := nil
     else
        Result := PIDL;
   except
     Result := nil;
   end;
end;

function PIDLStartsWith(PIDL, SubPIDL: PItemIDList): Boolean;
  var
    Size, SubSize: Integer;
begin
  Result := False;
  if (PIDL <> nil) and (SubPIDL <> nil) then
  begin
    Size := CalcPIDLSize(PIDL);
    SubSize := CalcPIDLSize(SubPIDL);
    if SubSize < Size then
      Result := CompareMem(PIDL, SubPIDL, SubSize - SizeOf(SubPIDL.mkid.cb));
  end;
end;

function PIDLContainsAt(PIDL, SubPIDL: PItemIDList; Pos: Integer): Boolean;
  var
    Total: Integer;
begin
  Result := False;
  if (PIDL <> nil) and (SubPIDL <> nil) then
  begin
    Total := 0;
    while (PIDL <> nil) do
    begin
      Inc(Total);
      if Pos = Total then
      begin
        if PIDL.mkid.cb = SubPIDL.mkid.cb then
          Result := CompareMem(@PIDL.mkid.abID, @SubPIDL.mkid.abID, SubPIDL.mkid.cb -
            SizeOf(SubPIDL.mkid.cb));
        break;
      end;
      PIDL := GetNextItemID(PIDL);
    end;
  end;
end;

function CalcPIDLSize(PIDL: PItemIDList): Integer;
  var
    cbTotal: Integer;
begin
  cbTotal := 0;
  if PIDL <> nil then
  begin
    Inc(cbTotal, SizeOf(pidl.mkid.cb));
    while (pidl <> nil) do
    begin
      Inc(cbTotal, pidl.mkid.cb);
      pidl := GetNextItemID(pidl);
    end;
  end;
  Result := cbTotal;
end;

function CompareIDLists(IDList1, IDList2: PItemIDList): Boolean;
  var
    i : Integer;
begin
  i := CalcPIDLSize(IDList1);
  if i <> CalcPIDLSize(IDList2) then
    Result := False
  else
    Result := CompareMem(IDList1, IDList2, i);
end;

function ClonePIDL(PIDL: PItemIDList): PItemIDList;
  var
    PIDLTemp: PItemIDList;
    cb: TShellAttr;
begin
  if PIDL = nil then
  begin
    Result := nil;
    exit;
  end;
  if Assigned(ShellMalloc) then
  begin
    cb := CalcPIDLSize(PIDL);
    PIDLTemp := ShellMalloc.alloc(cb);
    MoveMemory(PIDLTemp, PIDL, cb);
    Result := PIDLTemp;
  end
  else
    Result := nil;
end;

function GetOwnPIDL(PIDL: PItemIDList): PItemIDList;
  var
    oldPIDL: PItemIDList;
begin
  oldPIDL := nil;
  while (PIDL<>nil) and (PIDL.mkid.cb > 0) do
  begin
    oldPIDL := PIDL;
    PIDL := PItemIDList(Integer(PIDL) + PIDL.mkid.cb);
  end;
  Result := oldPIDL;
end;

function GetEmptyPIDL: PItemIDList;
begin
  if Assigned(ShellMalloc) then
  begin
    Result := ShellMalloc.alloc(2);
    Result.mkid.cb := 0;
  end
  else
    Result := nil;
end;

function GetItemIDOnly(PIDL: PItemIDList): PItemIDList;
  var
    pc     :PChar;
begin
  if Assigned(ShellMalloc) then
  begin
    Result := ShellMalloc.alloc(SizeOf(PIDL.mkid.cb) + PIDL.mkid.cb);
    MoveMemory(Result, PIDL, PIDL.mkid.cb);
    pc := PChar(Result);
    inc(pc, PIDL.mkid.cb);
    PWord(pc)^ := 0;
  end
  else
    Result := nil;
end;

function AppendPIDL(ParentPIDL, ChildPIDL: PItemIDList): PItemIDList;
  var
    pcb,ccb :TShellAttr;
begin
  if Assigned(ShellMalloc) then
  begin
    pcb := CalcPIDLSize(ParentPIDL);
    ccb := CalcPIDLSize(ChildPIDL);
    Result := ShellMalloc.alloc(pcb + ccb - SizeOf(ParentPIDL.mkid.cb));
    if pcb - SizeOf(ParentPIDL.mkid.cb) > 0 then
      MoveMemory(Result, ParentPIDL, pcb - SizeOf(ParentPIDL.mkid.cb));
    if ccb > 0 then
      MoveMemory(PItemIDList(TShellAttr(Result) + pcb  - SizeOf(ParentPIDL.mkid.cb)),
        ChildPIDL, ccb);
  end
  else
    Result := nil;
end;

function GetParentPIDL(PIDL: PItemIDList): PItemIDList;
  var
    PIDLLast, PIDLTemp :PItemIDList;
    cb                 :TShellAttr;
begin
  if Assigned(ShellMalloc) then
  begin
    PIDLLast := GetOwnPIDL(PIDL);
    if PIDLLast = nil then
    begin
      Result := ShellMalloc.alloc(2);
      Result.mkid.cb := 0;
    end
    else
    begin
      cb := Integer(PIDLLast) - Integer(PIDL) + SizeOf(PIDLTemp.mkid.cb);
      PIDLTemp := ShellMalloc.alloc(cb);
      MoveMemory(PIDLTemp, PIDL, cb);
      PItemIDList(TShellAttr(PIDLTemp) + cb - SizeOf(PIDLTemp.mkid.cb)).mkid.cb := 0;
      Result := PIDLTemp;
    end;
  end
  else
    Result := nil;
end;

function GetModule(const ModuleName: string): HMODULE;
begin
// migel: здесь так делать нельз€, т.к. в секции финализации используетс€ `FreeLibrary` и
// соответственно, если динамическа€ библиотека уже загружена, то данный вызов приведет к
// получению хендла этой библиотеки Ѕ≈« ”¬≈Ћ»„≈Ќ»я —„≈“„» ј ≈≈ »—ѕќЋ№«ќ¬јЌ»я,
// что приводит к тому, что данна€ библиотека будет выгружена из пам€ти, хот€ в этот момент
// ее может еще кто-то использовать.
{
  Result := GetModuleHandle(PChar(ModuleName));
  if Result < HINSTANCE_ERROR then
}
    Result := SafeLoadLibrary(PChar(ModuleName));
  if (Result > 0) and (Result < HINSTANCE_ERROR) then
    Result := 0;
end;

{ SetAutoComplete }

var
  ShlWAPIModule: THandle;

type
  TSHAutoCompleteFunc = function(hwndEdit: HWND; dwFlags: DWord): LongInt; stdcall;

var
  SHAutoCompleteFunc: TSHAutoCompleteFunc;

function SetAutoComplete(Handle: THandle; bFileSystem, bURL: Boolean): Boolean;
  const
    SHACF_FILESYSTEM = $00000001;
    SHACF_URLHISTORY = $00000002;
    SHACF_URLMRU     = $00000004;
    SHACF_USETAB     = $00000008;
  const
    cFileSystem :array[Boolean] of Cardinal = (0, SHACF_FILESYSTEM);
    cURL        :array[Boolean] of Cardinal = (0, SHACF_URLHISTORY or SHACF_URLMRU);
  var
    Flags: Cardinal;
begin
  if Assigned(SHAutoCompleteFunc) then
  begin
    Flags := cFileSystem[bFileSystem] or cURL[bURL];
    if Flags <> 0 then
    begin
      Flags := Flags or SHACF_USETAB;
      Result := SHAutoCompleteFunc(Handle, Flags) = 0;
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

function ElCreateShellLinkA(const sFileName, sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: string; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  SL: IShellLinkA;
  PF: IPersistFile;
  WS: WideString;
begin
  Obj := CreateComObject(CLSID_ShellLink);
  SL := Obj as IShellLinkA;

  if (IDList=nil) then
    SL.SetPath(PChar(sShortcutTo));
  if sArguments <> '' then
    SL.SetArguments(PChar(sArguments));
  if sWorkingDir <> '' then
    SL.SetWorkingDirectory(PChar(sWorkingDir));
  if sDescription <> '' then
    SL.SetDescription(PChar(sDescription));
  if (sIconFileName <> '') and (IconIndex>0) then
    SL.SetIconLocation(PChar(sIconFilename), IconIndex);

  if Assigned(IDList) then
    SL.SetIDList(IDList);

  if (fShowCmd = SW_SHOWNORMAL) or (fShowCmd  = SW_SHOWMAXIMIZED) or
     (fShowCmd = SW_SHOWMINNOACTIVE) then
    SL.SetShowCmd(fShowCmd);
  if Hotkey<>0 then
    SL.SetHotkey(Hotkey);

  PF := Obj as IPersistFile;
  WS := sFilename;
  Result := PF.Save(POleStr(WS), True) = S_OK;
end;

function ElCreateShellLinkW(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  SL: IShellLinkW;
  PF: IPersistFile;
begin
  if not IsWinNTUp then
    Result := ElCreateShellLinkA(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, IDList, fShowCmd, Hotkey )
  else
  begin
    Obj := CreateComObject(CLSID_ShellLink);
    SL := Obj as IShellLinkW;

    if (IDList=nil) then
      SL.SetPath(PWideChar(wsShortcutTo));
    if wsArguments <> '' then
      SL.SetArguments(PWideChar(wsArguments));
    if wsWorkingDir <> '' then
      SL.SetWorkingDirectory(PWideChar(wsWorkingDir));
    if wsDescription <> '' then
      SL.SetDescription(PWideChar(wsDescription));
    if (wsIconFileName <> '') and (IconIndex>0) then
      SL.SetIconLocation(PWideChar(wsIconFilename), IconIndex);

    if Assigned(IDList) then
      SL.SetIDList(IDList);

    if (fShowCmd = SW_SHOWNORMAL) or (fShowCmd  = SW_SHOWMAXIMIZED) or
       (fShowCmd = SW_SHOWMINNOACTIVE) then
      SL.SetShowCmd(fShowCmd);
    if Hotkey<>0 then
      SL.SetHotkey(Hotkey);

    PF := Obj as IPersistFile;
    Result := PF.Save(POleStr(wsFilename), True) = S_OK;
  end;
end;

function ElCreateShellLink(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TElFString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;
begin
  if IsWinNTUp then
    Result := ElCreateShellLinkW(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, IDList, fShowCmd, Hotkey )
  else
    Result := ElCreateShellLinkA(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, IDList, fShowCmd, Hotkey );
end;

function ElReadShellLinkA(const wsFileName: WideString; var sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: string; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  SL: IShellLinkA;
  PF: IPersistFile;
begin
  sShortcutTo := '';
  sWorkingDir := '';
  sArguments := '';
  sDescription := '';
  sIconFileName := '';
  IconIndex := -1;
  IDList := nil;
  fShowCmd := 0;
  Hotkey := 0;
  Obj := CreateComObject(CLSID_ShellLink);
  SL := Obj as IShellLinkA;
  PF := Obj as IPersistFile;
  Result := PF.Load(POleStr(wsFilename), 0) = S_OK;
  if not Result then
    exit;
  //
  SetLength(sShortcutTo, 1024);
  if SL.GetPath(PChar(sShortcutTo), Length(sShortcutTo), PWin32FindData(nil)^,
     SLGP_UNCPRIORITY) <> NOERROR then
    sShortcutTo := '';
  if IsWin2000Up then
    SetLength(sArguments, {CommCtrl.}INFOTIPSIZE)
  else
    SetLength(sArguments, Windows.MAX_PATH);
  if SL.GetArguments(PChar(sArguments), Length(sArguments)) <> S_OK then
    sArguments := '';
  //
  SetLength(sWorkingDir, 1024);
  if SL.GetWorkingDirectory(PChar(sWorkingDir), Length(sWorkingDir)) <> s_OK then
    sWorkingDir := '';
  //
  if IsWin2000Up then
    SetLength(sDescription, {CommCtrl.}INFOTIPSIZE)
  else
    SetLength(sDescription, Windows.MAX_PATH);
  if SL.GetDescription(PChar(sDescription), Length(sDescription)) <> S_OK then
    sDescription := '';
  //
  SetLength(sIconFileName, 1024);
  if SL.GetIconLocation(PChar(sIconFilename), Length(sIconFilename), IconIndex) <> S_OK then
    sIconFilename := '';
  //
  SL.GetShowCmd(fShowCmd);
  //
  SL.GetHotkey(WORD(Hotkey));
  //
  if bReadIDList then
    SL.GetIDList(IDList);
end;

function ElReadShellLinkW(const wsFileName: TElFString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TElFString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  SL: IShellLinkW;
  PF: IPersistFile;
  //
  sFileName, sShortcutTo, sWorkingDir,
  sArguments, sDescription, sIconFileName: string;
begin
  wsShortcutTo := '';
  wsWorkingDir := '';
  wsArguments := '';
  wsDescription := '';
  wsIconFileName := '';
  IconIndex := -1;
  IDList := nil;
  fShowCmd := 0;
  Hotkey := 0;
  if not IsWinNTUp then
  begin
    Result := ElReadShellLinkA(sFileName, sShortcutTo,
      sWorkingDir, sArguments, sDescription,
      sIconFileName, IconIndex, bReadIDList, IDList, fShowCmd, Hotkey );
    wsShortcutTo := sShortcutTo;
    wsWorkingDir := sWorkingDir;
    wsArguments := sArguments;
    wsDescription := sDescription;
    wsIconFileName := sIconFileName;
  end
  else
  begin
    Obj := CreateComObject(CLSID_ShellLink);
    SL := Obj as IShellLinkW;
    PF := Obj as IPersistFile;
    Result := PF.Load(POleStr(wsFilename), 0) = S_OK;
    if not Result then
      exit;
    //
    SetLength(wsShortcutTo, 1024);
    wsShortcutTo[1]:=#0;
    //? AV:
    //if Assigned(FD) then
    //  SL.GetPath(PWideChar(wsShortcutTo), Length(wsShortcutTo), FD{^}, SLGP_UNCPRIORITY);
    //  SL.GetPath(nil, 0, WFD{^}, SLGP_UNCPRIORITY);
    if SL.GetPath(PWideChar(wsShortcutTo), Length(wsShortcutTo), {nil}PWin32FindData(nil)^{},
       SLGP_UNCPRIORITY) <> NOERROR then
      wsShortcutTo := '';
    if IsWin2000Up then
      SetLength(wsArguments, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(wsArguments, Windows.MAX_PATH);
    if SL.GetArguments(PWideChar(wsArguments), Length(wsArguments)) <> S_OK then
      wsArguments := '';
    //
    SetLength(wsWorkingDir, 1024);
    if SL.GetWorkingDirectory(PWideChar(wsWorkingDir), Length(wsWorkingDir)) <> s_OK then
      wsWorkingDir := '';
    //
    if IsWin2000Up then
      SetLength(wsDescription, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(wsDescription, Windows.MAX_PATH);
    if SL.GetDescription(PWideChar(wsDescription), Length(wsDescription)) <> S_OK then
      wsDescription := '';
    //
    SetLength(wsIconFileName, 1024);
    if SL.GetIconLocation(PWideChar(wsIconFilename), Length(wsIconFilename), IconIndex) <> S_OK then
      wsIconFilename := '';
    //
    SL.GetShowCmd(fShowCmd);
    //
    SL.GetHotkey(WORD(Hotkey));
    //
    if bReadIDList then
      SL.GetIDList(IDList);
  end;
end;

function ElReadShellLink(const wsFileName: TElFString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TElFString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;
var
  sShortcutTo, sWorkingDir,
  sArguments, sDescription, sIconFileName: String;
begin
  if IsWinNTUp then
    Result := ElReadShellLinkW(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, bReadIDList, IDList, fShowCmd, Hotkey )
  else
  begin
    Result := ElReadShellLinkA(wsFileName, sShortcutTo,
      sWorkingDir, sArguments, sDescription,
      sIconFileName, IconIndex, bReadIDList, IDList, fShowCmd, Hotkey );
    wsShortcutTo := sShortcutTo;
    wsWorkingDir := sWorkingDir;
    wsArguments := sArguments;
    wsDescription := sDescription;
    wsIconFileName := sIconFileName;
  end;
end;

{$endif ifndef D_2}

function FireURL (const URL: String): Boolean;
  var
    SHI  :TShellExecuteInfo;
    URL2 :String;
begin
  URL2 := URL;
  if Pos(':', URL2) = 0 then
  begin
    if ContainsAt(URL2, 1, 'www') then
    begin
      URL2 := 'http://' + URL2;
    end
    else
    begin
      if ContainsAt(URL2, 1, 'ftp') then
      begin
        URL2 := 'ftp://' + URL2;
      end
      else
      begin
        if Pos('@', URL2) > 1 then
        begin
          URL2 := 'mailto:' + URL2;
        end;
      end;
    end;
  end;
  ZeroMemory(@SHI, SizeOf(SHI));
  SHI.cbSize := SizeOf(SHI);
  SHI.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_NOCLOSEPROCESS;
  SHI.Wnd := Application.Handle;
  SHI.lpVerb := PChar('Open');
  SHI.lpFile := PChar(URL2);
  SHI.lpParameters := nil;
  SHI.lpDirectory := nil;
  Result := ShellExecuteEx(@SHI);
  if Result then
  begin
    CloseHandle(SHI.hProcess);
  end;
end;


{$ifndef D_2}

initialization
  vShellIconCache    := TElShellIconCache.Create;
  GetShellMalloc;

  ShlWAPIModule      := GetModule(shlwapi);
  SHAutoCompleteFunc := GetProcAddress(ShlWAPIModule, 'SHAutoComplete');

finalization

  ShellDesktopFolder := nil;
  ShellMalloc := nil;
  vShellIconCache.Free;

  if ShlWAPIModule <> 0 then
    FreeLibrary(ShlWAPIModule);

{$endif ifndef D_2}

end.
