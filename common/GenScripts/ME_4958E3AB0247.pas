unit PrimSaveLoad_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoad_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimBaseSearchInterfaces
 , Search_Strange_Controls
 , PrimWorkJournalInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmItems
 {$IfEnd} // NOT Defined(NoVCM)
 , nsQuery
 , SimpleListInterfaces
 , vtPanel
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , bsTypes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(Monitorings)}
 , FoldersDomainInterfaces
 {$IfEnd} // NOT Defined(Monitorings)
 , SearchUnit
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimPrimListInterfaces
 , Classes
 , bsInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 , l3StringIDEx
 , nsLogEvent
;

type
 // ztParent

 _nsUserSettingsListener_Parent_ = TvcmContainerForm;
 {$Include nsUserSettingsListener.imp.pas}
 _vcmChromeLikeTabUpdater_Parent_ = _nsUserSettingsListener_;
 {$Include vcmChromeLikeTabUpdater.imp.pas}
 TPrimSaveLoadForm = {abstract} class(_vcmChromeLikeTabUpdater_, InsBaseSearchResultProcessor, InsWorkJournalListener)
  private
   f_LastQueryIndex: Integer;
   Filters: IucpFilters;
   f_pnHeader: TvtPanel;
    {* Поле для свойства pnHeader }
   f_lbHeader: TvtLabel;
    {* Поле для свойства lbHeader }
   f_pbHeader: TPaintBox;
    {* Поле для свойства pbHeader }
   f_ParentZone: TvtPanel;
    {* Поле для свойства ParentZone }
   f_QueryHistory: TvcmItems;
    {* Поле для свойства QueryHistory }
   f_SearchState: InsSearchTypeState;
    {* Поле для свойства SearchState }
  private
   procedure UpdateLabel(aSender: TObject);
   procedure pbHeaderPaint(aSender: TObject);
   procedure HeaderResize(aSender: TObject);
   function MakeCaption: IvcmCString;
  protected
   function pm_GetQueryHistory: TvcmItems;
   function pm_GetSearchState: InsSearchTypeState;
   function HideOpForPostingOrder(const aParams: IvcmTestParamsPrim): Boolean;
   {$If NOT Defined(Monitorings)}
   function MakeFilterInfo: InsFolderFilterInfo;
   {$IfEnd} // NOT Defined(Monitorings)
   function IsOkBtn: Boolean;
    {* проверяет является ли кнопка кнопкой "Ок" }
   procedure LoadQueryHistory;
   {$If NOT Defined(Monitorings)}
   procedure FillQueryAndSearch;
   {$IfEnd} // NOT Defined(Monitorings)
   procedure enResultopSaveExecute(const aParams: IvcmExecuteParamsPrim);
   class function IsDictionLike: Boolean; virtual;
    {* Определяет, что форма похожа на "словарь" }
   class function IsBaseSearchLike: Boolean; virtual;
   function IsNewQueryCard: Boolean;
   function ListType: TbsListType;
   procedure SearchResultEmpty(TryFullList: Boolean);
   procedure SearchResultExists;
   procedure AnotherSearchSuccessed;
   procedure JournalShrinked;
   procedure AnotherSearchCancelled;
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   procedure UserSettingsChanged; override;
    {* Изменились настройки пользователя }
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SaveOwnFormState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function IsAcceptable(aDataUpdate: Boolean): Boolean; override;
    {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function nsIsQueryTypeCompatibleToQueryFormType(aQueryType: TQueryType;
    aFormType: TvcmUserType): Boolean;
   procedure SaveToFolder; override;
    {* Сохранить в папки }
   procedure LoadFromFolder; override;
    {* Загрузить из папок }
   function Load: Boolean; override;
    {* Коллеги, кто может описать этот метод? }
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearAll; override;
   procedure SetList; override;
   function Add: Boolean; override;
   function Delete: Boolean; override;
   function GetList: IdeList; override;
   procedure ClearAll; override;
   function Refresh: Boolean; override;
   procedure ClearAll; override;
   procedure GetOldQuery; override;
   procedure SearchType; override;
   procedure LogicOr; override;
   procedure LogicAnd; override;
   procedure LogicNot; override;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure FiltersListOpen; override;
    {* Фильтры (вкладка) }
   function GetListType: TbsListType; override;
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property QueryHistory: TvcmItems
    read pm_GetQueryHistory;
   property SearchState: InsSearchTypeState
    read pm_GetSearchState;
  public
   property pnHeader: TvtPanel
    read f_pnHeader;
   property ParentZone: TvtPanel
    read f_ParentZone;
 end;//TPrimSaveLoadForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(Monitorings)}
 , nsFolders
 {$IfEnd} // NOT Defined(Monitorings)
 , FiltersUnit
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , BaseTypesUnit
 , nsQueryInterfaces
 , nsbQueryUtils
 , nsUtils
 {$If NOT Defined(Monitorings)}
 , nsFolderFilterInfo
 {$IfEnd} // NOT Defined(Monitorings)
 , l3Base
 , l3String
 , DataAdapter
 , Search_FormDefinitions_Controls
 , BaseTreeSupportUnit
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , vtF1InterfaceConst
 , nsConst
 , Graphics
 {$If NOT Defined(NoVCM)}
 , vcmBaseOperationsCollectionItem
 {$IfEnd} // NOT Defined(NoVCM)
 , StrUtils
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_FormDefinitions_Controls
 , nsQueryUtils
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , afwFacade
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , LoggingUnit
 , DynamicDocListUnit
 , bsUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ConsultingUnit
 , nsPostingsTreeSingle
;

type
 {$If NOT Defined(Monitorings)}
 TnsLoadQueryEvent = {final} class(TnsLogEvent)
  private
   class procedure Log(const aQuery: IQuery); virtual;
 end;//TnsLoadQueryEvent
 {$IfEnd} // NOT Defined(Monitorings)

 {$If NOT Defined(Monitorings)}
 TnsSendRequestToLegalAdviceEvent = class(TnsLogEvent)
  private
   class procedure Log;
 end;//TnsSendRequestToLegalAdviceEvent
 {$IfEnd} // NOT Defined(Monitorings)

 {$If NOT Defined(Monitorings)}
 TnsLoadQueryFromHistoryEvent = {final} class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsLoadQueryFromHistoryEvent
 {$IfEnd} // NOT Defined(Monitorings)

 TvtLabelHack = class(TvtLabel)
 end;//TvtLabelHack

const
 {* Локализуемые строки Local }
 str_WellDone: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'WellDone'; rValue : 'Ваша анкета ПРАЙМ успешно изменена!');
  {* 'Ваша анкета ПРАЙМ успешно изменена!' }
 str_QueryIsEmptyMessage: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'QueryIsEmptyMessage'; rValue : 'Пожалуйста, уточните запрос.');
  {* 'Пожалуйста, уточните запрос.' }
 str_FilterCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FilterCaption'; rValue : 'Фильтр');
  {* 'Фильтр' }

