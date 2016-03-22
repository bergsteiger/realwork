
Unit Dt_LinkServ;

{ $Id: dt_LinkServ.pas,v 1.21 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: dt_LinkServ.pas,v $
// Revision 1.21  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.20  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.19  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.18  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.17  2015/04/29 14:57:20  lukyanets
// Заготовки Большого Брата
//
// Revision 1.16  2014/09/04 13:19:36  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.15  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.14  2013/12/03 09:55:07  voba
// - збавляемся от степановских итераторов
//
// Revision 1.13  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.12  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.11  2012/01/13 08:54:40  fireton
// - добавил новый и переименовал старый метод (проверка действий над документами)
//
// Revision 1.10  2011/06/29 16:01:27  fireton
// - отлаживались и забыли
//
// Revision 1.9  2011/06/10 12:49:03  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.8  2010/10/04 14:08:25  fireton
// - const перед Tl3WString и Il3CString
//
// Revision 1.7  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.6  2010/09/21 11:06:54  fireton
// - переводим деревья с PAnsiChar на Tl3WString
//
// Revision 1.5  2010/03/16 12:01:07  voba
// no message
//
// Revision 1.4  2009/09/15 12:32:50  voba
// - use MakeDocEditRec
//
// Revision 1.3  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.2  2009/07/20 12:38:48  voba
// - Засунул renum в атрибуты
//
// Revision 1.1  2009/06/23 08:05:46  voba
// - стандартизация доступа к атрибутам
//
//

{$I DtDefine.inc}

interface

Uses WinTypes, Classes,
     daTypes,
     HT_Const,
     dtIntf,
     dt_aTbl, dt_Sab,
     dt_Types, dt_Const, dt_AttrSchema,
     Dt_Link,
     dt_Renum,
     dt_Prior,
     DT_Log, dt_Stage, dt_Active, dt_Alarm, dt_Hyper, 
     l3Base, l3Date, l3TreeInterfaces, l3Tree_TLB, l3Tree, l3DatLst,
     evTypes, evInternalInterfaces,
     l3LongintList,
     l3Interfaces,

     nevTools
     ;

type

 TLinkServer = Class(Tl3Base)
  protected
   fFamily : TFamilyID;
   fLinks  : Array[TdtAttribute] of TDocAttrTbl;
   fPrior  : TPriorTbl;

   procedure SetFamily(aValue : TFamilyID);
   function  GetLinkObj(aLinkType : TdaDictionaryType) : TLinkTbl;
   function  GetAttribute(aAttr : TdtAttribute) : TDocAttrTbl;
   function  GetLogBook : TLogBookTbl;
   Function  GetTStageTbl : TStageTbl;
   Function  GetActiveTbl : TActiveIntervalTbl;
   function  GetAlarmTbl : TAlarmTbl;

   function  GetSubTbl  : TSubTbl;
   function  GetHLinkTbl: THyperLinkTbl;
   function  GetRenumTbl : TReNumTbl;

   function  GetPriorObj : TPriorTbl;

   procedure DataClear;
   procedure Cleanup; override;
  public
   constructor Create; Reintroduce;

   procedure  Update;

   procedure  GetAttributeList(LT    : TdaDictionaryType;
                               ID    : TDocID;
                               aList : TPersistent;
                               ShortName : Boolean = False);

   procedure GetDataList(LT : TdaDictionaryType;ID : LongInt; aDataList : Tl3CustomDataList; Const aSortOrder : TSortRec);

   procedure ReplaceLinks(aAttr: TdtAttribute;
                          aNewDictIds: Tl3LongintList;
                          aDocId: TDocID;
                          aSubId: TSubID = 0;
                          aOtherDocIds: Tl3LongintList = nil); overload;
   procedure ReplaceLinks(aAttr: TdtAttribute;
                          aNewDictIds: Tl3CustomDataList;
                          aDocId: TDocID;
                          aSubId: TSubID = 0;
                          aOtherDocIds: Tl3LongintList = nil); overload;
   procedure CopyLinks(aAttr: TdtAttribute;
                       aFieldNum: Smallint; // либо lnkDocIDFld, либо lnkDictIDFld. И ничего иного.
                       aSrcId: Integer;
                       aDstId: Integer); overload; // ищет записи, у которых поле aFieldNum имеет значение = aSrcId, копирует их в буфер,
                                                   // меняет значения поля aFieldNum на aDstId  (в буфере!)
                                                   // и заносит полученные записи в таблицу.

   procedure CopyLinks(aAttr: TdtAttribute;
                       const aSrcNodePath: Tl3WString;
                       const aDstNodePath: Tl3WString;
                       const aLevelSlash: AnsiString = c_LevelSlash); overload;

   //procedure SetDataList(LT : TdaDictionaryType;ID : LongInt; aAddList,aDelList : Tl3CustomDataList);
   procedure SetDataListEx(aAttr: TdtAttribute;
                           aDocId: LongInt;
                           aChangedList: Tl3CustomDataList);

   procedure  SetGroupAttributeList(aAttr: TdtAttribute;
                                    aDocID  : TDocID;
                                    CurList : TPersistent;
                                    Action  : TOperActionType);

   procedure  SetGroupDataList(aAttr: TdtAttribute; ID : TDocID;
                               aAddList : Tl3CustomDataList);

   //procedure  SetGroupDateNumList(ID : LongInt; aAddList : Tl3CustomDataList);

   procedure  GetTreeList(aAttrID : TdtAttribute; ID : TDocID; Sub : TSubID;aList : Tl3StringDataList);

   function   GetPriority(ID : TDocID) : Word;

   function   GetMask(aDoc : TDocID) : LongInt;

   function   GetSelfMask : Word;
    {* - Отдает "верхнюю" половину маски прав (независимую от документа).
         Используется в TLockServer.FullLockDoc для проверки acfDelete}

   procedure  GetSubFlags(aDoc : TDocID; const aSubList: InevSubList);

   procedure  AddSubNode(aAttr: TdtAttribute; aDoc : TDocID;aSub : TSubID;aDictID : LongInt);
   procedure  AddNodeEx(aDictType: TdaDictionaryType; aNewRec: PAnsiChar);
   procedure  DelSubNode(aAttr: TdtAttribute; aDoc : TDocID; aSub : TSubID; aDictID : Longint);

   procedure  GetHistogramOfDictElementUsing(LT : TdaDictionaryType; ResList : Tl3DataList; MinCount : LongInt = 1);
   function   LinkExists(aDict: TdaDictionaryType;
                         aDocId: TDocID;
                         aDictId: Longint{;
                         aSubId: TSubID = 0}): Boolean;

   //procedure  AddLinksToGroupDict(aDictType: TdaDictionaryType; aData: TStream);
   //procedure ReplaceLinks(aDictID: TdaDictionaryType; aOldValue, aNewValue: PAnsiChar; const aLevelSlash: AnsiString); overload;
    // пакетное добавление линков на записи в словаре (DT#7 или DT#9).
    // Исходные данные предоставляются
    // в потоке в виде последовательного набора записей.

   procedure  VerifyLink(aDictType : TdaDictionaryType; aReportFile : PText; aWithCorrect : Boolean);

   property   Family : TFamilyID read fFamily write SetFamily;
   property   Links[LinkType : TdaDictionaryType] : TLinkTbl read GetLinkObj;  //default;
   property   Attribute[aAttr : TdtAttribute] : TDocAttrTbl read GetAttribute; default;

   property   SubTbl  : TSubTbl       read GetSubTbl;
   property   HLinkTbl: THyperLinkTbl read GetHLinkTbl;
   property   LogBook : TLogBookTbl   read GetLogBook;
   property   Stages  : TStageTbl     read GetTStageTbl;
   property   ActiveIntervals : TActiveIntervalTbl read GetActiveTbl;
   property   Alarms  : TAlarmTbl     read GetAlarmTbl;
   property   Renum   : TReNumTbl     read GetRenumTbl;
   property   PriorityObj : TPriorTbl read GetPriorObj;
 end;

function LinkServer(aFamily : TFamilyID) : TLinkServer;
procedure FreeLinkServer;

implementation
uses SysUtils, WinProcs,
     daDataProvider,
     daSchemeConsts,
     HT_Dll,
     Dt_Err, Dt_Misc,
     dt_Table,
     Dt_Doc, Dt_Dict, Dt_Acces, Dt_List, 
     l3MinMax, l3Nodes, dt_DictConst;

Const
 cLinkServer : TLinkServer = nil;

function LinkServer(aFamily : TFamilyID) : TLinkServer;
begin
 if cLinkServer = nil then
  cLinkServer := TLinkServer.Create;
 cLinkServer.Family := aFamily;
 Result := cLinkServer;
end;

procedure FreeLinkServer;
begin
 l3Free(cLinkServer);
end;

{ TLinkServer }
constructor TLinkServer.Create;
begin
 Inherited Create;
end;

procedure TLinkServer.Cleanup;
begin
 DataClear;
 Inherited;
end;

procedure TLinkServer.DataClear;
var
  I : TdtAttribute;
begin
 For I := Low(TdtAttribute) to High(TdtAttribute) do
  l3Free(fLinks[I]);
 l3Free(fPrior);
end;

procedure TLinkServer.SetFamily(aValue : TFamilyID);
begin
 if fFamily = aValue then
  Exit;

 if fFamily <> 0 then
  DataClear;

 fFamily := aValue;
end;

function TLinkServer.GetLinkObj(aLinkType : TdaDictionaryType) : TLinkTbl;
begin
 Result := TLinkTbl(GetAttribute(cDLType2Attributes[aLinkType]));
end;

Function  TLinkServer.GetLogBook : TLogBookTbl;
begin
 Result := TLogBookTbl(GetAttribute(atOrdLogRecords));
end;

function  TLinkServer.GetTStageTbl : TStageTbl;
begin
 Result := TStageTbl(GetAttribute(atStages));
end;

function  TLinkServer.GetActiveTbl : TActiveIntervalTbl;
begin
 Result := TActiveIntervalTbl(GetAttribute(atActiveIntervals));
end;

function  TLinkServer.GetAlarmTbl : TAlarmTbl;
begin
 Result := TAlarmTbl(GetAttribute(atAlarms));
end;

function  TLinkServer.GetSubTbl : TSubTbl;
begin
 Result := TSubTbl(GetAttribute(atSub));
end;

function  TLinkServer.GetHLinkTbl : THyperLinkTbl;
begin
 Result := THyperLinkTbl(GetAttribute(atHLink));
end;

function  TLinkServer.GetRenumTbl : TReNumTbl;
begin
 Result := TReNumTbl(GetAttribute(atRenum));
end;

function  TLinkServer.GetAttribute(aAttr : TdtAttribute) : TDocAttrTbl;
begin
 if fFamily = 0 then
  raise EHtErrors.CreateInt(ecNotAssigned);

 if not Assigned(fLinks[aAttr]) then
 begin
  if aAttr = atSub then
   fLinks[aAttr] := TSubTbl.Create(fFamily)
  else
  if aAttr = atHLink then
   fLinks[aAttr] := THyperLinkTbl.Create(fFamily)
  else
  if (aAttr = atOrdLogRecords) or (aAttr = atJurLogRecords) then
   fLinks[aAttr] := TLogBookTbl.Create(fFamily)
  else
  if aAttr = atStages then
   fLinks[aAttr] := TStageTbl.Create(fFamily)
  else
  if aAttr = atActiveIntervals then
   fLinks[aAttr] := TActiveIntervalTbl.Create(fFamily)
  else
  if aAttr = atAlarms then
   fLinks[aAttr] := TAlarmTbl.Create(fFamily)
  else
  if aAttr = atRenum then
   fLinks[aAttr] := TReNumTbl.Create(fFamily)
  else
   with cAttrPassport[aAttr] do
   begin
    if rDict <> da_dlNone then
    begin
     if rDict in sSubLinkDicts then
      fLinks[aAttr] := TSubLinkTbl.Create(fFamily, aAttr)
     else
      fLinks[aAttr] := TLinkTbl.Create(fFamily, aAttr);
    end
    else
     fLinks[aAttr] := TDocAttrTbl.Create(fFamily, aAttr);
   //Assert(False, 'TLinkServer.GetAttribute не дописана');
   end; //with cAttrPassport[aAttr] do
 end;

 Result := fLinks[aAttr];
end;

procedure TLinkServer.Update;
var
 I : TdtAttribute;
begin
 if fFamily=0 then raise EHtErrors.CreateInt(ecNotAssigned);

 for I := Low(TdtAttribute) to High(TdtAttribute) do
  if Assigned(fLinks[I]) then
   FLinks[I].Table.UpdateTbl;

 if Assigned(fPrior) then
  fPrior.UpdateTbl;
end;

function TLinkServer.GetPriorObj : TPriorTbl;
begin
 if fFamily = 0 then raise EHtErrors.CreateInt(ecNotAssigned);
 if not Assigned(fPrior) then
  fPrior := TPriorTbl.Create(fFamily);
 Result := fPrior;
end;

procedure TLinkServer.GetAttributeList(LT    : TdaDictionaryType;ID : LongInt;
                                       AList : TPersistent;ShortName : Boolean = False);
var
 Bodies   : SAB;
 svNFld   : SmallInt;
begin
 if (LT In sSubLinkDicts) then exit;
 l3FillChar(Bodies,SizeOf(SAB));
 Links[LT].GetNodes(ID,Bodies);
 try
  if ShortName and
    (LT in sWithShortName) then
   begin
    svNFld:=DictServer(Family).DictTbl[LT].NameFld;
    try
     DictServer(Family).DictTbl[LT].NameFld:=dtShNameFld;
     DictServer(Family).DictTbl[LT].GetDictListOnSab(Bodies,AList,False);
    finally
     DictServer(Family).DictTbl[LT].NameFld:=svNFld;
    end;
   end
  else
   DictServer(Family).DictTbl[LT].GetDictListOnSab(Bodies,AList,False);
 finally
  htClearResults(Bodies);
 end;
end;

procedure TLinkServer.GetDataList(LT : TdaDictionaryType;ID : LongInt;
                                  aDataList : Tl3CustomDataList;
                                  Const aSortOrder : TSortRec);
var
 Bodies   : SAB;
begin
 l3FillChar(Bodies,SizeOf(SAB));
 Links[LT].GetNodes(ID,Bodies);
 try
  DictServer(Family).Tbl[LT].GetFullListOnSAB(Bodies,ADataList,aSortOrder);
 finally
  htClearResults(Bodies);
 end;
end;

procedure TLinkServer.ReplaceLinks(aAttr: TdtAttribute;
                                   aNewDictIds: Tl3CustomDataList;
                                   aDocId: TDocID;
                                   aSubId: TSubID;
                                   aOtherDocIds: Tl3LongintList);
var
 l_List: Tl3LongintList;
 I: Integer;
begin
 l_List := Tl3LongintList.Create;
 try
  for I := 0 to aNewDictIds.Count - 1 do
   l_List.Add(aNewDictIds.DataInt[I]);

  ReplaceLinks(aAttr, l_List, aDocId, aSubId, aOtherDocIds);
 finally
  l3Free(l_List);
 end;
end;

procedure TLinkServer.ReplaceLinks(aAttr: TdtAttribute;
                                   aNewDictIds: Tl3LongintList;
                                   aDocId: TDocID;
                                   aSubId: TSubID = 0;
                                   aOtherDocIds: Tl3LongintList = nil);
var
 l_NewDictIds : Tl3LongintList;
 l_OldDictIds : ISAB;
 //l_ValIter    : TValuesIterator;
 //l_DictId     : LongWord;
 l_SubRec     : TDestHLinkRec;
 I, j         : Integer;
 l_TmpInt     :  Longint;

 lDictType    : TdaDictionaryType;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  l_DictId  : LongWord;
  J         : Integer;
 begin
  Result := True;
  l_DictId := PLongWord(aItemPtr)^;
      if l_NewDictIds.Remove(l_DictId) = -1 then
      begin
       if lDictType in sSubLinkDicts then
       begin
        l_SubRec.Doc := l_DictId;
        TSubLinkTbl(Links[lDictType]).DelNode(aDocId, l_SubRec);
        if aOtherDocIds <> nil then
         for J := 0 to aOtherDocIds.Count - 1 do
          TSubLinkTbl(Links[lDictType]).DelNode(aOtherDocIds[J], l_SubRec);
       end
       else
       begin
        Links[lDictType].DelNode(aDocId, l_DictId);
        if aOtherDocIds <> nil then
         for J := 0 to aOtherDocIds.Count - 1 do
          Links[lDictType].DelNode(aOtherDocIds[J], l_DictId);
       end;
      end;
 end;

 var
  lRAProcStub : TdtRecAccessProc;
  l_DictId  : LongWord;

begin
 l_SubRec.Sub := aSubID;

 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 // старые DictIds
 if lDictType in sSubLinkDicts then
  l_OldDictIds := TSubLinkTbl(Links[lDictType]).GetSubNodes(aDocId, aSubId)
 else
  l_OldDictIds := Links[lDictType].GetNodes(aDocId);

  // новые DictIds
  l_NewDictIds := Tl3LongintList.Create;
  try
   l_NewDictIds.Assign(aNewDictIds);

   // удаление из таблицы тех, которые были в старых, но нет в новых
   if l_OldDictIds.Count > 0 then
   begin
    lRAProcStub := L2RecAccessProc(@lRecAccessProc);
    try
     l_OldDictIds.IterateRecords(lRAProcStub, [rnRealID_fld, rnImportID_fld]);
    finally
     FreeRecAccessProc(lRAProcStub);
    end;
   end;

   l_OldDictIds := nil;

   // добавление в таблицу тех, которых там еще нет, но еще остались в новых
   for I := 0 to l_NewDictIds.Count - 1 do
   begin
    if lDictType in sSubLinkDicts then
    begin
     l_SubRec.Doc := TDictID(l_NewDictIds.Items[I]);
     TSubLinkTbl(Links[lDictType]).AddNode(aDocID, l_SubRec);
     if aOtherDocIds <> nil then
      for J := 0 to aOtherDocIds.Count - 1 do
       if SubTbl.CheckSub(aOtherDocIds[J], l_SubRec.Sub, l_TmpInt) then
        TSubLinkTbl(Links[lDictType]).AddNode(aOtherDocIds[J], l_SubRec);
    end
    else
    begin
     l_DictId := TDictID(l_NewDictIds.Items[I]);
     Links[lDictType].AddNode(aDocID, l_DictId);
     if aOtherDocIds <> nil then
      for J := 0 to aOtherDocIds.Count - 1 do
       Links[lDictType].AddNode(aOtherDocIds[J], l_DictId);
    end;
   end; // for I
  finally
   l3Free(l_NewDictIds);
  end;

 // запись в лог
 GlobalDataProvider.Journal.LogEditDoc(fFamily, aDocID, da_detDiction, lDictType);
end;

procedure TLinkServer.SetDataListEx(aAttr: TdtAttribute;
                                    aDocId: Integer;
                                    aChangedList: Tl3CustomDataList);
const
 cNotFound = -1;
var
 l_LinkKeyLength: Integer;

 l_LinkRecs: Sab;
 l_DictId: LongWord;
 l_Found: Integer;
 l_RecBuffer: AnsiString;
 l_LinkExists: array of Boolean;
 I: Integer;
 lDictType      : TdaDictionaryType;

 // процедура заполнения буфера (LNK_RECORD + DICT_RECORD), i-тыми данными из пачки
 procedure FillRecBuffer(aDataIndex: Integer);
 var
  l_Buf: PAnsiChar;
  l_BufLen: Integer;
 begin
  l_Buf := PAnsiChar(l_RecBuffer);
  l_BufLen := Length(l_RecBuffer);

  l3FillChar(l_Buf^, l_BufLen);
  PLinkRec(l_Buf)^.DocID := aDocId;
  PLinkRec(l_Buf)^.DictId := PLongWord(aChangedList.Data[aDataIndex])^;
  // если в LNK_RECORD имеются поля кроме полей, составляющих первичный ключ, то допишем и их
  if Links[lDictType].Table.RecSize > l_LinkKeyLength then
   l3Move((aChangedList.Data[aDataIndex] + DictServer(Family).Tbl[lDictType].RecSize)^,
        (l_Buf + l_LinkKeyLength)^,
        Links[lDictType].Table.RecSize - l_LinkKeyLength);
  // теперь загоняем в буфер и DICT_RECORD
  l3Move((aChangedList.Data[aDataIndex])^,
       (l_Buf + Links[lDictType].Table.RecSize)^,
       DictServer(Family).Tbl[lDictType].RecSize);
 end;
begin
 if aChangedList = nil then
  Exit;

 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 l_LinkKeyLength := Links[lDictType].Table.fldLength[Links[lDictType].Table.UniqKeyElemNum];

 // Инициализация массива, отображающего записи из пачки на Boolean
 SetLength(l_LinkExists, aChangedList.Count);
 for I := 0 to Length(l_LinkExists) - 1 do
  l_LinkExists[I] := False;

 // буфер для данных, кот-е передаются в др. методы. Еще раз напомню, эти данные есть LNK_RECORD + DICT_RECORD
 SetLength(l_RecBuffer, Links[lDictType].Table.RecSize + DictServer(Family).Tbl[lDictType].RecSize);

 Links[lDictType].GetOnID(aDocID, nil, l_LinkRecs);
 Ht(htOpenResults(l_LinkRecs, ROPEN_READ, @lnkDictIDFld, 1));
 try
  // перебираем все найденные в таблице DictId
  l_DictId := 0; // начинается шаманство с типами Word и Longword
  while htReadResults(l_LinkRecs, @l_DictId, DictServer(Family).Tbl[lDictType].IDSize) <> 0 do
  begin
   // Для каждого DictId из Sab'а ищем соответств. запись в пачке
   l_Found := cNotFound;
   for I := 0 to aChangedList.Count - 1 do
    if (DictServer(Family).Tbl[lDictType].IDSize = SizeOf(Word)) and (PWord(aChangedList.Data[I])^ = l_DictId)
     or (DictServer(Family).Tbl[lDictType].IDSize = SizeOf(LongWord)) and (PLongWord(aChangedList.Data[I])^ = l_DictId)
    then // DictId стоит в пачке самым первым
    begin
     l_Found := I;
     Break;
    end;

   // --- Удаление ---
   if l_Found = cNotFound then
    DelSubNode(aAttr, aDocId, 0, l_DictId)
   else
   begin
    // поставим-ка отметку о найденом соответствии в массив
    l_LinkExists[l_Found] := True;

    // --- Изменение ---
    if (aChangedList.Flags[l_Found] and lfItemModified) = lfItemModified then
    begin
     FillRecBuffer(l_Found);
     // вносим изменения в данные таблицы LNK (необходимость проведения такого изменения проверяется внутри EditData)
     Links[lDictType].EditData(PAnsiChar(l_RecBuffer),
                               PAnsiChar(l_RecBuffer) + l_LinkKeyLength);
     // вносим изменения в данные таблицы DT (необходимость проведения такого изменения проверяется внутри EditData)
     DictServer(Family).Tbl[lDictType].EditData(l_DictId,
      PAnsiChar(l_RecBuffer) + Links[lDictType].Table.RecSize + DictServer(Family).Tbl[lDictType].IDSize);
    end;
   end;
   l_DictId := 0;
  end; // while
 finally
  htCloseResults(l_LinkRecs);
 end;

 // --- Вставка ---
 // (здесь то нам и понадобятся сведения о найденных соответствиях)
 for I := 0 to Length(l_LinkExists) - 1 do
  if not l_LinkExists[I] then
  begin
   FillRecBuffer(I);
   AddNodeEx(lDictType, PAnsiChar(l_RecBuffer)); // этот метод знает, что ему передают в l_RecBuffer^
  end;

 l_LinkExists := nil;

 // Сброс флагов во ВСЕЙ пачке
 aChangedList.Modified := False;

 GlobalDataProvider.Journal.LogEditDoc(fFamily,
                                      aDocId,
                                      da_detDiction,
                                      lDictType);
end;

function TLinkServer.LinkExists(aDict: TdaDictionaryType;
                                aDocId: TDocID;
                                aDictId: Longint{;
                                aSubId: TSubID = 0}): Boolean;
var
 l_LinkRec: TLinkRec;
 l_SubLinkRec: TSubLinkRec;
 l_Sab1,
 l_Sab2: SAB;

 aSubId: TSubID;
begin
 if not (aDict in sSubLinkDicts) then
 begin
  l_LinkRec.DocId := aDocId;
  l_LinkRec.DictId := aDictId;
  Result := htRecordByUniq(nil, Links[aDict].Table.Handle, Links[aDict].Table.UniqKeyElemNum, @l_LinkRec, nil) > 0;
 end
 else
 begin
  if aSubId <> cAnySubId then
  begin
   l_SubLinkRec.DocID  := aDocId;
   l_SubLinkRec.DictID := aDictId;
   l_SubLinkRec.SubID  := aSubId;
   Result := htRecordByUniq(nil, Links[aDict].Table.Handle, tlnkUniKey, @l_SubLinkRec, nil) > 0;
  end
  else
  begin
   htSearch(nil, l_Sab1, Links[aDict].Table.Handle, lnkDocIDFld, EQUAL, @aDocId, nil);
   try
    if l_Sab1.gFoundCnt > 0 then
    begin
     htSubSearch(l_Sab1, l_Sab2, Links[aDict].Table.Handle, lnkDictIDFld, EQUAL, @aDictId, nil);
     Result := l_Sab2.gFoundCnt > 0;
     htClearResults(l_Sab2);
    end
    else
     Result := False;
   finally
    htClearResults(l_Sab1);
   end;
  end;
 end;
end;

procedure TLinkServer.SetGroupAttributeList(aAttr: TdtAttribute;
                                            aDocID  : TDocID;
                                            CurList : TPersistent;
                                            Action  : TOperActionType);
//!! используется только в TSearchWin.ExecGroupOperation
var
 I,
 MaxI      : LongInt;
 lSubRec   : TDestHLinkRec;
 lDictType : TdaDictionaryType;

 function GetCurNumber(Item : LongInt) : LongInt;
 begin
  Result:=0;
  if CurList is TStrings
   then
    Result:=LongInt(TStrings(CurList).Objects[Item]);
  if CurList is Tl3CustomDataList
   then
    l3Move(Tl3CustomDataList(CurList).Data[Item]^,
         Result,
         Min(Tl3CustomDataList(CurList).DataSize, SizeOf(Result)));
 end;

begin
 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 lSubRec.Sub := 0;
 MaxI := 0;
 if CurList is TStrings then
  MaxI := Pred(TStrings(CurList).Count);
 if CurList is Tl3CustomDataList then
  MaxI := Pred(Tl3CustomDataList(CurList).Count);

 for I := 0 to MaxI do
 begin
  lSubRec.Doc := GetCurNumber(I);
  if (lDictType In sSubLinkDicts) then
   case Action Of
    atAdd    : TSubLinkTbl(Links[lDictType]).AddNode(aDocID, lSubRec);
    atDelete : TSubLinkTbl(Links[lDictType]).DelSubNode(aDocID, cAllSubs, lSubRec.Doc{Это DictID!!});
    atMove   : begin // Удаление всех в цикле? что-то странное Нужно проверить где используется atMove
                TSubLinkTbl(Links[lDictType]).DelAllSubNodes(aDocID, lSubRec.Sub);
                TSubLinkTbl(Links[lDictType]).AddNode(aDocID, lSubRec.Doc);
               end;
   end
   else
    case Action of
     atAdd    : Links[lDictType].AddNode(aDocID, lSubRec.Doc);
     atDelete : Links[lDictType].DelNode(aDocID, lSubRec.Doc);
     atMove   : begin // Удаление всех в цикле? что-то странное Нужно проверить где используется atMove
                 Links[lDictType].DelAllLinkItems(aDocID);
                 Links[lDictType].AddNode(aDocID, lSubRec.Doc);
                end;
    end;
 end;

 GlobalDataProvider.Journal.LogEditDoc(fFamily, aDocID, da_detDiction, lDictType);
end;

procedure TLinkServer.SetGroupDataList(aAttr: TdtAttribute; ID : LongInt;
                                       aAddList : Tl3CustomDataList);
var
 I       : LongInt;
 CurID   : TDictID;
 lDictType      : TdaDictionaryType;
begin
 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 For I := 0 to Pred(aAddList.Count) do
 begin
  l3Move(aAddList.Data[I]^,CurID,Links[lDictType].Table.fldLength[lnkDictIDFld]);
  if CurId = cUndefDictID then
  begin
   DictServer(Family).Tbl[lDictType].AddData(CurID,@aAddList.Data[I][Links[lDictType].Table.fldLength[lnkDictIDFld]]);
   Links[lDictType].AddNode(ID,CurID);
  end;
 end;

 GlobalDataProvider.Journal.LogEditDoc(fFamily, ID, da_detDiction, lDictType);
end;


(*procedure TLinkServer.SetGroupDateNumList(ID : LongInt;aAddList : Tl3CustomDataList);
var
 lSrchVal : TDNType;
 lMinDate : TStDate;

 lSab : ISab;

begin
 SetGroupDataList(atDateNums,ID,aAddList);

 lSab := MakeEmptySab(Links[da_dlDateNums]);
 lSab.Select(lnkDocIDFld, ID);
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.TransferToPhoto(dtIDFld, DictServer(Family).GroupTbl[da_dlDateNums]);
 lSab.RecordsByKey;
 lSrchVal:=dnPublish;
 lSab.SubSelect(dnTypFld, lSrchVal);
 lMinDate := lSab.GetMinValue(dnDateFld);
 DocumentServer(fFamily).FileTbl.UpdSortDate(ID, lMinDate);
end;*)


procedure TLinkServer.GetTreeList(aAttrID : TdtAttribute; ID : TDocID; Sub : TSubID; aList : Tl3StringDataList);
var
 CurRootNode : TDictRootNode;
 Bodies      : SAB;
 TmpID       : LongInt;
 lDataSize   : Integer;
 lDictID     : TdaDictionaryType;

begin
 lDictID := AttrID2DLType(aAttrID);

 if not IsDictClass(lDictID) then
  Exit;
 CurRootNode:=DictServer(Family).DictRootNode[lDictID].Use;
 try
  l3FillChar(Bodies,SizeOf(SAB));

  aList.Changing;
  try
   if lDictID in sSubLinkDicts
    then
     TSubLinkTbl(Links[lDictID]).GetSubNodes(ID,Sub,Bodies)
    else
     Links[lDictID].GetNodes(ID,Bodies);

   try
    aList.Clear;
    if Bodies.gFoundCnt > 0 then
     begin
      Ht(htOpenResults(Bodies,ROPEN_READ,nil,0));
      try
       lDataSize := DictServer(Family).DictTbl[lDictID].IDSize;
       if aList.DataSize < lDataSize then
        aList.DataSize := lDataSize;
       aList.NeedAllocStr:=True;

       TmpID := 0;
       While htReadResults(Bodies,@TmpID,lDataSize) <> 0 do
        aList.Add(PAnsiChar(DictServer(Family).Dict[lDictID].GetFullDictItemName(TDictID(TmpID))),@tmpID, lDataSize);

        {if DictServer(Family)DictTbl[lDictID].ItemList.Find(TmpID,tmpIndex) then
         begin
          l3GetFullPathAlloc(CurRootNode,
                                       TDictItem(DictServer(Family)DictTbl[lDictID].ItemList.Items[tmpIndex]).LinkNode,
                                       #13,
                                       '  ',
                                       False),
                                       @tmpID, lDataSize);

         end;}
      finally
       htCloseResults(Bodies);
      end;
     end;
   finally
    htClearResults(Bodies);
   end;
  finally
   aList.Changed;
  end;
 finally
  l3Free(CurRootNode);
 end;
