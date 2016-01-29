unit ddDocStruct;

{ $Id: ddDocStruct.pas,v 1.25 2015/05/20 16:28:43 lulin Exp $ }

// $Log: ddDocStruct.pas,v $
// Revision 1.25  2015/05/20 16:28:43  lulin
// - чистим код.
//
// Revision 1.24  2015/05/13 12:49:30  lulin
// {RequestLink:588034502}. Инкапсулируем.
//
// Revision 1.23  2014/10/31 14:14:26  lulin
// - перетряхиваем код.
//
// Revision 1.22  2014/10/30 13:43:52  lulin
// - перетряхиваем код.
//
// Revision 1.21  2014/09/19 10:15:36  fireton
// - избавляемся от m3IsStorageExists и m3DeleteStorage
//
// Revision 1.20  2014/09/10 16:02:07  lulin
// - где возможно, там используем эксклюзивный доступ.
//
// Revision 1.19  2014/08/20 10:56:13  fireton
// - очищаем кэш от удалённых из базы доков
//
// Revision 1.18  2014/06/20 12:50:47  fireton
// - пилим автолинковщик на базовые классы
//
// Revision 1.17  2014/05/20 08:25:34  fireton
// - подчищен код
//
// Revision 1.16  2014/05/08 11:48:17  fireton
// - избавляемся от диапазонов в экспорте
//
// Revision 1.15  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.14  2014/03/28 06:13:15  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.13  2014/02/27 08:29:09  fireton
// - вычищаем Choise
//
// Revision 1.12  2014/02/26 12:49:03  voba
// - удалил ненужный Diapason.Choise:= 1;
//
// Revision 1.11  2014/02/24 11:29:33  fireton
// - передаём атрибуты для выливки через property
//
// Revision 1.10  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.9  2013/12/06 10:57:33  fireton
// - не распознавались блокнеймы с неразрывным пробелом
//
// Revision 1.8  2013/10/21 15:43:09  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.7  2013/10/21 10:30:56  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.6  2013/10/18 15:38:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.4  2012/12/20 09:08:21  narry
// Обновление
//
// Revision 1.3  2012/11/29 04:48:54  fireton
// - bugfix: не работало определение наличия на диске кэша структур
//
// Revision 1.2  2012/10/26 07:48:05  narry
// Залить новую партию НСРов (406126937)
//
// Revision 1.1  2012/09/21 09:10:43  lulin
// - не собирался Немезис.
//
// Revision 1.15  2011/05/06 12:19:14  fireton
// - CanUpdate
//
// Revision 1.14  2011/04/13 10:50:20  fireton
// - переводим простановку ссылок на внешние номера документов
//
// Revision 1.13  2011/03/29 12:06:13  fireton
// - кривое условие = AV
//
// Revision 1.12  2011/03/15 14:37:26  fireton
// - "пилим" кэш на два объекта - кэш и builder
//
// Revision 1.11  2011/03/03 08:38:20  fireton
// - кэш структур для простановщика ссылок
//
// Revision 1.10  2011/01/17 14:46:59  fireton
// - держим кэш структур документов на диске и обновляем его по необходимости
//
// Revision 1.9  2010/07/07 11:35:28  narry
// - К224134995. Ошибка формирования названия документа
//
// Revision 1.8  2010/03/02 13:03:54  fireton
// - опознаём номера из трёх чисел через точку
//
// Revision 1.7  2010/02/12 14:11:58  fireton
// - дополнительный контроль номера
//
// Revision 1.6  2010/01/27 14:35:00  fireton
// - распознаём римские цифры в главах документов
//
// Revision 1.5  2010/01/21 08:04:22  fireton
// - bugfix: неверно строилась структура, если в документе пункты без статей
//
// Revision 1.4  2010/01/15 07:52:49  fireton
// - обходим проблему с вложенными "пунктами" и "частями" статей
//
// Revision 1.3  2010/01/13 16:51:56  fireton
// - bug fix
//
// Revision 1.2  2010/01/12 11:59:36  fireton
// - "пункт" и "часть" теперь синонимы
//
// Revision 1.1  2009/12/24 14:49:34  fireton
// - Уточнённая простановка ссылок
//