{$If NOT Defined(Monitorings)}
class procedure TnsLoadQueryEvent.Log(const aQuery: IQuery);
//#UC START# *4B138FE70017_4B138FD2022C_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B138FE70017_4B138FD2022C_var*
begin
//#UC START# *4B138FE70017_4B138FD2022C_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aQuery);
 GetLogger.AddEvent(LE_LOAD_QUERY, l_Data);
//#UC END# *4B138FE70017_4B138FD2022C_impl*
end;//TnsLoadQueryEvent.Log
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
class procedure TnsSendRequestToLegalAdviceEvent.Log;
//#UC START# *4C319C8D03C3_4C319C7A00C0_var*
//#UC END# *4C319C8D03C3_4C319C7A00C0_var*
begin
//#UC START# *4C319C8D03C3_4C319C7A00C0_impl*
 GetLogger.AddEvent(LE_SEND_REQUEST_TO_LEGAL_ADVISE, MakeParamsList);
//#UC END# *4C319C8D03C3_4C319C7A00C0_impl*
end;//TnsSendRequestToLegalAdviceEvent.Log
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
class procedure TnsLoadQueryFromHistoryEvent.Log;
//#UC START# *4C31A2B4020F_4C31A29B00A3_var*
//#UC END# *4C31A2B4020F_4C31A29B00A3_var*
begin
//#UC START# *4C31A2B4020F_4C31A29B00A3_impl*
 GetLogger.AddEvent(LE_LOAD_QUERY_FROM_HISTORY, MakeParamsList);
//#UC END# *4C31A2B4020F_4C31A29B00A3_impl*
end;//TnsLoadQueryFromHistoryEvent.Log
{$IfEnd} // NOT Defined(Monitorings)

{$Include nsUserSettingsListener.imp.pas}

type _Instance_R_ = TPrimSaveLoadForm;

{$Include vcmChromeLikeTabUpdater.imp.pas}

function TPrimSaveLoadForm.pm_GetQueryHistory: TvcmItems;
//#UC START# *4C319872011D_4958E3AB0247get_var*
//#UC END# *4C319872011D_4958E3AB0247get_var*
begin
//#UC START# *4C319872011D_4958E3AB0247get_impl*
 if f_QueryHistory = nil then
  f_QueryHistory := TvcmItems.Create;
 Result := f_QueryHistory;
//#UC END# *4C319872011D_4958E3AB0247get_impl*
end;//TPrimSaveLoadForm.pm_GetQueryHistory

function TPrimSaveLoadForm.pm_GetSearchState: InsSearchTypeState;
//#UC START# *4C31AA0F017A_4958E3AB0247get_var*
//#UC END# *4C31AA0F017A_4958E3AB0247get_var*
begin
//#UC START# *4C31AA0F017A_4958E3AB0247get_impl*
 if (f_SearchState = nil) then
  f_SearchState := TnsSearchTypeState.Make;
 Result := f_SearchState;
//#UC END# *4C31AA0F017A_4958E3AB0247get_impl*
end;//TPrimSaveLoadForm.pm_GetSearchState

function TPrimSaveLoadForm.HideOpForPostingOrder(const aParams: IvcmTestParamsPrim): Boolean;
//#UC START# *4C3180320290_4958E3AB0247_var*
//#UC END# *4C3180320290_4958E3AB0247_var*
begin
//#UC START# *4C3180320290_4958E3AB0247_impl*
 if not IsDictionLike AND (UserType = slqtPostingOrder) then
 // Т.к. операция попадает в главное меню, то по-другому ее убрать нельзя
 begin
  aParams.Op.Flag[vcm_ofVisible] := False;
  Result := True;
 end//UserType = slqtPostingOrder
 else
  Result := False;
//#UC END# *4C3180320290_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.HideOpForPostingOrder

{$If NOT Defined(Monitorings)}
function TPrimSaveLoadForm.MakeFilterInfo: InsFolderFilterInfo;
//#UC START# *4C3184C400C5_4958E3AB0247_var*
var
 l_FilterType: TnsFolderFilter;
//#UC END# *4C3184C400C5_4958E3AB0247_var*
begin
//#UC START# *4C3184C400C5_4958E3AB0247_impl*
 if IsDictionLike then
 begin
  Result := nil;
  Assert(false);
 end//IsDictionLike
 else
 begin
  case UserType of
   slqtFilters:
   begin
    //l_FilterType := ffFilter;
    l_FilterType := ffQuery;
    Assert(false);
   end;//slqtFilters
   else
    l_FilterType := ffQuery;
  end;//case UserType
  Result := TnsFolderFilterInfo.Make(l_FilterType,
                                     nsListTypeToFilterFor(ListType));
 end;//IsDictionLike
//#UC END# *4C3184C400C5_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.MakeFilterInfo
{$IfEnd} // NOT Defined(Monitorings)

function TPrimSaveLoadForm.IsOkBtn: Boolean;
 {* проверяет является ли кнопка кнопкой "Ок" }
//#UC START# *4C3193B60045_4958E3AB0247_var*
{$If defined(Monitorings) or defined(Admin)}
{$Else}
var
 l_UserType: TvcmUserType;
{$IfEnd} 
//#UC END# *4C3193B60045_4958E3AB0247_var*
begin
//#UC START# *4C3193B60045_4958E3AB0247_impl*
 {$If defined(Monitorings) or defined(Admin)}
 Result := false;
 {$Else}
 if IsDictionLike then
 begin
  Result := false;
  Assert(false);
 end//IsDictionLike
 else
 begin
  l_UserType := UserType;
  Result := not ((l_UserType = slqtFilters) or (l_UserType = slqtPostingOrder));
 end;//IsDictionLike
 {$IfEnd}
//#UC END# *4C3193B60045_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.IsOkBtn

procedure TPrimSaveLoadForm.LoadQueryHistory;
//#UC START# *4C3195370120_4958E3AB0247_var*
var
 l_HistoryType  : TQueryType;
 l_QueryHistory : IQueryList;
 I,
 l_HistoryCount : LongInt;
 l_Query        : IQuery;
 l_QueryName    : Il3CString;
 l_Item         : Tl3DataIntfString;