end;

function TLinkServer.GetPriority(ID : LongInt) : Word;
var
 SourSab,
 TypeSab  : Sab;
 SourVal,
 TypeVal  : TDictID;
begin
 Links[da_dlSources].GetNodes(ID,SourSab);
 Links[da_dlTypes].GetNodes(ID,TypeSab);
 try
  if (SourSab.gFoundCnt<=1) and
     (TypeSab.gFoundCnt<=1)
    then
     begin
      if SourSab.gFoundCnt=1
       then
        begin
         Ht(htOpenResults(SourSab,ROPEN_READ,nil,0));
         try
          htReadResults(SourSab,@SourVal,SizeOf(SourVal));
         finally
          htCloseResults(SourSab);
         end;
        end
       else
        SourVal:=0;

      if TypeSab.gFoundCnt=1
       then
        begin
         Ht(htOpenResults(TypeSab,ROPEN_READ,nil,0));
         try
          htReadResults(TypeSab,@TypeVal,SizeOf(TypeVal));
         finally
          htCloseResults(TypeSab);
         end;
        end
       else
        TypeVal:=0;

      Result:=PriorityObj.GetPriorityOnValue(SourVal,TypeVal,True);
     end
    else
     Result:=PriorityObj.GetPriorityOnList(SourSab,TypeSab,True);
 finally
  htClearResults(SourSab);
  htClearResults(TypeSab);
 end;
