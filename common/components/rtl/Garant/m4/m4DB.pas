unit m4DB;

{ Библиотека "M4"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m4DB -          }
{ Начат: 17.08.2004 19:20 }
{ $Id: m4DB.pas,v 1.40 2015/11/06 10:57:33 lulin Exp $ }

// $Log: m4DB.pas,v $
// Revision 1.40  2015/11/06 10:57:33  lulin
// - выводим ошибку в лог.
//
// Revision 1.39  2015/05/14 10:31:18  lulin
// {RequestLink:588034502}. Перетряхиваем код.
//
// Revision 1.38  2015/03/16 14:38:47  lulin
// - делаем стереотипы Service и ServiceImplementation.
//
// Revision 1.37  2014/11/06 17:05:12  lulin
// - перетряхиваем код.
//
// Revision 1.36  2014/11/06 16:09:55  lulin
// - перетряхиваем код.
//
// Revision 1.35  2014/11/05 11:23:17  lulin
// - перетряхиваем код.
//
// Revision 1.34  2014/10/31 17:43:00  lulin
// - перетряхиваем код.
//
// Revision 1.33  2014/10/31 14:14:32  lulin
// - перетряхиваем код.
//
// Revision 1.32  2014/10/30 16:37:13  lulin
// - перетряхиваем код.
//
// Revision 1.31  2014/10/30 15:59:03  lulin
// - перетряхиваем код.
//
// Revision 1.30  2014/10/30 13:43:55  lulin
// - перетряхиваем код.
//
// Revision 1.29  2014/09/11 12:58:22  lulin
// - при ежедневном обновлении работаем с базой в монопольном режиме.
//
// Revision 1.28  2014/09/11 12:25:46  lulin
// - готовимся к монопольной работе с базой.
//
// Revision 1.27  2014/09/10 16:02:10  lulin
// - где возможно, там используем эксклюзивный доступ.
//
// Revision 1.26  2014/09/01 13:57:32  lulin
// - в таком разрезе не надо исключение типизировать иначе можно открытую скобку не закрыть.
//
// Revision 1.25  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.24  2013/04/05 12:04:38  lulin
// - портируем.
//
// Revision 1.23  2012/06/13 09:57:15  voba
// - bug fix: ошибка индексации для старого хранилища
//
// Revision 1.22  2012/05/25 14:17:24  lulin
// - делаем "кошерную" операцию проверки существования файла.
//
// Revision 1.21  2012/05/25 14:08:29  lulin
// - делаем операцию удаления индекса.
//
// Revision 1.20  2012/05/25 13:43:54  lulin
// - чистка кода.
//
// Revision 1.19  2012/03/02 08:56:25  voba
// -k:310676394
//
// Revision 1.18  2010/04/16 10:00:02  lulin
// {RequestLink:199590828}.
// - делаем возможность писать в базу из итератора с фильтром.
//
// Revision 1.17  2010/02/02 14:09:54  voba
// no message
//
// Revision 1.16  2009/09/28 08:52:58  voba
// - избавляемся от старого анализатора фраз
//
// Revision 1.15  2009/03/16 16:18:54  lulin
// - <K>: 138969458. Убираем ненужный параметр.
//
// Revision 1.14  2008/10/22 11:50:18  voba
// - bug fix ошибка с множественной подсветкой найденных
//
// Revision 1.13  2008/04/04 14:49:25  narry
// - не собиралось
//
// Revision 1.12  2008/03/20 09:48:44  lulin
// - cleanup.
//
// Revision 1.11  2008/02/07 14:44:50  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.10  2006/02/14 08:39:29  voba
// - rename
//  Tm3DocumentStream   -> Tm3DocPartSelector
//  Tm3DocumentStreams  -> Tm3DocPartSet
//  m3_defDocStream     -> m3_defDocPart
//  m3_AllDocStreams    -> m3_AllDocParts
//
// Revision 1.9  2006/02/07 16:33:57  voba
// - new beh. абстрагирование Im3DB от структуры базы
//
// Revision 1.8  2006/02/06 13:32:26  voba
// - new beh. выпилил поддержку стаго хранилища (часть 2)
//
// Revision 1.7  2006/02/06 11:49:25  fireton
// - подключил функции работы с компилированным словарем
//
// Revision 1.6  2006/02/03 07:22:14  voba
// - new beh. выпилил поддержку стаго хранилища
// временно отключены функции работы с компилированным словарем
//
// Revision 1.5  2005/04/19 15:41:56  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.4  2005/02/15 11:49:18  lulin
// - new behavior: теперь все итераторы могут перебирать составные части документов (main, anno).
//
// Revision 1.3  2005/02/14 15:34:01  lulin
// - bug fix: не компилировалось.
//
// Revision 1.2  2004/10/06 13:52:21  lulin
// - теперь метод Im3DB._Start имеет два ОБЯЗАТЕЛЬНЫХ параметра - режимы открытия частей.
//
// Revision 1.1  2004/09/02 07:15:21  law
// - cleanup.
//
// Revision 1.17  2004/08/30 15:14:51  law
// - new unit: m4DBTools.
//
// Revision 1.16  2004/08/30 14:44:08  law
// - new method: Im4DB.ParsePhraseF.
//
// Revision 1.15  2004/08/30 14:04:55  law
// - new method: Im4DB.CompileDictionary.
//
// Revision 1.14  2004/08/24 15:22:26  law
// - при индексации нового хранилища читаем список удаленных из "правильного места".
//
// Revision 1.13  2004/08/24 14:37:01  law
// - сделана возможность индексировать документы и с IndexID < 1.
//
// Revision 1.12  2004/08/24 07:52:27  law
// - new: сделана возможность индексировать в несколько индексов.
//
// Revision 1.11  2004/08/23 12:01:50  law
// - добавлено значение параметра по умолчанию.
//
// Revision 1.10  2004/08/20 11:14:16  law
// - new behavior: по завершению процесса закрываем базу.
//
// Revision 1.9  2004/08/20 07:17:29  law
// - new props: Im4DB.FakeIndex, _PackedIndex.
//
// Revision 1.8  2004/08/20 06:53:18  law
// - убрал с Tm3DB знания об _afw.ProcessMessages.
//
// Revision 1.7  2004/08/20 06:32:55  law
// - время процесса и флаг остановки теперь относятся к Im3DB.
//
// Revision 1.6  2004/08/20 05:45:49  law
// - new proc: Im3DB.Update.
//
// Revision 1.5  2004/08/19 18:20:08  law
// - реализован метод Tm4DB._UpdateIndex.
//
// Revision 1.4  2004/08/19 17:51:53  law
// - new method: Im4DB._UpdateIndex.
//
// Revision 1.3  2004/08/19 15:37:09  law
// - в нулевом приближении сделана индексация нового хранилища.
//
// Revision 1.2  2004/08/18 17:50:17  law
// - new units.
//
// Revision 1.1  2004/08/17 15:22:14  law
// - new unit: m4DB.
//