const
 cRecentlyOpenQueriesCount = 5;
//#UC END# *4C3195370120_4958E3AB0247_var*
begin
//#UC START# *4C3195370120_4958E3AB0247_impl*
 if IsDictionLike then
 begin
  Assert(false);
  Exit;
 end;//IsDictionLike
 QueryHistory.Clear;
 f_LastQueryIndex := 0;
 case UserType of
   slqtAttribute: l_HistoryType := QT_ATTRIBUTE;
   slqtKW,
   slqtOldKW : l_HistoryType := QT_KEYWORD;
   slqtPublishSource : l_HistoryType := QT_PUBLISHED_SOURCE;
   slqtLegislationReview : l_HistoryType := QT_REVIEW;
   slqtInpharmSearch : l_HistoryType := QT_PHARM_SEARCH;
  else
   exit; // История для фильтров не ведется
 end;
 l_HistoryCount := cRecentlyOpenQueriesCount;
 try
  defDataAdapter.NativeAdapter.MakeUserJournal.GetQueryHistory(l_HistoryType, l_HistoryCount,
   l_QueryHistory);
  if (l_QueryHistory <> nil) then
   try
    l_HistoryCount := l_QueryHistory.Count;
    if (l_HistoryCount > 0) then
     for I := 0 to Pred(l_HistoryCount) do
     begin
      l_QueryHistory.pm_GetItem(I, l_Query);
      try
       l_QueryName := nsGetQueryName(l_Query);
       if l3IsNil(l_QueryName) then
       begin
        l_QueryName := nsCreateQueryName(l_Query);
        l_Query.SetName(nsIStr(l_QueryName));
       end;//l3IsNil(l_QueryName)
       l_Item := Tl3DataIntfString.Make(l_QueryName, l_Query);
       try
        QueryHistory.Add(l_Item);
       finally
        FreeAndNil(l_Item);
       end;//try..finally
      finally
       l_Query := nil;
      end;//try..finally
     end;//for I
   finally
    l_QueryHistory := nil;
   end;//try..finally
 except
  // в истории запросов нет
  on ECanNotFindData do
 end;//try..except
//#UC END# *4C3195370120_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.LoadQueryHistory

{$If NOT Defined(Monitorings)}
procedure TPrimSaveLoadForm.FillQueryAndSearch;
//#UC START# *4C3195EA025F_4958E3AB0247_var*

 procedure lp_Search(const aQuery   : IQuery;
                     const aFilters : IFiltersFromQuery = nil;
                     const aList    : IDynList = nil);

   function GetPermanentFilters(aListType: TbsListType): IFiltersFromQuery;
   var
    l_Filters: IFiltersFromQuery;
    I: Integer;
    l_Filter: IFilterFromQuery;
   begin
    Result := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
    case aListType of
     bs_ltDocument: DefDataAdapter.NativeAdapter.MakeFiltersManager.GetLegalFilters(l_Filters);
     bs_ltDrug: DefDataAdapter.NativeAdapter.MakeFiltersManager.GetPharmFilters(l_Filters);
    end;
    for I := 0 to l_Filters.Count - 1 do
    begin
     l_Filters.pm_GetItem(I, l_Filter);
     if l_Filter.GetPermanent then
      Result.Add(l_Filter);
    end;
   end;

 var
  l_Filters: IFiltersFromQuery;
 begin
  {$If not (defined(Monitorings) or defined(Admin))}
  // Для Обзора изменений законодательства фильтры не применяются
  // http://mdp.garant.ru/pages/viewpage.action?pageId=363584635
  if (aQuery.GetType <> QT_REVIEW) then
  begin
   if aFilters <> nil then
    l_Filters := aFilters
   else
    l_Filters := GetPermanentFilters(ListType);//defDataAdapter.FiltersContainer(ListType).PermanentFilters;
  end;
  {$ELSE Monitorings}
  l_Filters := aFilters;
  {$IfEnd not (defined(Monitorings) or defined(Admin))}
  nsSearch(aQuery,
           l_Filters,
           bsBuildFullList(aList),
           Self);
 end;//lp_Search

var
 l_ListData     : IdeList;
 l_List         : IDynList;
 l_FiltersIntf  : IFiltersFromQuery;
 l_QueryType    : TlgQueryType;
 l_QueryParams  : TnsQueryInfo;
//#UC END# *4C3195EA025F_4958E3AB0247_var*
begin
//#UC START# *4C3195EA025F_4958E3AB0247_impl*
 if IsDictionLike then
 begin
  Assert(false);
  Exit;
 end;//IsDictionLike
 // Получаем заполненный Query из КЗ
 if (Aggregate <> nil) then
 begin
  if UserType in [slqtPublishSource, slqtOldKW, slqtKW] then
   Op_AttributeTree_AddNodeIfEmpty.Call(Aggregate);

  l_QueryParams := Op_SearchParameters_GetQuery.Call(Aggregate);
  if not l_QueryParams.rHasErrors then
  begin
   l_QueryType := AdapterQueryToBusinessQuery(l_QueryParams.rQuery.GetType);
   // Для Обзора законодательства запрещаем поиск по пустой КЗ
   if (l_QueryType = lg_qtLegislationReview) then
   begin
    if Op_SearchParameters_IsQueryEmpty.Call(Aggregate) then
    begin
     Say(inf_QueryIsEmptyCantBuild);
     exit;
    end;//Op_SearchParameters_IsQueryEmpty.Call(Aggregate)
   end;//l_QueryType = lg_qtLegislationReview

   if not DefDataAdapter.IsInternal then
    if (l_QueryType = lg_qtAttribute) and Op_SearchParameters_IsQueryEmpty.Call(Aggregate) then
    begin
     vcmAsk(str_QueryIsEmptyMessage, []);
     Exit;
    end;

   if (l_QueryType = lg_qtSendConsultation) then
   begin
    if not defDataAdapter.ConsultationManager.CheckConsultingAvailable then
    begin
     Say(war_NoSubscription, [defDataAdapter.GetDealerInfo]);
     op_SearchParameter_QueryNotSaved.Call(Aggregate);
    end
    else
    begin
     try
      {$If not Defined(Admin) and not Defined(Monitorings)}
      TnsSendRequestToLegalAdviceEvent.Log;
      {$IfEnd}
      l_QueryParams.rQuery.SendQuery;
      Say(inf_ConsultationSuccessSend);
      op_SearchParameters_ClearQuery.Call(Aggregate);
     except
      on ENoConnection do
       begin
        Say(war_NoConnectionOnSend, [defDataAdapter.GetDealerInfo]);
        op_SearchParameter_QueryNotSaved.Call(Aggregate);
       end;
      on ENoSubscription do
       begin
        Say(war_NoSubscription, [defDataAdapter.GetDealerInfo]);
        op_SearchParameter_QueryNotSaved.Call(Aggregate);
       end;
     end;
    end;
   end//if (l_QueryType = lg_qtSendConsultation) then
   else
   begin
    l_ListData := Op_Query_GetList.Call(Self.As_IvcmEntityForm);
    try
     if (l_ListData <> nil) then
      l_List := l_ListData.List
     else
      l_List := nil;
    finally
     l_ListData := nil;
    end;//try..finally
    try
     if not l_QueryParams.rAskFilters then
     begin
      if (l_QueryParams.rFilter <> nil) then
      begin
       l_FiltersIntf := defDataAdapter.NativeAdapter.MakeFiltersFromQuery;
       l_FiltersIntf.Add(l_QueryParams.rFilter);
       lp_Search(l_QueryParams.rQuery,
                 l_FiltersIntf,
                 l_List);
      end//l_QueryParams.rNode <> nil
      else
       lp_Search(l_QueryParams.rQuery,
                 nil,
                 l_List);
     end//not l_QueryParams.rAskFilters
     else
      lp_Search(l_QueryParams.rQuery,
                op_Filters_GetSelected.Call(Aggregate),
                l_List);
    finally
     l_List := nil;
    end;//try..finally
   end;//l_QueryType = lg_qtSendConsultation
  end;//not l_QueryParams.rHasErrors
 end;//Aggregate <> nil
