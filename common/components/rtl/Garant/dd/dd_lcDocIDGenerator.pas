unit dd_lcDocIDGenerator;
{ Генерация номеров для постановлений от различных источников }

{ $Id: dd_lcDocIDGenerator.pas,v 1.29 2015/07/02 11:41:28 lukyanets Exp $ }
// $Log: dd_lcDocIDGenerator.pas,v $
// Revision 1.29  2015/07/02 11:41:28  lukyanets
// Описываем словари
//
// Revision 1.28  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.27  2014/04/17 13:04:46  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.26  2014/04/07 09:59:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.25  2013/04/15 05:59:22  narry
// Не собиралось
//
// Revision 1.24  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.23  2013/02/18 09:19:43  narry
// Импортируются повторные документы (430743967)
//
// Revision 1.22  2013/02/15 12:22:00  narry
// Импортируются повторные документы (430743967)
//
// Revision 1.21  2012/12/28 09:25:14  narry
// Переход со списка на таблицу
//
// Revision 1.20  2012/09/10 08:35:38  narry
// Для пустых документов возвращает -1
//
// Revision 1.19  2012/08/13 12:22:14  narry
// Повторы при импорте судебных решений (381880048)
//
// Revision 1.18  2011/10/20 12:27:40  narry
// Не заливаются Определения ВАС (294596306)
//
// Revision 1.17  2011/09/13 05:33:39  narry
// Размноженные номера размножают хронологию (265410470)
//
// Revision 1.16  2011/07/01 11:56:06  narry
// Уточнение алгоритма проверки
//
// Revision 1.15  2011/06/28 14:00:47  narry
// Многообразие команды !CASECODE (269061913)
//
// Revision 1.13  2011/06/28 09:52:07  narry
// Многообразие команды !CASECODE (269061913)
//
// Revision 1.12  2011/06/09 11:56:23  narry
// Проверка документов ФАС при импорте на повторы (268340187)
//
// Revision 1.11  2011/06/07 11:22:59  narry
// Проверка документов ФАС при импорте на повторы (268340187)
//
// Revision 1.10  2011/06/03 11:57:48  narry
// Прикрутить обновление кэшей автопростановщика к Парню (266406580)
//
// Revision 1.9  2011/06/02 13:18:47  narry
// no message
//
// Revision 1.8  2011/04/13 05:51:46  narry
// Не определяются повторы постановлений (261980213)
//
// Revision 1.7  2011/04/01 12:15:54  narry
// 259885188 Справка для ФАС
//
// Revision 1.6  2011/04/01 09:07:00  narry
// К259884509.Диапазоны номеров
//

interface

uses
 l3Variant,
 ddHeaderFilter,
 dt_Types,
 l3LongintList, l3Date,
 k2Interfaces, k2TagGen,
 l3FieldSortRecList,
 ddTypes,
 l3RecList,
 dd_lcBaseHeaderFilter,
 dt_Table
 ;

type
 PDocInfoRec = ^TDocInfoRec;
 TDocInfoRec = packed record
  DocDate: TstDate;
  DocCode: TNumberStr;
  DocID: TDocID;
 end;

 PFASDocInfoRec = ^TFASDocInfoRec;
 TFASDocInfoRec = packed record
  DocDate: TstDate;
  DocCaseCode: TNumberStr;
  DocType: TDictID;
  //DocID: TDocID;
 end;

 TNewDocIDEvent = procedure (DocID: TDocID; IsDuplicate: Boolean) of Object;
 TDocIDGenerator = class(Tdd_lcBaseHeaderFilter)
 private
  f_DocList: Tl3FieldSortRecList;
  f_CurDocList: Tl3RecList;
  f_CurFASDocList: Tl3RecList;
  f_DocTable: TdtTable;
  f_FASDocList: Tl3RecList;
  f_OnNewDoc: TNewDocIDEvent;
  f_RepeatCount: Integer;
  f_SourcesList: Tl3LongintList;
  f_FASSourcesList: Tl3LongintList;
  f_TypesList: Tl3LongintList;
  function GetDiapasonAlias(aRoot: Tl3Variant): AnsiString;
  procedure ClearDocumentsList;
  procedure ExtractDateNumber(aHeaderRoot: Tl3Variant);
  procedure FillDocumentsList;
  procedure FillFASList;
  function GenerateDocId(const Alias: AnsiString): Integer;
  procedure NormalizeCaseCodes(aList: Tl3FieldSortRecList);
  function NotDuplicate(out aDocID: TDocID; IsFAS: Boolean): Boolean;
  procedure pm_SetSources(const Value: AnsiString);
  procedure pm_SetSourcesList(const Value: Tl3LongintList);
  procedure pm_SetFASSourcesList(const Value: Tl3LongintList);
  procedure pm_SetTypes(const Value: AnsiString);
  procedure pm_SetTypesList(const Value: Tl3LongintList);
  procedure Str2List(const aStr: AnsiString; aList: Tl3LongintList);
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
        {-}
  procedure Cleanup; override;
    {internal methods}
  procedure OpenStream; override;
 public
    // public methods
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  class procedure GetNewDocID(var DocID: TDocID; const Alias: AnsiString);
  property RepeatCount: Integer read f_RepeatCount;
  property Sources: AnsiString write pm_SetSources;
  property SourcesList: Tl3LongintList read f_SourcesList write pm_SetSourcesList;
  property FASSourcesList: Tl3LongintList read f_FASSourcesList write
      pm_SetFASSourcesList;
  property Types: AnsiString write pm_SetTypes;
  property TypesList: Tl3LongintList read f_TypesList write pm_SetTypesList;
  property OnNewDoc: TNewDocIDEvent read f_OnNewDoc write f_OnNewDoc;
 end;