{$I m4Define.inc}

interface

uses
  Classes,
  
  l3Types,
  l3Base,

  m3StorageInterfaces,
  m3DBInterfaces,
  m3DB,

  m4DBInterfaces
  ;

type
  Tm4DB = class(Tm3DB, Im4DB)
    private
    // internal fields
      f_PackedIndex : Bool;
      f_FakeIndex   : Bool;
      f_TextIndex   : Im3IndexedStorage;
    protected
    // interface methods
      // Im4DB
      function  pm_GetPackedIndex: Bool;
      procedure pm_SetPackedIndex(aValue: Bool);
        {-}
      function  pm_GetFakeIndex: Bool;
      procedure pm_SetFakeIndex(aValue: Bool);
        {-}
      function  BuildIndex(aDelta        : Bool = false;
                           aExitIfExists : Bool = false;
                           anIndexID     : Long = 1): Long;
        {-}
      procedure UpdateIndex(anIndexID: Long = 1);
        {-}
      procedure DeleteIndex;
        {-}
      procedure DeleteIndexDelta;
        {-}
    protected
    // internal methods
      procedure CloseBase;
        override;
        {* - закрывает открытые файлы. }
    public
    // public methods
      constructor Create(const aBaseName   : AnsiString;
                         aOnYield          : TNotifyEvent;
                         aFileMeter        : Tl3ProgressProc;
                         aFilesMeter       : Tl3ProgressProc;
                         aFilesProcessed   : Tm3FilesProcessed;
                         aFilesProcessedEx : Tm3FilesProcessedEx);
        override;
        {-}
      class function Make(const aBaseName   : AnsiString;
                          aOnYield          : TNotifyEvent = nil;
                          aFileMeter        : Tl3ProgressProc = nil;
                          aFilesMeter       : Tl3ProgressProc = nil;
                          aFilesProcessed   : Tm3FilesProcessed = nil;
                          aFilesProcessedEx : Tm3FilesProcessedEx = nil): Im4DB;
        reintroduce;
        {-}
  end;//Tm4DB

