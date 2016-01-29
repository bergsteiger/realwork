unit gzForm;

interface
{$I ProjectDefine.inc}
{.$DEFINE OLDXMLREADER}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, k2TagFilter, l3Types, k2Reader,
  ExtCtrls;

type
  TConverterForm = class(TForm)
    ProgressBar: TProgressBar;
    ProgressLabel: TLabel;
    LabelFolder: TLabel;
    LabelFile: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure FormCreate(Sender: TObject);
  private
    f_Abort: Boolean;
    f_DoneFiles: TStrings;
    f_EmptyDoc: Boolean;
    f_gFolderList: string;
    f_OldFormat: Boolean;
    f_Reader: Tk2CustomFileReader;
    gDoneFolder: string;
    gExcludeMask: string;
    gExcludeMaskList: string;
    gFromGZ: Boolean;
    gWithSubDirs: Boolean;
    gSaveDocImages: Boolean;
   procedure ConvertFiles;
    procedure CopyToBackup(const aFileName: String);
    procedure CopyToDone(const aFileName: String);
    procedure NonEmptyDocument(Sender: TObject);
    procedure Idle(Sender: TObject; var Done: Boolean);
   procedure Initialize;
    procedure CorrectParameters;
   procedure LoadParameters;
    function pm_GetToday: string;
   procedure UpdateProgress(Sender: TObject; aTotalPercent: Integer);
   procedure WriteHelp;
    { Private declarations }
  protected
    procedure DeleteFiles;
    procedure PackSendLog;
  public
    { Public declarations }
   gSourceFolder: String;
   gDestinationFolder: String;
   gBackupFolder: String;
   gNeedHelp: Boolean;
    function PackSelfLog(const aPackedFileName: string; aClearLog: Boolean): Boolean;
    property gFolderList: string read f_gFolderList write f_gFolderList;
  published
    property Today: string read pm_GetToday;
  end;

var
  ConverterForm: TConverterForm;

implementation

Uses
 StrUtils,
 l3Base,
 evdWriter, evdSchema,
 ddFileIterator, ddProgressObj, dd_lcTextChecker,
 l3Filer, l3FileUtils, l3GZipStream,
 k2TagGen, ddUtils, TextPara_Const, Document_Const, PrevInst, ddZipUtils,
 l3Stream, Masks, IDSmtp, IDMessage, IDAttachmentFile, IDText, l3ExceptionsLog,
 {$IFDEF OLDXMLREADER}
 ddArbitralCourtReader,
 {$ELSE}
 dd_lcPageNumberEliminator, ddLawCaseNameGenerator, dd_lcBelongsGenerator, dd_lcVASCodeCorrector,
 dd_lcYearCodeCorrector, dd_lcTypeConverter, dd_lcSourceConverter, dd_lcVASSourceCorrector,
 dd_lcParticipantsNormalizeFilter, evNestedDocumentEliminator, dd_lcDocImageConverter, dd_lcXMLReader2,
 dd_lcDocByTypeFilter, dd_lcHiddenTextExtractor
 {$ENDIF}
 ;
        

{$R *.dfm}

procedure TConverterForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_DoneFiles);
end;

procedure TConverterForm.FormCreate(Sender: TObject);
begin
 //if GotoPrevInst then
 // Application.Terminate
 //else
  Initialize;
 f_DoneFiles := TStringList.Create;
end;

