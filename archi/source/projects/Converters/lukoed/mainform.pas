unit mainform;
{.$DEFINE FullCycle} // Импорт напрямую в базу
{.$DEFINE NSRC} // Преобразование в NSRC. Если не определено - эверест
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ddAppConfigTypes, ddFileIterator, l3Types,
  k2Reader, k2TagGen, l3Filer, lukIDGenerator,
  lukDocumentFilter;

type
  TSDFImportForm = class(TForm)
    WorkSpace: TPanel;
    ProgressBar1: TProgressBar;
    ImportButton: TButton;
    CancelButton: TButton;
    LabelProgress: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImportButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    f_Abort: Boolean;
    f_AliasCfg: TddAppConfigNode;
    f_Config: TddAppConfigNode;
    f_DocFilter: TlukDocFilter;
    f_FileNames: TStrings;
    f_Files: TddFileIterator;
    f_IDGen: TlukIDGenerator;
    f_InFiler: TevDOSFiler;
    {$IFNDEF FullCycle}
    f_OutFiler: TevDOSFiler;
    {$ENDIF}
    f_Pipe: Tk2TagGenerator;
    f_SegmentsList: TStrings;
    procedure AnalyzeProc(var aBreak: Boolean);
    function BuildSegmentList: Boolean;
    procedure CheckFile(const aFileName: String);
    function CheckSegment(const aFileName: string): Boolean;
    function ConvertOneFile(const aFileName: String): Boolean;
    procedure DestroyAliasCfg;
    procedure ExcludeRemoved;
    procedure GetSegmentInfo(const aFileName: String; out theGroup, theClass,
        theType: string; out theSegmentID, theLimitDate: Integer);
    procedure MakeAliasCfg;
    procedure DestroyPipe;
    procedure FilerProgress(aState: Byte; aValue: Integer; const aMessage: String);
    procedure FreeFileList;
    procedure LoadFileList;
    procedure MakePipe(const aFileName: String);
    procedure Progress(aState : Byte; aValue : Long; const aMsg : String = '');
    procedure StructItem(const atext: String; aLevel: Integer);
    procedure WorkupFiles;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SDFImportForm: TSDFImportForm;

implementation

uses
 {$IFDEF FullCycle}
 ddClientBaseEngine, ddHTInit, CsClient, DT_IFltr, DT_Const, DT_Types,
 ddImportPipeKernel
 {$ELSE}
  {$IFDEF NSRC}
  ddNSRC_w, evSimpleTextPainter
  {$ELSE}
  EvdWriter
  {$ENDIF}
 {$ENDIF},
 ddAppConfigLists, ddAppConfigUtils, ddAppConfigDataAdapters, ddSectionRepair,
 l3Base, l3Date, l3FileUtils,
 lukAutoBlockFilter, lukSDFReader, lukTextBeautyfier, dd_lcTextChecker,
 StrUtils;

{$R *.dfm}

procedure TSDFImportForm.AnalyzeProc(var aBreak: Boolean);
begin
 Application.ProcessMessages;
 aBreak:= f_Abort;
end;

function TSDFImportForm.BuildSegmentList: Boolean;
var
 i, Index: integer;
begin
 // Выяснить, сколько сегментов будем обрабатывать
 f_SegmentsList.Clear;
 f_Files.IterateFiles(CheckSegment);
 // запросить значения для сегментов
 for i:= 0 to Pred(f_SegmentsList.Count) do
 begin
  Index:= TddListConfigItem(f_AliasCfg.ItemByAlias['AliasList']).DataAdapter.AddItem;
  if Index <> -1 then
   TddAppConfigNode(TddListConfigItem(f_AliasCfg.ItemByAlias['AliasList']).DataAdapter.Objects[Index]).Items[0].StringValue:= f_SegmentsList.Names[i];
 end;
 Result:= ExecuteNodeDialog(f_AliasCfg);
end;

procedure TSDFImportForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_FileNames);
 FreeAndNil(f_SegmentsList);
 {$IFNDEF FullCycle}
 FreeAndNil(f_OutFiler);
 {$ENDIF}
 FreeAndNil(f_InFiler);
 f_Config.Save(MakedefaultStorage);
 FreeAndNil(f_Config);
end;

