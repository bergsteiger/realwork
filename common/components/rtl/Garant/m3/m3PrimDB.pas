unit m3PrimDB;
 {* Заготовка для абстрактной базы }

// Модуль: "w:\common\components\rtl\Garant\m3\m3PrimDB.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3PrimDB" MUID: (49BFBC690162)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3DBInterfaces
 , l3Types
 , m3StorageInterfaces
 , l3ProxyStream
 , l3Filer
 , m3BackupTools
;

const
 m3_cDocPartNameW: Tm3DocPartSelector_Names_Array = ('Xmain', 'Xanno', 'Xinfo', m3_cObject);
  {* Имена стандартных потоков для ЗАПИСИ }
 m3_cMaxTry = 10000;
  {* Число попыток повторения открытия потока базы когда упёрлись в залочку }
 m3_cMaxSleep = 1000;
  {* Максимальное время  ожидания между попытками открытия потоков базы }

type
 Tm3PrimDB = {abstract} class(Tl3CProtoObject)
  {* Заготовка для абстрактной базы }
  private
   f_FilesProcessed: Tm3FilesProcessed;
    {* Поле для свойства FilesProcessed }
   f_FilesProcessedEx: Tm3FilesProcessedEx;
    {* Поле для свойства FilesProcessedEx }
   f_FileMeter: Tl3ProgressProc;
    {* Поле для свойства FileMeter }
   f_FilesMeter: Tl3ProgressProc;
    {* Поле для свойства FilesMeter }
  public
   function NeedsFork: Boolean; virtual;
   function IsExclusive: Boolean; virtual; abstract;
   function NeedProxy: Boolean; virtual;
   function AsDB: Im3DB; virtual;
   function LastElapsed: TDateTime; virtual; abstract;
   function Stopped: Boolean; virtual; abstract;
   procedure Yield; virtual; abstract;
   procedure TuneFiler(aFiler: Tl3CustomFiler); virtual; abstract;
   procedure ModifyDeleted(anID: Integer;
    aInsert: Boolean); virtual; abstract;
   function InProcess: Boolean; virtual; abstract;
   procedure ModifyModified(anID: Integer); virtual; abstract;
    {* Добавляет документ в список изменённых }
   procedure Commit(aStream: Tl3ProxyStream);
    {* Сохраняет изменения в документе }
   procedure Revert(aStream: Tl3ProxyStream);
    {* Откатывает изменения потока }
   function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; virtual; abstract;
    {* Возвращает корень постоянной части }
   function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; virtual; abstract;
    {* Возвращает корень переменной части }
   function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; virtual; abstract;
    {* Возвращает корень резервной копии }
   function GetDocumentObjectsIDs(aDocID: Integer): Im3StorageElementIDList;
    {* Возвращает список номеров объектов в документе }
   procedure Start(aOpenMode: Tm3StoreAccess); virtual; abstract;
    {* начинает процесс с базой }
   procedure Finish; virtual; abstract;
    {* заканчивает процесс с базой }
   procedure StartEx(aVersionsMode: Tm3StoreAccess;
    aConstMode: Tm3StoreAccess); virtual; abstract;
    {* начинает процесс с базой }
   procedure CloseBase; virtual; abstract;
    {* закрывает открытые файлы }
   procedure IterateObjectsInDocF(aDocID: Integer;
    aDeleted: Boolean;
    anAction: Tm3DBStreamAction;
    aSkipMain: Boolean);
    {* Перебирает объекты в документе }
  public
   property FilesProcessed: Tm3FilesProcessed
    read f_FilesProcessed
    write f_FilesProcessed;
   property FilesProcessedEx: Tm3FilesProcessedEx
    read f_FilesProcessedEx
    write f_FilesProcessedEx;
   property FileMeter: Tl3ProgressProc
    read f_FileMeter
    write f_FileMeter;
   property FilesMeter: Tl3ProgressProc
    read f_FilesMeter
    write f_FilesMeter;
 end;//Tm3PrimDB

implementation

uses
 l3ImplUses
 , l3Interfaces
 , m3DBProxyWriteStream
 , m3StorageTools
 , m2COMLib
 , SysUtils
 , ComObj
 , l3String
 , m3StorageElementIDList
 , StrUtils
 , Windows
 , l3Base
 , m3DBActions
;

