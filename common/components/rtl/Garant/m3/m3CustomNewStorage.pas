unit m3CustomNewStorage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3CustomNewStorage.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3CustomNewStorage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  ActiveX,
  m3StorageInterfaces,
  l3_String,
  m3StoreHeaderDataPrim,
  m3StoreHeader,
  m3CommonStorage,
  m3NewStoragePrim,
  m3RootStreamManagerPrim
  ;

type
 Tm3CustomNewStorage = {abstract} class(Tm3NewStoragePrim, Im3IndexedStorage)
 protected
 // realized methods
   function SetIndexParam(aBits: byte;
    aMaxBits: byte): Boolean;
     {* устанавливает параметры "размазывания" индекса. }
   function DeleteStore(anIndex: Tm3StoreElementIndex): hResult;
     {* удаляет элемент хранилища. }
   function CreateStore(anIndex: Tm3StoreElementIndex;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* создает элемент хранилища. }
   function OpenStore(anIndex: Tm3StoreElementIndex;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* открывает элемент хранилища. }
   function CreateStore(const aName: Tl3WString;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* создает элемент хранилища }
   function OpenStore(const aName: Tl3WString;
    anAccess: Tm3StoreAccess;
    aStoreType: Tm3StoreType;
    out aStore: Tm3Store;
    aUseCompression: Boolean): hResult; overload; 
     {* открывает элемент хранилища }
   function OpenStore(const aStoreInfo: Tm3StorageElementInfo;
    anAccess: Tm3StoreAccess;
    aUseCompression: Boolean): Tm3Store; overload; 
     {* открывает элемент хранилища. }
   function OpenStore(const aStoreInfo: Tm3StoreInfo;
    anAccess: Tm3StoreAccess;
    anIndex: Tm3StoreElementIndex;
    aUseCompression: Boolean): Tm3Store; overload; 
     {* открывает элемент хранилища }
   function RenameElementA(const aOldName: Tl3WString;
    const aNewName: Tl3WString): hResult;
     {* Переименовывает элемент хранилища }
   function ElementExists(const aName: Tl3WString): Boolean;
     {* Проверяет существование элемента с указанным именем }
   procedure CheckIndexStream(aNeedCreate: Boolean;
     aForIterate: Boolean); override;
   procedure DoSaveTableOfContents; override;
   procedure DoLoadTableOfContents; override;
   procedure ClearAll;
   procedure CopyFrom(const aSource: Im3IndexedStorage);
 public
 // realized methods
   class function Make(anAccess: Tm3StoreAccess;
     aName: Tl3_String;
     aManager: Tm3RootStreamManagerPrim;
     aPosition: Int64): Im3IndexedStorage; override;
   class function OpenRoot(anAccess: Tm3StoreAccess;
     const aStream: IStream;
     out theManager: Tm3RootStreamManagerPrim): Im3IndexedStorage; override;
   class function OpenFromManager(anAccess: Tm3StoreAccess;
     aManager: Tm3RootStreamManagerPrim): Im3IndexedStorage; override;
   {iterator} procedure IterateIndexedF(anAction: Mm3StorageIterators_IterateIndexedF_Action);
   {iterator} procedure IterateAllF(anAction: Mm3StorageIterators_IterateAllF_Action);
 protected
 // overridden protected methods
   procedure DoCreateStore(const aName: Tl3WString;
     anAccess: Tm3StoreAccess;
     aStoreType: Tm3StoreType;
     out theStream: Tm3Store;
     out theReturn: hResult;
     aUseCompression: Boolean); override;
   procedure DoOpenStore(const aName: Tl3WString;
     anAccess: Tm3StoreAccess;
     aStoreType: Tm3StoreType;
     out theStream: Tm3Store;
     out theReturn: hResult;
     aUseCompression: Boolean); override;
 protected
 // protected methods
   function FindItemByIndex(anIndex: Tm3StoreElementIndex;
     aStoreType: Tm3StoreType;
     anOp: Tm3StoreOperation;
     out thePosition: Int64;
     theStoreType: Pm3StoreType = nil): Boolean;
   function FindItemByName(const aName: Tl3WString;
     anOp: Tm3StoreOperation;
     out theStoreInfo: Tm3StoreInfo): Boolean;
   function IsValidOpenMode(aMode: Integer): Boolean; virtual;
   function IsValidCreateMode(aMode: Integer): Boolean;
   procedure RemoveElementByName(aName: Tl3_String;
     const aStoreInfo: Tm3StoreInfo);
   procedure RemoveElementByTOCIndex(anIndex: Integer);
   function CreateOpenStoreByName(const aStoreInfo: Tm3StoreInfo;
     anAccess: Tm3StoreAccess;
     aName: Tl3_String;
     aMode: Tm3StoreMode;
     aUseCompression: Boolean): Tm3Store; overload;  virtual;
   function CreateOpenStoreByName(const aStoreInfo: Tm3StorageElementInfo;
     anAccess: Tm3StoreAccess;
     aMode: Tm3StoreMode;
     aUseCompression: Boolean): Tm3Store; overload; 
   function CreateOpenStoreByIndex(const aStoreInfo: Tm3StoreInfo;
     anAccess: Tm3StoreAccess;
     anIndex: Tm3StoreElementIndex;
     aMode: Tm3StoreMode;
     aUseCompression: Boolean): Tm3Store;
   function SaveTableOfContentsPrim(const aStream: IStream): Int64;
 public
 // public methods
   constructor Create(anAccess: Tm3StoreAccess;
     aStoreHeader: Tm3StoreHeader;
     aIsRoot: Boolean); reintroduce;
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IStorage: IStorage;
 end;//Tm3CustomNewStorage

implementation

uses
  m3Const,
  l3String,
  SysUtils,
  Windows,
  m2COMLib,
  m3TOCHandle,
  l3Base,
  m3StorageTools,
  m3StorageIndexStreamForIterate,
  m3StorageIndexStream,
  m3StorageTableOfContentsStream,
  m3ReadOnlyRootStreamManager,
  m3NewRootStreamManager,
  m3Exceptions,
  m3NewStorageStream,
  ComObj,
  m2S64Lib
  ;

const
   { Names }
  cPseudoRootName : WideString = ':ROOT:';

type
  Tm3StoreHeaderDataPrimHack = {abstract} class(Tm3StoreHeaderDataPrim)
  end;//Tm3StoreHeaderDataPrimHack

// start class Tm3CustomNewStorage

function Tm3CustomNewStorage.FindItemByIndex(anIndex: Tm3StoreElementIndex;
  aStoreType: Tm3StoreType;
  anOp: Tm3StoreOperation;
  out thePosition: Int64;
  theStoreType: Pm3StoreType = nil): Boolean;
