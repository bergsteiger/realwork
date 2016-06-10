unit m3StgMgr;
{* Классы-менеджеры для работы с IStorage. }

// $Id: m3stgmgr.pas,v 1.60 2016/04/20 14:57:20 lulin Exp $

// $Log: m3stgmgr.pas,v $
// Revision 1.60  2016/04/20 14:57:20  lulin
// - делаем так, чтобы тест индексации мог работать по нескольку раз и без предварительных пасов руками.
//
// Revision 1.59  2016/04/20 14:24:08  lulin
// - делаем так, чтобы тест индексации мог работать по нескольку раз и без предварительных пасов руками.
//
// Revision 1.58  2016/04/13 11:27:49  lulin
// - улучшаем диагностику - выводим имя файла.
//
// Revision 1.57  2015/05/14 11:40:17  lulin
// {RequestLink:588034502}. Оптимизируем очистку кеша.
//
// Revision 1.56  2015/05/13 10:59:48  lulin
// - чистим код.
//
// Revision 1.55  2015/05/12 11:05:35  lulin
// {RequestLink:588034502}.
//
// Revision 1.54  2015/05/12 10:15:10  lulin
// {RequestLink:588034502}.
//
// Revision 1.53  2014/12/08 13:07:44  lulin
// - рисуем на модели.
//
// Revision 1.52  2014/12/05 13:23:08  lulin
// - рисуем на модели.
//
// Revision 1.51  2014/12/05 12:34:00  lulin
// - рисуем на модели.
//
// Revision 1.50  2014/10/16 13:06:04  lulin
// - перетряхиваем зависимости между классами.
//
// Revision 1.49  2014/10/16 09:02:51  lulin
// - очередной раз удаляем "совсем старое хранилище".
//
// Revision 1.48  2014/10/03 13:42:00  lulin
// - кешируем менеджеры блоков.
//
// Revision 1.47  2014/10/03 11:16:43  lulin
// - готовимся к кешированию хранилищ, а точнее - менеджеров блоков и связанных с ними потоков.
//
// Revision 1.46  2014/10/03 10:10:23  lulin
// - готовимся к кешированию хранилищ, а точнее - менеджеров блоков и связанных с ними потоков.
//
// Revision 1.45  2014/10/03 09:44:33  lulin
// - готовимся к кешированию хранилищ, а точнее - менеджеров блоков и связанных с ними потоков.
//
// Revision 1.44  2014/09/19 15:13:35  lulin
// - оптимизируем.
//
// Revision 1.42  2014/09/18 14:49:42  lulin
// - при копировании в бекап создаем новое хранилище.
//
// Revision 1.41  2014/09/16 16:30:27  lulin
// - бекап пытаемся писать в новом формате.
//
// Revision 1.40  2014/09/16 11:17:37  lulin
// - возвращаем нарезку.
//
// Revision 1.39  2014/09/16 10:43:22  lulin
// - возвращаем старую реализацию хранилища.
//
// Revision 1.38  2014/09/16 07:39:36  lulin
// - чистим код.
//
// Revision 1.37  2014/09/12 09:56:22  lulin
// - информационный поток открываем в том же режиме, что и все остальные.
//
// Revision 1.36  2014/09/11 15:45:24  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.35  2014/09/11 13:44:20  lulin
// - готовимся к открытию постоянной части в режине на чтение без залочек.
//
// Revision 1.34  2014/09/11 11:28:19  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.33  2014/09/10 16:40:13  lulin
// - продолжаем рефакторинг внутреннего устройства хранилища.
//
// Revision 1.32  2014/09/10 16:17:35  lulin
// - чистим код.
//
// Revision 1.31  2014/09/10 16:02:08  lulin
// - где возможно, там используем эксклюзивный доступ.
//
// Revision 1.30  2014/09/10 15:29:46  lulin
// - готовимся к эксклюзивной работе с хранилищами.
//
// Revision 1.29  2014/09/04 15:00:07  lulin
// - выделяем новый тип блоков - "без мусора".
//
// Revision 1.28  2014/08/29 12:15:51  lulin
// - заменяем условную директиву на переменную.
//
// Revision 1.27  2014/08/29 11:32:05  lulin
// - даём методу более вменяемое название.
//
// Revision 1.26  2014/08/29 11:22:08  lulin
// - заменяем условную директиву на переменную.
//
// Revision 1.25  2014/08/25 15:44:34  lulin
// - вставляем диагностику заголовка потока.
//
// Revision 1.23  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.22  2012/05/29 10:01:11  voba
// no message
//
// Revision 1.21  2012/05/29 09:44:12  lulin
// {RequestLink:367210517}
//
// Revision 1.20  2012/05/29 09:38:47  lulin
// {RequestLink:367210517}
//
// Revision 1.19  2012/05/25 14:17:21  lulin
// - делаем "кошерную" операцию проверки существования файла.
//
// Revision 1.17  2012/05/24 09:03:56  voba
// - bug fix
//
// Revision 1.16  2012/05/22 13:29:42  lulin
// {RequestLink:365838449}
//
// Revision 1.15  2012/05/22 11:59:11  lulin
// {RequestLink:365838449}
//
// Revision 1.14  2012/05/05 14:06:24  lulin
// {RequestLink:361038156}
//
// Revision 1.13  2012/05/05 12:11:45  lulin
// {RequestLink:361038156}
//
// Revision 1.12  2012/05/05 11:37:29  lulin
// {RequestLink:361038156}
//
// Revision 1.11  2012/05/05 11:20:48  lulin
// {RequestLink:361038156}
//
// Revision 1.10  2012/05/04 19:44:39  lulin
// {RequestLink:361038156}
//
// Revision 1.8  2012/05/04 10:04:36  lulin
// {RequestLink:361038156}
//
// Revision 1.7  2012/05/04 08:31:15  lulin
// {RequestLink:361038156}
//
// Revision 1.6  2011/12/28 09:29:10  lulin
// {RequestLink:325257155}
// - чистим код.
//
// Revision 1.5  2009/03/12 19:08:25  lulin
// - <K>: 138969458. Чистка устаревшего кода.
//
// Revision 1.4  2009/03/12 12:28:45  lulin
// - <K>: 138969458. Удаляем ненужные файлы, методы и классы.
//
// Revision 1.3  2009/03/12 12:08:19  lulin
// - <K>: 138969458. Удаляем ненужные методы и классы.
//
// Revision 1.2  2006/02/02 15:33:56  voba
// - new beh. при создании файла-хранилища проверяется и при необходимости достраивается путь к нему
//
// Revision 1.1  2004/09/02 08:09:49  law
// - cleanup.
//
// Revision 1.8  2004/05/20 11:36:31  law
// - bug fix: вместо %1 в сообщении об ошибке теперь пишется имя файла.
//
// Revision 1.7  2002/04/26 13:16:15  law
// - cleanup.
//
// Revision 1.6  2002/02/21 15:58:17  law
// - optimization.
//
// Revision 1.5  2001/11/29 17:02:43  law
// - new directive: _m3NeedStorageFixer.
//
// Revision 1.4  2001/11/28 15:10:02  law
// - bug fix: поправлен PlugIn для Far'а - не читал архивированные хранилища.
//
// Revision 1.3  2001/11/28 14:19:32  law
// - new behavior: сделано создание хранилищ с автоматической паковкой.
//
// Revision 1.2  2001/10/26 17:43:32  law
// - comments: xHelpGen.
//