function Tm3PrimDB.NeedsFork: Boolean;
//#UC START# *5540ECC800D2_49BFBC690162_var*
//#UC END# *5540ECC800D2_49BFBC690162_var*
begin
//#UC START# *5540ECC800D2_49BFBC690162_impl*
 {$IfDef m3DBNeedsFork}
 Result := true;
 {$Else  m3DBNeedsFork}
 Result := false;
 {$EndIf m3DBNeedsFork}
//#UC END# *5540ECC800D2_49BFBC690162_impl*
end;//Tm3PrimDB.NeedsFork

function Tm3PrimDB.NeedProxy: Boolean;
//#UC START# *5551EC2101DB_49BFBC690162_var*
//#UC END# *5551EC2101DB_49BFBC690162_var*
begin
//#UC START# *5551EC2101DB_49BFBC690162_impl*
 Result := true;
//#UC END# *5551EC2101DB_49BFBC690162_impl*
end;//Tm3PrimDB.NeedProxy

function Tm3PrimDB.AsDB: Im3DB;
//#UC START# *5553685D006D_49BFBC690162_var*
//#UC END# *5553685D006D_49BFBC690162_var*
begin
//#UC START# *5553685D006D_49BFBC690162_impl*
 Result := nil;
 Assert(false);
//#UC END# *5553685D006D_49BFBC690162_impl*
end;//Tm3PrimDB.AsDB

procedure Tm3PrimDB.Commit(aStream: Tl3ProxyStream);
 {* Сохраняет изменения в документе }
//#UC START# *49BFC9AF02B0_49BFBC690162_var*

 procedure AddDocToBaseSummary(const aBase: Im3IndexedStorage;
   aDocHandle: Integer);

  function SetBaseSummary(const theSumm: Tm3BaseSummary): Boolean;
  var
   l_Stream  : IStream;
   l_Written : Integer;
  begin
   l_Stream := m3GetBaseSummary(aBase, m3_saReadWrite);
   try
    Result := (l_Stream <> nil) AND
              (l_Stream.Write(@theSumm, SizeOf(theSumm), @l_Written) = S_Ok) AND
              (l_Written = SizeOf(theSumm));
   finally
    l_Stream := nil;
   end;//try..finally
  end;

 var
  l_Change : Boolean;
  l_Summ   : Tm3BaseSummary;
 begin
  l_Change := not m3GetBaseSummary(aBase, l_Summ);
  if (aDocHandle < l_Summ.rMin) then
  begin
   l_Summ.rMin := aDocHandle;
   l_Change := true;
  end;//aDocHandle < l_Summ.rMin
  if (aDocHandle > l_Summ.rMax) then
  begin
   l_Summ.rMax := aDocHandle;
   l_Change := true;
  end;//aDocHandle > l_Summ.rMax
  if l_Change then
   SetBaseSummary(l_Summ);
 end;