//#UC START# *5451116E01AE_5451095F00E9_var*
var
 l_Stream     : IStream;
 l_Info       : Tm3StoreInfo;
 l_MajorIndex : LongInt;
 l_Step       : Byte;
 l_StreamSize : Int64;
 l_FillIndex  : Integer;
 l_RecordSize : Integer;
 l_NeedCorrect : Boolean;
 l_Access      : Integer;
 l_CountToFill : Integer;
//#UC END# *5451116E01AE_5451095F00E9_var*
begin
//#UC START# *5451116E01AE_5451095F00E9_impl*
 Result := false;
 Assert(anIndex >= 0);
 if (anOp = m3_soOpen) then
  l_Access := m3_saRead
 else
  l_Access := Self.Access;
 thePosition := High(thePosition);
 CheckIndexStream(anOp = m3_soCreate, false);
 if (f_IndexStream <> nil) then
 begin
  l_Step := Pred(f_IndexInfo.rMaxBits div f_IndexInfo.rBits);
  l_Stream := f_IndexStream;
  try
   while true do
   begin
    l_RecordSize := SizeOf(Int64);
    if (l_Step = 0) then
     Inc(l_RecordSize, SizeOf(Tm3StoreType));
    l_MajorIndex := (anIndex shr (f_IndexInfo.rMaxBits - f_IndexInfo.rBits)) * l_RecordSize;
    anIndex := anIndex shl f_IndexInfo.rBits;
    l_StreamSize := m2COMGetSize(l_Stream);
    if (l_MajorIndex >= l_StreamSize) then
    begin
     if (anOp = m3_soCreate) then
     begin
      // - надо расширить коробку
      l_Info.rPosition := -1;
      l_Info.rStoreType := m3_stNone; // - в общем это все равно
      m2COMSetPosition(l_StreamSize, l_Stream);
      l_CountToFill := ((l_MajorIndex - l_StreamSize) div l_RecordSize);

      if (Header.RootStreamManager.Logger <> nil) then
       Header.RootStreamManager.Logger.ToLog('Расширяем индексный поток на ' + IntToStr(l_CountToFill + 1) + ' элементов');
       
      for l_FillIndex := 0 to l_CountToFill do
      begin
       // - заполняем нераспределенные элементы
       m2COMWriteBufferSafe(l_Stream, l_Info, l_RecordSize);
       Assert(l_Info.rPosition = -1);
      end;//for l_FillIndex
     end//anOp = m3_soCreate
     else
      Exit;
    end;//l_MajorIndex >= m2COMGetSize(l_Stream)
    m2COMSetPosition(l_MajorIndex, l_Stream);
    m2COMReadBuffer(l_Stream, l_Info, l_RecordSize);
    if not Header.RootStreamManager.IsValidPosition(l_Info.rPosition, Header.Name) OR
       ((l_Step = 0) AND (l_Info.rStoreType = m3_stNone)) OR

       ((l_Step > 0) AND (l_Info.rPosition = 0) AND (l_Info.rStoreType = m3_stNone))
       // - пытаемся обработать ситуацию, когда почему-то создался пустой каталог документа с пустой позицией и пустым типом
       //   и в итоге Архивариус зависал на сохранении такого "битого" документа 
       // Чинил Люлин А. В. 30 мая 2012 года от Рождества Христова
       then
    begin
     if (l_Info.rPosition = Int64(-1)) then
      l_NeedCorrect := false
     else
     begin
      l3System.Msg2Log('Неправильная позиция элемента каталога: ' +
                       IntToStr(anIndex) + ' -> ' +
                       IntToStr(l_Info.rPosition));
      l_NeedCorrect := true;
     end;//l_Info.rPosition = Int64(-1)
     if (anOp = m3_soCreate) then
     begin
      // - распределяем еще один поток
      l_Info.rPosition := Header.RootStreamManager.AllocNewFATElement;
      if (l_Info.rPosition = 0) then
       l3System.Msg2Log('Распределён блок с нулевым адресом');
      m2COMSetPosition(l_MajorIndex, l_Stream);
      l_Info.rStoreType := aStoreType;
      Assert(aStoreType <> m3_stNone);
      m2COMWriteBufferSafe(l_Stream, l_Info, l_RecordSize);
      Assert(l_Info.rStoreType <> m3_stNone);
      if l_NeedCorrect then
       l3System.Msg2Log('Была исправлена на: ' +
                        IntToStr(l_Info.rPosition));
     end//anOp = m3_soCreate
     else
      Exit;
    end;//not Header.FRootStreamManager.IsValidPosition(l_Info.rPosition)
    if (l_Step = 0) then
    begin
     if (l_Info.rStoreType = aStoreType) OR (theStoreType <> nil) then
     begin
      if (theStoreType <> nil) then
       theStoreType^ := l_Info.rStoreType;
      thePosition := l_Info.rPosition;
      if (anOp = m3_soDelete) then
      begin
       // - надо удалить информацию об элементе
       l_Info.rPosition := -1;
       l_Info.rStoreType := m3_stNone; // - в общем это все равно
       m2COMSetPosition(l_MajorIndex, l_Stream);
       m2COMWriteBufferSafe(l_Stream, l_Info, l_RecordSize);
      end;//anOp = m3_soDelete
      Result := true;
     end;//l_Info.rStoreType = aStoreType..
     Exit;
    end//l_Step = 0
    else
    begin
     l_Stream := nil;
     l_Stream := Tm3StorageIndexStream.Make(l_Access,
                                            l_Step,
                                            Self,
                                            l_Info.rPosition);
     Dec(l_Step);
    end;//l_Step = 0
   end;//while true
  finally
   l_Stream := nil;
  end;//try..finally
 end;//f_IndexStream <> nil
//#UC END# *5451116E01AE_5451095F00E9_impl*
end;//Tm3CustomNewStorage.FindItemByIndex

function Tm3CustomNewStorage.FindItemByName(const aName: Tl3WString;
  anOp: Tm3StoreOperation;
  out theStoreInfo: Tm3StoreInfo): Boolean;
//#UC START# *5451121F001E_5451095F00E9_var*
var
 l_Index : LongInt;
//#UC END# *5451121F001E_5451095F00E9_var*
begin
//#UC START# *5451121F001E_5451095F00E9_impl*
 Result := IsValidName(aName, l_Index) AND
           FindItemByIndex(l_Index, m3_stNone, anOp, theStoreInfo.rPosition, @theStoreInfo.rStoreType);
//#UC END# *5451121F001E_5451095F00E9_impl*
end;//Tm3CustomNewStorage.FindItemByName

