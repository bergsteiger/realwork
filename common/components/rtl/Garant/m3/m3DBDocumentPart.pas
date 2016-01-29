unit m3DBDocumentPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Модуль: "w:/common/components/rtl/Garant/m3/m3DBDocumentPart.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3DBDocumentPart
//
// Реализация части документа.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3DBInterfaces,
  m3BaseObject,
  l3Filer,
  m3PrimDB,
  ActiveX,
  m3StorageInterfaces
  ;

type
 Tm3DBDocumentPart = class(Tm3BaseObject, Im3DBDocumentPart)
  {* Реализация части документа. }
 private
 // private fields
   f_Document : Im3DBDocument;
   f_Level : Integer;
   f_Filer : Tl3CustomFiler;
 protected
 // realized methods
   function pm_GetDocument: Im3DBDocument;
   function pm_GetInfo: Tm3DBDocumentInfo;
   procedure pm_SetInfo(const aValue: Tm3DBDocumentInfo);
   function Open(aMode: Tm3StoreAccess = m3_saRead;
    aDocPart: Tm3DocPartSelector = m3_defDocPart;
    aIndex: Integer = 0): IStream;
     {* Открывает поток в документе. }
   function DateTime: TDateTime;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(aDB: Tm3PrimDB;
     const aDoc: Im3DBDocument;
     aLevel: Integer = 0;
     aFiler: Tl3CustomFiler = nil); reintroduce;
   class function Make(aDB: Tm3PrimDB;
     const aDoc: Im3DBDocument;
     aLevel: Integer = 0;
     aFiler: Tl3CustomFiler = nil): Im3DBDocumentPart; reintroduce;
     {* Сигнатура фабрики Tm3DBDocumentPart.Make }
 end;//Tm3DBDocumentPart

implementation

uses
  SysUtils,
  m3DB,
  m2MemLib,
  m3StorageTools,
  l3String,
  m3BackupTools,
  m3NewVersionStream,
  l3Base,
  m3DBProxyWriteStream,
  l3Types,
  m3Const,
  l3ForkStream,
  m3Exceptions,
  ComObj,
  m2COMLib,
  Windows,
  l3Date
  ;

// start class Tm3DBDocumentPart

constructor Tm3DBDocumentPart.Create(aDB: Tm3PrimDB;
  const aDoc: Im3DBDocument;
  aLevel: Integer = 0;
  aFiler: Tl3CustomFiler = nil);
//#UC START# *555B37CA01B6_4742DCFF02DC_var*
//#UC END# *555B37CA01B6_4742DCFF02DC_var*
begin
//#UC START# *555B37CA01B6_4742DCFF02DC_impl*
 inherited Create(aDB);
 f_Level := aLevel;
 f_Document := aDoc;
 aFiler.SetRefTo(f_Filer);
//#UC END# *555B37CA01B6_4742DCFF02DC_impl*
end;//Tm3DBDocumentPart.Create

class function Tm3DBDocumentPart.Make(aDB: Tm3PrimDB;
  const aDoc: Im3DBDocument;
  aLevel: Integer = 0;
  aFiler: Tl3CustomFiler = nil): Im3DBDocumentPart;
var
 l_Inst : Tm3DBDocumentPart;
begin
 l_Inst := Create(aDB, aDoc, aLevel, aFiler);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function Tm3DBDocumentPart.pm_GetDocument: Im3DBDocument;
//#UC START# *4725D0FB008B_4742DCFF02DCget_var*
//#UC END# *4725D0FB008B_4742DCFF02DCget_var*
begin
//#UC START# *4725D0FB008B_4742DCFF02DCget_impl*
 Result := f_Document;
//#UC END# *4725D0FB008B_4742DCFF02DCget_impl*
end;//Tm3DBDocumentPart.pm_GetDocument

