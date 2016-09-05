unit Dt_DocImages;

{ $Id: Dt_DocImages.pas,v 1.58 2016/07/29 11:25:14 fireton Exp $ }
// $Log: Dt_DocImages.pas,v $
// Revision 1.58  2016/07/29 11:25:14  fireton
// - более точная диагностика ошибок настроек
//
// Revision 1.57  2016/06/20 15:04:21  fireton
// - специализированная функция переноса файла образа из кэша в хранилище
//
// Revision 1.56  2016/06/17 13:00:03  fireton
// - мелкая правка
//
// Revision 1.55  2016/06/17 12:48:39  fireton
// - ускоряем перенос кэша
//
// Revision 1.54  2016/06/16 06:51:26  fireton
// - не удаляем файлы по маске (слишком долго!)
//
// Revision 1.53  2016/06/15 14:47:13  fireton
// - рапортуем имя файла при копировании из кэша
//
// Revision 1.52  2016/06/10 12:35:17  fireton
// - кеширование образов документов
//
// Revision 1.51  2016/06/09 15:14:58  fireton
// - кеширование образов документов
//
// Revision 1.50  2016/06/07 13:41:37  fireton
// - кеширование образов документов
//
// Revision 1.49  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.48  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.47  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.46  2015/05/20 11:51:05  fireton
// - расширенная диагностика времени добавления образа
//
// Revision 1.45  2015/03/04 12:08:12  lukyanets
// Наконец отправляем
//
// Revision 1.44  2014/11/13 11:42:12  fireton
// - увеличиваем детализацию лога MDP-синхронизатора
//
// Revision 1.43  2014/10/14 10:42:08  voba
// -bf еправильно проверялась доступность каталога
//
// Revision 1.42  2013/04/19 14:52:19  lulin
// - портируем.
//
// Revision 1.41  2012/11/30 08:36:51  narry
// Неверный путь к файлам образов документов (412167617)
//
// Revision 1.40  2012/11/01 09:42:41  lulin
// - забыл точку с запятой.
//
// Revision 1.39  2012/11/01 07:44:35  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.38  2012/09/26 10:26:43  fireton
// - создаём DocImageServer "on demand" (K 397280929)
//
// Revision 1.37  2012/08/15 07:23:46  fireton
// - добавляем отладочную информацию по образам в лог MDP-импорта
//
// Revision 1.36  2011/12/08 14:06:20  fireton
// - диагностика ошибок с файлом образа
//
// Revision 1.35  2011/11/15 12:10:13  fireton
// - bugfix: удалял файл ДО сравнения копии с образцом :)
//
// Revision 1.34  2011/10/28 13:24:08  fireton
// - более надёжный алгоритм перемещения файла
//
// Revision 1.33  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.32  2010/08/03 13:16:38  voba
// - k: 229672814
//
// Revision 1.31  2010/06/21 15:39:59  fireton
// - raise был пропущен
//
// Revision 1.30  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.29  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.28  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.27  2008/11/10 14:32:19  fireton
// - со значениями по умолчанию функция не работала
//
// Revision 1.26  2008/10/22 12:55:19  voba
// no message
//
// Revision 1.25  2008/10/15 09:06:57  fireton
// - рефакторинг кода, связанного с образами документов (выделение DocImageServer)
//
// Revision 1.24  2008/10/07 08:41:08  voba
// no message
//
// Revision 1.23  2008/10/03 10:31:36  fireton
// - образом документа теперь может быть не только TIFF
//
// Revision 1.22  2008/10/01 11:38:16  narry
// - пара заточек
//
// Revision 1.21  2008/08/11 08:49:20  voba
// - add overload function IsImageExists
//
// Revision 1.20  2008/04/03 07:56:02  voba
// - перетащил все из DocImgSup в dt_DocImages
//
// Revision 1.19  2008/01/31 14:56:16  fireton
// - TBigDictId -> TDictId
//
// Revision 1.18  2007/11/26 09:41:12  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.17  2007/09/10 08:34:51  fireton
// - избавляемся от жесткой привязки к ID источников опубликования
//
// Revision 1.16  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.15  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.14  2007/03/06 14:51:26  fireton
// - поиск и добавление записей периодичных источников опубликования
//
// Revision 1.13  2007/01/29 08:23:46  fireton
// - кеширование
//
// Revision 1.12  2006/12/13 13:48:52  fireton
// - добавляем записи о страницах
// - если "Получено по рассылке" уже есть, добавляется как "Получено по рассылке 2"
//
// Revision 1.11  2006/03/15 13:41:46  voba
// - enh. у существующих PublishedIn перезаписываются образы
//
// Revision 1.10  2005/11/03 14:08:28  step
// убран комментарий
//
// Revision 1.9  2005/11/03 12:10:35  step
// слил с веткой
//
// Revision 1.8.2.1  2005/11/03 09:32:20  step
// переделана TDocImages.ImageFullFileName
//
// Revision 1.8  2005/10/27 13:19:13  step
// добавлена возможность указывать источник опубликования
//
// Revision 1.7  2005/03/25 16:24:10  step
// TDocImages.Add может не только копировать, но и перемещать образ
//
// Revision 1.6  2005/03/24 11:51:38  step
// no message
//
// Revision 1.5  2005/03/24 11:29:47  step
// no message
//
// Revision 1.4  2005/03/24 11:27:24  step
// оптимизация
//
// Revision 1.3  2005/03/23 15:27:49  step
// подправляем пути извлеченные из инишника
//
// Revision 1.2  2005/03/21 13:29:57  step
// изменена c_ImageId
//
// Revision 1.1  2005/03/15 17:16:59  step
// занесено в CVS
//

