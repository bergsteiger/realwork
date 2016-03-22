unit alcuCourtDecision;
{ Простановка меток FirstSubNumber и SecondSubNumber в Судебных решениях }

{ $Id: alcuCourtDecision.pas,v 1.8 2016/02/29 07:07:18 lukyanets Exp $ }

// $Log: alcuCourtDecision.pas,v $
// Revision 1.8  2016/02/29 07:07:18  lukyanets
// Не собиралось
//
// Revision 1.7  2015/11/26 08:45:26  lukyanets
// КОнстанты переехали
//
// Revision 1.6  2015/07/02 07:34:38  lukyanets
// Описываем словари
//
// Revision 1.5  2015/06/11 13:39:40  fireton
// - проверяем строку на nil
//
// Revision 1.4  2015/04/07 07:35:53  lukyanets
// Изолируем HT
//
// Revision 1.3  2014/09/09 13:42:44  lukyanets
// Готовимся размножать AACImportTask
//
// Revision 1.2  2014/08/05 06:30:30  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.1  2014/07/28 15:18:16  lukyanets
// {Requestlink:557844282}. Используем правильный ProjectDefine.inc
//
// Revision 1.50  2014/04/30 13:17:56  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.48  2014/04/30 13:11:40  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.47  2014/04/17 13:07:50  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.46  2014/04/09 14:24:51  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.45  2014/04/08 14:16:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.44  2014/04/07 17:56:23  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.43  2014/04/04 07:14:16  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.42  2014/03/04 16:45:21  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.41  2014/02/14 15:33:23  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.40  2014/02/10 07:54:05  GarikNet
// K:516189258
//
// Revision 1.39  2012/08/17 12:36:37  narry
// Обновление
//
// Revision 1.38  2011/12/05 14:03:47  narry
// Assert при поиске в уникодном тексте
//
// Revision 1.37  2011/11/30 12:42:15  narry
// Простановка саб 30005 (294584934)
//
// Revision 1.36  2011/11/02 06:22:38  narry
// Обновление
//
// Revision 1.35  2011/11/01 05:22:02  narry
// НИР Расстановка меток в ФАСах (147489953)
//
// Revision 1.34  2011/11/01 05:05:10  narry
// НИР Расстановка меток в ФАСах (147489953)
//
// Revision 1.33  2011/10/17 13:35:36  narry
// Простановка сабов 20005 и 30005 - перенос на этап заливки (288784725)
//
// Revision 1.32  2011/10/14 06:11:21  narry
// Не собиралось
//
// Revision 1.31  2011/10/13 13:47:26  narry
// Простановка сабов 20005 и 30005 - перенос на этап заливки (288784725)
//
// Revision 1.30  2011/10/13 10:47:53  narry
// Накопившиеся изменения
//
// Revision 1.29  2011/10/11 11:33:08  narry
// Игнорировать пустые документы (290955322)
//
// Revision 1.28  2011/09/19 10:47:30  narry
// - чистка мусора
//
// Revision 1.27  2011/09/15 07:22:21  narry
// - Избавление от ненужных параметров
//
// Revision 1.26  2011/09/13 12:26:53  narry
// Простановка меток в документах ВАС (283613768)
//
// Revision 1.25  2011/09/08 08:03:05  fireton
// - поменялось название метода (Update -> ProcessUpdate)
//
// Revision 1.24  2011/09/07 07:44:10  narry
// Не работает разметка текстов (280858671)
//
// Revision 1.23  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.22  2010/08/18 11:29:07  narry
// - не собиралось в связи с переименованием dt_Srch2
//
// Revision 1.21  2009/11/10 08:20:06  narry
// - обновление
// - экспорт произвольных аннотаций в Прайм
//
// Revision 1.20  2009/06/03 07:25:19  lulin
// - убираем метод построения заглушки локальной процедуры в отдельный модуль.
//
// Revision 1.19  2009/06/02 17:23:20  lulin
// - удалены ненужные интерфейсы и переопределения типов.
//
// Revision 1.18  2009/05/27 12:29:20  narry
// - Обновление
//
// Revision 1.17  2009/02/03 08:11:37  narry
// - непавильно формировался список документов
// - не ставились метки
//
// Revision 1.16  2009/01/28 12:35:13  fireton
// - мелкий рефакторинг
//
// Revision 1.15  2009/01/26 08:59:44  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.14  2009/01/23 16:24:15  narry
// - ловушки для меток
//
// Revision 1.13.2.1  2009/01/23 14:07:40  fireton
// - перенос Парня на Query
//
// Revision 1.13  2008/10/13 13:38:39  dinishev
// <K> : 84640081
//
// Revision 1.12  2008/06/24 07:44:05  narry
// + возможность сборки под "старый" редактор
//
// Revision 1.11  2008/06/20 14:48:52  lulin
// - используем префиксы элементов.
//
// Revision 1.10  2008/06/10 14:15:27  narry
// - запись в ББ информации о проведенной АК
// - исправление ошибки импорта - запись "престижа" в документ, идущий перед пропущенным
//
// Revision 1.9  2008/05/14 11:23:36  narry
// - уменьшение объема выоводимой в лог инфы для регионов
// - рефакторинг конфигурации
// - переделки Прайма
//
// Revision 1.8  2008/02/19 15:52:19  narry
// - перенос настроек из garant\base.ini в Конфигурацию
//
// Revision 1.7  2007/12/06 09:50:40  narry
// - обновление
//
// Revision 1.6  2007/12/05 10:58:14  lulin
// - пытаемся заставить собираться (безуспешно).
//
// Revision 1.5  2007/12/05 10:37:16  lulin
// - пытаемся заставить собираться (безуспешно).
//
// Revision 1.4  2007/11/16 09:38:00  narry
// - расширение отчета об ошибках
//
// Revision 1.3  2007/11/12 09:11:10  narry
// - накопилось: чистка кода, окошко "О программе",  поддержка внешних словарей, исправление "метки 20005", "Английская база"
//
// Revision 1.2  2007/09/11 12:22:39  narry
// - Расстановка меток 30005 и 20005. Уточненная
//
// Revision 1.1  2007/09/06 06:21:12  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - Расстановка меток SecondSubNumber и FirstSubNumber
// - Удаленое изменение словарей
//

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

