unit dt_SrchQueries;

// Фабрики спецпоисков

{ $Id: dt_SrchQueries.pas,v 1.17 2015/07/02 11:41:29 lukyanets Exp $ }

// $Log: dt_SrchQueries.pas,v $
// Revision 1.17  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.16  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.15  2014/10/31 14:13:14  voba
//  k:570533875
//
// Revision 1.14  2013/01/17 06:19:49  narry
// Новая функция SQNewAndChangedIncuded
//
// Revision 1.13  2012/12/03 10:56:44  fireton
// - поиск по фрагменту теперь понимает номер дела и ГОСТы, а также выкидывает недействующие редакции
//
// Revision 1.12  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.11  2010/08/04 08:29:39  voba
// - k: 229672814
//
// Revision 1.10  2009/10/13 14:59:08  fireton
// - работа над ошибками в простановке ссылок в БРАС
//
// Revision 1.9  2009/09/29 12:58:56  voba
// - bug fix
//
// Revision 1.8  2009/09/28 08:53:52  voba
// - избавляемся от старого анализатора фраз
//
// Revision 1.7  2009/09/25 10:35:59  voba
// - [$163065584]
//
// Revision 1.6  2009/09/17 13:40:57  fireton
// - ищем правильный тип дат и номеров
//
// Revision 1.5  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.4  2009/05/25 11:45:50  voba
// - при поиске по фрагменту не находило если в дате встречалось слово "мая"
//
// Revision 1.3  2009/01/28 12:34:25  fireton
// - добавлены хелперы And, Or и AndNot, освобождающие параметр
//
// Revision 1.2  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.1.2.3  2009/01/23 14:06:30  fireton
// - перенос Парня на Query
//
// Revision 1.1.2.2  2008/12/25 10:17:44  fireton
// - перевод спецпоисков на TdtQuery
//
// Revision 1.1.2.1  2008/12/22 11:21:56  fireton
// - перевод поисков на TdtQuery
//

interface
uses
 Windows,
 
 l3Types,
 l3Date,
 l3String,

 DT_Types,
 DT_Query,
 Dt_IndexSupport;

// инвертирует запрос и освобождает первоначальный объект
procedure SQNot(var theQuery: TdtQuery);

// сложение двух запросов
procedure SQOr(var theQuery: TdtQuery; aQuery: TdtQuery);
procedure SQOrF(var theQuery: TdtQuery; var aQuery: TdtQuery);

// умножение двух запросов
procedure SQAnd(var theQuery: TdtQuery; aQuery: TdtQuery);
procedure SQAndF(var theQuery: TdtQuery; var aQuery: TdtQuery);

// вычитание запросов
procedure SQAndNot(var theQuery: TdtQuery; aQuery: TdtQuery);
procedure SQAndNotF(var theQuery: TdtQuery; var aQuery: TdtQuery);

// запрос по статусу "законченности" (acIncluded)
function SQDocOnDoneState(aDocFlag : LongInt): TdtQuery;

// фильтрует документы по статусу "законченности" (acIncluded)
procedure SQAndDoneQuery(var theQuery: TdtQuery; aDoneFlag: Longint);

// запрос по логу: новые документы
function SQNewDocsFromLog(FromDate,ToDate : TStDate;
                                 DoneFlag : LongInt;
                                   UserID : TDictID = 0; UserGr : Boolean = False;
                               LogRecType : TLogActionFlags = acfOrdinal): TdtQuery;

// запрос по логу: измененные документы
function SQChangedDocsFromLog(FromDate,ToDate : TStDate;
                                     DoneFlag : LongInt;
                                       UserID : TDictID = 0; UserGr : Boolean = False;
                                   LogRecType : TLogActionFlags = acfOrdinal): TdtQuery;

// составляет запрос по набору log actions
function SQLogByActionsQuery(FromDate,ToDate : TStDate;
                                    aActions : TLogActionSet;
                                      UserID : TDictID = 0; UserGr : Boolean = False;
                                  LogRecType : TLogActionFlags = acfNone): TdtQuery;

