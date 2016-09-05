unit nscSystemProgressDialog;

interface
uses
 Windows,
 ShellApi;

const
 // IProgressDialog
 CLSID_ProgressDialog: TGUID      = '{F8383852-FCD3-11D1-A6B9-006097DF5BD4}';
 {$EXTERNALSYM CLSID_ProgressDialog}
 // Progress objects exposed via QueryService
 SID_SProgressUI: TGUID           = '{F8383852-FCD3-11D1-A6B9-006097DF5BD4}'; //CLSID_ProgressDialog;
 {$EXTERNALSYM SID_SProgressUI}
 SID_IProgressDialog              = '{EBBC7C04-315E-11D2-B62F-006097DF5BD4}';
 IID_IProgressDialog: TGUID       = SID_IProgressDialog;
 // Flags for IProgressDialog::StartProgressDialog() (dwFlags)
 // The flag space includes OPPROGDLG_ and PROGDLG_ values, please guarantee they don't conflict. See shobjidl.idl for OPPROGDLG_*
 PROGDLG_NORMAL = $00000000;               // default normal progress dlg behavior
 {$EXTERNALSYM PROGDLG_NORMAL}
 PROGDLG_MODAL = $00000001;                // the dialog is modal to its hwndParent (default is modeless)
 {$EXTERNALSYM PROGDLG_MODAL}
 PROGDLG_AUTOTIME = $00000002;             // automatically updates the "Line3" text with the "time remaining" (you cant call SetLine3 if you passs this!)
 {$EXTERNALSYM PROGDLG_AUTOTIME}
 PROGDLG_NOTIME = $00000004;               // we dont show the "time remaining" if this is set. We need this if dwTotal < dwCompleted for sparse files
 {$EXTERNALSYM PROGDLG_NOTIME}
 PROGDLG_NOMINIMIZE = $00000008;           // Do not have a minimize button in the caption bar.
 {$EXTERNALSYM PROGDLG_NOMINIMIZE}
 PROGDLG_NOPROGRESSBAR = $00000010;        // Don't display the progress bar
 {$EXTERNALSYM PROGDLG_NOPROGRESSBAR}
 PROGDLG_MARQUEEPROGRESS = $00000020;      // Use marquee progress (comctl32 v6 required)
 {$EXTERNALSYM PROGDLG_MARQUEEPROGRESS}
 PROGDLG_NOCANCEL = $00000040;             // No cancel button (operation cannot be canceled) (use sparingly)
 {$EXTERNALSYM PROGDLG_NOCANCEL}

 // Time Actions (dwTimerAction)
 PDTIMER_RESET = $00000001;             // Reset the timer so the progress will be calculated from now until the first ::SetProgress() is called so
 {$EXTERNALSYM PDTIMER_RESET}
                                        // those this time will correspond to the values passed to ::SetProgress().  Only do this before ::SetProgress() is called.
 PDTIMER_PAUSE = $00000002;             // Progress has been suspended
 {$EXTERNALSYM PDTIMER_PAUSE}
 PDTIMER_RESUME = $00000003;            // Progress has resumed
 {$EXTERNALSYM PDTIMER_RESUME}

type
 IProgressDialog = interface(IUnknown)
 [SID_IProgressDialog]
  function StartProgressDialog(hwndParent: HWND; const punkEnableModless: IUnknown;
   dwFlags: DWORD; var pvResevered: Pointer): HRESULT; stdcall;
  function StopProgressDialog: HRESULT; stdcall;
  function SetTitle(pwzTitle:LPCWSTR): HRESULT; stdcall;
  function SetAnimation(hInstAnimation: HINST; idAnimation: UINT): HRESULT; stdcall;
  function HasUserCancelled: BOOL; stdcall;
  function SetProgress(dwCompleted, dwTotal: DWORD): HRESULT; stdcall;
  function SetProgress64(ullCompleted, ullTotal: UINT64): HRESULT; stdcall;
  function SetLine(dwLineNum: DWORD; pwzString: LPCWSTR; fCompactPath: BOOL;
   var pvResevered: Pointer): HRESULT; stdcall;
  function SetCancelMsg(pwzCancelMsg: LPCWSTR; var pvResevered: Pointer): HRESULT; stdcall;
  function Timer(dwTimerAction: DWORD; var pvResevered: Pointer): HRESULT; stdcall;
 end;

const
 FOF_NOCANCEL = $0800; // disabled cancel button

 SHGFP_TYPE_CURRENT = 0; { current value for user, verify it exists }
 SHGFP_TYPE_DEFAULT = 1; { default value, may not exist }

function GetProgressDialog: IProgressDialog;
procedure StopProgressDialog(const ADialog: IProgressDialog);

implementation
uses
 SysUtils,
 ActiveX;

function GetProgressDialog: IProgressDialog;
var
 l_progressDialog: IProgressDialog;
begin
 Result := nil;
 if (LOBYTE(LOWORD(GetVersion)) < 5) then // under Windows 2000
  Exit;
 try
  if (CoCreateInstance(CLSID_ProgressDialog, nil, CLSCTX_INPROC_SERVER, IID_IProgressDialog,
   l_progressDialog) = S_OK) then
    Result := l_progressDialog;
 except
 end;
end;

procedure StopProgressDialog(const ADialog: IProgressDialog);
var
 l_DlgHWND: HWND;
 l_OleWindow: IOleWindow;
 l_hr: HRESULT;
begin
 Assert(ADialog <> nil);
 if Supports(ADialog, IOleWindow, l_OleWindow) then
 try
  if (not Succeeded(l_OleWindow.GetWindow(l_DlgHWND))) then
   l_DlgHWND := 0;
 finally
  l_OleWindow := nil;
 end;
 ADialog.StopProgressDialog;
 if (l_DlgHWND <> 0) then
  ShowWindow(l_DlgHWND, SW_HIDE);
end;

end.