{$I m3Define.inc}

interface

uses
  Windows,
  SysUtils,

  ActiveX,
  COMObj,

  l3FileUtils,
  
  m2COMLib,

  m3StorageInterfaces,

  m3ArchiveStorage
  ;

const
  def_ReadModeStorageUseCompression = m3_stArchive;
  def_FullModeStorageUseCompression = m3_stArchive;

type
  Tm3StorageManager = class
   protected
    class function SharedMode: Cardinal; virtual; abstract;
   public
    class procedure IterateStorageFiles(const aName : AnsiString; aDoFile : TFileProcessingFunc);
    class procedure DeleteStorageFile(const aName : AnsiString);
    class function RenameStorageFile(const anOldName : AnsiString; const aNewName : AnsiString): Boolean;
    class function StorageFileExists(const aName : AnsiString): Boolean;
    class function UseSplitted: Boolean;
    class function HasSplitted(const aName : AnsiString): Boolean;
    class function HasSolid(const aName : AnsiString): Boolean;
  end;//Tm3StorageManager

  Tm3ReadModeStorageManager = class(Tm3StorageManager)
   {* Менеджер для создания ReadOnly хранилищ. }
   protected
    class function SharedMode: Cardinal; override;
    class function MakeInterface(const AStream  : IStream;
                                 UseCompression : Tm3StorageType
                                 ): Im3StorageHolder; overload;
     {* Открывает хранилище в потоке. }
    class function MakeSafeInterface(out AResult    : Im3IndexedStorage;
                                     const AStream  : IStream;
                                     UseCompression : Tm3StorageType
                                     ): HRESULT; overload;
     {* Открывает хранилище в потоке (без исключительных ситуаций). }
   public
    class function MakeInterface(const AName    : WideString;
                                 UseCompression : Tm3StorageType = def_ReadModeStorageUseCompression
                                 ): Im3IndexedStorage; overload;
     {* Открывает хранилище на диске. }

    class function MakeSafeInterface(out   AResult  : Im3IndexedStorage;
                                     const AName    : WideString;
                                     UseCompression : Tm3StorageType = def_ReadModeStorageUseCompression
                                     ): HRESULT; overload;
     {* Открывает хранилище на диске (без исключительных ситуаций). }
  end;//Tm3ReadModeStorageManager

  Tm3FullModeStorageManager = class(Tm3StorageManager)
   {* Менеджер для создания хранилищ. }
   protected
    class function SharedMode: Cardinal; override;
    class function MakeInterface(const AStream: IStream;
                                 UseCompression : Tm3StorageType
                                 ): Im3StorageHolder; overload;
     {* Открывает хранилище в потоке. }
    class function MakeSafeInterface(out AResult: Im3IndexedStorage;
                                     const AStream: IStream;
                                     UseCompression : Tm3StorageType
                                     ): HRESULT; overload;
     {* Открывает хранилище в потоке (без исключительных ситуаций). }
   public
    class function MakeInterface(const AName: WideString;
                                 UseCompression : Tm3StorageType = def_FullModeStorageUseCompression
                                 ): Im3IndexedStorage; overload;
     {* Открывает хранилище на диске. }
    class function MakeSafeInterface(out AResult: Im3IndexedStorage;
                                     const AName: WideString;
                                     UseCompression : Tm3StorageType = def_FullModeStorageUseCompression
                                     ): HRESULT; overload;
     {* Открывает хранилище на диске (без исключительных ситуаций). }
  end;//Tm3FullModeStorageManager

  Tm3FullModeExclusiveStorageManager = class(Tm3FullModeStorageManager)
   protected
    class function SharedMode: Cardinal; override;
  end;//Tm3FullModeExclusiveStorageManager

  Tm3ReadModeExclusiveStorageManager = class(Tm3ReadModeStorageManager)
   protected
    class function SharedMode: Cardinal; override;
  end;//Tm3ReadModeExclusiveStorageManager

  Tm3FullModeBackupStorageManager = class(Tm3FullModeStorageManager)
  end;//Tm3FullModeBackupStorageManager

  Tm3FullModeBackupExclusiveStorageManager = class(Tm3FullModeBackupStorageManager)
   protected
    class function SharedMode: Cardinal; override;
  end;//Tm3FullModeBackupExclusiveStorageManager

  Tm3ReadModeBackupStorageManager = class(Tm3ReadModeStorageManager)
  end;//Tm3ReadModeBackupStorageManager

  Tm3ConstantStorageManager = class(Tm3ReadModeStorageManager)
   protected
    class function SharedMode: Cardinal; override;
  end;//Tm3ConstantStorageManager