interface

uses
 l3Base,
 l3Types,
 l3Variant,
 l3PrimString,
 l3RegEx,
 l3Interfaces,
 l3String,
 l3FieldSortRecList,
 l3LongintList,

 k2Types,
 k2Base,
 k2TagTerminator,

 m3StorageInterfaces,

 DT_Types,
 dtIntf, DT_Sab,

 ddDocStructBase,

 SewerPipe;


type
 TddProtoStructCache = class;

 TddDocStructBuildFilter = class(Tk2TagTerminator)
 private
  f_CurElement: TddDocStructElementRec;
  f_BlockLevel  : Integer;
  f_Cache: TddProtoStructCache;
  f_EntriesPresent: Boolean;
  f_LastChainLevel: Integer;
  f_LastItemLevel: Integer;
  f_REItem: Tl3RegularSearch;
  f_SubHandle: Integer;
  f_SubName: Tl3PrimString;
  f_StructArray: Tl3FieldSortRecList;
  procedure GetCacheForDoc(aDocID: TDocID);
  function pm_GetREItem: Tl3RegularSearch;
  procedure PutEntry;
  procedure WorkOutSub;
 protected
  procedure Cleanup; override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure CloseStructure(NeedUndo: Boolean); override;
  procedure StartChild(TypeID: Tl3VariantDef); override;
  property Cache: TddProtoStructCache read f_Cache write f_Cache;
  property REItem: Tl3RegularSearch read pm_GetREItem;
 public
 end;

 TddProtoStructCache = class(Tl3Base)
 private
  f_BaseName: AnsiString;
 protected
  f_BaseMainDateTime: TDateTime;
  f_BuildFilter: TddDocStructBuildFilter;
  f_BuildPipe: TSewerPipe;
  f_Docs: Tl3FieldSortRecList;
  f_FileCacheName: AnsiString;
  procedure Cleanup; override;
  function CreateDocRec(aDocID: TDocID): Integer;
  function GetWriteStorage: Im3IndexedStorage;
  procedure SaveOneToCache(const aIdx: Integer; const aIS: Im3IndexedStorage);
  procedure DoOnDocumentAdded; virtual;
 public
  constructor Create(const aFileCacheName, aBaseName: AnsiString);
  procedure ClearMemCache;
  function GetAddressArr(aDocID: TDocID): Tl3FieldSortRecList;
  property  BaseName: AnsiString read f_BaseName write f_BaseName;
 end;

 TddDocStructCache = class(TddProtoStructCache)
 private
  f_CanUpdate: Boolean;
  function GetDocChangeDate(const aDocID: TDocID): TDateTime;
  function LoadDocToMemCache(aDocID: TDocID): Integer;
  function LoadFromDiskCache(const aDocID: TDocID; out theIndex: Integer): Boolean;
  procedure SaveToDiskCache(const aDocID: TDocID);
 public
  constructor Create(const aFileCacheName, aBaseName: AnsiString; aCanUpdate: Boolean = True);
  function BuildDocStruct(aDocID: TDocID): Integer; overload;
  function FindBlock(const aDocID: TDocID; const aEntryAddr: TddDocStructElementRec): Longint;
  property CanUpdate: Boolean read f_CanUpdate write f_CanUpdate;
 end;

 TddDocStructBuilder = class(TddProtoStructCache)
 private
  f_Counter: Integer;
  f_OnProgress: Tl3ProgressProc;
 protected
  procedure DoOnDocumentAdded; override;
 public
  procedure BuildDocStruct(const aSab: ISab; aProgressProc: Tl3ProgressProc = nil); overload;
  procedure DeleteDoc(aDocID: TDocID);
  procedure DeleteDocs(aList: Tl3LongintList; aProgressProc: Tl3ProgressProc = nil);
  procedure FlushMemCacheToDisk;
 end;

implementation

uses
 Windows,
 SysUtils,

 l3Chars,
 l3ProtoPtrRecListPrim,
 l3FileUtils,
 l3Date,

 dt_AttrSchema,

 Sub_Const,
 Block_Const,
 Document_Const,
 k2Tags,
 k2TagGen,

 m3StgMgr,
 m3BackupTools,
 m3DB
 ;

