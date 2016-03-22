unit bcMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, evdSchema,
  ComCtrls, ExtCtrls, l3Types, l3Interfaces, bcReader;

type
  TMainForm = class(TForm)
    deSource: TDirectoryEdit;
    btnDoThings: TButton;
    Label1: TLabel;
    rgFormat: TRadioGroup;
    ProgressBar: TProgressBar;
    lblProgress: TLabel;
    DetailProgressBar: TProgressBar;
    lblCount: TLabel;
    Label2: TLabel;
    deResult: TDirectoryEdit;
    cbAppendResult: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnDoThingsClick(Sender: TObject);
    
  private
    f_CurTopic: Il3CString;
    f_DidStartUp: Boolean;
    f_LastUpdated: Cardinal;
    f_TopicCount: Cardinal;
    f_Reader: TbcReader;
    f_RunFromCmdLine: Boolean;
    procedure DoOnIdle(Sender: TObject; var Done: Boolean);
    procedure CurTopicHandler(const aTopic: Il3CString);
    procedure DoJob;
    procedure InitDB;
    procedure DoneDB;
    procedure DoProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
    procedure DoPerFileProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
    procedure ErrorHandler(const aMsg: AnsiString; aLevel: Integer = 0);
    procedure ReadParams;
    procedure ShowError(const aMsg: AnsiString);
    procedure UpdateTopicCounter;
    function WriteParams: Integer;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3Base,
 l3FileUtils,
 l3Filer,
 l3IniFile,
 l3String,
 l3LongintList,
 l3LongintListPrim,
 k2FileGenerator,
 k2TagGen,
 evdWriter,
 evNestedDocumentEliminator,
 evSimpleTextPainter,

 HT_Const,
 Ht_DLL,
 DT_Err,

 ddFileIterator,
 ddNSRC_w,
 ddUtils,
 ddCmdLineUtils,
 ddCmdLineDlg,

 bcInterfaces,
 bcTopicDispatcher,
 bcLinksFilter,
 bcBitmapHandleFilter,
 bcAngleBracketsFilter,
 bcCutLongParaFilter,
 bcCmdLine
 ;

{$R *.dfm}

procedure LoadListFromFile(const aFN: AnsiString; const aList: Tl3LongintList);
var
 l_Filer: Tl3DOSFiler;
 l_Topic: Integer;
begin
 l_Filer := Tl3DOSFiler.Make(aFN);
 try
  l_Filer.Open;
  while not l_Filer.EOF do
  begin
   l_Topic := l3StrToIntDef(l3Trim(l_Filer.ReadLn), 0);
   if l_Topic > 0 then
    aList.Add(l_Topic);
  end;
 finally
  FreeAndNil(l_Filer);
 end;
end;

procedure SaveListToFile(const aFN: AnsiString; const aList: Tl3LongintList);
var
 I: Integer;
 l_Filer: Tl3DOSFiler;
begin
 l_Filer := Tl3DOSFiler.Make(aFN, l3_fmWrite);
 try
  l_Filer.Open;
  for I := 0 to aList.Hi do
   l_Filer.WriteLn(IntToStr(aList.Items[I]));
 finally
  FreeAndNil(l_Filer);
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 Application.OnIdle := DoOnIdle;
end;

procedure TMainForm.btnDoThingsClick(Sender: TObject);
begin
 DoJob;
end;

procedure TMainForm.CurTopicHandler(const aTopic: Il3CString);
begin
 // l3System.Msg2Log('# %s', [l3Str(aTopic)]);
 f_CurTopic := aTopic;
end;