{$I DtDefine.inc}

interface

uses SysUtils,
     HT_Const, 
     l3Base,
     l3Date,
     l3Types,

     Dt_Types,
     Dt_Const,
     dt_AttrSchema,

     Dt_aTbl,
     Dt_Dict,
     Dt_DictTypes;

type
 EDocImageError = class(Exception);

 TImgFileType   = (iftAutoDetect, iftTIFF, iftContainer);
 TImgSourceType = (istAutoDetect, istStorage, istCache, istNoSource);

 TDocImageServer = class(Tl3Base)
 private
  f_ImageStoragePath: AnsiString;
  f_ImageCachePath: AnsiString;
  f_LastSource: TPublishedUniqueKeyRec;
  f_LastSourceId : LongWord;
  f_MemorizedIgnoreDuplicated: Boolean;
  function GetPublishDataRec(aDocId: TDocId; aDocSourceId: TDictId; var theRec: TPublishDataRec): Boolean;
  function ImagesFolder(aDocId: TDocId): AnsiString;
 protected
  function ExistsFor(aDocId: TDocId; aSourceId: TDictId): Boolean;
 public
  constructor Create(const aImageStoragePath, aImageCachePath: AnsiString);
  procedure Add(aDocId: TDocId;
                const aImageFile: AnsiString;
                aSourceIds : array of TDictId; // DT#B.ID, если = c_GotByMail, и DT#A.ID=DT#B.Source в противном случае
                aPages     : AnsiString;
                aIssueNum  : AnsiString  = '';
                aStartDate : TStDate = 0;
                aEndDate   : TStDate = 0;
                aAsCopy: Boolean = True;
                aByMail: Boolean = False); overload;
  procedure AddImageFile(const aImageFile: AnsiString;
                         aSrcID : TDictID;
                         aSDate, aEDate : TStDate;
                         const aNumber : AnsiString;
                         aNonPeriodic : Boolean;
                         aDocID : TDocID = -1;
                         aAsCopy: Boolean = True); overload;
  procedure AddImageFile(const aImageFile: AnsiString; const aPubRec: PPublishDataRec; aAsCopy: Boolean = True); overload;
  function CommitImageCache(const aProgressProc: Tl3ProgressProc = nil): Boolean;
  procedure DeleteImages(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString; aNonPeriodic : Boolean);
  function GetImageFileName(aDocId: TDocId; aDocSourceId: TDictId; aImageFileType: TImgFileType = iftAutoDetect;
   aImgSource: TImgSourceType = istAutoDetect): AnsiString; overload;
  function GetImageFileName(const aRec : PPublishDataRec; aImageFileType: TImgFileType = iftAutoDetect; aImgSource:
   TImgSourceType = istAutoDetect): AnsiString; overload;
  function GetImageFileName(aSrcID : TDictID;
                           aSDate, aEDate : TStDate;
                           const aNumber : AnsiString;
                           aNonPeriodic : Boolean;
                           aDocID : TDocID = -1;
                           aImageFileType: TImgFileType = iftAutoDetect;
                           aImgSource: TImgSourceType = istAutoDetect): AnsiString; overload;
  procedure StartBatch;
  procedure StopBatch;
  function IsImageExists(const aRec : PPublishDataRec) : boolean; overload;
  function IsImageExists(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString; aNonPeriodic : Boolean; aDocID : TDocID = -1): boolean; overload;
  property ImageStoragePath: AnsiString read f_ImageStoragePath;
  property ImageCachePath: AnsiString read f_ImageCachePath;
 end;