implementation

uses
  StrUtils,

  l3Base,
  
  m3SplittedFileStream,
  m3RootStreamManagerPrim,
  m3RootStreamManager,
  m3StorageHolder,
  m3StorageHolderList,
  m3TempStream,
  m3FileStream,
  m3StorageService
  ;

// Tm3ReadModeStorageManager

class function Tm3ReadModeStorageManager.SharedMode: Cardinal;
begin
 Result := FILE_SHARE_READ or FILE_SHARE_WRITE;
end;

const
 cFileMacro = '%1';

class function Tm3ReadModeStorageManager.MakeInterface(const aName    : WideString;
                                                       UseCompression : Tm3StorageType = def_ReadModeStorageUseCompression): Im3IndexedStorage;
const
 CAccess = GENERIC_READ;
 CDistribution = OPEN_EXISTING;
 CFlags = FILE_ATTRIBUTE_NORMAL;
begin
 if Tm3StorageHolder.GetFromCache(aName, STGM_READ, UseCompression, SharedMode, Result) then
  Exit;
 if not StorageFileExists(aName) then
 begin
  Result := nil;
  Exit;
 end;//not StorageFileExists(aName)
 try
  if HasSplitted(aName) then
  begin
   Assert(not HasSolid(aName), 'Существуют и кусочная и некусочная части: ' + aName);
   Result := MakeInterface(Tm3SplittedFileStream.Make(AName, CAccess, SharedMode, CDistribution, CFlags),
                           UseCompression).StoreToCache(aName, SharedMode);
  end//HasSplitted(aName)
  else
  if {UseSplitted AND }not HasSolid(aName) then
   Result := MakeInterface(Tm3SplittedFileStream.Make(AName, CAccess, SharedMode, CDistribution, CFlags),
                           UseCompression).StoreToCache(aName, SharedMode)
  else
   Result := MakeInterface(Tm3FileStream.Make(AName, CAccess, SharedMode, CDistribution, CFlags),
                          UseCompression).StoreToCache(aName, SharedMode);
 except
  on E: EOleSysError do
  begin
   if (E.ErrorCode = STG_E_INVALIDHEADER)
      OR (Pos(cFileMacro, E.Message) > 0) then
    raise EOleSysError.Create(ANSIReplaceStr(E.Message, cFileMacro, '"' + aName + '"'), E.ErrorCode, E.HelpContext)
   else
    raise;
  end;//on E: EOleSysError
 end;//try..except 