implementation

uses
  ActiveX,
  ComObj,
  SysUtils,

  l3Chars,
  l3String,
  l3Stream,
  l3LongintList,

  m2COMLib,
  m2HASLib,

  m3IndexConst,
  m3EvdDocumentIndexBuilder,
  m3StorageTools,
  m3StgMgr,
  m3IdxCla,
  m3DocumentAddress,

  l3Interfaces,

  m3BranchHandleList,
  m3WideStringManager,
  m3BranchHandlePrim,
  m3BranchHandle,
  m3HashHandle
  ;

const
 cIndexExt = '.idx';
 cDeltaExt = '_delta';
   
// start class Tm4DB

constructor Tm4DB.Create(const aBaseName   : AnsiString;
                         aOnYield          : TNotifyEvent;
                         aFileMeter        : Tl3ProgressProc;
                         aFilesMeter       : Tl3ProgressProc;
                         aFilesProcessed   : Tm3FilesProcessed;
                         aFilesProcessedEx : Tm3FilesProcessedEx);
  //override;
  {-}
begin
 inherited;
 f_PackedIndex := true;
 f_FakeIndex := false;
end;

class function Tm4DB.Make(const aBaseName   : AnsiString;
                          aOnYield          : TNotifyEvent = nil;
                          aFileMeter        : Tl3ProgressProc = nil;
                          aFilesMeter       : Tl3ProgressProc = nil;
                          aFilesProcessed   : Tm3FilesProcessed = nil;
                          aFilesProcessedEx : Tm3FilesProcessedEx = nil): Im4DB;
  //reintroduce;
  {-}
var
 l_Base : Tm4DB;  
begin
 l_Base := Tm4DB.Create(aBaseName, aOnYield,
                        aFileMeter, aFilesMeter,
                        aFilesProcessed, aFilesProcessedEx);
 try
  l_Base.SetExclusive;
  Result := l_Base;
 finally
  FreeAndNil(l_Base);
 end;//try..finally
end;

procedure Tm4DB.CloseBase;
  //override;
  {* - закрывает открытые файлы. }
begin
 f_TextIndex := nil;
 inherited;
end;

function Tm4DB.pm_GetPackedIndex: Bool;
  {-}
begin
 Result := f_PackedIndex;
end;

procedure Tm4DB.pm_SetPackedIndex(aValue: Bool);
  {-}
begin
 f_PackedIndex := aValue;
end;

function Tm4DB.pm_GetFakeIndex: Bool;
  {-}
begin
 Result := f_FakeIndex;
end;

procedure Tm4DB.pm_SetFakeIndex(aValue: Bool);
  {-}
begin
 f_FakeIndex := aValue;
end;

function Tm4DB.BuildIndex(aDelta        : Bool = false;
                          aExitIfExists : Bool = false;
                          anIndexID     : Long = 1): Long;
  {-}
var
 l_DocumentIndexBuilder : Tm3EvdDocumentIndexBuilder;
 l_StorageType          : Tm3StorageType;
 l_IndexExt             : AnsiString;
 l_IndexName            : AnsiString;
 l_Range                : Im3DBRange;