implementation

uses
   l3Base, k2Tags, Math, SysUtils, daTypes, Dt_Serv, dt_AttrSchema,
 DT_Const, Dt_Query, dtIntf, dt_Sab, DT_Doc, DT_LinkServ, DT_Link, DT_DictConst, DT_Dict, DT_Renum,
 rxStrUtils, StrUtils, l3ProtoPtrRecListPrim, dd_lcSourceUtils, dd_lcUtils,
 {dd_lcCodeCorrector,} HT_Const, HT_Dll, l3FileUtils, dt_err, ddUtils,
 dt_Record;


constructor TDocIDGenerator.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_SourcesList:= Tl3LongintList.Make;
 f_FASSourcesList:= Tl3LongintList.Make;
 f_TypesList:= Tl3LongintList.Make;
 f_CurDocList := Tl3RecList.Create(Sizeof(TDocInfoRec));
 f_CurFASDocList := Tl3RecList.Create(Sizeof(TFASDocInfoRec));
end;

procedure TDocIDGenerator.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_DateNums, l_DN: Tl3Tag;
 i: Integer;
 l_Str: TNumberStr;
 l_S: AnsiString;
 l_ExtID: TDocID;
 l_Msg: AnsiString;
begin
 ExtractDateNumber(aHeaderRoot);
 l_ExtID:= GenerateDocID(GetDiapasonAlias(aHeaderRoot));

 if Assigned(f_OnNewDoc) and (aHeaderRoot.IntA[k2_tiType] <> Ord(dtRelText)) then
   f_OnNewDoc(Abs(l_ExtID), l_ExtID < 0);
 if l_ExtID > 0 then
  aheaderRoot.IntA[k2_tiExternalHandle]:= l_ExtID
 else
 begin
  l_Msg:= '-> Повтор постановления '+ IntToStr(Abs(l_ExtID));
  ErrorReaction(l_Msg);
  Inc(f_RepeatCount);
 end;
end;

function TDocIDGenerator.GetDiapasonAlias(aRoot: Tl3Variant): AnsiString;
var
 l_Sources: Tl3Variant;
 l_Source: Tl3Variant;
 i: Integer;
begin
 Result:= lc_defAlias;
 l_Sources:= aRoot.Attr[k2_tiSources];
 if l_Sources.Isvalid then
  for i:= 0 to Pred(l_Sources.ChildrenCount) do
  begin
   l_Source:= l_Sources.Child[i];
   Result:= Source2Alias(l_Source.StrA[k2_tiName])
  end; // for i
end;

procedure TDocIDGenerator.Cleanup;
begin
 ClearDocumentsList;
 FreeAndNil(F_CurDocList);
 FreeAndNil(F_CurFASDocList);
 FreeAndNil(f_SourcesList);
 FreeAndNil(f_FASSourcesList);
 FreeAndNil(f_TypesList);
 inherited;
end;