//#UC END# *4C3195EA025F_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.FillQueryAndSearch
{$IfEnd} // NOT Defined(Monitorings)

procedure TPrimSaveLoadForm.enResultopSaveExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C31965803C6_4958E3AB0247_var*

{$IFNDEF Monitorings}
 procedure SaveQuery(const aQuery   : IQuery;
                     aIsFilterQuery : Boolean;
                     SaveAs         : Boolean);
 var
  l_Result: Boolean;
 begin//
  if not aQuery.IsFilterQuery AND not aIsFilterQuery then
  begin
   l_Result := false;
   Assert(false);
   // - интересно - как же и куда тогда фильтры сохранять
(*   l_Result := TdmStdRes.SaveOpen(Self.As_IvcmEntityForm,
                         MakeFilterInfo,
                         fetFilter,
                         aQuery,
                         SaveAs) = mrOk*)
  end                       
  else
   l_Result := TdmStdRes.CreateFilter(aQuery) = mrOk;
  if l_Result AND (ZoneType = vcm_ztManualModal) then
   ModalResult := mrOk;
 end;//SaveQuery

var
 l_Params: TnsQueryInfo;
 l_CurEntity: IEntityBase;
 l_IsSave: Boolean;
 l_Desision: Boolean;
 l_EntityStorage: IEntityStorage;
{$ENDIF Monitorings}
//#UC END# *4C31965803C6_4958E3AB0247_var*
begin
//#UC START# *4C31965803C6_4958E3AB0247_impl*
 if UserType = slqtPostingOrder then
 begin
  if TnsPostingsTreeSingle.Instance.SaveOrCreateQuery then
  begin
   op_SearchParameter_QuerySaved.Call(Aggregate);
   {$IFNDEF Monitorings}
   defDataAdapter.PrimeManager.SaveAndSendToOnlineServer;
   vcmAsk(str_WellDone, []);
   {$ENDIF Monitorings}
  end;
 end
{$IFNDEF Monitorings}
 else
 // Получаем заполненный Query из КЗ
 if (Aggregate <> nil) then
 begin
  // Для Заказа рассылки запрещаем сохранение пустой КЗ
  l_Params := Op_SearchParameters_GetQuery.Call(Aggregate);
  if not l_Params.rHasErrors then
  begin
   if Supports(l_Params.rQuery, IEntityBase, l_CurEntity) then
    try
     if l_CurEntity.GetIsSaved then
     begin
      // Сообщение для фильтра
      if l_Params.rQuery.IsFilterQuery OR l_Params.rIsQueryForFilter then
       l_IsSave := Ask(qr_FilterWasSaved, [nsGetQueryName(l_Params.rQuery)])
      // Сообщение для запроса
      else
       l_IsSave := Ask(qr_QueryWasSaved);
      // Пользователь захотел перезаписать
      if l_IsSave then
      begin
       try
        l_CurEntity.SaveTo(nil, l_EntityStorage);
       except
        on EAccessDenied do
        begin
         l_Desision := Ask(qr_SaveAsReadOnlyFilter);
         if l_Desision then
          SaveQuery(l_Params.rQuery, l_Params.rIsQueryForFilter, True);
         Exit;
        end;//on EAccessDenied
        on ECanNotSave do
        begin
         Say(err_CannotSave, [nsGetQueryName(l_Params.rQuery)]);
         Exit;
        end;//on ECanNotSave
        on ENotSaved do
        begin
         Say(err_NotSaved);
         Exit;
        end;//on ENotSaved
       end;//try..except
       if (ZoneType = vcm_ztManualModal) then
        ModalResult := mrOk;
      end//l_IsSave
      else
        SaveQuery(l_Params.rQuery, l_Params.rIsQueryForFilter, True);
     end//l_CurEntity.GetIsSaved
     else
      // Сохраняем Query в папку
      SaveQuery(l_Params.rQuery, l_Params.rIsQueryForFilter, false);
    finally
     l_CurEntity := nil;
    end//try..finally
  end;//not l_Params.rHasErrors
 end//Aggregate <> nil
{$ENDIF Monitorings}
 ;
//#UC END# *4C31965803C6_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.enResultopSaveExecute

procedure TPrimSaveLoadForm.UpdateLabel(aSender: TObject);
//#UC START# *4D7131F40095_4958E3AB0247_var*

 function NotEmptySuffix(const aSt: String; const aSep : String): String;
 begin//NotEmptySuffix
  Result := Trim(ev_psSuffix(aSt, aSep));
  if (Result = '') then
   Result := aSt;
 end;//NotEmptySuffix

var
 l_Str: IvcmCString;
//#UC END# *4D7131F40095_4958E3AB0247_var*
begin
//#UC START# *4D7131F40095_4958E3AB0247_impl*
 l_Str := MakeCaption;
 (aSender As TAction).Caption := l3Str(l_Str);
 (aSender As TAction).Enabled := true;
 if (pnHeader.Width - lbHeader.Left < lbHeader.Width) then
  TvtLabelHack(lbHeader).AdjustBounds;
 {$If not defined(Admin) AND not defined(Monitorings)}
 UpdateChromeLikeTab;
 UpdateChromeLikeTabCaption(l_Str);
 {$IfEnd}