function Tm3CustomNewStorage.IsValidOpenMode(aMode: Integer): Boolean;
//#UC START# *545112B30162_5451095F00E9_var*
const
 CAccess = [STGM_READ,
            STGM_READWRITE];

 CSharing = [STGM_SHARE_EXCLUSIVE];

 CFlags = STGM_DIRECT;
//#UC END# *545112B30162_5451095F00E9_var*
begin
//#UC START# *545112B30162_5451095F00E9_impl*
 Result := (Byte(m2COMModeAccess(aMode)) in CAccess);
 Result := Result and (Byte(m2COMModeSharing(aMode)) in CSharing);
 Result := Result and ((m2COMModeFlags(aMode) and not(CFlags)) = 0);
//#UC END# *545112B30162_5451095F00E9_impl*
end;//Tm3CustomNewStorage.IsValidOpenMode

function Tm3CustomNewStorage.IsValidCreateMode(aMode: Integer): Boolean;
//#UC START# *545112EF01E1_5451095F00E9_var*
const
 CAccess = [STGM_READWRITE];

 CSharing = [STGM_SHARE_EXCLUSIVE];

 CFlags = STGM_CREATE or
          STGM_FAILIFTHERE or
          STGM_DIRECT;
//#UC END# *545112EF01E1_5451095F00E9_var*
begin
//#UC START# *545112EF01E1_5451095F00E9_impl*
 Result := (Byte(m2COMModeAccess(aMode)) in CAccess);
 Result := Result and (Byte(m2COMModeSharing(aMode)) in CSharing);
 Result := Result and ((m2COMModeFlags(aMode) and not(CFlags)) = 0);
//#UC END# *545112EF01E1_5451095F00E9_impl*
end;//Tm3CustomNewStorage.IsValidCreateMode

procedure Tm3CustomNewStorage.RemoveElementByName(aName: Tl3_String;
  const aStoreInfo: Tm3StoreInfo);
//#UC START# *545113AB00C0_5451095F00E9_var*

 procedure DoRemove;
 var
  l_St : Im3IndexedStorage;
  l_S  : IStream;
 begin//DoRemove
  case aStoreInfo.rStoreType of
   m3_stStorage:
   begin
    try
     l_St := SubStorageClass.Make(Self.Access,
                                  aName,
                                  Header.RootStreamManager,
                                  aStoreInfo.rPosition);
    except
     on Em3InvalidStoreData do
      l_St := nil;
    end;//try..except
    if (l_St <> nil) then
     l_St.ClearAll;
    l_St := nil;
   end;//m3_stStorage
   m3_stStream:
   begin
    try
     l_S := Tm3NewStorageStream.Make(Self.Access,
                                     aName,
                                     Header.RootStreamManager,
                                     aStoreInfo.rPosition);
    except
     on Em3InvalidStoreData do
      l_S := nil;
    end;//try..except
    if (l_S <> nil) then
     m2COMDestroyData(l_S);
    l_S := nil;
   end;//m3_stStream
   else
    OleError(E_UNEXPECTED);
  end;//case aStoreType
 end;//DoRemove

//#UC END# *545113AB00C0_5451095F00E9_var*
begin
//#UC START# *545113AB00C0_5451095F00E9_impl*
 Assert(not Self.ReadOnly);
 DoRemove;
 Header.RootStreamManager.RemoveFATElementAtPos(aStoreInfo.rPosition);
//#UC END# *545113AB00C0_5451095F00E9_impl*
end;//Tm3CustomNewStorage.RemoveElementByName

procedure Tm3CustomNewStorage.RemoveElementByTOCIndex(anIndex: Integer);
//#UC START# *5451140501FA_5451095F00E9_var*
var
 l_H : Tm3TOCHandle;
//#UC END# *5451140501FA_5451095F00E9_var*
begin
//#UC START# *5451140501FA_5451095F00E9_impl*
 l_H := Tm3TOCHandle(f_TableOfContents.Items[anIndex]);
 RemoveElementByName(l_H.HandleName, l_H.StoreInfo);
 f_TableOfContents.Delete(anIndex);
 f_TableOfContents.Modified := True;
//#UC END# *5451140501FA_5451095F00E9_impl*
end;//Tm3CustomNewStorage.RemoveElementByTOCIndex

function Tm3CustomNewStorage.CreateOpenStoreByName(const aStoreInfo: Tm3StoreInfo;
  anAccess: Tm3StoreAccess;
  aName: Tl3_String;
  aMode: Tm3StoreMode;
  aUseCompression: Boolean): Tm3Store;
//#UC START# *545119B000EE_5451095F00E9_var*
//#UC END# *545119B000EE_5451095F00E9_var*
begin
//#UC START# *545119B000EE_5451095F00E9_impl*
 if (aMode = m3_smCreate) then
  anAccess := m2COMModeAccess(anAccess or STGM_CREATE)
 else
  anAccess := m2COMModeAccess(anAccess);
 Case aStoreInfo.rStoreType of
  m3_stStream:
   Result := Tm3Store_C(Tm3NewStorageStream.Make(anAccess,
                                      aName,
                                      Header.RootStreamManager,
                                      aStoreInfo.rPosition));
  m3_stStorage:
   Result := Tm3Store_C(SubStorageClass.Make(anAccess,
                                  aName,
                                  Header.RootStreamManager,
                                  aStoreInfo.rPosition));
  else
  begin
   Assert(false);
   Result := Tm3Store_E;
  end;//else
 end;//Case aStoreType
//#UC END# *545119B000EE_5451095F00E9_impl*
end;//Tm3CustomNewStorage.CreateOpenStoreByName

function Tm3CustomNewStorage.CreateOpenStoreByName(const aStoreInfo: Tm3StorageElementInfo;
  anAccess: Tm3StoreAccess;
  aMode: Tm3StoreMode;
  aUseCompression: Boolean): Tm3Store;
//#UC START# *54511A30020D_5451095F00E9_var*
var
 l_Name : Tl3_String;
//#UC END# *54511A30020D_5451095F00E9_var*
begin
//#UC START# *54511A30020D_5451095F00E9_impl*
 l_Name := Tl3_String.Make(aStoreInfo.rName);
 try
  Result := CreateOpenStoreByName(aStoreInfo.rInfo, anAccess, l_Name, aMode, aUseCompression);
 finally
  FreeAndNil(l_Name);
 end;//try..finally
//#UC END# *54511A30020D_5451095F00E9_impl*
end;//Tm3CustomNewStorage.CreateOpenStoreByName

