unit gzNSRForm;
{$I ProjectDefine.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, k2TagFilter, l3Types, k2Reader, ddFileIterator,
  ExtCtrls, l3Stream, gzConverter;

type
  TConverterForm = class(TForm)
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    LabelFolder: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure FormCreate(Sender: TObject);
  private
    f_Abort: Boolean;
    f_DoneCount: Integer;
    f_DoneFiles: TStrings;
    f_EmptyCount: Integer;
    f_EmptyDoc: Boolean;
    f_gFolderList: string;
    f_NeedRestart: Boolean;
    f_OldFormat: Boolean;
    f_OneSessionLimit: Integer;
    f_Reader: Tk2CustomFileReader;
    f_Misspels: Tl3NamedTextStream;
    f_OutFileName: string;
    f_ThreadCount: Integer;
    f_WrongCount: Integer;
    gDoneFolder: string;
    gExcludeMask: string;
    gExcludeMaskList: string;
    gFromGZ: Boolean;
    gWithSubDirs: Boolean;
   procedure ConvertFilesThreated;
    procedure ConvertFilesMain;
    procedure CopyToBackup(const aFileName: String);
    procedure CopyToDone(const aFileName: String);
    procedure EmptyDocument(Sender: TObject);
    procedure Idle(Sender: TObject; var Done: Boolean);
   procedure Initialize;
    procedure CorrectParameters;
    procedure ErrorReaction(const Msg: String; Category: Integer = 0);
   procedure LoadParameters;
    function MakeOneThread(aIndex: Integer; aFiles: TddFileIterator): TThread;
    function MakeOutFileName: string;
    function MakeProgressBar(aIndex: Integer; theThread: TgzThreadConverter): TProgressBar;
    function pm_GetToday: string;
    procedure SendEmail(aTotalCount: Integer; const aElapsed: string);
   procedure UpdateProgress(Sender: TObject; aTotalPercent: Integer);
   procedure WriteHelp;
    { Private declarations }
  protected
  public
    { Public declarations }
   gSourceFolder: String;
   gDestinationFolder: String;
   gBackupFolder: String;
   gNeedHelp: Boolean;
    property gFolderList: string read f_gFolderList write f_gFolderList;
  published
    property Today: string read pm_GetToday;
  end;

 TgzIDGenerator = class(Tk2TagFilter)
 public
  function GetExternalHandle: Integer;
  procedure StartChild(ChildID: Integer); override;
 end;

var
  ConverterForm: TConverterForm;

implementation

Uses
 StrUtils,
 l3Base,
 evdWriter, evdSchema,
 ddArbitralCourtReader, ddProgressObj, dd_lcTextChecker,
 dd_lcTextFormatter,
 dd_lcTypeConverter, dd_lcSourceConverter, dd_lcVASSourceCorrector,
 dd_lcTableEliminator, dd_lcsectionEliminator, ddSpaceTrimmer, dd_lcPageNumberEliminator,
 dd_lcVASCodeCorrector, dd_lcYearCodeCorrector, dd_lcMisspellFilter,
 dd_lcDateNumberFormatter, dd_lcStartDocFormatter, dd_lcTitleFormatter,
 dd_lcTextStyleCorrector, dd_lcJudgeFormatter, dd_lcResolutionFormatter,
 dd_lcCityNameFormatter, dd_lcTextSplitter, ddLawCaseNameGenerator, dd_lcBelongsGenerator,
 l3Filer, l3FileUtils,
 k2TagGen, ddUtils, TextPara_Const, Document_Const,
 Masks, ddNSRC_w, evSimpleTextPainter, k2Tags, l3IniFile, 
 k2FileGenerator, Math,
 IdMessage, IdMessageClient, IdSMTP, IDStack, JclSysInfo, k2Facade;


{$R *.dfm}

procedure TConverterForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_DoneFiles);
end;

procedure TConverterForm.FormCreate(Sender: TObject);
begin
 f_DoneFiles := TStringList.Create;
 //if GotoPrevInst then
 // Application.Terminate
 //else
  Initialize;
 l3System.ShowObjectsWindow:= False;