//#UC END# *4D7131F40095_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.UpdateLabel

procedure TPrimSaveLoadForm.pbHeaderPaint(aSender: TObject);
//#UC START# *4D722A0903AC_4958E3AB0247_var*
//#UC END# *4D722A0903AC_4958E3AB0247_var*
begin
//#UC START# *4D722A0903AC_4958E3AB0247_impl*
 if (CurUserType <> nil) AND (CurUserType.ImageIndex >= 0) then
  with (aSender as TPaintBox) do
   dmStdRes.LargeImageList.Draw(Canvas,
                                Width - c_LargeSizeIcon,
                                (Height - c_LargeSizeIcon) div 2 + 2,
                                CurUserType.ImageIndex);
//#UC END# *4D722A0903AC_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.pbHeaderPaint

procedure TPrimSaveLoadForm.HeaderResize(aSender: TObject);
//#UC START# *4D7FA1E40348_4958E3AB0247_var*
//#UC END# *4D7FA1E40348_4958E3AB0247_var*
begin
//#UC START# *4D7FA1E40348_4958E3AB0247_impl*
 TvtLabelHack(lbHeader).AdjustBounds;
//#UC END# *4D7FA1E40348_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.HeaderResize

class function TPrimSaveLoadForm.IsDictionLike: Boolean;
 {* Определяет, что форма похожа на "словарь" }
//#UC START# *4F5DB2320323_4958E3AB0247_var*
//#UC END# *4F5DB2320323_4958E3AB0247_var*
begin
//#UC START# *4F5DB2320323_4958E3AB0247_impl*
 Result := false;
//#UC END# *4F5DB2320323_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.IsDictionLike

class function TPrimSaveLoadForm.nsIsQueryTypeCompatibleToQueryFormType(aQueryType: TQueryType;
 aFormType: TvcmUserType): Boolean;
//#UC START# *4F5E079B0368_4958E3AB0247_var*
//#UC END# *4F5E079B0368_4958E3AB0247_var*
begin
//#UC START# *4F5E079B0368_4958E3AB0247_impl*
 if IsDictionLike then
 begin
  Result := false;
  Assert(false);
  Exit;
 end;//IsDictionLike
 case aFormType of
  slqtAttribute:
   Result := aQueryType in [QT_ATTRIBUTE
                            {,
                            QT_OLD_ATTRIBUTE,
                            QT_OLD_FILTER}];
  slqtKW:
   Result := aQueryType = QT_KEYWORD;
  slqtOldKW:
   Result := aQueryType = QT_KEYWORD;
  slqtPublishSource:
   Result := aQueryType = QT_PUBLISHED_SOURCE;
(*  slqtFilters:
   Result := aQueryType = QT_OLD_FILTER;*)
  slqtLegislationReview:
   Result := aQueryType = QT_REVIEW;
  slqtPostingOrder:
   Result := aQueryType = QT_MAIL_LIST;
  slqtInpharmSearch:
   Result := aQueryType = QT_PHARM_SEARCH;
  else
   Result := False;
 end;//case aFormType
//#UC END# *4F5E079B0368_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.nsIsQueryTypeCompatibleToQueryFormType

class function TPrimSaveLoadForm.IsBaseSearchLike: Boolean;
//#UC START# *502289FB008D_4958E3AB0247_var*
//#UC END# *502289FB008D_4958E3AB0247_var*
begin
//#UC START# *502289FB008D_4958E3AB0247_impl*
 Result := false;
//#UC END# *502289FB008D_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.IsBaseSearchLike

function TPrimSaveLoadForm.MakeCaption: IvcmCString;
//#UC START# *53F32421018A_4958E3AB0247_var*

 function NotEmptySuffix(const aSt: String; const aSep : String): String;
 begin//NotEmptySuffix
  Result := Trim(ev_psSuffix(aSt, aSep));
  if (Result = '') then
   Result := aSt;
 end;//NotEmptySuffix

const
 cMagic1 = ' - ';
 cMagic2 = ' : ';
var
 l_S : String;
//#UC END# *53F32421018A_4958E3AB0247_var*
begin
//#UC START# *53F32421018A_4958E3AB0247_impl*
 if IsDictionLike then
  l_S := CurUserType.Caption
 else
 if (UserType = slqtFilters) then
  l_S := str_FilterCaption.AsStr
 else
 begin
  l_S := l3Str(NativeMainForm.AsForm.Caption);
  if ANSIEndsStr(cMagic1, l_S) then
   l_S := ''
  else
  begin
   l_S := NotEmptySuffix(l_S, cMagic1);
   l_S := NotEmptySuffix(l_S, cMagic2);
  end;//ANSIEndsStr(cMagic1, l_S)
 end;//IsDictionLike
 Result := l3CStr(l_S);
//#UC END# *53F32421018A_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.MakeCaption

function TPrimSaveLoadForm.IsNewQueryCard: Boolean;
//#UC START# *4AE89F6E02E3_4958E3AB0247_var*
//#UC END# *4AE89F6E02E3_4958E3AB0247_var*
begin
//#UC START# *4AE89F6E02E3_4958E3AB0247_impl*
 Result := False;
 if IsDictionLike then
 begin
  Assert(false);
  Exit;
 end;//IsDictionLike
 case UserType of
  slqtAttribute,
  slqtLegislationReview,
  slqtPostingOrder,
  slqtConsult,
  slqtInpharmSearch :
   Result := True;
  slqtFilters:
   Result := HasForm(fm_enQueryCard.rFormID);
 end;//case UserType of
//#UC END# *4AE89F6E02E3_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.IsNewQueryCard

function TPrimSaveLoadForm.ListType: TbsListType;
//#UC START# *4AE9C89601E6_4958E3AB0247_var*
//#UC END# *4AE9C89601E6_4958E3AB0247_var*
begin
//#UC START# *4AE9C89601E6_4958E3AB0247_impl*
 if IsDictionLike then
 begin
  Result := bs_ltNone;
  Assert(false);
  Exit;
 end;//IsDictionLike
 if UserType = slqtInpharmSearch then
  Result := bs_ltDrug
 else
  Result := bs_ltDocument;
//#UC END# *4AE9C89601E6_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.ListType