function Tm3DBDocumentPart.pm_GetInfo: Tm3DBDocumentInfo;
//#UC START# *4725D11802BD_4742DCFF02DCget_var*
var
 l_ID     : Integer;
 l_Summ   : IStream;
 l_Length : LongInt;
 l_ContentType : AnsiString;
//#UC END# *4725D11802BD_4742DCFF02DCget_var*
begin
//#UC START# *4725D11802BD_4742DCFF02DCget_impl*
 Result := Tm3DBDocumentInfo_C(0);
 if (f_DB <> nil) then
  with f_DB do
  begin
(*   Start(m3_saRead);*)
   try
    l_ID := f_Document.ID;
    l_Summ := Open(m3_saRead, m3_dsInfo);
    //        ^^^^
    if (l_Summ = nil) and (f_Level <> Cm3ConstVersion) {not f_IsConst} then
     l_Summ := f_Document.GetConst.Open(m3_saRead, m3_dsInfo);
    //

    if (l_Summ <> nil) then
    begin
     if (l_Summ.Read(@l_Length, SizeOf(l_Length), nil) = S_False) then
      Exit;
     if (l_Length > 0) then
     begin
      SetLength(l_ContentType, l_Length);
      if (l_Summ.Read(@l_ContentType[1], l_Length, nil) = S_False) then
      begin
       SetLength(l_ContentType, 0);
       Exit;
      end;//l_Summ.Read..
     end;
     l_Summ.Read(@Result.rIndexID, SizeOf(Result.rIndexID), nil);
     if l_Summ.Read(@Result.rRelID, SizeOf(Result.rRelID), nil) = S_False then
      Result.rRelID := 0;
     if l_Summ.Read(@Result.rRightsMask, SizeOf(Result.rRightsMask), nil) = S_False then
      Result.rRightsMask := 0;
     if l_Summ.Read(@Result.rLockedBy, SizeOf(Result.rLockedBy), nil) = S_False then
      Result.rLockedBy := 0;
     if l_Summ.Read(@Result.rDocType, SizeOf(Result.rDocType), nil) = S_False then
      Result.rDocType := 0;
     if l_Summ.Read(@Result.rExtDocID, SizeOf(Result.rExtDocID), nil) = S_False then
      Result.rExtDocID := 0;
     l_Summ := nil; 
    end;//l_Summ <> nil
   finally
(*    Finish;*)
   end;//try..finally
  end;//with f_DB
//#UC END# *4725D11802BD_4742DCFF02DCget_impl*
end;//Tm3DBDocumentPart.pm_GetInfo

procedure Tm3DBDocumentPart.pm_SetInfo(const aValue: Tm3DBDocumentInfo);
//#UC START# *4725D11802BD_4742DCFF02DCset_var*
var
 l_Info   : Tm3DBDocumentInfo;
 l_Summ   : IStream;
 l_Length : LongInt;
 l_ContentType : AnsiString;
//#UC END# *4725D11802BD_4742DCFF02DCset_var*
begin
//#UC START# *4725D11802BD_4742DCFF02DCset_impl*
 if (f_DB <> nil) then
  with f_DB do
  begin
   if (f_Level = Cm3ConstVersion) then
    raise Exception.Create('pm_SetInfo to ConstPart')
(*   else
    Start(m3_saReadWrite)*);
   try
    l_Info := pm_GetInfo;
    if (m2MEMCompare(@l_Info, @aValue, SizeOf(l_Info)) <> 0) then
    begin
     l_Summ := Open(m3_saReadWrite, m3_dsInfo);
     if (l_Summ <> nil) then
     begin
      l_ContentType := '';
      l_Length := Length(l_ContentType);
      l_Summ.Write(@l_Length, SizeOf(l_Length), nil);
      if (l_Length <> 0) then
       l_Summ.Write(@l_ContentType[1], l_Length, nil);
      l_Summ.Write(@aValue.rIndexID, SizeOf(aValue.rIndexID), nil);
      l_Summ.Write(@aValue.rRelID, SizeOf(aValue.rRelID), nil);
      l_Summ.Write(@aValue.rRightsMask, SizeOf(aValue.rRightsMask), nil);
      l_Summ.Write(@aValue.rLockedBy, SizeOf(aValue.rLockedBy), nil);
      l_Summ.Write(@aValue.rDocType, SizeOf(aValue.rDocType), nil);
      l_Summ.Write(@aValue.rExtDocID, SizeOf(aValue.rExtDocID), nil);
      l_Summ := nil;
     end;//l_Summ <> nil
    end;//pm_GetContentType <> aValue
   finally