end;

function TLinkServer.GetSelfMask : Word;
var
 lMask  : TTblMaskRec;
begin
 lMask := TTblMaskRec(AccessServer[MainTblsFamily,fFamily]);

 Result := lMask.AllowMask and not lMask.DenyMask;
end;

function TLinkServer.GetMask(aDoc : TDocID) : LongInt;
var
 Bodies  : Sab;
 TmpGroup: TDictID;
 GrMask  : TTblMask;
begin
 Result:=0;
 GrMask:=AccessServer[MainTblsFamily,fFamily];
 TLongWord(Result).HiWord:=TTblMaskRec(GrMask).AllowMask and
                           not TTblMaskRec(GrMask).DenyMask;
 GrMask:=0;
 Links[da_dlAccGroups].GetNodes(aDoc,Bodies);
 if Bodies.gFoundCnt<>0 then
  begin
   Ht(htOpenResults(Bodies,ROPEN_READ,nil,0));
   try
    while htReadResults(Bodies,@TmpGroup,SizeOf(TDictID))<>0 do
     GrMask:=GrMask or AccessServer[fFamily,TmpGroup];
   finally
    htCloseResults(Bodies);
   end;
  end
 else
  GrMask:=AccessServer[fFamily,0];

 if LogBook.IsDocHadAction(aDoc, acIncluded) then
  GrMask:=GrMask or AccessServer[fFamily,agIncludedGroup]
 else
  GrMask:=GrMask or AccessServer[fFamily,agNotIncludedGroup];

 TLongWord(Result).LoWord:=TTblMaskRec(GrMask).AllowMask and
                           not TTblMaskRec(GrMask).DenyMask;