Uses
 l3Variant,
 l3Base, l3Types, l3LongintList,
 Classes,
 alcuDocument,
 k2Interfaces,
 dt_Doc,
 evInternalInterfaces, ddProgressObj;

Type
 TalcuCourtDecisionSubMaker = class(Tl3Base)
 private
  f_2ndPara: Il3TagRef;
  f_SearchTextList: TStrings;
  f_CharactersLimit: Integer;
  f_CharsBeforeSecondSubNumber: Integer;
  f_DocCharsCount: Integer;
  f_DocSource: Integer;
  f_DocType: Integer;
  f_EmptyDocList: Tl3LongintList;
  f_FirstSubNumber: Integer;
  f_FoundDocs: Integer;
  f_FromDate: TDateTime;
  f_Progressor: TddProgressObject;
  f_SearchBefore: Boolean;
  f_SecondSubNumber: Integer;
  f_WorkedDocs: Integer;
  f_NotHaveFirstSubNumber: Boolean;
  f_NotHaveSecondSubNumber: Boolean;
  f_NotValidDocList: Tl3LongintList;
  procedure AddDocumentToLog(aDocID: Integer);
  procedure Clear;
  procedure ExtractParameters(aExpression: String; out theText: String; out theBefore: Boolean);
  procedure pm_SetSearchTextList(const Value: TStrings);
  function SetFirstSub(aDoc: TalcuDocument): Boolean;
  function _SetFirstSubNumberSub(aDoc: TalcuDocument; const aText: String; aAfterPara: Boolean): Boolean;
  function SetSecondSub(aDoc: TalcuDocument): Boolean;
  procedure SetSubToPara(aPara: Tl3Tag; aSubID: Integer);
  procedure SpecialSetFirstSub(aDoc: TalcuDocument);
  procedure StartWork(aValue: Integer);
  procedure StopWork;
  procedure UpdateWork(aValue: Integer);
  function ValidDoc(aDoc: TalcuDocument; aDocInfo: TDocReadRec): Boolean;
  function ValidParams: Boolean;
  procedure WorkupDocument(aDoc: TDocReadRec);
