unit nsQueryUtils;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsQueryUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsQueryUtils" MUID: (4AE864B801C5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicDocListUnit
 , l3Interfaces
 , nsTypes
 , ContextHistoryInterfaces
 , SearchUnit
 , Windows
 , FiltersUnit
 , PrimBaseSearchInterfaces
 , l3TreeInterfaces
 , nsQueryAttribute
 , nsQueryInterfaces
 //#UC START# *4AE864B801C5intf_uses*
 //#UC END# *4AE864B801C5intf_uses*
;

type
 TSysDateTime = TDateTime;

{$If NOT Defined(Monitorings)}
function nsGetContextFromQuery(ContextKind: TnsContextHistoryKind;
 const aQuery: IQuery): IvcmStrings;
 {* Операция позволяет получить контекст, участвовавший в запросе. Если не было контекста - nil. }
{$IfEnd} // NOT Defined(Monitorings)
{$If NOT Defined(Monitorings)}
function nsSearchExecute(const aQuery: IQuery;
 aResult: PInteger = nil;
 const aFilters: IFiltersFromQuery = nil;
 const aList: IDynList = nil;
 const aProcessor: InsBaseSearchResultProcessor = nil): IDynList;
 {* Операция проводит поиск по текущему запросу (aQuery), на результирующий список, накладывается фильтр (aFilter), список возвращается как результат }
{$IfEnd} // NOT Defined(Monitorings)
function nsCreateQueryName(const aQuery: IQuery): Il3CString;
 {* Формирует для запроса имя по умолчанию }
function nsIsQuerySaved(const aQuery: IQuery): Boolean;
 {* Проверяет статус isSaved для указанного объекта Query }
function LoadContextNew(const aQuery: IQuery;
 const aTagName: Il3CString;
 out aContext: Il3CString): Boolean;
 {* загружает контекст из Query }
function LoadAttributeCaption(const aQuery: IQuery;
 const aTagName: Il3CString;
 out aCaption: Il3CString): Boolean;
 {* загружает заголовок первого атрибута из Query }
procedure nsParseContext(const aContext: Il3CString;
 const aStrings: IvcmStrings);
procedure LoadLogicFromQuery(const aQuery: IQuery;
 const aTag: Il3CString;
 const aTree: Il3SimpleTree);
function SaveLogicToQuery(const aQuery: IQuery;
 const aTag: Il3CString;
 const aTree: Il3SimpleTree): Boolean;
function nsGetQueryName(const aQuery: IQuery): Il3CString;
procedure LoadPhone(const aQuery: IQuery;
 const aTagName: Tl3WString;
 out aCode: Il3CString;
 out aNumber: Il3CString);
 {* Загрузить номер телефона из IQuery }
procedure LoadDictionaryNew(aList: TqaAttrInfoList;
 const aQuery: IQuery;
 const aTagName: Il3CString);
 {* Загрузить значение реквизита }
function GetAdditionalFilter(const aTagName: Il3CString;
 aQueryType: TlgQueryType): TnsFilterType;
{$If NOT Defined(Monitorings)}
procedure nsSearch(const aQuery: IQuery;
 const aFilters: IFiltersFromQuery = nil;
 const aList: IDynList = nil;
 const aProcessor: IUnknown = nil);
 {* Операция проводит поиск по текущему запросу (aQuery), на результирующий список, накладывается фильтр (aFilter), список автоматически открывается }
{$IfEnd} // NOT Defined(Monitorings)
procedure LoadDateNew(const aQuery: IQuery;
 const aTagName: Il3CString;
 var aStartDate: TSysDateTime;
 var aEndDate: TSysDateTime);
 {* Загрузить диапазон дат из IQuery }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmStringList
 {$IfEnd} // NOT Defined(NoVCM)
 , IOUnit
 , DynamicTreeUnit
 , MonitoringUnit
 , DebugStr
 , afwFacade
 , nsConst
 , BaseTypesUnit
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsQuery
 , nsQueryExecuteProgressIndicator
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , bsUtils
 , nsUtils
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces
 , DataAdapter
 , l3InterfacesMisc
 , l3String
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 , nsManagers
 , nsQuestionsWithChoices
 , nsQuestions
 , bsTypes
 , nsContextHistory
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
 , vcmDialogs
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)
 , l3Chars
 , nsAttributeTreeStruct
 , nsTreeUtils
 , nsLogicOperationToFlags
 , SearchDomainInterfaces
 , l3Date
 , nsSearchClasses
 , nsDataExchangeProxy
 //#UC START# *4AE864B801C5impl_uses*
 {$If NOT Defined(Monitorings)}
 , Base_Operations_F1Services_Contracts
 {$IfEnd}
 //#UC END# *4AE864B801C5impl_uses*
;

const
 cContextValueSeparator = ';';

{$If NOT Defined(Monitorings)}
function nsGetContextFromQuery(ContextKind: TnsContextHistoryKind;
 const aQuery: IQuery): IvcmStrings;
 {* Операция позволяет получить контекст, участвовавший в запросе. Если не было контекста - nil. }
//#UC START# *54F98EAB038F_4AE864B801C5_var*
 procedure lp_ProcessTag(const aTag: PAnsiChar; const aList: IvcmStrings);
 var
  l_List: IQueryAttributeList;
  l_Idx: Integer;
  l_ContextIdx: Integer;
  l_Context: IQueryContextAttribute;
  l_ContextList: IContextValueList;
  l_Attribute: IQueryAttribute;
  l_ContextValue: TContextValue;
 begin
  aQuery.AttributesByTag(aTag, l_List);
  if l_List = nil then
   Exit;
  for l_Idx := 0 to Pred(l_List.Count) do
  begin
   l_List.pm_GetItem(l_Idx, l_Attribute);
   if l_Attribute.GetType = QTT_CONTEXT then
    if Supports(l_Attribute, IQueryContextAttribute, l_Context) then
    try
     l_Context.GetValues(l_ContextList);
     for l_ContextIdx := 0 to Pred(l_ContextList.Count) do
     begin
      l_ContextList.pm_GetItem(l_ContextIdx, l_ContextValue);
      with l_ContextValue do
        nsParseContext(nsCStr(rContext), aList);
     end;
    finally
     l_Context := nil;
    end;
  end;
 end;

