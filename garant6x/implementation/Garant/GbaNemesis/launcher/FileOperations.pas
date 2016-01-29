unit FileOperations;

interface
uses
 Windows, ShellApi, SysUtils;

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

 PProgressInfoStruct = ^TProgressInfoStruct;
 TProgressInfoStruct = record
  ProgressDialog: IProgressDialog;
  TotalSize: UINT64;
  DoneSize: UINT64;
  ShowFileNames: boolean;
  SourceFileName: string;
  DestFileName: string;
 end;

 EFileOperationUserAbort = class(Exception);

 function FileOperation(var aFileOp: TSHFileOpStruct): Integer;

 function CopyProgressRoutine(aTotalFileSize: TLargeInteger;
  aTotalBytesTransferred: TLargeInteger; aStreamSize: TLargeInteger;
  aStreamBytesTransferred: TLargeInteger; aStreamNumber: DWORD;
  aCallbackReason: DWORD; aSourceFile: THandle; aDestinationFile: THandle;
  aData: pointer): DWORD; stdcall;

const
 FOF_NOCANCEL = $0800; // disabled cancel button

 SHGFP_TYPE_CURRENT = 0; { current value for user, verify it exists }
 SHGFP_TYPE_DEFAULT = 1; { default value, may not exist }

implementation
uses
 ActiveX, ShlObj, Classes;

const
 c_AllFilesMask = '*.*';

function AnsiToWide(aText: AnsiString): WideString;
var
 l_wText: PWideChar;
 l_ansiSize: integer;
 l_wideSize: integer;
begin
 l_wText := nil;
 Result := '';
 if (aText = '') then
  Exit;
 try
  l_ansiSize := Length(aText) + 1;
  l_wideSize := l_ansiSize * SizeOf(WideChar);
  l_wText := AllocMem(l_wideSize);
  try
   MultiByteToWideChar(CP_ACP, 0, PChar(aText), l_ansiSize, l_wText, l_wideSize);
   Result := l_wText;
  finally
   FreeMem(l_wText);
  end;
 except
 end;
end;

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

{$R-}
procedure GetFilesSize(const aPath: PChar; out aSize: UINT64);
var
 l_SearchRec: TSearchRec;
 l_SearchResult: Integer;
 l_fileSize: integer;
 l_filePath: string;
 l_sizeInDir: UINT64;
begin
 l_sizeInDir := 0;
 l_SearchResult := FindFirst(aPath, Integer(faAnyFile), l_SearchRec);
 try
  while (l_SearchResult = 0) do
  begin
   l_filePath := '';
   if ((l_SearchRec.Name = '.') or (l_SearchRec.Name = '..')) then
   begin
    l_SearchResult := FindNext(l_SearchRec);
    Continue;
   end;
   if ((l_SearchRec.Attr and Integer(faDirectory)) = 0) then
    aSize := aSize + l_SearchRec.Size
   else
   begin
    l_filePath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(aPath)) + l_SearchRec.Name) +
     c_AllFilesMask;
    GetFilesSize(PChar(l_filePath), l_sizeInDir);
    aSize := aSize + l_sizeInDir;
   end;
   l_SearchResult := FindNext(l_SearchRec);
  end;
 finally
  FindClose(l_SearchRec);
 end;
end;
{$R+}

function FileOperationInternal(var aFileOp: TSHFileOpStruct;
 aProgressInfoStruct: PProgressInfoStruct): Integer;
var
 l_SearchRec: TSearchRec;
 l_SearchResult: Integer;
 l_fromFileName: string;
 l_toFileName: string;
 l_result: BOOL;
 l_recFileOpStruct: TSHFileOpStruct;
 l_isDirectory: boolean;

 function IsAborted: boolean;
 begin
  Result := False;
  if (aProgressInfoStruct <> nil) and (aProgressInfoStruct^.ProgressDialog <> nil) then
   Result := aProgressInfoStruct^.ProgressDialog.HasUserCancelled;
 end;