procedure TConverterForm.ConvertFiles;
var
 {$IFDEF OLDXMLREADER}
 l_Filer : TevDOSFiler;
 {$ELSE}
 l_Filer : Tl3CustomFiler;
 l_XMLReader: TlcXMLStreamReader;
 l_ImgConverter: TlcDocImageConvertFilter;
 {$ENDIF}
 l_Filer2: TevDOSFiler;
 l_Files: TddFileIterator;
 i: Integer;
 l_Start: TDateTime;
 l_Prg: TddProgressObject;
 l_Gen: Tk2TagGenerator;
 l_ExMasks: TStrings;

 procedure BuildPipe;
 begin
  l_Gen:= TevdNativeWriter.Create;
  TevdNativeWriter(l_Gen).Binary:= False; //True;;
  TevdNativeWriter(l_Gen).Filer:= l_Filer2;
  {$IFDEF OLDXMLREADER}
  TlcTextChecker.SetTo(l_Gen);
  TlcTextChecker(l_Gen).OnNonEmptyDocument:= NonEmptyDocument;
  f_Reader:= TLiteArbitralCourtReader.SetTo(l_Gen);
  TLiteArbitralCourtReader(l_Gen).OnEmptyDocument:= EmptyDocument;
  TLiteArbitralCourtReader(l_Gen).SourceFileName:= ExtractFilePath(Application.ExeName)+'lcSourceFile.dat';
  TLiteArbitralCourtReader(l_Gen).DictionaryFileName:= ExtractFilePath(Application.ExeName)+'id.txt';
  TLiteArbitralCourtReader(l_Gen).Filer:= l_Filer;
  TLiteArbitralCourtReader(l_Gen).FromGZ:= gFromGZ;
  TLiteArbitralCourtReader(l_Gen).SaveImage:= True;
  TLiteArbitralCourtReader(l_Gen).ImageFolder:= gDestinationFolder;
  {$ELSE}
  //Tdd_lcPageNumberEliminator.SetTo(l_Gen, k2_idTextPara);
  // преобразование атрибутов
  //Tdd_lcNameGenerator.SetTo(l_Gen{, catGeneral, ErrorReaction});
  //TlcBelongsGenerator.SetTo(l_Gen{, catGeneral, ErrorReaction});
  //TalcuSourceDocFilter.SetTo(l_Gen, k2_idDocument, Tl3LongintList(AsObject['lcSource']));
  //TalcuSourceDocFilter(l_Gen).OnError:= ErrorReaction;
  {
  Tdd_lcVASCodeCorrector.SetTo(l_Gen);
  Tdd_lcYearCodeCorrector.SetTo(l_Gen);
  Tdd_lcSourceConverterFilter.SetTo(l_Gen, GetAppFolderFileName('lcSourceFile.dat'));
  //Tdd_lcVASSourceCorrector.SetTo(l_Gen);
  }
  {$IFNDEF Debug}
  TlcTextChecker.SetTo(l_Gen);
  TlcTextChecker(l_Gen).OnNonEmptyDocument:= NonEmptyDocument;
  Tdd_lcHiddenTextExtractor.SetTo(l_Gen);
  TlclcParticipantsNormalizeFilter.SetTo(l_Gen);
  {$ENDIF}
  TevNestedDocumentEliminator.SetTo(l_Gen);
  l_ImgConverter := TlcDocImageConvertFilter.SetTo(l_Gen);
  l_ImgConverter.SaveImage := gSaveDocImages;
  l_ImgConverter.ImageDir := gDestinationFolder;
  {$IFNDEF Debug}
  TlcDocByTypeFilter.SetTo(l_Gen, GetAppFolderFileName('lcProperTypes.dat'));
  Tdd_lcTypeConverter2.SetTo(l_Gen);
  Tdd_lcTypeConverter2(l_Gen).LoadSources(GetAppFolderFileName('lcSourceConvertFile.dat'));
  Tdd_lcSourceConverterFilter.SetTo(l_Gen, GetAppFolderFileName('lcSourceFile.dat'));
  Tdd_lcTypeConverter.SetTo(l_Gen, GetAppFolderFileName('lcTypeSyno.dat'));
  {$ENDIF}
  l_XMLReader := TlcXMLStreamReader.SetTo(l_Gen, 'id.txt');
  l_XMLReader.Filer := l_Filer;
  {$ENDIF}
 end;


 function lp_WorkFile(const FileName: String): Boolean;
 var
  l_BadInputStream: Boolean;
  l_Stream: Tl3FileStream;
  l_GZStream: Tl3GZipStream;
  l_BufStream: Tl3BufferStream;
  l_FileName: String;
  l_GZFilename: string;
 begin
  try
   l3System.Msg2Log(FileName);
   l_GZFilename := ExtractFileName(FileName);
   labelFile.Caption:= l_GZFilename;

   {$IFDEF OLDXMLREADER}
   l_Filer.Filename := Filename;
   {$ELSE}
   l_Stream := Tl3FileStream.Create(FileName, l3_fmRead);
   try
    if gFromGZ then
    try
     try
      l_GZStream := nil;
      l_GZStream := Tl3GZipStream.Create(l_Stream, True);
      l3Set(l_Stream, l_GZStream);
     finally
      FreeAndNil(l_GZStream);
     end;
     //l_BufStream := Tl3BufferStream.Create(l_Stream);
     //l3Set(l_Stream, l_BufStream);
    except
     on E: Exception do
     begin
      l3System.Msg2Log(E.Message);
      FreeAndNil(l_Stream);
     end;
    end;
    l_BadInputStream := l_Stream = nil;
    l_Filer.Stream := l_Stream;
   finally
    FreeAndNil(l_Stream);
   end;
   l_ImgConverter.BaseImageName := ChangeFileExt(l_GZFilename, '');
   {$ENDIF}
   l_FileName:= ConcatDirName(gDestinationFolder, ChangeFileExt(l_GZFilename, '.evd'));
   l_Filer2.FileName:= l_FileName;
   f_EmptyDoc:= True;

   if not l_BadInputStream then
   try
    {$IFDEF OLDXMLREADER}
    TLiteArbitralCourtReader(l_Gen).Execute;
    {$ELSE}
    TlcXMLStreamReader(l_Gen).Execute;
    {$ENDIF OLDXMLREADER}
    if f_EmptyDoc then
     l3System.Msg2Log('нет подходящих документов');
   except
    on E: Exception do
    begin
     l3System.Msg2Log('ОШИБКА ПРИ ЧТЕНИИ!');
     f_EmptyDoc := True;
     l_Filer.Close;
     l_Filer2.Close;
     FreeAndNil(l_Gen);
     BuildPipe;
    end;
   end;
   {$IFNDEF Debug}
   if f_EmptyDoc then
   begin
    l_Filer.Close;
    CopyToBackup(FileName);
    l_Filer2.Close;
    DeleteFilesByMask(gDestinationFolder, ChangeFileExt(l_GZFilename, '')+'*.*');
   end
   else
    CopyToDone(FileName);
   {$ENDIF}
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    {$IFNDEF Debug}
    CopyToBackup(FileName);
    {$ENDIF}
   end;
  end;
  labelFile.Caption:= '';
  Result := not f_Abort;
 end; // lp_WorkFile