begin
 CheckExclusive;
 Start(m3_saRead);
 try
  Result := 0;
  if f_PackedIndex then
   l_StorageType := m3_stArchive
  else
   l_StorageType := m3_stPlain;
  l_IndexExt := cIndexExt;
  if (anIndexID <> 1) then
   l_IndexExt := l_IndexExt + IntToStr(anIndexID);
  if not f_PackedIndex then
   l_IndexExt := '_unpack' + l_IndexExt;
 // if aBack then
 //  l_IndexExt := '_back' + l_IndexExt;
  if aDelta then
   l_IndexExt := cDeltaExt + l_IndexExt;
  l_IndexName := ChangeFileExt(BaseName, l_IndexExt);
  if Tm3StorageManager.StorageFileExists(l_IndexName) then
  //if FileExists(l_IndexName) then
  begin
   if not aExitIfExists then
    Tm3StorageManager.DeleteStorageFile(l_IndexName)
    //DeleteFile(l_IndexName);
  end//FileExists(l_IndexName)
  else
   aExitIfExists := false;
  if not f_FakeIndex AND (f_TextIndex = nil) then
   f_TextIndex := Tm3FullModeExclusiveStorageManager.
                   MakeInterface(l_IndexName, l_StorageType);
  if (f_TextIndex <> nil) then
   m3COMOpenStream(f_TextIndex,
                   l3PCharLen(m3SummaryName),
                   m3_saReadWrite,
                   true);
  if not aExitIfExists then
  begin
   if f_FakeIndex then
    l_DocumentIndexBuilder := nil
   else
    l_DocumentIndexBuilder := Tm3EvdDocumentIndexBuilder.Create(f_TextIndex);
   try
//    if (l_DocumentIndexBuilder <> nil) then
//     l_DocumentIndexBuilder.OnSortFinished := aSortFinished;
    l_Range := IndexedFiles(anIndexID);
    if aDelta then
     l_Range := l_Range.Mul(ModifiedFiles);
    Result := l_Range.Iterate(l_DocumentIndexBuilder, false, [m3_defDocPart]);
   finally
    FreeAndNil(l_DocumentIndexBuilder);
   end;//try..finally
  end;//not ExitIfExists
 finally
  Finish;
 end;//try..finally
end;

procedure Tm4DB.UpdateIndex(anIndexID : Long = 1);
  {-}