function IsTIFF(aFileName: AnsiString): Boolean;


procedure SetDocImagePath(const aPath, aCachePath: AnsiString);
function DocImageServer: TDocImageServer;

implementation

uses
 l3FileUtils,
 l3IniFile,
 l3String,
 l3Except,

 daTypes,
 daSchemeConsts,

 HT_DLL,
 Dt_Table, dt_Record,

 Dt_LinkServ,
 Dt_Err,
 dt_ImgContainer,

 DateUtils, dt_DictConst,

 ddFileIterator,
 ddUtils, vtDebug;

const
 cImageContainerExt = '.aic';   // Archi Image Container
 cTIFFImageExt      = '.tif';

const
 gDocImageServer: TDocImageServer = nil;
 gDocImagePath     : AnsiString = '';
 gDocImageCachePath: AnsiString = '';

{ TDocImages }

procedure SetDocImagePath(const aPath, aCachePath: AnsiString);
var
 l_Changed: Boolean;
 l_NewCachePath: AnsiString;
begin
 l_Changed := False;
 if gDocImagePath <> aPath then
 begin
  gDocImagePath := aPath;
  l_Changed := True;
 end;
 if UpperCase(ExcludeTrailingPathDelimiter(aCachePath)) = UpperCase(ExcludeTrailingPathDelimiter(aPath)) then
  l_NewCachePath := ''
 else
  l_NewCachePath := aCachePath;
 if gDocImageCachePath <> l_NewCachePath then
 begin
  gDocImageCachePath := l_NewCachePath;
  l_Changed := True;
 end;
 if l_Changed then
 begin
  FreeAndNil(gDocImageServer);
 end;
end;

function DocImageServer: TDocImageServer;
var
 l_CachePathDefined: Boolean;
 l_CachePathValid: Boolean;
 l_ImagePathValid: Boolean;
begin
 if gDocImageServer = nil then
 begin
  l_ImagePathValid := SysUtils.DirectoryExists(gDocImagePath);
  l_CachePathDefined   := (gDocImageCachePath <> '');
  if l_CachePathDefined then
   l_CachePathValid := SysUtils.DirectoryExists(gDocImageCachePath)
  else
   l_CachePathValid := False;
  if not l_ImagePathValid then
   l3System.Msg2Log('ОШИБКА: Неверный путь к файлам образов документов ("%s")!. Обратитесь к администратору', [gDocImagePath]);
  if l_CachePathDefined and not l_CachePathValid then
   l3System.Msg2Log('ОШИБКА: Неверный путь к кэшу образов документов ("%s")!. Обратитесь к администратору', [gDocImageCachePath]);
  if ((not l_ImagePathValid) and (not l_CachePathDefined)) or (l_CachePathDefined and (not l_CachePathValid)) then
   raise El3Error.Create('Работа с образами невозможна! Неправильные настройки!');
  gDocImageServer := TDocImageServer.Create(gDocImagePath, gDocImageCachePath);
 end;
 Result := gDocImageServer;
end;

procedure TDocImageServer.Add(aDocId: TDocId;
                         const aImageFile: AnsiString;
                         aSourceIds : array of TDictId;
                         aPages     : AnsiString;
                         aIssueNum  : AnsiString = '';
                         aStartDate : TStDate = 0;
                         aEndDate   : TStDate = 0;
                         aAsCopy    : Boolean = True;
                         aByMail    : Boolean = False);