function Tm3CustomNewStorage.CreateOpenStoreByIndex(const aStoreInfo: Tm3StoreInfo;
  anAccess: Tm3StoreAccess;
  anIndex: Tm3StoreElementIndex;
  aMode: Tm3StoreMode;
  aUseCompression: Boolean): Tm3Store;
//#UC START# *54511A6901FF_5451095F00E9_var*
const
 cFormatString = m3IndexPrefixFormatStr;
//#UC END# *54511A6901FF_5451095F00E9_var*
begin
//#UC START# *54511A6901FF_5451095F00E9_impl*
 Result := CreateOpenStoreByName(Tm3StorageElementInfo_C(aStoreInfo, l3PCharLen(WideString(Format(cFormatString, [anIndex])))),
                           anAccess,
                           aMode,
                           aUseCompression)
//#UC END# *54511A6901FF_5451095F00E9_impl*
end;//Tm3CustomNewStorage.CreateOpenStoreByIndex

function Tm3CustomNewStorage.SaveTableOfContentsPrim(const aStream: IStream): Int64;
//#UC START# *5451D88D0097_5451095F00E9_var*
//#UC END# *5451D88D0097_5451095F00E9_var*
begin
//#UC START# *5451D88D0097_5451095F00E9_impl*
 Assert(not Self.ReadOnly);
 Assert(Header <> nil);
 Assert(f_TableOfContents <> nil);
 f_TableOfContents.Modified := false;
 Result := f_TableOfContents.SaveToStream(aStream);
 Assert((Header.TOCListPosition = Result) OR (Result = -1));
 Assert(m2COMGetSize(aStream) >= Header.TOCListPosition);
//#UC END# *5451D88D0097_5451095F00E9_impl*
end;//Tm3CustomNewStorage.SaveTableOfContentsPrim

constructor Tm3CustomNewStorage.Create(anAccess: Tm3StoreAccess;
  aStoreHeader: Tm3StoreHeader;
  aIsRoot: Boolean);
//#UC START# *5451E49C023B_5451095F00E9_var*
var
 l_NeedLoadTOC : Boolean;                                 
//#UC END# *5451E49C023B_5451095F00E9_var*
begin
//#UC START# *5451E49C023B_5451095F00E9_impl*
 inherited Create(anAccess, aStoreHeader);
(*
 Этот кусок был написан Люлиным А. В. для спасения тверских данных из побитой базы
 Хорошо бы разобраться зачем вообще хранятся данные, которые можно заменить константами

 if (f_StorageHeader.ftocitemdata^.rNextPosition > High(Longint)) then
 begin
  f_StorageHeader.ftocitemdata^.rNextPosition := Int64(-1);
  f_StorageHeader.ftocitemdata^.RTOCBuffRootPosition := 516;
  f_StorageHeader.ftocitemdata^.RTOCItemListPosition := 10;
  f_StorageHeader.ftocitemdata^.RRealSize := 140;
 end;
*)
 l_NeedLoadTOC := true;
 if aIsRoot then
 begin
  if not Self.ReadOnly then
   if (Header.TOCListPosition = -1) then
   begin
    Assert(Header.RootStreamManager.AllocatedStreamSize <= Tm3StoreHeaderDataPrimHack(Header.HeaderData).DataSize * 22, 'Нельзя переинициализировать непустое корневое хранилище');
    // - 22 - это "магическое число" элементов FAT, которые распределяются в Tm3RootStreamManagerPrimPrim.AllocNewFATElement
    Assert(Header.HeaderData.rRealSize = 0, 'Нельзя переинициализировать непустое корневое хранилище');
    Assert(Header.HeaderData.FirstCluster = -1, 'Нельзя переинициализировать непустое корневое хранилище');
    CheckIndexStream(true, false);
    Assert(Header.TOCListPosition >= 0);
    Assert(f_IndexInfo.rPosition >= 0);
    l_NeedLoadTOC := false;
   end;//Header.TOCListPosition = -1
  f_CanAllocateIndex := false;
 end;//aIsRoot
 if l_NeedLoadTOC then
  LoadTableOfContents;
 // - грузим оглавление
//#UC END# *5451E49C023B_5451095F00E9_impl*
end;//Tm3CustomNewStorage.Create

function Tm3CustomNewStorage.SetIndexParam(aBits: byte;
  aMaxBits: byte): Boolean;
//#UC START# *4720939E0233_5451095F00E9_var*
//#UC END# *4720939E0233_5451095F00E9_var*
begin
//#UC START# *4720939E0233_5451095F00E9_impl*
 if (f_IndexStream = nil) then
 begin
  f_IndexInfo.rBits := aBits;
  f_IndexInfo.rMaxBits := aMaxBits;
  Result := true;
 end//f_IndexStream = nil
 else
  Result := false;
//#UC END# *4720939E0233_5451095F00E9_impl*
end;//Tm3CustomNewStorage.SetIndexParam

function Tm3CustomNewStorage.DeleteStore(anIndex: Tm3StoreElementIndex): hResult;
//#UC START# *472093CD005A_5451095F00E9_var*
const
 cFormatString = m3IndexPrefixFormatStr;
var
 l_Position  : Int64;
 l_StoreType : Tm3StoreType;
 l_Name      : Tl3_String;
//#UC END# *472093CD005A_5451095F00E9_var*
begin
//#UC START# *472093CD005A_5451095F00E9_impl*
 Assert(anIndex >= 0);
 Result := S_Ok;
 Lock;
 try
  if FindItemByIndex(anIndex, m3_stNone, m3_soDelete, l_Position, @l_StoreType) then
  begin
   l_Name := Tl3_String.Make(l3PCharLen(Format(cFormatString, [anIndex])));
   try
    RemoveElementByName(l_Name, Tm3StoreInfo_C(l_Position, l_StoreType));
   finally
    FreeAndNil(l_Name);
   end;//try..finally
  end//FindItemByIndex(anIndex, m3_stNone, m3_soDelete, l_Position, @l_StoreType)
  else
   Result := STG_E_FILENOTFOUND;
 finally
  Unlock;
 end;//try..finally
//#UC END# *472093CD005A_5451095F00E9_impl*
end;//Tm3CustomNewStorage.DeleteStore

function Tm3CustomNewStorage.CreateStore(anIndex: Tm3StoreElementIndex;
  anAccess: Tm3StoreAccess;
  aStoreType: Tm3StoreType;
  out aStore: Tm3Store;
  aUseCompression: Boolean): hResult;
//#UC START# *472093E4036B_5451095F00E9_var*
var
 l_StorePosition : Int64;