var
 l_Strings: IvcmStrings;
//#UC END# *54F98EAB038F_4AE864B801C5_var*
begin
//#UC START# *54F98EAB038F_4AE864B801C5_impl*
 l_Strings := TvcmStringList.Make;
 case ContextKind of
  ns_chkDocument:
   begin
    lp_ProcessTag(AT_TEXT_BODY, l_Strings);
    lp_ProcessTag(AT_TEXT_NAME, l_Strings);
   end;
  ns_chkInpharm:
   begin
    lp_ProcessTag(AT_PHARM_TEXT, l_Strings);
    lp_ProcessTag(AT_PHARM_NAME, l_Strings);
   end;
 end;
 if l_Strings.Count > 0 then
  Result := l_Strings
 else
  Result := nil;
//#UC END# *54F98EAB038F_4AE864B801C5_impl*
end;//nsGetContextFromQuery
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
function nsSearchExecute(const aQuery: IQuery;
 aResult: PInteger = nil;
 const aFilters: IFiltersFromQuery = nil;
 const aList: IDynList = nil;
 const aProcessor: InsBaseSearchResultProcessor = nil): IDynList;
 {* Операция проводит поиск по текущему запросу (aQuery), на результирующий список, накладывается фильтр (aFilter), список возвращается как результат }
//#UC START# *54F98F0D007F_4AE864B801C5_var*
var
 l_Query: IQuery;
 l_TmpStr: Il3CString;
 l_QueryResult: Integer;
 l_DocCount: Integer;
 l_EditionCount: Integer;
 l_EntryCount: Integer;
 l_FilteredCount: Integer;
 l_Filterable: IFilterable;
 l_IsBuild: Boolean; // строить список
 l_BuildCount: Integer; // количество элементов в списке
 l_Root: INodeBase;
 l_SpecialMessage: Boolean;

 function FoundCount(anAmount: Integer; const anArray: TnsNumberSufixesArray): AnsiString;
 begin
   // *10, *11, ... , *19,
   if (anAmount mod 100) div 10 = 1 then
     Result := anArray[ns_nsTenth]
   // *1
   else if (anAmount mod 10) = 1 then
     Result := anArray[ns_nsSingle]
   // *2, *3, *4
   else if (anAmount mod 10) in [2, 3, 4] then
     Result := anArray[ns_nsFew]
   // *5, *6, *7, *8, *9, *0
   else
     Result := anArray[ns_nsSome];
 end;

 function FoundText(anAmount: Integer): AnsiString;
 begin
  // все *1, кроме *11
  if ((anAmount mod 10) = 1) and ((anAmount mod 100) <> 11) then
    Result := cseSinglePrefix
  else
    Result := cseOtherPrefix;
 end;

 procedure SetSearchListInfo(out aIsBuild: Boolean; out aBuildCount: Integer);
 begin
  case l_Query.GetType of
   // Автореферат
   QT_REVIEW:
    begin
     aIsBuild := afw.Settings.LoadBoolean(piSearchListIsBuildReview, dvSearchListIsBuildReview);
     aBuildCount := afw.Settings.LoadInteger(piSearchListBuildCountReview, dvSearchListBuildCountReview);
    end;
   // Остальные поисковые запросы (поиски по реквизитам, по ситуации, по
   // источнику опубликования)
  else
   aIsBuild := afw.Settings.LoadBoolean(pi_Search_List_IsBuild, dv_Search_List_IsBuild);
   aBuildCount := afw.Settings.LoadInteger(pi_Search_List_BuildCount, dv_Search_List_BuildCount);
  end;
 end;

 function lp_DoSearch(out aDocCount, aEditionCount, aEntryCount: Integer; out aResultList: IDynList): Boolean;
 var
  l_Entity: ISearchEntity;
 begin
  aResultList := nil;
  Result := TnsQueryExecuteProgressIndicator.Make(l_Query, aList).Execute(vcmCStr(str_seSearchTitle), l_Entity);
  if Result and Assigned(l_Entity) then
   with l_Entity do
   begin
    aDocCount := GetDocumentCount;
    aEditionCount := GetEditionCount;
    aEntryCount := GetEntryCount;
    case GetResultType of
     SRT_CONSULTATION: Assert(False, 'Не поддерживается');
     SRT_AUTOREFERAT: aResultList := bsMonitoringList(l_Entity);
     SRT_DOCUMENT_LIST: aResultList := bsDocumentList(l_Entity);
    end;//case l_Entity.GetResultType of
   end
  else
  begin
   aDocCount := 0;
   aEditionCount := 0;
   aEntryCount := 0;
  end;
 end;//lp_Result

 function lp_QueryHasAttribute(const aQuery: IQuery; const aTag: PAnsiChar): Boolean;
 var
  l_List: IQueryAttributeList;
 begin
  aQuery.AttributesByTag(aTag, l_List);
  Result := Assigned(l_List) and (l_List.Count > 0);
 end;

 procedure AddQueryToJournal(const aQuery: IQuery);
 var
  l_NewQuery: IQuery;
 begin
  if aQuery.GetType in [QT_COMMENTS,
                        QT_MAIL_LIST,
                        QT_HANDYCRAFT_CONSULT] then
   Exit;
  aQuery.Clone(l_NewQuery);
  if Assigned(l_NewQuery) then
   TWorkJournalService.Instance.MakeWorkJournal.AddQuery(l_NewQuery);
 end;//AddQueryToJournal

var
 l_FilterName: Il3CString;
 l_Button: Integer;
 l_Filter: IFilterFromQuery;