(*  function _FirstSubNumber(Sender : TObject; const aBlock : IevEditableTagSelection): Long;
  function _SecondSubNumber(Sender       : TObject; const aBlock : IevEditableTagSelection): Long;*)
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure Execute(aReport: TStrings); overload;
  procedure Execute(aDocSource: Integer; aTextList, aReport: TStrings); overload;
  procedure Execute(aDocList: Tl3LongintList; aTextList, aReport: TStrings);
      overload;
  property SearchTextList: TStrings
   read f_SearchTextList
   write pm_SetSearchTextList;
  property CharactersLimit: Integer
   read f_CharactersLimit
   write f_CharactersLimit;
  property DocSource: Integer
   read f_DocSource
   write f_DocSource;
  property DocType: Integer
   read f_DocType
   write f_DocType;
  property EmptyDocList: Tl3LongintList
   read f_EmptyDocList;
  property FirstSubNumber: Integer read f_FirstSubNumber write f_FirstSubNumber;
  property FoundDocs: Integer read f_FoundDocs;
  property FromDate: TDateTime
   read f_FromDate
   write f_FromDate;
  property NotValidDocList: Tl3LongintList read f_NotValidDocList write f_NotValidDocList;
  property Progressor: TddProgressObject read f_Progressor write f_Progressor;
  property SecondSubNumber: Integer read f_SecondSubNumber write f_SecondSubNumber;
  property WorkedDocs: Integer read f_WorkedDocs;
 end;


implementation

Uses
 SysUtils, StrUtils,
 daInterfaces,
 daTypes,
 daSchemeConsts,
 dt_Types, dt_Const, dt_AttrSchema, dt_Hyper,
 dt_Serv, dt_Query, dt_SrchQueries,
 l3Date,
 k2Tags,
 evParaTools, evIntf, evSearch, evTypes, evdStyles, evdTypes,
 nevTools, evTextSource, evOpProc, evFacadeSub, evFacadTextSource,
  l3LongintListPrim, dtIntf, dt_Sab,
  evStubs
  , DT_LinkServ, DT_UserConst, alcuUtils, l3InterfaceList, l3Chars,
  k2SimpleTagList
  ;

type
 TalcuRegSearcher = class(TevRegularExpressionSearcher)
 private
  f_FindNext: Boolean;
  f_NeedNext: Boolean;
  f_Para: Tl3Variant;
  f_TextLen: Integer;
  procedure pm_SetFindNext(const Value: Boolean);
 protected
  function DoCheckText(Sender : Tl3Variant; S : Tl3CustomString; const aSel : TevPair; out theSel : TevPair): Bool;
      override;
        {-}
  procedure DoStart; override;
  procedure Cleanup; override;
 public
  property FindNext: Boolean read f_FindNext write pm_SetFindNext;
  property Para: Tl3Variant read f_Para;
  property TextLen: Integer read f_TextLen;
 end;

 TalcuTextSearcher = class(TevBMTextSearcher)
 private
  f_BetweenTextLen: Integer;
  f_BetweenTextLen2: Integer;
  f_Last: InevObject;
  f_NextToLast: InevObject;
  f_NextTolastTextLen: Integer;
  f_Para: InevObject;
  f_ParaCount: Integer;
  f_ParaIndex: Integer;
  f_SecondPara: Il3TagRef;
  f_SixthPara: Tk2SimpleTagList;
  f_TextLen: Integer;
  function pm_GetSixthPara: InevObject;
 protected
  procedure Cleanup; override;
        {-}
  procedure DoStart; override;
 public
    // public methods
  constructor Create(anOwner: TevSearchToolOwner = nil); override;
  function DoCheckText(Sender : Tl3Variant; S : Tl3CustomString; const aSel : TevPair; out theSel : TevPair): Bool;
      override;
  property NextToLast: InevObject read f_NextToLast;
  property NextTolastTextLen: Integer read f_NextTolastTextLen;
  property Para: InevObject read f_Para;
  property ParaCount: Integer read f_ParaCount;
  property ParaIndex: Integer read f_ParaIndex;
  property SecondPara: Il3TagRef read f_SecondPara;
  property SixthPara: InevObject read pm_GetSixthPara;
  property TextLen: Integer read f_TextLen;
 end;

 TalcuValueParaSearcher = class(TevBaseSearcher)
 private
  f_Currentvalue: Integer;
  f_TextValue: Integer;
 public
  function DoCheckText(Sender : Tl3Variant; S : Tl3CustomString; const aSel : TevPair; out theSel : TevPair): Bool;
      override;
  property TextValue: Integer read f_TextValue write f_TextValue;
 end;