//#UC END# *472093E4036B_5451095F00E9_var*
begin
//#UC START# *472093E4036B_5451095F00E9_impl*
 Assert(anIndex >= 0);
 Result := S_Ok;
 if IsValidCreateMode(anAccess) then
 begin
  Lock;
  try
   if FindItemByIndex(anIndex, aStoreType, m3_soOpen, l_StorePosition) then
    Result := STG_E_FILEALREADYEXISTS
   else
   begin
    if FindItemByIndex(anIndex, aStoreType, m3_soCreate, l_StorePosition) then
     aStore := CreateOpenStoreByIndex(Tm3StoreInfo_C(l_StorePosition, aStoreType),
                               anAccess,
                               anIndex, m3_smCreate, aUseCompression)
    else
     Result := E_UNEXPECTED;
   end;//FindItem
  finally
   Unlock;
  end;//try..finally
 end//__IsValidCreateMode(anAccess)
 else
  Result := STG_E_INVALIDFLAG;
//#UC END# *472093E4036B_5451095F00E9_impl*
end;//Tm3CustomNewStorage.CreateStore

function Tm3CustomNewStorage.OpenStore(anIndex: Tm3StoreElementIndex;
  anAccess: Tm3StoreAccess;
  aStoreType: Tm3StoreType;
  out aStore: Tm3Store;
  aUseCompression: Boolean): hResult;
//#UC START# *472094380181_5451095F00E9_var*
var
 l_StorePosition : Int64;
//#UC END# *472094380181_5451095F00E9_var*
begin
//#UC START# *472094380181_5451095F00E9_impl*
 Assert(anIndex >= 0);
 Result := S_Ok;
 if IsValidOpenMode(anAccess) then
 begin
  Lock;
  try
   if FindItemByIndex(anIndex, aStoreType, m3_soOpen, l_StorePosition) then
    aStore := CreateOpenStoreByIndex(Tm3StoreInfo_C(l_StorePosition, aStoreType),
                              anAccess,
                              anIndex, m3_smOpen, aUseCompression)
   else
    Result := STG_E_FILENOTFOUND;
  finally
   Unlock;
  end;//try..finally
 end
 else
  Result := STG_E_INVALIDFLAG;
//#UC END# *472094380181_5451095F00E9_impl*
end;//Tm3CustomNewStorage.OpenStore

function Tm3CustomNewStorage.CreateStore(const aName: Tl3WString;
  anAccess: Tm3StoreAccess;
  aStoreType: Tm3StoreType;
  out aStore: Tm3Store;
  aUseCompression: Boolean): hResult;
//#UC START# *47209BA50026_5451095F00E9_var*
var
 l_TOCIndex  : Integer;
 l_DocIndex  : Integer;
 l_TOCHandle : Tm3TOCHandle;
//#UC END# *47209BA50026_5451095F00E9_var*
begin
//#UC START# *47209BA50026_5451095F00E9_impl*
 Result := S_Ok;
 if IsValidName(AName) then
 begin
  if IsValidCreateMode(anAccess) then
  begin
   Lock;
   try
    //with f_TableOfContents do
    begin
     if f_TableOfContents.FindItemByKey(aName, l_TOCIndex) then
      Result := STG_E_FILEALREADYEXISTS
     else 
     begin
      if IsValidName(aName, l_DocIndex) then
       Result := CreateStore(l_DocIndex, anAccess, aStoreType, aStore, aUseCompression)
      else
      begin
       l_TOCHandle := Tm3TOCHandle.CreateNew(Header.RootStreamManager, aName, aStoreType);
       try
        f_TableOfContents.Insert(l_TOCIndex, l_TOCHandle);
        f_TableOfContents.Modified := true;
        //with l_TOCHandle do
         aStore := CreateOpenStoreByName(l_TOCHandle.StoreInfo,
                                         anAccess,
                                         l_TOCHandle.HandleName,
                                         m3_smCreate,
                                         aUseCompression);
       finally
        FreeAndNil(l_TOCHandle);
       end;//try..finally
      end;//IsValidName(aName, l_Index)
     end;//FindTOCItem(aName, l_Index)
    end;//with f_TableOfContents
   finally
    Unlock;
   end;//try..finally
  end//__IsValidCreateMode(anAccess)
  else
   Result := STG_E_INVALIDFLAG;
 end else
  Result := STG_E_INVALIDNAME;
//#UC END# *47209BA50026_5451095F00E9_impl*
end;//Tm3CustomNewStorage.CreateStore

function Tm3CustomNewStorage.OpenStore(const aName: Tl3WString;
  anAccess: Tm3StoreAccess;
  aStoreType: Tm3StoreType;
  out aStore: Tm3Store;
  aUseCompression: Boolean): hResult;
//#UC START# *47209BD8008D_5451095F00E9_var*
var
 l_Index : Integer;
 l_Mode  : Tm3StoreMode;
//#UC END# *47209BD8008D_5451095F00E9_var*
begin
//#UC START# *47209BD8008D_5451095F00E9_impl*
 Result := S_Ok;
 if IsValidName(aName) then
 begin
  if IsValidOpenMode(anAccess) then
  begin
   Lock;
   try
    //with f_TableOfContents do
    begin
     if f_TableOfContents.FindItemByKey(AName, l_Index) then
     begin
      with f_TableOfContents.Items[l_Index] do
      begin
       if (StoreInfo.rStoreType = aStoreType) then
       begin
        if (anAccess = m3_saCreate) then
         l_Mode := m3_smCreate
        else
         l_Mode := m3_smOpen;
        aStore := CreateOpenStoreByName(StoreInfo,
                                        anAccess,
                                        HandleName,
                                        l_Mode,
                                        aUseCompression);
        Exit;
       end;//HandleType = aStoreType
      end;//with Items[l_Index]
     end;//FindTOCItem..
     if IsValidName(aName, l_Index) then
      Result := OpenStore(l_Index, anAccess, aStoreType, aStore, aUseCompression)
     else
      Result := STG_E_FILENOTFOUND;
    end;//with f_TableOfContents
   finally
    Unlock;
   end;//try..finally
  end else
   Result := STG_E_INVALIDFLAG;
 end else
   Result := STG_E_INVALIDNAME;
//#UC END# *47209BD8008D_5451095F00E9_impl*
end;//Tm3CustomNewStorage.OpenStore

function Tm3CustomNewStorage.OpenStore(const aStoreInfo: Tm3StorageElementInfo;
  anAccess: Tm3StoreAccess;
  aUseCompression: Boolean): Tm3Store;
//#UC START# *47209BF501C5_5451095F00E9_var*
//#UC END# *47209BF501C5_5451095F00E9_var*
begin
//#UC START# *47209BF501C5_5451095F00E9_impl*
 Result := CreateOpenStoreByName(aStoreInfo, anAccess, m3_smOpen, aUseCompression);
