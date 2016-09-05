unit evd_aform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ddProgressObj,
  {$IFDEF UseZip}ZipMstr,{$ENDIF}
  Dialogs, ddAppConfigTypes, ExtCtrls, StdCtrls, ComCtrls, k2Types, l3FieldSortRecList, l3LongintList;

type
  TImportEVDForm = class(TForm)
    WorkPanel: TPanel;
    Panel2: TPanel;
    GoButton: TButton;
    CancelButton: TButton;
    Panel1: TPanel;
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    f_Aborted: Boolean;
    f_Config: TddAppConfigNode;
    f_EmptyCount: Integer;
    f_Errors: Array[0..1] of TStream;
    procedure EmptyDocFound(Sender: TObject);
    procedure ErrorReaction(const Msg: String; Category: Integer = 0);
   procedure ImportDocuments;
    procedure ImportOnePart(aFiles: TStrings; aProgress: TddProgressObject; aLow:
        Integer = 0; aHigh: Integer = MaxInt);
    procedure ImportRange(aFiles: TStrings; aProgress: TddProgressObject; aLow,
        aHigh: Integer);
    procedure OnUpdate(Sender: TObject; aState, aPercent: Integer);
    {$IFDEF UseZip}
    procedure PackBase(aCount: Integer);
    procedure PackLogFiles;
    procedure ZipProgress(Sender: TObject; details: TProgressDetails);
    {$ENDIF}
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImportEvdForm: TImportEVDForm;

implementation

Uses
 l3Base, l3Types, l3String, l3Filer, l3LingLib, l3Date,
 ddAppConfigUtils, ddImportPipeKernel, ddLCCodexLinkFilter, ddHTInit,  ddFileIterator,
 ddLawCaseNameGenerator, ddSpaceTrimmer,
 k2TagGen, k2TagTerminator, k2TagFilter, k2Tags,
 daInterfaces,
 dt_Types, dt_Serv, dt_Const,
 evEvdReader,
 afwVCL,
 StrUtils,
 DictItem_Const, Document_Const, TextPara_Const, Block_Const,
 Participant_Const, NumAndDate_Const, dd_lcSectionEliminator,
 dd_lcTextFormatter, dd_lcTableEliminator, dd_lcPageNumberEliminator,
 SectionBreak_Const, dd_lcDossierMaker, dd_lcBelongsGenerator
 , DT_Sab, Math, DT_Link, DT_LinkServ, DT_DictConst, DT_Dict, rxStrUtils,
 DT_Srch2, l3LongintListPrim, DT_Doc, ddHeaderFilter, k2Interfaces,
  Dt_ReNum, dd_lcDoublicateFilter, l3FileUtils, stFileOp, ddUtils,
  dd_lcTextChecker, dd_lcCaseCodeGenerator, ddKTExtractor, dd_lcDocIDGenerator;

{$R *.dfm}




procedure TImportEVDForm.ImportDocuments;
var
 l_Prg: TddProgressObject;
 l_Files: TddFileIterator;
 i, l_PartCount, l_Range: Integer;
begin
 f_Errors[0]:= TFileStream.Create(ChangeFileExt(Application.ExeName, '.err'), fmCreate);
 f_Errors[1]:= TFileStream.Create(ChangeFileExt(Application.ExeName, 'Links.err'), fmCreate);
 f_EmptyCount:= 0;
 try
  l_Prg:= TddProgressObject.Create(nil);
  try
   l_Prg.OnUpdate:= OnUpdate;
   f_Aborted:= False;
   l_Files:= TddFileIterator.Make(f_Config.Items[3].Value.AsString, '*.evd');
   try
    if l_Files.FileList.Count > 0 then
    begin
     if f_Config.Count >= 10 then
      l_Range:= f_Config.Items[9].Value.AsInteger
     else
      l_Range:= 0;
     if l_Range > 0 then
      l_Range:= Min(l_Range, l_Files.FileList.Count)
     else
      l_Range:= l_Files.FileList.Count;
     l_PartCount:= l_Files.FileList.Count div l_Range;
     if l_Files.FileList.Count mod l_Range > 0 then
      Inc(l_PartCount);
     LoadKTScan(f_Config.Items[8].Value.AsString);
     l_Prg.Start(l_Files.FileList.Count);
     try
      for i:= 1 to l_PartCount do
       ImportOnePart(l_Files.FileList, l_Prg, Pred(i)*l_Range, i*l_Range);
     finally
      l_Prg.Stop;
     end;
    end; // l_Files.FileList.Count > 0
    l3System.Msg2Log('%d файлов импортировано за %s', [l_Files.FileList.Count, l_Prg.ElapsedTimeAsString]);
   finally
    l3Free(l_Files);
   end;
  finally
   l3Free(l_Prg);
  end;
 finally
  f_Errors[0].Free;
  f_Errors[1].Free;
 end;
 if f_EmptyCount > 0 then
  l3System.Msg2Log('Найдено %d пустых документов', [f_EmptyCount]);
 {$IFDEF UseZip}
 PackLogFiles;
 {$ENDIF}