constructor TalcuCourtDecisionSubMaker.Create;
begin
 inherited;
 f_SearchTextList:= TStringList.Create;
 f_EmptyDocList:= Tl3LongintList.MakeSorted;
 f_NotValidDocList:= Tl3LongintList.MakeSorted;
 f_CharactersLimit:= 1000;
 f_FirstSubNumber:= 20005;
 f_SecondSubNumber:= 30005;
end;



procedure TalcuCourtDecisionSubMaker.AddDocumentToLog(aDocID: Integer);
begin
 f_EmptyDocList.Add(aDocID);
end;

procedure TalcuCourtDecisionSubMaker.Cleanup;
begin
 l3Free(f_NotValidDocList);
 l3Free(f_EmptyDocList);
 l3Free(f_SearchTextList);
 inherited;
end;

procedure TalcuCourtDecisionSubMaker.Clear;
begin
 EmptyDocList.Clear;
 NotValidDocList.Clear;
 f_WorkedDocs:= 0;
end;

procedure TalcuCourtDecisionSubMaker.Execute(aDocSource: Integer; aTextList,
    aReport: TStrings);
var
 i: Integer;
begin
 DocSource := aDocSource;
 SearchTextList:= aTextList;
 Execute(aReport);
 if EmptyDocList.Count > 0 then
 begin
  AddReportLog('Из них с ошибками (не найдена фраза "постановил:" или не удалось поставить метку 30005): %d', [EmptyDocList.Count], aReport);
  for i:= 0 to EmptyDocList.Hi do
   aReport.Add(Format('%d', [LinkServer(CurrentFamily).ReNum.GetExtDocID(EmptyDocList.Items[i])]));
 end; // EmptyDocList.Count > 0
 if NotValidDocList.Count > 0 then
 begin
  AddReportLog('Пропущено %d документов (отсутствует текст или найдена метка 20005 или 30005):', [NotValidDocList.Count], aReport);
  for i:= 0 to NotValidDocList.Hi do
   aReport.Add(Format('%d', [LinkServer(CurrentFamily).ReNum.GetExtDocID(NotValidDocList.Items[i])]));
 end; // NotValidDocList.Count > 0
end;


procedure TalcuCourtDecisionSubMaker.Execute(aReport: TStrings);
var
 l_DocsQuery : TdtQuery;
 l_Q         : TdtQuery;
 I           : Integer;
 l_List      : Tl3LongintList;
 l_DocList   : TDocumentSabList;
 l_Doc       : TDocReadRec;
 lSab1 : ISab; 
 lValArr : array[0..1] of Integer;