begin
 ForceDirectories(gDestinationFolder);
 f_DoneFiles.Clear;
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
   {$IFDEF OLDXMLREADER}
   l_Filer:= TevDOSFiler.Create;
   {$ELSE}
   l_Filer:= Tl3CustomFiler.Create;
   {$ENDIF}
   try
    l_Filer.Mode:= l3_fmRead;
     l_Filer2:= TevDOSFiler.Create;
     try
       l_Filer2.Mode:= l3_fmFullShareCreateReadWrite;
       l_Start:= Now;
       try
        BuildPipe;
        LabelFolder.Caption:= gSourceFolder;
        l_Prg:= TddProgressObject.Create(nil);
        try
         l_Prg.OnUpdate:= UpdateProgress;
         l_Prg.Start(l_Files.FileList.Count);
         l_Filer.Indicator.OnProgressProc:= l_Prg.ProcessUpdate;
         l_Filer.Indicator.NeedProgressProc:= True;
         l3System.Msg2Log('Начато преобразование %d файлов', [l_Files.FileList.Count]);
         f_Abort:= False;
         for i:= 0 to l_Files.FileList.Count-1 do
         begin
          if f_Abort then
           break;
          if l_Files.ValidFileName(l_Files.FileList[i]) then
           lp_WorkFile(l_Files.FileList[i])
          else
           CopyToBackup(l_Files.FileList[i]);
          l_Prg.ProcessUpdate(i);
         end; // for i
        finally
         l_Prg.Stop;
         l3System.Msg2Log('Преобразование закончено за '+ CalcElapsedTime(l_Start, Now));
         l3Free(l_Prg);
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
   ForceDirectories(gDoneFolder);
   ZipFiles(MakeUniqueFileName(ConcatDirName(gDoneFolder, ExtractFileName(gSourceFolder) + '.zip')), f_DoneFiles);
   DeleteFiles;
  end;
 finally
  l3Free(l_Files);
 end;
end;

procedure TConverterForm.CopyToBackup(const aFileName: String);
var
 l_FN: string;
begin
 l_FN := ConcatDirName(gBackupFolder, ExtractFileName(aFileName));
 try
  if not RenameFile(aFileName, l_FN) then
   CopyFile(aFileName, l_FN, cmDeleteSource);
 except
  on E: Exception do
   l3System.Msg2Log('Ошибка "%s" переноса файла %s', [e.Message, aFileName]);
 end;
end;

procedure TConverterForm.CopyToDone(const aFileName: String);
var
 l_FileName: String;
begin
 {$IFNDEF Debug}
 l_FileName:= ConcatDirName(gDoneFolder, ExtractFileName(aFileName));
 f_DoneFiles.Add(l_Filename);
 try
  if not RenameFile(aFileName, l_FileName) then
   CopyFile(aFileName, l_FileName, cmDeleteSource);
 except
  on E: Exception do
   l3System.Msg2Log('Ошибка "%s" переноса файла %s', [e.Message, aFileName]);
 end;
 {$ENDIF}