end;

procedure TConverterForm.ConvertFilesThreated;
var
 l_Files: TddFileIterator;
 i: Integer;
 l_Start: TDateTime;
 l_Prg: TddProgressObject;
 l_ExMasks: TStrings;
 l_NeedRestart: Boolean;
 l_RealCount: Integer;
 l_CPUInfo: TCPUInfo;
 l_Threads: Array[1..256] of TThread;
 l_Finished: Boolean;
begin
 ForceDirectories(gDestinationFolder);
 f_DoneFiles.Clear;
 f_OutFileName:= '';
 l_Finished:= True;
 l_Prg:= TddProgressObject.Create;
 try
  l_Prg.SetVisualParams(ProgressBar, LabelFolder);
  l_Files:= TddFileIterator.Make(gSourceFolder, IfThen(gFromGZ, '*.gz', '*.xml'), l_Prg.ProcessUpdate, gWithSubDirs);
  try
   l_Files.LoadFiles;
   LabelFolder.Caption:= gSourceFolder;
   if gExcludeMask <> '' then
    l_Files.ExcludeMask:= gExcludeMask;
   if (gExcludeMaskList <> '') and FileExists(gExcludeMaskList) then
   begin
    l_ExMasks:= TStringList.Create;
    try
     l_ExMasks.LoadFromFile(gExcludeMaskList);
     for i:= 0 to Pred(l_ExMasks.Count) do
      l_Files.ExcludeMask:= l_ExMasks[i];
    finally
     FreeAndNil(l_ExMasks);
    end;
   end;  // (gExcludeMaskList <> '') and FileExists(gExcludeMaskList)
   if not l_Files.Empty then
   begin
     // Вычисляем кол-во процессоров
     GetCpuInfo(l_CPUInfo);
     
     f_ThreadCount:= Min(256, l_CPUInfo.PhysicalCore*2-1);
     f_ThreadCount:= 1; //Min(l_Files.FileList.Count, f_ThreadCount);
     for i:= 1 to f_ThreadCount do
      l_Threads[i]:= MakeOneThread(i, l_Files);
     l_Finished:= False;
   end;
  finally
   l3Free(l_Files);
  end;
 finally
  FreeAndNil(l_Prg);
 end; 
 if not l_Finished then
 begin
    f_Misspels:= Tl3NamedTextStream.Create(GetAppFolderFileName('SpellErrors.txt'), l3_fmAppend);
    try
     k2.TypeTable;

     for i:= 1 to f_ThreadCount do
      l_Threads[i].Resume;

     l_Finished := false;
     while not l_Finished do
     begin
       l_Finished := true;
       for i := 1 to f_ThreadCount do
       begin
        if f_Abort then
        begin
         l_Threads[i].Terminate;
         l_Threads[i].WaitFor;
        end;
        l_Finished := l_Finished AND TgzThreadConverter(l_Threads[i]).Finished;
        Application.ProcessMessages;
       end;
     end; // while

     for i:= 1 to f_ThreadCount do
      l_Threads[i].Free;

    finally
     FreeAndNil(f_Misspels);
    end;
    (* Слишком долго и бесполезно
    ForceDirectories(gDoneFolder);
    l3System.Msg2Log('Упаковка исходных данных...');
    ZipFiles(MakeUniqueFileName(ConcatDirName(gDoneFolder, ExtractFileName(gSourceFolder) + '.zip')), f_DoneFiles, l_Prg);
    *)
 end;   
end;