end;

procedure TLinkServer.GetSubFlags(aDoc : TDocID; const aSubList: InevSubList);

procedure GetAssignedSubs(aAttrID : TdtAttribute; aDoc : TDocID; var theSubs : SAB);
var
 lSab : ISAB;
begin
 lSab := MakeSab(Attribute[aAttrID].Table);
 lSab.Select(lnkDocIDFld, aDoc);
 lSab.ValuesOfKey(lnkSubIDFld);
 theSubs := lSab.ExtractHTSab;
end;

const
 l_HtMask = sfKeyWords or sfTreeNodes or sfDocType or sfExpName;
var
 NamedSubs : Sab;
 TreeSubs  : Sab;
 KWSubs    : Sab;
 TypeSubs  : Sab;

 NamedS_ID,
 TreeS_ID,
 KWS_ID,
 TypeS_ID,
 AutoClass_ID  : TSubID;

 procedure GetTypeID;
 begin
  if htReadResults(TypeSubs,@TypeS_ID,Sizeof(TypeS_ID)) = 0 then
   TypeS_ID := High(TSubID);
 end;

 procedure GetTreeID;
 begin
  if htReadResults(TreeSubs,@TreeS_ID,Sizeof(TreeS_ID)) = 0 then
   TreeS_ID := High(TSubID);
 end;

 procedure GetKWID;
 begin
  if htReadResults(KWSubs,@KWS_ID,Sizeof(KWS_ID)) = 0 then
   KWS_ID := High(TSubID);
 end;

 procedure GetNamedID;
 begin
  if htReadResults(NamedSubs,@NamedS_ID,Sizeof(NamedS_ID)) = 0 then
   NamedS_ID := High(TSubID);
 end;