const
 cseBuild: array[Boolean] of AnsiString = (cseBuildList, cseBuildAutoreferat);
 cseBuildWOEntry: array[Boolean] of AnsiString = (cseBuildListWOEntry, cseBuildAutoreferatWOEntry);
 cseBuildWOEdition: array[Boolean] of AnsiString = (cseBuildListWOEdition, cseBuildAutoreferatWOEdition);
 cseBuildWOEditionWOEntry: array[Boolean] of AnsiString = (cseBuildListWOEditionWOEntry, cseBuildAutoreferatWOEditionWOEntry);

 str_seBuild: array[Boolean] of PVCMStringID = (@str_seBuildList, @str_seBuildAutoreferat);
 str_seBuildWOEntry: array[Boolean] of PVCMStringID = (@str_seBuildListWOEntry, @str_seBuildAutoreferatWOEntry);
 str_seBuildWOEdition: array[Boolean] of PVCMStringID = (@str_seBuildListWOEdition, @str_seBuildAutoreferatWOEdition);
 str_seBuildWOEditionWOEntry: array[Boolean] of PVCMStringID = (@str_seBuildListWOEditionWOEntry, @str_seBuildAutoreferatWOEditionWOEntry);
//#UC END# *54F98F0D007F_4AE864B801C5_var*
begin
//#UC START# *54F98F0D007F_4AE864B801C5_impl*
 l_SpecialMessage := afw.Application.LocaleInfo.Language = afw_lngRussian;
 if aResult <> nil then
  aResult^ := 0;
 if aQuery <> nil then
  l_Query := aQuery
 else
  l_Query := DefDataAdapter.CreateEmptyQuery(QT_ATTRIBUTE);
 try
  if lp_DoSearch(l_DocCount, l_EditionCount, l_EntryCount, Result) then
  begin
   if Result <> nil then
   begin
    if Assigned(aProcessor) then
     aProcessor.SearchResultExists;
    l_TmpStr := nil;
    if Assigned(aFilters) and (aFilters.Count > 0) then
    begin
     if l3BQueryInterface(Result, IFilterable, l_Filterable) then
     try
      if (aFilters.Count = 1) then
      begin
       aFilters.pm_GetItem(0, l_Filter);
       l_FilterName := nsGetFilterCaption(l_Filter);
      end;//if (aFilters.Count = 1)
      try
       // фильтрация
       l_Filterable.ApplyFilters(aFilters);
       // Получаем количество отфильтрованных элементов списка
       Result.GetRoot(l_Root);
       try
        l_FilteredCount:= l_Root.GetChildCount;
       finally
        l_Root := nil;
       end;
       SetSearchListInfo(l_IsBuild, l_BuildCount);
       if l_IsBuild and (l_FilteredCount > l_BuildCount) then
       begin
        if l_SpecialMessage then
         if not l3IsNil(l_FilterName) then
          l_TmpStr := l3Fmt(cseSingleFilterFound,[FoundText(l_FilteredCount),
           l_FilteredCount, FoundCount(l_FilteredCount, cseDocument), l_FilterName])
         else
          l_TmpStr := l3Fmt(cseManyFilterFound,[FoundText(l_FilteredCount),
           l_FilteredCount, FoundCount(l_FilteredCount, cseDocument), aFilters.Count])
        else
        if not l3IsNil(l_FilterName) then
         l_TmpStr := vcmFmt(str_seSingleFilterFound, [l_FilteredCount, l_FilterName])
        else
         l_TmpStr := vcmFmt(str_seManyFilterFound, [l_FilteredCount, aFilters.Count])
       end;//if l_IsBuild and (l_FilteredCount > l_BuildCount)
      except
       if l_SpecialMessage then
        if not l3IsNil(l_FilterName) then
        begin
         if (l_EditionCount > 0) and (l_EntryCount > 0) then
          l_TmpStr := l3Fmt(cseSingleFilterNotFound, [l_FilterName, l_DocCount, FoundCount(l_DocCount, cseDocument),
                                                                    l_EditionCount, FoundCount(l_EditionCount, cseEdition),
                                                                    l_EntryCount, FoundCount(l_EntryCount, cseEntry)])
         else
         if l_EditionCount > 0 then
          l_TmpStr := l3Fmt(cseSingleFilterNotFoundWOEntry, [l_FilterName, l_DocCount, FoundCount(l_DocCount, cseDocument),
                                                                    l_EditionCount, FoundCount(l_EditionCount, cseEdition)])
         else
         if l_EntryCount > 0 then
          l_TmpStr := l3Fmt(cseSingleFilterNotFoundWOEdition, [l_FilterName, l_DocCount, FoundCount(l_DocCount, cseDocument),
                                                                    l_EntryCount, FoundCount(l_EntryCount, cseEntry)])
         else
          l_TmpStr := l3Fmt(cseSingleFilterNotFoundWOEditionWOEntry, [l_FilterName, l_DocCount, FoundCount(l_DocCount, cseDocument)])
        end
        else//if not l3IsNil(l_FilterName)
        begin
         if (l_EditionCount > 0) and (l_EntryCount > 0) then
          l_TmpStr := l3Fmt(cseManyFilterNotFound, [l_DocCount, FoundCount(l_DocCount, cseDocument),
                                                    l_EditionCount, FoundCount(l_EditionCount, cseEdition),
                                                    l_EntryCount, FoundCount(l_EntryCount, cseEntry)])
         else
         if l_EditionCount > 0 then
          l_TmpStr := l3Fmt(cseManyFilterNotFoundWOEntry, [l_DocCount, FoundCount(l_DocCount, cseDocument),
                                                           l_EditionCount, FoundCount(l_EditionCount, cseEdition)])
         else
         if l_EntryCount > 0 then
          l_TmpStr := l3Fmt(cseManyFilterNotFoundWOEdition, [l_DocCount, FoundCount(l_DocCount, cseDocument),
                                                             l_EntryCount, FoundCount(l_EntryCount, cseEntry)])
         else
          l_TmpStr := l3Fmt(cseManyFilterNotFoundWOEditionWOEntry, [l_DocCount, FoundCount(l_DocCount, cseDocument)])
        end//if not l3IsNil(l_FilterName)
       else//if l_SpecialMessage
        if not l3IsNil(l_FilterName) then
        begin
         if (l_EditionCount > 0) and (l_EntryCount > 0) then
          l_TmpStr := vcmFmt(str_seSingleFilterNotFound, [l_FilterName, l_DocCount, l_EditionCount, l_EntryCount])
         else
         if l_EditionCount > 0 then
          l_TmpStr := vcmFmt(str_seSingleFilterNotFoundWOEntry, [l_FilterName, l_DocCount, l_EditionCount])
         else
         if l_EntryCount > 0 then
          l_TmpStr := vcmFmt(str_seSingleFilterNotFoundWOEdition, [l_FilterName, l_DocCount, l_EntryCount])
         else
          l_TmpStr := vcmFmt(str_seSingleFilterNotFoundWOEditionWOEntry, [l_FilterName, l_DocCount])
        end
        else//if not l3IsNil(l_FilterName)
        begin
         if (l_EditionCount > 0) and (l_EntryCount > 0) then
          l_TmpStr := vcmFmt(str_seManyFilterNotFound, [l_DocCount, l_EditionCount, l_EntryCount])
         else
         if l_EditionCount > 0 then
          l_TmpStr := vcmFmt(str_seManyFilterNotFoundWOEntry, [l_DocCount, l_EditionCount])
         else
         if l_EntryCount > 0 then
          l_TmpStr := vcmFmt(str_seManyFilterNotFoundWOEdition, [l_DocCount, l_EntryCount])
         else
          l_TmpStr := vcmFmt(str_seManyFilterNotFoundWOEditionWOEntry, [l_DocCount])
        end//if not l3IsNil(l_FilterName)
      end;//try..except
     finally
      l_Filterable := nil;
     end;//try..finally
    end
    else//if Assigned(aFilters) and (aFilters.Count > 0)
    begin
     SetSearchListInfo(l_IsBuild, l_BuildCount);
     if l_IsBuild and ((l_DocCount + l_EditionCount) > l_BuildCount) then
      if l_SpecialMessage then
      begin
       if (l_EditionCount > 0) and (l_EntryCount > 0) then
        l_TmpStr := l3Fmt(cseBuild[l_Query.GetType = QT_REVIEW],
                          [l_DocCount, FoundCount(l_DocCount, cseDocument),
                          l_EditionCount, FoundCount(l_EditionCount, cseEdition),
                          l_EntryCount, FoundCount(l_EntryCount, cseEntry)])
       else
       if l_EditionCount > 0 then
        l_TmpStr := l3Fmt(cseBuildWOEntry[l_Query.GetType = QT_REVIEW],
                          [l_DocCount, FoundCount(l_DocCount, cseDocument),
                          l_EditionCount, FoundCount(l_EditionCount, cseEdition)])
       else
       if l_EntryCount > 0 then
        l_TmpStr := l3Fmt(cseBuildWOEdition[l_Query.GetType = QT_REVIEW],
                          [l_DocCount, FoundCount(l_DocCount, cseDocument),
                          l_EntryCount, FoundCount(l_EntryCount, cseEntry)])
       else
        l_TmpStr := l3Fmt(cseBuildWOEditionWOEntry[l_Query.GetType = QT_REVIEW],
                          [l_DocCount, FoundCount(l_DocCount, cseDocument)])
      end
      else//if l_SpecialMessage
      begin
       if (l_EditionCount > 0) and (l_EntryCount > 0) then
        l_TmpStr := vcmFmt(str_seBuild[l_Query.GetType = QT_REVIEW]^, [l_DocCount, l_EditionCount, l_EntryCount])
       else
       if l_EditionCount > 0 then
        l_TmpStr := vcmFmt(str_seBuildWOEntry[l_Query.GetType = QT_REVIEW]^, [l_DocCount, l_EditionCount])
       else
       if l_EntryCount > 0 then
        l_TmpStr := vcmFmt(str_seBuildWOEdition[l_Query.GetType = QT_REVIEW]^, [l_DocCount, l_EntryCount])
       else
        l_TmpStr := vcmFmt(str_seBuildWOEditionWOEntry[l_Query.GetType = QT_REVIEW]^, [l_DocCount])
      end//if l_SpecialMessage
    end;//if Assigned(aFilters) and (aFilters.Count > 0)

    if l3IsNil(l_TmpStr) then
     l_QueryResult := mrYes
    else
     l_QueryResult := vcmShowMessageDlg(Tl3Message_C(l_TmpStr, 'nsSearchExecute', mtConfirmation, [mbYes, mbNo]));

    if l_QueryResult <> mrYes then
     Result := nil
    else
    begin
     {$IfDef vcmUseProfilers}
     ProfilersManager.ListAfterSearch.Start;
     {$EndIf vcmUseProfilers}
     {$If not defined(Admin) and not defined(Monitorings)}
     AddQueryToJournal(l_Query);
     {$IfEnd}
    end;
   end
   else//if Result <> nil
   begin
    if (l_Query.GetType = QT_BASE_SEARCH) then
    begin
     if lp_QueryHasAttribute(aQuery, AT_BASE_SEARCH_PANES{AT_PREFIX}) then
     begin
      if vcmAsk(qr_EmptyResultAfterBaseSearchWithPrefix) then
       TBaseSearchService.Instance.TryAnotherBaseSearch(nil, aProcessor)
      else
      if Assigned(aProcessor) then
       aProcessor.AnotherSearchCancelled;
      Exit;
     end;//if lp_QueryHasAttribute(aQuery, AT_BASE_SEARCH_PANES{AT_PREFIX})
     if Assigned(aList) then
     begin
      if aList.GetIsShort then
      case vcmMessageDlg(str_EmptySearchResultInBaseList, []) of
       -1: TBaseSearchService.Instance.TryAnotherBaseSearch(nil, aProcessor, True);
       -2: TBaseSearchService.Instance.TryAnotherBaseSearch(nil, aProcessor);
      end
      else
      if lp_QueryHasAttribute(aQuery, AT_TEXT_NAME) then
      begin
       if vcmAsk(qr_EmptyResultAfterBaseSearchInNames) then
        TBaseSearchService.Instance.TryAnotherBaseSearch(nil, aProcessor);
      end//lp_QueryHasAttribute(aQuery, AT_TEXT_NAME)
      else
      if vcmAsk(qr_EmptyResultAfterBaseSearchInList) then
       TBaseSearchService.Instance.TryAnotherBaseSearch(nil, aProcessor);
      Exit;
     end;//Assigned(aList)
    end;//l_Query.GetType = QT_BASE_SEARCH
    if Assigned(aList) then
     vcmSay(war_EmptyResultAfterSearchInList)
    else
     if (l_Query.GetType <> QT_COMMENTS) and (l_Query.GetType <> QT_PHARM_SEARCH) and
       DefDataAdapter.ConsultationManager.CheckConsultingAvailable and
       not defDataAdapter.AdministratorLogin then
     begin
      // В английской версии не предлагаем обратиться в ППО
      // http://mdp.garant.ru/pages/viewpage.action?pageId=498142205
      if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) then
       l_Button := vcmMessageDlg(str_ConsultDocumentsNotFound, [])
      else
      begin
       vcmMessageDlg(str_ConsultDocumentsNotFoundNoSpec, []);
       // Единственный вариант - вернуться в карточку
       l_Button := -2;
      end;
      if aResult <> nil then
       aResult^ := l_Button;
     end
     else
     if l_Query.GetType = QT_COMMENTS then
      vcmSay(war_DocumentsWithUserCommentsNotFound)
     else
      vcmSay(war_DocumentsNotFound);
   end;//if Result <> nil
  end
  else//if lp_DoSearch(l_DocCount, l_EditionCount, l_EntryCount, Result)
  begin
   l_Button := vcmMessageDlg(war_SearchCancelled);
   if aResult <> nil then
    aResult^ := l_Button;
  end;//if lp_DoSearch(l_DocCount, l_EditionCount, l_EntryCount, Result)
 finally
  l_Query := nil;
 end;