procedure TConverterForm.ConvertFilesMain;
var
 l_Filer, l_Filer2: TevDOSFiler;
 l_Files: TddFileIterator;
 i: Integer;
 l_Start: TDateTime;
 l_Prg: TddProgressObject;
 l_Gen, l_Starter: Tk2TagGenerator;
 l_ExMasks: TStrings;
 l_R: Tdd_lcResolutionFormatter;
 l_J: Tdd_lcJudgeFormatter;
 l_NeedRestart: Boolean;
 l_RealCount: Integer;

 function lp_WorkFile(const FileName: String): Boolean;
 begin
  //labelFile.Caption:= ExtractFileName(FileName);
  Application.ProcessMessages;
  l_Filer.FileName:= FileName;
  if l_Filer2.Opened then
   l_FIler2.Close;
  l_FIler2.Mode:= l3_fmAppend;
  l_Filer2.FileName:= MakeOutFileName;
  l_Filer2.Open;
  try
   //l_Filer2.FileName:= ConcatDirName(gDestinationFolder, ChangeFileExt(ExtractFileName(FileName), {$IFDEF Everest}'.evd'{$ELSE}'.nsr'{$ENDIF}));
   f_EmptyDoc:= False;
   try
    TLiteArbitralCourtReader(l_Gen).Execute;
    if f_EmptyDoc then
    begin
     l3System.Msg2Log('Пустой');
     CopyToBackup(FileName);
     //DeleteFile(l_Filer2.FileName);
     Inc(f_EmptyCount);
    end
    else
    begin
     CopyToDone(FileName);
     Inc(f_DoneCount);
    end;
   except
    on E: Exception do
    begin

    end;
   end;
  finally
   l_Filer2.Close;
  end;
  //labelFile.Caption:= '';
  Result:= not f_Abort;
 end; // lp_WorkFile