//#UC END# *47209BF501C5_5451095F00E9_impl*
end;//Tm3CustomNewStorage.OpenStore

function Tm3CustomNewStorage.OpenStore(const aStoreInfo: Tm3StoreInfo;
  anAccess: Tm3StoreAccess;
  anIndex: Tm3StoreElementIndex;
  aUseCompression: Boolean): Tm3Store;
//#UC START# *47209C92017B_5451095F00E9_var*
//#UC END# *47209C92017B_5451095F00E9_var*
begin
//#UC START# *47209C92017B_5451095F00E9_impl*
 Result := CreateOpenStoreByIndex(aStoreInfo, anAccess, anIndex, m3_smOpen, aUseCompression);
//#UC END# *47209C92017B_5451095F00E9_impl*
end;//Tm3CustomNewStorage.OpenStore

function Tm3CustomNewStorage.RenameElementA(const aOldName: Tl3WString;
  const aNewName: Tl3WString): hResult;
//#UC START# *49C0E07203A8_5451095F00E9_var*
//#UC END# *49C0E07203A8_5451095F00E9_var*
begin
//#UC START# *49C0E07203A8_5451095F00E9_impl*
 Result := S_Ok;
 RenameElement(aOldName, aNewName, Result);
//#UC END# *49C0E07203A8_5451095F00E9_impl*
end;//Tm3CustomNewStorage.RenameElementA

function Tm3CustomNewStorage.ElementExists(const aName: Tl3WString): Boolean;
//#UC START# *4B0FC2FB02DA_5451095F00E9_var*
var
 l_Index : Integer;
 l_StoreInfo : Tm3StoreInfo;
//#UC END# *4B0FC2FB02DA_5451095F00E9_var*
begin
//#UC START# *4B0FC2FB02DA_5451095F00E9_impl*
 Result := f_TableOfContents.FindItemByKey(aName, l_Index);
 if not Result then
  if FindItemByName(aName, m3_soOpen, l_StoreInfo) then
   Result := true;
//#UC END# *4B0FC2FB02DA_5451095F00E9_impl*
end;//Tm3CustomNewStorage.ElementExists

procedure Tm3CustomNewStorage.CheckIndexStream(aNeedCreate: Boolean;
  aForIterate: Boolean);
//#UC START# *5421776B00F3_5451095F00E9_var*
var
 l_Stream : IStream;
 l_SizeToRead : Integer;
 l_ReadSize   : Integer;
 l_IndexInfo : Tm3IndexInfo;
//#UC END# *5421776B00F3_5451095F00E9_var*
begin
//#UC START# *5421776B00F3_5451095F00E9_impl*
 if Self.ReadOnly then
  if aNeedCreate then
   aNeedCreate := false;
 Lock;
 try
  if (f_IndexStream = nil) then
  begin
   if (Header.TOCListPosition > 0) then
   begin
    Assert(f_IndexInfo.rPosition = -1, 'Позицию индексного потока уже читали, но почему-то не создали индексный поток');
    Assert(Header.HeaderData.rRealSize > 0, 'Должно быть что-то записано');
    Assert(Header.HeaderData.FirstCluster >= 0, 'Должно быть что-то записано');
    l_Stream := Tm3StorageTableOfContentsStream.Make(m3_saRead, Header);
    try
     Assert(SizeOf(f_IndexInfo) <= Header.TOCListPosition, 'Похоже, что в информации о хранилище не писали информацию об индексной части. Header.TOCListPosition = ' + IntToStr(Header.TOCListPosition));
     l3FillChar(l_IndexInfo, 0); 
     l_SizeToRead := m2S64Min(SizeOf(f_IndexInfo), Header.TOCListPosition);
     l_ReadSize := m2COMReadBuffer(l_Stream, l_IndexInfo, l_SizeToRead);
     Assert(l_ReadSize = l_SizeToRead, 'Не удалось считать информацию об индексной части. SizeToRead = ' + IntToStr(l_SizeToRead) + ' ReadSize = ' + IntToStr(l_ReadSize));
     f_IndexInfo := l_IndexInfo; 
    finally
     l_Stream := nil;
    end;//try..finally
    // Header.TOCListPosition = SizeOf(Tm3IndexInfo)
   end;//Header.TOCListPosition > 0
   if (f_IndexInfo.rPosition = Int64(-1)) then
   begin
    if aNeedCreate then
    // - распределяем поток под хранение индекса
    begin
     Assert(f_CanAllocateIndex, 'Наверное кто-то пытается перезаписать индекс рутового потока');
     f_IndexInfo.rPosition := Header.RootStreamManager.AllocNewFATElement;
     if (f_IndexInfo.rPosition = Int64(-1)) then
      Exit;
     //FTOCHandleListModifed := true;
     // - иначе оглавление не сохраняется куда надо (после индекса, насколько я понял)
     // !!! это можно уже убрать, т.к. используем сразу SaveTableOfContentsPrim
    
     Header.TOCListPosition := SizeOf(Tm3IndexInfo);
     l_Stream := Tm3StorageTableOfContentsStream.Make(Self.Access, Header);
     try
      m2COMWriteBufferSafe(l_Stream, f_IndexInfo, SizeOf(f_IndexInfo));
      if (f_TableOfContents <> nil) then
       SaveTableOfContentsPrim(l_Stream);
       // - записываем оглавление, за индексом
     finally
      l_Stream := nil;
     end;//try..finally

     if (Header.RootStreamManager.Logger <> nil) then
      Header.RootStreamManager.Logger.ToLog('Записана новая позиция индекса: ' + IntToStr(f_IndexInfo.rPosition) + ' имя хранилища: ' + Header.Name.AsString);
    end// NeedCreate
    else
     Exit;
   end;//f_IndexInfo.rPosition = Int64(-1)
   if aForIterate then
    f_IndexStream := Tm3StorageIndexStreamForIterate.Make(Self.Access,
                                               0,
                                               Self,
                                               f_IndexInfo.rPosition)
   else
    f_IndexStream := Tm3StorageIndexStream.Make(Self.Access,
                                                0,
                                                Self,
                                                f_IndexInfo.rPosition);
    // - а это уже честный индексный поток
  end;//f_IndexStream = nil
 finally
  Unlock;
 end;//try..finally
//#UC END# *5421776B00F3_5451095F00E9_impl*
end;//Tm3CustomNewStorage.CheckIndexStream

class function Tm3CustomNewStorage.Make(anAccess: Tm3StoreAccess;
  aName: Tl3_String;
  aManager: Tm3RootStreamManagerPrim;
  aPosition: Int64): Im3IndexedStorage;