var
 l_Total     : TDateTime;
 l_InHash    : Im3IndexedStorage;
 l_OutHash   : Im3IndexedStorage;
 l_DeltaHash : Im3IndexedStorage;
 l_HashInfo  : Tm3HashInfoStream;
 l_ConvertBuff : PAnsiChar;
 l_Deleted     : Tl3LongintList;
 l_DeltaWords  : Tm3Hash;

 function DoHash(const aStoreInfo: Tm3StoreInfo; anIndex: Long): Bool;

 var
  l_InHashElement    : Im3IndexedStorage;
  l_OutHashElement   : Im3IndexedStorage;
  l_DeltaHashElement : Im3IndexedStorage;
  l_HashWords        : Tm3BranchHandleList;

  function DoWord(const aStoreInfo : Tm3StorageElementInfo): Bool;

  var
   l_OutWordStream   : IStream;
   l_DeltaWordStream : IStream;
   l_CurDeleted      : Long;
   l_DeltaAddress    : Tm3DocumentAddress;
   l_Read            : Int64;
   l_Code            : hResult;

   procedure OutWord(const anAddress: Tm3DocumentAddress);
   var
    l_Written : Int64;
    l_ID      : Long;
   begin//OutWord
    if (l_Deleted <> nil) then begin
     with l_Deleted do
      while (l_CurDeleted < Count) do begin
       l_ID := Items[l_CurDeleted];
       if (l_ID > anAddress.rDocument) then
        break
       else if (l_ID = anAddress.rDocument) then
        Exit // - выкидываем адрес для удаленного документа
       else
        Inc(l_CurDeleted); // - берем следующий адрес удаленного документа
      end;//while (l_CurDeleted < l_Deleted.Count
    end;//l_Deleted = nil
    if (l_DeltaWordStream <> nil) AND not l_DeltaAddress.EQ(m3StopWordAddress) then begin
     while true do begin
      if l_DeltaAddress.EQ(m3NullDocumentAddress) then begin
       l_Code := l_DeltaWordStream.Read(@l_DeltaAddress, SizeOf(l_DeltaAddress), @l_Read);
       if (l_Code = S_False) then begin
        l_DeltaAddress := m3StopWordAddress;
        break;
       end else
        OleCheck(l_Code);
      end;//l_DeltaAddress.EQ(m3NullDocumentAddress)
      Case l_DeltaAddress.CaseCompare(anAddress) of
       -1 : begin
        l_OutWordStream.Write(@l_DeltaAddress, SizeOf(l_DeltaAddress), @l_Written);
        l_DeltaAddress := m3NullDocumentAddress;
       end;//-1
       0  : begin
        l_OutWordStream.Write(@l_DeltaAddress, SizeOf(l_DeltaAddress), @l_Written);
        l_DeltaAddress := m3NullDocumentAddress;
        Exit; // - не надо писать дубли (хотя они должны били выкинуться при выкидывании удаленных)
       end;//0
       else
        break; // - надо записать меньший адрес
      end;//Case l_DeltaAddress
     end;//while true
    end;//l_DeltaWordStream <> nil
    l_OutWordStream.Write(@anAddress, SizeOf(anAddress), @l_Written);
    // - записываем адрес, т. к. он не входит в удаленный документ
   end;//OutWord

  var
   l_InWordStream  : IStream;
   l_Address       : Tm3DocumentAddress;
   l_FoundIndex    : Long;
  begin//DoWord
   if Stopped then
    Result := false
   else begin
    m2COMWriteBuffer(l_HashInfo, PWideChar(aStoreInfo.rName.S)^, aStoreInfo.rName.SLen * SizeOf(WideChar));
    m2COMWriteBuffer(l_HashInfo, cc_NullVar, SizeOf(WideChar));
    l_CurDeleted := 0;
    Result := true;
    if Assigned(FilesMeter) then
     FilesMeter(piCurrent,
                  anIndex,
                  IntToStr(anIndex) + ' ' + l3PCharLen2String(aStoreInfo.rName, CP_ANSI, @l_ConvertBuff));
    Yield;
    l_InWordStream := l_InHashElement.OpenStore(aStoreInfo, m3_saRead, true).rStream;
    try
     if (l_DeltaHashElement = nil) then
      l_DeltaWordStream := nil
     else
      l_DeltaWordStream := m3COMOpenStream(l_DeltaHashElement,
                                           aStoreInfo.rName,
                                           m3_saRead,
                                           false);
     try
      l_OutWordStream := m3COMOpenStream(l_OutHashElement,
                                         aStoreInfo.rName,
                                         m3_saReadWrite,
                                         true);
      try
       l_DeltaAddress := m3NullDocumentAddress;
       while true do begin
        l_Code := l_InWordStream.Read(@l_Address, SizeOf(l_Address), @l_Read);
        if (l_Code = S_False) then
         break;
        OleCheck(l_Code);
        OutWord(l_Address);
       end;//while true
       if (l_DeltaWordStream <> nil) AND
          not l_DeltaAddress.EQ(m3StopWordAddress) then begin
         if not l_DeltaAddress.EQ(m3NullDocumentAddress) then
          l_OutWordStream.Write(@l_DeltaAddress, SizeOf(l_DeltaAddress), @l_Read);
         while true do begin
          l_Code := l_DeltaWordStream.Read(@l_Address, SizeOf(l_Address), @l_Read);
          if (l_Code = S_False) then
           break;
          OleCheck(l_Code);
          l_OutWordStream.Write(@l_Address, SizeOf(l_Address), @l_Read);
         end;//while true
       end;//l_DeltaWordStream <> nil..
      finally
       l_OutWordStream := nil;
      end;//try..finally
     finally
      l_DeltaWordStream := nil;
     end;//try..finally
    finally
     l_InWordStream := nil;
    end;//try..finally
   end;//Stopped
   if (l_HashWords <> nil) then
    with l_HashWords do
     if FindItemByKey(Tm3WideString_C(PWideChar(aStoreInfo.rName.S), aStoreInfo.rName.SLen), l_FoundIndex) then
      Delete(l_FoundIndex);
  end;//DoWord

  function DoNewWord(aWord: PObject; anIndex: Long): Bool;
  var
   l_InWordStream  : IStream;
   l_OutWordStream : IStream;
   l_Read          : Int64;
   l_Written       : Int64;
  begin//DoNewWord
   if Stopped then
    Result := false
   else begin
    Result := true;
    l_InWordStream := m3COMOpenStream(l_DeltaHashElement,
                                      Tm3WideStringManager.StringAsPCharLen(
                                       Pm3BranchHandlePrim(aWord).Data.Value),
                                      m3_saRead,
                                      false);
    Assert(l_InWordStream <> nil, 'l_InWordStream = nil, Word = ' + Pm3BranchHandlePrim(aWord).Data.Value);
    try
     l_OutWordStream := m3COMOpenStream(l_OutHashElement,
                                       Tm3WideStringManager.StringAsPCharLen(
                                        Pm3BranchHandlePrim(aWord).Data.Value),
                                       m3_saReadWrite,
                                       true);
     try
      l_InWordStream.CopyTo(l_OutWordStream, High(Int64), l_Read, l_Written);
     finally
      l_OutWordStream := nil;
     end;//try..finally
    finally
     l_InWordStream := nil;
    end;//try..finally
   end;//Stopped
  end;//DoNewWord

 begin//DoHash
  if Stopped then
   Result := false
  else begin
   l_HashWords := Tm3HashHandle(l_DeltaWords.Items[anIndex]).BranchHandleList;
   if (anIndex mod 50 = 0) AND Assigned(FilesProcessed) then
    FilesProcessed(anIndex);
   if (anIndex mod 100 = 0) AND Assigned(FilesProcessedEx) then
    FilesProcessedEx(anIndex, Cm2HASDefCount, Now - l_Total);
   if Assigned(FilesMeter) then
    FilesMeter(piCurrent, anIndex, IntToStr(anIndex));
   Yield;
   l_InHashElement := l_InHash.OpenStore(aStoreInfo, m3_saRead, anIndex, true).rStorage;
   try
    if (l_DeltaHash = nil) then
     l_DeltaHashElement := nil
    else
     l_DeltaHashElement := m3COMOpenStorage(l_DeltaHash,
                                            anIndex,
                                            m3_saRead,
                                            false);
    try
     l_OutHashElement := m3COMOpenStorage(l_OutHash,
                                          anIndex,
                                          m3_saReadWrite,
                                          true);
     try
      l_InHashElement.IterateAllF(L2Mm3StorageIteratorsIterateAllFAction(@DoWord));
      if (l_HashWords <> nil) then begin
       if not l_HashWords.Empty then begin
        {$IfDef m4OutNewHashWords}
        Gm0EXCLibDefSrv.SaveMessage(Cm0EXCLibINF, 'Появились новые слова для хеша ' + IntToStr(anIndex));
        {$EndIf m4OutNewHashWords}
        l_HashWords.IterateAllF(l3L2IA(@DoNewWord));
       end;//not l_HashWords.Empty
       l_DeltaWords.Items[anIndex] := nil;
      end;//l_HashWords <> nil
     finally
      l_OutHashElement := nil;
     end;//try..finally
    finally
     l_DeltaHashElement := nil;
    end;//try..finally
   finally
    l_InHashElement := nil;
   end;//try..finally
   Result := true;
  end;//Stopped
 end;//DoHash

 procedure LoadDeltaWords;
 var
  l_HashInfo : Tm3HashInfoStream;
  l_Word     : WideString;
 begin
  l_HashInfo := Tm3HashInfoStream.Create(
                  m3COMOpenStream(f_TextIndex,
                                  l3PCharLen(WideString(m3HashInfoName)),
                                  m3_saRead,
                                  false), STGM_READ);
  try
   while (m3ReadWideString(l_HashInfo, l_Word) = S_Ok) do
    l_DeltaWords.SearchBranchHandle(l_Word, nil);
  finally
   FreeAndNil(l_HashInfo);
  end;//try..finally
 end;