begin
 Result := S_OK;
 l_SearchResult := FindFirst(aFileOp.pFrom, Integer(faAnyFile), l_SearchRec);
 try
  while (l_SearchResult = 0) do
  begin
   l_result := True;
   l_fromFileName := '';
   l_toFileName := '';

   if ((l_SearchRec.Name = '.') or (l_SearchRec.Name = '..')) then
   begin
    l_SearchResult := FindNext(l_SearchRec);
    Continue;
   end;

   l_isDirectory := ((l_SearchRec.Attr and Integer(faDirectory)) <> 0);

   if (aFileOp.wFunc <> FO_RENAME) then
    l_toFileName := IncludeTrailingPathDelimiter(aFileOp.pTo) +
     ExtractFileName(l_SearchRec.Name)
   else
    l_toFileName := aFileOp.pTo;

   if (not l_isDirectory) then
    l_fromFileName := IncludeTrailingPathDelimiter(ExtractFilePath(aFileOp.pFrom)) +
     ExtractFileName(l_SearchRec.Name)
   else
   begin
    l_fromFileName := IncludeTrailingPathDelimiter(ExtractFilePath(aFileOp.pFrom)) +
     IncludeTrailingPathDelimiter(ExtractFileName(l_SearchRec.Name)) + c_AllFilesMask;
    FillChar(l_recFileOpStruct, SizeOf(l_recFileOpStruct), 0);
    l_recFileOpStruct.wFunc := aFileOp.wFunc;
    l_recFileOpStruct.pFrom := PChar(l_fromFileName);
    l_recFileOpStruct.pTo := PChar(l_toFileName);
    l_recFileOpStruct.fFlags := aFileOp.fFlags;
   end;

   if (aProgressInfoStruct <> nil) then
   begin
    aProgressInfoStruct^.SourceFileName := l_fromFileName;
    aProgressInfoStruct^.DestFileName := l_toFileName;
   end;

   case aFileOp.wFunc of
    FO_COPY:
     if (not l_isDirectory) then
      l_result := CopyFileEx(PChar(l_fromFileName), PChar(l_toFileName),
       @CopyProgressRoutine, aProgressInfoStruct, nil, 0)
     else
      if ForceDirectories(l_toFileName) then
       l_result := (FileOperationInternal(l_recFileOpStruct, aProgressInfoStruct) = S_OK);
    FO_MOVE, FO_RENAME:
     if (not l_isDirectory) then
      l_result := MoveFileWithProgress(PChar(l_fromFileName), PChar(l_toFileName),
       @CopyProgressRoutine, aProgressInfoStruct, 0)
     else
      if (ForceDirectories(l_toFileName)) then
       if (FileOperationInternal(l_recFileOpStruct, aProgressInfoStruct) = S_OK) then
        l_result := RemoveDirectory(PChar(ExtractFilePath(l_fromFileName)));
    FO_DELETE:
     if not l_isDirectory then
      l_result := DeleteFile(l_fromFileName)
     else
      if (FileOperationInternal(l_recFileOpStruct, aProgressInfoStruct) = S_OK) then
       RemoveDirectory(PChar(ExtractFilePath(l_fromFileName)));
   end;
   if IsAborted then
    Raise(EFileOperationUserAbort.Create(''));
   l_SearchResult := FindNext(l_SearchRec);
  end;
 finally
  SysUtils.FindClose(l_SearchRec);
  if (not l_result) then
   Result := S_FALSE;
 end;
end;

function FileOperation(var aFileOp: TSHFileOpStruct): Integer;
var
 l_progressDialog: IProgressDialog;
 l_progressInfoStruct: PProgressInfoStruct;
 l_progressDialogFlags: DWORD;
 l_nilPointer: pointer;
 l_showDialog: HRESULT;
 l_progressTitleA: string;
 l_progressTitleW: WideString;