end;

class function Tm3ReadModeStorageManager.MakeSafeInterface(out   AResult: Im3IndexedStorage;
                                                         const AName: WideString;
                                                         UseCompression : Tm3StorageType = def_ReadModeStorageUseCompression): HRESULT;
begin
 Result := S_OK;
 try
  AResult := MakeInterface(AName, UseCompression);
 except
  on E: EOutOfMemory do
   Result := STG_E_INSUFFICIENTMEMORY;
  on E: EOleSysError do
   Result := E.ErrorCode;
  else
   Result := E_UNEXPECTED;
 end;//try..except
end;

class function Tm3ReadModeStorageManager.MakeInterface(const AStream  : IStream;
                                                       UseCompression : Tm3StorageType): Im3StorageHolder;
begin
 Result := Tm3ArchiveStorage.Make(STGM_READ, AStream, UseCompression);
end;

class function Tm3ReadModeStorageManager.MakeSafeInterface(out   AResult  : Im3IndexedStorage;
                                                         const AStream  : IStream;
                                                         UseCompression : Tm3StorageType): HRESULT;
begin
 Result := S_OK;
 try
  AResult := MakeInterface(aStream, UseCompression).Storage;
 except
  on E: EOutOfMemory do
   Result := STG_E_INSUFFICIENTMEMORY;
  on E: EOleSysError do
   Result := E.ErrorCode;
  else
   Result := E_UNEXPECTED;
 end;//try..except
end;

// Tm3FullModeStorageManager

class function Tm3FullModeStorageManager.SharedMode: Cardinal;
begin
 Result := FILE_SHARE_READ or FILE_SHARE_WRITE;
end;

class function Tm3FullModeStorageManager.MakeInterface(const aName: WideString;
                                                     UseCompression : Tm3StorageType = def_FullModeStorageUseCompression): Im3IndexedStorage;
const
 CAccess = GENERIC_READ or GENERIC_WRITE;
 CDistribution = OPEN_ALWAYS;
 CFlags = FILE_ATTRIBUTE_NORMAL;