procedure TPrimSaveLoadForm.SearchResultEmpty(TryFullList: Boolean);
//#UC START# *496B4FAA02FA_4958E3AB0247_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *496B4FAA02FA_4958E3AB0247_var*
begin
//#UC START# *496B4FAA02FA_4958E3AB0247_impl*
 if Supports(NativeMainForm, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.SearchResultEmpty(TryFullList);
//#UC END# *496B4FAA02FA_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.SearchResultEmpty

procedure TPrimSaveLoadForm.SearchResultExists;
//#UC START# *496B4FC70065_4958E3AB0247_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *496B4FC70065_4958E3AB0247_var*
begin
//#UC START# *496B4FC70065_4958E3AB0247_impl*
 op_SearchParameter_ClearMistakes.Call(Aggregate);
 if Supports(NativeMainForm, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.SearchResultExists;
//#UC END# *496B4FC70065_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.SearchResultExists

procedure TPrimSaveLoadForm.AnotherSearchSuccessed;
//#UC START# *496B4FD20320_4958E3AB0247_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *496B4FD20320_4958E3AB0247_var*
begin
//#UC START# *496B4FD20320_4958E3AB0247_impl*
 if Supports(NativeMainForm, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.AnotherSearchSuccessed;
//#UC END# *496B4FD20320_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.AnotherSearchSuccessed

procedure TPrimSaveLoadForm.SaveToFolder;
 {* Сохранить в папки }
//#UC START# *49885D540232_4958E3AB0247_var*
//#UC END# *49885D540232_4958E3AB0247_var*
begin
//#UC START# *49885D540232_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D540232_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.SaveToFolder

procedure TPrimSaveLoadForm.LoadFromFolder;
 {* Загрузить из папок }
//#UC START# *49885D59018D_4958E3AB0247_var*
//#UC END# *49885D59018D_4958E3AB0247_var*
begin
//#UC START# *49885D59018D_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D59018D_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.LoadFromFolder

function TPrimSaveLoadForm.Load: Boolean;
 {* Коллеги, кто может описать этот метод? }
//#UC START# *49895A2102E8_4958E3AB0247_var*
//#UC END# *49895A2102E8_4958E3AB0247_var*
begin
//#UC START# *49895A2102E8_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *49895A2102E8_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Load

procedure TPrimSaveLoadForm.JournalShrinked;
//#UC START# *4A83AA610299_4958E3AB0247_var*
//#UC END# *4A83AA610299_4958E3AB0247_var*
begin
//#UC START# *4A83AA610299_4958E3AB0247_impl*
 if not IsDictionLike then
  LoadQueryHistory;
//#UC END# *4A83AA610299_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.JournalShrinked

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadForm.OkExt;
 {* OK }
//#UC START# *4A8AD47D0357_4958E3AB0247_var*
//#UC END# *4A8AD47D0357_4958E3AB0247_var*
begin
//#UC START# *4A8AD47D0357_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD47D0357_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadForm.Cancel;
 {* Отмена }
//#UC START# *4AC5D61E0284_4958E3AB0247_var*
//#UC END# *4AC5D61E0284_4958E3AB0247_var*
begin
//#UC START# *4AC5D61E0284_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimSaveLoadForm.ClearAll;
//#UC START# *4AE8A0E10254_4958E3AB0247_var*
//#UC END# *4AE8A0E10254_4958E3AB0247_var*
begin
//#UC START# *4AE8A0E10254_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8A0E10254_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.ClearAll

procedure TPrimSaveLoadForm.SetList;
//#UC START# *4AE96F6C0191_4958E3AB0247_var*
//#UC END# *4AE96F6C0191_4958E3AB0247_var*
begin
//#UC START# *4AE96F6C0191_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE96F6C0191_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.SetList

function TPrimSaveLoadForm.Add: Boolean;
//#UC START# *4AEF0BF70306_4958E3AB0247_var*
//#UC END# *4AEF0BF70306_4958E3AB0247_var*
begin
//#UC START# *4AEF0BF70306_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF0BF70306_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Add

function TPrimSaveLoadForm.Delete: Boolean;
//#UC START# *4AEF0D1A01C3_4958E3AB0247_var*
//#UC END# *4AEF0D1A01C3_4958E3AB0247_var*
begin
//#UC START# *4AEF0D1A01C3_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF0D1A01C3_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Delete

function TPrimSaveLoadForm.GetList: IdeList;
//#UC START# *4AF2AA2100CF_4958E3AB0247_var*
//#UC END# *4AF2AA2100CF_4958E3AB0247_var*
begin
//#UC START# *4AF2AA2100CF_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF2AA2100CF_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.GetList

procedure TPrimSaveLoadForm.ClearAll;
//#UC START# *4AF80DB80383_4958E3AB0247_var*
//#UC END# *4AF80DB80383_4958E3AB0247_var*
begin
//#UC START# *4AF80DB80383_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF80DB80383_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.ClearAll

function TPrimSaveLoadForm.Refresh: Boolean;
//#UC START# *4AF810230307_4958E3AB0247_var*
//#UC END# *4AF810230307_4958E3AB0247_var*
begin
//#UC START# *4AF810230307_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF810230307_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Refresh

procedure TPrimSaveLoadForm.AnotherSearchCancelled;
//#UC START# *4C04AFC8015D_4958E3AB0247_var*
var
 l_Processor: InsBaseSearchResultProcessor;
//#UC END# *4C04AFC8015D_4958E3AB0247_var*
begin
//#UC START# *4C04AFC8015D_4958E3AB0247_impl*
 if Supports(NativeMainForm, InsBaseSearchResultProcessor, l_Processor) then
  l_Processor.AnotherSearchCancelled;
//#UC END# *4C04AFC8015D_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.AnotherSearchCancelled

procedure TPrimSaveLoadForm.ClearAll;
//#UC START# *4C2DFEE000BA_4958E3AB0247_var*
//#UC END# *4C2DFEE000BA_4958E3AB0247_var*
begin
//#UC START# *4C2DFEE000BA_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2DFEE000BA_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.ClearAll

procedure TPrimSaveLoadForm.GetOldQuery;
//#UC START# *4C31A4EC023F_4958E3AB0247_var*
//#UC END# *4C31A4EC023F_4958E3AB0247_var*
begin
//#UC START# *4C31A4EC023F_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31A4EC023F_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.GetOldQuery

procedure TPrimSaveLoadForm.SearchType;
//#UC START# *4C31A68800FA_4958E3AB0247_var*
//#UC END# *4C31A68800FA_4958E3AB0247_var*
begin
//#UC START# *4C31A68800FA_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31A68800FA_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.SearchType

procedure TPrimSaveLoadForm.LogicOr;
//#UC START# *4C31B48D03BB_4958E3AB0247_var*
//#UC END# *4C31B48D03BB_4958E3AB0247_var*
begin
//#UC START# *4C31B48D03BB_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31B48D03BB_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.LogicOr

procedure TPrimSaveLoadForm.LogicAnd;
//#UC START# *4C31B4990225_4958E3AB0247_var*
//#UC END# *4C31B4990225_4958E3AB0247_var*
begin
//#UC START# *4C31B4990225_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31B4990225_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.LogicAnd

procedure TPrimSaveLoadForm.LogicNot;
//#UC START# *4C31B4A90088_4958E3AB0247_var*
//#UC END# *4C31B4A90088_4958E3AB0247_var*
begin
//#UC START# *4C31B4A90088_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C31B4A90088_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.LogicNot

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4958E3AB0247_var*
//#UC END# *4C762C910358_4958E3AB0247_var*
begin
//#UC START# *4C762C910358_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadForm.OkExt;
 {* OK }
//#UC START# *4C762D9B0224_4958E3AB0247_var*
//#UC END# *4C762D9B0224_4958E3AB0247_var*
begin
//#UC START# *4C762D9B0224_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762D9B0224_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimSaveLoadForm.FiltersListOpen;
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_4958E3AB0247_var*
//#UC END# *4C81191003E5_4958E3AB0247_var*
begin
//#UC START# *4C81191003E5_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C81191003E5_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.FiltersListOpen

function TPrimSaveLoadForm.GetListType: TbsListType;
//#UC START# *4F99403A00A5_4958E3AB0247_var*
//#UC END# *4F99403A00A5_4958E3AB0247_var*
begin
//#UC START# *4F99403A00A5_4958E3AB0247_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F99403A00A5_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.GetListType

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimSaveLoadForm.DoGetFormSetImageIndex: Integer;
//#UC START# *53B649F600A3_4958E3AB0247_var*
var
 l_TabIconType: TnsTabIconType;
//#UC END# *53B649F600A3_4958E3AB0247_var*
begin
//#UC START# *53B649F600A3_4958E3AB0247_impl*
 case UserType of
  slqtAttribute:
   l_TabIconType := titAttributeSearch;
  slqtKW, slqtOldKW:
   l_TabIconType := titSituationSearch;
  slqtPublishSource:
   l_TabIconType := titPublishSourceSearch;
  slqtLegislationReview:
   l_TabIconType := titLegislationReviewSearch;
  slqtInpharmSearch:
   l_TabIconType := titDrugSearch;
  slqtConsult:
   l_TabIconType := titLawSupportOnline;
  else
   l_TabIconType := titMain;
 end;
 Result := nsTabIconIndex(l_TabIconType);
//#UC END# *53B649F600A3_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TPrimSaveLoadForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4958E3AB0247_var*
//#UC END# *479731C50290_4958E3AB0247_var*
begin
//#UC START# *479731C50290_4958E3AB0247_impl*
 {$If not Defined(Admin) and not Defined(Monitorings)}
 TdmStdRes.MakeWorkJournal.UnRegisterListener(Self);
 {$IfEnd}
 FreeAndNil(f_QueryHistory);
 f_SearchState := nil;
 f_LastQueryIndex := 0;
 inherited;
//#UC END# *479731C50290_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Cleanup

constructor TPrimSaveLoadForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4958E3AB0247_var*
//#UC END# *47D1602000C6_4958E3AB0247_var*
begin
//#UC START# *47D1602000C6_4958E3AB0247_impl*
 inherited;
{$If defined(Monitorings) or defined(Admin)}
  with TvcmBaseOperationsCollectionItem(dmStdRes.MenuManager.GetItemByName('enFilters')
   .Operations.FindItemByName('opFiltersListOpen')) do
    Options := Options - [vcm_ooShowInMainMenu];
  with dmStdRes.MenuManager.GetItemByName('enFile') do
  begin
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opSaveToFolder')) do
    Options := Options - [vcm_ooShowInMainMenu];
   with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opLoadFromFolder')) do
    Options := Options - [vcm_ooShowInMainMenu];
  end;
{$IfEnd defined(Monitorings) or defined(Admin)}
//#UC END# *47D1602000C6_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.Create

procedure TPrimSaveLoadForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4958E3AB0247_var*
//#UC END# *47EA4E9002C6_4958E3AB0247_var*
begin
//#UC START# *47EA4E9002C6_4958E3AB0247_impl*
 if not IsAcceptable(True) then
 begin
  if vcmDispatcher.History.CanBack then
   vcmDispatcher.History.Back(True);
 end;
//#UC END# *47EA4E9002C6_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.FinishDataUpdate

procedure TPrimSaveLoadForm.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_4958E3AB0247_var*
//#UC END# *47EA8B9601FE_4958E3AB0247_var*
begin
//#UC START# *47EA8B9601FE_4958E3AB0247_impl*
 inherited;
 UserSettingsChanged;
//#UC END# *47EA8B9601FE_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.SettingsReplaceFinish

procedure TPrimSaveLoadForm.UserSettingsChanged;
 {* Изменились настройки пользователя }
//#UC START# *4958BE910345_4958E3AB0247_var*

 function lp_NeedExchangeForm: Boolean;
 begin
  Result := (UserType <> slqtPublishSource) and
            ((l3Same(afw.Settings.LoadString(pi_Search_SituationType,
                               dv_Search_SituationType),
                               li_NewSearch_SituationType)) and
             (UserType = slqtOldKW )) or
            ((l3Same(afw.Settings.LoadString(pi_Search_SituationType,
                               dv_Search_SituationType),
                               li_OldSearch_SituationType)) and
             (UserType = slqtKW ))
 end;//lp_NeedExchangeForm

 function lp_Query: IQuery;
 var
  l_QueryParams: TnsQueryInfo;
 begin
  l_QueryParams := Op_SearchParameters_GetQuery.Call(Aggregate);
  if not l_QueryParams.rHasErrors then
   Result := l_QueryParams.rQuery
  else
   Result := nil;
 end;//lp_Query

//#UC END# *4958BE910345_4958E3AB0247_var*
begin
//#UC START# *4958BE910345_4958E3AB0247_impl*
 inherited;
 if not IsDictionLike AND not IsBaseSearchLike then
  if lp_NeedExchangeForm then
  begin
   // Изменяем вид КЗ
   case UserType of
    slqtAttribute:
     TdmStdRes.OpenQuery(lg_qtAttribute, lp_Query, nil);
    slqtKW, slqtOldKW:
     TdmStdRes.OpenQuery(lg_qtKeyWord, lp_Query, nil);
   end;//case UserType
  end;//not (UserType = slqtPublishSource)..
//#UC END# *4958BE910345_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.UserSettingsChanged

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4958E3AB0247_var*
//#UC END# *49803F5503AA_4958E3AB0247_var*
begin
//#UC START# *49803F5503AA_4958E3AB0247_impl*
 inherited;
 {$If not Defined(Admin) and not Defined(Monitorings)}
 TdmStdRes.MakeWorkJournal.RegisterListener(Self);
 {$IfEnd}
 if not IsDictionLike then
 begin
  LoadQueryHistory;
  if (UserType = slqtFilters) then
   CCaption := str_FilterCaption.AsCStr;
 end;//not IsDictionLike
//#UC END# *49803F5503AA_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimSaveLoadForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_4958E3AB0247_var*
//#UC END# *49807428008C_4958E3AB0247_var*
begin
//#UC START# *49807428008C_4958E3AB0247_impl*
 Result := true;
 if (aStateType = vcm_stContent) then
  if not Supports(aState, InsSearchTypeState, f_SearchState) then
   Assert(False);
//#UC END# *49807428008C_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.DoLoadState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4958E3AB0247_var*
//#UC END# *4A8E8F2E0195_4958E3AB0247_var*
begin
//#UC START# *4A8E8F2E0195_4958E3AB0247_impl*
 inherited;
 pnHeader.Align := alTop;
 pnHeader.Height := 60;
 pnHeader.BevelOuter := bvNone;
 pnHeader.TabOrder := 1;
 pnHeader.OnResize := HeaderResize;
 pnHeader.PopupMenu := TPopupMenu.Create(pnHeader);
 // - делаем фиктивное пустое меню
 // http://mdp.garant.ru/pages/viewpage.action?pageId=278844700&focusedCommentId=294585427&#comment-294585427
 NotifyUserTypeSet;
 lbHeader.EndEllipsis := true;
 lbHeader.Font.Name := 'Arial';
 lbHeader.Font.Size := 30;
 lbHeader.Font.Style := [fsBold];
 lbHeader.Font.Color := cGarant2011GradientEndColor;
 lbHeader.Action := TAction.Create(lbHeader);
 lbHeader.Action.OnUpdate := UpdateLabel;
 // При размере шрифт 150% высота lbHeader может быть больше, чем высота
 // pnHeader, тогда lbHeader.Top уходит вверх за границы панели
 // http://mdp.garant.ru/pages/viewpage.action?pageId=449678181
 if ((lbHeader.Height + 6) > pnHeader.Height) then
  pnHeader.Height := pnHeader.Height + ((lbHeader.Height + 6) - pnHeader.Height);
 lbHeader.Top := (pnHeader.Height - lbHeader.Height) - 6;
 lbHeader.PopupMenu := pnHeader.PopupMenu;
 // - делаем фиктивное пустое меню
 // http://mdp.garant.ru/pages/viewpage.action?pageId=278844700&focusedCommentId=294585427&#comment-294585427
 pbHeader.Left := c_ControlBorder * 4;
 pbHeader.Width := 34;
 pbHeader.Height := 34;
(* pbHeader.Width := 48;
 pbHeader.Height := 48;*)
 pbHeader.Top := (pnHeader.Height -  pbHeader.Height) div 2 + 5;
 pbHeader.OnPaint := pbHeaderPaint;
 pbHeader.PopupMenu := pnHeader.PopupMenu;
 // - делаем фиктивное пустое меню
 // http://mdp.garant.ru/pages/viewpage.action?pageId=278844700&focusedCommentId=294585427&#comment-294585427
 lbHeader.Left := pbHeader.Left + pbHeader.Width + c_ControlBorder * 3;
//#UC END# *4A8E8F2E0195_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimSaveLoadForm.SaveOwnFormState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
//#UC START# *4B4F49900003_4958E3AB0247_var*
//#UC END# *4B4F49900003_4958E3AB0247_var*
begin
//#UC START# *4B4F49900003_4958E3AB0247_impl*
 Result := true;
 if (aStateType = vcm_stContent) then
  theState := SearchState as IvcmBase;
//#UC END# *4B4F49900003_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.SaveOwnFormState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSaveLoadForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4958E3AB0247_var*
//#UC END# *4D78E2BB0211_4958E3AB0247_var*
begin
//#UC START# *4D78E2BB0211_4958E3AB0247_impl*
 inherited;
 if IsDictionLike then
 begin
  ParentZone.Align := alClient;
  ParentZone.Color := clWhite;
  pnHeader.Color := clWhite;
  pnHeader.BevelOuter := bvSpace;
 end//IsDictionLike
 else
 begin
  ParentZone.Align := alClient;
  ParentZone.Color := cGarant2011BackColor;
  pnHeader.Color := cGarant2011BackColor;
  pnHeader.BevelOuter := bvNone;
 end;//IsDictionLike
//#UC END# *4D78E2BB0211_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.NotifyUserTypeSet
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimSaveLoadForm.ClearFields;
begin
 f_SearchState := nil;
 inherited;
end;//TPrimSaveLoadForm.ClearFields

{$If NOT Defined(NoVCM)}
function TPrimSaveLoadForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4958E3AB0247_var*
//#UC END# *53F1C6EF02C9_4958E3AB0247_var*
begin
//#UC START# *53F1C6EF02C9_4958E3AB0247_impl*
 Result := MakeCaption;
//#UC END# *53F1C6EF02C9_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimSaveLoadForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
 {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
//#UC START# *55127A5401DE_4958E3AB0247_var*
//#UC END# *55127A5401DE_4958E3AB0247_var*
begin
//#UC START# *55127A5401DE_4958E3AB0247_impl*
 case UserType of
  slqtPostingOrder:
   if aDataUpdate then
    Result := defDataAdapter.IsInpharmExists
   else
    Result := defDataAdapter.IsInpharmExists and not Assigned(TnsPostingsTreeSingle.Instance.MgrSearch);
  slqtPublishSource: Result := defDataAdapter.IsExists_PublishSourceTag;
  slqtInpharmSearch: Result := defDataAdapter.IsInpharmExists;
 else
  Result := True;
 end;
//#UC END# *55127A5401DE_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.IsAcceptable
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_WellDone.Init;
!!! Lost Message ini !!!
 {* Инициализация str_WellDone }
 str_QueryIsEmptyMessage.Init;
!!! Lost Message ini !!!
 {* Инициализация str_QueryIsEmptyMessage }
 str_FilterCaption.Init;
 {* Инициализация str_FilterCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadForm);
 {* Регистрация PrimSaveLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