procedure TSDFImportForm.FormCreate(Sender: TObject);
begin
 f_Config:= MakeNode('Config', 'Настройки',
             {$IFDEF FullCycle}
             {0}MakeFolderName('BaseFolder', 'Путь к базе', '',
             {1}MakeString('Login', 'Пользователь', '',
             {2}MakeString('Password', 'Пароль', '', '*',
             {$ENDIF}
             // дальше просто параметры
             {3}MakeFolderName('SourceFolder', 'Папка с исходными данными', '',
             {4}MakeBoolean('WithSubFolder', 'С подпапками', False,
             {5}MakeInteger('StartID', 'Начальный номер документов', 55040000,
             {$IFNDEF FullCycle}
             {6}MakeFolderName('DestinationFolder', 'Папка для преобразованных данных', '',
             {7}MakeBoolean('ClearDestFolder', 'Очистить перед обработкой', True,
             {$ENDIF}
             nil{$IFDEF FullCycle}))){$ELSE})){$ENDIF}))));
 f_Config.LabelTop:= False;
 f_Config.CreateFrame(WorkSpace, 0);
 f_Config.Load(MakedefaultStorage);
 f_Config.SetControlValues(False);
 f_InFiler := TevDOSFiler.Create();
 f_InFiler.Indicator.NeedProgressProc:= True;
 f_InFiler.Indicator.OnProgressProc:= FilerProgress;
 {$IFNDEF FullCycle}
 f_OutFiler:= TevDOSFiler.Create();
 {$ENDIF}
 f_Pipe:= nil;
 f_SegmentsList := TStringList.Create;
 f_FileNames := TStringList.Create;
end;

procedure TSDFImportForm.ImportButtonClick(Sender: TObject);
begin
 ImportButton.Enabled:= False;
 WorkSpace.Enabled:= False;
 try
  f_Config.GetControlValues;
  {$IFDEF FullCycle}
  if InitBaseEngine(f_Config.AsString['BaseFolder'], f_Config.AsString['Login'], f_Config.AsString['Password']) then
  begin
  {$ENDIF}
   MakeAliasCfg;
   try
    LoadFileList;
    {$IFNDEF FullCycle}
    if f_Config.AsString['DestinationFolder'] = '' then
     f_Config.AsString['DestinationFolder']:= ConcatDirName(ExtractFilePath(Application.ExeName), 'WorkedFiles');
    ForceDirectories(f_Config.AsString['DestinationFolder']);
    PureDir(f_Config.AsString['DestinationFolder']);
    {$ENDIF}
    L3System.Msg2Log('Начало преобразования');
    WorkupFiles;
    L3System.Msg2Log(IfThen(f_Abort, 'Преобразование прервано', 'Преобразование закончено'));
    ShowMessage(IfThen(f_Abort, 'Преобразование прервано', 'Преобразование закончено'));
   finally
    FreeFileList;
    destroyPipe;
    {$IFDEF FullCycle}
    DoneClientBaseEngine;
    {$ENDIF}
    DestroyAliasCfg;
   end;
  {$IFDEF FullCycle}
  end
  else
   ShowMessage('не удалось подключиться к базе данных');
  {$ENDIF}
 finally
  ImportButton.Enabled:= True;
  WorkSpace.Enabled:= True;
 end;
end;