begin
 if (AName = '') then
  Result := MakeInterface(Tm3TempStream.Make, UseCompression).StoreToCache(aName, SharedMode)
 else
 begin
  if Tm3StorageHolder.GetFromCache(aName, STGM_READWRITE, UseCompression, SharedMode, Result) then
   Exit;
  l3FileUtils.MakeDir(ExtractFilePath(AName));
  try
   if HasSplitted(aName) then
   begin
    Assert(not HasSolid(aName), 'Существуют и кусочная и некусочная части: ' + aName);
    Result := MakeInterface(Tm3SplittedFileStream.Make(AName, CAccess, SharedMode, CDistribution, CFlags), UseCompression).StoreToCache(aName, SharedMode);
   end//HasSplitted(aName)
   else
   if UseSplitted AND not HasSolid(AName) then
    Result := MakeInterface(Tm3SplittedFileStream.Make(AName, CAccess, SharedMode, CDistribution, CFlags), UseCompression).StoreToCache(aName, SharedMode)
   else
    Result := MakeInterface(Tm3FileStream.Make(AName, CAccess, SharedMode, CDistribution, CFlags), UseCompression).StoreToCache(aName, SharedMode);
  except
   on E: EOleSysError do
   begin
    if (E.ErrorCode = STG_E_INVALIDHEADER)
       OR (Pos(cFileMacro, E.Message) > 0) then
     raise EOleSysError.Create(ANSIReplaceStr(E.Message, cFileMacro, '"' + aName + '"'), E.ErrorCode, E.HelpContext)
    else
     raise;
   end;//on E: EOleSysError
  end;//try..except
 end;//AName = ''
end;

class function Tm3FullModeStorageManager.MakeSafeInterface(out   AResult: Im3IndexedStorage;
                                                         const AName: WideString;
                                                         UseCompression : Tm3StorageType = def_FullModeStorageUseCompression): HRESULT;
begin
 Result := S_OK;
 try
  AResult := MakeInterface(AName, UseCompression);
 except
  on E: EOutOfMemory do
   Result := STG_E_INSUFFICIENTMEMORY;
  on E: EOleSysError do
   Result := E.ErrorCode;
  else
   Result := E_UNEXPECTED;
 end;//try..except
end;

class function Tm3FullModeStorageManager.MakeInterface(const AStream: IStream;
                                                     UseCompression : Tm3StorageType): Im3StorageHolder;
begin
 Result := Tm3ArchiveStorage.Make(STGM_READWRITE, AStream, UseCompression);
end;

class function Tm3FullModeStorageManager.MakeSafeInterface(out   AResult: Im3IndexedStorage;
                                                         const AStream: IStream;
                                                         UseCompression : Tm3StorageType): HRESULT;
begin
 Result := S_OK;
 try
  AResult := MakeInterface(aStream, UseCompression).Storage;
 except
  on E: EOutOfMemory do
   Result := STG_E_INSUFFICIENTMEMORY;
  on E: EOleSysError do
   Result := E.ErrorCode;
  else
   Result := E_UNEXPECTED;
 end;//try..except
end;

// start class Tm3StorageManager

class procedure Tm3StorageManager.IterateStorageFiles(const aName : AnsiString; aDoFile : TFileProcessingFunc);

var
 l_Ext : AnsiString;
 
 function DoFile(const aFileName: AnsiString; aData: Pointer): Boolean;
 begin//DoFile
  if (Pos('.etalon.', aFileName) > 0) then
  //if AnsiEndsStr('.etalon' + l_Ext, aFileName) then
   Result := true
  else
   Result := aDoFile(aFileName, aData);
 end;//DoFile

var
 l_FPStub : Pointer;
const
 cMaskPart = '.*';
var
 l_Mask : AnsiString;
 l_Folder : AnsiString;
begin
 l_Ext := ExtractFileExt(aName);
 aDoFile(aName, nil);
 aDoFile(Tm3SplittedFileStream.NormalizeFileName(aName) + m3_cInfoFileNameExt + l_Ext, nil);
 aDoFile(Tm3SplittedFileStream.NormalizeFileName(aName) + l_Ext + cLockLogExt, nil);
 l_Folder := ExtractFilePath(aName);
 l_Mask := Tm3SplittedFileStream.NormalizeFileName(ExtractFileName(aName)) + cMaskPart + l_Ext;
 l_FPStub := l3LocalStub(@DoFile);
 try
  ProcessFilesWithMask(l_Folder, l_Mask, l_FPStub);
 finally
  l3FreeLocalStub(l_FPStub);
 end;//try..finally
end;