var
 l_LinkRec: TPublishLinkRec;
 l_AlreadyExists: Boolean;
 l_FileSize: Int64;
 l_PubRecNum: Longint;
 l_PubRec   : TPublishedDictRec;
 l_PubKey   : TPublishedUniqueKeyRec;
 l_PubDataRec: TPublishDataRec;
 l_Elapsed: Double;
 l_Str: AnsiString;
 l_Time: Int64;

 procedure RetrieveSourceIdFromDB;
 var
  l_SourceId: TDictID;
 begin
  l_PubRecNum := DictServer(CurrentFamily).DictTbl[da_dlPublisheds].GetRecordIDByUniq(piUniqKeyNum, l_PubKey);
  if l_PubRecNum > 0 then
  begin
   with DictServer(CurrentFamily).DictTbl[da_dlPublisheds] do
   begin
    GetFullRec(l_PubRecNum, False);
    GetFromFullRec(piIDFld, l_SourceId);
    aSourceIDs[0] := l_SourceId;
   end;
  end
  else
  begin
   // не найдено такой записи, надо создать...
   l3FillChar(l_PubRec, SizeOf(l_PubRec), 0);
   with l_PubRec do
   begin
    ID := cUndefDictID;
    Sour := aSourceIds[0];
    SDate := aStartDate;
    EDate := aEndDate;
    l3StringToArray(Num, SizeOf(Num), aIssueNum);
   end;
   DictServer(CurrentFamily).Tbl[da_dlPublisheds].AddData(l_PubRec.ID, @l_PubRec.Sour);
   aSourceIDs[0] := l_PubRec.ID;
  end;
 end;

begin
 // если не "получено по рассылке", то надо найти правильный номер выпуска,
 // а если его нет, то создать
 if not aByMail then
 begin
  with l_PubKey do
  begin
   Sour := aSourceIds[0];
   SDate := aStartDate;
   EDate := aEndDate;
   l3StringToArray(Num, SizeOf(Num), aIssueNum);
  end;
  if not CompareMem(@f_LastSource, @l_PubKey, SizeOf(TPublishedUniqueKeyRec)) then
  begin
   RetrieveSourceIdFromDB;
   f_LastSource := l_PubKey;
   f_LastSourceId := aSourceIds[0];
  end
  else
   aSourceIds[0] := f_LastSourceId;
 end;

 l_AlreadyExists := ExistsFor(aDocId, aSourceIds[0]);
 if aByMail and l_AlreadyExists and (Length(aSourceIds) > 1) and (aSourceIds[1] <> 0) then
 begin
  aSourceIds[0] := aSourceIds[1];
  l_AlreadyExists := ExistsFor(aDocId, aSourceIds[0]);
 end;

 if not l_AlreadyExists then
 begin
  l3FillChar(l_LinkRec, SizeOf(l_LinkRec), 0);
  l_LinkRec.Doc_ID := aDocId;
  l_LinkRec.Dict_ID := aSourceIds[0];
  l3StringToArray(l_LinkRec.Pages, SizeOf(l_LinkRec.Pages), aPages);
  LinkServer(CurrentFamily).Links[da_dlPublisheds].AddNodeEx(@l_LinkRec);
 end;

 if aImageFile = '' then // копировать файл никто не просит, надо было просто добавить запись
  Exit;

 if GetPublishDataRec(aDocId, aSourceIds[0], l_PubDataRec) then
 begin
  l_FileSize := GetFileSize(aImageFile);
  l_Str := Bytes2Str(l_FileSize);
  l3System.Msg2Log('Запись файла образа документа (%s)', [l_Str], 1);
  l_Time := dbgStartTimeCounter;
  AddImageFile(aImageFile, @l_PubDataRec, aAsCopy);
  l_Time := dbgGetElapsed(l_Time);
  l_Elapsed :=  l_Time / 1000; // прошедшее время в секундах
  if l_Elapsed > 0 then
   l_Str := Bytes2Str(Trunc(l_FileSize / l_Elapsed))
  else
   l_Str := 'бесконечность';
  l3System.Msg2Log('Образ записан со скоростью %s/сек', [l_Str], 1);
 end
 else
  l3System.Msg2Log(Format('Запись об опубликовании не найдена, файл образа не записан! DocID = %d, SourceID = %d',
     [aDocId, aSourceIds[0]]), 1);

end;

constructor TDocImageServer.Create(const aImageStoragePath, aImageCachePath: AnsiString);
begin
 inherited Create;
 f_ImageStoragePath := NormalizedPath(aImageStoragePath);
 f_ImageCachePath := NormalizedPath(aImageCachePath);

 {if not DirectoryExists(f_ImageStoragePath) then
  raise EDocImage.Create(SysUtils.Format('Задан неверный ImageStoragePath: %s',
                                         [f_ImageStoragePath]));
 }
 
 l3FillChar(f_LastSource, SizeOf(f_LastSource), 0);
 f_LastSourceId := 0;
end;

procedure TDocImageServer.AddImageFile(const aImageFile: AnsiString;
                                       aSrcID : TDictID;
                                       aSDate, aEDate : TStDate;
                                       const aNumber : AnsiString;
                                       aNonPeriodic: Boolean;
                                       aDocID : TDocID = -1;
                                       aAsCopy: Boolean = True);