const
 c_NoEdition     = High(TDocID);

 cFlushThreshold    = 1000;
 cProgressThreshold = 25;

procedure TddDocStructBuildFilter.Cleanup;
begin
 l3Free(f_SubName);
 l3Free(f_REItem);
 inherited;
end;

procedure TddDocStructBuildFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiExternalHandle) then
 begin
  GetCacheForDoc(Value.AsInteger);
  f_LastChainLevel := -1;
  f_EntriesPresent := False;
 end
 else
  if CurrentType.IsKindOf(k2_typSub) then
  begin
   if AtomIndex in [k2_tiHandle, k2_tiName, k2_tiShortName] then
   begin
    case AtomIndex of
     k2_tiHandle: f_SubHandle := Value.AsInteger;
     k2_tiName, k2_tiShortName: l3Set(f_SubName, Value.AsString);
    end;
    if (f_SubHandle >= 0) and (f_SubName <> nil) then
     WorkOutSub;
   end;
  end;
 inherited;
end;

procedure TddDocStructBuildFilter.GetCacheForDoc(aDocID: TDocID);
var
 l_Idx: Integer;
begin
 if f_Cache <> nil then
 begin
  f_StructArray := f_Cache.GetAddressArr(aDocID);
  f_StructArray.Clear;
 end;
end;

procedure TddDocStructBuildFilter.CloseStructure(NeedUndo: Boolean);
begin
 if CurrentType.IsKindOf(k2_typSub{Block}) then
 begin
  Dec(f_BlockLevel);
  if f_BlockLevel < f_LastChainLevel then
   f_LastChainLevel := -1;
 end;
 if CurrentType.IsKindOf(k2_typDocument) and (f_Cache <> nil) then
  f_Cache.DoOnDocumentAdded;
 inherited;
end;

procedure TddDocStructBuildFilter.StartChild(TypeID: Tl3VariantDef);
var
 l_Type: Tk2Type;
begin
 l_Type := Tk2Type(TypeID);
 if l_Type.IsKindOf(k2_typSub) then
 begin
  f_SubHandle := -1;
  l3Free(f_SubName);
  Inc(f_BlockLevel);
 end;
 {
 if TypeID = k2_idBlock then
 begin
  Inc(f_BlockLevel);
 end;
 }
 inherited;
end;

function TddDocStructBuildFilter.pm_GetREItem: Tl3RegularSearch;
begin
 if f_REItem = nil then
 begin
  f_REItem := Tl3RegularSearch.Create;
  f_REItem.SearchPattern := '^({(раздел)|(глава)|(часть)|(статья)|(пункт)|(подпункт)}\s{([а-я0-9]+)|([cdivxlm]+)}(\.{[0-9]+})?(\.{[0-9]+})?)|(({(\d+)|([cdivxlm]+)}(\.{\d+})?)|({[а-я]})[.)]\s)';
  f_REItem.IgnoreCase := True;
 end;
 Result := f_REItem;
end;

procedure TddDocStructBuildFilter.PutEntry;
var
 l_AddrRec: TddDocEntryAddrRec;
begin
 if f_StructArray <> nil then
 begin
  l_AddrRec.rAddress := f_CurElement;
  l_AddrRec.rSubID := f_SubHandle;
  f_StructArray.Add(l_AddrRec);
 end;
end;