//#UC END# *54F98F0D007F_4AE864B801C5_impl*
end;//nsSearchExecute
{$IfEnd} // NOT Defined(Monitorings)

function nsCreateQueryName(const aQuery: IQuery): Il3CString;
 {* Формирует для запроса имя по умолчанию }
//#UC START# *54F98FF20087_4AE864B801C5_var*
const
 l_QueryNamePatternsForSave: array[TQueryType] of PvcmStringID = (
   @str_cqnKeywordForSave,
   @str_cqnAttributeForSave,
   //@str_cqnOldAttributeForSave,
   //@str_cqnOldFilterForSave,
   @str_cqnPublishSourceForSave,
   @str_cqnCommentsForSave,
   @str_cqnReviewForSave,
   @str_cqnMailListForSave,
   @str_Empty,
   @str_Empty,
   @str_Empty,
   @str_Empty,
   @str_cqnBaseSearchForSave,
   @str_cqnInpharmSearchForSave);
//#UC END# *54F98FF20087_4AE864B801C5_var*
begin
//#UC START# *54F98FF20087_4AE864B801C5_impl*
 Result := nsGetQueryName(aQuery);
 if l3IsNil(Result) then
  Result := vcmFmt(l_QueryNamePatternsForSave[aQuery.GetType]^, [DateTimeToStr(Now)]);