end;

procedure TImportEVDForm.FormCreate(Sender: TObject);
begin
 AfwHackControlFont(Self);
 f_Config:= MakeNode('Config', 'Настройки',
             {0}MakeFolderName('Путь к базе', '',
             {1}MakeString('Пользователь', '', #0,
             {2}MakeString('Пароль', '', '*',
             {3}MakeFolderName('Папка с исходными данными', '',
             {4}MakeFileName('Список кодексов', '*.csv', '',
             {5}MakeFileName('Список ФЗ', '*.csv', '',
             {6}MakeString('Тип документов', '91', #0,
             {7}MakeString('Исходящие органы', '1807;1653;1772;1808;1809;1810;1811;1806;1553;1805;1812;1813;1556;1819;1814;1773;1815;1816;1818;1817', #0,
             {8}MakeFileName('Список Ключевых тем', '*.csv', '' (*,
             {9}MakeInteger('Импортировать по|файлов', 50000
             )*)))))))))));
 f_Config.LabelTop:= False;
 f_Config.CreateFrame(WorkPanel, 0);
 f_Config.Load(MakedefaultStorage);
 f_Config.SetControlValues(False);
end;

procedure TImportEVDForm.FormDestroy(Sender: TObject);
begin
 f_Config.Save(MakedefaultStorage);
 l3Free(f_Config);
end;

procedure TImportEVDForm.GoButtonClick(Sender: TObject);
begin
 GoButton.Enabled:= False;
 try
  CancelButton.Caption:= 'Отмена';
  f_Config.GetControlValues;
  if InitBaseEngine(f_Config.Items[0].Value.AsString, f_Config.Items[1].Value.AsString, f_Config.Items[2].Value.AsString) then
  try
   ImportDocuments;
  finally
   DoneClientBaseEngine;
  end
  else
   MessageDlg('Не удалось подключиться к базе данных', mtError, [mbOk], 0);
 finally
  CancelButton.Caption:= 'Выход';
  GoButton.Enabled:= True;
 end;
end;

procedure TImportEVDForm.CancelButtonClick(Sender: TObject);
begin
 if GoButton.Enabled then
  Close
 else
  f_Aborted:= True;
end;

procedure TImportEVDForm.EmptyDocFound(Sender: TObject);
begin
 Inc(f_EmptyCount);
end;

procedure TImportEVDForm.ErrorReaction(const Msg: String; Category: Integer = 0);
var
 i: Integer;
const
 EOL = #13#10;
begin
 i:= IfThen(Category = 0, 0, 1);
 f_Errors[i].Write(Msg[1], Length(Msg));
 f_Errors[i].Write(EOL[1], 2);
end;

procedure TImportEVDForm.ImportOnePart(aFiles: TStrings; aProgress:
    TddProgressObject; aLow: Integer = 0; aHigh: Integer = MaxInt);
begin
 ImportRange(aFiles, aProgress, aLow, aHigh);
 GlobalHtServer.UpdateAllTbl(CurrentFamily);
 {$IFDEF UseZip}
 PackBase(aHigh);
 {$ENDIF}
end;

procedure TImportEVDForm.ImportRange(aFiles: TStrings; aProgress:
    TddProgressObject; aLow, aHigh: Integer);
var
 l_Reader: TevEvdStorageReader;
 l_Filer: TevDOSFiler;
 i, l_Count: Integer;
 l_Gen: Tk2TagGenerator;
begin
 l_Gen:= TddImportPipeFilter.Create(CurrentFamily);
 try
  with TddImportPipeFilter(l_Gen) do
  begin
   UserID:= usServerService;
   AddNewToLog:= True;
   BaseGenerator.ExclusiveMode:= True;
  end; //
  TlcDossierMaker.SetTo(l_Gen);
  TlcDossierMaker(l_Gen).OnNewDocument:= TDocIDGenerator.GetNewDocID;
  TddLCCodexLinkFilter.SetTo(l_Gen, f_Config.Items[4].Value.AsString, f_Config.Items[5].Value.AsString);
  TddLCCodexLinkFilter(l_Gen).onError:= ErrorReaction;
  TddKTExtractorFilter.SetTo(l_Gen);
  TlcTextChecker.setTo(l_Gen);
  TlcTextChecker(l_Gen).OnEmptyDocument:= EmptyDocFound;
  Tdd_lcTextFormatter.SetTo(l_Gen, k2_idTextPara);
  Tdd_lcTextFormatter(l_Gen).OnError:= ErrorReaction;
  Tdd_lcNameGenerator.SetTo(l_Gen);
  Tdd_lcSectionEliminator.SetTo(l_Gen);
  Tdd_lcSectionEliminator(l_Gen).OnError:= ErrorReaction;
  TddSpaceTrimmerFilter.SetTo(l_Gen);
  TddSpaceTrimmerFilter(l_Gen).OnError:= ErrorReaction;
  Tdd_lcPageNumberEliminator.SetTo(l_Gen, k2_idTextPara);
  TlcTableEliminator2.SetTo(l_Gen);
  TlcBelongsGenerator.SetTo(l_Gen);
  TlcDoublicateFilter.SetTo(l_Gen);
  TDocIDGenerator.SetTo(l_Gen);
  TDocIDGenerator(l_Gen).Types:= f_Config.Items[6].Value.AsString;
  TDocIDGenerator(l_Gen).Sources:= f_Config.Items[7].Value.AsString;
  TevEvdStorageReader.SetTo(l_Gen);
  l_Reader:= l_Gen as TevEvdStorageReader;
  l_Filer:= TevDOSFiler.Create();
  try
   l_Reader.Filer:= l_Filer;
   l_Count:= Min(aFiles.Count, aHigh);
   l_Reader.Generator.Start;
   try
    for i:= aLow to Pred(l_Count) do
    begin
     if not f_Aborted then
     begin
      l_Filer.FileName:= aFiles.Strings[i];
      l_Reader.Start;
      try
       l3System.Str2Log(ExtractFileName(aFiles.Strings[i]));
       l_Reader.Execute;
      finally
       l_Reader.Finish;
      end;
      aProgress.Update(1, i, aFiles.Strings[i]);
     end
     else
      break;
    end; // for i
   finally
    l_Reader.Generator.Finish;
   end;
  finally
   l3Free(l_Filer);
  end;
 finally
  l3Free(l_Gen);
 end;