begin
 if ValidParams then
 begin
  Clear;
  l_DocsQuery:= TdtAndQuery.Create;
  try
   l_List := Tl3LongintList.Make;
   try
    l_List.Add(f_DocType);
    l_Q := TdtDictQuery.Create(da_dlTypes, l_List);
    TdtAndQuery(l_DocsQuery).AddQueryF(l_Q);
   finally
    l3Free(l_List);
   end;

   l_List := Tl3LongintList.Make;
   try
    l_List.Add(f_DocSource);
    l_Q := TdtDictQuery.Create(da_dlSources, l_List);
    TdtAndQuery(l_DocsQuery).AddQueryF(l_Q);
   finally
    l3Free(l_List);
   end;

   {$IFDEF Region}
   lValArr[0] := 20005;
   lValArr[1] := 30005;
   lSab1:= MakeValueSet(LinkServer(CurrentFamily).SubTbl, subSID_fld, @lValArr, Length(lValArr));
   lSab1.ValuesOfKey(subDID_fld);
   lSab1.RecordsByKey(fId_Fld, l_DocsQuery.FoundList);
   l_DocsQuery.FoundList.SubtractSab(lSab1);
   {$ELSE}
   //l_Q:= SQChangedDocsFromLog(StDateToDemon(DateTimeToStDate(f_FromDate)), StDateToDemon(CurrentDate), 0);
   l_Q:= SQLogByActionsQuery(DateTimeToDtDate(f_FromDate), StDateToDemon(CurrentDate),
                             [//acRevision,      // 0
                             acTextWork,       // 2
                             acNew,            // 6
                             acChanged,        // 8
                             acWasImported     // 13
                             ]);
   TdtAndQuery(l_DocsQuery).AddQueryF(l_Q);
   {$ENDIF}

   f_FoundDocs := l_DocsQuery.FoundList.Count;
   AddReportLog('Найдено документов: %d', [FoundDocs], aReport);
   (*
    l_Doc.ID:= 22007314;
    WorkupDocument(l_Doc);
   *)
   if f_FoundDocs > 0 then
   begin
    StartWork(l_DocsQuery.FoundList.Count);
    l_DocList := TDocumentSabList.Create;
    try
     l_DocList.Family := CurrentFamily;
     l_DocList.CurSab := l_DocsQuery.FoundList;
     for i := 0 to Pred(l_DocList.Count) do
     begin
      l_Doc := l_DocList.GetDoc(i);
      WorkupDocument(l_Doc);
      UpdateWork(i);
     end; // for i
     
     StopWork;
    finally
     l3Free(l_DocList);
    end;
   end; // f_FoundDocs > 0
  finally
   l3Free(l_DocsQuery);
  end;
 end; // ValidParams
end;

procedure TalcuCourtDecisionSubMaker.Execute(aDocList: Tl3LongintList;
    aTextList, aReport: TStrings);
var
 I           : Integer;
 l_Doc       : TDocReadRec;
begin
 // Список номеров приходит извне
 if aTextList.Count > 0  then
 begin
  Clear;
  SearchTextList:= aTextList;
  AddReportLog('Получено документов: %d', [aDocList.Count], aReport);
  if aDocList.Count > 0 then
  begin
   StartWork(aDocList.Count);
   for i := 0 to aDocList.Hi do
   begin
    l_Doc.ID := aDocList[i];
    WorkupDocument(l_Doc);
    UpdateWork(i);
   end; // for i
   StopWork;
  end; // f_FoundDocs > 0
 end; // ValidParams
end;

procedure TalcuCourtDecisionSubMaker.ExtractParameters(aExpression: String; out theText: String; out theBefore:
    Boolean);
var
 l_Pos: Integer;
begin
 theText:= '';
 theBefore:= True;
 // Входные данные: <"text">, <where>
 if (aExpression <> '') and (aExpression[1] = '"') then
 begin
  l_Pos:= PosEx('"', aExpression, 2);
  theText:= Copy(aExpression, 2, l_Pos-2);
  TheBefore := aExpression[Length(aExpression)] = '0';
 end;
end;

procedure TalcuCourtDecisionSubMaker.pm_SetSearchTextList(const Value: TStrings);
begin
 if Value <> nil then
  f_SearchTextList.Assign(Value)
 else
  f_SearchTextList.Clear;
end;

function TalcuCourtDecisionSubMaker.SetFirstSub(aDoc: TalcuDocument): Boolean;
var
 l_Text: String;
 l_Before: Boolean;
 i: Integer;
begin
 Result:= False;
 for i:= 0 to Pred(SearchTextList.Count) do
 begin
  ExtractParameters(SearchTextList.Strings[i], l_Text, l_Before);
  if _SetFirstSubNumberSub(aDoc, l_Text, not l_Before) then
  begin
   Result:= True;
   break;
  end; // _SetFirstSubNumberSub(aDoc, l_Text, not l_Before)
 end; // for i