//#UC END# *54F98FF20087_4AE864B801C5_impl*
end;//nsCreateQueryName

function nsIsQuerySaved(const aQuery: IQuery): Boolean;
 {* Проверяет статус isSaved для указанного объекта Query }
//#UC START# *54F992C20305_4AE864B801C5_var*
var
 l_CurEntity: IEntityBase;
//#UC END# *54F992C20305_4AE864B801C5_var*
begin
//#UC START# *54F992C20305_4AE864B801C5_impl*
 if l3BQueryInterface(aQuery, IEntityBase, l_CurEntity) then
 try
  Result := l_CurEntity.GetIsSaved;
 finally
  l_CurEntity := nil;
 end//try..finally
 else
  Result := False;
//#UC END# *54F992C20305_4AE864B801C5_impl*
end;//nsIsQuerySaved

function LoadContextNew(const aQuery: IQuery;
 const aTagName: Il3CString;
 out aContext: Il3CString): Boolean;
 {* загружает контекст из Query }
//#UC START# *54F992EA00FA_4AE864B801C5_var*
var
 l_ValueList: IQueryAttributeList;
 l_Context: IQueryContextAttribute;
 l_List: IContextValueList;
 l_Attribute: IQueryAttribute;
 l_ContextValue: TContextValue;
 l_Count: Integer;
 l_Index: Integer;
 l_ContextStr: Il3CString;
//#UC END# *54F992EA00FA_4AE864B801C5_var*
begin
//#UC START# *54F992EA00FA_4AE864B801C5_impl*
 Result := False;
 aQuery.AttributesByTag(nsAStr(aTagName).S, l_ValueList);
 if Assigned(l_ValueList) then
 try
  if (l_ValueList.Count > 0) then
  begin
   Result := True;
   l_ValueList.pm_GetItem(0, l_Attribute);
   if (l_Attribute.GetType = QTT_CONTEXT) and Supports(l_Attribute, IQueryContextAttribute, l_Context) then
   try
    l_Context.GetValues(l_List);
    try
     l_Count := l_List.Count;
     if (l_Count > 0) then
     begin
      for l_Index := 0 to Pred(l_Count) do
      begin
       if (l_Index > 0) then
        l_ContextStr := l3Cat([l_ContextStr, nsCStr(cContextValueSeparator)]);
       l_List.pm_GetItem(l_Index, l_ContextValue);
       l_ContextStr := l3Cat([l_ContextStr, nsCStr(l_ContextValue.rContext)]);
      end;
      aContext := l_ContextStr;
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=597354916
     end;
    finally
     l_List := nil;
    end;//try..finally
   finally
    l_Context := nil;
   end;//try..finally
  end;//l_ValueList.GetCount > 0
 finally
  l_ValueList := nil;
 end;//try..finally
//#UC END# *54F992EA00FA_4AE864B801C5_impl*
end;//LoadContextNew

function LoadAttributeCaption(const aQuery: IQuery;
 const aTagName: Il3CString;
 out aCaption: Il3CString): Boolean;
 {* загружает заголовок первого атрибута из Query }
//#UC START# *54F9934D0399_4AE864B801C5_var*
var
 l_ValueList: IQueryAttributeList;
 l_Node: IQueryNodeAttribute;
 l_List: INodeValueList;
 l_Caption: IString;
 l_Attribute: IQueryAttribute;
 l_Value: TQueryNodeValue;