var
 l_Sub   : IevSub;
 TmpFlag : Byte;
 I       : TSubID;
 Max_ID  : TSubID;
begin
 NamedSubs := SubTbl.GetRealNamedSNums(aDoc,Max_ID);
 try
  GetAssignedSubs(atClasses, aDoc, TreeSubs);
  try
   GetAssignedSubs(atKeyWords, aDoc, KWSubs);
   try
    GetAssignedSubs(atTypes, aDoc, TypeSubs);
    try
      Ht(htOpenResults(NamedSubs,ROPEN_READ,nil,0));
      Ht(htOpenResults(TreeSubs,ROPEN_READ,nil,0));
      Ht(htOpenResults(KWSubs,ROPEN_READ,nil,0));
      Ht(htOpenResults(TypeSubs,ROPEN_READ,nil,0));
      try
       GetTreeID;
       GetKWID;
       GetNamedID;
       GetTypeID;
       I := 0;
       while (I <= Max_ID) do
       begin
        TmpFlag:=0;
        if (KWS_ID=I) then
        begin
         TmpFlag:=TmpFlag or sfKeyWords;
         GetKWID;
        end;
        if (TreeS_ID=I) then
        begin
         TmpFlag:=TmpFlag or sfTreeNodes;
         GetTreeID;
        end;
        if (NamedS_ID=I) then
        begin
         TmpFlag:=TmpFlag or sfExpName;
         GetNamedID;
        end;
        if (TypeS_ID=I) then
        begin
         TmpFlag:=TmpFlag or sfDocType;
         GetTypeID;
        end;
        if TmpFlag<>0 then
        begin
         l_Sub := aSubList.Sub[I];
         l_Sub.Flags := (l_Sub.Flags and not l_HtMask) or TmpFlag;
         l_Sub := nil;
        end;
        I := MinIntValue([NamedS_ID, TreeS_ID, KWS_ID, TypeS_ID]);
        // - выбираем следующий минимальный идентификатор Sub'а
       end;//I <= Max_ID
      finally
       htCloseResults(TypeSubs);
       htCloseResults(KWSubs);
       htCloseResults(TreeSubs);
       htCloseResults(NamedSubs);
      end;
    finally
     htClearResults(TypeSubs);
    end;
   finally
    htClearResults(KWSubs);
   end;
  finally
   htClearResults(TreeSubs);
  end;
 finally
  htClearResults(NamedSubs);
 end;