var
 l_NewHashTotal : TDateTime;

 function _CheckNewHash(aHashWords: PObject; anIndex: Long): Bool;

  function _NewWord(aWord: PObject; anIndex: Long): Bool;
  begin//_NewWord
   Result := true;
   if (aWord^ <> nil) then begin
    with Tm3BranchHandle(aWord^).Data do
     m2COMWriteBuffer(l_HashInfo, Value^, Tm3WideStringManager.ItemLength(Value) * SizeOf(WideChar));
    m2COMWriteBuffer(l_HashInfo, cc_NullVar, SizeOf(WideChar));
   end;//aWord^ <> nil
  end;//_NewWord

 var
  l_OutHashElement   : Im3IndexedStorage;
  l_DeltaHashElement : Im3IndexedStorage;
 begin//_CheckNewHash
  if Stopped then
   Result := false
  else begin
   Result := true;
   if (aHashWords^ <> nil) then begin
    if (anIndex mod 100 = 0) AND Assigned(FilesProcessedEx) then
     FilesProcessedEx(anIndex, Cm2HASDefCount, Now - l_NewHashTotal);
    if (Tm3HashHandle(aHashWords^).BranchHandleList.Count > 0) then begin
     {$IfDef m4OutNewHash}
     Gm0EXCLibDefSrv.SaveMessage(Cm0EXCLibINF, 'Появился новый хеш ' + IntToStr(anIndex));
     {$EndIf m4OutNewHash}
     Tm3HashHandle(aHashWords^).BranchHandleList.IterateAllF(l3L2IA(@_NewWord));
     l_DeltaHashElement := m3COMOpenStorage(l_DeltaHash,
                                             anIndex,
                                             m3_saRead,
                                             false);
     if (l_DeltaHashElement <> nil) then
      try
       l_OutHashElement := m3COMOpenStorage(l_OutHash,
                                            anIndex,
                                            m3_saReadWrite,
                                            true);
       try
        if Assigned(FilesMeter) then
         FilesMeter(piCurrent, anIndex, IntToStr(anIndex));
        Yield;
        l_OutHashElement.CopyFrom(l_DeltaHashElement);
        //l_DeltaHashElement.CopyTo(0, nil, nil, l_OutHashElement);
       finally
        l_OutHashElement := nil;
       end;//try..finally
      finally
       l_DeltaHashElement := nil;
      end;//try..finally
    end;//Tm3HashHandle(aHashWords^).BranchHandleList.Count > 0
   end;//aHashWords^ <> nil
  end;//Stopped
 end;//_CheckNewHash