var
 l_FullFileName: AnsiString;
 l_AtlImgFN: AnsiString;
 l_ImgContainer: TdtImgContainerFile;

 procedure GenerateImgFileName(aImageType: TImgFileType);
 var
  l_Src: TImgSourceType;
 begin
  if f_ImageCachePath <> '' then
   l_Src := istCache
  else
   l_Src := istStorage;
  l_FullFileName := GetImageFileName(aSrcID, aSDate, aEDate, aNumber, aNonPeriodic, aDocID, aImageType, l_Src);
  if l_FullFileName = '' then
   raise EDocImageError.CreateFmt('Не удалось вычислить местоположение образа (документ Id=%d, источник Id=%d).',
                                         [aDocID, aSrcID]);
  MakeDir(ExtractFilePath(l_FullFileName));
 end;

begin
 if (not FileExists(aImageFile)) then
  raise EDocImageError.CreateFmt('Исходный файл образа не найден: %s', [aImageFile]);
 if GetFileSize(aImageFile) = 0 then
  raise EDocImageError.CreateFmt('Исходный файл образа пуст: %s', [aImageFile]);
 if IsTIFF(aImageFile) then // если это TIF, то тупо копируем его
 begin
  GenerateImgFileName(iftTIFF);
  if aAsCopy then
  begin
   CopyFile(aImageFile, l_FullFileName, cmWriteOver+cmNoBakCopy);
   if GetFileSize(aImageFile) <> GetFileSize(l_FullFileName) then
    raise EInOutError.CreateFmt('Ошибка копирования файла %s', [ExtractFileName(aImageFile)]);
  end
  else
   if not RenameFile(aImageFile, l_FullFileName) then
   begin
    CopyFile(aImageFile, l_FullFileName, cmWriteOver+cmNoBakCopy);
    if GetFileSize(aImageFile) <> GetFileSize(l_FullFileName) then
     raise EInOutError.CreateFmt('Ошибка перемещения файла %s', [aImageFile]);
    DeleteFile(aImageFile);
   end;

  // Если уже был образ-контейнер, то его надо грохнуть
  l_AtlImgFN := ChangeFileExt(l_FullFileName, cImageContainerExt);
  if FileExists(l_AtlImgFN) then
   DeleteFile(l_AtlImgFN);
 end
 else
 begin
  GenerateImgFileName(iftContainer);
  l_ImgContainer := TdtImgContainerFile.Create(l_FullFileName);
  try
   l_ImgContainer.WrapFile(aImageFile);
  finally
   l3Free(l_ImgContainer);
  end;

  if not aAsCopy then
   DeleteFile(aImageFile);

  // Если уже был образ с расширением .tif, то его надо грохнуть
  l_AtlImgFN := ChangeFileExt(l_FullFileName, cTIFFImageExt);
  if FileExists(l_AtlImgFN) then
   DeleteFile(l_AtlImgFN);
 end;

 {$IFDEF ReportImageName}
 l3System.Msg2Log('Файл образа: %s', [l_FullFileName]);
 if not FileExists(l_FullFileName) then
  l3System.Msg2Log('ОШИБКА: Файл не был создан на сервере образов!');
 {$ENDIF}
end;

procedure TDocImageServer.AddImageFile(const aImageFile: AnsiString; const aPubRec: PPublishDataRec; aAsCopy: Boolean = True);
begin
 with aPubRec^ do
   AddImageFile(aImageFile, SourID, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), (IsNonperiodic = 1), DocId, aAsCopy);
end;

