unit F1ShellDriver_IMPL;

interface

uses
 ActiveX,
 Classes,
 Clipbrd,
 ComObj,
 ComServ,
 Forms,
 Office2000,
 Registry,
 ShellAPI,
 StdVcl,
 StrUtils,
 SysUtils,
 Variants,
 Windows,
 Word2000,
 //
 adxAddIn,
 adxHostAppEvents,
 //
 nsIntegration,
 F1ShellDriver_TLB;

type
 TF1Shell = class(TadxAddin, IF1Shell)
 end;

 TF1ShellAddInModule = class(TadxCOMAddInModule)
  f_KeyboardShortcuts: TadxKeyboardShortcut;
  //
  f_WordAppEvents: TadxWordAppEvents;
  //
  f_FieldAutoTextContextMenu: TadxContextMenu;
  f_Grammar1ContextMenu: TadxContextMenu;
  f_Grammar2ContextMenu: TadxContextMenu;
  f_HeadingsContextMenu: TadxContextMenu;
  f_HyperlinkContextMenu: TadxContextMenu;
  f_LinkedTextContextMenu: TadxContextMenu;
  f_ListsContextMenu: TadxContextMenu;
  f_SpellingContextMenu: TadxContextMenu;
  f_TableTextContextMenu: TadxContextMenu;
  f_TextContextMenu: TadxContextMenu;
  //
  f_CommandBar: TadxCommandBar;
  //
  f_MainReadOnlyRibbonTab: TadxRibbonTab;
  f_MainWritableRibbonTab: TadxRibbonTab;
  //
  f_SelfReadOnlyRibbonTab: TadxRibbonTab;
  f_SelfWritableRibbonTab: TadxRibbonTab;
  //
  procedure HideErrorMessageBox(const a_Exception: Exception; var a_Handled: Boolean);
  //
  procedure AddInInitialize(a_Sender: TObject);
  procedure AddInStartupComplete(a_Sender: TObject);
  //
  procedure KeyboardShortcutAppsAction(a_Sender: TObject);
  //
  procedure OutlookExplorerClose(a_Sender: TObject);
  //
  procedure WordAppEventsStartup(a_Sender: TObject);
  procedure WordAppEventsQuit(a_Sender: TObject);
  //
  procedure WordAppEventsDocumentChange(a_Sender: TObject);
  procedure WordAppEventsDocumentBeforeClose(a_Sender: TObject; const a_Document: _Document; var a_Cancel: WordBool);
  //
  procedure WordAppEventsWindowBeforeRightClick(a_Sender: TObject; const a_WordSelection: WordSelection; var a_Cancel: WordBool);
  //
  procedure ContextMenuFindClick(a_Sender: TObject);
  //
  procedure CommandBarFindButtonClick(a_Sender: TObject);
  //
  procedure MainReadOnlyRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  procedure MainWritableRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure SelfReadOnlyRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  procedure SelfWritableRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure MainReadOnlyRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  procedure MainWritableRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure SelfReadOnlyRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  procedure SelfWritableRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarInfoClick(a_Sender: TObject);
  procedure RibbonTabInfoClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarLinkClick(a_Sender: TObject);
  procedure RibbonTabLinkClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenMainMenu(a_Sender: TObject);
  procedure RibbonTabOpenMainMenu(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenOnlineNews(a_Sender: TObject);
  procedure RibbonTabOpenOnlineNews(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenPolicies(a_Sender: TObject);
  procedure RibbonTabOpenPolicies(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenGuide(a_Sender: TObject);
  procedure RibbonTabOpenGuide(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenBusinessInfo(a_Sender: TObject);
  procedure RibbonTabOpenBusinessInfo(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenAskExpert(a_Sender: TObject);
  procedure RibbonTabOpenAskExpert(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenLawMonitoring(a_Sender: TObject);
  procedure RibbonTabOpenLawMonitoring(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarOpenPrime(a_Sender: TObject);
  procedure RibbonTabOpenPrime(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure CommandBarExternalLinkExecute(a_Sender: TObject);
  procedure RibbonTabExternalLinkExecute(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
  //
  procedure adxCOMAddInModuleHostAppSet(Sender: TObject);
 private
  f_CommandBarLinkButton: TadxCommandBarButton;
  f_CommandBarEditBox: TadxCommandBarEdit;
  //
  f_MainReadOnlyRibbonTabGroup: TadxRibbonGroup;
  f_MainWritableRibbonTabGroup: TadxRibbonGroup;
  //
  f_MainReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox;
  f_MainWritableRibbonTabCheckBox: TadxRibbonCheckBox;
  //
  f_SelfReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox;
  f_SelfWritableRibbonTabCheckBox: TadxRibbonCheckBox;
  //
  f_MainWritableRibbonLinkButton: TadxRibbonButton;
  f_SelfWritableRibbonLinkButton: TadxRibbonButton;
  //
  f_MainWritableRibbonEditBox: TadxRibbonEditBox;
  f_SelfWritableRibbonEditBox: TadxRibbonEditBox;
  //
  f_MainReadOnlyRibbonEditBox: TadxRibbonEditBox;
  f_SelfReadOnlyRibbonEditBox: TadxRibbonEditBox;
 private
  procedure UpdateCommandBar;
  //
  procedure UpdateVisibility;
  //
  procedure UpdateMainReadOnlyRibbonTabCheckBox;
  procedure UpdateMainWritableRibbonTabCheckBox;
  //
  procedure UpdateSelfReadOnlyRibbonTabCheckBox;
  procedure UpdateSelfWritableRibbonTabCheckBox;
  //
  function  GetCachedCommandBarControl(const a_Tag: WideString; var a_CacheVar: TadxCommandBarControl): TadxCommandBarControl;
  function  GetCachedRibbonControl(const a_ID: WideString; var a_CacheVar: TObject): TObject;
  //
  function  GetCachedCommandBarButton(const a_Tag: WideString; var a_CacheVar: TadxCommandBarButton): TadxCommandBarButton;
  function  GetCachedCommandBarEditBox(const a_Tag: WideString; var a_CacheVar: TadxCommandBarEdit): TadxCommandBarEdit;
  //
  function  GetCachedRibbonTabCheckBox(const a_ID: WideString; var a_CacheVar: TadxRibbonCheckBox): TadxRibbonCheckBox;
  //
  function  GetCachedRibbonTabGroup(const a_ID: WideString; var a_CacheVar: TadxRibbonGroup): TadxRibbonGroup;
  //
  function  GetCachedRibbonButton(const a_ID: WideString; var a_CacheVar: TadxRibbonButton): TadxRibbonButton;
  //
  function  GetCachedRibbonEditBox(const a_ID: WideString; var a_CacheVar: TadxRibbonEditBox): TadxRibbonEditBox;
  //
  function  GetCommandBarLinkButton: TadxCommandBarButton;
  function  GetCommandBarEditBox: TadxCommandBarEdit;
  //
  function  GetMainReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox;
  function  GetMainWritableRibbonTabCheckBox: TadxRibbonCheckBox;
  //
  function  GetSelfReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox;
  function  GetSelfWritableRibbonTabCheckBox: TadxRibbonCheckBox;
  //
  function  GetMainReadOnlyRibbonTabGroup: TadxRibbonGroup;
  function  GetMainWritableRibbonTabGroup: TadxRibbonGroup;
  //
  function  GetMainWritableRibbonLinkButton: TadxRibbonButton;
  function  GetSelfWritableRibbonLinkButton: TadxRibbonButton;
  //
  function  GetMainWritableRibbonEditBox: TadxRibbonEditBox;
  function  GetSelfWritableRibbonEditBox: TadxRibbonEditBox;
  //
  function  GetMainReadOnlyRibbonEditBox: TadxRibbonEditBox;
  function  GetSelfReadOnlyRibbonEditBox: TadxRibbonEditBox;
 private
  function  GetRegistryRoot: HKEY;
  function  GetRegistryPath: string;
  //
  function  GetSettingsValue(const a_Name: string; a_Default: string): string; overload;
  function  GetSettingsValue(const a_Name: string; a_Default: Boolean): Boolean; overload;
  //
  procedure PutSettingsValue(const a_Name: string; a_Value: string); overload;
  procedure PutSettingsValue(const a_Name: string; a_Value: Boolean); overload;
 private
  function  CreateXMLLink(const a_ID: Cardinal; const a_Point: Cardinal = 0; const a_Type: string = 'SUB'): string;
  function  CreateXMLQuery(const a_Text: string): string;
  //
  procedure FindExecute(const a_Text: string);
  procedure ShellExecute(const a_Params: string);
  //
  function  GetTextFromSelection(const a_WordSelection: OLEVariant): WideString; overload;
  function  GetTextFromSelection(const a_WordSelection: WordSelection): WideString; overload;
 private
  function  CommandBarVisibleSettingsName: string;
  function  MainRibbonTabGroupVisibleSettingsName(const a_ReadOnly: Boolean): string;
  //
  function  IsClipboardHasLink: Boolean;
  function  IsNoActiveDocument: Boolean;
  //
  function  IsCommandBarPresent: Boolean;
  function  IsCommandBarVisible: Boolean;
  procedure SetCommandBarVisible(const a_Value: Boolean);
  //
  function  IsMainReadOnlyRibbonTabGroupVisible(const a_IsNoActiveDocument: Boolean; const a_ForceSettings: Boolean = False): Boolean;
  procedure SetMainReadOnlyRibbonTabGroupVisible(const a_Value: Boolean);
  //
  function  IsMainWritableRibbonTabGroupVisible(const a_IsNoActiveDocument: Boolean; const a_ForceSettings: Boolean = False): Boolean;
  procedure SetMainWritableRibbonTabGroupVisible(const a_Value: Boolean);
  //
  function  IsSelfReadOnlyRibbonTabVisible(const a_IsNoActiveDocument: Boolean): Boolean;
  function  IsSelfWritableRibbonTabVisible(const a_IsNoActiveDocument: Boolean): Boolean;
  //
 protected
  property  CommandBar: TadxCommandBar read f_CommandBar;
  //
  property  FieldAutoTextContextMenu: TadxContextMenu read f_FieldAutoTextContextMenu;
  property  Grammar1ContextMenu: TadxContextMenu read f_Grammar1ContextMenu;
  property  Grammar2ContextMenu: TadxContextMenu read f_Grammar2ContextMenu;
  property  HeadingsContextMenu: TadxContextMenu read f_HeadingsContextMenu;
  property  HyperlinkContextMenu: TadxContextMenu read f_HyperlinkContextMenu;
  property  LinkedTextContextMenu: TadxContextMenu read f_LinkedTextContextMenu;
  property  ListsContextMenu: TadxContextMenu read f_ListsContextMenu;
  property  SpellingContextMenu: TadxContextMenu read f_SpellingContextMenu;
  property  TableTextContextMenu: TadxContextMenu read f_TableTextContextMenu;
  property  TextContextMenu: TadxContextMenu read f_TextContextMenu;
  //
  property  CommandBarLinkButton: TadxCommandBarButton read GetCommandBarLinkButton;
  property  CommandBarEditBox: TadxCommandBarEdit read GetCommandBarEditBox;
  //
  property  SelfReadOnlyRibbonTab: TadxRibbonTab read f_SelfReadOnlyRibbonTab;
  property  SelfWritableRibbonTab: TadxRibbonTab read f_SelfWritableRibbonTab;
  //
  property  MainReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox read GetMainReadOnlyRibbonTabCheckBox;
  property  MainWritableRibbonTabCheckBox: TadxRibbonCheckBox read GetMainWritableRibbonTabCheckBox;
  //
  property  SelfReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox read GetSelfReadOnlyRibbonTabCheckBox;
  property  SelfWritableRibbonTabCheckBox: TadxRibbonCheckBox read GetSelfWritableRibbonTabCheckBox;
  //
  property  MainReadOnlyRibbonTabGroup: TadxRibbonGroup read GetMainReadOnlyRibbonTabGroup;
  property  MainWritableRibbonTabGroup: TadxRibbonGroup read GetMainWritableRibbonTabGroup;
  //
  property  MainWritableRibbonLinkButton: TadxRibbonButton read GetMainWritableRibbonLinkButton;
  property  SelfWritableRibbonLinkButton: TadxRibbonButton read GetSelfWritableRibbonLinkButton;
  //
  property  MainWritableRibbonEditBox: TadxRibbonEditBox read GetMainWritableRibbonEditBox;
  property  SelfWritableRibbonEditBox: TadxRibbonEditBox read GetSelfWritableRibbonEditBox;
  //
  property  MainReadOnlyRibbonEditBox: TadxRibbonEditBox read GetMainReadOnlyRibbonEditBox;
  property  SelfReadOnlyRibbonEditBox: TadxRibbonEditBox read GetSelfReadOnlyRibbonEditBox;
 end;

implementation

{$R *.dfm}

uses
 Controls,
 Messages,
 //
 F1ShellInfo,
 F1ShellLinkInfo;

{$INCLUDE '..\interface\nsIntergationConstants.inc'}

const
 c_DefaultTimeOut = 1*60*1000; // one minute
 //
 c_MaxContextMenuFindTextLength: Integer = 32;
 c_MaxSelectionLength: Integer = 300;
 //
 c_InternalOffset =  100000;
 //
 c_BusinessInfoId  =   49990 + c_InternalOffset;
 c_GuideId         = 5451210 + c_InternalOffset;
 c_LawMonitoringId =  897937 + c_InternalOffset;
 c_PoliciesId      = 5178321 + c_InternalOffset;
 //
 c_CommandBarLinkButtonTag: WideString         = '{FF0528B5-D32B-423D-9897-775DFCE7AAAE}';
 c_CommandBarEditBoxTag: WideString            = '{D01A9C0F-B442-4106-93C8-20FD2018AB39}';
 //
 c_MainReadOnlyRibbonTabCheckBoxId: WideString = 'adxRibbonCheckBox1218F453CAA44EB2AB2BC911E4EAAA1F';
 c_MainWritableRibbonTabCheckBoxId: WideString = 'adxRibbonCheckBoxD6E3AA9380BA4561A7F1E8B331F9F3EB';
 //
 c_SelfReadOnlyRibbonTabCheckBoxId: WideString = 'adxRibbonCheckBox08FEC8CEFA8D4D67AB94690E5B4F4B2E';
 c_SelfWritableRibbonTabCheckBoxId: WideString = 'adxRibbonCheckBox9151E041935C44308F716E46E00551FB';
 //
 c_MainReadOnlyRibbonTabGroupId: WideString    = 'adxRibbonGroupA23C97AA24454FE5A6376627E66F2AA3';
 c_MainWritableRibbonTabGroupId: WideString    = 'adxRibbonGroupB51E7027F3F040A5B96EBB597846D6FC';
 //
 c_MainWritableRibbonLinkButtonId: WideString  = 'adxRibbonButtonFD43275524404AF196F918DDCDAFFE27';
 c_SelfWritableRibbonLinkButtonId: WideString  = 'adxRibbonButton1B33A86077484C979A2F1BB700D715C8';
 //
 c_MainWritableRibbonEditBoxId: WideString  = 'adxRibbonEditBox314AE63DB42445528FD2E41E08846F38';
 c_SelfWritableRibbonEditBoxId: WideString  = 'adxRibbonEditBox3CEC6DF45CEB47D08857B934AA1A8FE5';
 //
 c_MainReadOnlyRibbonEditBoxId: WideString  = 'adxRibbonEditBox08CA31D5694D4B12A88FC8C13CD01CAF';
 c_SelfReadOnlyRibbonEditBoxId: WideString  = 'adxRibbonEditBoxD5F7187F87C64FA5A0617D056A9387B2';
 //
 c_MsgBusyText: String = 'Внимание!' +
  #10#13 + 'Для продолжения операции необходимо закрыть диалоговое окно в системе ГАРАНТ.';
 c_MsgTryToFindEmptyContext: String = 'Введите описание своего вопроса для поиска.';

var
 g_EverestClipboardId: UINT = UINT(-1);
 g_CommandBarEditBox: TadxCommandBarEdit = nil;
type
 TProcessCommandHelper = class(TThread)
 private
  f_Command: DWORD;
  f_OpenInNewWindow: Bool;
  f_TimeOut: DWORD;
  f_AddInName: string;
  //
  procedure Execute; override;
 public
  constructor Create(a_Command: DWORD; a_OpenInNewWindow: Bool; a_TimeOut: DWORD = c_DefaultTimeOut;
   a_AddInName: string = '');
 end;

 TShowLinkHelper = class(TThread)
 private
  f_Link: string;
  f_OpenInNewWindow: Bool;
  f_TimeOut: DWORD;
  f_AddInName: string;
  //
  procedure Execute; override;
 public
  constructor Create(a_Link: string; a_OpenInNewWindow: Bool; a_TimeOut: DWORD = c_DefaultTimeOut;
   a_AddInName: string = '');
 end;

procedure ShowErrorMessage(const a_AddInName : String; const a_MessageText : String);
begin
 MessageBox(GetForegroundWindow, PChar(a_MessageText), PChar(a_AddInName),
  MB_ICONINFORMATION or MB_OK or MB_TOPMOST or MB_APPLMODAL);
end;

procedure HandleErrorCode(a_ForegrndWnd : HWND; const a_AddInName : String; a_ErrorCode : Integer);
var
 l_MessageText : String;
begin
 SetForegroundWindow(a_ForegrndWnd);
 case a_ErrorCode of
  GI_BUSY :
   l_MessageText := c_MsgBusyText;
  GI_TRYTOFINDEMPTYCONTEXT :
   l_MessageText := c_MsgTryToFindEmptyContext;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=493327197
  else
   Exit;
 end;
 ShowErrorMessage(a_AddInName, l_MessageText);
end;

procedure TProcessCommandHelper.Execute;
var
 l_Result : Integer;
 l_PrevForegroundWnd : HWND;
begin
 l_PrevForegroundWnd := GetForegroundWindow;
 l_Result := GarantProcessCommand(f_Command, f_OpenInNewWindow, f_TimeOut);
 if (l_Result <> GI_OK) then
  HandleErrorCode(l_PrevForegroundWnd, f_AddInName, l_Result);
end;

constructor TProcessCommandHelper.Create(a_Command: DWORD; a_OpenInNewWindow: Bool; a_TimeOut: DWORD;
 a_AddInName: string);
begin
 inherited Create(True);
 //
 f_Command := a_Command;
 f_OpenInNewWindow := a_OpenInNewWindow;
 f_TimeOut := a_TimeOut;
 f_AddInName := a_AddInName;
 //
 FreeOnTerminate := True;
end;

procedure TShowLinkHelper.Execute;
var
 l_PrevForegroundWnd: HWND;
 l_Result: Integer;
begin
 l_PrevForegroundWnd := GetForegroundWindow;
 l_Result := GarantShowLink(PChar(f_Link), f_OpenInNewWindow, f_TimeOut);
 if l_Result <> GI_OK then
  HandleErrorCode(l_PrevForegroundWnd, f_AddInName, l_Result);
end;

constructor TShowLinkHelper.Create(a_Link: string; a_OpenInNewWindow: Bool; a_TimeOut: DWORD;
 a_AddInName: string);
begin
 inherited Create(True);
 //
 f_Link := a_Link;
 f_OpenInNewWindow := a_OpenInNewWindow;
 f_TimeOut := a_TimeOut;
 f_AddInName := a_AddInName;
 //
 FreeOnTerminate := True;
end;

procedure TF1ShellAddInModule.HideErrorMessageBox(const a_Exception: Exception; var a_Handled: Boolean);
begin
 a_Handled := True;
end;

procedure TF1ShellAddInModule.AddInInitialize(a_Sender: TObject);
//
 function FileNameToHandle(const a_FileName: string): THandle;
 const
  STATUS_SUCCESS              = Longint($00000000);
  STATUS_INFO_LENGTH_MISMATCH = Longint($C0000004);
 //
 type
  TDynRAWBuffer = array of Byte;
  TStaRAWBuffer = array [0..32767] of Byte;
  //
  TSysytemHandleInformation = packed record
   r_ProcessId: ULONG;
   r_ObjectType: UCHAR;
   r_Flags: UCHAR;
   r_Handle: Word;
   r_FObject: Pointer;
   r_GrantedAccess: ACCESS_MASK;
  end;
  PSysytemHandleInformation = ^TSysytemHandleInformation;
  //
  TSystemHandleInformationArray = array [1..65536] of TSysytemHandleInformation;
  //
  TSysytemHandlesInformation = packed record
   r_Count: ULONG;
   r_Data: TSystemHandleInformationArray;
  end;
  PSysytemHandlesInformation = ^TSysytemHandlesInformation;
  //
  TNTStatus = Longint;
  //
  function QuerySystemHandlesInformation(const a_NTDLL: HMODULE; var a_Buffer: TDynRAWBuffer): PSysytemHandlesInformation;
  type
   TNTQuerySystemInformationCall = function(
    a_SystemInformationClass: Integer
    ; a_SystemInformation: Pointer
    ; a_SystemInformationLength: ULONG
    ; a_ReturnLength: PULONG
   ): TNTStatus; stdcall;
  //
  var
   l_Length: ULONG;
   //
   l_NTQuerySystemInformationProc: Pointer;
   l_NTQuerySystemInformationCall: TNTQuerySystemInformationCall absolute l_NTQuerySystemInformationProc;
  begin
   Result := nil;
   //
   if (a_NTDLL <> HMODULE(0)) then
   begin
    l_NTQuerySystemInformationProc := GetProcAddress(a_NTDLL, 'NtQuerySystemInformation');
    if (l_NTQuerySystemInformationProc <> nil) then
    begin
     SetLength(a_Buffer, $8000);
     //
     while (l_NTQuerySystemInformationCall(16, a_Buffer, Length(a_Buffer), @l_Length) = STATUS_INFO_LENGTH_MISMATCH) do
      SetLength(a_Buffer, Length(a_Buffer) shl 1);
     //
     SetLength(a_Buffer, l_Length);
     //
     Result := Pointer(a_Buffer);
    end;
   end;
  end;
  //
  function GetDeviceFileName(const a_FileName: string): string;
  const
   c_LanRedir: string = '\Device\LanmanRedirector\';
   c_SubstRedir: string = '\??\';
  var
   l_DeviceName: string;
   l_FileDrive: string;
   //
   l_Position: Integer;
  begin
   Result := a_FileName;
   //
   l_FileDrive := ExtractFileDrive(Result);
   if ((Length(l_FileDrive) = 2) and (l_FileDrive[2] = DriveDelim)) then
   begin
    SetLength(l_DeviceName, Succ(MAX_PATH));
    SetLength(l_DeviceName, QueryDosDevice(PChar(l_FileDrive), PChar(l_DeviceName), Length(l_DeviceName)));
    //
    l_DeviceName := PChar(l_DeviceName); // remove final `\0`
    //
    if (l_DeviceName <> '') then
    begin
     Delete(Result, 1, Length(l_FileDrive));
     //
     if (Pos(c_SubstRedir, l_DeviceName) = 1) then
     begin
      Delete(l_DeviceName, 1, Length(c_SubstRedir));
      Insert(l_DeviceName, Result, 1);
      //
      Result := GetDeviceFileName(Result);
     end
     else
      if (Pos(c_LanRedir, l_DeviceName) = 1) then
      begin
       l_Position := PosEx('\', l_DeviceName, Succ(Length(c_LanRedir)));
       //
       if (l_Position > 0) then
        Insert(Format('\Device\Mup\%s', [PChar(@l_DeviceName[Succ(l_Position)])]), Result, 1);
      end
      else
       Insert(l_DeviceName, Result, 1);
    end;
   end;
  end;
  //
  function FileHandleObjectType(a_NTDLL: HMODULE; a_ProcessId: DWORD): UCHAR;
  var
   l_Buffer: TDynRAWBuffer;
   l_Handle: THandle;
   //
   l_Index: ULONG;
  begin
   Result := UCHAR(-1);
   //
   l_Handle := CreateFile('NUL', GENERIC_READ, 0, nil, OPEN_EXISTING, 0, THandle(0));
   try
    with QuerySystemHandlesInformation(a_NTDLL, l_Buffer)^ do
     for l_Index := 1 to r_Count do
      with r_Data[l_Index] do
       if ((r_ProcessId = a_ProcessId) and (r_Handle = Word(l_Handle))) then
       begin
        Result := r_ObjectType;
        //
        Break;
       end;
   finally
    CloseHandle(l_Handle);
   end;
  end;
  //
 type
  TNTQueryObjectCall = function (
   a_Handle: THandle
   ; a_ObjectInformationClass: Integer
   ; a_ObjectInformation: Pointer
   ; a_ObjectInformationLength: ULONG
   ; a_ReturnLength: PULONG
  ): TNTStatus; stdcall;
  //
  TUnicodeString = packed record
    Length: WORD;
    MaximumLength: WORD;
    Buffer: PWideChar;
  end;
  PUnicodeString = ^TUnicodeString;
 var
  l_Buffer: TDynRAWBuffer;
  //
  l_Index: UINT;
  //
  l_ErrorMode: UINT;
  l_HModule: HMODULE;
  l_ProcessId: DWORD;
  //
  l_FileHandleObjectType: UCHAR;
  //
  l_NTQueryObjectProc: Pointer;
  l_NTQueryObjectCall: TNTQueryObjectCall absolute l_NTQueryObjectProc;
  //
  l_FileBuff: TStaRAWBuffer;
  l_FileName: string;
 begin
  Result := INVALID_HANDLE_VALUE;
  //
  l_ErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
   l_ProcessId := GetCurrentProcessId;
   //
   l_HModule := LoadLibrary('ntdll.dll');
   if (l_HModule <> HMODULE(0)) then
    try
     l_FileHandleObjectType := FileHandleObjectType(l_HModule, l_ProcessId);
     //
     l_NTQueryObjectProc := GetProcAddress(l_HModule, 'NtQueryObject');
     if ((l_FileHandleObjectType <> UCHAR(-1)) and (l_NTQueryObjectProc <> nil)) then
      with QuerySystemHandlesInformation(l_HModule, l_Buffer)^ do
       for l_Index := 1 to r_Count do
        with r_Data[l_Index] do
         if ((r_ProcessId = l_ProcessId) and (r_ObjectType = l_FileHandleObjectType) and (l_NTQueryObjectCall(r_Handle, 1, @l_FileBuff, SizeOf(l_FileBuff), nil) = STATUS_SUCCESS)) then
         begin
          l_FileName := PUnicodeString(@l_FileBuff)^.Buffer;
          //
          if SameText(l_FileName, GetDeviceFileName(a_FileName)) then
          begin
           Result := r_Handle;
           //
           Break;
          end;
         end;
    finally
     FreeLibrary(l_HModule);
    end;
  finally
   SetErrorMode(l_ErrorMode);
  end;
 end;
//
begin

 CloseHandle(FileNameToHandle(ComServer.ServerFileName)); // hack: find and close dll file handle, need for correct update
 //
 g_CommandBarEditBox := CommandBarEditBox;
 //
 UpdateMainReadOnlyRibbonTabCheckBox;
 UpdateMainWritableRibbonTabCheckBox;
 //
 UpdateSelfReadOnlyRibbonTabCheckBox;
 UpdateSelfWritableRibbonTabCheckBox;
 //
 UpdateVisibility;
end;

procedure TF1ShellAddInModule.AddInStartupComplete(a_Sender: TObject);
begin
 if (HostType = ohaOutlook) then
  f_CommandBar.Visible := GetSettingsValue(CommandBarVisibleSettingsName, True);
end;

procedure TF1ShellAddInModule.KeyboardShortcutAppsAction(a_Sender: TObject);
var
 l_Cancel: WordBool;
begin
 WordAppEventsWindowBeforeRightClick(a_Sender, nil, l_Cancel);
end;

procedure TF1ShellAddInModule.OutlookExplorerClose(a_Sender: TObject);
begin
 if (HostType = ohaOutlook) then // K330143425
 begin
  SetCommandBarVisible(f_CommandBar.Visible);
  //
  f_CommandBar.Uninstall; // K328859821
 end;
end;

procedure TF1ShellAddInModule.WordAppEventsStartup(a_Sender: TObject);
var
 l_OnError: TadxOnError;
 //
 l_Count: Integer;
 l_Index: Integer;
 l_Saved: array of WordBool;
begin
 try
  if (HostType = ohaWord) then
  begin
   l_Count := HostApp.Templates.Count;
   //
   SetLength(l_Saved, l_Count);
   for l_Index := 1 to l_Count do
    try
     l_Saved[Pred(l_Index)] := HostApp.Templates.Item(l_Index).Saved;
    except
     l_Count := Pred(l_Index);
     Break;
    end;
   SetLength(l_Saved, l_Count);
  end;
 except
 end;
 try
  l_OnError := OnError;
  try
   OnError := HideErrorMessageBox;
   try
    CommandBar.Visible := IsCommandBarVisible;
   except
   end;
  finally
   OnError := l_OnError;
  end;
 finally
  try
   if (HostType = ohaWord) then
     for l_Index := 1 to l_Count do
      try
       HostApp.Templates.Item(l_Index).Saved := l_Saved[Pred(l_Index)];
      except
      end;
  except
  end;
 end;
end;

procedure TF1ShellAddInModule.WordAppEventsQuit(a_Sender: TObject);
var
 l_OnError: TadxOnError;
 //
 l_Count: Integer;
 l_Index: Integer;
 l_Saved: array of WordBool;
begin
 try
  if (HostType = ohaWord) then
  begin
   l_Count := HostApp.Templates.Count;
   //
   SetLength(l_Saved, l_Count);
   for l_Index := 1 to l_Count do
    try
     l_Saved[Pred(l_Index)] := HostApp.Templates.Item(l_Index).Saved;
    except
     l_Count := Pred(l_Index);
     Break;
    end;
   SetLength(l_Saved, l_Count);
  end;
 except
 end;
 try
  l_OnError := OnError;
  try
   OnError := HideErrorMessageBox;
   try
    UpdateCommandBar;
   except
   end;
  finally
   OnError := l_OnError;
  end;
 finally
  try
   if (HostType = ohaWord) then
     for l_Index := 1 to l_Count do
      try
       HostApp.Templates.Item(l_Index).Saved := l_Saved[Pred(l_Index)];
      except
      end;
  except
  end;
 end;
end;

procedure TF1ShellAddInModule.WordAppEventsDocumentChange(a_Sender: TObject);
var
 l_OnError: TadxOnError;
 //
 l_Count: Integer;
 l_Index: Integer;
 l_Saved: array of WordBool;
begin
 try
  if (HostType = ohaWord) then
  begin
   l_Count := HostApp.Templates.Count;
   //
   SetLength(l_Saved, l_Count);
   for l_Index := 1 to l_Count do
    try
     l_Saved[Pred(l_Index)] := HostApp.Templates.Item(l_Index).Saved;
    except
     l_Count := Pred(l_Index);
     Break;
    end;
   SetLength(l_Saved, l_Count);
  end;
 except
 end;
 try
  l_OnError := OnError;
  try
   OnError := HideErrorMessageBox;
   try
    UpdateCommandBar;
    UpdateVisibility;
   except
   end;
  finally
   OnError := l_OnError;
  end;
 finally
  try
   if (HostType = ohaWord) then
     for l_Index := 1 to l_Count do
      try
       HostApp.Templates.Item(l_Index).Saved := l_Saved[Pred(l_Index)];
      except
      end;
  except
  end;
 end;
end;

procedure TF1ShellAddInModule.WordAppEventsDocumentBeforeClose(a_Sender: TObject; const a_Document: _Document; var a_Cancel: WordBool);
var
 l_OnError: TadxOnError;
 //
 l_Count: Integer;
 l_Index: Integer;
 l_Saved: array of WordBool;
begin
 try
  if (HostType = ohaWord) then
  begin
   l_Count := HostApp.Templates.Count;
   //
   SetLength(l_Saved, l_Count);
   for l_Index := 1 to l_Count do
    try
     l_Saved[Pred(l_Index)] := HostApp.Templates.Item(l_Index).Saved;
    except
     l_Count := Pred(l_Index);
     Break;
    end;
   SetLength(l_Saved, l_Count);
  end;
 except
 end;
 try
  l_OnError := OnError;
  try
   OnError := HideErrorMessageBox;
   try
    UpdateCommandBar;
   except
   end;
  finally
   OnError := l_OnError;
  end;
 finally
  try
   if (HostType = ohaWord) then
     for l_Index := 1 to l_Count do
      try
       HostApp.Templates.Item(l_Index).Saved := l_Saved[Pred(l_Index)];
      except
      end;
  except
  end;
 end;
 try
  if (HostType = ohaWord) then
   HostApp.NormalTemplate.Saved := True;
 except
 end;
end;

procedure TF1ShellAddInModule.WordAppEventsWindowBeforeRightClick(a_Sender: TObject; const a_WordSelection: WordSelection; var a_Cancel: WordBool);
 var
  l_Text: WideString;
  l_TextLength: Integer;
  //
  l_IsNoActiveDocument: Boolean;
  l_IsClipboardHasLink: Boolean;
 //
 procedure UpdateContextMenu(const a_ContextMenu: TadxContextMenu; const a_FindButtonTag: string; const a_LinkButtonTag: string);
 var
  l_Caption: string;
  l_Position: Integer;
  //
  l_CommandBarButton: TadxCommandBarButton;
 begin
  with a_ContextMenu do
  begin
   ReconnectControls; // hacked, now is public method
   //
   l_CommandBarButton := ControlByOfficeTag(a_FindButtonTag).AsButton;
   if (l_CommandBarButton <> nil) then
    with l_CommandBarButton do
    begin
     l_Caption := Caption;
     if (l_Caption <> '') then
     begin
      l_Position := Pos(' "', l_Caption);
      if (l_Position > 0) then
       SetLength(l_Caption, Pred(l_Position));
      //
      if ((l_TextLength > 0) and (l_TextLength <= c_MaxContextMenuFindTextLength)) then
       l_Caption := Format('%s "%s"', [l_Caption, l_Text]);
      //
      Caption := l_Caption;
      Visible := (l_TextLength > 0);
     end;
    end;
   //
   l_CommandBarButton := ControlByOfficeTag(a_LinkButtonTag).AsButton;
   if (l_CommandBarButton <> nil) then
    l_CommandBarButton.Visible := (not l_IsNoActiveDocument and l_IsClipboardHasLink);
  end;
 end;
 //
var
 l_OnError: TadxOnError;
 //
 l_Count: Integer;
 l_Index: Integer;
 l_Saved: array of WordBool;
begin
 try
  if (HostType = ohaWord) then
  begin
   l_Count := HostApp.Templates.Count;
   //
   SetLength(l_Saved, l_Count);
   for l_Index := 1 to l_Count do
    try
     l_Saved[Pred(l_Index)] := HostApp.Templates.Item(l_Index).Saved;
    except
     l_Count := Pred(l_Index);
     Break;
    end;
   SetLength(l_Saved, l_Count);
  end;
 except
 end;
 try
  l_OnError := OnError;
  try
   OnError := HideErrorMessageBox;
   try
    if (a_WordSelection <> nil) then
     l_Text := GetTextFromSelection(a_WordSelection)
    else
     l_Text := GetTextFromSelection(HostApp.Selection);
    //
    l_TextLength := Length(l_Text);
    //
    l_IsNoActiveDocument := IsNoActiveDocument;
    l_IsClipboardHasLink := IsClipboardHasLink;
    //
    UpdateContextMenu(FieldAutoTextContextMenu, '{F0C78A07-2202-4DCA-A348-18298B8F0C85}', '{AA39F8FC-B455-4FC9-9F66-FD7246EAE951}');
    UpdateContextMenu(Grammar1ContextMenu, '{8305528D-4D43-4617-BC41-E0423F2BE1C3}', '{AC47E17E-7373-41A2-B179-7ED841E13232}');
    UpdateContextMenu(Grammar2ContextMenu, '{7A9C15B8-A7C3-4559-AEA5-31BF15F1DCD5}', '{6A2E42A8-9C2A-4B23-82CE-91C26C024681}');
    UpdateContextMenu(HeadingsContextMenu, '{DF09B700-3BB5-4FC8-B53F-5AAFE3A27BE3}', '{B9B987BA-3C4C-45B0-BD5B-E5FAA0AEA46A}');
    UpdateContextMenu(HyperlinkContextMenu, '{C8075016-F35A-4EE5-AFAD-58918E8F5276}', '{D6344799-8B0C-42F1-9846-E119C6078D80}');
    UpdateContextMenu(LinkedTextContextMenu, '{90CC744C-1C23-4501-803E-40A30DE582BE}', '{31525CC8-71E0-4F74-BA7D-7F6F5515D95B}');
    UpdateContextMenu(ListsContextMenu, '{EF962C4C-EF98-4B7E-9119-63BB74CEB004}', '{A39B845F-5EB3-428D-9B79-241980F5D70D}');
    UpdateContextMenu(SpellingContextMenu, '{E49EE176-AB2B-4DD4-8A45-22E394712CE0}', '{5FD095E4-CC04-4151-BDC1-9BEE03C63890}');
    UpdateContextMenu(TableTextContextMenu, '{08F61090-11E3-45EB-9F3A-AE17FB93BC47}', '{6C965221-0E71-4EC6-9969-F106877B5A1E}');
    UpdateContextMenu(TextContextMenu, '{E2F5F160-5EB4-4E6F-BB30-1DD776EF6627}', '{5AB854B0-E032-49F2-A80B-BE30A8CC6BCC}');
   except
   end;
  finally
   OnError := l_OnError;
  end;
 finally
  try
   if (HostType = ohaWord) then
     for l_Index := 1 to l_Count do
      try
       HostApp.Templates.Item(l_Index).Saved := l_Saved[Pred(l_Index)];
      except
      end;
  except
  end;
 end;
end;

procedure TF1ShellAddInModule.ContextMenuFindClick(a_Sender: TObject);
begin
 FindExecute(GetTextFromSelection(HostApp.Selection));
end;

procedure TF1ShellAddInModule.CommandBarFindButtonClick(a_Sender: TObject);
begin
 FindExecute(CommandBarEditBox.Text);
end;

procedure TF1ShellAddInModule.MainReadOnlyRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 SetMainReadOnlyRibbonTabGroupVisible(MainReadOnlyRibbonTabCheckBox.Pressed);
 //
 UpdateMainWritableRibbonTabCheckBox;
 //
 UpdateSelfReadOnlyRibbonTabCheckBox;
 UpdateSelfWritableRibbonTabCheckBox;
 //
 UpdateVisibility;
end;

procedure TF1ShellAddInModule.MainWritableRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 SetMainWritableRibbonTabGroupVisible(MainWritableRibbonTabCheckBox.Pressed);
 //
 UpdateMainReadOnlyRibbonTabCheckBox;
 //
 UpdateSelfReadOnlyRibbonTabCheckBox;
 UpdateSelfWritableRibbonTabCheckBox;
 //
 UpdateVisibility;
end;

procedure TF1ShellAddInModule.SelfReadOnlyRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 SetMainReadOnlyRibbonTabGroupVisible(SelfReadOnlyRibbonTabCheckBox.Pressed);
 //
 UpdateMainReadOnlyRibbonTabCheckBox;
 UpdateMainWritableRibbonTabCheckBox;
 //
 UpdateSelfWritableRibbonTabCheckBox;
 //
 UpdateVisibility;
end;

procedure TF1ShellAddInModule.SelfWritableRibbonTabCheckBoxClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 SetMainWritableRibbonTabGroupVisible(SelfWritableRibbonTabCheckBox.Pressed);
 //
 UpdateMainReadOnlyRibbonTabCheckBox;
 UpdateMainWritableRibbonTabCheckBox;
 //
 UpdateSelfReadOnlyRibbonTabCheckBox;
 //
 UpdateVisibility;
end;

procedure TF1ShellAddInModule.MainReadOnlyRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 FindExecute(MainReadOnlyRibbonEditBox.Text);
end;

procedure TF1ShellAddInModule.MainWritableRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 FindExecute(MainWritableRibbonEditBox.Text);
end;

procedure TF1ShellAddInModule.SelfReadOnlyRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 FindExecute(SelfReadOnlyRibbonEditBox.Text);
end;

procedure TF1ShellAddInModule.SelfWritableRibbonTabFindButtonClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 FindExecute(SelfWritableRibbonEditBox.Text);
end;

procedure TF1ShellAddInModule.CommandBarInfoClick(a_Sender: TObject);
begin
 RibbonTabInfoClick(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabInfoClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 with TF1ShellInfoForm.Create(Self) do
  try
   Caption := Format('%s: Справка', [AddInName]);
   //
   ShowModal;
  finally
   Free;
  end;
end;

procedure TF1ShellAddInModule.CommandBarLinkClick(a_Sender: TObject);
begin
 RibbonTabLinkClick(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabLinkClick(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 if IsClipboardHasLink then
  try
   if (HostMajorVersion < 12) then
    HostApp.Selection.Paste
   else
    if (HostType = ohaOutlook) then
     HostApp.ActiveInspector.CommandBars.ExecuteMSO('Paste')
    else
     HostApp.CommandBars.ExecuteMSO('Paste');
  except
   // ignore any exception
  end
 else
  with TF1ShellLinkInfoForm.Create(Self) do
   try
    Caption := Format('%s: Установить гиперссылку', [AddInName]);
    //
    if (ShowModal <> mrCancel) then
     RibbonTabOpenMainMenu(nil, nil);
   finally
    Free;
   end;
end;

procedure TF1ShellAddInModule.CommandBarOpenMainMenu(a_Sender: TObject);
begin
 RibbonTabOpenMainMenu(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenMainMenu(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TProcessCommandHelper.Create(GC_MAIN_MENU, False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarOpenOnlineNews(a_Sender: TObject);
begin
 RibbonTabOpenOnlineNews(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenOnlineNews(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TProcessCommandHelper.Create(GC_INTERNET_AGENT, False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarOpenPolicies(a_Sender: TObject);
begin
 RibbonTabOpenPolicies(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenPolicies(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TShowLinkHelper.Create(CreateXMLLink(c_PoliciesId), False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarOpenGuide(a_Sender: TObject);
begin
 RibbonTabOpenGuide(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenGuide(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TShowLinkHelper.Create(CreateXMLLink(c_GuideId), False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarOpenBusinessInfo(a_Sender: TObject);
begin
 RibbonTabOpenBusinessInfo(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenBusinessInfo(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TShowLinkHelper.Create(CreateXMLLink(c_BusinessInfoId), False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarOpenAskExpert(a_Sender: TObject);
begin
 RibbonTabOpenAskExpert(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenAskExpert(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TProcessCommandHelper.Create(GC_OPEN_CONSULT, False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarOpenLawMonitoring(a_Sender: TObject);
begin
 RibbonTabOpenLawMonitoring(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenLawMonitoring(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TShowLinkHelper.Create(CreateXMLLink(c_LawMonitoringId), False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarOpenPrime(a_Sender: TObject);
begin
 RibbonTabOpenPrime(a_Sender, nil);
end;

procedure TF1ShellAddInModule.RibbonTabOpenPrime(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 TProcessCommandHelper.Create(GC_PRIME, False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.CommandBarExternalLinkExecute(a_Sender: TObject);
begin
 ShellExecute((a_Sender as TadxCommandBarButton).DescriptionText);
end;

procedure TF1ShellAddInModule.RibbonTabExternalLinkExecute(a_Sender: TObject; const a_RibbonControl: IRibbonControl);
begin
 ShellExecute((a_Sender as TadxRibbonButton).Description);
end;

procedure TF1ShellAddInModule.UpdateCommandBar;
begin
 CommandBar.ReconnectControls;
 //
 SetCommandBarVisible(IsCommandBarPresent);
end;

procedure TF1ShellAddInModule.UpdateVisibility;
var
 l_IsNoActiveDocument: Boolean;
 //
 l_IsMainReadOnlyRibbonTabGroupVisible: Boolean;
 l_IsMainWritableRibbonTabGroupVisible: Boolean;
 //
 l_IsSelfReadOnlyRibbonTabVisible: Boolean;
 l_IsSelfWritableRibbonTabVisible: Boolean;
begin
 l_IsNoActiveDocument := (HostType = ohaWord) and IsNoActiveDocument;
 //
 CommandBarLinkButton.Enabled := not l_IsNoActiveDocument;
 CommandBarLinkButton.Visible := (HostType <> ohaOutlook);
 //
 l_IsMainReadOnlyRibbonTabGroupVisible := IsMainReadOnlyRibbonTabGroupVisible(l_IsNoActiveDocument);
 l_IsMainWritableRibbonTabGroupVisible := IsMainWritableRibbonTabGroupVisible(l_IsNoActiveDocument);
 //
 l_IsSelfReadOnlyRibbonTabVisible := IsSelfReadOnlyRibbonTabVisible(l_IsNoActiveDocument) and not l_IsMainReadOnlyRibbonTabGroupVisible;
 l_IsSelfWritableRibbonTabVisible := IsSelfWritableRibbonTabVisible(l_IsNoActiveDocument) and not l_IsMainWritableRibbonTabGroupVisible;
 //
 if (HostType <> ohaWord) then
 begin
  MainReadOnlyRibbonTabGroup.Visible := l_IsMainReadOnlyRibbonTabGroupVisible;
  SelfReadOnlyRibbonTab.Visible := l_IsSelfReadOnlyRibbonTabVisible;
 end;
 //
 MainWritableRibbonTabGroup.Visible := l_IsMainWritableRibbonTabGroupVisible or ((HostType = ohaWord) and l_IsMainReadOnlyRibbonTabGroupVisible);
 SelfWritableRibbonTab.Visible := l_IsSelfWritableRibbonTabVisible or ((HostType = ohaWord) and l_IsSelfReadOnlyRibbonTabVisible);
 //
 if (HostType = ohaWord) then
 begin
  MainWritableRibbonLinkButton.Visible := not l_IsMainReadOnlyRibbonTabGroupVisible;
  SelfWritableRibbonLinkButton.Visible := not l_IsSelfReadOnlyRibbonTabVisible;
 end; 
end;

procedure TF1ShellAddInModule.UpdateMainReadOnlyRibbonTabCheckBox;
begin
 if (HostType <> ohaWord) then
  MainReadOnlyRibbonTabCheckBox.Pressed := IsMainReadOnlyRibbonTabGroupVisible(False, True);
end;

procedure TF1ShellAddInModule.UpdateMainWritableRibbonTabCheckBox;
begin
 MainWritableRibbonTabCheckBox.Pressed := IsMainWritableRibbonTabGroupVisible((HostType = ohaWord) and IsNoActiveDocument, True);
end;

procedure TF1ShellAddInModule.UpdateSelfReadOnlyRibbonTabCheckBox;
begin
 if (HostType <> ohaWord) then
  SelfReadOnlyRibbonTabCheckBox.Pressed := IsMainReadOnlyRibbonTabGroupVisible(False, True);
end;

procedure TF1ShellAddInModule.UpdateSelfWritableRibbonTabCheckBox;
begin
 SelfWritableRibbonTabCheckBox.Pressed := IsMainWritableRibbonTabGroupVisible((HostType = ohaWord) and IsNoActiveDocument, True);
end;

function TF1ShellAddInModule.GetCachedCommandBarControl(const a_Tag: WideString; var a_CacheVar: TadxCommandBarControl): TadxCommandBarControl;
begin
 if (a_CacheVar = nil) then
  a_CacheVar := f_CommandBar.ControlByOfficeTag(a_Tag);
 //
 Assert(a_CacheVar <> nil, 'CommandBar control not exist');
 //
 Result := a_CacheVar;
end;

function TF1ShellAddInModule.GetCachedRibbonControl(const a_ID: WideString; var a_CacheVar: TObject): TObject;
begin
 if (a_CacheVar = nil) then
  a_CacheVar := FindRibbonControl(a_ID);
 //
 Assert(a_CacheVar <> nil, 'Ribbon control not exist');
 //
 Result := a_CacheVar;
end;

function TF1ShellAddInModule.GetCachedCommandBarButton(const a_Tag: WideString; var a_CacheVar: TadxCommandBarButton): TadxCommandBarButton;
begin
 Result := GetCachedCommandBarControl(a_Tag, TadxCommandBarControl(a_CacheVar)) as TadxCommandBarButton;
end;

function TF1ShellAddInModule.GetCachedRibbonTabCheckBox(const a_ID: WideString; var a_CacheVar: TadxRibbonCheckBox): TadxRibbonCheckBox;
begin
 Result := GetCachedRibbonControl(a_ID, TObject(a_CacheVar)) as TadxRibbonCheckBox;
end;

function TF1ShellAddInModule.GetCachedRibbonTabGroup(const a_ID: WideString; var a_CacheVar: TadxRibbonGroup): TadxRibbonGroup;
begin
 Result := GetCachedRibbonControl(a_ID, TObject(a_CacheVar)) as TadxRibbonGroup;
end;

function TF1ShellAddInModule.GetCachedRibbonButton(const a_ID: WideString; var a_CacheVar: TadxRibbonButton): TadxRibbonButton;
begin
 Result := GetCachedRibbonControl(a_ID, TObject(a_CacheVar)) as TadxRibbonButton;
end;

function TF1ShellAddInModule.GetCommandBarLinkButton: TadxCommandBarButton;
begin
 Result := GetCachedCommandBarButton(c_CommandBarLinkButtonTag, f_CommandBarLinkButton);
end;

function TF1ShellAddInModule.GetMainReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox;
begin
 Result := GetCachedRibbonTabCheckBox(c_MainReadOnlyRibbonTabCheckBoxId, f_MainReadOnlyRibbonTabCheckBox);
end;

function TF1ShellAddInModule.GetMainWritableRibbonTabCheckBox: TadxRibbonCheckBox;
begin
 Result := GetCachedRibbonTabCheckBox(c_MainWritableRibbonTabCheckBoxId, f_MainWritableRibbonTabCheckBox);
end;

function TF1ShellAddInModule.GetSelfReadOnlyRibbonTabCheckBox: TadxRibbonCheckBox;
begin
 Result := GetCachedRibbonTabCheckBox(c_SelfReadOnlyRibbonTabCheckBoxId, f_SelfReadOnlyRibbonTabCheckBox);
end;

function TF1ShellAddInModule.GetSelfWritableRibbonTabCheckBox: TadxRibbonCheckBox;
begin
 Result := GetCachedRibbonTabCheckBox(c_SelfWritableRibbonTabCheckBoxId, f_SelfWritableRibbonTabCheckBox);
end;

function TF1ShellAddInModule.GetMainReadOnlyRibbonTabGroup: TadxRibbonGroup;
begin
 Result := GetCachedRibbonTabGroup(c_MainReadOnlyRibbonTabGroupId, f_MainReadOnlyRibbonTabGroup);
end;

function TF1ShellAddInModule.GetMainWritableRibbonTabGroup: TadxRibbonGroup;
begin
 Result := GetCachedRibbonTabGroup(c_MainWritableRibbonTabGroupId, f_MainWritableRibbonTabGroup);
end;

function TF1ShellAddInModule.GetMainWritableRibbonLinkButton: TadxRibbonButton;
begin
 Result := GetCachedRibbonButton(c_MainWritableRibbonLinkButtonId, f_MainWritableRibbonLinkButton);
end;

function TF1ShellAddInModule.GetSelfWritableRibbonLinkButton: TadxRibbonButton;
begin
 Result := GetCachedRibbonButton(c_SelfWritableRibbonLinkButtonId, f_SelfWritableRibbonLinkButton);
end;

function TF1ShellAddInModule.GetRegistryRoot: HKEY;
begin
 if CheckConfigSection then
  Result := HKEY_CURRENT_USER
 else
  Result := HKEY_LOCAL_MACHINE;
end;

function TF1ShellAddInModule.GetRegistryPath: string;
begin
 Result := Format('Software\Classes\CLSID\%s\Settings', [GUIDToString(CLASS_F1Shell)]);
end;

function TF1ShellAddInModule.GetSettingsValue(const a_Name: string; a_Default: string): string;
begin
 Result := a_Default;
 //
 try
  with TRegistry.Create(KEY_READ) do
   try
    RootKey := GetRegistryRoot;
    //
    if OpenKey(GetRegistryPath, False) then
     try
      Result := ReadString(a_Name);
     finally
      CloseKey;
     end;
   finally
    Free;
   end;
 except
  on ERegistryException do; // ignore
 end;
end;

function TF1ShellAddInModule.GetSettingsValue(const a_Name: string; a_Default: Boolean): Boolean;
begin
 Result := StrToBoolDef(GetSettingsValue(a_Name, BoolToStr(a_Default, True)), a_Default);
end;

procedure TF1ShellAddInModule.PutSettingsValue(const a_Name: string; a_Value: string);
begin
 try
  with TRegistry.Create(KEY_WRITE) do
   try
    RootKey := GetRegistryRoot;
    //
    if OpenKey(GetRegistryPath, True) then
     try
      WriteString(a_Name, a_Value);
     finally
      CloseKey;
     end;
   finally
    Free;
   end;
 except
  on ERegistryException do; // ignore
 end;
end;

procedure TF1ShellAddInModule.PutSettingsValue(const a_Name: string; a_Value: Boolean);
begin
 PutSettingsValue(a_Name, BoolToStr(a_Value, True));
end;

function TF1ShellAddInModule.CreateXMLLink(const a_ID: Cardinal; const a_Point: Cardinal; const a_Type: string): string;
begin
 Result := Format(
  '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'+
  '<bookmark xml_version = "1" id = "%u" point = "%u" point_type = "%s"/>'
  , [a_ID, a_Point, a_Type]
 );
end;

function TF1ShellAddInModule.CreateXMLQuery(const a_Text: string): string;
begin
 Result := Format(
  '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'+
  '<query type="QT_BASE_SEARCH">'+
   '<attribute tag="AT_TEXT_BODY"><text>%s</text></attribute>'+
   '<attribute tag="AT_SHORT_LIST"><text>%s</text></attribute>'+
  '</query>'
  , [AnsiToUtf8(a_Text), AnsiToUtf8('базовый список')]
 );
end;

procedure TF1ShellAddInModule.FindExecute(const a_Text: string);
 //
 function TruncateRightByLimit(const a_String: string): string;
 var
  l_BreakWord: Boolean;
  l_Index: Integer;
 begin
  Result := a_String;
  //
  if (Length(Result) > c_MaxSelectionLength) then
  begin
   l_Index := c_MaxSelectionLength;
   l_BreakWord := (Result[Succ(l_Index)] <> ' ');
   //
   while (l_BreakWord and (l_Index > 0)) do
   begin
    l_BreakWord := (Result[l_Index] <> ' ');
    //
    Dec(l_Index);
   end;
   //
   if (l_Index = 0) then begin
    l_Index := c_MaxSelectionLength;
   end;
   //
   SetLength(Result, l_Index);
   //
   Result := TrimRight(Result);
  end;
 end;
 //
begin
 if (a_Text = '') then
  MessageBox(GetForegroundWindow, PChar('Введите Ваш запрос'), PChar(AddInName),
   MB_ICONINFORMATION + MB_OK + MB_APPLMODAL + MB_TOPMOST)
 else
  TShowLinkHelper.Create(CreateXMLQuery(TruncateRightByLimit(a_Text)), False, c_DefaultTimeOut, AddInName).Resume;
end;

procedure TF1ShellAddInModule.ShellExecute(const a_Params: string);
var
 l_ShellExecuteInfo: TShellExecuteInfo;
begin
 if (a_Params <> '') then
 begin
  FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
  //
  with l_ShellExecuteInfo do
  begin
   cbSize := SizeOf(l_ShellExecuteInfo);
   //
   lpFile := PChar(a_Params);
   nShow := SW_SHOWNORMAL;
  end;
  //
  ShellExecuteEx(@l_ShellExecuteInfo);
 end;
end;

function TF1ShellAddInModule.GetTextFromSelection(const a_WordSelection: OLEVariant): WideString;
var
 l_Dispatch: IDispatch;
 l_WordSelection: WordSelection;
begin
 Result := '';
 //
 try
  l_Dispatch := a_WordSelection;
  l_Dispatch.QueryInterface(WordSelection, l_WordSelection);
  //
  Result := GetTextFromSelection(l_WordSelection);
 except
  // ignore any exception
 end;
end;

function TF1ShellAddInModule.GetTextFromSelection(const a_WordSelection: WordSelection): WideString;
 //
 function RemoveDoubleSpaces(const a_String: WideString): WideString;
 var
  l_Length: Integer;
  //
  l_IndexR: Integer;
  l_IndexS: Integer;
  //
  l_Space: Boolean;
 begin
  l_Length := Length(a_String);
  //
  SetLength(Result, l_Length);
  //
  l_Space := False;
  l_IndexR := 1;
  //
  for l_IndexS := 1 to l_Length do
  begin
   if a_String[l_IndexS] = WideChar(' ') then
   begin
    if not (l_Space) then
    begin
     Result[l_IndexR] := WideChar(' ');
     //
     l_Space := True;
     Inc(l_IndexR);
    end
   end
   else
   begin
    Result[l_IndexR] := a_String[l_IndexS];
    //
    l_Space := False;
    Inc(l_IndexR);
   end;
  end;
  //
  SetLength(Result, Pred(l_IndexR));
 end;
 //
const
 c_MaxSelectionLength = 1024;
var
 l_Count: Integer;
 l_Index: Integer;
 l_Length: Integer;
begin
 Result := '';
 //
 if (a_WordSelection <> nil) then
  with a_WordSelection do
  begin
   Result := Range.Text;
   //
   if Result = '' then
   begin
    if (Words.Count = 1) then
     Result := Words.First.Text
    else
     Result := Text;
   end;
   //
   l_Length := Length(Result);
   //
   l_Count := 0;
   l_Index := 1;
   //
   while (l_Index <= l_Length) do
   begin
    if ((Result[l_Index] <= WideChar(' ')) or (Result[l_Index] = WideChar('"'))) then
     Result[l_Index] := ' '
    else
     Inc(l_Count);
    //
    if (l_Count > c_MaxSelectionLength) then
     Break;
    //
    Inc(l_Index);
   end;
   //
   SetLength(Result, Pred(l_Index));
   //
   Result := Trim(RemoveDoubleSpaces(Result));
  end;
end;

function TF1ShellAddInModule.CommandBarVisibleSettingsName: string;
begin
 Result := Format('%s::CommandBar.Visible', [adxOfficeAppNames[HostType]]);
end;

function TF1ShellAddInModule.MainRibbonTabGroupVisibleSettingsName(const a_ReadOnly: Boolean): string;
var
 l_ReadOnly: string;
begin
 l_ReadOnly := '';
 //
 if ((HostType = ohaOutlook) and a_ReadOnly) then
  l_ReadOnly := 'ReadOnly';
 //
 Result := Format('%s::MainRibbonTabGroup%s.Visible', [adxOfficeAppNames[HostType], l_ReadOnly]);
end;

function TF1ShellAddInModule.IsClipboardHasLink: Boolean;
begin
 Result := Clipboard.HasFormat(g_EverestClipboardId);
end;

function TF1ShellAddInModule.IsNoActiveDocument: Boolean;
var
 l_WordDocument: WordDocument;
begin
 l_WordDocument := nil;
 //
 try
  l_WordDocument := WordApp.ActiveDocument;
 except
  on EOleError do; // ignore
 end;
 //
 Result := (l_WordDocument = nil);
end;

function TF1ShellAddInModule.IsCommandBarPresent: Boolean;
begin
 with f_CommandBar do
 begin
  Result := (FindCommandBar(CommandBarName) <> nil);
  //
  if (Result) then
   Result := Enabled and Visible;
 end;
end;

function TF1ShellAddInModule.IsCommandBarVisible: Boolean;
begin
 Result := GetSettingsValue(CommandBarVisibleSettingsName, True);
end;

procedure TF1ShellAddInModule.SetCommandBarVisible(const a_Value: Boolean);
begin
 try // K439420501 
  if (HostApp.Visible) then
   PutSettingsValue(CommandBarVisibleSettingsName, a_Value);
 except
 end;
 CommandBar.Visible := IsCommandBarVisible;
end;

function TF1ShellAddInModule.IsMainReadOnlyRibbonTabGroupVisible(const a_IsNoActiveDocument: Boolean; const a_ForceSettings: Boolean): Boolean;
begin
 Result := (GetSettingsValue(MainRibbonTabGroupVisibleSettingsName(True), True) and (a_ForceSettings or IsSelfReadOnlyRibbonTabVisible(a_IsNoActiveDocument)));
end;

procedure TF1ShellAddInModule.SetMainReadOnlyRibbonTabGroupVisible(const a_Value: Boolean);
begin
 PutSettingsValue(MainRibbonTabGroupVisibleSettingsName(True), a_Value);
end;

function TF1ShellAddInModule.IsMainWritableRibbonTabGroupVisible(const a_IsNoActiveDocument: Boolean; const a_ForceSettings: Boolean): Boolean;
begin
 Result := (GetSettingsValue(MainRibbonTabGroupVisibleSettingsName(False), True) and (a_ForceSettings or IsSelfWritableRibbonTabVisible(a_IsNoActiveDocument)));
end;

procedure TF1ShellAddInModule.SetMainWritableRibbonTabGroupVisible(const a_Value: Boolean);
begin
 PutSettingsValue(MainRibbonTabGroupVisibleSettingsName(False), a_Value);
end;

function TF1ShellAddInModule.IsSelfReadOnlyRibbonTabVisible(const a_IsNoActiveDocument: Boolean): Boolean;
begin
 Result := ((HostType <> ohaWord) or a_IsNoActiveDocument);
end;

function TF1ShellAddInModule.IsSelfWritableRibbonTabVisible(const a_IsNoActiveDocument: Boolean): Boolean;
begin
 Result := ((HostType <> ohaWord) or not a_IsNoActiveDocument);
end;

procedure TF1ShellAddInModule.adxCOMAddInModuleHostAppSet(Sender: TObject);
var
 l_TabName : string;
begin
 // K 431359970 : setting up correct ribbon tab name
 // when getting host application type (before AddInInitialize event)
 if HostType = ohaWord then
  l_TabName := 'TabHome'
 else if HostType = ohaOutLook then
 begin
  l_TabName := 'TabNewMailMessage';
  f_CommandBar.Temporary := False;
 end;
 f_MainWritableRibbonTab.IdMso := l_TabName;
end;

function TF1ShellAddInModule.GetMainReadOnlyRibbonEditBox: TadxRibbonEditBox;
begin
 Result := GetCachedRibbonEditBox(c_MainReadOnlyRibbonEditBoxId, f_MainReadOnlyRibbonEditBox);
end;

function TF1ShellAddInModule.GetMainWritableRibbonEditBox: TadxRibbonEditBox;
begin
 Result := GetCachedRibbonEditBox(c_MainWritableRibbonEditBoxId, f_MainWritableRibbonEditBox);
end;

function TF1ShellAddInModule.GetSelfReadOnlyRibbonEditBox: TadxRibbonEditBox;
begin
 Result := GetCachedRibbonEditBox(c_SelfReadOnlyRibbonEditBoxId, f_SelfReadOnlyRibbonEditBox);
end;

function TF1ShellAddInModule.GetSelfWritableRibbonEditBox: TadxRibbonEditBox;
begin
 Result := GetCachedRibbonEditBox(c_SelfWritableRibbonEditBoxId, f_SelfWritableRibbonEditBox);
end;

function TF1ShellAddInModule.GetCachedRibbonEditBox(const a_ID: WideString;
  var a_CacheVar: TadxRibbonEditBox): TadxRibbonEditBox;
begin
 Result := GetCachedRibbonControl(a_ID, TObject(a_CacheVar)) as TadxRibbonEditBox;
end;

function TF1ShellAddInModule.GetCommandBarEditBox: TadxCommandBarEdit;
begin
 Result := GetCachedCommandBarEditBox(c_CommandBarEditBoxTag, f_CommandBarEditBox);
end;

function TF1ShellAddInModule.GetCachedCommandBarEditBox(
  const a_Tag: WideString;
  var a_CacheVar: TadxCommandBarEdit): TadxCommandBarEdit;
begin
 Result := GetCachedCommandBarControl(a_Tag, TadxCommandBarControl(a_CacheVar)) as TadxCommandBarEdit;
end;

var
 g_CALLWNDPROC_Hook: HHOOK;

function CALLWNDPROC_Hook(a_Code: Integer; a_WParam: WPARAM; a_LParam: LPARAM): LRESULT; stdcall;
 //
 function GetText(const a_HWND: HWND): string;
 var
  l_Length: Integer;
 begin
  Result := '';
  //
  if (a_HWND <> HWND(0)) then
  begin
   l_Length := GetWindowTextLength(a_HWND);
   //
   if (l_Length > 0) then
   begin
    Inc(l_Length);
    SetLength(Result, l_Length);
    //
    GetWindowText(a_HWND, PChar(Result), l_Length);
    //
    Result := PChar(Result);
   end;
  end;
 end;
 //
 function IsCommandBarEditBox(const a_HWND: HWND): Boolean;
  //
  function GetClass(const a_HWND: HWND): string;
  var
   l_Buffer: array [0..MAX_PATH] of Char;
  begin
   Result := '';
   //
   if (GetClassName(a_HWND, l_Buffer, SizeOf(l_Buffer)) <> 0) then
    Result := l_Buffer;
  end;
  //
 begin
  Result := (
   AnsiSameText(GetClass(a_HWND), 'RichEdit20W') and
   AnsiSameText(GetText(GetParent(a_HWND)), 'ГАРАНТ')
  );
 end;
 //
begin
 if (a_Code = HC_ACTION) then
  with PCWPStruct(a_LParam)^ do
   if ((Message = WM_KILLFOCUS) and IsCommandBarEditBox(hWND) and (g_CommandBarEditBox <> nil)) then
    g_CommandBarEditBox.Text := GetText(hWND);
 //
 Result := CallNextHookEx(g_CALLWNDPROC_Hook, a_Code, a_WParam, a_LParam);
end;

initialization
 TadxFactory.Create(ComServer, TF1Shell, CLASS_F1Shell, TF1ShellAddInModule);
 //
 g_EverestClipboardId := RegisterClipboardFormat('Everest Editor v1.0 (Binary)');
 //
 g_CALLWNDPROC_Hook := SetWindowsHookEx(WH_CALLWNDPROC, @CALLWNDPROC_Hook, HInstance, GetCurrentThreadId);
finalization
 UnhookWindowsHookEx(g_CALLWNDPROC_Hook);
end.