end;

procedure TLinkServer.AddSubNode(aAttr: TdtAttribute; aDoc : TDocID; aSub : TSubID; aDictID : LongInt);
var
 SubRec     : TDestHLinkRec;
 lDictType      : TdaDictionaryType;
begin
 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 if (lDictType in sSubLinkDicts) then
 begin
  SubRec.Doc:=aDictID;
  SubRec.Sub:=aSub;
  TSubLinkTbl(Links[lDictType]).AddNode(aDoc,SubRec);
 end
 else
  Links[lDictType].AddNode(aDoc,aDictID);

 GlobalDataProvider.Journal.LogEditDoc(fFamily, aDoc, da_detDiction, lDictType);
end;

procedure TLinkServer.AddNodeEx(aDictType: TdaDictionaryType; aNewRec: PAnsiChar);
 // структура aNewRec такая: LNK_RECORD + DICT_RECORD
var
 l_NewDictRec: PAnsiChar;
 l_NewLinkRec: PAnsiChar;

 l_DictIdSize: Integer;
 l_NewDictId: TDictID;
begin
 // для удобства вычленим
 l_NewLinkRec := aNewRec;
 l_NewDictRec := aNewRec + Links[aDictType].Table.RecSize;

 l_DictIdSize := DictServer(Family).Tbl[aDictType].IDSize;
 case l_DictIdSize of
  SizeOf(Word):
   l_NewDictId := PSmallint(l_NewDictRec)^;
  SizeOf(LongWord):
   l_NewDictId := PDictID(l_NewDictRec)^;
 end;

 if l_NewDictId = cUndefDictID then
 begin
  DictServer(Family).Tbl[aDictType].AddData(l_NewDictId,
                                    l_NewDictRec + l_DictIdSize);
  case l_DictIdSize of
   SizeOf(Word):
    begin
     PWord(l_NewLinkRec + SizeOf(TDocId))^ := l_NewDictId;
     PWord(l_NewDictRec)^ := l_NewDictId;
    end;
   SizeOf(LongWord):
    begin
     PLongWord(l_NewLinkRec + SizeOf(TDocId))^ := l_NewDictId;
     PLongWord(l_NewDictRec)^ := l_NewDictId;
    end;
  end;
 end;

 Links[aDictType].AddNodeEx(aNewRec);

 GlobalDataProvider.Journal.LogEditDoc(fFamily,
                                      PLinkRec(aNewRec)^.DocID,
                                      da_detDiction,
                                      aDictType);