function SQComplexStageQuery(aFromDate, aToDate           : TStDate;
                             aBeginStage, aEndStage,
                             aNotEndStage, aNotBeginStage : TStageSet;
                                                aDoneFlag : Longint): TdtQuery;


function  MakeIDList(aQuery: TdtQuery): TdtQuery;
procedure SQ2IDList(var theQuery: TdtQuery);

function SQText2Query(const aText: string): TdtQuery;

function SQNewAndChangedIncuded(FromDate,ToDate : TStDate; DoneFlag : LongInt;
    UserID : TDictID = 0; UserGr : Boolean = False; LogRecType :
    TLogActionFlags = acfOrdinal): TdtQuery;

implementation
uses
 SysUtils,
 StDateSt,

 l3Base,
 l3LongintList,

 m4DictTypes,
 m4DictScanner,
 m4PhraseParser,

 daTypes,

 DT_Sab,
 DT_Const, dt_AttrSchema,

 DT_Doc,
 DT_Serv,
 DT_Dict, l3LongintListPrim;

function SQDocOnDoneState(aDocFlag : LongInt): TdtQuery;
begin
 Result := nil;
 if (aDocFlag <> ((1 shl MaxDoneType)-1)) and (aDocFlag <> 0) then
 begin
  Result := TdtLogByActionQuery.Create(acIncluded, 0, 0);
  if aDocFlag = cNotDone then
   SQNot(Result);
 end;
end;

procedure SQNot(var theQuery: TdtQuery);
var
 l_Q: TdtNOTQuery;
begin
 l_Q := TdtNOTQuery.Create;
 l_Q.SubQuery := theQuery;
 l3Free(theQuery);
 theQuery := l_Q;
end;

procedure SQAndDoneQuery(var theQuery: TdtQuery; aDoneFlag: Longint);
var
 l_Q: TdtQuery;
 l_And: TdtAndQuery;
begin
 l_Q := SQDocOnDoneState(aDoneFlag);
 if l_Q <> nil then
 begin
  l_And := TdtAndQuery.Create;
  l_And.AddQueryF(l_Q);
  l_And.AddQueryF(theQuery);
  theQuery := l_And;
 end;
end;

function _NewDocsFromLog(FromDate,ToDate : TStDate;
                                  UserID : TDictID = 0; UserGr : Boolean = False;
                              LogRecType : TLogActionFlags = acfOrdinal): TdtQuery;
var
 l_Q   : TdtQuery;
begin
 Result := TdtOrQuery.Create;
 l_Q := TdtLogByActionQuery.Create(acNew, FromDate, ToDate, UserID, UserGr, LogRecType);
 TdtOrQuery(Result).AddQueryF(l_Q);
 l_Q := TdtLogByActionQuery.Create(acWasImported, FromDate, ToDate, UserID, UserGr, LogRecType);
 TdtOrQuery(Result).AddQueryF(l_Q);
end;

function SQNewDocsFromLog(FromDate,ToDate : TStDate;
                                 DoneFlag : LongInt;
                                   UserID : TDictID = 0; UserGr : Boolean = False;
                               LogRecType : TLogActionFlags = acfOrdinal): TdtQuery;
begin
 Result := _NewDocsFromLog(FromDate, ToDate, USerID, UserGr, LogRecType);
 SQAndDoneQuery(Result, DoneFlag);
end;

function SQChangedDocsFromLog(FromDate,ToDate : TStDate;
                                     DoneFlag : LongInt;
                                       UserID : TDictID = 0; UserGr : Boolean = False;
                                   LogRecType : TLogActionFlags = acfOrdinal): TdtQuery;
var
 l_Q: TdtQuery;