procedure TDocIDGenerator.ClearDocumentsList;
begin
 if f_DocTable <> nil then
 begin
  f_DocTable.DropTable;
  FreeAndNil(f_DocTable);
 end;
 FreeAndNil(f_DocList);
 FreeAndNil(f_FASDocList);
end;

procedure TDocIDGenerator.ExtractDateNumber(aHeaderRoot: Tl3Variant);
var
 l_DateNums: Tl3Variant;
 l_DN: Tl3Variant;
 l_Types: Tl3Variant;
 i: Integer;
 l_Str: TNumberStr;
 l_S, l_STwin: AnsiString;
 l_CurDoc: TDocInfoRec;
 l_CurFASDoc, l_CurFASDocTwin: TFASDocInfoRec;
 l_Type: TDictID;
begin
 f_CurDocList.Clear;
 f_CurFASDocList.Clear;
 l_Types:= aHeaderRoot.Attr[k2_tiTypes];
 if (l_Types.IsValid) and (l_Types.ChildrenCount > 0) then
  l_Type:= DictServer(CurrentFamily).Dict[da_dlTypes].FindIDByFullPath(l_Types.Child[0].PCharLenA[k2_tiName]);

 l_DateNums:= aHeaderRoot.Attr[k2_tiNumANDDates];
 if l_DateNums.Isvalid then
  for i:= 0 to Pred(l_DateNums.ChildrenCount) do
  begin
   l_DN:= l_DateNums.Child[i];
   if l_DN.IntA[k2_tiType] = Ord(dnPublish) then
   begin
    l_CurDoc.DocDate:= l_DN.IntA[k2_tiStart];
    l_CurFASDoc.DocDate:= l_DN.IntA[k2_tiStart];;
    l3FillChar(l_Str, cDNNumberLen, 32);
    l_CurDoc.DocCode:= l_Str;
    l_S:= l_DN.StrA[k2_tiNumber];
    if (l_S <> '') then
    begin
     l3Move(l_S[1], l_Str, Min(Length(l_S), cDNNumberLen));
     l_CurDoc.DocCode:= l_Str;
     f_CurDocList.Add(l_CurDoc);
    end; // l_S <> ''
   end // l_DN.IntA[k2_tiType] = Ord(dnPublish)
   else
   if l_DN.IntA[k2_tiType] = Ord(dnLawCaseNum) then
   begin
    l3FillChar(l_Str, cDNNumberLen, 32);
    l_CurFASDoc.DocType:= l_Type;
    l_CurFASDoc.DocCaseCode:= l_Str;
    l_S:= l_DN.StrA[k2_tiNumber];
    if (l_S <> '') then
    begin
     l_STwin:= MakeTwinNumber(l_S);
     l3Move(l_S[1], l_Str, Min(Length(l_S), cDNNumberLen));
     l_CurFASDoc.DocCaseCode:= l_Str;
     f_CurFASDocList.Add(l_CurFASDoc);
     l3Move(l_CurFASDoc, l_CurFASDocTwin, SizeOf(TFASDocInfoRec));
     l3FillChar(l_Str, cDNNumberLen, 32);
     l3Move(l_STwin[1], l_Str, Min(Length(l_STwin), cDNNumberLen));
     l_CurFASDocTwin.DocCaseCode:= l_Str;
     f_CurFASDocList.Add(l_CurFASDocTwin);
    end; // l_S <> ''
   end;
  end; // for i
end;

function TDocIDGenerator.GenerateDocId(const Alias: AnsiString): Integer;
var
 l_Doc: PDocInfoRec;
 i: Integer;
begin
 if (not f_CurDocList.Empty) or (not f_CurFASDocList.Empty) then
 begin
  if NotDuplicate(Result, IsFASAlias(Alias)) then
  begin
   GetNewDocID(Result, Alias);
   if IsFASAlias(Alias) then
   begin
    if (f_FASDocList <> nil) and not f_CurFASDocList.Empty then
    begin
     for i:= 0 to f_CurFASDocList.Hi do
      f_FASDocList.Add(f_CurFASDocList.ItemSlot(i)^);
    end
   end
   else
   begin
    if (f_DocList <> nil) and not f_CurDocList.Empty then
    begin
     for i:= 0 to f_CurDocList.Hi do
     begin
      PDocInfoRec(f_CurDocList.ItemSlot(i))^.DocID:= Result;
      f_DocList.Add(f_CurDocList.ItemSlot(i)^);
     end;
    end
   end;
  end // NotDuplicate(Result, IsFASAlias(Alias))
 end
 else
  Result:= -1;