//#UC END# *54F9934D0399_4AE864B801C5_var*
begin
//#UC START# *54F9934D0399_4AE864B801C5_impl*
 Result := False;
 aQuery.AttributesByTag(nsAStr(aTagName).S, l_ValueList);
 if Assigned(l_ValueList) then
 try
  if (l_ValueList.Count > 0) then
  begin
   Result := True;
   l_ValueList.pm_GetItem(0, l_Attribute);
   if (l_Attribute.GetType = QTT_NODE) and Supports(l_Attribute, IQueryNodeAttribute, l_Node) then
   try
    l_Node.GetValues(l_List);
    try
     if l_List.Count > 0 then
     begin
      l_List.pm_GetItem(0, l_Value);
      l_Value.rNode.GetCaption(l_Caption);
      aCaption := nsCStr(l_Caption);
      Result := True;
     end;
    finally
     l_List := nil;
    end;//try..finally
   finally
    l_Node := nil;
   end;//try..finally
  end;//l_ValueList.GetCount > 0
 finally
  l_ValueList := nil;
 end;//try..finally
//#UC END# *54F9934D0399_4AE864B801C5_impl*
end;//LoadAttributeCaption

procedure nsParseContext(const aContext: Il3CString;
 const aStrings: IvcmStrings);
//#UC START# *54F993CB03AA_4AE864B801C5_var*
 function MissSimbol(var aIndex: Integer; aSimbol: AnsiChar; const aValue: Il3CString): Integer;
 { MissSimbol - пропускаем одинакомые символы идущие один за другим.
    Result - количество пропущенных символов; }
 begin//MissSimbol
  Result := 0;
  while (l3Len(aValue) > aIndex + 1) and
   l3IsChar(aValue, aIndex + 1, aSimbol) do
  begin
   Inc(Result);
   Inc(aIndex);
  end;//while..
 end;//MissSimbol

var
 l_Index, l_Marker: Integer;
//#UC END# *54F993CB03AA_4AE864B801C5_var*
begin
//#UC START# *54F993CB03AA_4AE864B801C5_impl*
 if not l3IsNil(aContext) then
 begin
  (* выходим, нет символов, которые нам интересны *)
  if not l3CharSetPresent(aContext, [';', '"']) then
   aStrings.Add(aContext)
  else
  begin
   l_Index := 0;
   l_Marker := 0;
   while (l_Index < l3Len(aContext)) do
   begin
    case l3Char(aContext, l_Index) of
     ';':
      if (l_Index > 0) then
      begin
       if not l3IsChar(aContext, l_Marker, ';') then
        aStrings.Add(l3Trim(l3Copy(aContext, l_Marker, l_Index - l_Marker)));
       MissSimbol(l_Index, ';', aContext);
       l_Marker := l_Index + 1;
      end//l_Index > 0
      else
       l_Marker := 1;
    end;//case l3Char(aContext, l_Index)
    Inc(l_Index);
   end;//while (l_Index < l3Len(aContext))
   if (l_Marker < l3Len(aContext)) then
    aStrings.Add(l3Trim(l3Copy(aContext, l_Marker, l3Len(aContext) - l_Marker + 1)));
  end;//l3AllCharsInCharSet
 end;//not l3IsNil(aContext)
//#UC END# *54F993CB03AA_4AE864B801C5_impl*
end;//nsParseContext

procedure LoadLogicFromQuery(const aQuery: IQuery;
 const aTag: Il3CString;
 const aTree: Il3SimpleTree);
//#UC START# *54F99436023D_4AE864B801C5_var*
var
 l_List: TqaAttrInfoList;
 l_Node: INodeBase;
 l_TreeNode: INodeBase;
 l_Index: Integer;
 l_FakeTree: Il3SimpleTree;
 l_A: TqaAttrInfo;
//#UC END# *54F99436023D_4AE864B801C5_var*
begin
//#UC START# *54F99436023D_4AE864B801C5_impl*
 /////// !! временно, для обхода бага в дереве, сохраняем не сам узел, а его "близнеца" в большом дереве
 //////  !! убрать после починки дерева
 /////  см. _GetTwinNode
 l_FakeTree := TnsAttributeTreeStruct.Make(aTag, aTree.ShowRoot);
 //////////////////////////////////////////////////////////////////////////////

 l_List := TqaAttrInfoList.Create;
 try
  {$IfNDef Admin}
  LoadDictionaryNew(l_List, aQuery, aTag);
  {$Else  Admin}
  Assert(False);
  {$EndIf Admin}
  for l_Index := 0 to l_List.Count - 1 do
  begin
   l_A := l_List[l_Index];
   l_Node := l_A.NodeBase;
   l_TreeNode := GetTwinNode(l_FakeTree, l_Node);
   if l_TreeNode <> nil then
    SetLogicOperation(l_TreeNode, l_A.Oper)
   else
    SetLogicOperation(l_Node, l_A.Oper);
  end;//for l_Index
 finally
  vcmFree(l_List);
 end;//try..finally
//#UC END# *54F99436023D_4AE864B801C5_impl*
end;//LoadLogicFromQuery

function SaveLogicToQuery(const aQuery: IQuery;
 const aTag: Il3CString;
 const aTree: Il3SimpleTree): Boolean;
//#UC START# *54F994590042_4AE864B801C5_var*
var
 l_Root: INodeBase;
 l_FakeTree: Il3SimpleTree;

 procedure SaveOpToQuery(aOp: TLogicOperation);
 var
  l_Node: INodeBase;
  l_Iterator: INodeIterator;   
  l_Twin: INodeBase;
 begin
  l_Iterator := GetOperationIterator(l_Root, aOp);
  try
   l_Iterator.GetNext(l_Node);
   while l_Node <> nil do
   begin
    l_Twin := GetTwinNode(l_FakeTree, l_Node);
    {$If not defined(Admin)}
    if l_Twin <> nil then
     SaveAttributeNew(aQuery, aTag, aOp, l_Twin)
    else
     SaveAttributeNew(aQuery, aTag, aOp, l_Node);
    {$Else}
    Assert(False);
    {$IfEnd}
    l_Iterator.GetNext(l_Node);
    Result := True;
   end;
  finally
   l_Iterator := nil;
  end;
 end;