var
 l_DocRoot : Im3IndexedStorage;

 procedure RenameStream(aVersion : Integer;
                        aPart    : Tm3DocPartSelector);
 var
  l_Version : Im3IndexedStorage;
 begin
  Assert(l_DocRoot <> nil);
  l_Version := m3COMOpenStorage(l_DocRoot,
                              aVersion,
                              m3_saReadWrite,
                              true);
  try
   Assert(l_Version <> nil);
   try
    OleCheck(l_Version.RenameElementA(l3PCharLen(m3_cDocPartNameW[aPart]),
                                      l3PCharLen(m3_cDocPartName[aPart])));
   except
    on E: EOleSysError do
    begin
     if (E.ErrorCode = STG_E_FILENOTFOUND) OR (E.ErrorCode = STG_E_PATHNOTFOUND) then
      raise EOleSysError.Create(ANSIReplaceStr(E.Message, '%1', '"' + m3_cDocPartNameW[aPart] + '"') +
       ' in ' + IntToStr(Tm3DBProxyWriteStream(aStream).ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID) + '.' + IntToStr(Tm3DBProxyWriteStream(aStream).ID.rVersion),
       E.ErrorCode, E.HelpContext)
     else
     if (E.ErrorCode = STG_E_FILEALREADYEXISTS) then
      raise EOleSysError.Create(ANSIReplaceStr(E.Message, '%1', '"' + m3_cDocPartName[aPart] + '"') +
       ' in ' + IntToStr(Tm3DBProxyWriteStream(aStream).ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID) + '.' + IntToStr(Tm3DBProxyWriteStream(aStream).ID.rVersion),
       E.ErrorCode, E.HelpContext)
     else
      raise;
    end;//on E: EOleSysError
   end;//try..except
  finally
   l_Version := nil;
  end;//try..finally
 end;

 procedure WriteVersion(aVersion : Integer);
 var
  l_Stream  : IStream;
  l_Now     : TDateTime;
  l_Index   : Integer;
  l_Version : Integer;
 begin
  Assert(l_DocRoot <> nil);
  try
   l_Stream :=  m3COMOpenStream(l_DocRoot,
                                0,
                                m3_saRead,
                                false);
   try
    if (l_Stream = nil) OR
       (l_Stream.Read(@l_Version, SizeOf(l_Version), nil) = S_False) then
     l_Version := 0;
   finally
    l_Stream := nil;
   end;//try..finally
  except
   l_Version := 0;
  end;//try..except
  if (l_Version > aVersion) then
  begin
   // - потоки могут закрываться в произвольном порядке, поэтому нельзя
   //   понижать уже ранее записанныю версию.
   //l3System.Msg2Log('Версия документа ' + IntToStr(l_Version) + ' пытались записать ' + IntToStr(aVersion));
   Exit;
  end;//l_Version > aVersion
  l_Stream := m3COMOpenStream(l_DocRoot,
                              0,
                              m3_saReadWrite,
                              true,
                              false);
  try
   m2COMWriteBuffer(l_Stream, aVersion, SizeOf(aVersion));
   l_Now := Now;
   try
    m2COMSeek(l_Stream, Pred(aVersion) * SizeOf(l_Now));
   except
    for l_Index := 0 to Pred(aVersion) do
     m2COMWriteBuffer(l_Stream, l_Now, SizeOf(l_Now));
   end;//try..except
   m2COMWriteBuffer(l_Stream, l_Now, SizeOf(l_Now));
  finally
   l_Stream := nil;
  end;//try..finally
 end;

var
 l_Base     : Im3IndexedStorage;
 l_TryCount : Integer;
//#UC END# *49BFC9AF02B0_49BFBC690162_var*
begin
//#UC START# *49BFC9AF02B0_49BFBC690162_impl*
 Assert(aStream Is Tm3DBProxyWriteStream);
 with Tm3DBProxyWriteStream(aStream) do
 begin
  Assert(ID.rVersion >= 0);
  try
   l_TryCount := 0;
   while (l_TryCount < m3_cMaxTry) do
   begin
    l_Base := nil;
    l_DocRoot := nil;
    Inc(l_TryCount);
    try
     Case ID.rDBPart of
      m3_bpConst:
       l_Base := MainStorage(m3_saReadWrite);
      m3_bpVersion:
       l_Base := GetVersionsStorage(m3_saReadWrite);
      m3_bpBackup:
       l_Base := GetBackupStorage(m3_saReadWrite);
      else
       Assert(false);
     end;//Case ID.rDBPart
     Assert(l_Base <> nil);
     if (ID.rDBPart <> m3_bpConst) then
      try
       l_DocRoot := m3COMOpenStorage(l_Base,
                                     ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID,
                                     m3_saReadWrite,
                                     true)
      except
       on E: EOleSysError do
       begin
        if (E.ErrorCode = STG_E_LOCKVIOLATION) then
         raise;
        l3System.Msg2Log('Ошибка %s %s при Commit документа', [E.ClassName, E.Message, ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID]);
        raise;
       end;//on E: EOleSysError
       else
       begin
        l3System.Msg2Log('Ошибка при Commit документа', [ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID]);
        raise;
       end;//else
      end//try..except
     else
      l_DocRoot := nil;
    except
     on E: EOleSysError do
     begin
      if (E.ErrorCode = STG_E_LOCKVIOLATION) then
      begin
       CloseBase;
       // - стараемся отпустить всё по-максимуму
       if (l_TryCount >= m3_cMaxTry) then
        raise
       else
       begin
        Sleep(Random(m3_cMaxSleep));
        continue;
       end;//l_TryCount >= m3_cMaxTry
      end//E.ErrorCode = STG_E_LOCKVIOLATION
      else
       raise;
     end;//on E: EOleSysError
    end;//try..excepy
    break;
   end;//while (l_TryCount < m3_cMaxTry)
   try
    if (ID.rDBPart = m3_bpConst) then
     StartEx(m3_saRead, m3_saReadWrite)
    else
     StartEx(m3_saReadWrite, m3_saRead);
    try
     CloseInner;
     //l3System.Msg2Log('CloseInner');
     // - отпускаем поток, чтобы его можно было переименовать
     if (ID.rDBPart <> m3_bpConst) then
      if (ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rPart <> m3_dsObject) then
       RenameStream(ID.rVersion, ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rPart);
       // - переименовываем поток
     if (ID.rDBPart <> m3_bpConst) then
      ModifyModified(ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID);
     AddDocToBaseSummary(l_Base, ID{$IfDef XE4}.rTm3DBStreamIndex{$EndIf}.rID);
     if (ID.rDBPart <> m3_bpConst) then
     begin
      Assert(ID.rVersion > 0);
      if IsNewVersion then
       // Записываем информацию о новой версии:
       WriteVersion(ID.rVersion);
     end;//ID.rDBPart <> m3_bpConst
    finally
     Finish;
    end;//try..finally
   finally
    l_DocRoot := nil;
   end;//try..finally
  finally
   l_Base := nil;
  end;//try..finally
  //l3System.Msg2Log('EndCommit');
 end;//with aStream