procedure TddDocStructBuildFilter.WorkOutSub;
var
 l_Pos : Tl3MatchPosition;
 l_Str: Tl3WString;
 l_SubNameText: Tl3WString;

 procedure FillOutNum(var NumRec: TddElementNumRec; aTagStart: Integer);
 var
  l_Subnum, l_SubSubnum: Tl3WString;
 begin
  // Надо проверить, нет ли чего лишнего после найденного числа,
  // если там точка, то за ней точно ничего не должно быть.
  if l_SubNameText.SLen > l_Pos.EndPos then
  begin
   if l_SubNameText.S[l_Pos.EndPos] = '.' then
    if (l_SubNameText.SLen > l_Pos.EndPos+1) and (not (l_SubNameText.S[l_Pos.EndPos+1] in cc_WhiteSpaceExt)) then
     Exit;
  end;

  if REItem.TagParts.Count > aTagStart+1 then
   l_Subnum := REItem.TagParts[aTagStart+1].AsWStr
  else
   l_Subnum := cc_EmptyStr;

  if REItem.TagParts.Count > aTagStart+2 then
   l_SubSubnum := REItem.TagParts[aTagStart+2].AsWStr
  else
   l_SubSubnum := cc_EmptyStr;

  FillOutEntryNum(NumRec, REItem.TagParts[aTagStart].AsWStr, l_Subnum, l_SubSubnum);

  PutEntry;
 end;

 procedure HandleItem;
 begin
  if (f_LastItemLevel < 0) or (f_BlockLevel <= f_LastItemLevel) then
  begin
   // это пункт
   f_LastItemLevel := f_BlockLevel;
   l3FillChar(f_CurElement.rSubItem, SizeOf(TddElementNumRec));
   FillOutNum(f_CurElement.rItem, 1);
  end
  else
   // это подпункт
   FillOutNum(f_CurElement.rSubItem, 1);
 end;

begin
 l_SubNameText := f_SubName.AsWStr;
 if REItem.SearchInString(l_SubNameText, l_Pos) then
 begin
  l_Str := REItem.TagParts[0].AsWStr;
  if l3Starts(l3PCharLen('статья'), l_Str, True) and (f_LastChainLevel < 0) then
  begin
   // начинаем цепочку адреса
   f_EntriesPresent := True;
   f_LastChainLevel := f_BlockLevel;
   f_LastItemLevel := -1;
   l3FillChar(f_CurElement, SizeOf(f_CurElement));
   f_CurElement.rType := stEntry;
   FillOutNum(f_CurElement.rEntry, 1);
  end
  else
  if l3Starts(l3PCharLen('пункт'), l_Str, True) then
  begin
   if (f_LastChainLevel < 0) and (not f_EntriesPresent) then
   begin
    // похоже, в документе - пункты без статей: начинаем цепочку адреса
    f_LastChainLevel := f_BlockLevel;
    f_LastItemLevel := -1;
    l3FillChar(f_CurElement, SizeOf(f_CurElement));
    f_CurElement.rType := stEntry;
   end;
   HandleItem;
   {
   l3FillChar(f_CurElement.rSubItem, SizeOf(TddElementNumRec));
   FillOutNum(f_CurElement.rItem, 1);
   PutEntry;
   }
  end
  else
  if l3Starts(l3PCharLen('подпункт'), l_Str, True) and
     (f_LastChainLevel >= 0) and (f_CurElement.rItem.rNum <> 0) then
   FillOutNum(f_CurElement.rSubItem, 1)
  else
  if l3Starts(l3PCharLen('раздел'), l_Str, True) and (f_LastChainLevel < 0) then
  begin
   l3FillChar(f_CurElement, SizeOf(f_CurElement));
   f_CurElement.rType := stChapter;
   FillOutNum(f_CurElement.rEntry, 1);
  end
  else
  if l3Starts(l3PCharLen('глава'), l_Str, True) and (f_LastChainLevel < 0) then
  begin
   l3FillChar(f_CurElement, SizeOf(f_CurElement));
   f_CurElement.rType := stHead;
   FillOutNum(f_CurElement.rEntry, 1);
  end
  else
  if l3Starts(l3PCharLen('часть'), l_Str, True) then
  begin
   if (f_LastChainLevel < 0) then // это просто "часть документа"
   begin
    l3FillChar(f_CurElement, SizeOf(f_CurElement));
    f_CurElement.rType := stPart;
    FillOutNum(f_CurElement.rEntry, 1);
   end
   else
    // это "часть статьи", что является синонимом пункта
    HandleItem;
  end
  else
  begin
   // нет чёткого указание, что это такое, а просто цифра/буква с точкой/скобочкой
   // тогда пытаемся определить, чтобы это могло быть - пункт или подпункт
   if (f_LastChainLevel >= 0) then
   begin
    if (f_CurElement.rItem.rNum = 0) then
     // похоже, это пункт
     FillOutNum(f_CurElement.rItem, 0)
    else
     // кажется, это подпункт
     FillOutNum(f_CurElement.rSubItem, 0);
   end
   else
   if not f_EntriesPresent then // в документе нам не встречались статьи
   begin
    // будем считать, что это - пункт в документе без статей
    f_LastChainLevel := f_BlockLevel;
    l3FillChar(f_CurElement, SizeOf(f_CurElement));
    FillOutNum(f_CurElement.rItem, 0);
   end;
  end;
 end;