end;

class procedure TDocIDGenerator.GetNewDocID(var DocID: TDocID; const Alias: AnsiString);
begin
 if GlobalHTServer.FreeTbl[CurrentFamily].AnyRangesPresent(Alias) then
  DocID:= GlobalHTServer.FreeTbl[CurrentFamily].GetFree(Alias)
 else
  DocID:= -1;
end;

procedure TDocIDGenerator.OpenStream;
begin
 inherited;
 FillDocumentsList;
 FillFASList;
 f_RepeatCount:= 0;
end;

procedure TDocIDGenerator.FillDocumentsList;
var
 l_ResQuery: TdtAndQuery;
 l_Q       : TdtQuery;
 lDocIDSab : ISab;
 lsab      : ISab;
 lSabLnk   : ISab;
 lRenumSab : ISab;
 lJoinSab: IJoinSab;
 lJoinSab2: IJoinSab;
 lJoinSabSum : IJoinSab;
 l_List: Tl3LongintList;
 l_ID: TDocID;

 l_TableHandle: THandle;
 l_Fields: TFieldArray;
 l_TableSab: Sab;
 l_TableName: AnsiString;
const
 lDNDocType : TDNType = dnPublish;
 lZDate : TstDate = 0;
 asElem: array[1..4] of ThtElementInfo = (
  (wLength:0; wOffset:0; cClass: EC_FIELD; cType: ET_DWRD; cKey: EK_NOTKEY; mName: 'Date'),
  (wLength:50; wOffset:0; cClass: EC_FIELD; cType: ET_CHAR; cKey: EK_NOTKEY; mName: 'Number'),
  (wLength:0; wOffset:0; cClass: EC_FIELD; cType: ET_DWRD; cKey: EK_NOTKEY; mName: 'DocID'),
  (wLength:2; wOffset:1; cClass: EC_GROUP; cType: ET_CHAR; cKey: EK_UNIQUE; mName: 'DateNumber')
  );
begin
 if f_DocList = nil then
 begin
  l3System.Msg2Log('Создание списка постановлений...');
  l_ResQuery := TdtAndQuery.Create;
  try
   l_Q := TdtDictQuery.Create(da_dlSources, f_SourcesList, False, True {WithSubTree});
   l_ResQuery.AddQueryF(l_Q);

   l_Q := TdtDictQuery.Create(da_dlTypes, f_TypesList, False, True {WithSubTree});
   l_ResQuery.AddQueryF(l_Q);
   lDocIDSab:= l_ResQuery.FoundList;
  finally
   l3Free(l_ResQuery);
  end;
  //lDocIDSab;
  lSab := MakeSabCopy(lDocIDSab);
  lSab.ValuesOfKey(fId_Fld);
  lRenumSab := MakeSabCopy(lSab);
  lSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
  lSab.RecordsByKey;

  lSabLnk := MakeSabCopy(lSab);

  lSab.ValuesOfKey(lnkDictIDFld);
  lSab.TransferToPhoto(dnIDFld, DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  lSab.RecordsByKey;
  lSab.SubSelect(dnTypFld, lDNDocType);
  lSab.SubSelect(dnDateFld, lZDate, GREAT);


  lJoinSab := MakeJoinSab(lSab, dnIDFld,
                          lSabLnk, lnkDictIDFld);

  lRenumSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atRenum]);
  lRenumSab.RecordsByKey;
  //l_ID:= 52935344;
  //lRenumSab.SubSelect(rnImportID_fld, l_ID);

  lJoinSab2 := MakeJoinSab(lSabLnk, lnkDocIDFld,
                           lRenumSab, rnRealID_fld);


  lJoinSabSum := MakeJoinSab(lJoinSab, lJoinSab2, True);

  (*
  lJoinSabSum.SortJoin([JFRec(lSab.Table, dnDateFld), JFRec(lSab.Table, dnNumFld)]);
  f_DocList := dtMakeRecListByJoinSab(lJoinSabSum, [JFRec(lSab.Table, dnDateFld),
                                                    JFRec(lSab.Table, dnNumFld),
                                                    JFRec(lRenumSab.Table, rnImportID_fld)], [1,2]);
  *)
  l_TableName:= GetAppFolderFileName('DatNumID', True);
  DeleteFilesByMask(ExtractFileDir(l_tableName), ChangeFileExt(ExtractFileName(l_TableName), '.*'));
  htTableCreate(PAnsiChar(l_TableName), @asElem, 4, nil, nil, nil, TAB_PRIVATE or TAB_ANSI, l_TableHandle);
  l_Fields:= lJoinSabSum.TranslateFieldNumber([JFRec(lSab.Table, dnDateFld),
                                               JFRec(lSab.Table, dnNumFld),
                                               JFRec(lRenumSab.Table, rnImportID_fld)]);
  l_TableSab:= lJoinSabSum.HTSab;
  HT(htResultsToTable(l_TableSab, l_TableHandle, nil, nil, nil, @l_Fields[0], 3, False, False));
  htTableClose(l_TableHandle);
  f_DocTable:= TdtTable.CreateWithOpen(ExtractFilePath(l_TableName), '', ExtractFileName(l_TableName), 0);
  f_DocTable.UpdateTbl;

  f_DocList:= Tl3FieldSortRecList.Create(SizeOf(TDocInfoRec), [SizeOf(TstDate), SizeOf(TNumberStr)], [1, 2]);

  l3System.Msg2Log('... создан');
 end; // f_DocList = nil