end;

procedure TImportEVDForm.OnUpdate(Sender: TObject; aState, aPercent: Integer);
begin
 case aState of
  0: begin
      Progressbar.Position:= 0;
      ProgressLabel.Caption:= '';
     end;
  1: begin
      Progressbar.Position:= aPercent;
      ProgressLabel.Caption:= 'До окончания осталось примерно: '+(Sender as TddProgressObject).TotalRemainingTimeAsString;
     end;
  2: begin
      Progressbar.Position:= 100;
      ProgressLabel.Caption:= 'Импорт завершен за '+(Sender as TddProgressObject).TotalElapsedTimeAsString;
     end;
 end;
 Application.ProcessMessages;
end;
{$IFDEF UseZip}
procedure TImportEVDForm.PackBase(aCount: Integer);
var
 SR: TSearchRec;
 l_ZipFile: String;
begin
 Progressbar.Position:= 0;
 ProgressLabel.Caption:= 'Упаковка промежуточных результатов...';
 l_ZipFile:= Format('%s\part_%d', [g_BaseEngine.DataParams.DocStoragePath, aCount]);
 if DirectoryExists(l_ZipFile) then
  DelDir(l_ZipFile);
 CopyFolder(g_BaseEngine.DataParams.DocStoragePath+'\garant', l_ZipFile, False);
 (*
 l3System.Str2Log(ProgressLabel.Caption);
 l_ZipFile:= Format('%s\part_%d.zip', [g_BaseEngine.DataParams.DocStoragePath, aCount]);
 if FileExists(l_ZipFile) then
  DeleteFile(l_ZipFile);
 with TZipMaster.Create(nil) do
 try
  Language:= 'RU';
  OnProgressDetails:= ZipProgress;
  ZipFileName:= l_ZipFile;
  Dll_Load:= True;
  // Добавить имена файлов
  if FindFirst(ConcatDirName(g_BaseEngine.DataParams.DocStoragePath+'\garant', '*.*'), faAnyFile, sr) = 0 then
  begin
   repeat
    if not f_Aborted then
    begin
     if SR.Size > 0 then
     begin
      FSpecArgs.Add(ConcatDirName(g_BaseEngine.DataParams.DocStoragePath+'\garant', SR.Name));
      if Add <> 0 then
      begin
       l3System.Str2Log(Message);
       break;
      end;
     end; // SR.Size > 0
    end; // not f_Aborted
   until FindNext(sr) <> 0;
   FindClose(sr);
  end;
  Dll_Load:= False;
 finally
  Free;
 end;
 *)
 Progressbar.Position:= 100;
 ProgressLabel.Caption:= 'Упаковка завершена';
end;

procedure TImportEVDForm.PackLogFiles;
begin
 with TZipMaster.Create(nil) do
 try
  Language:= 'RU';
  OnProgressDetails:= ZipProgress;
  ZipFileName:= ExtractFilePath(Application.ExeName)+'logs'+AnsiReplaceStr(DateTimeToStr(Now), ':', '')+'.zip';
  Dll_Load:= True;
  FSpecArgs.Add(ChangeFileExt(Application.ExeName, '.err'));
  FSpecArgs.Add(ChangeFileExt(Application.ExeName, 'Links.err'));
  Add;
  Dll_Load:= False;
 finally
  Free;
 end;
end;

procedure TImportEVDForm.ZipProgress(Sender: TObject; details:
    TProgressDetails);
begin
 if Details.Order = ProgressUpdate then
 begin
  Progressbar.Position:= Details.ItemPerCent;
  ProgressLabel.Caption:= 'Упаковка '+ Details.ItemName;
 end;
end;
{$ENDIF}




end.