end;

constructor TddProtoStructCache.Create(const aFileCacheName, aBaseName: AnsiString);
var
 l_MainName: AnsiString;
begin
 inherited Create;
 f_FileCacheName := aFileCacheName;

 f_BaseName := aBaseName;
 l_MainName := ChangeFileExt(aBaseName, m3_cMainExt);
 if FileExists(l_MainName) then
  f_BaseMainDateTime := FileDateTime(l_MainName)
 else
  f_BaseMainDateTime := BadDateTime; 

 f_Docs := Tl3FieldSortRecList.Create(SizeOf(TddDocBlocksRec), [SizeOf(TDocID)], [1]);
 f_Docs.Sorted := True;
 f_BuildPipe := TSewerPipe.Create;
 f_BuildFilter := TddDocStructBuildFilter.Create(nil);

 f_BuildFilter.Cache := Self;

 f_BuildPipe.Writer := f_BuildFilter;
 f_BuildPipe.ExportDocument:= True;
 
 f_BuildPipe.ExportDocTypes := [dtText];
end;

procedure TddProtoStructCache.Cleanup;
begin
 ClearMemCache;
 l3Free(f_Docs);
 l3Free(f_BuildPipe);
 l3Free(f_BuildFilter);
 inherited Cleanup;
end;

procedure TddProtoStructCache.ClearMemCache;
var
 I: Integer;
begin
 for I := 0 to f_Docs.Count - 1 do
  l3Free(PddDocBlocksRec(f_Docs.ItemSlot(I))^.rCache);
 f_Docs.Clear;
end;

function TddProtoStructCache.CreateDocRec(aDocID: TDocID): Integer;
var
 l_DocBlocks : TddDocBlocksRec;
begin
 l_DocBlocks.rDocID := aDocID;
 l_DocBlocks.rCache := Tl3FieldSortRecList.Create(SizeOf(TddDocEntryAddrRec), [SizeOf(TddDocStructElementRec)], [1]);
 Result := f_Docs.Add(l_DocBlocks);
end;

procedure TddProtoStructCache.DoOnDocumentAdded;
begin
 // ничего не делаем в базовом классе
end;

function TddProtoStructCache.GetAddressArr(aDocID: TDocID): Tl3FieldSortRecList;
var
 l_Idx: Integer;
begin
 Result := nil;
 if (aDocID = 0) or (aDocID = c_NoEdition) then
  Exit;
 if not f_Docs.FindRecord(aDocID, l_Idx) then
  l_Idx := CreateDocRec(aDocID);
 Result := PddDocBlocksRec(f_Docs.ItemSlot(l_Idx))^.rCache;
end;

function TddProtoStructCache.GetWriteStorage: Im3IndexedStorage;
begin
 Result := Tm3FullModeExclusiveStorageManager.MakeInterface(f_FileCacheName)
end;

procedure TddProtoStructCache.SaveOneToCache(const aIdx: Integer; const aIS: Im3IndexedStorage);
var
 l_Intf: Tm3Store;
 l_Str: IStream;
 l_DT: TDateTime;
 l_W: Longint;
 l_RecList: Tl3FieldSortRecList;
 l_Count: Integer;
 I: Integer;
 l_Res: HResult;
 l_DocRec: PddDocBlocksRec;