//#UC END# *49BFC9AF02B0_49BFBC690162_impl*
end;//Tm3PrimDB.Commit

procedure Tm3PrimDB.Revert(aStream: Tl3ProxyStream);
 {* Откатывает изменения потока }
//#UC START# *49BFD2E803B1_49BFBC690162_var*
//#UC END# *49BFD2E803B1_49BFBC690162_var*
begin
//#UC START# *49BFD2E803B1_49BFBC690162_impl*
 // - ничего пока не делаем
//#UC END# *49BFD2E803B1_49BFBC690162_impl*
end;//Tm3PrimDB.Revert

function Tm3PrimDB.GetDocumentObjectsIDs(aDocID: Integer): Im3StorageElementIDList;
 {* Возвращает список номеров объектов в документе }
//#UC START# *49C2446A025E_49BFBC690162_var*

var
 l_List : Im3StorageElementIDList absolute Result;
 
 function DoAdd(const aStream: IStream;
                const anIndex: Tm3DBStreamIndex): Boolean;
 begin
  Result := true;
  l_List.Add(anIndex.rIdx);
 end;

//#UC END# *49C2446A025E_49BFBC690162_var*
begin
//#UC START# *49C2446A025E_49BFBC690162_impl*
 Result := Tm3StorageElementIDList.MakeI;
 IterateObjectsInDocF(aDocID, false, m3L2DBStreamAction(@DoAdd), false);
//#UC END# *49C2446A025E_49BFBC690162_impl*
end;//Tm3PrimDB.GetDocumentObjectsIDs

procedure Tm3PrimDB.IterateObjectsInDocF(aDocID: Integer;
 aDeleted: Boolean;
 anAction: Tm3DBStreamAction;
 aSkipMain: Boolean);
 {* Перебирает объекты в документе }
//#UC START# *49C77CA801B9_49BFBC690162_var*