end;

procedure TLinkServer.DelSubNode(aAttr: TdtAttribute; aDoc : TDocID; aSub : TSubID; aDictID : LongInt);
var
 lDictType      : TdaDictionaryType;
begin
 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 if (lDictType in sSubLinkDicts) then
  TSubLinkTbl(Links[lDictType]).DelSubNode(aDoc,aSub,aDictID)
 else
  Links[lDictType].DelNode(aDoc,aDictID);

 GlobalDataProvider.Journal.LogEditDoc(fFamily, aDoc, da_detDiction, lDictType);
end;

procedure TLinkServer.GetHistogramOfDictElementUsing(LT : TdaDictionaryType; ResList : Tl3DataList;
                                                     MinCount : LongInt);
var
 HistoSab : SAB;

 TmpRec   : PAnsiChar;

 TmpList  : TAbstractList;
 TmpMode  : TOpenMode;
 I        : LongInt;
begin
 if IsDictClass(LT) then
 begin
  HistoSab:=Links[LT].GetHistogramOfBodies(MinCount);
  try
   ResList.Changing;
   try
    ResList.Clear;
    TmpMode.openMode:=ROPEN_BODY;
    TmpMode.Count:=0;
    TmpMode.FldArr:=nil;
    TmpList:=TAbstractList.Create(@HistoSab,TmpMode);
    TmpList.ReadForvard:=True;
    try
     ResList.DataSize:=TmpList.ItemSize;
     for I:=0 to TmpList.Count-1 do
      begin
       TmpRec:=TmpList.GetItem(I);
       ResList.Add(TmpRec);
      end;
    finally
     l3Free(TmpList);
    end;
   finally
    ResList.Changed;
   end;
  finally
   htClearResults(HistoSab);
  end;
 end
 else
  raise EHtErrors.CreateInt(ecNotEnable);