function TDocImageServer.CommitImageCache(const aProgressProc: Tl3ProgressProc = nil): Boolean;
var
 l_FI: TddFileIterator;
 l_IterFunc: TddIterateProc;
 l_Success : Boolean;
 l_Time: Int64;
 l_Elapsed: Double;
 l_Str: AnsiString;
 l_Num: Integer;

 // это специальная функция копирования, без временных файлов и переименований
 // нацелена на максимальную скорость работы в условиях директорий с большим количеством файлов
 procedure MoveImageFile(const aFromFN, aToFN: AnsiString);
 const
  cBufSize = 1024 * 256; // 256 килобайт
 var
  l_Buf: Pointer;
  l_FileAge, l_FileAttr: Longint;
  l_HFrom, l_HTo: Integer;
  l_FileSize, l_TotalWritten: Int64;
  l_NumRead, l_NumWritten: Integer;
  l_ErrStr: AnsiString;
 begin
  l3System.GetLocalMem(l_Buf, cBufSize);
  try
   l_FileAttr := FileGetAttr(aFromFN);
   l_HFrom := FileOpen(aFromFN, fmShareDenyWrite);
   if l_HFrom < 0 then
    raise EInOutError.CreateFmt('Не могу открыть для чтения файл %s', [aFromFN]);
   try
    l_FileAge := FileGetDate(l_HFrom);
    MakeDir(ExtractFilePath(aToFN));
    l_HTo := FileCreate(aToFN);
    if l_HTo < 0 then
     raise EInOutError.CreateFmt('Не могу открыть для записи файл %s', [aToFN]);
    try
     l_FileSize := GetFileSize(aFromFN);
     l_TotalWritten := 0;
     repeat
      l_NumRead := FileRead(l_HFrom, l_Buf^, cBufSize);
      if l_NumRead < 0 then
      begin
       l_ErrStr := SysErrorMessage(GetLastError);
       raise EInOutError.CreateFmt('Ошибка чтения файла %s (%s)', [aFromFN, l_ErrStr]);
      end;
      l_NumWritten := FileWrite(l_HTo, l_Buf^, l_NumRead);
      if l_NumWritten < 0 then
      begin
       l_ErrStr := SysErrorMessage(GetLastError);
       raise EInOutError.CreateFmt('Ошибка записи файла %s (%s)', [aToFN, l_ErrStr]);
      end;
      Inc(l_TotalWritten, l_NumWritten);
     until (l_NumRead = 0) or (l_NumWritten < l_NumRead);
     FileSetDate(l_HTo, l_FileAge);
    finally
     FileClose(l_HTo);
    end;
    if l_TotalWritten <> l_FileSize then
    begin
     DeleteFile(aToFN);
     raise EInOutError.CreateFmt('Ошибка копирования, не совпадает размер файлов %s (%d) и %s (%d). Копия удалена.',
        [aFromFN, l_FileSize, aToFN, l_TotalWritten]);
    end;
    FileSetAttr(aToFN, l_FileAttr);
   finally
    FileClose(l_HFrom);
   end;
   DeleteFile(aFromFN);
  finally
   l3System.FreeLocalMem(l_Buf);
  end;
 end;

 function MoveOne(const aFileName: AnsiString): Boolean;
 var
  l_DestFN: AnsiString;
  l_LocalFN: AnsiString;
  l_FS : Int64;
 begin
  Result := True;
  try
   Inc(l_Num);
   l_LocalFN := ExtractRelativePath(IncludeTrailingBackslash(f_ImageCachePath), aFileName);
   l_FS := GetFileSize(aFileName);
   l3System.Msg2Log('  [%d из %d] %s (%s)', [l_Num, l_FI.Count, l_LocalFN, Bytes2Str(l_FS)]);
   l_DestFN := ConcatDirName(f_ImageStoragePath, l_LocalFN);
   DeleteFile(ChangeFileExt(l_DestFN, cTIFFImageExt)); // чтобы удалить те образы, которые уже есть в хранилище
   DeleteFile(ChangeFileExt(l_DestFN, cImageContainerExt)); // удалять по маске - НЕЛЬЗЯ! (слишком долго, если много файлов, ибо поиск)
   //CopyFileEx(aFileName, l_DestFN, nil, cmWriteOver + cmNoBakCopy + cmDeleteSource, True);
   MoveImageFile(aFileName, l_DestFN);
  except
   on E: Exception do
   begin
    l3System.Msg2Log('Ошибка копирования файла %s (%s)', [aFileName, E.Message]);
    l_Success := False;
    Result := False;
   end;
  end;
 end;