end;

function TalcuCourtDecisionSubMaker._SetFirstSubNumberSub(aDoc: TalcuDocument; const aText: String; aAfterPara: Boolean): Boolean;
var
 l_Searcher: TalcuRegSearcher;
 l_List    : InevObject;
 l_Para    : InevObject;
 l_SubList : InevSubList;
begin
 Result:= False;
 l_Searcher := TalcuRegSearcher.Create;
 try
  l_Searcher.Options:= [ev_soFind, ev_soWholeWord, ev_soDocumentPart, ev_soGlobal];
  l_Searcher.FindNext:= aAfterPara;
  l_Searcher.Text:= aText;
  if not aDoc.Document.QT(InevObject, l_List) then
   Assert(false);
  if evSearchPara(l_List, l_Searcher, l_Para) then
  begin
   if f_CharsBeforeSecondSubNumber - l_Searcher.TextLen > CharactersLimit then
   begin
    if f_NotHaveFirstSubNumber then
     SetSubToPara(l_Para.AsObject, FirstSubNumber);
    Result:= True;
   end; // f_CharsBeforeSecondSubNumber - l_Searcher.TextLen > CharactersLimit
  end;
 finally
  l3Free(l_Searcher);
 end;
end;

function TalcuCourtDecisionSubMaker.SetSecondSub(aDoc: TalcuDocument): Boolean;
var
 l_Searcher: TevBaseSearcher;
 l_Para    : InevObject;
 l_SubList : InevSubList;
 l_List    : InevObject;
begin
 l_Searcher := TalcuTextSearcher.Create;
 try
  l_Searcher.Options:= [ev_soFind, ev_soWholeWord, ev_soDocumentPart, ev_soGlobal{, ev_soReplace}];
  TalcuTextSearcher(l_Searcher).Text := 'постановил:';
  if not aDoc.Document.QT(InevObject, l_List) then
   Assert(false);
  while evSearchPara(l_List, l_Searcher, l_Para) do;
  with TalcuTextSearcher(l_Searcher) do
  begin
   f_2ndPara:= SecondPara;
   if Para <> nil then
   begin
    if ParaCount - ParaIndex > 6 then
    begin
     l_Para := NextToLast;
     f_CharsBeforeSecondSubNumber:= NextToLastTextLen;
    end
    else
    begin
     l_Para := Para;
     f_CharsBeforeSecondSubNumber:= TextLen;
    end
   end
   else
   begin
    AddDocumentToLog(aDoc.DocID);
    l_Para:= NextToLast;
    //l_Para:= SixthPara;
    f_CharsBeforeSecondSubNumber:= NextToLastTextLen;
   end;
  end; // with TalcuTextSearcher(l_Searcher)
  if f_NotHaveSecondSubNumber then
   SetSubToPara(l_Para.AsObject, SecondSubNumber);
 finally
  l3Free(l_Searcher);
 end;
 Result := True;
end;

procedure TalcuCourtDecisionSubMaker.SetSubToPara(aPara: Tl3Tag; aSubID: Integer);
var
 l_Para : InevPara;
begin
 if aPara <> nil then
 begin
  if Supports(aPara, InevPara, l_Para) then
   l_Para.MainSubList.SubEx[aSubID, Ord(ev_sbtSub)].SetTo(aPara.AsObject)
  else
   l3System.Msg2Log('Абзац не поддерживает метки');
 end
 else
  l3System.Msg2Log('Абзац для метки %d не найден', [aSubID]);
end;

procedure TalcuCourtDecisionSubMaker.SpecialSetFirstSub(aDoc: TalcuDocument);
var
 l_Searcher: TalcuValueParaSearcher;
 l_Para: InevObject;
 l_List    : InevObject;