//#UC START# *5422B23D0352_5451095F00E9_var*
var
 l_Header : Tm3StoreHeader;
 l_S      : Tm3CustomNewStorage;
//#UC END# *5422B23D0352_5451095F00E9_var*
begin
//#UC START# *5422B23D0352_5451095F00E9_impl*
 l_Header := Tm3StoreHeader.Create(anAccess,
                                   aName,
                                   aManager,
                                   aPosition);
 try
  l_S := Create(anAccess, l_Header, false);
  try
   Result := l_S;
  finally
   FreeAndNil(l_S);
  end;//try..finally
 finally
  FreeAndNil(l_Header);
 end;//try..finally
//#UC END# *5422B23D0352_5451095F00E9_impl*
end;//Tm3CustomNewStorage.Make

procedure Tm3CustomNewStorage.DoSaveTableOfContents;
//#UC START# *5422B9FA01C5_5451095F00E9_var*
var
 l_Stream : IStream;
 l_NewPos : Int64;
//#UC END# *5422B9FA01C5_5451095F00E9_var*
begin
//#UC START# *5422B9FA01C5_5451095F00E9_impl*
 l_Stream := Tm3StorageTableOfContentsStream.Make(Self.Access, Header);
 try
  if (Header.TOCListPosition = Int64(-1)) then
   Header.TOCListPosition := 0;
  m2COMSetPosition(Header.TOCListPosition, l_Stream);
  l_NewPos := SaveTableOfContentsPrim(l_Stream);
 finally
  l_Stream := nil;
 end;//try..finally
 if (Header.RootStreamManager.Logger <> nil) then
  Header.RootStreamManager.Logger.ToLog('Записано оглавление. Позиция: ' + IntToStr(Header.TOCListPosition) + '/' + IntToStr(l_NewPos) + ' имя хранилища: ' + Header.Name.AsString);
//#UC END# *5422B9FA01C5_5451095F00E9_impl*
end;//Tm3CustomNewStorage.DoSaveTableOfContents

procedure Tm3CustomNewStorage.DoLoadTableOfContents;
//#UC START# *5422CF790072_5451095F00E9_var*
//#UC END# *5422CF790072_5451095F00E9_var*
begin
//#UC START# *5422CF790072_5451095F00E9_impl*
 f_TableOfContents.LoadFromStream(Tm3StorageTableOfContentsStream.Make(m3_saRead, Header),
                              Header.TOCListPosition);
//#UC END# *5422CF790072_5451095F00E9_impl*
end;//Tm3CustomNewStorage.DoLoadTableOfContents

class function Tm3CustomNewStorage.OpenRoot(anAccess: Tm3StoreAccess;
  const aStream: IStream;
  out theManager: Tm3RootStreamManagerPrim): Im3IndexedStorage;
//#UC START# *5425558F008E_5451095F00E9_var*
var
 l_Name : Tl3String;
 l_RM   : Tm3NewRootStreamManager;
 l_Header : Tm3StoreHeader;
 l_S      : Tm3CustomNewStorage;
 l_M      : Tm3RootStreamManagerPrim;
//#UC END# *5425558F008E_5451095F00E9_var*
begin
//#UC START# *5425558F008E_5451095F00E9_impl*
 Assert(theManager = nil);
 Assert(aStream <> nil);
 l_RM := Tm3NewRootStreamManager.Make(aStream);
 try
  if (anAccess = STGM_READ) then
   l_M := Tm3ReadOnlyRootStreamManager.Create(l_RM)
  else
   l_M := l_RM.Use;
  try
   l_Name := Tl3String.Make(l3PCharLen(cPseudoRootName));
   try
    l_Header := Tm3StoreHeader.Create(anAccess,
                                      l_Name,
                                      l_M,
                                      l_M.RootStorageFATElement);
    try
     Assert((l_Header.TOCListPosition >= -1), 'Хранилище возможно разрушено');
     l_S := Create(anAccess, l_Header, true);
     try
      Result := l_S;
     finally
      FreeAndNil(l_S);
     end;//try..finally
    finally
     FreeAndNil(l_Header);
    end;//try..finally
   finally
    l3Free(l_Name);
   end;//try..finally
  finally
   FreeAndNil(l_M);
  end;//try..finally
  l_RM.SetRefTo(theManager);
 finally
  FreeAndNil(l_RM);
 end;//try..finally
//#UC END# *5425558F008E_5451095F00E9_impl*
end;//Tm3CustomNewStorage.OpenRoot

class function Tm3CustomNewStorage.OpenFromManager(anAccess: Tm3StoreAccess;
  aManager: Tm3RootStreamManagerPrim): Im3IndexedStorage;
//#UC START# *542E82E10073_5451095F00E9_var*
var
 l_Name : Tl3String;
 l_Header : Tm3StoreHeader;
 l_S      : Tm3CustomNewStorage;
 l_M      : Tm3RootStreamManagerPrim;
//#UC END# *542E82E10073_5451095F00E9_var*
begin
//#UC START# *542E82E10073_5451095F00E9_impl*
 Assert((anAccess = STGM_READ) OR not aManager.ReadOnly, 'Нельзя открывать хранилище на запись, когда менеджер открыт только на чтение');
 if ((anAccess = STGM_READ) AND not aManager.ReadOnly) then
  l_M := Tm3ReadOnlyRootStreamManager.Create(aManager)
 else
  l_M := aManager.Use;
 try
  l_Name := Tl3String.Make(l3PCharLen(cPseudoRootName));
  try
   l_Header := Tm3StoreHeader.Create(anAccess,
                                     l_Name,
                                     l_M,
                                     l_M.RootStorageFATElement);
   try
    Assert({(anAccess = STGM_READ) OR }(l_Header.TOCListPosition >= 0), 'Хранилище из кеша не может быть неинициализированым');
    l_S := Create(anAccess, l_Header, true);
    try
     Result := l_S;
    finally
     FreeAndNil(l_S);
    end;//try..finally
   finally
    FreeAndNil(l_Header);
   end;//try..finally
  finally
   l3Free(l_Name);
  end;//try..finally
 finally
  FreeAndNil(l_M);
 end;//try..finally
//#UC END# *542E82E10073_5451095F00E9_impl*
end;//Tm3CustomNewStorage.OpenFromManager

procedure Tm3CustomNewStorage.ClearAll;
//#UC START# *545221EB010C_5451095F00E9_var*
//#UC END# *545221EB010C_5451095F00E9_var*
begin
//#UC START# *545221EB010C_5451095F00E9_impl*
 m2COMDestroyData(Self);
//#UC END# *545221EB010C_5451095F00E9_impl*
end;//Tm3CustomNewStorage.ClearAll