//#UC END# *54F994590042_4AE864B801C5_var*
begin
//#UC START# *54F994590042_4AE864B801C5_impl*
 Result := False;
 if Supports(aTree.RootNode, INodeBase, l_Root) then
 try
  /////// !! временно, для обхода бага в дереве, сохраняем не сам узел, а его "близнеца" в большом дереве
  //////  !! убрать после починки дерева
  /////  см. _GetTwinNode
  l_FakeTree := TnsAttributeTreeStruct.Make(aTag, aTree.ShowRoot);
  //////////////////////////////////////////////////////////////////////////////
  SaveOpToQuery(loOr);
  SaveOpToQuery(loAnd);
  SaveOpToQuery(loNot);
 finally
  l_Root := nil;
 end;
//#UC END# *54F994590042_4AE864B801C5_impl*
end;//SaveLogicToQuery

function nsGetQueryName(const aQuery: IQuery): Il3CString;
//#UC START# *54F9947602D7_4AE864B801C5_var*
var
 l_String: IString;
//#UC END# *54F9947602D7_4AE864B801C5_var*
begin
//#UC START# *54F9947602D7_4AE864B801C5_impl*
 if Assigned(aQuery) then
  aQuery.GetName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
//#UC END# *54F9947602D7_4AE864B801C5_impl*
end;//nsGetQueryName

procedure LoadPhone(const aQuery: IQuery;
 const aTagName: Tl3WString;
 out aCode: Il3CString;
 out aNumber: Il3CString);
 {* Загрузить номер телефона из IQuery }
//#UC START# *54F9953503AE_4AE864B801C5_var*
var
 l_Node: IQueryPhoneNumberAttribute;
 l_Str: IString;
//#UC END# *54F9953503AE_4AE864B801C5_var*
begin
//#UC START# *54F9953503AE_4AE864B801C5_impl*
 aQuery.GetPhoneNumberAttribute(nsAStr(aTagName).S, l_Node);
 l_Node.GetCityCode(l_Str);
 aCode := nsCStr(l_Str);
 l_Node.GetPhoneNumber(l_Str);
 aNumber := nsCStr(l_Str);
//#UC END# *54F9953503AE_4AE864B801C5_impl*
end;//LoadPhone

procedure LoadDictionaryNew(aList: TqaAttrInfoList;
 const aQuery: IQuery;
 const aTagName: Il3CString);
 {* Загрузить значение реквизита }
//#UC START# *54F9956D01A4_4AE864B801C5_var*
var
 l_List: IQueryAttributeList;
 l_Index: Integer;
 l_Context: IQueryContextAttribute;
 l_Node: IQueryNodeAttribute;
 l_ContextList: IContextValueList;
 l_I: Integer;
 l_NodeList: INodeValueList;
 l_AttrInfo: TqaAttrInfo;
 l_Count: Integer;
 l_ContCount: Integer;
 l_NodeCount: Integer;
 l_Attribute: IQueryAttribute;
 l_ContextValue: TContextValue;
 l_NodeValue: TQueryNodeValue;
//#UC END# *54F9956D01A4_4AE864B801C5_var*
begin
//#UC START# *54F9956D01A4_4AE864B801C5_impl*
 aQuery.AttributesByTag(nsAStr(aTagName).S, l_List);
 if Assigned(l_List) then
 try
  l_Count := l_List.Count - 1;
  for l_Index := 0 to l_Count do
  begin
   l_List.pm_GetItem(l_Index, l_Attribute);
   case l_Attribute.GetType of
      // Маска для номеров
    QTT_CONTEXT:
     if Supports(l_Attribute, IQueryContextAttribute, l_Context) then
     try
      l_Context.GetValues(l_ContextList);
      l_ContCount := l_ContextList.Count - 1;
      for l_I := 0 to l_ContCount do
      begin
       l_ContextList.pm_GetItem(l_I, l_ContextValue);
       with l_ContextValue do
       begin
        l_AttrInfo := TqaAttrInfo.Create(LQOperationToLSelection(rOperation), nil, nsCStr(rContext));
        try
         aList.Add(l_AttrInfo);
        finally
         vcmFree(l_AttrInfo);
        end;
       end;
      end;
     finally
      l_Context := nil;
     end;
      // Древовидное значение
    QTT_NODE:
     if Supports(l_Attribute, IQueryNodeAttribute, l_Node) then
     try
      l_Node.GetValues(l_NodeList);
      l_NodeCount := l_NodeList.Count - 1;
      for l_I := 0 to l_NodeCount do
      begin
       l_NodeList.pm_GetItem(l_I, l_NodeValue);
       with l_NodeValue do
       begin
        l_AttrInfo := TqaAttrInfo.Create(LQOperationToLSelection(rOperation), rNode);
        try
         aList.Add(l_AttrInfo);
        finally
         vcmFree(l_AttrInfo);
        end;
       end;
      end;
     finally
      l_Node := nil;
     end;
    end;
  end;
 finally
  l_List := nil;
 end;
//#UC END# *54F9956D01A4_4AE864B801C5_impl*
end;//LoadDictionaryNew

function GetAdditionalFilter(const aTagName: Il3CString;
 aQueryType: TlgQueryType): TnsFilterType;
//#UC START# *54F99595006E_4AE864B801C5_var*
//#UC END# *54F99595006E_4AE864B801C5_var*
begin
//#UC START# *54F99595006E_4AE864B801C5_impl*
 case aQueryType of
  lg_qtLegislationReview:
   if l3Same(aTagName, AT_CLASS) or
      l3Same(aTagName, AT_CLASS_REVIEW) then
    Result := ns_ftTrim
   else
   if (l3Same(aTagName, AT_SOURCE) or
       l3Same(aTagName, AT_SOURCE_REVIEW) OR
       l3Same(aTagName, AT_PREFIX_REVIEW)) then
    Result := ns_ftTrimLeaf
   else
    Result := ns_ftNone;
  lg_qtAttribute:
   if l3Same(aTagName, AT_PREFIX) then
    Result := ns_ftTrimLeaf
   else
    Result := ns_ftNone;
 else
  Result := ns_ftNone;
 end;//Case aQueryType
 if l3Same(aTagName, AT_BASES) then
  Result := ns_ftBlocks;