begin
 // переливаем содержимое кэша в основное хранилище
 l_FI := TddFileIterator.Make(f_ImageCachePath, '*.*', aProgressProc, True);
 try
  if l_FI.Count > 0 then
  begin
   l3System.Msg2Log('Найдено: %s общим объёмом %s. Начало копирования.',
    [NumSuffix(l_FI.Count, 'документ', 'документа', 'документов'),
    Bytes2Str(l_FI.TotalSize)]);
   l_IterFunc := L2IterateFilesProc(@MoveOne);
   try
    l_Success := True;
    l_Num := 0;
    l_Time := dbgStartTimeCounter;
    l_FI.IterateFiles(l_IterFunc);
    if l_Success then
    begin
     l_Time := dbgGetElapsed(l_Time);
     l_Elapsed :=  l_Time / 1000; // прошедшее время в секундах
     if l_Elapsed > 0 then
      l_Str := Bytes2Str(Trunc(l_FI.TotalSize / l_Elapsed))  
     else
      l_Str := 'бесконечность';
     l3System.Msg2Log('Обработка завершена за %s, файлы скопированы со скоростью %s/сек.', [TimeSec2Str(Trunc(l_Elapsed)), l_Str]);
     PureDir(f_ImageCachePath);
    end;
    Result := l_Success;
   finally
    FreeIterateFilesProc(l_IterFunc);
   end;
  end
  else
  begin
   l3System.Msg2Log('Кэш образов пуст, обработка не требуется.');
   Result := True;
  end;
 finally
  FreeAndNil(l_FI);
 end;
end;

procedure TDocImageServer.DeleteImages(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString;
 aNonPeriodic : Boolean);
var
 l_Mask: AnsiString;
begin
 l_Mask := ChangeFileExt(GetImageFileName(aSrcID, aSDate, aEDate, aNumber, aNonPeriodic, -1, iftTIFF, istNoSource), '.*');
 DeleteFilesByMask(f_ImageCachePath, l_Mask);
 DeleteFilesByMask(f_ImageStoragePath, l_Mask);
end;

function TDocImageServer.ExistsFor(aDocId: TDocId; aSourceId: TDictId): Boolean;
type
 TLinkRec = packed record
  rDocId  : TDocID;
  rDictId : TDictID;
 end;
var
 lPack : TLinkRec;
begin
 with lPack do
 begin
  rDocId  := aDocId;
  rDictId := aSourceId;
 end;

 Result := LinkServer(CurrentFamily)[atPublisheds].Table.HasUniqRec(lPack);

 //Result := LinkServer.LinkExists(da_dlPublisheds, aDocId, aSourceId);
{
 // проверка на наличие соответствующего файла
 if Result then
  if not FileExists(ImageFullFileName(aDocId)) then
   raise EDocImage.Create(SysUtils.Format('Не найден образ документа %d', [aDocId]));
}
end;

function TDocImageServer.GetImageFileName(aDocId: TDocId; aDocSourceId: TDictId; aImageFileType: TImgFileType =
    iftAutoDetect; aImgSource: TImgSourceType = istAutoDetect): AnsiString;
var
 l_PublishDataRec: TPublishDataRec;
begin
 Result := '';
 if GetPublishDataRec(aDocId, aDocSourceId, l_PublishDataRec) then
  Result := GetImageFileName(@l_PublishDataRec, aImageFileType, aImgSource);
end;

function TDocImageServer.GetImageFileName(const aRec : PPublishDataRec; aImageFileType: TImgFileType = iftAutoDetect;
                                          aImgSource: TImgSourceType = istAutoDetect):AnsiString;
begin
 with aRec^ do
  Result := GetImageFileName(SourID, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), (IsNonperiodic = 1), DocId, aImageFileType, aImgSource)
end;

function TDocImageServer.ImagesFolder(aDocId: TDocId): AnsiString;
begin
 // параметр aDocId может понадобиться в будущем при определении папки
 Result := f_ImageStoragePath;
end;

procedure TDocImageServer.StartBatch;
begin
 f_MemorizedIgnoreDuplicated := LinkServer(CurrentFamily)[atPublisheds].Table.IgnoreDuplicates;
 LinkServer(CurrentFamily)[atPublisheds].Table.IgnoreDuplicates := True;
 LinkServer(CurrentFamily)[atPublisheds].Table.StartCaching;
end;

procedure TDocImageServer.StopBatch;
begin
 LinkServer(CurrentFamily)[atPublisheds].Table.StopCaching;
 LinkServer(CurrentFamily)[atPublisheds].Table.IgnoreDuplicates := f_MemorizedIgnoreDuplicated;
end;

function TDocImageServer.GetImageFileName(aSrcID : TDictID;
                          aSDate, aEDate : TStDate;
                          const aNumber : AnsiString;
                          aNonPeriodic : Boolean;
                          aDocID : TDocID = -1;
                          aImageFileType: TImgFileType = iftAutoDetect;
                          aImgSource: TImgSourceType = istAutoDetect): AnsiString;
var
 D1, M1, Y1,
 D2, M2, Y2 : Integer;
 l_TempName: AnsiString;
 l_TempNameCache: AnsiString;
 l_TempNameStorage: AnsiString;

 function GetDocIDStr : AnsiString;
 begin
  if aDocID >=0 then
   Result := Format('%d', [aDocID])
  else
   Result := '*';
 end;