var
 l_Proc : Im3StorageElementIDList;

 procedure IterateObjectsInDoc(const aDocBase: Im3IndexedStorage);

 var
  l_ObjectStorage: Im3IndexedStorage;
   
  function DoObject(const aStoreInfo: Tm3StoreInfo; anIndex: Integer): Boolean;
  var
   l_ObjStream : IStream;
  begin
   Result := True; // пробегаем по всем объектам
   if (aStoreInfo.rStoreType = m3_stStream) then
   begin
    if (l_Proc.IndexOf(anIndex) < 0) then // если этого объекта нет в списке обработанных
    begin
     // пытаемся открыть его поток
     l_ObjStream := l_ObjectStorage.OpenStore(aStoreInfo, m3_saRead, anIndex, true).rStream;
     if (l_ObjStream <> nil) then
     begin
      Assert(Supports(l_ObjStream, IStream));
      try
       if aDeleted XOR (m2COMGetSize(l_ObjStream) > 0) then
        if not anAction(l_ObjStream, Tm3DBStreamIndex_C(aDocID, m3_dsObject, anIndex)) then
        begin
         Result := false;
        end;//not anAction(l_ObjStream, Tm3DBStreamIndex_C(aDocID, m3_dsObject, anIndex))
      finally
       l_ObjStream := nil;
      end;//try..finally
      l_Proc.Add(anIndex);
     end;//l_ObjStream <> nil
    end;//l_Proc.IndexOf(anIndex) < 0
   end;//aStoreInfo.rStoreType = m3_stStream
  end;

 begin
  m3COMSafeOpenStorage(aDocBase, l3PCharLen(PAnsiChar(m3_cObject)), m3_saRead, False, l_ObjectStorage);
  if (l_ObjectStorage <> nil) then
  try
   l_ObjectStorage.IterateIndexedF(L2Mm3StorageIteratorsIterateIndexedFAction(@DoObject));
  finally
   l_ObjectStorage := nil;
  end;//try..finally
 end;

 var
  l_Versions : Im3IndexedStorage;
  l_Main     : Im3IndexedStorage;

 procedure IterateObjectsVersion;
   {-}
    
  procedure IterateObjectsInDocVersionPrim(const aDocBase: Im3IndexedStorage);
  var
   l_Stream: IStream;
   l_Version: Integer;
   l_VersionStorage: Im3IndexedStorage;
  begin
   if aDocBase = nil then
    Exit;
   try
    // читаем номер самой старшей версии
    l_Stream := m3COMOpenStream(aDocBase, 0, m3_saRead, false);
    try
     if (l_Stream = nil) OR
        (l_Stream.Read(@l_Version, SizeOf(l_Version), nil) = S_False) then
      Exit;
    finally
     l_Stream := nil;
    end;//try..finally
    // итерируем по версиям, начиная со старшей
    while (l_Version > 0) do
    begin
     m3COMSafeOpenStorage(aDocBase, l_Version, m3_saRead, False, l_VersionStorage);
     if l_VersionStorage <> nil then
     try
      IterateObjectsInDoc(l_VersionStorage);
     finally
      l_VersionStorage := nil;
     end;//try..finally
     Dec(l_Version);
    end;//l_Version > 0
   except
    on E : Exception do
     l3System.Exception2Log(E);
   end;//try..except
  end;

 var
  l_DocStorage: Im3IndexedStorage;
 begin
  m3COMSafeOpenStorage(l_Versions, aDocID, m3_saRead, False, l_DocStorage);
  if (l_DocStorage <> nil) then
   IterateObjectsInDocVersionPrim(l_DocStorage);
 end;

 procedure IterateObjectsMain;
 var
  l_DocStorage: Im3IndexedStorage;
 begin
  m3COMSafeOpenStorage(l_Main, aDocID, m3_saRead, False, l_DocStorage);
  if (l_DocStorage <> nil) then
   IterateObjectsInDoc(l_DocStorage);
 end;

var
 l_TryCount : Integer; 
//#UC END# *49C77CA801B9_49BFBC690162_var*
begin
//#UC START# *49C77CA801B9_49BFBC690162_impl*
 try
  l_Proc := Tm3StorageElementIDList.MakeI;
  Start(m3_saRead);
  try
   l_TryCount := 0;
   while (l_TryCount < m3_cMaxTry) do
   begin
    l_Versions := nil;
    l_Main := nil;
    Inc(l_TryCount);
    try
     l_Versions := GetVersionsStorage(m3_saRead);
     if not aSkipMain then
      l_Main := MainStorage(m3_saRead);
    except
     on E: EOleSysError do
     begin
      if (E.ErrorCode = STG_E_LOCKVIOLATION) then
      begin
       CloseBase;
       // - стараемся отпустить всё по-максимуму
       if (l_TryCount >= m3_cMaxTry) then
        raise
       else
       begin
        Sleep(Random(m3_cMaxSleep));
        continue;
       end;//l_TryCount >= m3_cMaxTry
      end//E.ErrorCode = STG_E_LOCKVIOLATION
      else
       raise;
     end;//on E: EOleSysError
    end;//try..excepy
    break;
   end;//while (l_TryCount < m3_cMaxTry)
   try
    IterateObjectsVersion;
    if not aSkipMain then
     IterateObjectsMain;
   finally
    try
     l_Versions := nil;
    finally
     l_Main := nil;
    end;//try..finally
   end;//try..finally
  finally
   Finish;
  end;//try..finally
 finally
  m3FreeDBStreamAction(anAction);
 end;//try..finally
//#UC END# *49C77CA801B9_49BFBC690162_impl*
end;//Tm3PrimDB.IterateObjectsInDocF

end.