procedure TMainForm.DoJob;
var
 I: Integer;
 l_Gen: Tk2TagGenerator;
 l_TD : IbcTopicDispatcher;
 l_TDPath: AnsiString;
 l_SettingsPath: AnsiString;
 l_Writer: Tk2CustomFileGenerator;
 l_OutExt: AnsiString;
 l_FI: TddFileIterator;
 l_IterFunc: TddIterateProc;
 l_OutDir: AnsiString;
 l_SourceDir: AnsiString;
 l_ExistTopics: Tl3LongintList;
 l_TopicsFileName: AnsiString;

 function ConvertOne(const aFileName: AnsiString): Boolean;
 var
  l_OutFN : AnsiString;
  l_BaseFN: AnsiString;
  l_Filer: Tl3DOSFiler;
  l_Idx: Integer;
 begin
  Result := True;
  l3System.Msg2Log('Обработка файла %s', [aFileName]);
  l_BaseFN := ChangeFileExt(ExtractFileName(aFileName), '');
  l_OutFN := ConcatDirName(l_OutDir, l_BaseFN + l_OutExt);
  l_Idx := 0;
  while FileExists(l_OutFN) do
  begin
   Inc(l_Idx);
   l_OutFN := ConcatDirName(l_OutDir, Format('%s_%d%s', [l_BaseFN, l_Idx, l_OutExt]));
  end;
  l_Filer := Tl3DOSFiler.Make(aFileName, l3_fmRead, False);
  try
   f_Reader.Filer := l_Filer;
   f_Reader.CurrentFile := Copy(aFilename, Length(l_SourceDir) + 2, MaxInt);
   l_Filer.Indicator.NeedProgressProc := True;
   l_Filer.Indicator.OnProgressProc := DoPerFileProgress;
  finally
   FreeAndNil(l_Filer);
  end;
  l_Filer := Tl3DOSFiler.Make(l_OutFN, l3_fmWrite, False);
  try
   l_Writer.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;
  f_Reader.Execute;
 end;

begin
 l_SourceDir := deSource.Text;
 if not DirectoryExists(l_SourceDir) then
 begin
  ShowError('Исходная папка указана неверно!');
  Exit;
 end;

 ForceDirectories(deResult.Text);
 if not DirectoryExists(deResult.Text) then
 begin
  ShowError('Папка для результата указана неверно!');
  Exit;
 end;

 WriteParams;
 l_OutDir := deResult.Text;

 if not f_RunFromCmdLine then
  l3System.Str2Log('');

 l_TopicsFileName := ConcatDirName(l_OutDir, 'doclist.txt');
 l_ExistTopics := Tl3LongintList.MakeSorted;
 try
  if cbAppendResult.Checked then
  begin
   if FileExists(l_TopicsFileName) then
    LoadListFromFile(l_TopicsFileName, l_ExistTopics)
   else
   begin
    l3System.Msg2Log('Не могу дополнить результат, не найден doclist.txt - очищаю папку результата');
    PureDir(l_OutDir);
   end;
  end
  else
   PureDir(l_OutDir);
  {
  l_FI := TddFileIterator.MakeFolders(deSource.Text, '_result', DoProgress, True);
  try
   for I := 0 to l_FI.Count-1 do
    PureDir(l_Fi.FileList[I]);
  finally
   FreeAndNil(l_FI);
  end;
  }

  btnDoThings.Enabled := False;
  Update;
  l_FI := TddFileIterator.Make(l_SourceDir, '*.t??', DoProgress, True);
  try
   if l_FI.Count = 0 then
   begin
    ShowError('В указанной директории не найден ни один файл (*.t??)');
    Exit;
   end;
   l3System.Msg2Log('Начало конвертации %d файлов в директории %s', [l_FI.Count, l_SourceDir]);
   InitDB;
   try
    l_TDPath := ExtractFilePath(ParamStr(0)) + 'BELCONTD';
    l_TD := TbcTopicDispatcher.Make(l_TDPath);
 
    l_SettingsPath := ExtractFilePath(ParamStr(0)) + 'belacon.dat';
 
    l_Gen := nil;
    try
     case rgFormat.ItemIndex of
      0:
       begin
        l_Writer := TevdNativeWriter.SetTo(l_Gen);
        l_OutExt := '.evd';
       end;
      1:
       begin
        l_Writer := TddNSRCGenerator.SetTo(l_Gen);
        TddNSRCGenerator(l_Writer).ExportDirectory := l_OutDir;
        TevSimpleTextPainter.SetTo(l_Gen);
        TbcCutLongParaFilter.SetTo(l_Gen);
        l_OutExt := '.nsr';
       end;
     end;
     TbcAngleBracketsFilter.SetTo(l_Gen, l_TD);
     TbcLinksFilter.SetTo(l_Gen, l_TD, ErrorHandler);
     TbcBitmapHandleFilter.SetTo(l_Gen, l_TD);
     TevNestedDocumentEliminator.SetTo(l_Gen);
     f_Reader := TbcReader(TbcReader.SetTo(l_Gen, l_SettingsPath, l_TD, l_ExistTopics, ErrorHandler));
     f_Reader.OnCurTopic := CurTopicHandler;
     f_Reader.ErrorFolder := ConcatDirName(l_OutDir, '_errors');
     l_IterFunc := L2IterateFilesProc(@ConvertOne);
     try
      l_FI.IterateFiles(l_IterFunc);
     finally
      FreeIterateFilesProc(l_IterFunc);
     end;
     l3System.Msg2Log('Обработка завершена. Преобразовано %s.', [NumSuffix(f_Reader.TopicCount, 'документ', 'документа', 'документов')]);
    finally
     FreeAndNil(l_Gen);
     f_Reader := nil;
    end;
   finally
    l_TD := nil;
    DoneDB;
   end;
  finally
   btnDoThings.Enabled := True;
   FreeAndNil(l_FI);
  end;
  SaveListToFile(l_TopicsFileName, l_ExistTopics);
 finally
  FreeAndNil(l_ExistTopics);
 end;