begin
 Result := '';
 if aSrcID = 0 then
  Result := Format('@\[#%s]',[GetDocIDStr])
 else
  if aNonperiodic then
   Result := Format('%d\[%d] [#%s]',[aSrcID, aSrcID, GetDocIDStr])
  else
  begin
   Result := Format('%d\[%d]',[aSrcID, aSrcID]);

   if aSDate <> BlankDate then
   begin
    StDateToDMY(aSDate, D1, M1, Y1);
    If aSDate = aEDate then
     Result:= Result + Format(' %d_%d_%d', [D1, M1, Y1])
    else
    begin
     StDateToDMY(aEDate, D2, M2, Y2);
     if (Y1 = Y2) and (M1 = M2) and (D1 = 1) and (D2 = DaysInAMonth(Y1, M1)) then
      Result:= Result + Format(' %d_%d', [M1, Y1])
     else
      if (Y1 = Y2) and (M1 = 1) and (M2 = 12) and (D1 = 1) and (D2 = 31) then
       Result := Result + Format(' %d', [Y1])
      else
       Result := Result + Format(' %d_%d_%d-%d_%d_%d', [D1, M1, Y1, D2, M2, Y2]);
    end;
   end;
  end; //IsNonperiodic > 0

 if Length(aNumber) > 0 then Result := Result + Format(' #%S', [aNumber]);


 l_TempNameCache   := ConcatDirName(f_ImageCachePath, Result);
 l_TempNameStorage := ConcatDirName(f_ImageStoragePath, Result);

 case aImgSource of
  istAutoDetect, istCache : l_TempName := l_TempNameCache;
  istStorage              : l_TempName := l_TempNameStorage;
  istNoSource             : l_TempName := Result; // для внутреннего употребления
 end;

 while True do
 begin
  case aImageFileType of
   iftAutoDetect:
    begin
     Assert(aImgSource <> istNoSource);
     Result := l_TempName + cTIFFImageExt;
     if not FileExists(Result) then
      Result := ChangeFileExt(Result, cImageContainerExt);
    end;
   iftTIFF     : Result := l_TempName + cTIFFImageExt;
   iftContainer: Result := l_TempName + cImageContainerExt;
  end;
  if (not FileExists(Result)) and (aImgSource = istAutoDetect) and (l_TempName = l_TempNameCache) then
   l_TempName := l_TempNameStorage
  else
   Break;
 end; // while
end;

function TDocImageServer.GetPublishDataRec(aDocId: TDocId; aDocSourceId: TDictId; var theRec: TPublishDataRec): Boolean;
var
 lRec : TdtRecord;
begin
 Result := False;

 lRec := DictServer(CurrentFamily).Tbl[da_dlPublisheds].GetRecordByUniq(aDocSourceId);
 if not lRec.WasFound then Exit;
 l3FillChar(theRec, SizeOf(theRec), 0);
 lRec.GetTo(@theRec);

 theRec.DocId := aDocId;

 lRec := DictServer(CurrentFamily).Tbl[da_dlCorSources].GetRecordByUniq(theRec.SourId);
 if not lRec.WasFound then Exit;

 lRec.GetCharArrayField(dtShNameFld, theRec.ShName);
 lRec.GetField(dtIsPrivate, theRec.IsPrivate);
 lRec.GetField(dtIsNonperiodic, theRec.IsNonperiodic);

 Result := True;
end;

function TDocImageServer.IsImageExists(const aRec : PPublishDataRec): boolean;
begin
 with aRec^ do
  Result := IsImageExists(SourID, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), (IsNonperiodic = 1), DocId);
end;

function TDocImageServer.IsImageExists(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString; aNonPeriodic : Boolean; aDocID : TDocID = -1): boolean;
var
 l_FN: AnsiString;
begin
 l_FN := GetImageFileName(aSrcID, aSDate, aEDate, aNumber, aNonPeriodic, aDocID);
 Result := FileExists(l_FN);
end;


function IsTIFF(aFileName: AnsiString): Boolean;
var
 l_Ext: AnsiString;
begin
 l_Ext := Lowercase(ExtractFileExt(aFileName));
 Result := (l_Ext = '.tif') or (l_Ext = '.tiff');
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\Dt_DocImages.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\Dt_DocImages.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(gDocImageServer);
end.
