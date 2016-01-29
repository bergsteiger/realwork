unit mainform;
{.$DEFINE FullCycle} // Импорт напрямую в базу
{$DEFINE NSRC} // Преобразование в NSRC. Если не определено - эверест
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ddAppConfigTypes, ddFileIterator, l3Types,
  k2Reader, k2TagGen, l3Filer, //PravoSudIDGenerator,
  {PravoSudReaders,} ddProgressObj;

type
  TPravosudForm = class(TForm)
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
   // f_DocFilter: TPravoSudXMLReader;
    f_FileNames: TStrings;
    f_Files: TddFileIterator;
   // f_IDGen: TPravoSudIDGenerator;
    f_InFiler: TevDOSFiler;
    {$IFNDEF FullCycle}
    f_OutFiler: TevDOSFiler;
    {$ENDIF}
    f_Pipe: Tk2TagGenerator;
    f_Progressor: TddProgressObject;
    f_SegmentsList: TStrings;
    procedure AnalyzeProc(var aBreak: Boolean);
    procedure CheckFile(const aFileName: String);
    function ConvertOneFile(const aFileName: String): Boolean;
    procedure DestroyPipe;
    procedure FreeFileList;
    procedure LoadFileList;
    procedure MakePipe(const aFileName: String);
    procedure WorkupFiles;
    procedure OnDocumentStart(Sender: TObject; TopicNo: Integer; FilerType: Byte;
        MainGroup: ShortString);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PravosudForm: TPravosudForm;

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
 l3Base, l3Date, l3FileUtils, l3Stream, evNestedDocumentEliminator,
 {ddPravoSudStyler,} Format5Reader,
 {lukAutoBlockFilter, lukSDFReader, lukTextBeautyfier,}

 dd_lcTextChecker,
 StrUtils, ddDocTypeDetector;

{$R *.dfm}

procedure TPravosudForm.AnalyzeProc(var aBreak: Boolean);
begin
 Application.ProcessMessages;
 aBreak:= f_Abort;
end;

procedure TPravosudForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_Progressor);
 FreeAndNil(f_FileNames);
 FreeAndNil(f_SegmentsList);
 {$IFNDEF FullCycle}
 FreeAndNil(f_OutFiler);
 {$ENDIF}
 FreeAndNil(f_InFiler);
 f_Config.Save(MakedefaultStorage);
 FreeAndNil(f_Config);
end;

procedure TPravosudForm.FormCreate(Sender: TObject);
begin
 {$IFDEF FullCycle}
   Caption:= 'Импорт документов Право-Суд';
   ImportButton.Caption:= 'Импорт';
 {$ELSE}
  ImportButton.Caption:= 'Преобразовать';
  {$IFDEF NSRC}
   Caption:= 'Преобразование документов Право-Суд в формат NSRC';
  {$ELSE}
   Caption:= 'Преобразование документов Право-Суд в формат Эверест';
  {$ENDIF}
 {$ENDIF}
 f_Config:= MakeNode('Config', 'Настройки', False,
             {$IFDEF FullCycle}
             {0}MakeFolderName('BaseFolder', 'Путь к базе', '',
             {1}MakeString('Login', 'Пользователь', '',
             {2}MakeString('Password', 'Пароль', '', '*',
             {$ENDIF}
             // дальше просто параметры
             {3}MakeFolderName('SourceFolder', 'Папка с исходными данными', '',
             {4}MakeBoolean('WithSubFolder', 'С подпапками', False,
             {$IFDEF NeedIDGen}
             {5}MakeInteger('StartID', 'Начальный номер документов', 55040000,
             {$ENDIF}
             {$IFNDEF FullCycle}
             {6}MakeFolderName('DestinationFolder', 'Папка для преобразованных данных', '',
             {7}MakeBoolean('ClearDestFolder', 'Очистить перед обработкой', True,
             {$ENDIF}
             nil{$IFDEF FullCycle}))){$ELSE})){$ENDIF}{$IFDEF NeedIDGen}){$ENDIF})));
 f_Config.LabelTop:= False;
 f_Config.CreateFrame(WorkSpace, 0);
 f_Config.Load(MakedefaultStorage);
 f_Config.SetControlValues(False);
 f_Progressor := TddProgressObject.Create();
 f_Progressor.SetVisualParams(ProgressBar1, LabelProgress);
 f_InFiler := TevDOSFiler.Create();
 f_InFiler.Indicator.NeedProgressProc:= True;
 f_InFiler.Indicator.OnProgressProc:= f_Progressor.ProcessUpdate;
 {$IFNDEF FullCycle}
 f_OutFiler:= TevDOSFiler.Create();
 {$ENDIF}
 f_Pipe:= nil;
 f_SegmentsList := TStringList.Create;
 f_FileNames := TStringList.Create;
end;

procedure TPravosudForm.ImportButtonClick(Sender: TObject);
begin
 f_Config.Save(MakedefaultStorage); // На всякий случай
 ImportButton.Enabled:= False;
 WorkSpace.Enabled:= False;
 try
  f_Config.GetControlValues;
  {$IFDEF FullCycle}
  if InitBaseEngine(f_Config.AsString['BaseFolder'], f_Config.AsString['Login'], f_Config.AsString['Password']) then
  begin
  {$ENDIF}
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

