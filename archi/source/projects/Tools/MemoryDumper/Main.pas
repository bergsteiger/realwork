unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TThreadFunc = function (hThread: THandle): DWORD; stdcall;

  TForm3 = class(TForm)
    ProcessListBox: TListBox;
    Label1: TLabel;
    Button1: TButton;
    OutDir: TEdit;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    LogMemo: TMemo;
    Label3: TLabel;
    SuspendCheck: TCheckBox;
    WriteCheck: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    f_Report: TStream;
    f_Buffer: Pointer;
    f_BufferSize: Cardinal;
    procedure FillProcessList(aList: TListBox);
    procedure MakeDump(const outDir, aProcessName: String; aProcessID: DWORD; SuspendThreads, WriteDump: Boolean);
    procedure DumpRegion(aProcess: THandle; const anInfo: TMemoryBasicInformation; const OutDir: String; WriteDump: Boolean);
    procedure ClearLog;
    procedure AddToLog(const aStr: String);
    procedure AddToReport(const aFile: TSTream; const aStr: String);
    procedure CheckBufferSize(aNewSize: Cardinal);
    procedure FreeBuffer;
    procedure ProcessThreads(aSnapShot: THandle; aFunc: TThreadFunc);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
 TlHelp32,
 FileCtrl,

 l3FileUtils;

{$R *.dfm}

{ TForm3 }

procedure TForm3.FillProcessList(aList: TListBox);
var
 l_SnapShot: THandle;
 l_Entry: TProcessEntry32;
begin
 aList.Items.Clear;
 l_SnapShot := CreateToolHelp32SnapShot(TH32CS_SNAPPROCESS, 0);
 try
  l_Entry.dwSize := SizeOf(l_Entry);
  if Process32First(l_SnapShot, l_Entry) then
  begin
   repeat
    aList.Items.AddObject(ExtractFileName(l_Entry.szExeFile), Pointer(l_Entry.th32ProcessID));
   until not Process32Next(l_SnapShot, l_Entry);
  end;
 finally
  CloseHandle(l_SnapShot);
 end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
 FillProcessList(ProcessListBox);
 OutDir.Text := ExtractFilePath(ParamStr(0));
end;

procedure TForm3.Button1Click(Sender: TObject);
var
 l_OutDir: String;
begin
 if ProcessListBox.ItemIndex = -1 then
  raise Exception.Create('Unspecified process');
 l_OutDir := OutDir.Text;
 if l_OutDir = '' then
  l_OutDir := ExtractFilePath(ParamStr(0));
 ForceDirectories(l_OutDir);
 if not DirectoryExists(l_OutDir) then
  raise Exception.Create('Unspecified out folder');
 MakeDump(l_OutDir, ProcessListBox.Items[ProcessListBox.ItemIndex],
   DWORD(ProcessListBox.Items.Objects[ProcessListBox.ItemIndex]),
   SuspendCheck.Checked, WriteCheck.Checked);
end;

procedure TForm3.MakeDump(const outDir, aProcessName: String; aProcessID: DWORD; SuspendThreads, WriteDump: Boolean);
var
 l_SnapShot: THandle;
 l_Process: THandle;
 l_Info: TMemoryBasicInformation;
 l_Ptr: PAnsiChar;
 l_Res: LongWord;
 l_Module: TModuleEntry32;
begin
 DeleteFilesByMask(outDir, '*.MemDump');
 ClearLog;
 f_Report := TFileStream.Create(ConcatDirName(OutDir, ChangeFileExt(ExtractFileName(aProcessName), '.MemDump')), fmCreate);
 try
  l_SnapShot := CreateToolHelp32SnapShot(TH32CS_SNAPMODULE or TH32CS_SNAPTHREAD or TH32CS_SNAPHEAPLIST, aProcessID);
  try
   if SuspendThreads then
    ProcessThreads(l_SnapShot, SuspendThread);
   try
    AddToLog(Format('Making Dump for process %s (%d)', [aProcessName, aProcessID]));
    l_Module.dwSize := SizeOf(l_Module);
    if Module32First(l_SnapShot, l_Module) then
    begin
     AddToLog(Format('MODULE %s %s', [l_Module.szModule, l_Module.szExePath]));
     if l_Module.th32ProcessID <> aProcessID then
      raise Exception.Create('Process failed');
    end
    else
    begin
     AddToLog('Protected or 64-bit process. Unable to dump');
     Exit;
    end;
    l_Process := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, aProcessID);
    try
     if l_Process = 0 then
      RaiseLastOSError;
     CheckBufferSize(10*1024*1024);
     l_Ptr := Pointer(0);
     l_Res := VirtualQueryEx(l_Process, l_Ptr, l_Info, SizeOf(l_Info));
     if l_Res <> SizeOf(l_Info) then
      RaiseLastOSError;
     while l_Res = SizeOf(l_Info) do
     begin
      DumpRegion(l_Process, l_Info, OutDir, WriteDump);
      Inc(l_Ptr, l_Info.RegionSize);
      l_Res := VirtualQueryEx(l_Process, l_Ptr, l_Info, SizeOf(l_Info));
     end;
    finally
     CloseHandle(l_Process);
    end;
   finally
    if SuspendThreads then
     ProcessThreads(l_SnapShot, ResumeThread);
   end;
  finally
   CLoseHandle(l_SnapShot);
  end;
 finally
  FreeAndNil(f_Report);
 end;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