//#UC END# *54F99595006E_4AE864B801C5_impl*
end;//GetAdditionalFilter

{$If NOT Defined(Monitorings)}
procedure nsSearch(const aQuery: IQuery;
 const aFilters: IFiltersFromQuery = nil;
 const aList: IDynList = nil;
 const aProcessor: IUnknown = nil);
 {* Операция проводит поиск по текущему запросу (aQuery), на результирующий список, накладывается фильтр (aFilter), список автоматически открывается }
//#UC START# *54F98FAF0095_4AE864B801C5_var*
 function lp_GetListOpenFrom: TbsListOpenFrom;
 begin
  case aQuery.GetType of
   QT_BASE_SEARCH:
    if Assigned(aList) then
     Result := lofBaseSearchEx
    else
     Result := lofBaseSearch;
   QT_ATTRIBUTE: Result := lofAttributeSearch;
  else
   Result := lofNone;
  end;
  //http://mdp.garant.ru/pages/viewpage.action?pageId=567573990
 end;
var
 l_FoundList: IDynList;
 l_Result: Integer;
 l_Comment: IString;
 l_Query: IQuery;
 l_ConsultationText: Il3CString;
 l_Context: IvcmStrings;
 l_Processor: InsBaseSearchResultProcessor;
const
 cMap: array[Boolean] of TnsContextHistoryKind = (ns_chkDocument, ns_chkInpharm);
//#UC END# *54F98FAF0095_4AE864B801C5_var*
begin
//#UC START# *54F98FAF0095_4AE864B801C5_impl*
 if (aQuery.GetType = QT_REVIEW) and not defDataAdapter.LegislationReviewAvailable then
  vcmSay(err_QueryCannotBeExecuted)
 else
 begin
  l_Context := nsGetContextFromQuery(cMap[aQuery.GetType = QT_PHARM_SEARCH], aQuery);
  try
   if Assigned(l_Context) then
    nsGetContextHistory(cMap[aQuery.GetType = QT_PHARM_SEARCH]).Searched(l_Context);
  finally
   l_Context := nil;
  end;

  Supports(aProcessor, InsBaseSearchResultProcessor, l_Processor);

  l_FoundList := nsSearchExecute(aQuery, @l_Result, aFilters, aList, l_Processor);
  try
   if (l_FoundList <> nil) then
   begin
    if (aQuery.GetType <> QT_BASE_SEARCH) and Assigned(l_Processor) then
      l_Processor.AnotherSearchSuccessed;
    if (aQuery.GetType <> QT_REVIEW) then
     TnsDataExchangeProxy.Instance.MakeAndOpenList(l_FoundList, lp_GetListOpenFrom)
    else
     TMonitoringsService.Instance.OpenAutoreferatAfterSearch(l_FoundList as IMonitoringList, nil);
   end//l_FoundList <> nil
   else
   if (l_Result = vcm_mrCustomButton) then
   begin
    if (aQuery.GetType in [QT_ATTRIBUTE, QT_BASE_SEARCH]) then
    begin
     DefDataAdapter.Search.CreateQuery(QT_HANDYCRAFT_CONSULT, l_Query);
     aQuery.GetComment(l_Comment);
     l_ConsultationText := vcmFmt(str_FailedSearchTemplate,[nsCStr(l_Comment)]);
     l_ConsultationText := l3StringReplace(l_ConsultationText, cc_EOLStr, cc_SoftEnterNativeStr, [rfReplaceAll]);
     l_ConsultationText := l3StringReplace(l_ConsultationText, cc_HardEnterNativeStr, cc_SoftEnterNativeStr, [rfReplaceAll]);
     SaveContextNew(l_Query, nsCStr(AT_LAW_SUPPORT_TEXT), l_ConsultationText);
    end//aQuery.GetType in [QT_ATTRIBUTE, QT_BASE_SEARCH]
    else
     l_Query := nil;
    TConsultationService.Instance.OpenSendConsultation(l_Query);
   end;
  finally
   l_FoundList := nil;
  end;//try..finally
 end;//not defDataAdapter.Monitoring.IsExist
//#UC END# *54F98FAF0095_4AE864B801C5_impl*
end;//nsSearch
{$IfEnd} // NOT Defined(Monitorings)

procedure LoadDateNew(const aQuery: IQuery;
 const aTagName: Il3CString;
 var aStartDate: TSysDateTime;
 var aEndDate: TSysDateTime);
 {* Загрузить диапазон дат из IQuery }
//#UC START# *54F994DE0329_4AE864B801C5_var*
var
 l_Node: IQueryDateAttribute;
 l_List: IQueryAttributeList;
 l_ValueList: IDateValueList;
 l_Attribute: IQueryAttribute;
 l_DateValue: TDateValue;
//#UC END# *54F994DE0329_4AE864B801C5_var*
begin
//#UC START# *54F994DE0329_4AE864B801C5_impl*
 aStartDate := NullDate;
 aEndDate := NullDate;
 aQuery.AttributesByTag(nsAStr(aTagName).S, l_List);
 if Assigned(l_List) and (l_List.Count > 0) then
 begin
  // Для одного тега может быть только одно значение
  l_List.pm_GetItem(0, l_Attribute);
  if (l_Attribute.GetType = QTT_DATE) and Supports(l_Attribute, IQueryDateAttribute, l_Node) then
  try
   // Список значений
   l_Node.GetValues(l_ValueList);
   if l_ValueList.Count > 0 then
   begin
    l_ValueList.pm_GetItem(0, l_DateValue);
    with l_DateValue do
    begin
     // Начало
     if not IsNullDate(rFrom) then
      aStartDate := GblAdapterDateToDateTime(rFrom);
     // Конец
     if not IsNullDate(rTo) then
      aEndDate := GblAdapterDateToDateTime(rTo);
    end;//with l_ValueList.GetDataPtr(0)^
   end;
  finally
   l_Node := nil;
  end;//try..finally
 end;//l_List.GetCount > 0
//#UC END# *54F994DE0329_4AE864B801C5_impl*
end;//LoadDateNew
{$IfEnd} // NOT Defined(Admin)

end.