begin
 Result := S_FALSE;
 aFileOp.fAnyOperationsAborted := False;
 if (LOWORD(LOBYTE(LOWORD(GetVersion))) < 5) then
 begin
  Result := SHFileOperation(aFileOp);
  Exit;
 end;
 l_progressInfoStruct := nil;
 l_progressDialog := nil;
 l_showDialog := S_FALSE;
 if ((aFileOp.fFlags and FOF_SILENT) = 0) then
 begin
  l_progressDialog := GetProgressDialog;
  if (l_progressDialog <> nil) then
  begin
   l_progressTitleA := aFileOp.lpszProgressTitle;
   l_progressTitleW := AnsiToWide(l_progressTitleA);
   l_progressDialog.SetTitle(PWideChar(l_progressTitleW));
  end;
  try
   GetMem(l_progressInfoStruct, SizeOf(TProgressInfoStruct));
   FillChar(l_progressInfoStruct^, SizeOf(TProgressInfoStruct), 0);
   with l_progressInfoStruct^ do
   begin
    ProgressDialog := l_progressDialog;
{$R-}
    GetFilesSize(aFileOp.pFrom, TotalSize);
    DoneSize := 0;
{$R+}
    ShowFileNames := ((aFileOp.fFlags and FOF_SIMPLEPROGRESS) <> 0);
   end;
   l_progressDialogFlags := PROGDLG_NORMAL;
   if ((aFileOp.fFlags and FOF_NOCANCEL) <> 0) then
    l_progressDialogFlags := l_progressDialogFlags or PROGDLG_NOCANCEL;
   if (aFileOp.wFunc in [FO_DELETE, FO_MOVE]) then
   begin
    if (LOBYTE(LOWORD(GetVersion)) >= 6) then // Vista up
     l_progressDialogFlags := l_progressDialogFlags or PROGDLG_MARQUEEPROGRESS
    else
     l_progressDialogFlags := l_progressDialogFlags or PROGDLG_NOPROGRESSBAR;
   end;
   l_nilPointer := nil;
   l_showDialog := l_progressInfoStruct.ProgressDialog.StartProgressDialog(0, nil, l_progressDialogFlags or PROGDLG_MODAL, l_nilPointer);
  except
  end;
 end;
 try
  try
   Result := FileOperationInternal(aFileOp, l_progressInfoStruct);
  except
   on E: EFileOperationUserAbort do
   begin
    Result := S_FALSE;
    Exit;
   end;
  end;
 finally
  if l_progressInfoStruct <> nil then
  begin
   try
    if ((l_progressInfoStruct.ProgressDialog <> nil) and (l_showDialog = S_OK)) then
     l_progressInfoStruct.ProgressDialog.StopProgressDialog;
   finally
    FreeMem(l_progressInfoStruct);
   end;
  end;
  aFileOp.fAnyOperationsAborted := (Result <> S_OK);
 end;
end;

function CopyProgressRoutine(aTotalFileSize: TLargeInteger;
  aTotalBytesTransferred: TLargeInteger; aStreamSize: TLargeInteger;
  aStreamBytesTransferred: TLargeInteger; aStreamNumber: DWORD;
  aCallbackReason: DWORD; aSourceFile: THandle; aDestinationFile: THandle;
  aData: pointer): DWORD; stdcall;
var
 l_progressDialog: IProgressDialog;
 l_doneSize: Int64;
 l_totalSize: Int64;
 l_nilPointer: pointer;
 l_percentDone: Integer;
begin
 Result := PROGRESS_QUIET;
 if aData = nil then
  Exit;
 try
{$R-}
  if supports(PProgressInfoStruct(adata)^.ProgressDialog, IID_IProgressDialog, l_progressDialog) then
  begin
   l_doneSize := PProgressInfoStruct(aData)^.DoneSize + aTotalBytesTransferred;
   l_totalSize := PProgressInfoStruct(aData)^.TotalSize;
   l_percentDone := l_doneSize div (l_totalSize div 100);
   l_progressDialog.SetProgress64(l_doneSize, l_totalSize);
   l_nilPointer := nil;
   if PProgressInfoStruct(aData)^.ShowFileNames then
   begin
    l_ProgressDialog.SetLine(1, PWideChar(AnsiToWide(Format('%d%s', [l_percentDone, '%']))), True, l_nilPointer);
    l_ProgressDialog.SetLine(2, PWideChar(AnsiToWide(PProgressInfoStruct(aData)^.SourceFileName)), True, l_nilPointer);
    l_ProgressDialog.SetLine(3, PWideChar(AnsiToWide(PProgressInfoStruct(aData)^.DestFileName)), True, l_nilPointer);
   end;
   if l_ProgressDialog.HasUserCancelled then
    Result := PROGRESS_CANCEL
   else
    Result := PROGRESS_CONTINUE;
   if aTotalBytesTransferred = aTotalFileSize then
    PProgressInfoStruct(aData)^.DoneSize := PProgressInfoStruct(aData)^.DoneSize + aTotalBytesTransferred;
{$R+}
  end;
 except
 end;
end;


end.