begin
 if (aIS <> nil) then
 begin
  l_DocRec := PddDocBlocksRec(f_Docs.ItemSlot(aIdx));
  l_Res := aIS.CreateStore(l_DocRec^.rDocID, m3_saReadWrite, m3_stStream, l_Intf, true);
  if (l_Res = STG_E_FILEALREADYEXISTS) then
   l_Res := aIS.OpenStore(l_DocRec^.rDocID, m3_saReadWrite, m3_stStream, l_Intf, true);
  if l_Res <> S_Ok then
   Exit;
  l_Str := l_Intf.rStream;
  if (l_Str = nil) then
   Exit;
  l_DT := Now;
  l_Str.Write(@l_DT, SizeOf(TDateTime),  @l_W);
  l_RecList := l_DocRec^.rCache;
  l_Count := l_RecList.Count;
  l_Str.Write(@l_Count, SizeOf(Integer),  @l_W);
  for I := 0 to Pred(l_Count) do
   l_Str.Write(l_RecList.ItemSlot(I), SizeOf(TddDocEntryAddrRec), @l_W);
 end;
end;

constructor TddDocStructCache.Create(const aFileCacheName, aBaseName: AnsiString; aCanUpdate: Boolean = True);
begin
 inherited Create(aFileCacheName, aBaseName);
 f_CanUpdate := aCanUpdate; // кэш будет достраивать структуры, которых нет и обновлять данные
end;

function TddDocStructCache.BuildDocStruct(aDocID: TDocID): Integer;
begin
 f_BuildPipe.MakeSingleDocSab(aDocID, True);
 f_BuildPipe.Attributes := [atSub];
 f_BuildPipe.Execute;
 if f_Docs.FindRecord(aDocID, Result) then
 begin
  PddDocBlocksRec(f_Docs.ItemSlot(Result))^.rCache.Sorted := True;
  SaveToDiskCache(aDocID);
 end
 else
  Result := -1;
end;

function TddDocStructCache.FindBlock(const aDocID: TDocID; const aEntryAddr: TddDocStructElementRec): Longint;
var
 l_Idx  : Integer;
 l_BIdx : Integer;
 l_DocRec: PddDocBlocksRec;
begin
 Result := -1;
 if (aDocID = 0) or (aDocID = c_NoEdition) then
  Exit;
 if not f_Docs.FindRecord(aDocID, l_Idx) then
  l_Idx := LoadDocToMemCache(aDocID);
 if l_Idx < 0 then
  Exit;
 l_DocRec := PddDocBlocksRec(f_Docs.ItemSlot(l_Idx));
 if l_DocRec^.rCache.FindRecord(aEntryAddr, l_BIdx) then
  Result := PddDocEntryAddrRec(l_DocRec^.rCache.ItemSlot(l_BIdx))^.rSubID;

 // Для тестовых целей, пусть каждый раз документ парсится заново
 (*
 l3Free(l_DocRec^.rCache);
 f_Docs.Delete(l_Idx);
 *)
end;

function TddDocStructCache.GetDocChangeDate(const aDocID: TDocID): TDateTime;
begin
 Result := Tm3DB.Make(f_BaseName).GetDocument(aDocID).GetVersion.DateTime;
 if Result = BadDateTime then
  Result := f_BaseMainDateTime;
end;

function TddDocStructCache.LoadDocToMemCache(aDocID: TDocID): Integer;
var
 l_Dia: TDiapasonRec;
begin
 if not LoadFromDiskCache(aDocID, Result) then
  if f_CanUpdate then
   Result := BuildDocStruct(aDocID)
  else
   Result := -1;
end;

function TddDocStructCache.LoadFromDiskCache(const aDocID: TDocID; out theIndex: Integer): Boolean;
var
 l_IS   : Im3IndexedStorage;
 l_Intf : Tm3Store;
 l_Str  : IStream;
 l_DT   : TDateTime;
 l_R    : Longint;
 l_Count: Integer;
 l_RecList : Tl3FieldSortRecList;
 l_Rec     : TddDocEntryAddrRec;
 I         : Integer;
 l_DocDateTime: TDateTime;