begin
 if f_CharsBeforeSecondSubNumber div 2 > CharactersLimit then
 begin
  l_Searcher:= TalcuValueParaSearcher.Create(nil);
  try
   l_Searcher.TextValue := f_CharsBeforeSecondSubNumber div 2;
   if not aDoc.Document.QT(InevObject, l_List) then
    Assert(false);
   if evSearchPara(l_List, l_searcher, l_para) then
   begin
    SetSubToPara(l_Para.AsObject, FirstSubNumber);
   end;
  finally
   l3Free(l_searcher);
  end;
 end
 else
  SetSubToPara(f_2ndPara.AsObject, FirstSubNumber);
end;

procedure TalcuCourtDecisionSubMaker.StartWork(aValue: Integer);
begin
 if f_Progressor <> nil then
 begin
  f_Progressor.Start;
  f_Progressor.ProcessUpdate(0, aValue, '');
 end;
end;

procedure TalcuCourtDecisionSubMaker.StopWork;
begin
 if f_Progressor <> nil then
  f_Progressor.Stop
end;

procedure TalcuCourtDecisionSubMaker.UpdateWork(aValue: Integer);
begin
 if f_Progressor <> nil then
  f_Progressor.ProcessUpdate(1, aValue, '');
end;

function TalcuCourtDecisionSubMaker.ValidDoc(aDoc: TalcuDocument; aDocInfo: TDocReadRec): Boolean;

 function DoSubFirstSubNumber(const aSub: IevSub): Boolean;
 begin
  Result := aSub.ID <> FirstSubNumber;
  f_NotHaveFirstSubNumber:= Result;
 end;
 function DoSubSecondSubNumber(const aSub: IevSub): Boolean;
 begin
  Result := aSub.ID <> SecondSubNumber;
  f_NotHaveSecondSubNumber:= Result
 end;

begin
 Result:= EvGetTextParaCount(aDoc) > 0;
 if Result then
 begin
  f_NotHaveFirstSubNumber:= True; f_NotHaveSecondSubNumber:= True;
  evGetSubList(aDoc).IterateF(evL2SubA(@DoSubFirstSubNumber));
  evGetSubList(aDoc).IterateF(evL2SubA(@DoSubSecondSubNumber));
  Result:= (f_NotHaveFirstSubNumber or f_NotHaveSecondSubNumber);
 end; // Result
 if not Result then
  f_NotValidDocList.Add(aDocInfo.ID);
end;

function TalcuCourtDecisionSubMaker.ValidParams: Boolean;
begin
 Result := (DocSource <> 0) and (DocType <> 0) and (SearchTextList.Count > 0);
end;

procedure TalcuCourtDecisionSubMaker.WorkupDocument(aDoc: TDocReadRec);
var
 l_Doc: TalcuDocument;
begin
 l_Doc:= TalcuDocument.Make(aDoc.ID);
 try
  l_Doc.LoadDoc;
  //l3System.Msg2Log('Документ # %d', [aDoc.ID]);
  if ValidDoc(l_Doc, aDoc) then
  begin
   Inc(f_WorkedDocs);
   f_DocCharsCount := evGetNettoCharCount(l_Doc);
   if SetSecondSub(l_Doc) then
   begin
    if not SetFirstSub(l_Doc) then
    begin
     AddDocumentToLog(aDoc.ID);
     SpecialSetFirstSub(l_Doc);
    end;
    LinkServer(CurrentFamily).LogBook.PutLogRec(aDoc.ID, acHLWork, usServerService);
   end
   else
    l3System.Msg2Log('%d - не удалось поставить метку %d', [aDoc.ID, SecondSubNumber]);
   l_Doc.SaveDoc;
  end // ValidDoc
  else
   l3System.Msg2Log('%d - не подходит по условиям', [aDoc.ID]);
 finally
  l3Free(l_Doc);
 end;
end;

function TalcuRegSearcher.DoChecktext(Sender : Tl3Variant; S : Tl3CustomString; const aSel : TevPair; out theSel : TevPair): Bool;
var
 l_Sel: TevPair;