begin
 l_Prg:= TddProgressObject.Create(nil);
 try
  l_prg.SetVisualParams(ProgressBar, ProgressLabel);
  l_Prg.OnUpdate:= UpdateProgress;
  ForceDirectories(gDestinationFolder);
  f_DoneFiles.Clear;
  f_OutFileName:= '';
  l_Files:= TddFileIterator.Make(gSourceFolder, IfThen(gFromGZ, '*.gz', '*.xml'), nil, gWithSubDirs);
  try
   l_Files.LoadFiles;
   if gExcludeMask <> '' then
    l_Files.ExcludeMask:= gExcludeMask;
   if (gExcludeMaskList <> '') and FileExists(gExcludeMaskList) then
   begin
    l_ExMasks:= TStringList.Create;
    try
     l_ExMasks.LoadFromFile(gExcludeMaskList);
     for i:= 0 to Pred(l_ExMasks.Count) do
      l_Files.ExcludeMask:= l_ExMasks[i];
    finally
     FreeAndNil(l_ExMasks);
    end;
   end;
   if not l_Files.Empty then
   begin
    f_Misspels:= Tl3NamedTextStream.Create(GetAppFolderFileName('SpellErrors.txt'), l3_fmAppend);
    try
     l_Filer:= TevDOSFiler.Create;
     try
      l_FIler.Mode:= l3_fmRead;
      l_Filer.TimeOut:= 60000; // минута на ожидание
       l_Filer2:= TevDOSFiler.Create;
       try
        l_Filer2.Mode:= l3_fmAppend;
        l_Filer2.FileName:= l3GetTempFileName('gz');
        l_Filer2.TimeOut:= 60000; // минута на ожидание
         l_Start:= Now;
         {$IFDEF Everesr}
         l_Gen:= TevdNativeWriter.Create;
         try
          // запись
          TevdNativeWriter(l_Gen).Binary:= False; //True;;
          TevdNativeWriter(l_Gen).Filer:= l_Filer2;
         {$ELSE}
         l_Gen:= TddNSRCGenerator.Create;
         try
          TddNSRCGenerator(l_Gen).Filer:= l_Filer2;
          TevSimpleTextPainter.SetTo(l_Gen);
         {$ENDIF}
          // Орфография
          Tdd_lcMisspellFilter.SetTo(l_Gen, 1, ErrorReaction, GetAppFolderFileName('lcMisspells.dat'));
          // Номер дела
          TgzIDGenerator.SetTo(l_Gen);
          // Повторная проверка на пустоту
          TlcTextChecker.SetTo(l_Gen);
          TlcTextChecker(l_Gen).OnEmptyDocument:= EmptyDocument;
          // Форматирование
          Tdd_lcJudgeFormatter.SetTo(l_Gen);
          l_J:= Tdd_lcJudgeFormatter(l_Gen);
          Tdd_lcResolutionFormatter.SetTo(l_Gen);
          l_R:= Tdd_lcResolutionFormatter(l_Gen);
          Tdd_lcDateNumberFormatter.SetTo(l_Gen);
          Tdd_lcCityFormatter.SetTo(l_Gen);
          l_R.AddBodyStartNotifier(Tdd_lcCityFormatter(l_Gen));
          Tdd_lcTitleFormatter.SetTo(l_Gen);
          Tdd_lcStartDocFormatter.SetTo(l_Gen);
          Tdd_lcTextStyleCorrector.SetTo(l_Gen);
          TlcTableEliminator2.SetTo(l_Gen);
          l_R.AddBodyStartNotifier(TlcTableEliminator2(l_Gen));
          l_J.AddBodyFinishNotifier(TlcTableEliminator2(l_Gen));
          Tdd_lcSectionEliminator.SetTo(l_Gen);
          TddSpaceTrimmerFilter.SetTo(l_Gen);
          Tdd_lcTextSplitter.SetTo(l_Gen, #10);
          l_R.AddBodyStartNotifier(Tdd_lcTextSplitter(l_Gen));
          Tdd_lcPageNumberEliminator.SetTo(l_Gen, k2_idTextPara);
          // преобразование атрибутов
          Tdd_lcNameGenerator.SetTo(l_Gen{, catGeneral, ErrorReaction});
          TlcBelongsGenerator.SetTo(l_Gen{, catGeneral, ErrorReaction});
          //TalcuSourceDocFilter.SetTo(l_Gen, k2_idDocument, Tl3LongintList(AsObject['lcSource']));
          //TalcuSourceDocFilter(l_Gen).OnError:= ErrorReaction;
          Tdd_lcVASCodeCorrector.SetTo(l_Gen);
          Tdd_lcYearCodeCorrector.SetTo(l_Gen);
          Tdd_lcTypeConverter2.SetTo(l_Gen);
          Tdd_lcTypeConverter2(l_Gen).LoadSources(GetAppFolderFileName('lcSourceConvertFile.dat'));
          Tdd_lcSourceConverterFilter.SetTo(l_Gen, GetAppFolderFileName('lcSourceFile.dat'));
          Tdd_lcTypeConverter.SetTo(l_Gen, GetAppFolderFileName('lcTypeSyno.dat'));
          Tdd_lcVASSourceCorrector.SetTo(l_Gen);
          // Чтение
          TlcTextChecker.SetTo(l_Gen);
          TlcTextChecker(l_Gen).OnEmptyDocument:= EmptyDocument;
          l_Starter:= l_Gen;
          l_Starter.Start;
          try
           f_Reader:= TLiteArbitralCourtReader.SetTo(l_Gen);
           TLiteArbitralCourtReader(l_Gen).OnEmptyDocument:= EmptyDocument;
           TLiteArbitralCourtReader(l_Gen).SourceFileName:= GetAppFolderFileName('lcSourceFile.dat');
           TLiteArbitralCourtReader(l_Gen).DictionaryFileName:= GetAppFolderFileName('id.txt');
           TLiteArbitralCourtReader(l_Gen).Filer:= l_Filer;
           TLiteArbitralCourtReader(l_Gen).FromGZ:= gFromGZ;
           TLiteArbitralCourtReader(l_Gen).SaveImage:= False;
           TLiteArbitralCourtReader(l_Gen).ImageFolder:= gDestinationFolder;
           LabelFolder.Caption:= gSourceFolder;
           l_RealCount:= Min(f_OneSessionLimit, l_Files.FileList.Count);
           l_Prg.Start(l_RealCount);
           try
            l3System.Msg2Log('Начато преобразование %d файлов', [l_Files.FileList.Count]);
            f_Abort:= False;
            f_EmptyCount:= 0;
            f_DoneCount:= 0;
            f_WrongCount:= 0;
            f_NeedRestart:= l_RealCount < l_Files.FileList.Count;
             for i:= 0 to l_RealCount-1 do
             begin
              if f_Abort then
               break;
              l3System.Msg2Log('%9d из %9d %s', [Succ(i), l_RealCount, l_Files.FileList[i]]);
              if l_Files.ValidFileName(l_Files.FileList[i]) then
              begin
               lp_WorkFile(l_Files.FileList[i]);
               l_Prg.ProcessUpdate(i); // Здесь, чтобы более плавно вычислять скорость
              end
              else
              begin
               l3System.Msg2Log('Не подошел по маске');
               CopyToBackup(l_Files.FileList[i]);
               Inc(f_WrongCount);
              end;
             end; // for i
           finally
            l_Prg.Stop;
            l3System.Msg2Log('Преобразование закончено за '+ CalcElapsedTime(l_Start, Now));
            l3System.Msg2Log('Создано %d документов, найдено пустых %d, отброшено %d', [f_DoneCount, f_EmptyCount, f_WrongCount]);
            SendEmail(l_Files.FileList.Count, CalcElapsedTime(l_Start, Now));
           end;
          finally
           l_Starter.Finish;
          end;
          LabelFolder.Caption:= '';
         finally
          FreeAndNil(l_Gen);
         end;

       finally
        l3Free(l_Filer2);
       end;
     finally
      l3Free(l_Filer);
     end;
    finally
     FreeAndNil(f_Misspels);
    end;
    (* Слишком долго и бесполезно
    ForceDirectories(gDoneFolder);
    l3System.Msg2Log('Упаковка исходных данных...');
    ZipFiles(MakeUniqueFileName(ConcatDirName(gDoneFolder, ExtractFileName(gSourceFolder) + '.zip')), f_DoneFiles, l_Prg);
    *)
   end;
  finally
   l3Free(l_Files);
  end;
 finally
  l3Free(l_Prg);
 end;
end;

procedure TConverterForm.CopyToBackup(const aFileName: String);
begin
 if not RenameFile(aFileName, ConcatDirName(gBackupFolder, ExtractFileName(aFileName))) then
  CopyFile(aFileName, ConcatDirName(gBackupFolder, ExtractFileName(aFileName)), cmDeleteSource);
end;

procedure TConverterForm.CopyToDone(const aFileName: String);
var
 l_FileName: String;
begin
 l_FileName:= ConcatDirName(gDoneFolder, ExtractFileName(aFileName));
 f_DoneFiles.Add(l_Filename);
 if not RenameFile(aFileName, l_FileName) then
  CopyFile(aFileName, l_FileName, cmDeleteSource);
end;

procedure TConverterForm.EmptyDocument(Sender: TObject);
begin
 f_EmptyDoc:= True;
end;

procedure TConverterForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 with Tl3IniFile.Create do
 try
  Section:= 'Position';
  WriteParamInt('Left', Left);
  WriteParamInt('Top', Top);
 finally
  Free;
 end;

 f_Abort:= True;
 Action:= caHide;
end;

procedure TConverterForm.Idle(Sender: TObject; var Done: Boolean);
var
 l_Folders: TStrings;
 i: Integer;
begin
 f_NeedRestart:= False;
 Application.OnIdle:= nil;
 LoadParameters;
 if gNeedHelp then
  WriteHelp
 else
 begin
  l_Folders:= TStringList.Create;
  try
   if (gFolderList <> '') and FileExists(gFolderList) then
    l_Folders.LoadFromFile(gFolderList)
   else
    l_Folders.Add(gSourceFolder);
   for i:= 0 to Pred(l_Folders.Count) do
   begin
    gSourceFolder:= Trim(l_Folders[i]);
    {$IFDEF Threated}
    ConvertFilesThreated;
    {$ELSE}
    ConvertFilesMain;
    {$ENDIF}
   end;
  finally
   FreeAndNil(l_Folders);
  end;
 end;
 if not f_Abort and f_NeedRestart then
  RestartApplication(CmdLine)
 else
  Close;
end;

procedure TConverterForm.Initialize;
begin
 gSourceFolder:= '';
 gDestinationFolder:= '';
 gBackupFolder:= '';
 gDoneFolder:= '';
 gWithSubDirs:= False;
 gFromGZ:= True;
 gFolderList:= '';
 f_OldFormat:= False;
 with Tl3IniFile.Create do
 try
  Section:= 'Limit';
  f_OneSessionLimit:= ReadParamIntDef('Value', 20000);
  Section:= 'Position';
  Left:= ReadParamIntDef('Left', Left);
  Top:= ReadParamIntDef('Top', Top);
 finally
  Free;
 end;
 ResetSelfLog(10000000);
 Application.OnIdle:= Idle;
end;

procedure TConverterForm.CorrectParameters;
var
 l_Folder: String;
begin
 l_Folder:= ExtractFilePath(Application.ExeName);
 if gSourceFolder = '' then
  gSourceFolder:= l_Folder;
 if gDestinationFolder = '' then
  gDestinationFolder:= ConcatDirName(gSourceFolder, 'EvdFiles');
 if gBackupFolder = '' then
  gBackupFolder:= ConcatDirName(gSourceFolder, 'WrongFiles\'+Today)
 else
  gBackupFolder:= ConcatDirName(gBackupFolder, Today);
 if gDoneFolder = '' then
  gDoneFolder:= ConcatDirname(gSourceFolder, 'DoneFiles\'+Today)
 else
  gDoneFolder:= ConcatDirname(gDoneFolder, Today);
end;

procedure TConverterForm.ErrorReaction(const Msg: String; Category: Integer = 0);
begin
  f_Misspels.PutLine(Msg);
end;

procedure TConverterForm.LoadParameters;
var
 i: Integer;
 l_S: String;
begin
 for i:= 1 to ParamCount do
 begin
  l_S:= ParamStr(i);
  if AnsiStartsText('/S', l_S) then
   gSourceFolder:= Copy(l_S, 3, Length(l_S))
  else
  if AnsiStartsText('/D', l_S) then
   gDestinationFolder:= Copy(l_S, 3, Length(l_S))
  else
  if AnsiStartsText('/B', l_S) then
   gBackupFolder:= Copy(l_S, 3, Length(l_S))
  else
  (*
  if AnsiStartsText('/O', l_S) then
   f_OldFormat:= True
  else
  *)
  if AnsiStartsText('/H', l_S) then
   gNeedHelp:= True
  else
  if AnsiStartsText('/R', l_S) then
   gWithSubDirs:= True
  else
  if AnsiStartsText('/W', l_S) then
   gDoneFolder:= Copy(l_S, 3, Length(l_S))
  else
  if AnsiStartsText('/X', l_S) then
   gFromGZ:= False
  else
  if AnsiStartstext('/F', l_S) then
   gFolderList:= Copy(l_S, 3, Length(l_S))
  else
  if AnsiStartsText('/EM', l_S) then
   gExcludeMask:= Copy(l_S, 4, Length(l_S))
  else
  if AnsiStartsText('/EL', l_S) then
   gExcludeMaskList:= Copy(l_S, 4, Length(l_S))
 end; // fof i
 CorrectParameters;
end;

function TConverterForm.MakeOneThread(aIndex: Integer; aFiles: TddFileIterator): TThread;
var
 l_Prg: TProgressBar;
 i, l_Idx, l_PartSize: Integer;
begin
  Result:= TgzThreadConverter.Create;
   with Result as TgzThreadConverter do
   begin
    MakeProgressBar(aIndex, Result as TgzThreadConverter);
    DestinationFolder:= gDestinationFolder;
    DoneFolder:= gDoneFolder;
    FromGZ:= gFromGZ;
    FileNamePrefix:= 'p'+IntToStr(aIndex);
    SaveImage:= False;
    WrongFolder:= gBackupFolder;
    l_PartSize:= Min(f_OneSessionLimit, Round(aFiles.FileList.Count/f_ThreadCount));
    for i:= 0 to l_PartSize do
    begin
     l_Idx:= i+Pred(aIndex)*l_PartSize;
     if l_Idx < aFiles.FileList.Count then
      if aFiles.ValidFileName(aFiles.FileList[l_Idx]) then
       FileList.Add(aFiles.FileList[l_Idx]);
    end;
    //while not Terminated do;
   (*
         LabelFolder.Caption:= gSourceFolder;
         l_RealCount:= Min(f_OneSessionLimit, l_Files.FileList.Count);
         l_Prg.Start(l_RealCount);
         try
          l3System.Msg2Log('Начато преобразование %d файлов', [l_Files.FileList.Count]);
          f_Abort:= False;
          f_EmptyCount:= 0;
          f_DoneCount:= 0;
          f_WrongCount:= 0;
          f_NeedRestart:= l_RealCount < l_Files.FileList.Count;
           for i:= 0 to l_RealCount-1 do
           begin
            if f_Abort then
             break;
            l3System.Msg2Log('%9d из %9d %s', [Succ(i), l_RealCount, l_Files.FileList[i]]);
            if l_Files.ValidFileName(l_Files.FileList[i]) then
            begin
             lp_WorkFile(l_Files.FileList[i]);
             l_Prg.ProcessUpdate(i); // Здесь, чтобы более плавно вычислять скорость
            end
            else
            begin
             l3System.Msg2Log('Не подошел по маске');
             CopyToBackup(l_Files.FileList[i]);
             Inc(f_WrongCount);
            end;
           end; // for i
         finally
          l_Prg.Stop;
          l3System.Msg2Log('Преобразование закончено за '+ CalcElapsedTime(l_Start, Now));
          l3System.Msg2Log('Создано %d документов, найдено пустых %d, отброшено %d', [f_DoneCount, f_EmptyCount, f_WrongCount]);
          SendEmail(l_Files.FileList.Count, CalcElapsedTime(l_Start, Now));
         end;
        finally
         l_Starter.Finish;
        end;
        LabelFolder.Caption:= '';
       *)
   end;
end;

function TConverterForm.MakeOutFileName: string;
var
 l_FileName: String;
begin
 if f_OutFileName = '' then
  l_FileName:= ChangeFileExt(ExtractFileName(gSourceFolder), {$IFDEF Everest}'.evd'{$ELSE}'.nsr'{$ENDIF})
 else
  l_FileName:= f_OutFileName;
 Result := GetNextUniqueFileName(ConcatDirName(gDestinationFolder, l_FileName), 10000000);
 f_OutFileName:= ExtractFileName(Result);
end;

function TConverterForm.MakeProgressBar(aIndex: Integer; theThread: TgzThreadConverter): TProgressBar;
var
 l_Label: TLabel;
 l_Delta: Integer;
begin
 // Можно использовать существующий прогресс для общего прогресса
 if aIndex > 1 then
 begin
  l_Delta:= ProgressLabel.Top + ProgressLabel.Height - ProgressBar.Top + 4;
  // Прогресс
  Result := TProgressBar.Create(self);
  Result.Name:= 'ProgressBar'+IntToStr(aIndex);
  Result.Smooth:= True;
  Result.Left:= ProgressBar.Left;
  Result.Width:= ProgressBar.Width;
  Result.Top:= ProgressBar.Top + l_Delta*Pred(aIndex);
  Result.Parent:= Self;
  // Метка
  l_Label:= TLabel.Create(Self);
  l_Label.Width:= ProgressLabel.Width;
  l_Label.Left:= ProgressLabel.Left;
  l_Label.AutoSize:= False;
  l_Label.Top:= ProgressLabel.Top + l_Delta*Pred(aIndex);
  l_Label.Name:= 'ProgressLabel'+IntToStr(aIndex);
  l_Label.Parent:= Self;
  Height:= Height + l_Delta;
  theThread.Progressor.SetVisualParams(Result, l_Label);
 end
 else
 begin
  Result:= ProgressBar;
  theThread.Progressor.SetVisualParams(Result, ProgressLabel);
 end;
end;

function TConverterForm.pm_GetToday: string;
var
 l_Y, l_M, l_D: Word;
begin
 DecodeDate(Date, l_Y, l_M, l_D);
 Result := Format('%d-%.2d-%.2d', [l_Y, l_M, l_D]);
end;

procedure TConverterForm.SendEmail(aTotalCount: Integer; const aElapsed: string);
var
 l_Address: String;
 l_SMTP: TidSMTP;
 l_Msg: TidMessage;
begin
 try
  TIdStack.IncUsage;
  l_Address:= GStack.LocalAddress;
  TIdStack.DecUsage;
 except
  l_Address:= 'unknown host';
 end;
 l_SMTP:= TidSMTP.Create;
 try
  l_Msg:= TidMessage.Create;
  try
   with l_SMTP do
   begin
    AuthType := idSMTP.atNone;
     {General setup}
    Host := 'smtp.garant.ru';
    with l_Msg do
    begin
     Encoding := mePlainText;
     From.Name:= l_Address;
     if f_NeedRestart then
      Subject := 'Done at ' + l_Address
     else
      Subject := 'Folder done at ' + l_Address;
     From.Address:= 'dudko@garant.ru';
     Recipients.EMailAddresses := 'narratius@live.ru;dudko@garant.ru';
     Priority := mpNormal; { Message Priority }
     CCList.EMailAddresses := ''; {CC}
     BccList.EMailAddresses := ''; {BBC}
     {indicate that there is no receipt recipiant}
     ReceiptRecipient.Text := '';

     ContentType:='text/plain; charset=windows-1251';
     ContentTransferEncoding:= '8bit';
     with Body do
     begin
      if f_NeedRestart then
       Add('Part of '+gSourceFolder +' done.')
      else
       Add('All files in '+gSourceFolder +' done.');
      Add('Elapsed time: '+ aElapsed);
      Add('From '+IntToStr(aTotalCount)+' files was:');
      Add('Worked: '+IntToStr(f_DoneCount));
      Add('Empty: '+IntToStr(f_EmptyCount));
      Add('Wrong: '+IntToStr(f_WrongCount));
     end;
    end; // with l_Msg
    Connect;
    try
     Send(l_Msg);
    finally
     Disconnect;
    end; // try..finally
   end; // with f_SMTP;
  finally
   FreeAndNil(l_Msg);
  end;
 finally
  FreeAndNil(l_SMTP);
 end;
end;

procedure TConverterForm.UpdateProgress(Sender: TObject; aTotalPercent: Integer);
begin
 with TddProgressObject(Sender) do
  ProgressLabel.Caption:= Format('Осталось: %s Прошло: %s', [TotalRemainingTimeAsString, TotalElapsedTimeAsString]);
 Application.ProcessMessages;
end;

procedure TConverterForm.WriteHelp;
begin
 MessageDlg(
  'gzxmlReader [/sdir] [/ddir] [/bdir] [/r] [/wdir] [/x] [/ffile] [/h]'#10 +
  '  /sdir  - папка исходных данных'#10 +
  '  /ddir  - папка для выходных данных'#10 +
  '  /bdir  - папка резервного копирования'#10 +
  '  /r     - включая подкаталоги'#10 +
  '  /wdir  - папка для "неправильных" файлов'#10 +
  '  /x     - из XML'#10 +
  '  /ffile - список каталогов для обработки'#10 +
  '  /h     - подсказка по использованию',
  mtInformation, [mbOk], 0);
end;

function TgzIDGenerator.GetExternalHandle: Integer;
begin
 Result := 80000000;
 // Нужно прочитать из инишника, присвоить, увеличить и положить обратно
 with Tl3IniFile.Create do
 try
  Section:= 'DocID';
  Result:= ReadParamIntDef('ID', Result);
  WriteParamInt('ID', Succ(Result));
 finally
  Free;
 end;
end;

procedure TgzIDGenerator.StartChild(ChildID: Integer);
begin
 inherited;
 if CurrentType.InheritsFrom(k2_idDocument) then
  AddIntegerAtom(k2_tiExternalHandle, GetExternalHandle);
end;

end.