begin
 Result := False;
 if not Tm3StorageManager.StorageFileExists(f_FileCacheName) then
  Exit;
 l_IS := Tm3ReadModeStorageManager.MakeInterface(f_FileCacheName);
 if (l_IS <> nil) then
 begin
  if l_IS.OpenStore(aDocID, m3_saRead, m3_stStream, l_Intf, true) <> S_Ok then
   Exit;
  l_Str := l_Intf.rStream;
  if (l_Str = nil) then
   Exit;
  l_Str.Read(@l_DT, SizeOf(TDateTime), @l_R);
  if f_CanUpdate then
  begin
   // здесь проверяем, не устарел ли кэш
   l_DocDateTime := GetDocChangeDate(aDocID);
   if (l_DocDateTime <> BadDateTime) and (l_DT < l_DocDateTime) then
    Exit;
  end;  
  l_Str.Read(@l_Count, SizeOf(Integer), @l_R);
  theIndex := CreateDocRec(aDocID);
  l_RecList := PddDocBlocksRec(f_Docs.ItemSlot(theIndex))^.rCache;
  for I := 1 to l_Count do
  begin
   l_Str.Read(@l_Rec, SizeOf(TddDocEntryAddrRec), @l_R);
   l_RecList.Add(l_Rec);
  end;
  Result := True;
 end;
end;

procedure TddDocStructCache.SaveToDiskCache(const aDocID: TDocID);
var
 l_Idx: Integer;
begin
 if ((aDocID <> 0) or (aDocID <> c_NoEdition)) and f_Docs.FindRecord(aDocID, l_Idx) then
  SaveOneToCache(l_Idx, GetWriteStorage);
end;

procedure TddDocStructBuilder.BuildDocStruct(const aSab: ISab; aProgressProc: Tl3ProgressProc = nil);
var
 l_Dia: TDiapasonRec;
begin
 f_OnProgress := aProgressProc;
 f_Counter := 0;
 if Assigned(f_OnProgress) then
  f_OnProgress(piStart, aSab.Count, 'Построение кэша структур документов');
 try
  f_BuildPipe.DocSab := aSab;
  f_BuildPipe.Attributes := [atSub];
  f_BuildPipe.Execute;
 finally
  FlushMemCacheToDisk;
  if Assigned(f_OnProgress) then
   f_OnProgress(piEnd, aSab.Count);
 end;
end;

procedure TddDocStructBuilder.DeleteDoc(aDocID: TDocID);
var
 l_Idx: Integer;
 l_ST: Im3IndexedStorage;
begin
 if ((aDocID <> 0) or (aDocID <> c_NoEdition)) then
 begin
  if f_Docs.FindRecord(aDocID, l_Idx) then
   f_Docs.Delete(l_Idx);
  l_ST := GetWriteStorage;
  l_ST.DeleteStore(aDocID);
 end;
end;

procedure TddDocStructBuilder.DeleteDocs(aList: Tl3LongintList; aProgressProc: Tl3ProgressProc = nil);
var
 I: Integer;
 l_DocID: LongInt;
 l_Idx: Integer;
 l_ST: Im3IndexedStorage;
begin
 l_ST := GetWriteStorage;
 if Assigned(aProgressProc) then
  aProgressProc(piStart, aList.Count, 'Удаление документов из хранилища структур');
 try
  for I := 0 to aList.Count-1 do
  begin
   l_DocID := aList[I];
   if ((l_DocID <> 0) or (l_DocID <> c_NoEdition)) then
   begin
    if f_Docs.FindRecord(l_DocID, l_Idx) then
     f_Docs.Delete(l_Idx);
    l_ST.DeleteStore(l_DocID);
    if Assigned(aProgressProc) then
     aProgressProc(piCurrent, I, '');
   end;
  end;
 finally
  if Assigned(aProgressProc) then
   aProgressProc(piEnd, 0, '');
 end
end;

procedure TddDocStructBuilder.DoOnDocumentAdded;
begin
 Inc(f_Counter);
 if (f_Counter mod cProgressThreshold = 0) and Assigned(f_OnProgress) then
  f_OnProgress(piCurrent, f_Counter);
 if f_Counter mod cFlushThreshold = 0 then
  FlushMemCacheToDisk;
end;

procedure TddDocStructBuilder.FlushMemCacheToDisk;
var
 I   : Integer;
 l_IS: Im3IndexedStorage;
begin
 l_IS := GetWriteStorage;
 for I := 0 to f_Docs.Count - 1 do
  SaveOneToCache(I, l_IS);
 ClearMemCache;
end;

end.