end;

procedure TLinkServer.CopyLinks(aAttr: TdtAttribute;
                                aFieldNum: Smallint; // либо lnkDocIDFld, либо lnkDictIDFld. И ничего иного.
                                aSrcId: Integer;
                                aDstId: Integer);

 function lRecModifyProc(aBuffer : Pointer) : Boolean;
 begin
  if (aFieldNum = lnkDocIDFld) then
     PSubLinkRec(aBuffer)^.DocID := aDstId
  else
  if (aFieldNum = lnkDictIDFld) then
   PSubLinkRec(aBuffer)^.DictID := aDstId;

  Result := True;
 end;

var
 l_Table: TPrometTbl;

 lSab : ISab;
 lRecModifyProcStub : TdtRecAccessProc;

 lDictType      : TdaDictionaryType;
begin
 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 Assert((aFieldNum = lnkDocIDFld) or (aFieldNum = lnkDictIDFld),
        'Вызов TLinkServer.CopyLinks с неверным параметром aFieldNum');

 l_Table := Links[lDictType].Table;

 lSab := MakeSab(l_Table);
 lSab.Select(aFieldNum, aSrcId);
 // заносим получившиеся записи в таблицу

 lRecModifyProcStub := L2RecAccessProc(@lRecModifyProc);
 try
  l_Table.CopyRecs(lSab.HTSab, lRecModifyProcStub);
 finally
  FreeRecAccessProc(lRecModifyProcStub);
 end;

 // запись в лог
 GlobalDataProvider.Journal.LogEditDoc(fFamily, aDstId, da_detDiction, lDictType);
end;

procedure TLinkServer.CopyLinks(aAttr: TdtAttribute;
                                const aSrcNodePath, aDstNodePath: Tl3WString;
                                const aLevelSlash: AnsiString);
var
 l_SrcDictId,
 l_DstDictId: TDictID;
lDictType      : TdaDictionaryType;
begin
 lDictType := AttrID2DLType(aAttr);
 Assert(lDictType <> da_dlNone, 'Не словарный атрибут');

 l_SrcDictId := DictServer(Family).Dict[lDictType].FindIdByFullPath(aSrcNodePath, aLevelSlash);
 l_DstDictId := DictServer(Family).Dict[lDictType].FindIdByFullPath(aDstNodePath, aLevelSlash);
 if (l_SrcDictId <> cUndefDictID) and (l_DstDictId <> cUndefDictID) then
  CopyLinks(aAttr, lnkDictIDFld, l_SrcDictId, l_DstDictId);
end;

procedure TLinkServer.VerifyLink(aDictType : TdaDictionaryType; aReportFile : PText; aWithCorrect : Boolean);

 procedure lProcessWrongItems(const aSab : ISab; aReportName : AnsiString);
  var
  lNeedComma : Boolean;
  lStub : TdtRecAccessProc;

  function lRecAccessProc(aRec : Pointer) : Boolean;
   begin
    Result := True;
    if lNeedComma then
     Write(aReportFile^, ', ');
    Write(aReportFile^, PDictID(aRec)^);
    lNeedComma := True;
   end;

 begin
  if aSab.Count > 0 then
  begin
   lStub := L2RecAccessProc(@lRecAccessProc);
   try
    lNeedComma := False;
    Write(aReportFile^,' ** '+aReportName+': ');
    aSab.IterateRecords(lStub);
    WriteLn(aReportFile^);
   finally
    FreeRecAccessProc(lStub);
   end;
   if aWithCorrect then
   begin
    aSab.RecordsByKey;
    aSab.DeleteFromTable;
    WriteLn(aReportFile^,' ## Записи удалены;');
   end;
  end;  
 end;

var
 lSab  : ISab;

begin
 if not Assigned(aReportFile) then Exit;

 lSab := MakeAllRecords(DictServer(Family).Tbl[aDictType]);
 lSab.ValuesOfKey(dtIDFld);
 lSab.TransferToPhoto(lnkDictIDFld, Links[aDictType]);
 lSab.RecordsByKey;
 lSab.InvertSab;
 lSab.ValuesOfKey(lnkDictIDFld);
 lProcessWrongItems(lSab, 'Несуществующие элементы словаря');

 lSab := MakeAllRecords(DocumentServer(fFamily).FileTbl);
 lSab.ValuesOfKey(fId_Fld);
 lSab.TransferToPhoto(lnkDocIDFld, Links[aDictType]);
 lSab.RecordsByKey;
 lSab.InvertSab;
 lSab.ValuesOfKey(lnkDocIDFld);
 lProcessWrongItems(lSab, 'Несуществующие документы');

 //GlobalHtServer.FreeTbl[fFamily].CheckFreeNumbers(FDicts[aDictType].Obj.TblName,DtID);
 //WriteLn(ReportFile^,' - Свободные номера проверены;');


end;


Initialization
Finalization
 FreeLinkServer;
end.