end;

procedure TDocIDGenerator.FillFASList;
var
 l_ResQuery: TdtAndQuery;
 l_Q       : TdtQuery;
 lDocIDSab : ISab;
 lsab      : ISab;
 lSabLC    : ISab;
 lSabLnk   : ISab;
 lRenumSab : ISab;
 lTypeSab  : ISab;
 lSabDoc   : ISab;
 l_List: Tl3LongintList;
 l_ID: TDocID;
 lDNTblDupLC : TdtTable;
 lJoinDN_LC: IJoinSab;
 lJoinDN_LC_Type: IJoinSab;
 lJoinDoc_DNLink: IJoinSab;
 //lJoinDoc_LCLink: IJoinSab;
 lJoinDoc_DN: IJoinSab;
 lJoinDoc_LC: IJoinSab;
 lJoinDoc_Renum: IJoinSab;
 lJoinDoc_TypeLink : IJoinSab;
 lJoinSabDNlink: IJoinSab;
 lJoinSabLClink: IJoinSab;
 lJoinSabSum : IJoinSab;
 l_FasDocList: Tl3FieldSortRecList;
const
 lDNDocTypePubl : TDNType = dnPublish;
 lDNDocTypeLC : TDNType = dnLawCaseNum;
 lZDate : TstDate = 0;