end;

procedure TConverterForm.NonEmptyDocument(Sender: TObject);
begin
 f_EmptyDoc:= False;
end;

procedure TConverterForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 f_Abort:= True;
 Action:= caHide;
end;

procedure TConverterForm.Idle(Sender: TObject; var Done: Boolean);
var
 l_Folders: TStrings;
 i: Integer;
begin
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
    ConvertFiles;
    PackSendLog;
   end; // for i
  finally
   FreeAndNil(l_Folders);
  end;
 end;
 Close;
end;

procedure TConverterForm.Initialize;
begin
 ResetSelfLog(5*1024*1024);
 gSourceFolder:= '';
 gDestinationFolder:= '';
 gBackupFolder:= '';
 gDoneFolder:= '';
 gWithSubDirs:= False;
 gSaveDocImages := False;
 gFromGZ:= True;
 gFolderList:= '';
 f_OldFormat:= False;
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

procedure TConverterForm.DeleteFiles;
var
 i: Integer;
begin
 for i:= 0 to Pred(f_DoneFiles.Count) do
  DeleteFile(f_DoneFiles[i]);
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
  if AnsiStartsText('/I', l_S) then
   gSaveDocImages:= True
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

function TConverterForm.PackSelfLog(const aPackedFileName: string; aClearLog: Boolean): Boolean;
{$IFDEF _m0LOGSAV1}
var
 l_LogFileName: String;
{$ENDIF}
begin
 {$IFDEF _m0LOGSAV1}
 Result:= False;
 l_LogFileName:= Gm0EXCLibDefSrv.LogFileName;
 FreeAndNil(Gm0EXCLibDefSrv);
 try
  if FileExists(l_LogFileName) then
  begin
   Result:= ZipFiles(aPackedFileName, ExtractFileDir(l_LogFileName), ExtractFileName(l_LogFileName));
   if aClearLog then
    SysUtils.DeleteFile(l_LogFileName);
  end;
 finally
  Gm0EXCLibDefSrv:= Tl3ExceptionsLog.Create(l_LogFileName);
 end;
 {$ENDIF}
end;

procedure TConverterForm.PackSendLog;
{$IFNDEF NOSENDLOG}
var
 l_ZipFileName: String;
 LSMTP: TIdSMTP;
 LMsg: TIdMessage;
 l_Text : TidText;
{$ENDIF}
begin
 {$IFNDEF NOSENDLOG}
 l_ZipFileName:= GetAppFolderFileName(ExtractFileName(gSourceFolder) + '.zip');
 if PackSelfLog(l_ZipFileName, True) then
 begin
  // Отправить письмо с логом
  LSMTP := TIdSMTP.Create(nil);
  try
    LMsg := TIdMessage.Create(LSMTP);
    try
      with LMsg do
      begin
        Encoding := meMIME;
        l_Text := TidText.Create(MessageParts);
        l_Text.CharSet := 'windows-1251';
        l_Text.ContentType := 'text/plain';
        l_Text.ContentTransfer := '8bit';
        l_Text.Body.Text:= 'Вложение содержит лог-файл преобразования постановлений из папки ' + gSourceFolder;
        Subject := 'Conversion ' + ExtractFileName(gSourceFolder) + ' done';
        Recipients.EMailAddresses := {'zhuchkov@garant.ru';// }'appel_info@garant.ru';
        From.Text := 'alcu@garant.ru';
        TidAttachmentFile.Create(MessageParts, l_ZipFileName);
      end;
      with LSMTP do
      begin
        Host := 'smtp.garant.ru';
        Connect;
        try;
          Send(LMsg);
        finally
         Disconnect;
        end;
      end;
    finally
     FreeAndNil(LMsg);
    end;
  finally
   FreeAndNil(LSMTP);
  end;
  DeleteFile(l_ZipFileName);
 end; // PackSelfLog(l_ZipFileName)
 {$ENDIF}
end;

function TConverterForm.pm_GetToday: string;
var
 l_Y, l_M, l_D: Word;
begin
 DecodeDate(Date, l_Y, l_M, l_D);
 Result := Format('%d-%.2d-%.2d', [l_Y, l_M, l_D]);
end;

procedure TConverterForm.UpdateProgress(Sender: TObject; aTotalPercent: Integer);
begin
 ProgressBar.Position:= aTotalPercent;
 ProgressLabel.Caption:= 'До окончания осталось: '+ TddProgressObject(Sender).TotalRemainingTimeAsString;
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

end.