(*    Finish;*)
   end;//try..finally
  end;//with f_DB
//#UC END# *4725D11802BD_4742DCFF02DCset_impl*
end;//Tm3DBDocumentPart.pm_SetInfo

function Tm3DBDocumentPart.Open(aMode: Tm3StoreAccess = m3_saRead;
  aDocPart: Tm3DocPartSelector = m3_defDocPart;
  aIndex: Integer = 0): IStream;
//#UC START# *4725D13E031C_4742DCFF02DC_var*

 function OpenStream(anIndex : Tm3DBStreamIndex): IStream;

 var
  l_WasInProcess : Boolean;
  
  function GetVersionForWrite(var theBase: Im3IndexedStorage; aPart: Tm3DBPart): IStream;

  var
   l_DocStorage : Im3IndexedStorage;
   
   function CheckNotExist: Boolean;
   var
    l_S : IStream;
   begin//CheckNotExist
    l_S := m3COMOpenStream(l_DocStorage,
                           l3PCharLen(m3_cDocPartName[anIndex.rPart]),
                           m3_saRead,
                           false);
    Result := (l_S = nil);
   end;//CheckNotExist

  var
   l_Storage    : Im3IndexedStorage;
   l_ObjStorage : Im3IndexedStorage;
   l_Stream     : IStream;
   l_Version    : Integer;
  begin//GetVersionForWrite
   Result := nil;
   l_Storage := m3COMOpenStorage(theBase,
                                 anIndex.rID,
                                 m3_saReadWrite,
                                 true);
   if (l_Storage <> nil) then
   begin
    theBase := nil;
    if not l_WasInProcess then
     if not f_DB.IsExclusive then
      f_DB.CloseBase;
   end;//l_Storage <> nil
   try
    Assert(l_Storage <> nil); 
    l_Storage.SetIndexParam(16, 16);
    l_Stream :=  m3COMOpenStream(l_Storage,
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
   if (l_Version > 0) then
   // - пытаемся открыть поток в предыдущей версии
   begin
    l_DocStorage := m3COMOpenStorage(l_Storage, l_Version, m3_saReadWrite, false);
    if (l_DocStorage <> nil) then
     try
      l_DocStorage.SetIndexParam(16, 16);
      if (anIndex.rPart = m3_dsObject) then
      begin
       l_ObjStorage := m3COMOpenStorage(l_DocStorage,
                                        l3PCharLen(m3_cDocPartNameW[anIndex.rPart]),
                                        m3_saReadWrite,
                                        True);
       if (l_ObjStorage <> nil) then
        try
         Result := m3COMOpenStream(l_ObjStorage,
                                   anIndex.rIdx,
                                   m3_saRead,
                                   false);
         if (Result = nil) then // - не было такого потока
          Result := m3COMOpenStream(l_ObjStorage, // - создаем его
                                    anIndex.rIdx,
                                    m3_saReadWrite,
                                    true)

         else
          Result := nil;
          // - поток был - его перезаписывать не надо
        finally
         l_ObjStorage := nil;
        end;//try..finally
      end//aPartSelector = m3_dsObject
      else
      begin
       if not l_DocStorage.ElementExists(l3PCharLen(m3_cDocPartName[anIndex.rPart])) then
(*       Result := m3COMOpenStream(l_DocStorage,
                                 l3PCharLen(m3_cDocPartName[anIndex.rPart]),
                                 m3_saRead,
                                 false);
       if (Result = nil) then*)
        // - не было такого потока
        Result := m3COMOpenStream(l_DocStorage,
                                  l3PCharLen(m3_cDocPartNameW[anIndex.rPart]),
                                  m3_saReadWrite,
                                  true)
        // - создаем его
       else
        Result := nil;
        // - поток был - его перезаписывать не надо
      end;//aPartSelector = m3_dsObject
     finally
      l_DocStorage := nil;
     end;//try..finally
   end;//l_Version > 0
   if (Result = nil) then
   // - не удалось открыть поток в предыдущей версии
   begin
    while true do
    begin
     Inc(l_Version);
     l_DocStorage := m3COMOpenStorage(l_Storage, l_Version, m3_saReadWrite, true);
     try
      if (l_DocStorage <> nil) then
       l_DocStorage.SetIndexParam(16, 16);
      if (anIndex.rPart = m3_dsObject) then
      begin
       l_ObjStorage := m3COMOpenStorage(l_DocStorage, l3PCharLen(m3_cDocPartNameW[anIndex.rPart]), m3_saReadWrite, True);
       try
        Result := m3COMOpenStream(l_ObjStorage,
                                  anIndex.rIdx,
                                  m3_saReadWrite,
                                  true);
        if f_DB.NeedProxy then
         Result := Tm3NewVersionStream.Make(Result,
                                            f_DB,
                                            Tm3DBStreamIndexEx_CV(
                                            anIndex,
                                            aPart, l_Version));
       finally
        l_ObjStorage := nil;
       end;//try..finally
      end//aPartSelector = m3_dsObject
      else
      begin
       if not CheckNotExist then
       begin
        l3System.Msg2Log('Поток ' + m3_cDocPartName[anIndex.rPart] + ' уже существует в ' + IntToStr(anIndex.rID) + '.' + IntToStr(l_Version));
        continue;
       end;//not CheckNotExist
       Result := m3COMOpenStream(l_DocStorage,
                                 l3PCharLen(m3_cDocPartNameW[anIndex.rPart]),
                                 m3_saReadWrite,
                                 true);
       if f_DB.NeedProxy then
        Result := Tm3NewVersionStream.Make(Result,
                                           f_DB,
                                           Tm3DBStreamIndexEx_CV(
                                           anIndex,
                                           aPart, l_Version));
      end;//anIndex.rPart = m3_dsObject
     finally
      l_DocStorage := nil;
     end;//try..finally
     break;
    end;//while true
   end//Result = nil
   else
   // - удалось открыть поток в предыдущей версии
   if f_DB.NeedProxy then
    Result := Tm3DBProxyWriteStream.Make(Result,
                                         f_DB,
                                         Tm3DBStreamIndexEx_CV(
                                         anIndex,
                                         aPart, l_Version));
    // - надо его завернуть
  end;//GetVersionForWrite

  function GetConstStream(const aBase: Im3IndexedStorage): IStream;
  var
   l_DocStorage : Im3IndexedStorage;
   l_ObjStorage : Im3IndexedStorage;
  begin
   m3COMSafeOpenStorage(aBase, anIndex.rID, aMode, aMode <> m3_saRead, l_DocStorage);
   try
    if (l_DocStorage <> nil) then
     if (anIndex.rPart = m3_dsObject) then
     begin
      m3COMSafeOpenStorage(l_DocStorage,
                           l3PCharLen(m3_cDocPartName[anIndex.rPart]),
                           aMode,
                           aMode <> m3_saRead,
                           l_ObjStorage);
      try
       if (l_ObjStorage <> nil) then
        m3COMSafeOpenStream(l_ObjStorage,
                            anIndex.rIdx,
                            aMode,
                            aMode <> m3_saRead,
                            Result);
      finally
       l_ObjStorage := nil;
      end;
     end
     else
      m3COMSafeOpenStream(l_DocStorage,
                          l3PCharLen(m3_cDocPartName[anIndex.rPart]),
                          aMode,
                          aMode <> m3_saRead,
                          Result);
   finally
    l_DocStorage := nil;
   end;//try..finally
  end;//

  procedure l_TuneFiler(aFiler: Tl3CustomFiler);
  begin//l_TuneFiler
   f_DB.TuneFiler(aFiler);
   if (aMode <> m3_saRead) then
    aFiler.Mode := l3_fmWrite;
  end;//l_TuneFiler

 var
  l_Filer : Tl3CustomFiler;
  l_Base  : Im3IndexedStorage;

  function TryRestoreElement(const aDest: Im3IndexedStorage;
                             //const aSource: Im3IndexedStorage;
                             aPart: Tm3DBPart): IStream;
  var
   l_Name : WideString;
   l_Res  : hResult;
   l_Base : Im3IndexedStorage;
  begin//TryRestoreElement
   Result := nil;
   if (aDest = nil) then
    Exit;
   l_Name := WideString(Format(m3IndexPrefixFormatStr, [anIndex.rID]));
   try
    //l_Res := aDest.DestroyElement(PWideChar(l_Name));
    l_Res := aDest.DeleteStore(anIndex.rID);
   except
    on E: Exception do
    begin
     l3System.Msg2Log('Ошибка при удалении элемента #' + l_Name);
     l3System.Exception2Log(E);
     Exit;
    end;//on E: Exception
   end;//try..except 
   if l3IOk(l_Res) then
   begin
    try
     l_Base := aDest;
     try
      Result := GetVersionForWrite(l_Base, aPart);
     finally
      l_Base := nil;
     end;//try..finally
    except
     Result := nil;
    end;//try..except
   end;//l3IOk(aDest.DestroyElement(PWideChar(l_Name)))
  end;//TryRestoreElement
  
  procedure MakeFork;
  var
   l_Fork : Tl3ForkStream;
   l_Bkp  : Im3IndexedStorage;
   l_S1   : IStream;
   l_S2   : IStream;
  begin//MakeFork
   // делаем форк
   l_Fork := nil;
   try
    l_Bkp := f_DB.GetBackupStorage(aMode);
    try
     try
      l_S1 := GetVersionForWrite(l_Base, m3_bpVersion);
     except
      on Em3InvalidStreamSize do
      begin
       l3System.Msg2Log('Видимо битый файл sav');
       l_S1 := TryRestoreElement(l_Base, m3_bpVersion);
      end;//on Em3InvalidStreamSize
      on Em3InvalidStoreData do
      begin
       l3System.Msg2Log('Видимо битый файл sav');
       l_S1 := nil;
      end;//Em3InvalidStoreData
     end;//try..except
     if (l_Bkp = nil) then
      l_S2 := nil
     else
     begin
      try
       l_S2 := GetVersionForWrite(l_Bkp, m3_bpBackup);
      except
       on Em3InvalidStreamSize do
       begin
        l3System.Msg2Log('Видимо битый файл bkp');
        l_S2 := TryRestoreElement(l_Bkp, m3_bpBackup);
       end;//on Em3InvalidStreamSize
       on Em3InvalidStoreData do
       begin
        l3System.Msg2Log('Видимо битый файл sav');
        l_S2 := nil;
       end;//Em3InvalidStoreData
      end;//try..except
     end;//l_Bkp = nil
     if (l_S1 = nil) AND (l_S2 = nil) then
      raise Exception.Create('Некуда писать документ');

     if (l_S1 = nil) then
     begin
      l_Filer.COMStream := l_S2;
      Exit;
     end;//l_S1 = nil

     if (l_S2 = nil) then
     begin
      l_Filer.COMStream := l_S1;
      Exit;
     end;//l_S2 = nil

     l_Fork := Tl3ForkStream.MakeI(l_S1, l_S2);
     l_S1 := nil;
     l_S2 := nil;
    finally
     l_Bkp := nil
    end;//try..finally
    l_Filer.Stream := l_Fork;
   finally
    FreeAndNil(l_Fork);
   end;//try..finally
  end;//MakeFork

(*  procedure CheckWasModified;
  var
   l_List  : Tl3LongintList;
   l_Index : Integer;
  begin//CheckWasModified
   l_List := Tl3LongintList.MakeSorted;
   try
    f_DB.LoadList(cModified, l_List);
    if l_List.FindData(anIndex.rID, l_Index) then
     raise Exception.Create('Документ ' + IntToStr(anIndex.rID) + ' числится в списке модифицированных, однако не находится в переменной части');
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end;//CheckWasModified*)

  function m3GetDocumentForRead(const aBase: Im3IndexedStorage;
    aDocHandle: Integer): Im3IndexedStorage;
  begin
   try
    Result := m3COMOpenStorage(aBase,
                               aDocHandle,
                               m3_saRead,
                               false);
   except
    on E: EOleSysError do
    begin
     if (E.ErrorCode = STG_E_LOCKVIOLATION) then
      raise
     else
      l3System.Exception2Log(E);
    end;//on EOleSysError
    on E: Exception do
     l3System.Exception2Log(E);
   end;//try..except
  end;//m3GetDocumentForRead

  function m3GetDocumentVersionForRead(const aDocument: Im3IndexedStorage;
    aNotEmpty: Boolean;
    aDocPart: Tm3DocPartSelector;
    aIndex: Integer;
    aLevel: Integer): IStream;
  var
   l_DocStorage : Im3IndexedStorage;
   l_ObjStorage : Im3IndexedStorage;
   l_Stream     : IStream;
   l_Version    : Integer;
   l_Max        : Integer;
  begin
   Result := nil;
   try
    if (aDocument = nil) then
     Exit;
    l_Stream :=  m3COMOpenStream(aDocument,
                                 0,
                                 m3_saRead,
                                 false);
    try
     if (l_Stream = nil) OR
        (l_Stream.Read(@l_Version, SizeOf(l_Version), nil) = S_False) then
      Exit;
    finally
     l_Stream := nil;
    end;//try..finally
    l_Max := l_Version;
    while true do
    begin
     l_Version := l_Max - aLevel;
     if (l_Version <= 0) then
      break;
     if (aDocPart = m3_defDocPart) then
      // - других потоков в старом не было
      l_Stream :=  m3COMOpenStream(aDocument,
                                   l_Version,
                                   m3_saRead,
                                   false)
      // - пытаемся открыть без потока main
     else
      l_Stream := nil;
     try
      if (l_Stream = nil) then
      // - не получилось - пытаемся открыть директорию для версии
      begin
       l_DocStorage := m3COMOpenStorage(aDocument, l_Version, m3_saRead, false);
       try
        if aDocPart = m3_dsObject then
        begin
         m3COMSafeOpenStorage(l_DocStorage, l3PCharLen(m3_cDocPartName[aDocPart]),
                              m3_saRead, False, l_ObjStorage);
         try
          if (l_ObjStorage <> nil) then
           m3COMSafeOpenStream(l_ObjStorage,
                               aIndex,
                               m3_saRead,
                               False,
                               l_Stream);
         finally
          l_ObjStorage := nil;
         end;
        end
        else
         m3COMSafeOpenStream(l_DocStorage,
                                     l3PCharLen(m3_cDocPartName[aDocPart]),
                                     m3_saRead,
                             false,
                             l_Stream);
       finally
        l_DocStorage := nil;
       end;//try..finally
      end//l_Stream = nil
      else
      if (aDocPart <> m3_defDocPart) then
       l_Stream := nil;
      if (aDocPart = m3_dsInfo) AND (l_Stream = nil) then
       m3COMSafeOpenStream(aDocument,
                                   l3PCharLen(m3_cDocPartName[aDocPart]),
                                   m3_saRead,
                           false,
                           l_Stream);
       // - читаем информацию о документе из корневого каталога версии
      Result := l_Stream;
      if (Result <> nil) then
      begin
        if (not aNotEmpty OR (m2COMGetSize(Result) > 0)) then
       // - проверяем на то, что открылся непустой поток
        break
       else
        Result := nil;
      end;//Result <> nil
     finally
      l_Stream := nil;
     end;//try..finally
     Inc(aLevel);
    end;//while true
   except
    on E: EOleSysError do
    begin
     if (E.ErrorCode = STG_E_LOCKVIOLATION) then
      raise
     else
      l3System.Exception2Log(E);
    end;//on EOleSysError
    on E: Exception do
     l3System.Exception2Log(E);
   end;//try..except
  end;//m3GetDocumentVersionForRead
  
 var
  l_TryCount : Integer;
  l_Doc      : Im3IndexedStorage;
 begin//OpenStream
  l_WasInProcess := true;
  // - инициализируем более безобидным значением 
  l_TryCount := 0;
  while (l_TryCount < m3_cMaxTry) do
  begin
   Inc(l_TryCount);
   Result := nil;
   try
    l_Filer := Tl3CustomFiler.Create;
    try
     l_Filer.Handle := anIndex.rID;
     l_TuneFiler(l_Filer);
     l_WasInProcess := f_DB.InProcess;
     if (f_Level = Cm3ConstVersion) then
      f_DB.StartEx(m3_saRead, aMode)
     else
      f_DB.StartEx(aMode, m3_saRead);
     try
      if (f_Level = Cm3ConstVersion) then
      begin
       l_Base := f_DB.MainStorage(aMode);
       try
        if (aMode = m3_saRead) OR not f_DB.NeedProxy then
         l_Filer.COMStream := GetConstStream(l_Base)
        else
         l_Filer.COMStream := Tm3DBProxyWriteStream.Make(
                                GetConstStream(l_Base),
                                f_DB,
                                Tm3DBStreamIndexEx_C(
                                anIndex,
                                m3_bpConst));
       finally
        l_Base := nil;
       end;//try..finally
      end//f_IsConst
      else
      begin
       l_Base := f_DB.GetVersionsStorage(aMode);
       try
        if (aMode = m3_saRead) then
        begin
         l_Doc := m3GetDocumentForRead(l_Base, anIndex.rID);
         try
          l_Base := nil;
          if not l_WasInProcess then
           if not f_DB.IsExclusive then
            f_DB.CloseBase;
          l_Filer.COMStream := m3GetDocumentVersionForRead(l_Doc, False, anIndex.rPart, anIndex.rIdx, f_Level);
         finally
          l_Doc := nil;
         end;//try..finally
(*         l_Filer.COMStream := m3GetVersionForRead(l_Base, anIndex.rID, False, anIndex.rPart, anIndex.rIdx, f_Level);*)
(*         if (l_Filer.COMStream = nil) then
         begin
          if (l_Base <> nil) then
          begin
           l_Base := nil;
           l_Base := f_DB.GetBackupStorage(m3_saReadWrite{aMode});
           l_Filer.COMStream := m3GetVersionForRead(l_Base, anIndex.rID, False, anIndex.rPart, anIndex.rIdx, f_Level);
//           if (l_Filer.COMStream = nil) then
//             CheckWasModified;
          end;//l_Base <> nil
         end;//l_Filer.COMStream = nil*)
        end//aMode = m3_saRead
        else
        begin
         if f_DB.NeedsFork then
          MakeFork
         else
          l_Filer.COMStream := GetVersionForWrite(l_Base, m3_bpVersion);
        end;//aMode = m3_saRead
       finally
        l_Base := nil;
       end;//try..finally
       if (l_Filer.COMStream = nil) then
        Exit;
      end;//f_IsConst
      Supports(l_Filer, IStream, Result);
     finally
      f_DB.Finish;
     end;//try..finally
    finally
     FreeAndNil(l_Filer);
    end;//try..finally
   except
    on E: EOleSysError do
    begin
     if (E.ErrorCode = STG_E_LOCKVIOLATION) then
     begin
      f_DB.CloseBase;
      // - стараемся отпустить всё по-максимуму
      if (l_TryCount >= m3_cMaxTry) then
       raise
      else
      begin
       l3System.Msg2Log('Номер попытки залочки: ' + IntToStr(l_TryCount));
       Sleep(Random(m3_cMaxSleep));
       continue;
      end;//l_TryCount >= m3_cMaxTry
     end//E.ErrorCode = STG_E_LOCKVIOLATION
     else
     begin
      l3System.Exception2Log(E);
      raise;
     end;//else 
    end;//on E: EOleSysError
    on E: Exception do
    begin
     l3System.Exception2Log(E);
     raise;
    end;//on E: Exception
   end;//try..excepy
   break;
  end;//while (l_TryCount < m3_cMaxTry)
 end;//OpenStream

//#UC END# *4725D13E031C_4742DCFF02DC_var*
begin
//#UC START# *4725D13E031C_4742DCFF02DC_impl*
 Result := nil;
 if (f_Filer <> nil) then
  Supports(f_Filer, IStream, Result)
 else
 if (f_DB <> nil) then
 begin
  if (aMode <> m3_saRead) then
   if (aDocPart = m3_dsObject) then
   begin
    if (aIndex < 0) then
     aIndex := f_Document.GetFreeObjectID;
    Assert(aIndex >= 0, 'Отрицательных объектов не бывает');
   end;//aDocPart = m3_dsObject
  Result := OpenStream(Tm3DBStreamIndex_C(f_Document.ID, aDocPart, aIndex));
 end;//f_DB <> nil
//#UC END# *4725D13E031C_4742DCFF02DC_impl*
end;//Tm3DBDocumentPart.Open

function Tm3DBDocumentPart.DateTime: TDateTime;
//#UC START# *555CAF230331_4742DCFF02DC_var*
var
 l_Storage : Im3IndexedStorage;
 l_Stream  : IStream;
 l_Version : Integer;
//#UC END# *555CAF230331_4742DCFF02DC_var*
begin
//#UC START# *555CAF230331_4742DCFF02DC_impl*
 Result := BadDateTime;
 if (f_Level = Cm3ConstVersion) then
  Exit;
 try
  l_Storage := f_DB.GetVersionsStorage(m3_saRead);
  try
   l_Storage := m3COMOpenStorage(l_Storage,
                                 f_Document.ID,
                                 m3_saRead,
                                 false);
   if (l_Storage = nil) then
    Exit;
   l_Stream :=  m3COMOpenStream(l_Storage,
                                0,
                                m3_saRead,
                                false);
   try
    if (l_Stream.Read(@l_Version, SizeOf(l_Version), nil) = S_False) then
     Exit;
    Dec(l_Version, f_Level);
    Dec(l_Version);
    if (l_Version < 0) then
     Exit;
    m2COMSeek(l_Stream, l_Version * SizeOf(Result));
    if (l_Stream.Read(@Result, SizeOf(Result), nil) = S_False) then
     Result := BadDateTime;
   finally
    l_Stream := nil;
   end;//try..finally
  finally
   l_Storage := nil;
  end;//try..finally
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *555CAF230331_4742DCFF02DC_impl*
end;//Tm3DBDocumentPart.DateTime

procedure Tm3DBDocumentPart.Cleanup;
//#UC START# *479731C50290_4742DCFF02DC_var*
//#UC END# *479731C50290_4742DCFF02DC_var*
begin
//#UC START# *479731C50290_4742DCFF02DC_impl*
 FreeAndNil(f_Filer);
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_4742DCFF02DC_impl*
end;//Tm3DBDocumentPart.Cleanup

procedure Tm3DBDocumentPart.ClearFields;
 {-}
begin
 f_Document := nil;
 inherited;
end;//Tm3DBDocumentPart.ClearFields

end.