var
 l_Dir: String;
begin
 l_Dir := OutDir.Text;
 if SelectDirectory('Out folder', '', l_Dir) then
  OutDir.Text := l_Dir;
end;

procedure TForm3.DumpRegion(aProcess: THandle; const anInfo: TMemoryBasicInformation; const OutDir: String; WriteDump: Boolean);
var
 l_State: String;
 l_End: PAnsiChar;
 l_Protect: String;
 l_Size: Cardinal;
 l_RegionReport: TStream;
begin
 case anInfo.State of
  MEM_COMMIT: l_State := '[COMMITED]';
  MEM_FREE: l_State := '[FREE]';
  MEM_RESERVE: l_State := '[RESERVED]';
 else
  l_State := '[UNKNOWN]';
 end;
 if (anInfo.Protect and (PAGE_EXECUTE or PAGE_EXECUTE_READ)) <> 0 then
  l_Protect := '[EXECUTABLE] '
 else
  l_Protect := '';
 l_End := PAnsiChar(anInfo.BaseAddress) + anInfo.RegionSize;
 if Cardinal(l_End) < Cardinal(anInfo.BaseAddress) then
 begin
  AddToLog(Format('[INVALID REGION ] %p-%p %s', [anInfo.BaseAddress, Pointer(l_End), FormatFloat('#,##0', anInfo.RegionSize)]));
  Abort;
 end;
 AddToLog(Format('%s%p-%p %s %s', [l_Protect, anInfo.BaseAddress, Pointer(l_End), l_State, FormatFloat('#,##0', anInfo.RegionSize)]));
 if WriteDump then
 begin
  CheckBufferSize(anInfo.RegionSize);
  if anInfo.State = MEM_COMMIT then
  begin
   if ReadProcessMemory(aProcess, anInfo.BaseAddress, f_Buffer, anInfo.RegionSize, l_Size) then
   begin
    Assert(anInfo.RegionSize = l_Size);
    l_RegionReport := TFileStream.Create(ConcatDirName(OutDir, Format('%p [%s].MemDump', [anInfo.BaseAddress, FormatFloat('#,##0', anInfo.RegionSize)])), fmCreate);
    try
     l_RegionReport.Write(f_Buffer^, l_Size);
    finally
     FreeAndNil(l_RegionReport);
    end;
   end
   else
    AddToLog(Format('FAILED - %s', [SysErrorMessage(GetLastError)]));
  end;
 end;
end;

procedure TForm3.AddToLog(const aStr: String);
begin
 LogMemo.Lines.Add(aStr);
 AddToReport(f_Report, aStr);
end;

procedure TForm3.AddToReport(const aFile: TSTream; const aStr: String);
const
 cCRLF: AnsiString = #13#10;
begin
 if aStr <> '' then
  aFile.Write(aStr[1], Length(aStr)*SizeOf(aStr[1]));
 aFile.Write(cCRLF[1], Length(cCRLF));
end;

procedure TForm3.ClearLog;
begin
 LogMemo.Lines.Clear;
end;

procedure TForm3.CheckBufferSize(aNewSize: Cardinal);
begin
 if aNewSize > f_BufferSize then
 begin
  FreeBuffer;
  f_Buffer := AllocMem(aNewSize);
  f_BufferSize := aNewSize;
 end;
end;

procedure TForm3.FreeBuffer;
begin
 FreeMem(f_Buffer);
 f_BufferSize := 0;
end;

const
  THREAD_SUSPEND_RESUME = $0002;

function OpenThread(dwDesiredAccess: dword; bInheritHandle: bool; dwThreadId: dword):dword; stdcall; external 'kernel32.dll';

procedure TForm3.ProcessThreads(aSnapShot: THandle; aFunc: TThreadFunc);
var
 l_Info: TThreadEntry32;
 l_Thread: THandle;
begin
 l_Info.dwSize := SizeOf(l_Info);
 if Thread32First(aSnapShot, l_Info) then
  repeat
   l_Thread := OpenThread(THREAD_SUSPEND_RESUME, False, l_Info.th32ThreadID);
   Assert(l_Thread <> 0);
   try
    aFunc(l_Info.th32ThreadID)
   finally
    CloseHandle(l_Thread);
   end;
  until not Thread32Next(aSnapShot, l_Info);
end;

end.