procedure TSDFImportForm.Button2Click(Sender: TObject);
begin
 if MessageDlg(IfThen(ImportButton.Enabled, 'Вы уверены, что хотите закрыть приложение?', 'Вы уверены, что хотите прервать обработку и выйти?'),
               mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin
  f_Abort:= True;
  Close;
 end; 
end;

procedure TSDFImportForm.CheckFile(const aFileName: String);
begin
 if GetFileSize(aFileName) = 0 then
  DeleteFile(aFileName);
end;

function TSDFImportForm.CheckSegment(const aFileName: string): Boolean;
var
 l_S: String;
begin
 Result := True;
 l_S:= ExtractFilePath(aFileName);
 Delete(l_S, 1, Length(f_Config.AsString['SourceFolder']));
 Delete(l_S, Pos('\SRC', UpperCase(l_S)), Length(l_S));
 if l_S[1] = '\' then
  Delete(l_S, 1, 1);
 if l_S = '' then
  l_S:= 'default';
 if f_SegmentsList.Values[l_S] = '' then
  f_SegmentsList.Values[l_S]:= Copy(ExtractFilePath(aFileName), 1, Pos('\SRC', UpperCase(aFileName)));
end;

function TSDFImportForm.ConvertOneFile(const aFileName: String): Boolean;
var
 l_Group, l_Class, l_Type: String;
 l_SegmentID: Integer;
 l_LimitDate: Integer;
 l_FileName: String;
begin
 if not f_Abort then
 begin
  if f_Pipe = nil then
   MakePipe(aFileName);
  Result:= False;
  try
   l3System.Msg2Log(aFileName);
   if GetFileSize(aFileName) > 0 then
   begin
    f_InFiler.FileName:= aFileName;
    {$IFNDEF FullCycle}
    l_FileName:= MakeUniqueFileName(ConcatDirName(f_Config.AsString['DestinationFolder'],
                                    ChangeFileExt(ExtractFileName(aFileName),
                                                  {$IFDEF NSRC}'.nsr'{$ELSE}'.evd'{$ENDIF})));
    f_OutFiler.FileName:=  l_FileName;
    {$ENDIF}
    GetSegmentInfo(aFileName, l_Group, l_Class, l_Type, l_SegmentID, l_LimitDate);
    f_IDGen.SegmentID:= l_SegmentID;
    f_IDGen.AddFileName(aFileName);
    f_DocFilter.LimitDate:= l_LimitDate;
    TlukSDFReader(f_Pipe).DocGroup:= l_Group;
    TlukSDFReader(f_Pipe).DocClass:= l_Class;
    TlukSDFReader(f_Pipe).DocType:= l_Type;
    TlukSDFReader(f_Pipe).Read;
    f_FileNames.Add(l_FileName);
   end
   else
    l3System.Msg2Log('  - пустой');
   Result:= True;
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    l3System.Msg2Log('Ошибка преобразования файла %s', [aFilename]);
   end;
  end;
 end
 else
  Result:= False;
end;

procedure TSDFImportForm.DestroyAliasCfg;
begin
 FreeAndNil(f_AliasCfg);
end;

procedure TSDFImportForm.DestroyPipe;
begin
 TlukSDFReader(f_Pipe).Finish;
 FreeAndNil(f_Pipe);
 FreeAndNil(f_IDGen);
end;

procedure TSDFImportForm.ExcludeRemoved;
var
 i: Integer;
begin
 i:= f_Files.Count;
 while i <> 0 do
 begin
  if AnsiContainsText(f_Files.FileList[Pred(i)], '!old') or AnsiContainsText(f_Files.FileList[Pred(i)], 'removed') then
   f_Files.FileList.Delete(Pred(i));
  Dec(i);
 end;
end;

procedure TSDFImportForm.FilerProgress(aState: Byte; aValue: Integer; const
    aMessage: String);
begin
 Application.ProcessMessages;
end;

procedure TSDFImportForm.FreeFileList;
begin
 FreeAndNil(f_Files);
end;

procedure TSDFImportForm.GetSegmentInfo(const aFileName: String; out theGroup,
    theClass, theType: string; out theSegmentID, theLimitDate: Integer);
var
 i: Integer;
begin
 theGroup:= 'LUK';
 theClass:= 'Документы ЛУКойл';
 for i:= 0 to Pred(f_SegmentsList.Count) do
  if AnsiStartsText(f_SegmentsList.ValueFromIndex[i], aFileName) then
  begin
   with TddAppConfigNode(TddListConfigItem(f_AliasCfg.ItemByAlias['AliasList']).DataAdapter.Objects[i]) do
   begin
    theSegmentID:= Items[1].IntegerValue;
    theGroup:= Items[2].StringValue;
    theLimitDate:= DateTimeToDtDate(Items[3].DateTimeValue);
   end; // with TddAppConfigNode(TddListConfigItem(f_AliasCfg.ItemByAlias['AliasList']).DataAdapter.Objects[i])
   if AnsiSameText(theGroup, 'LOK') then
   begin
    theClass:= 'Локальные акты';
    theType:= '';
   end
   else
   if AnsiSameText(theGroup, 'PRO') then
   begin
    theClass:= 'Протоколы';
    theType:= 'Протокол';
   end
   else
   if AnsiSameText(theGroup, 'DOV') then
   begin
    theClass:= 'Доверенности';
    theType:= 'Доверенность';
   end;
   break;
  end;
end;

procedure TSDFImportForm.LoadFileList;
begin
 f_Files:= TddFileIterator.Make(f_Config.AsString['SourceFolder'], '*.sdf', Progress, f_Config.AsBoolean['WithSubFolder']);
 ExcludeRemoved;
 BuildSegmentList;
end;

procedure TSDFImportForm.MakeAliasCfg;
begin
 f_AliasCfg:= TddAppConfigNode.Create('AliasCfg', 'Сегменты базы');
 with f_AliasCfg do
 begin
  AddItem(TddSimpleListConfigItem.Make('AliasList', 'Список сегментов',
            MakeString('Имя папки', '',            // 0
            MakeInteger('Идентификатор', 1017,     // 1
            MakeString('Группа документов', 'LOK', // 2
            MakeDateTime('Не позднее', Date,       // 3
            nil))))));
 end;
end;

procedure TSDFImportForm.MakePipe(const aFileName: String);
var
 l_StructCreator: TlukStructureCreator;
begin
 f_Pipe:= nil;
 f_IDGen:= TlukIDGenerator.Create;
 f_IDGen.NextDocID:= f_Config.AsInteger['StartID'];
 f_InFiler.FileName:= aFileName;
 {$IFDEF FullCycle}
 TddImportPipeFilter.SetTo(f_Pipe, CurrentFamily);
 TddImportPipeFilter(f_Pipe).UserID:= g_BaseEngine.CSClient.ClientId;
 TddImportPipeFilter(f_Pipe).CheckDocuments:= True;
 TddImportPipeFilter(f_Pipe).DocumentReaction:= sdrDelete;
 TddImportPipeFilter(f_Pipe).AddNewToLog:= True;
 {$ELSE}
 f_OutFiler.FileName:= ChangeFileExt(aFileName, {$IFDEF NSRC}'.nsr'{$ELSE}'.evd'{$ENDIF});
 {$IFDEF NSRC}
 TddNSRCGenerator.SetTo(f_Pipe);
 TddNSRCGenerator(f_Pipe).Filer:= f_OutFiler;
 TevSimpleTextPainter.SetTo(f_Pipe);
 {$ELSE}
 TevdNativeWriter.SetTo(f_Pipe);
 TevdNativeWriter(f_Pipe).Filer:= f_OutFiler;
 {$ENDIF}
 {$ENDIF}
 // Форматирование текста
 TlukStructureCreator.SetTo(f_Pipe);
 l_StructCreator:= TlukStructureCreator(f_Pipe);
 TlukStyleReplacer.SetTo(f_Pipe);
 TlukSegmentJoiner.SetTo(f_Pipe);
 TlukPresidentFilter.SetTo(f_Pipe);
 TlukNumberDecorator.SetTo(f_Pipe);
 TlukPointDecorator.SetTo(f_Pipe);
 TlukSpaceInserter.SetTo(f_Pipe);
 TlukTextReplacer.SetTo(f_Pipe, '  ', ' ');
 //TlukTextReplacer.SetTo(f_Pipe, #10, ' '); // оставляем для красоты
 TlukTextReplacer.SetTo(f_Pipe, #160, '');
 TlukTextSplitter.SetTo(f_Pipe, #10#160);
 TlukTextSplitter.SetTo(f_Pipe, #10#160#10#160#160#160#160);
 TlukStructureFilter.SetTo(f_Pipe);
 TlukStructureFilter(f_Pipe).OnStructItem:= l_StructCreator.StructItem;
 TddSectionRepairFilter.SetTo(f_Pipe);
 f_DocFilter:= TlukDocFilter.SetTo(f_Pipe);
 //Получение текста из исходного документа
 TlukSDFReader.SetTo(f_Pipe, f_IDGen);
 TlukSDFReader(f_Pipe).OnAnalyze:= AnalyzeProc;
 TlukSDFReader(f_Pipe).Filer:= f_InFiler;
 TlukSDFReader(f_Pipe).Start;
end;

procedure TSDFImportForm.Progress(aState : Byte; aValue : Long; const aMsg : String = '');
begin
 case aState of
  0:
   begin
    ProgressBar1.Max:= aValue;
    ProgressBar1.Position:= 0;
   end;
  1,2: ProgressBar1.Position:= aValue;
 end;
 if aMsg <> '' then
  labelProgress.Caption:= aMsg;
 Application.ProcessMessages;
end;

procedure TSDFImportForm.StructItem(const atext: String; aLevel: Integer);
begin
 l3System.Msg2Log('text: %s, level %d', [atext, alevel]);
end;

procedure TSDFImportForm.WorkupFiles;
var
 i: Integer;
begin
 f_Abort:= False;
 f_FileNames.Clear;
 f_Files.IterateFiles(ConvertOneFile);
 for i:= 0 to f_FileNames.Count-1 do
  CheckFile(f_FileNames[i]);
end;

end.