procedure TPravosudForm.Button2Click(Sender: TObject);
begin
 if MessageDlg(IfThen(ImportButton.Enabled, 'Вы уверены, что хотите закрыть приложение?', 'Вы уверены, что хотите прервать обработку и выйти?'),
               mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 begin
  f_Abort:= True;
  Close;
 end;
end;

procedure TPravosudForm.CheckFile(const aFileName: String);
begin
 if GetFileSize(aFileName) = 0 then
  DeleteFile(aFileName);
end;

function TPravosudForm.ConvertOneFile(const aFileName: String): Boolean;
var
 l_Group, l_Class, l_Type: String;
 l_SegmentID: Integer;
 l_LimitDate: Integer;
 l_FileName: String;
 l_Stream: Tl3NamedTextStream;
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
    f_Infiler.FileName:= aFileName;
    {$IFNDEF FullCycle}
    l_FileName:= MakeUniqueFileName(ConcatDirName(f_Config.AsString['DestinationFolder'],
                                    ChangeFileExt(ExtractFileName(aFileName),
                                                  {$IFDEF NSRC}'.nsr'{$ELSE}'.evd'{$ENDIF})));
    f_OutFiler.FileName:=  l_FileName;
    (*
    l_Stream := Tl3NamedTextStream.Create(l_FileName, l3_fmWrite);
    try
     f_OutFiler.Stream := l_Stream;
    finally
     FreeAndNil(l_Stream);
    end;//try..finally
    *)
    {$ENDIF}
    //TPravoSudXMLStreamReader(f_Pipe).read;
    TFormat5Reader(f_Pipe).Execute;
    f_InFiler.Stream:= nil;
    {$IFNDEF FullCycle}
    f_OutFiler.Stream:= nil;
    f_FileNames.Add(l_FileName);
    {$ENDIF}
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

procedure TPravosudForm.DestroyPipe;
begin
 TFormat5Reader(f_Pipe).Finish;
 FreeAndNil(f_Pipe);
 {$IFDEF NeedIDGen}
 FreeAndNil(f_IDGen);
 {$ENDIF}
end;

procedure TPravosudForm.FreeFileList;
begin
 FreeAndNil(f_Files);
end;

procedure TPravosudForm.LoadFileList;
begin
 f_Files:= TddFileIterator.Make(f_Config.AsString['SourceFolder'], '*.*', f_Progressor.ProcessUpdate, f_Config.AsBoolean['WithSubFolder']);
end;

procedure TPravosudForm.MakePipe(const aFileName: String);
begin
 f_Pipe:= nil;
 {$IFDEF NeedIDGen}
 f_IDGen:= TPravoSudIDGenerator.Create;
 f_IDGen.NextDocID:= f_Config.AsInteger['StartID'];
 {$ENDIF}
 f_InFiler.FileName:= aFileName;
 {$IFDEF FullCycle}
 TddImportPipeFilter.SetTo(f_Pipe, CurrentFamily);
 with TddImportPipeFilter(f_Pipe) do
 begin
  UserID:= g_BaseEngine.CSClient.ClientId;
  CheckDocuments:= True;
  DocumentReaction:= sdrDelete;
  AddNewToLog:= True;
  UpdateDictionary:= True;
 end; // with TddImportPipeFilter(f_Pipe)
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
 {$IFNDEF FullCycle}
 //TddDocTypeDetector.SetTo(f_Pipe);
 //TddDocTypeDetector(f_Pipe).OnStartDocument:= OnDocumentStart;
 {$ENDIF}
 //TddPravoSudTextSplitter.SetTo(f_Pipe);
 TevNestedDocumentEliminator.SetTo(f_Pipe);
 //Получение текста из исходного документа
 //TPravoSudXMLStreamReader.SetTo(f_Pipe);
 TFormat5Reader.SetTo(f_Pipe);
 {$IFDEF NeedIDGen}
 //TPravoSudXMLStreamReader(f_Pipe).OnGetIDEvent:= f_IDGen.ConvertID;
 {$ENDIF}
 //TPravoSudXMLStreamReader(f_Pipe).Filer:= f_InFiler;
 //TPravoSudXMLStreamReader(f_Pipe).Start;
 TFormat5Reader(f_Pipe).Filer:= f_InFiler;
 TFormat5Reader(f_Pipe).Start;
end;

procedure TPravosudForm.WorkupFiles;
var
 i: Integer;
begin
 f_Abort:= False;
 f_FileNames.Clear;
 f_Files.IterateFiles(ConvertOneFile);
 for i:= 0 to f_FileNames.Count-1 do
  CheckFile(f_FileNames[i]);
end;

procedure TPravoSudForm.OnDocumentStart(Sender: TObject; TopicNo: Integer;
    FilerType: Byte; MainGroup: ShortString);
var
 l_Folder: String;
begin
 {$IFNDEF FullCycle}
 f_OutFiler.FileName:= ConcatDirName(f_Config.AsString['DestinationFolder'],
                                    ChangeFileExt(IntToStr(TopicNo), {$IFDEF NSRC}'.nsr'{$ELSE}'.evd'{$ENDIF}));
 f_OutFiler.Mode:= l3_fmWrite;
 {$ENDIF}
end;

end.