var
 l_OutIndex    : Im3IndexedStorage;
 
 procedure CreateSummary;
 var
  l_Stream : IStream;
 begin//CreateSummary
  l_Stream := m3COMOpenStream(l_OutIndex,
                              l3PCharLen(m3SummaryName),
                              m3_saReadWrite,
                              true);
  l_Stream := nil;
 end;//CreateSummary

 procedure CreateHashInfo;
 begin
  l_HashInfo := Tm3HashInfoStream.Create(
                 m2COMDestroyData(
                  m3COMOpenStream(l_OutIndex,
                                  l3PCharLen(WideString(m3HashInfoName)),
                                  m3_saReadWrite,
                                  true)), STGM_READWRITE);
 end;

var
 l_IndexExt    : AnsiString;
 l_InIndex     : Im3IndexedStorage;
 l_InIndexName : AnsiString;
 l_BakIndexName: AnsiString;
 l_UpdateName  : AnsiString;
 l_Delta       : Bool;
 l_Count       : Long;
begin
 CheckExclusive;
 Start(m3_saRead);
 try
  l_Delta := true;
  l_IndexExt := cIndexExt;
  if (anIndexID <> 1) then
   l_IndexExt := l_IndexExt + IntToStr(anIndexID);
  l_InIndexName := BaseName + '_direct' + l_IndexExt;
  if not Tm3StorageManager.StorageFileExists(l_InIndexName) then
  //if not FileExists(l_InIndexName) then
  begin
   l_InIndexName := BaseName + l_IndexExt;
   if not Tm3StorageManager.StorageFileExists(l_InIndexName) then
   //if not FileExists(l_InIndexName) then
    l_Delta := false;
  end;//not FileExists(l_InIndexName)
  l_Count := BuildIndex(l_Delta, false);
  l_Total := Now;
  if not Stopped then
  begin
   if l_Delta AND (l_Count > 0) then
   begin
    l_Deleted := MakeCommonList(clsModified);
    l_Deleted.InsertList(DeletedFiles);
    try
     l_ConvertBuff := nil;
     try
      l_InIndex := Tm3ReadModeExclusiveStorageManager.MakeInterface(l_InIndexName);
      try
       l_UpdateName := BaseName + '_update' + l_IndexExt;
       if Tm3StorageManager.StorageFileExists(l_UpdateName) then
       //if FileExists(l_UpdateName) then
        Tm3StorageManager.DeleteStorageFile(l_UpdateName);
        //DeleteFile(l_UpdateName);
       l_OutIndex := Tm3FullModeExclusiveStorageManager.MakeInterface(l_UpdateName);
       try
        CreateSummary;
        l_InHash := m3COMOpenStorage(l_InIndex,
                                     l3PCharLen(WideString(m3HashDataName)),
                                     m3_saRead,
                                     false);
        try
         Tm3WideStringManager.Instance.LockFree;
         try
          l_DeltaWords := Tm3Hash.Create;
          try
           LoadDeltaWords;
           l_DeltaHash := m3COMOpenStorage(f_TextIndex,
                                           l3PCharLen(WideString(m3HashDataName)),
                                           m3_saRead,
                                           false);
           try
            CreateHashInfo;
            try
             l_OutHash := m3COMOpenStorage(l_OutIndex,
                                           l3PCharLen(WideString(m3HashDataName)),
                                           m3_saReadWrite,
                                           true);
             try
              l_OutHash.SetIndexParam(16, 16);
              {$IfNDef l3ConsoleApp}
              if Assigned(FilesMeter) then
               FilesMeter(piStart, Cm2HASDefCount, 'Обновление индекса');
              try
              {$EndIf l3ConsoleApp}
               l_InHash.IterateIndexedF(L2Mm3StorageIteratorsIterateIndexedFAction(@DoHash));
              {$IfNDef l3ConsoleApp}
              finally
               if Assigned(FilesMeter) then
                FilesMeter(piEnd, 0, '');
              end;//try..finally
              {$EndIf l3ConsoleApp}
              {$IfNDef l3ConsoleApp}
              if Assigned(FilesMeter) then
               FilesMeter(piStart, l_DeltaWords.Count, 'Проверка новых хешей');
              try
              {$EndIf l3ConsoleApp}
               l_NewHashTotal := Now;
               l_DeltaWords.IterateAllF(l3L2IA(@_CheckNewHash));
              {$IfNDef l3ConsoleApp}
              finally
               if Assigned(FilesMeter) then
                FilesMeter(piEnd, 0, '');
              end;//try..finally
              {$EndIf l3ConsoleApp}
             finally
              l_OutHash := nil;
             end;//try..finally
            finally
             FreeAndNil(l_HashInfo);
            end;//try..finally
           finally
            l_DeltaHash := nil;
           end;//try..finally
          finally
           FreeAndNil(l_DeltaWords);
          end;//try..finally
         finally
          Tm3WideStringManager.Instance.UnlockFree;
         end;//try..finally
        finally
         l_InHash := nil;
        end;//try..finally
       finally
        l_OutIndex := nil;
       end;//try..finally
      finally
       l_InIndex := nil;
      end;//try..finally
     finally
      l3System.FreeLocalMem(l_ConvertBuff);
     end;//try..finally
    finally
     FreeAndNil(l_Deleted);
    end;//try..finally
   end;//l_Delta
   if l_Delta then
   begin
    f_TextIndex := nil;
    // - надо освободить все файлы
    if (l_Count > 0) then
    begin
     l_BakIndexName := BaseName + '~'+l_IndexExt;
     if Tm3StorageManager.StorageFileExists(l_BakIndexName) then
     //if FileExists(l_BakIndexName) then
      Tm3StorageManager.DeleteStorageFile(l_BakIndexName);
      //DeleteFile(l_BakIndexName);
     // - удаляем старый backup
     Tm3StorageManager.RenameStorageFile(l_InIndexName, l_BakIndexName);
     //RenameFile(l_InIndexName, l_BakIndexName);
     // - сохраняем текущий индекс
     if Tm3StorageManager.RenameStorageFile(l_UpdateName, l_InIndexName) then
     //if RenameFile(l_UpdateName, l_InIndexName) then
      // - переименовываем новый индекс
      Tm3StorageManager.DeleteStorageFile(l_BakIndexName);
      //DeleteFile(l_BakIndexName);
      // - удаляем новый backup
    end//l_Count > 0
    else
     Tm3StorageManager.DeleteStorageFile(l_UpdateName);
     //DeleteFile(l_UpdateName);
     // - удаляем новый индекс
    Tm3StorageManager.DeleteStorageFile(BaseName + cDeltaExt + l_IndexExt);
    //DeleteFile(BaseName + cDeltaExt + l_IndexExt);
    // - удаляем дельту индекса
   end;//l_Delta
  end;//not Stopped
 finally
  Finish;
 end;//try..finally
end;

procedure Tm4DB.DeleteIndex;
  {-}
var
 l_S : AnsiString;
begin
 l_S := ChangeFileExt(BaseName, cIndexExt);
 Tm3StorageManager.DeleteStorageFile(l_S);
end;  

procedure Tm4DB.DeleteIndexDelta;
  {-}
var
 l_S : AnsiString;
begin
 l_S := ChangeFileExt(BaseName, cDeltaExt + cIndexExt);
 Tm3StorageManager.DeleteStorageFile(l_S);
end;  

end.