begin
 Result := TdtAndQuery.Create;
 // получаем список всех документов в диапазоне дат
 l_Q := TdtSimpleLogQuery.Create(FromDate, ToDate, UserID, UserGr, LogRecType);
 TdtAndQuery(Result).AddQueryF(l_Q);
 // получаем список всех НОВЫХ (acNew и acWasImported) документов в диапазоне
 l_Q := _NewDocsFromLog(FromDate, ToDate, UserID, UserGr, LogRecType);
 SQNot(l_Q); // инвертируем его
 // и вычитаем
 TdtAndQuery(Result).AddQueryF(l_Q);
 SQAndDoneQuery(Result, DoneFlag);
end;



function SQLogByActionsQuery(FromDate,ToDate : TStDate;
                                    aActions : TLogActionSet;
                                      UserID : TDictID = 0; UserGr : Boolean = False;
                                  LogRecType : TLogActionFlags = acfNone): TdtQuery;
var
 l_Act: TLogActionType;
 l_Q  : TdtQuery;
begin
 Result := TdtOrQuery.Create;
 for l_Act := Low(TLogActionType) to High(TLogActionType) do
  if l_Act in aActions then
  begin
   l_Q := TdtLogByActionQuery.Create(l_Act, FromDate, ToDate, UserID, UserGr, LogRecType);
   TdtOrQuery(Result).AddQueryF(l_Q);
  end;
end;


function SQComplexStageQuery(aFromDate, aToDate           : TStDate;
                             aBeginStage, aEndStage,
                             aNotEndStage, aNotBeginStage : TStageSet;
                                                aDoneFlag : Longint): TdtQuery;
var
 l_Stage: TStageType;
 l_Q: TdtQuery;
begin
 Result := TdtAndQuery.Create;

 for l_Stage := Low(TStageType) to High(TStageType) do
 begin
  if l_Stage in aBeginStage then
  begin
   l_Q := TdtStageQuery.Create(aFromDate, aToDate, l_Stage, stfBegined);
   TdtAndQuery(Result).AddQueryF(l_Q);
  end;

  if l_Stage in aEndStage then
  begin
   l_Q := TdtStageQuery.Create(aFromDate, aToDate, l_Stage, stfFinished);
   TdtAndQuery(Result).AddQueryF(l_Q);
  end;

  if l_Stage in aNotEndStage then
  begin
   l_Q := TdtStageQuery.Create(aFromDate, aToDate, l_Stage, stfUnfinished);
   TdtAndQuery(Result).AddQueryF(l_Q);
  end;

  if l_Stage in aNotBeginStage then
  begin
   l_Q := TdtStageQuery.Create(aFromDate, aToDate, l_Stage, stfBegined);
   SQNot(l_Q);
   TdtAndQuery(Result).AddQueryF(l_Q);
  end;
 end;

 SQAndDoneQuery(Result, aDoneFlag);
end;