end;

procedure TMainForm.DoneDB;
begin
 htShut;
 htGlobalShut;
end;

procedure TMainForm.DoProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 lblProgress.Caption := aMsg;
 case aState of
  piStart :
   begin
    ProgressBar.Max := aValue;
    ProgressBar.Position := 0;
   end;
  piCurrent: ProgressBar.Position := aValue;
  piEnd: ProgressBar.Position := ProgressBar.Max;
 end;
 Update;
end;

procedure TMainForm.DoPerFileProgress(aState: Byte; aValue: Long; const aMsg : AnsiString = '');
begin
 //lblProgress.Caption := aMsg;
 case aState of
  piStart :
   begin
    DetailProgressBar.Max := aValue;
    DetailProgressBar.Position := 0;
    Update;
    f_LastUpdated := GetTickCount;
   end;
  piCurrent:
  begin
   if (GetTickCount - f_LastUpdated) > 500 then
   begin
    DetailProgressBar.Position := aValue;
    UpdateTopicCounter;
    Update;
    f_LastUpdated := GetTickCount;
   end;
  end;
  piEnd:
   begin
    DetailProgressBar.Position := DetailProgressBar.Max;
    UpdateTopicCounter;
    Update;
   end;
 end;
end;

procedure TMainForm.ErrorHandler(const aMsg: AnsiString; aLevel: Integer = 0);
begin
 l3System.Msg2Log('Топик %s : %s', [l3Str(f_CurTopic), aMsg]);
end;

procedure TMainForm.DoOnIdle(Sender: TObject; var Done: Boolean);
var
 l_Cmd: TbcCmdLine;
