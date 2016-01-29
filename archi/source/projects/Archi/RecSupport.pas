unit RecSupport;

interface
uses
  Windows, Messages, SysUtils, Classes, Forms;

function GetRecorderHandle : HWnd;

procedure LoadRecorderModule;

procedure StartRecorder;
procedure StopRecorder;

procedure SaveRecorderFileSeq;
procedure InitSaveRecorderFileSeq;

//procedure SaveRecordertoFile(aFileName : String);


function  IsRecSeqInit : boolean;
procedure InitSaveSeqData;
function  GetNextRecFileName : String;

const
 wm_RecorderStart   = WM_USER + 30101;
 wm_RecorderStop    = WM_USER + 30102;
 wm_RecorderSaveSeq = WM_USER + 30103;
 wm_RecorderSaveSeqInit = WM_USER + 30104;

implementation

uses
  l3FileUtils,
  
  l3IniFile
  ;

var
 RecFilePathMask : String;

const
 RecSeqInit : Boolean = False;
 RecSeqCounter  : Integer = 1;


function  IsRecSeqInit : boolean;
 begin
  Result := RecSeqInit;
 end;

function  GetNextRecFileName : String;
 begin
  Result := Format(RecFilePathMask,[RecSeqCounter]);
  Inc(RecSeqCounter);
 end;

procedure InitSaveSeqData;
 var
  lModulePath2 : ShortString;
  lModulePath : String;

 begin
  If RecSeqInit then exit;
  Randomize;
  UserConfig.Section := 'Recorder';
  RecFilePathMask := ConcatDirName(UserConfig.ReadParamStrDef('RecFileDirPath',''),
                                   IntToStr(Random(99999999))+'_%d.rec');
  lModulePath := lModulePath2;
  RecSeqInit  := True;
 end;

procedure LoadRecorderModule;
 var
  lModulePath2 : ShortString;
  lModulePath : String;
  lRecHandle : HWnd;
 begin
  lRecHandle := GetRecorderHandle;
  If lRecHandle = 0 then Exit;

  UserConfig.Section:='Recorder';
  If UserConfig.ReadParamStr('RecModulePath',lModulePath2) then
   begin
    lModulePath := lModulePath2;
    WinExec(PChar(lModulePath),SW_SHOW);
   end;
 end;

procedure StartRecorder;
 var
  lRecHandle : HWnd;
 begin
  lRecHandle := GetRecorderHandle;
  If lRecHandle = 0 then Exit;
  SendMessage(lRecHandle, wm_RecorderStart, 0, 0);
 end;

procedure StopRecorder;
 var
  lRecHandle : HWnd;
 begin
  lRecHandle := GetRecorderHandle;
  If lRecHandle = 0 then Exit;
  SendMessage(lRecHandle, wm_RecorderStop, 0, 0);
 end;

procedure InitSaveRecorderFileSeq;
 var
  lRecHandle : HWnd;
 begin
  lRecHandle := GetRecorderHandle;
  If lRecHandle = 0 then Exit;
  SendMessage(lRecHandle, wm_RecorderSaveSeqInit, 0, 0);
 end;

procedure SaveRecorderFileSeq;
  var
  lRecHandle : HWnd;
 begin
  lRecHandle := GetRecorderHandle;
  If lRecHandle = 0 then Exit;
  SendMessage(lRecHandle, wm_RecorderSaveSeq, 0, 0);
 end;

{procedure SaveRecordertoFile(aFileName : String);
 var
  lRecHandle : HWnd;
  Atom: tAtom;
 begin
  lRecHandle := GetRecorderHandle;
  If lRecHandle = 0 then Exit;

  Atom := GlobalAddAtom(PChar(aFileName));
  try
   SendMessage(lRecHandle, wmRecorderSave, Atom, 0);
  finally
   GlobalDeleteAtom(Atom);
  end;
 end;}

function LookAtAllWindows(Handle: HWND; Temp: LongInt): BOOL; stdcall;
 var
  WindowName, ClassName: Array[0..255] of Char;
 begin
  Result:= True;
  if (GetClassName(Handle, ClassName, SizeOf(ClassName)) > 0) and
     (StrComp(ClassName, 'TRecordDlg') = 0) then
  begin
    Result := False;
    PInteger(Temp)^ := Handle;
  end;
 end;

function GetRecorderHandle : HWnd;
 begin
  Result := 0;
  EnumWindows(@LookAtAllWindows, Integer(@Result));
 end;

end.