function SQText2Query(const aText: string): TdtQuery;
var
 l_DelSources : Tl3LongintList;
 l_DelTypes   : Tl3LongintList;

 l_Sources            : Tl3LongintList;
 l_Types              : Tl3LongintList;
 l_FromDate, l_ToDate : TStDate;
 l_NumMask            : string;
 l_NumIsGOST          : Boolean;
 l_LawCase            : string;
 l_Text               : string;

 l_Res : TdtAndQuery;
 l_Q   : TdtQuery;
 lText : Tl3PCharLen;

 procedure AndQuery(var aQuery: TdtQuery);
 begin
  if l_Res = nil then
   l_Res := TdtAndQuery.Create;
  l_Res.AddQueryF(aQuery);
 end;

 function lFoundDictItem(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 begin
 Result := True;
  case aDictItemID.rDictionaryID of
   cDateDictID :
    begin
     if l_FromDate > 0 then
      Exit;
     l_FromDate := aDictItemID.rID;
     l_ToDate   := aDictItemID.rID;
    end;

   cNumDictID, cGostDictID:
    begin
     if l_NumMask <> '' then
      Exit;
     l_NumMask := l3MakeSimpleANSIStr(l3Str(l3PcharLen(lText.S + aSegment.rOffs, aSegment.rLen, lText.SCodePage)));
     l_NumIsGOST := (aDictItemID.rDictionaryID = cGostDictID);
    end;

   cLawcaseNumDictID:
    begin
     if l_LawCase <> '' then
      Exit;
     l_LawCase := l3MakeSimpleANSIStr(l3Str(l3PcharLen(lText.S + aSegment.rOffs, aSegment.rLen, lText.SCodePage)));
    end;

   cTextDictID :
    begin
     if l_Text <> '' then
      l_Text := l_Text + ' ';
     l_Text := l_Text + l3Str(l3PcharLen(lText.S + aSegment.rOffs, aSegment.rLen, lText.SCodePage));
    end

   else
    begin
     case TdaDictionaryType(aDictItemID.rDictionaryID) of
      da_dlSources:
       begin
        if l_DelSources.IndexOf(aDictItemID.rID) = -1 then
        begin
         if l_Sources = nil then
          l_Sources := Tl3LongintList.Make;
         l_Sources.Add(aDictItemID.rID);
        end;
       end;
      da_dlTypes:
       begin
        if l_DelTypes.IndexOf(aDictItemID.rID) = -1 then
        begin
         if l_Types = nil then
          l_Types := Tl3LongintList.Make;
         l_Types.Add(aDictItemID.rID);
        end;
       end;
     end; //case TdaDictionaryType(aDictItemID.rDictionaryID) of
    end;

   end; //case aDictItemID.rDictionaryID do
  end; //function lFoundDictItem
var
 lFDIProcStub : Tm4FoundDictItemProc;

begin
 l_Res  := nil;
 Result := nil;
 l_DelSources := Tl3LongintList.Make;
 l_DelTypes := Tl3LongintList.Make;
 try
  DictServer(CurrentFamily).DictTbl[da_dlSources].GetDelNumbers(l_DelSources);
  DictServer(CurrentFamily).DictTbl[da_dlTypes].GetDelNumbers(l_DelTypes);
  // инициализация переменных
  l_FromDate := 0;
  l_ToDate   := 0;
  l_NumMask := '';
  l_LawCase := '';
  l_Text    := '';
  l_Sources := nil;
  l_Types   := nil;
  l_NumIsGOST := False;
  lText     := l3PCharLen(aText);
  // собственно, парсим строку
  lFDIProcStub := L2FoundDictItemProc(@lFoundDictItem);
  try

   DoParsePhrase(lText, DictServer(CurrentFamily).DictScanner, lFDIProcStub);
  finally
   FreeFoundDictItemProc(lFDIProcStub);
  end;

  // разбор того, что напарсили и создание запросов
  if (l_FromDate > 0) or (l_NumMask <> '') then
  begin
   l_Q := TdtDateNumQuery.Create(l_FromDate, l_ToDate, l_NumMask, dnPublish);
   AndQuery(l_Q);
  end;

  // Поскольку номер ГОСТа всегда однозначно определяет документ, то остальное, скорее всего, будет просто мусором
  if not l_NumIsGOST then
  begin
   if l_LawCase <> '' then
   begin
    l_Q := TdtDateNumQuery.Create(0, 0, l_LawCase, dnLawCaseNum);
    AndQuery(l_Q);
   end;
 
   { Парсер кривой, выдает лишние слова для поиска. Например 23 мая => МАЯТЬ, в результате ничего не находится
   if l_Text <> '' then
   begin
    l_Q := TdtTextQuery.Create(l_Text, itHeading);
    AndQuery(l_Q);
   end;}
 
   if (l_Sources <> nil) then
   begin
    l_Q := TdtDictQuery.Create(da_dlSources, l_Sources);
    AndQuery(l_Q);
   end;

   if l_Types <> nil then
   begin
    l_Q := TdtDictQuery.Create(da_dlTypes, l_Types, False, False, True);
    AndQuery(l_Q);
   end;
  end;

  // Если какой-то запрос удалось создать, то выкинем из него недействующие редакции
  if l_Res <> nil then
  begin
   l_Q := TdtDocTypeFilterQuery.Create;
   with TdtDocTypeFilterQuery(l_Q) do
    UserTypeFilter := UserTypeFilter - [utEdition];
   AndQuery(l_Q);
  end;

  Result := l_Res;

 finally
  l3Free(l_DelSources);
  l3Free(l_DelTypes);
  l3Free(l_Sources);
  l3Free(l_Types);
 end;
end;

procedure SQ2IDList(var theQuery: TdtQuery);
var
 l_Q : TdtQuery;
begin
 if theQuery <> nil then
 begin
  l_Q := MakeIDList(theQuery);
  try
   l3Free(theQuery);
   theQuery := l_Q.Use;
  finally
   l3Free(l_Q);
  end;
 end;
end;

function MakeIDList(aQuery: TdtQuery): TdtQuery; overload;
begin
 Result := nil;
 if aQuery <> nil then
  Result := TdtIDListQuery.CreateFrom(aQuery.GetDocIdList);
end;

procedure SQOr(var theQuery: TdtQuery; aQuery: TdtQuery);
var
 l_Q : TdtOrQuery;
begin
 l_Q := TdtOrQuery.Create;
 try
  l_Q.AddQueryF(theQuery);
  l_Q.AddQuery(aQuery);
  theQuery := l_Q.Use;
 finally
  l3Free(l_Q);
 end;
end;

procedure SQAnd(var theQuery: TdtQuery; aQuery: TdtQuery);
var
 l_Q : TdtAndQuery;
begin
 l_Q := TdtAndQuery.Create;
 try
  l_Q.AddQueryF(theQuery);
  l_Q.AddQuery(aQuery);
  theQuery := l_Q.Use;
 finally
  l3Free(l_Q);
 end;
end;

procedure SQAndNot(var theQuery: TdtQuery; aQuery: TdtQuery);
var
 l_Q : TdtAndQuery;
 l_NQ: TdtQuery;
begin
 l_Q := TdtAndQuery.Create;
 try
  l_Q.AddQueryF(theQuery);
  l_NQ := TdtNOTQuery.Create;
  TdtNOTQuery(l_NQ).SubQuery := aQuery;
  l_Q.AddQueryF(l_NQ);
  theQuery := l_Q.Use;
 finally
  l3Free(l_Q);
 end;
end;

procedure SQAndF(var theQuery: TdtQuery; var aQuery: TdtQuery);
begin
 try
  SQAnd(theQuery, aQuery);
 finally
  l3Free(aQuery);
 end;
end;

procedure SQAndNotF(var theQuery: TdtQuery; var aQuery: TdtQuery);
begin
 try
  SQAndNot(theQuery, aQuery);
 finally
  l3Free(aQuery);
 end;
end;

procedure SQOrF(var theQuery: TdtQuery; var aQuery: TdtQuery);
begin
 try
  SQOr(theQuery, aQuery);
 finally
  l3Free(aQuery);
 end;
end;

function SQNewAndChangedIncuded(FromDate,ToDate : TStDate;
                                     DoneFlag : LongInt;
                                       UserID : TDictID = 0; UserGr : Boolean = False;
                                   LogRecType : TLogActionFlags = acfOrdinal): TdtQuery;
var
 l_Q: TdtQuery;
begin
 Result := TdtAndQuery.Create;
 // получаем список всех документов в диапазоне дат
 l_Q := TdtSimpleLogQuery.Create(FromDate, ToDate, UserID, UserGr, LogRecType);
 TdtAndQuery(Result).AddQueryF(l_Q);
 // Подключенные
 l_Q:= SQDocOnDoneState(cDone);
 TdtAndQuery(Result).AddQueryF(l_Q);
end;

end.