begin
 Done := True;
 if f_DidStartUp then
  Exit;
 if ParamCount > 0 then
 begin
  l3System.Str2Log('');
  f_RunFromCmdLine := True;
  l_Cmd := TbcCmdLine.Create;
  try
   if l_Cmd.NeedHelp then
    ShowCmdHelpMessage('Параметры командной строки', l_Cmd.HelpText)
   else
   begin
    if l_Cmd.InFolder = '' then
     ShowError('Не указана входная папка!')
    else
    if l_Cmd.OutFolder = '' then
     ShowError('Не указана папка для результата!')
    else
    begin
     deSource.Text := l_Cmd.InFolder;
     deResult.Text := l_Cmd.OutFolder;
     cbAppendResult.Checked := l_Cmd.Add;
     if (l_Cmd.Format = 'E') or (l_Cmd.Format = 'e') then
      rgFormat.ItemIndex := 0
     else
      rgFormat.ItemIndex := 1;
     DoJob;
    end;
   end;
  finally
   FreeAndNil(l_Cmd);
  end;
  Close;
 end
 else
  ReadParams;
 f_DidStartUp := True;
end;

procedure TMainForm.InitDB;
var
 l_DirTemp: AnsiString;
 l_DirLocks: AnsiString;
 l_Init :Init;
begin
 l_DirTemp  := l3GetTempDir;
 l_DirLocks := ExtractFilePath(ParamStr(0));
 l3FillChar(l_Init, SizeOf(l_Init));
 with l_Init do
 begin
  nTableCnt      := 50;
  nTaskCnt       := 20;
  nHtCnt         := 4 + 20 * 6 + 1;
  nLockTimeOut   := 40;
  nPollDelay     := 40;
  nTransTimeOut  := 40;
  nTrsMode       := TRS_HARD;
  fpTmpPath      := PChar(l_DirTemp);
  fpNetPath      := PChar(l_DirLocks);
  fpTrtPath      := PChar(l_DirLocks);
  fpNetName      := 'BelConv';
  fpfInfo        := Pointer(-1);
  fpfIoMess      := nil; //@fn_OnIOError;
  fpfErrMess     := nil; //@fn_OnHtError;
  fpfPiStart     := Pointer(-1);
  fpfPiDraw      := Pointer(-1);
  fpfPiStop      := Pointer(-1);
  fpfYield       := Pointer(-1);
  gHeapCtrl      := 10000000;
  gHeapTask      := 120000;
 end;
 htGlobalInit(HInstance);
 Ht(htInit(@l_Init, SizeOf(l_Init)));
end;

procedure TMainForm.ReadParams;
var
 l_Ini: Tl3IniFile;
begin
 l_Ini := Tl3IniFile.Create;
 try
  l_Ini.Section := 'Params';
  deSource.Text := l_Ini.ReadParamStrDef('Path', '');
  deResult.Text := l_Ini.ReadParamStrDef('ResultPath', '');
  rgFormat.ItemIndex := l_Ini.ReadParamIntDef('Format', 0);
  cbAppendResult.Checked := l_Ini.ReadParamBoolDef('AppendResult', False);
 finally
  FreeAndNil(l_Ini);
 end;
end;

procedure TMainForm.ShowError(const aMsg: AnsiString);
begin
 if f_RunFromCmdLine then
 begin
  l3System.Msg2Log(aMsg);
  ExitCode := 1;
 end
 else
  MessageDlg(aMsg, mtError, [mbOk], 0); 
end;

procedure TMainForm.UpdateTopicCounter;
begin
 if f_Reader <> nil then
  lblCount.Caption := Format('Получено документов: %d', [f_Reader.TopicCount]);
end;

function TMainForm.WriteParams: Integer;
var
 l_Ini: Tl3IniFile;
begin
 l_Ini := Tl3IniFile.Create;
 try
  l_Ini.Section := 'Params';
  l_Ini.WriteParamStr('Path', deSource.Text);
  l_Ini.WriteParamStr('ResultPath', deResult.Text);
  l_Ini.WriteParamInt('Format', rgFormat.ItemIndex);
  l_Ini.WriteParamBool('AppendResult', cbAppendResult.Checked);
 finally
  FreeAndNil(l_Ini);
 end;
end;

end.