procedure Tm3CustomNewStorage.CopyFrom(const aSource: Im3IndexedStorage);
//#UC START# *5452222303C7_5451095F00E9_var*
//#UC END# *5452222303C7_5451095F00E9_var*
begin
//#UC START# *5452222303C7_5451095F00E9_impl*
 m2COMCopyData(Self, aSource.As_IStorage);
//#UC END# *5452222303C7_5451095F00E9_impl*
end;//Tm3CustomNewStorage.CopyFrom

{iterator} procedure Tm3CustomNewStorage.IterateIndexedF(anAction: Mm3StorageIterators_IterateIndexedF_Action);
//#UC START# *545255C003CB_5451095F00E9_var*

 function IterateStream(const aStream : IStream;
                        aStep         : Integer;
                        aMajor        : Integer): Boolean;
 var
  l_Info       : Tm3StoreInfo;
  l_RecordSize : Integer;
  l_Result     : hResult;
  l_Junior     : Integer;
  l_Stream     : IStream;
 begin//IterateStream
  Result := true;
  aMajor := aMajor shl f_IndexInfo.rBits;
  l_RecordSize := SizeOf(l_Info.rPosition);
  if (aStep = 0) then
   Inc(l_RecordSize, SizeOf(l_Info.rStoreType));
  l_Junior := 0;
  while true do
  begin
   l_Result := aStream.Read(@l_Info, l_RecordSize, nil);
   if l3IFail(l_Result) OR (l_Result = S_False) then
    break;
   if (l_Info.rPosition <> Int64(-1)) then
   begin
    if Header.RootStreamManager.IsValidPosition(l_Info.rPosition, Header.Name) then
    begin
     if (aStep = 0) then
     begin
      if not anAction(l_Info, aMajor or l_Junior) then
      begin
       Result := false;
       break;
      end;//not anAction
     end//aStep = 0
     else
     begin
      try
       l_Stream := Tm3StorageIndexStreamForIterate.Make(m3_saRead,
                                              aStep,
                                              Self,
                                              l_Info.rPosition);
      except
       on E: Exception do
       begin
        l3System.Exception2Log(E);
        Inc(l_Junior);
        continue;
       end;//on E: Exception
       else
        Assert(false, 'Сюда не должны попасть'); 
      end;//try..except
      try
       if not IterateStream(l_Stream, Pred(aStep), aMajor or l_Junior) then
       begin
        Result := false;
        break;
       end;//not anAction
      finally
       l_Stream := nil;
      end;//try..finally
     end;//aStep = 0
    end;//Header.FRootStreamManager.IsValidPosition
   end;//l_Info.rPosition <> Int64(-1)
   Inc(l_Junior);
  end;//while true
 end;//IterateStream

var
 Hack : Pointer absolute anAction;
//#UC END# *545255C003CB_5451095F00E9_var*
begin
//#UC START# *545255C003CB_5451095F00E9_impl*
 try
  Lock;
  try
   CheckIndexStream(false, true);
   if (f_IndexStream <> nil) then
   begin
    m2COMSetPosition(0, f_IndexStream);
    IterateStream(f_IndexStream, Pred(f_IndexInfo.rMaxBits div f_IndexInfo.rBits), 0);
   end;//f_IndexStream <> nil
  finally
   Unlock;
  end;//try..finally
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *545255C003CB_5451095F00E9_impl*
end;//Tm3CustomNewStorage.IterateIndexedF

{iterator} procedure Tm3CustomNewStorage.IterateAllF(anAction: Mm3StorageIterators_IterateAllF_Action);
//#UC START# *54525E3A02BF_5451095F00E9_var*

var
 l_Cont : Boolean;

type
  Pm3TOCHandle = ^Tm3TOCHandle;
   
 function __Forward(AItemPtr: Pm3TOCHandle; AIndex: LongInt): Boolean;
 begin//__Forward
  Result := anAction(Tm3StorageElementInfo_C(AItemPtr^.StoreInfo,
                                             AItemPtr^.HandleName.AsWStr));
  l_Cont := Result;
 end;//__Forward

 function _IndexElement(const aStoreInfo: Tm3StoreInfo; anIndex: Integer): Boolean;
 const
  cFormatString = m3IndexPrefixFormatStr;
 begin//_IndexElement
  Result := anAction(Tm3StorageElementInfo_C(aStoreInfo, l3PCharLen(Format(cFormatString, [anIndex]))));
 end;//_IndexElement

var
 Hack : Pointer absolute anAction;
//#UC END# *54525E3A02BF_5451095F00E9_var*
begin
//#UC START# *54525E3A02BF_5451095F00E9_impl*
 try
  Lock;
  try
   l_Cont := true;
   f_TableOfContents.IterateAllF(l3L2IA(@__Forward));
   if l_Cont then
    IterateIndexedF(L2Mm3StorageIteratorsIterateIndexedFAction(@_IndexElement));
  finally
   Unlock;
  end;//try..finally
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *54525E3A02BF_5451095F00E9_impl*
end;//Tm3CustomNewStorage.IterateAllF

procedure Tm3CustomNewStorage.DoCreateStore(const aName: Tl3WString;
  anAccess: Tm3StoreAccess;
  aStoreType: Tm3StoreType;
  out theStream: Tm3Store;
  out theReturn: hResult;
  aUseCompression: Boolean);
//#UC START# *54520BDF0089_5451095F00E9_var*
//#UC END# *54520BDF0089_5451095F00E9_var*
begin
//#UC START# *54520BDF0089_5451095F00E9_impl*
 OleCheck(theReturn);
 theReturn := CreateStore(aName, anAccess, aStoreType, theStream, aUseCompression);
//#UC END# *54520BDF0089_5451095F00E9_impl*
end;//Tm3CustomNewStorage.DoCreateStore

procedure Tm3CustomNewStorage.DoOpenStore(const aName: Tl3WString;
  anAccess: Tm3StoreAccess;
  aStoreType: Tm3StoreType;
  out theStream: Tm3Store;
  out theReturn: hResult;
  aUseCompression: Boolean);
//#UC START# *54520C63028A_5451095F00E9_var*
//#UC END# *54520C63028A_5451095F00E9_var*
begin
//#UC START# *54520C63028A_5451095F00E9_impl*
 OleCheck(theReturn);
 theReturn := OpenStore(aName, anAccess, aStoreType, theStream, aUseCompression);
//#UC END# *54520C63028A_5451095F00E9_impl*
end;//Tm3CustomNewStorage.DoOpenStore

// Методы преобразования к реализуемым интерфейсам

function Tm3CustomNewStorage.As_IStorage: IStorage;
begin
 Result := Self;
end;

end.