begin
 if f_FasDocList = nil then
 begin
  l3System.Msg2Log('Создание списка постановлений ФАС...');
  l_ResQuery := TdtAndQuery.Create;
  try
   l_Q := TdtDictQuery.Create(da_dlSources, f_FASSourcesList, False, True {WithSubTree});
   l_ResQuery.AddQueryF(l_Q);

   l_Q := TdtDictQuery.Create(da_dlTypes, f_TypesList, False, True {WithSubTree});
   l_ResQuery.AddQueryF(l_Q);
   lDocIDSab:= l_ResQuery.FoundList;
  finally
   l3Free(l_ResQuery);
  end;
  {Для проверки конкретного документа:}
  //l_ID:= 1318764;
  //lDocIDSab.SubSelect(1, l_ID);

  //lDocIDSab;
  lSabDoc := MakeSabCopy(lDocIDSab);
  lSab := MakeSabCopy(lSabDoc);

  lSab.ValuesOfKey(fId_Fld);
  lRenumSab := MakeSabCopy(lSab);
  lTypeSab := MakeSabCopy(lSab);

  lSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
  lSab.RecordsByKey;

  lSabLnk := MakeSabCopy(lSab);

  lSab.ValuesOfKey(lnkDictIDFld);

  lSabLC := MakeSabCopy(lSab); // сделали копию

  //получим даты
  lSab.TransferToPhoto(dnIDFld, DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  lSab.RecordsByKey;
  //lSab2 := SabCopy(lSab);

  lSab.SubSelect(dnTypFld, lDNDocTypePubl);
  lSab.SubSelect(dnDateFld, lZDate, GREAT);

  //получим LC номера
  lDNTblDupLC := TdtTable.CreateDup(DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  try
   lSabLC.TransferToPhoto(dnIDFld, lDNTblDupLC);
   lSabLC.RecordsByKey;
   lSabLC.SubSelect(dnTypFld, lDNDocTypeLC);

  //получим типы
   //lTypeSab := MakeSabCopy(lDocIDSab);
   //lTypeSab.ValuesOfKey(fId_Fld);
   lTypeSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily).Attribute[atTypes]);
   lTypeSab.RecordsByKey;

   //lTypeSab.ValuesOfKey(lnkDictIDFld);

   //получим Renum
   lRenumSab.TransferToPhoto(rnRealID_fld, LinkServer(CurrentFamily).Attribute[atRenum]);
   lRenumSab.RecordsByKey;

   //объединим DN-Link
   {1}
   lJoinSabDNlink := MakeJoinSab(lSabLnk, lnkDictIDFld,
                                 lSab, dnIDFld);

   //объединим DNLC-Link
   {2}
   lJoinSabLClink := MakeJoinSab(lSabLnk, lnkDictIDFld,
                                 lSabLC, dnIDFld);

   //Doc-DNLink
   {3}
   lJoinDoc_DNLink := MakeJoinSab(lSabDoc,fId_Fld,
                                  lSabLnk, lnkDocIDFld);

   //Doc-DN
   {3-1}
    lJoinDoc_DN := MakeJoinSab(lJoinDoc_DNLink, lJoinSabDNLink, True);

   //Doc-LC
   {3-2}
    lJoinDoc_LC := MakeJoinSab(lJoinDoc_DNLink, lJoinSabLCLink, True);

   //DN-LC
   {1-2}
    lJoinDN_LC := MakeJoinSab( lJoinDoc_DN, lJoinDoc_LC);

   //Doc-Type
   {4}
   lJoinDoc_TypeLink := MakeJoinSab(lTypeSab, lnkDocIDFld,
                                  lSabDoc,fId_Fld);

   //DN-LC-Type
   {1-2-4}
   lJoinDN_LC_Type := MakeJoinSab(lJoinDN_LC, lJoinDoc_TypeLink);

   //Doc-Renum
   {5}
   lJoinDoc_Renum := MakeJoinSab(lRenumSab, rnRealID_fld,
                                 lSabDoc,fId_Fld);

   //DN-LC-Type-Renum
   {1-2-4-5}
   //lJoinSabSum := MakeJoinSab(lJoinDoc_Renum, lJoinDN_LC_Type, True);
   //L3System.Msg2Log('lJoinDN_LC_Type.Count=%d', [lJoinDN_LC_Type.Count]);

   lJoinSabSum := lJoinDN_LC_Type;
   lJoinSabSum.SortJoin([JFRec(lSab.Table, dnDateFld), JFRec(lSab.Table, dnNumFld)]);

   l_FASDocList := dtMakeRecListByJoinSab(lJoinSabSum, [JFRec(lSab.Table, dnDateFld),
                                                     JFRec(lSabLC.Table, dnNumFld),
                                                     JFRec(lTypeSab.Table, lnkDictIDFld){,
                                                     JFRec(lRenumSab.Table, rnImportID_fld)}], [1,2,3]);
   try
    NormalizeCaseCodes(l_FASDocList);
   finally
    FreeAndNil(l_FASDocList);
   end;
  finally
   FreeAndNil(lDNTblDupLC);
  end;
 end; // f_DocList = nil
 l3System.Msg2Log('... создан');
end;

procedure TDocIDGenerator.NormalizeCaseCodes(aList: Tl3FieldSortRecList);
var
 i, j: Integer;
 l_YearStart: Integer;
 l_Doc: TFASDocInfoRec;
 l_LeftPart, l_Year: AnsiString;
 l_List: Tl3FieldSortRecList;