class procedure Tm3StorageManager.DeleteStorageFile(const aName : AnsiString);

 function DoFile(const aFileName: AnsiString): Boolean;
 begin//DoFile
  Result := true;
  if FileExists(aFileName) then
   DeleteFile(aFileName);
 end;//DoFile

var
 l_FPStub : Pointer;
begin
 Tm3StorageHolderList.Drop(aName);
 l_FPStub := l3LocalStub(@DoFile);
 try
  IterateStorageFiles(aName, l_FPStub);
 finally
  l3FreeLocalStub(l_FPStub);
 end;//try..finally
end;

class function Tm3StorageManager.UseSplitted: Boolean;
begin
 Result := Tm3StorageService.Instance.UseSplitted;
end;

class function Tm3StorageManager.HasSplitted(const aName : AnsiString): Boolean;
var
 l_Ext : AnsiString;
 l_Name : AnsiString;
begin
 l_Ext := ExtractFileExt(aName);
 l_Name := Tm3SplittedFileStream.NormalizeFileName(aName) + m3_cInfoFileNameExt + l_Ext;
 Result := FileExists(l_Name);
end;

class function Tm3StorageManager.HasSolid(const aName : AnsiString): Boolean;
begin
 Result := FileExists(aName);
end;

class function Tm3StorageManager.StorageFileExists(const aName : AnsiString): Boolean;

 function DoFile(const aFileName: AnsiString): Boolean;
 begin//DoFile
  Result := true;
  if FileExists(aFileName) then
  begin
   StorageFileExists := true;
   Result := false;
  end;//FileExists(aFileName)
 end;//DoFile

var
 l_FPStub : Pointer;
begin
 Result := false;
 l_FPStub := l3LocalStub(@DoFile);
 try
  IterateStorageFiles(aName, l_FPStub);
 finally
  l3FreeLocalStub(l_FPStub);
 end;//try..finally
end;

class function Tm3StorageManager.RenameStorageFile(const anOldName : AnsiString; const aNewName : AnsiString) : Boolean;

var
 l_PathNew : AnsiString;
 l_StartOld : AnsiString;
 l_StartNew : AnsiString;

 function DoFile(const aFileName: AnsiString): Boolean;
 var
  l_Name : AnsiString;
 begin//DoFile
  Result := true;
  if FileExists(aFileName) then
  begin
   l_Name := ExtractFileName(aFileName);
   if AnsiStartsText(l_StartOld, l_Name) then
   begin
    Delete(l_Name, 1, Length(l_StartOld));
    l_Name := l_StartNew + l_Name;
   end//AnsiStartsText(l_StartOld, l_Name)
   else
    Assert(false, 'Какая-то беда с переименованием файлов');
   l_Name := l_PathNew + l_Name;
   if FileExists(l_Name) then
    DeleteFile(l_Name);
   if RenameFile(aFileName, l_Name) then
    RenameStorageFile := true
   else
    Assert(false, Format('Какая-то беда с переименованием файлов %s в %s', [aFileName, l_Name]));
  end;//FileExists(aFileName)
 end;//DoFile

var
 l_FPStub : Pointer;
begin
 Tm3StorageHolderList.Drop(anOldName);
 Result := false;
 l_PathNew := ExtractFilePath(aNewName);
 if (l_PathNew = '') then
  l_PathNew := ExtractFilePath(anOldName);
 l_StartOld := Tm3SplittedFileStream.NormalizeFileName(ExtractFileName(anOldName));
 l_StartNew := Tm3SplittedFileStream.NormalizeFileName(ExtractFileName(aNewName));
 l_FPStub := l3LocalStub(@DoFile);
 try
  IterateStorageFiles(anOldName, l_FPStub);
 finally
  l3FreeLocalStub(l_FPStub);
 end;//try..finally
end;

class function Tm3FullModeExclusiveStorageManager.SharedMode: Cardinal;
begin
 Result := 0;
end;

class function Tm3ReadModeExclusiveStorageManager.SharedMode: Cardinal;
begin
 Result := 0;
end;

class function Tm3ConstantStorageManager.SharedMode: Cardinal;
begin
 Result := FILE_SHARE_READ;
end;

class function Tm3FullModeBackupExclusiveStorageManager.SharedMode: Cardinal;
begin
 Result := 0;
end;

end.