begin
 Result:= False;
 if not S.Empty then
 begin
  if (S.CodePage = CP_ANSI) or (S.CodePage = CP_OEM) then
  begin
   if FindNext then
    if f_NeedNext then
    begin
     Sender.SetRef(f_Para);
     f_NeedNext:= False;
     Result:= True;
     exit
    end; // NeedNext
   Result:= inherited DoCheckText(Sender, S, aSel, l_Sel);
   if FindNext then
    if Result then
    begin
     f_NeedNext:= True;
     Result:= False;
    end; // Result
  end;
  if not Result then
   inc(f_TextLen, S.Len);
 end;
end;

procedure TalcuRegSearcher.DoStart;
  //virtual;
  {-}
begin
 f_TextLen:= 0;
 f_NeedNext := False;
 FreeAndNil(f_Para);
end;

procedure TalcuRegSearcher.Cleanup;
begin
 FreeAndNil(f_Para);
 inherited;
end;

procedure TalcuRegSearcher.pm_SetFindNext(const Value: Boolean);
begin
 if f_FindNext <> Value then
 begin
  f_FindNext := Value;
 end;
end;

// start class TalcuTextSearcher

constructor TalcuTextSearcher.Create(anOwner: TevSearchToolOwner = nil);
begin
 inherited Create(anOwner);
 f_SixthPara := Tk2SimpleTagList.Create;
end;

procedure TalcuTextSearcher.Cleanup;
begin
 inherited;
 FreeAndNil(f_SixthPara);
end;

function TalcuTextSearcher.DoCheckText(Sender : Tl3Variant; S : Tl3CustomString; const aSel : TevPair; out theSel :
    TevPair): Bool;
var
 l_ValidPara: Boolean;
begin
 if not S.Empty then
 begin
  inc(f_BetweenTextLen, S.Len);
  inc(f_BetweenTextLen2, S.Len);

  l_ValidPara := ((S.CodePage = CP_ANSI) or (S.CodePage = CP_OEM)) and
     ((Sender.AsObject.rOwnAtom(k2_tiStyle).IsValid and (Sender.AsObject.rOwnAtom(k2_tiStyle).AsLong = ev_saTxtNormalANSI)) or
      Sender.AsObject.rOwnAtom(k2_tiStyle).IsNull);
  if l_ValidPara then
  begin
   f_SixthPara.Add(Sender);
   if f_SixthPara.Count > 6 then
    f_SixthPara.Delete(0);

   if (f_Last <> nil) then
   begin
    f_NextToLast:= f_Last;
    Inc(f_NextToLastTextLen, f_BetweenTextLen2 - S.Len);
    f_BetweenTextLen2 := S.Len;
   end;
   Sender.QT(InevObject, f_Last);
   Inc(f_ParaCount);
  end;

  if f_ParaCount > 1 then // В заголовке искать не нужно
  begin
   if f_ParaCount = 2 then
    Sender.QT(InevObject, f_SecondPara);
   Result:= inherited DoCheckText(Sender, S, aSel, theSel);
   if Result then
   begin
    Sender.QT(InevObject, f_Para);
    f_ParaIndex:= Pred(f_ParaCount);
    Inc(f_TextLen, f_BetweenTextLen - S.Len);
    f_BetweenTextLen := S.Len;
   end;
  end; // f_ParaCount > 1
 end;

 Result:= False;
end;

procedure TalcuTextSearcher.DoStart;
begin
 f_ParaIndex := 0;
 f_ParaCount := 0;
 f_BetweenTextLen:= 0;
 f_BetweenTextLen2:= 0;
 f_TextLen := 0;
 f_NextTolastTextLen := 0;
 f_Last:= nil;
 f_NextToLast:= nil;
 f_SixthPara.Clear;
end;

function TalcuTextSearcher.pm_GetSixthPara: InevObject;
begin
 if f_SixthPara.Count > 0 then
  f_SixthPara.First.QT(InevObject, Result)
 else
  Result:= nil;
end;

function TalcuValueParaSearcher.DoCheckText(Sender : Tl3Variant; S : Tl3CustomString; const aSel : TevPair; out
    theSel : TevPair): Bool;
begin
 if not S.Empty then
  Inc(f_CurrentValue, S.Len);
 Result:= f_CurrentValue >= TextValue;
end;

end.