begin
 if f_FASDocList <> nil then Exit;
  f_FASDocList:= Tl3RecList.Create(Sizeof(TFASDocInfoRec));
  for i:= 0 to aList.Hi do
  begin
   l_Doc:= PFASDocInfoRec(aList.ItemSlot(i))^;
   j:= 1;
   if l_Doc.DocCaseCode[j] in ['А', 'а', 'A', 'a'] then
   begin
    l_Doc.DocCaseCode[j]:= 'А';
    while (j <= cDNNumberLen) and not (l_Doc.DocCaseCode[j] in ['/', #0]) do
     Inc(j);
    if j <= cDNNumberLen then
    begin
     l_YearStart:= Succ(j);
     j:= l_YearStart;
     l_Year:= '';
     while (j <= cDNNumberLen) and (l_Doc.DocCaseCode[j] in ['0'..'9']) do
     begin
      l_Year:= l_Year + l_Doc.DocCaseCode[j];
      Inc(j);
     end; // (j <= cDNNumberLen) and (l_Doc.DocCaseCode[j] in ['0'..'9'])
     if (j <=cDNNumberLen) and (Length(l_Year) in [2, 4]) then
     begin
      if inRange(StrToInt(l_Year), 0, 30) then
       l_Year:= '20'+l_Year
      else
      if inRange(StrToInt(l_Year), 31, 99) then
       l_Year:= '19'+l_Year;
      l3FillChar(l_Doc.DocCaseCode[l_YearStart], cDNNumberLen-l_YearStart+1, 32);
      l3Move(l_Year[1], l_Doc.DocCaseCode[l_YearStart], 4);
      f_FASDocList.Add(l_Doc);
     end; // j <=cDNNumberLen
    end; // j <= cDNNumberLen
   end; // l_Doc.DocCaseCode[j] = 'А'
 //  else
 //   l3System.Msg2Log('%s (%x)', [l_Doc.DocCaseCode[j], Ord(l_Doc.DocCaseCode[j])]);
  end; // for i
end;

function TDocIDGenerator.NotDuplicate(out aDocID: TDocID; IsFAS: Boolean):
    Boolean;
var
 l_Index, I: Integer;
 l_Rec: TdtRecord;
 l_Buf: Array[0..SizeOf(TDocInfoRec)] of Byte;
 l_Key: TDocInfoRec;
 l_Value: Array[0..53] of Byte;
begin
 Result := True;
 if IsFAS then
 begin
  if (f_FASDocList <> nil) then
   for i:= 0 to f_CurFASDocList.Hi do
   begin
    if f_FASDocList.Find(f_CurFASDocList.ItemSlot(i)^, l_Index) then
    begin
     aDocID:= -1; // aDocID < 0 - дубликат. Никогда не перезаливаем постановления
     Result:= false{aDocID > 0};
     break;
    end; //
   end
 end
 else
 begin
  // Сначала ищем по таблице
  if {f_DocList}f_DocTable <> nil then
   for i:= 0 to f_CurDocList.Hi do
   begin
    l_Key:= PDocInfoRec(f_CurDocList.ItemSlot(i))^;
    l_Rec:= f_DocTable.GetRecordByUniq(l_Key);
    if l_Rec.WasFound then
    begin
     l_Rec.GetTo(@l_Buf[0]);
     aDocID:= -PDocInfoRec(@l_Buf[0]).DocID; // ID < 0 - дубликат. Никогда не перезаливаем постановления
     Result:= false;
     break;
    end; // l_Rec.WasFound
   end; // for i
  if Result and (f_DocList <> nil) then
   for i:= 0 to f_CurDocList.Hi do
    if f_DocList.FindRecord(f_CurDocList.ItemSlot(i)^, l_Index) then
    begin
     aDocID:= -PDocInfoRec(f_DocList.Itemslot(l_Index))^.DocID; // ID < 0 - дубликат. Никогда не перезаливаем постановления
     Result:= false;
     break;
    end; //
 end;
end;

procedure TDocIDGenerator.pm_SetSources(const Value: AnsiString);
begin
 Str2List(Value, f_SourcesList);
end;

procedure TDocIDGenerator.pm_SetSourcesList(const Value: Tl3LongintList);
begin
 f_SourcesList.Assign(Value);
end;

procedure TDocIDGenerator.pm_SetFASSourcesList(const Value: Tl3LongintList);
begin
 f_FASSourcesList.Assign(Value);
end;

procedure TDocIDGenerator.pm_SetTypes(const Value: AnsiString);
begin
 Str2List(Value, f_TypesList);
end;

procedure TDocIDGenerator.pm_SetTypesList(const Value: Tl3LongintList);
begin
 f_TypesList.Assign(Value);
end;

procedure TDocIDGenerator.Str2List(const aStr: AnsiString; aList: Tl3LongintList);
var
 i: Integer;
 l_ID: Integer;
begin
 aList.Clear;
 for i:= 1 to WordCount(aStr, [';',',']) do
 begin
  l_ID:= StrToIntDef(ExtractWord(i, aStr, [';',',']), 0);
  if l_ID > 0 then
   aList.Add(l_ID);
 end;
end;

end.
