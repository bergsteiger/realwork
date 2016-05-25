unit PrimSaveLoad_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoad_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimSaveLoad" MUID: (4958E3AB0247)
// Имя типа: "TPrimSaveLoadForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 , eeInterfaces
 , nsTypes
 , FiltersUnit
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsInterfaces
;

type
 _nsUserSettingsListener_Parent_ = TvcmContainerForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
 _vcmChromeLikeTabUpdater_Parent_ = _nsUserSettingsListener_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabUpdater.imp.pas}
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
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function nsIsQueryTypeCompatibleToQueryFormType(aQueryType: TQueryType;
    aFormType: TvcmUserType): Boolean;
   procedure File_SaveToFolder_Test(const aParams: IvcmTestParamsPrim);
    {* Сохранить в папки }
   procedure File_SaveToFolder_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Сохранить в папки }
   procedure File_LoadFromFolder_Test(const aParams: IvcmTestParamsPrim);
    {* Загрузить из папок }
   procedure File_LoadFromFolder_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Загрузить из папок }
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean;
    {* Коллеги, кто может описать этот метод? }
   procedure Loadable_Load(const aParams: IvcmExecuteParams);
    {* Коллеги, кто может описать этот метод? }
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Query_ClearAll_Execute(aNotClearRange: Boolean);
   procedure Query_ClearAll(const aParams: IvcmExecuteParams);
   procedure Query_SetList_Execute(const aList: IdeList;
    aInList: Boolean);
   procedure Query_SetList(const aParams: IvcmExecuteParams);
   function Filterable_Add_Execute(const aFilter: IFilterFromQuery): Boolean;
   procedure Filterable_Add(const aParams: IvcmExecuteParams);
   function Filterable_Delete_Execute(const aFilter: IFilterFromQuery): Boolean;
   procedure Filterable_Delete(const aParams: IvcmExecuteParams);
   function Query_GetList_Execute: IdeList;
   procedure Query_GetList(const aParams: IvcmExecuteParams);
   procedure Filterable_ClearAll_Execute;
   procedure Filterable_ClearAll(const aParams: IvcmExecuteParams);
   function Filterable_Refresh_Execute: Boolean;
   procedure Filterable_Refresh(const aParams: IvcmExecuteParams);
   procedure Result_ClearAll_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_ClearAll_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Query_GetOldQuery_Test(const aParams: IvcmTestParamsPrim);
   procedure Query_GetOldQuery_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Query_SearchType_Test(const aParams: IvcmTestParamsPrim);
   procedure Query_SearchType_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LogicOperation_LogicOr_Test(const aParams: IvcmTestParamsPrim);
   procedure LogicOperation_LogicOr_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LogicOperation_LogicAnd_Test(const aParams: IvcmTestParamsPrim);
   procedure LogicOperation_LogicAnd_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LogicOperation_LogicNot_Test(const aParams: IvcmTestParamsPrim);
   procedure LogicOperation_LogicNot_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filters_FiltersListOpen_Test(const aParams: IvcmTestParamsPrim);
    {* Фильтры (вкладка) }
   procedure Filters_FiltersListOpen_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Фильтры (вкладка) }
   function Filterable_GetListType_Execute: TbsListType;
   procedure Filterable_GetListType(const aParams: IvcmExecuteParams);
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
   property lbHeader: TvtLabel
    read f_lbHeader;
   property pbHeader: TPaintBox
    read f_pbHeader;
 end;//TPrimSaveLoadForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3MessageID
 , l3StringIDEx
 , nsLogEvent
 {$If NOT Defined(Monitorings)}
 , nsFolders
 {$IfEnd} // NOT Defined(Monitorings)
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
 , DynamicDocListUnit
 , bsUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ConsultingUnit
 , nsPostingsTreeSingle
 , LoggingUnit
;

{$If NOT Defined(NoVCM)}
{$If NOT Defined(Monitorings)}
type
 TnsLoadQueryEvent = {final} class(TnsLogEvent)
  private
   class procedure Log(const aQuery: IQuery); virtual;
 end;//TnsLoadQueryEvent
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
type
 TnsSendRequestToLegalAdviceEvent = class(TnsLogEvent)
  private
   class procedure Log;
 end;//TnsSendRequestToLegalAdviceEvent
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
type
 TnsLoadQueryFromHistoryEvent = {final} class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsLoadQueryFromHistoryEvent
{$IfEnd} // NOT Defined(Monitorings)

type
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

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}

type _Instance_R_ = TPrimSaveLoadForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabUpdater.imp.pas}

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

procedure TPrimSaveLoadForm.File_SaveToFolder_Test(const aParams: IvcmTestParamsPrim);
 {* Сохранить в папки }
//#UC START# *49885D540232_4958E3AB0247test_var*
//#UC END# *49885D540232_4958E3AB0247test_var*
begin
//#UC START# *49885D540232_4958E3AB0247test_impl*
 if not HideOpForPostingOrder(aParams) and Assigned(Aggregate) then
  with aParams.Op.SubItems do
  begin
   Clear;
   if Op_SearchParameters_IsQuerySaved.Call(Aggregate) then
   begin
    Add(vcmCStr(str_SaveLoadOverride));
    Add(vcmCStr(str_SaveLoadSaveAs));
   end;//TSearchParameter_IsQuerySaved_Op.Call(Aggregate)
  end;//with aParams.Op.SubItems
//#UC END# *49885D540232_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.File_SaveToFolder_Test

procedure TPrimSaveLoadForm.File_SaveToFolder_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Сохранить в папки }
//#UC START# *49885D540232_4958E3AB0247exec_var*
var
 l_CurOpsIndex   : Integer;
 l_CurName       : Il3CString;
 l_QueryIsEmpty  : Boolean;
 l_EntityBase    : IEntityBase;
 l_EntityStorage : IEntityStorage;
 l_QueryType     : TlgQueryType;
 l_QueryParams   : TnsQueryInfo;
//#UC END# *49885D540232_4958E3AB0247exec_var*
begin
//#UC START# *49885D540232_4958E3AB0247exec_impl*
 if IsDictionLike then
 begin
  Assert(false);
  Exit;
 end;//IsDictionLike
 l_QueryIsEmpty := False;

 l_CurOpsIndex := aParams.ItemIndex;

 if (l_CurOpsIndex >= 0) and (Aggregate <> nil) then
 begin
  if Op_SearchParameters_IsQueryEmpty.Call(Aggregate) then
  begin
   l_QueryIsEmpty := True;
   if (UserType <> slqtLegislationReview) and
     not Ask(qr_QueryIsEmpty) then Exit;
  end;//Op_SearchParameters_IsQueryEmpty.Call(Aggregate)
  // Получаем заполненный Query из КЗ
  l_QueryParams := Op_SearchParameters_GetQuery.Call(Aggregate);
  if not l_QueryParams.rHasErrors then
   begin
    l_QueryType := AdapterQueryToBusinessQuery(l_QueryParams.rQuery.GetType);
    // Для Обзора законодательства запрещаем сохранение пустой КЗ
    if (l_QueryType = lg_qtLegislationReview) and
       l_QueryIsEmpty then
    begin
     Say(inf_QueryIsEmptyCantSave);
     exit;
    end;//l_QueryType = lg_qtLegislationReview
    if Supports(l_QueryParams.rQuery, IEntityBase, l_EntityBase) then
    try
     if l_EntityBase.GetIsSaved then
      case l_CurOpsIndex of
       1 :
       begin
        l_CurName := nsGetQueryName(l_QueryParams.rQuery);
        if Ask(qr_QueryWasSavedEx, [l_CurName]) then
         try
          /////////////////////////////////////////
          // исключаем http://mdp.garant.ru/pages/viewpage.action?pageId=321985983
          // -Бесконечную рекурсию часом никогда не получим?
          // -Нет, это в нормальном поведении невозможно, когда список до сохранения был НЕпустой, а потом тут (см. строку ниже) станет пустым
          if (l_CurOpsIndex >= 0) and (Aggregate <> nil) and (not l_QueryIsEmpty) and Op_SearchParameters_IsQueryEmpty.Call(Aggregate) then
          begin
           File_SaveToFolder_Execute(aParams);
           Exit;
          end;
          /////////////////////////////////////////
          l_EntityBase.SaveTo(nil, l_EntityStorage);
         except
          on EAccessDenied do
           Say(err_SaveReadOnlyQuery);
          on ECanNotSave do
           Say(err_CannotSave, [l_CurName]);
          on ENotSaved do
           Say(err_NotSaved);
         end;//try..except
       end;//1
       0, 2 :
        {$IFDEF Monitorings}
        Assert(false);
        {$Else  Monitorings}
        TdmStdRes.SaveOpen(Self.As_IvcmEntityForm,
                           MakeFilterInfo,
                           fetQuery,
                           l_EntityBase,
                           True);
        {$EndIF  Monitorings}
       else
        Assert(false);
      end//case l_CurOpsIndex
     else
     begin
      // Сохраняем Query в папку
      {$IFDEF Monitorings}
      Assert(false);
      {$Else  Monitorings}
      TdmStdRes.SaveOpen(Self.As_IvcmEntityForm,
                         MakeFilterInfo,
                         fetQuery,
                         l_EntityBase,
                         false);
      {$EndIF Monitorings}
     end;//l_EntityBase.GetIsSaved
    finally
     l_EntityBase := nil;
    end;//try..finally
   end;//not l_QueryParams.rHasErrors
 end//l_CurOpsIndex >= 0
 else
  aParams.DoneStatus := vcm_dsInvalidParams;
  // - это нужно, чтобы вызывалось по ShortCut'у
//#UC END# *49885D540232_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.File_SaveToFolder_Execute

procedure TPrimSaveLoadForm.File_LoadFromFolder_Test(const aParams: IvcmTestParamsPrim);
 {* Загрузить из папок }
//#UC START# *49885D59018D_4958E3AB0247test_var*
//#UC END# *49885D59018D_4958E3AB0247test_var*
begin
//#UC START# *49885D59018D_4958E3AB0247test_impl*
 HideOpForPostingOrder(aParams);
//#UC END# *49885D59018D_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.File_LoadFromFolder_Test

procedure TPrimSaveLoadForm.File_LoadFromFolder_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Загрузить из папок }
//#UC START# *49885D59018D_4958E3AB0247exec_var*
//#UC END# *49885D59018D_4958E3AB0247exec_var*
begin
//#UC START# *49885D59018D_4958E3AB0247exec_impl*
 // Выбор Query из папки
 {$IFDEF Monitorings}
 Assert(false);
 {$Else  Monitorings}
 TdmStdRes.LoadOpen(Self.As_IvcmEntityForm, MakeFilterInfo);
 {$EndIF Monitorings}
//#UC END# *49885D59018D_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.File_LoadFromFolder_Execute

function TPrimSaveLoadForm.Loadable_Load_Execute(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = LLO_NONE): Boolean;
 {* Коллеги, кто может описать этот метод? }
//#UC START# *49895A2102E8_4958E3AB0247exec_var*
const
 cQueryType: array [TQueryType] of PvcmStringID =
                      (@str_qtKeyWord,
                       @str_qtAttribute,
                       //@str_qtOldAttribute,
                       //@str_qtOldFilter,
                       @str_qtPublishSource,
                       @str_qtComments,
                       @str_qtReview,
                       @str_qtMailList,
                       @str_qtRubricator,
                       @str_Empty,
                       @str_qtConsultation,
                       @str_Empty,
                       @str_qtBaseSearch,
                       @str_qtInpharmSearch);
var
 l_FolderNode : INode;
 l_BaseEntity : IUnknown;
 l_Query      : IQuery;
 l_QueryType  : TQueryType;
//#UC END# *49895A2102E8_4958E3AB0247exec_var*
begin
//#UC START# *49895A2102E8_4958E3AB0247exec_impl*
 Result := true;
 if Supports(aNode, INode, l_FolderNode) then
  try
   l_FolderNode.Open(l_BaseEntity);
   try
    if Supports(l_BaseEntity, IQuery, l_Query) then
     try
      l_QueryType := l_Query.GetType;
      if nsIsQueryTypeCompatibleToQueryFormType(l_QueryType,
                                                UserType) then
      begin
       {$If not defined(Monitorings)}
       TnsLoadQueryEvent.Log(l_Query);
       {$IfEnd}
       // Передаем Query в КЗ для заполнения
       op_SearchParameters_SetQuery.Call(Aggregate, l_Query);
      end
      else
      begin
       Assert(CurUserType <> nil);
       Say(inf_WrongQueryType, [vcmCStr(cQueryType[l_QueryType]^),
                                CurUserType.Caption]);
       Result := false;
      end;//nsIsQueryTypeCompatibleToQueryFormType
     finally
      l_Query := nil;
     end;//try..finally
   finally
    l_BaseEntity := nil;
   end;//try..finally
  finally
   l_FolderNode := nil;
  end;//try..finally
//#UC END# *49895A2102E8_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Loadable_Load_Execute

procedure TPrimSaveLoadForm.Loadable_Load(const aParams: IvcmExecuteParams);
 {* Коллеги, кто может описать этот метод? }
begin
 with (aParams.Data As ILoadable_Load_Params) do
  ResultValue := Self.Loadable_Load_Execute(Node, Data, nOp);
end;//TPrimSaveLoadForm.Loadable_Load

procedure TPrimSaveLoadForm.JournalShrinked;
//#UC START# *4A83AA610299_4958E3AB0247_var*
//#UC END# *4A83AA610299_4958E3AB0247_var*
begin
//#UC START# *4A83AA610299_4958E3AB0247_impl*
 if not IsDictionLike then
  LoadQueryHistory;
//#UC END# *4A83AA610299_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.JournalShrinked

procedure TPrimSaveLoadForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A8AD47D0357_4958E3AB0247test_var*
//#UC END# *4A8AD47D0357_4958E3AB0247test_var*
begin
//#UC START# *4A8AD47D0357_4958E3AB0247test_impl*
 // - ничего не делаем
//#UC END# *4A8AD47D0357_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.Result_OkExt_Test

procedure TPrimSaveLoadForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A8AD47D0357_4958E3AB0247exec_var*
//#UC END# *4A8AD47D0357_4958E3AB0247exec_var*
begin
//#UC START# *4A8AD47D0357_4958E3AB0247exec_impl*
 if IsOkBtn then
 begin
  {$If defined(Monitorings) or defined(Admin)}
  Assert(false);
  {$Else}
  FillQueryAndSearch;
  LoadQueryHistory;
  {$IfEnd}
 end//IsOkBtn
 else 
  enResultopSaveExecute(aParams);
//#UC END# *4A8AD47D0357_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Result_OkExt_Execute

procedure TPrimSaveLoadForm.Result_OkExt_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A8AD47D0357_4958E3AB0247getstate_var*
var
 l_UserType: TvcmUserType;
//#UC END# *4A8AD47D0357_4958E3AB0247getstate_var*
begin
//#UC START# *4A8AD47D0357_4958E3AB0247getstate_impl*
 if IsDictionLike then
 begin
  Assert(false);
  Exit;
 end;//IsDictionLike
 l_UserType := UserType;
 if (l_UserType = slqtConsult) then
  State := st_user_Result_OkExt_Consult
 else
 {$if not defined(Monitorings)}
 if (l_UserType = slqtPostingOrder) then
  State := st_user_Result_OkExt_SaveAndSend
 else
 {$ifend}
 if IsOkBtn then
  State := st_user_Result_OkExt_Search
 else
  State := st_user_Result_OkExt_Save;
//#UC END# *4A8AD47D0357_4958E3AB0247getstate_impl*
end;//TPrimSaveLoadForm.Result_OkExt_GetState

procedure TPrimSaveLoadForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_4958E3AB0247test_var*
//#UC END# *4AC5D61E0284_4958E3AB0247test_var*
begin
//#UC START# *4AC5D61E0284_4958E3AB0247test_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.Result_Cancel_Test

procedure TPrimSaveLoadForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_4958E3AB0247exec_var*
//#UC END# *4AC5D61E0284_4958E3AB0247exec_var*
begin
//#UC START# *4AC5D61E0284_4958E3AB0247exec_impl*
 if ZoneType = vcm_ztManualModal then
  ModalResult := mrCancel
 else
  vcmDispatcher.History.Back;
//#UC END# *4AC5D61E0284_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Result_Cancel_Execute

procedure TPrimSaveLoadForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
 {* Отмена }
//#UC START# *4AC5D61E0284_4958E3AB0247getstate_var*
//#UC END# *4AC5D61E0284_4958E3AB0247getstate_var*
begin
//#UC START# *4AC5D61E0284_4958E3AB0247getstate_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_4958E3AB0247getstate_impl*
end;//TPrimSaveLoadForm.Result_Cancel_GetState

procedure TPrimSaveLoadForm.Query_ClearAll_Execute(aNotClearRange: Boolean);
//#UC START# *4AE8A0E10254_4958E3AB0247exec_var*
//#UC END# *4AE8A0E10254_4958E3AB0247exec_var*
begin
//#UC START# *4AE8A0E10254_4958E3AB0247exec_impl*
 if not aNotClearRange then
 begin
  with SearchState do
  begin
   if List <> nil then
    SearchType := stAllBase
   else
    SearchType := stNone;
  end;//SearchState
 end;//not aNotClearRange
 if (Aggregate <> nil) then
 begin
  op_SearchParameters_ClearQuery.Call(Aggregate);
  Op_List_SetNewContent.Call(Aggregate);
   // - загрузим фильтры по умолчанию.
 end;//Aggregate <> nil
//#UC END# *4AE8A0E10254_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Query_ClearAll_Execute

procedure TPrimSaveLoadForm.Query_ClearAll(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IQuery_ClearAll_Params) do
  Self.Query_ClearAll_Execute(NotClearRange);
end;//TPrimSaveLoadForm.Query_ClearAll

procedure TPrimSaveLoadForm.Query_SetList_Execute(const aList: IdeList;
 aInList: Boolean);
//#UC START# *4AE96F6C0191_4958E3AB0247exec_var*
//#UC END# *4AE96F6C0191_4958E3AB0247exec_var*
begin
//#UC START# *4AE96F6C0191_4958E3AB0247exec_impl*
 if (aList <> nil) then
 begin
  SearchState.List := aList;
  if aInList then
   SearchState.SearchType := stInList
  else
   SearchState.SearchType := stAllBase;
 end//aList <> nil
 else
 begin
  SearchState.List := nil;
  SearchState.SearchType := stNone; {stAllBaseOnly;}
 end;//aList <> nil
//#UC END# *4AE96F6C0191_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Query_SetList_Execute

procedure TPrimSaveLoadForm.Query_SetList(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IQuery_SetList_Params) do
  Self.Query_SetList_Execute(List, InList);
end;//TPrimSaveLoadForm.Query_SetList

function TPrimSaveLoadForm.Filterable_Add_Execute(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4AEF0BF70306_4958E3AB0247exec_var*
//#UC END# *4AEF0BF70306_4958E3AB0247exec_var*
begin
//#UC START# *4AEF0BF70306_4958E3AB0247exec_impl*
 Result := true;
//#UC END# *4AEF0BF70306_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Filterable_Add_Execute

procedure TPrimSaveLoadForm.Filterable_Add(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_Add_Params) do
  ResultValue := Self.Filterable_Add_Execute(Filter);
end;//TPrimSaveLoadForm.Filterable_Add

function TPrimSaveLoadForm.Filterable_Delete_Execute(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4AEF0D1A01C3_4958E3AB0247exec_var*
//#UC END# *4AEF0D1A01C3_4958E3AB0247exec_var*
begin
//#UC START# *4AEF0D1A01C3_4958E3AB0247exec_impl*
 Result := true;
//#UC END# *4AEF0D1A01C3_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Filterable_Delete_Execute

procedure TPrimSaveLoadForm.Filterable_Delete(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_Delete_Params) do
  ResultValue := Self.Filterable_Delete_Execute(Filter);
end;//TPrimSaveLoadForm.Filterable_Delete

function TPrimSaveLoadForm.Query_GetList_Execute: IdeList;
//#UC START# *4AF2AA2100CF_4958E3AB0247exec_var*
//#UC END# *4AF2AA2100CF_4958E3AB0247exec_var*
begin
//#UC START# *4AF2AA2100CF_4958E3AB0247exec_impl*
 if (SearchState.SearchType = stInList) and
    (SearchState.List <> nil) then
  Result := SearchState.List
 else
  Result := nil;
//#UC END# *4AF2AA2100CF_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Query_GetList_Execute

procedure TPrimSaveLoadForm.Query_GetList(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IQuery_GetList_Params) do
  ResultValue := Self.Query_GetList_Execute;
end;//TPrimSaveLoadForm.Query_GetList

procedure TPrimSaveLoadForm.Filterable_ClearAll_Execute;
//#UC START# *4AF80DB80383_4958E3AB0247exec_var*
//#UC END# *4AF80DB80383_4958E3AB0247exec_var*
begin
//#UC START# *4AF80DB80383_4958E3AB0247exec_impl*
 // - ничего не делаем
//#UC END# *4AF80DB80383_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Filterable_ClearAll_Execute

procedure TPrimSaveLoadForm.Filterable_ClearAll(const aParams: IvcmExecuteParams);
begin
 Self.Filterable_ClearAll_Execute;
end;//TPrimSaveLoadForm.Filterable_ClearAll

function TPrimSaveLoadForm.Filterable_Refresh_Execute: Boolean;
//#UC START# *4AF810230307_4958E3AB0247exec_var*
//#UC END# *4AF810230307_4958E3AB0247exec_var*
begin
//#UC START# *4AF810230307_4958E3AB0247exec_impl*
 // - ничего не делаем
 Result := True;
//#UC END# *4AF810230307_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Filterable_Refresh_Execute

procedure TPrimSaveLoadForm.Filterable_Refresh(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_Refresh_Params) do
  ResultValue := Self.Filterable_Refresh_Execute;
end;//TPrimSaveLoadForm.Filterable_Refresh

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

procedure TPrimSaveLoadForm.Result_ClearAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2DFEE000BA_4958E3AB0247test_var*
//#UC END# *4C2DFEE000BA_4958E3AB0247test_var*
begin
//#UC START# *4C2DFEE000BA_4958E3AB0247test_impl*
 // - ничего не делаем
//#UC END# *4C2DFEE000BA_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.Result_ClearAll_Test

procedure TPrimSaveLoadForm.Result_ClearAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2DFEE000BA_4958E3AB0247exec_var*
//#UC END# *4C2DFEE000BA_4958E3AB0247exec_var*
begin
//#UC START# *4C2DFEE000BA_4958E3AB0247exec_impl*
 Query_ClearAll_Execute(false);
//#UC END# *4C2DFEE000BA_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Result_ClearAll_Execute

procedure TPrimSaveLoadForm.Query_GetOldQuery_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C31A4EC023F_4958E3AB0247test_var*
//#UC END# *4C31A4EC023F_4958E3AB0247test_var*
begin
//#UC START# *4C31A4EC023F_4958E3AB0247test_impl*
 if QueryHistory.Count > 0 then
 begin
  aParams.Op.Flag[vcm_ofEnabled] := True;
  aParams.Op.SubItems := QueryHistory;
 end//if QueryHistory.Count > 0 then
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C31A4EC023F_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.Query_GetOldQuery_Test

procedure TPrimSaveLoadForm.Query_GetOldQuery_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C31A4EC023F_4958E3AB0247exec_var*
var
 l_Index    : Integer;
 l_NewQuery : IQuery;
 l_OldQuery : IQuery;
//#UC END# *4C31A4EC023F_4958E3AB0247exec_var*
begin
//#UC START# *4C31A4EC023F_4958E3AB0247exec_impl*
 l_Index := aParams.ItemIndex;
 if (l_Index = 0) then
 begin
  l_Index := f_LastQueryIndex;
  Inc(f_LastQueryIndex);
  if (f_LastQueryIndex >= QueryHistory.Count) then
   f_LastQueryIndex := 0;
 end//l_Index = 0
 else
  Dec(l_Index);
 if Supports(QueryHistory.Items[l_Index], IQuery, l_OldQuery) then
  try
   l_OldQuery.Clone(l_NewQuery);
   try
    // Передаем Query в КЗ для заполнения
    op_SearchParameters_SetQuery.Call(Aggregate, l_NewQuery);
    {$If not Defined(Admin) and not Defined(Monitorings)}
    TnsLoadQueryFromHistoryEvent.Log;
    {$IfEnd}
   finally
    l_NewQuery := nil;
   end;//try..finally
  finally
   l_OldQuery := nil;
  end;//try..finally
//#UC END# *4C31A4EC023F_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Query_GetOldQuery_Execute

procedure TPrimSaveLoadForm.Query_SearchType_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C31A68800FA_4958E3AB0247test_var*

  function lp_AllSearchCaption: IvcmCString;
  begin
   case ListType of
    bs_ltDocument:
     Result := vcmCStr(str_AllDocumentSearch);
    bs_ltDrug:
     Result := vcmCStr(str_AllDrugSearch);
    else
    begin
     Result := nil;
     Assert(False);
    end;//else
   end;//case ListType of
  end;//lp_AllSearchCaption

var
 l_Strings : IvcmStrings;
//#UC END# *4C31A68800FA_4958E3AB0247test_var*
begin
//#UC START# *4C31A68800FA_4958E3AB0247test_impl*
 case SearchState.SearchType of
  stNone :
    begin
     aParams.Op.Flag[vcm_ofEnabled] := False;
     aParams.Op.SelectedString := lp_AllSearchCaption;
     aParams.Op.SubNodes := nil;
    end;//stNone
//  stAllBaseOnly : aParams.Op.Flag[vcm_ofVisible] := False;
  stAllBase, stInList :
    begin
     aParams.Op.Flag[vcm_ofEnabled] := True;
     l_Strings := aParams.Op.SubItems;
     if (l_Strings <> nil) and
        (l_Strings.Count = 0) then
     begin
      l_Strings.Clear;
      l_Strings.Add(lp_AllSearchCaption);
      l_Strings.Add(vcmCStr(str_CurListSearch));
     end;
     case SearchState.SearchType of
      stAllBase:
       aParams.Op.SelectedString := lp_AllSearchCaption;
      stInList:
       aParams.Op.SelectedString := vcmCStr(str_CurListSearch);
     end;
    end//l_Strings <> nil..
 end;//case SearchState.SearchType
//#UC END# *4C31A68800FA_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.Query_SearchType_Test

procedure TPrimSaveLoadForm.Query_SearchType_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C31A68800FA_4958E3AB0247exec_var*
//#UC END# *4C31A68800FA_4958E3AB0247exec_var*
begin
//#UC START# *4C31A68800FA_4958E3AB0247exec_impl*
 if l3Same(aParams.SelectedString, vcmCStr(str_CurListSearch)) then
  SearchState.SearchType := stInList
 else
  SearchState.SearchType := stAllBase;
//#UC END# *4C31A68800FA_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Query_SearchType_Execute

procedure TPrimSaveLoadForm.LogicOperation_LogicOr_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C31B48D03BB_4958E3AB0247test_var*
//#UC END# *4C31B48D03BB_4958E3AB0247test_var*
begin
//#UC START# *4C31B48D03BB_4958E3AB0247test_impl*
 vcmDispatcher.EntityOperation(TdmStdRes.opcode_Attribute_LogicOr, aParams As IvcmTestParams);
 // На контейнере кнопка всегда видна
 aParams.Op.Flag[vcm_ofVisible] := True;
//#UC END# *4C31B48D03BB_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.LogicOperation_LogicOr_Test

procedure TPrimSaveLoadForm.LogicOperation_LogicOr_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C31B48D03BB_4958E3AB0247exec_var*
//#UC END# *4C31B48D03BB_4958E3AB0247exec_var*
begin
//#UC START# *4C31B48D03BB_4958E3AB0247exec_impl*
 vcmDispatcher.EntityOperation(TdmStdRes.opcode_Attribute_LogicOr, aParams As IvcmExecuteParams);
//#UC END# *4C31B48D03BB_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.LogicOperation_LogicOr_Execute

procedure TPrimSaveLoadForm.LogicOperation_LogicAnd_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C31B4990225_4958E3AB0247test_var*
//#UC END# *4C31B4990225_4958E3AB0247test_var*
begin
//#UC START# *4C31B4990225_4958E3AB0247test_impl*
 vcmDispatcher.EntityOperation(TdmStdRes.opcode_Attribute_LogicAnd, aParams As IvcmTestParams);
 // На контейнере кнопка всегда видна
 aParams.Op.Flag[vcm_ofVisible] := True;
//#UC END# *4C31B4990225_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.LogicOperation_LogicAnd_Test

procedure TPrimSaveLoadForm.LogicOperation_LogicAnd_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C31B4990225_4958E3AB0247exec_var*
//#UC END# *4C31B4990225_4958E3AB0247exec_var*
begin
//#UC START# *4C31B4990225_4958E3AB0247exec_impl*
 vcmDispatcher.EntityOperation(TdmStdRes.opcode_Attribute_LogicAnd, aParams As IvcmExecuteParams);
//#UC END# *4C31B4990225_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.LogicOperation_LogicAnd_Execute

procedure TPrimSaveLoadForm.LogicOperation_LogicNot_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C31B4A90088_4958E3AB0247test_var*
//#UC END# *4C31B4A90088_4958E3AB0247test_var*
begin
//#UC START# *4C31B4A90088_4958E3AB0247test_impl*
 vcmDispatcher.EntityOperation(TdmStdRes.opcode_Attribute_LogicNot, aParams As IvcmTestParams);
 // На контейнере кнопка всегда видна
 aParams.Op.Flag[vcm_ofVisible] := True;
//#UC END# *4C31B4A90088_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.LogicOperation_LogicNot_Test

procedure TPrimSaveLoadForm.LogicOperation_LogicNot_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C31B4A90088_4958E3AB0247exec_var*
//#UC END# *4C31B4A90088_4958E3AB0247exec_var*
begin
//#UC START# *4C31B4A90088_4958E3AB0247exec_impl*
 vcmDispatcher.EntityOperation(TdmStdRes.opcode_Attribute_LogicNot, aParams As IvcmExecuteParams);
//#UC END# *4C31B4A90088_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.LogicOperation_LogicNot_Execute

procedure TPrimSaveLoadForm.Filters_FiltersListOpen_Test(const aParams: IvcmTestParamsPrim);
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_4958E3AB0247test_var*
//#UC END# *4C81191003E5_4958E3AB0247test_var*
begin
//#UC START# *4C81191003E5_4958E3AB0247test_impl*
 HideOpForPostingOrder(aParams);
//#UC END# *4C81191003E5_4958E3AB0247test_impl*
end;//TPrimSaveLoadForm.Filters_FiltersListOpen_Test

procedure TPrimSaveLoadForm.Filters_FiltersListOpen_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_4958E3AB0247exec_var*
//#UC END# *4C81191003E5_4958E3AB0247exec_var*
begin
//#UC START# *4C81191003E5_4958E3AB0247exec_impl*
 {$IFDEF Monitorings}
 Assert(false);
 {$Else  Monitorings}
 if (DataSource = nil) then
  TdmStdRes.OldSchoolFiltersOpen(Aggregate, nil, Self)
 else
  TdmStdRes.FiltersOpen(Self.Filters);
 {$EndIF Monitorings}
//#UC END# *4C81191003E5_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Filters_FiltersListOpen_Execute

function TPrimSaveLoadForm.Filterable_GetListType_Execute: TbsListType;
//#UC START# *4F99403A00A5_4958E3AB0247exec_var*
//#UC END# *4F99403A00A5_4958E3AB0247exec_var*
begin
//#UC START# *4F99403A00A5_4958E3AB0247exec_impl*
 Result := ListType;
//#UC END# *4F99403A00A5_4958E3AB0247exec_impl*
end;//TPrimSaveLoadForm.Filterable_GetListType_Execute

procedure TPrimSaveLoadForm.Filterable_GetListType(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_GetListType_Params) do
  ResultValue := Self.Filterable_GetListType_Execute;
end;//TPrimSaveLoadForm.Filterable_GetListType

{$If NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
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
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

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

procedure TPrimSaveLoadForm.ClearFields;
begin
 f_SearchState := nil;
 inherited;
end;//TPrimSaveLoadForm.ClearFields

function TPrimSaveLoadForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4958E3AB0247_var*
//#UC END# *53F1C6EF02C9_4958E3AB0247_var*
begin
//#UC START# *53F1C6EF02C9_4958E3AB0247_impl*
 Result := MakeCaption;
//#UC END# *53F1C6EF02C9_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.DoGetTabCaption

function TPrimSaveLoadForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
 {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
//#UC START# *55127A5401DE_4958E3AB0247_var*
//#UC END# *55127A5401DE_4958E3AB0247_var*
begin
//#UC START# *55127A5401DE_4958E3AB0247_impl*
 case UserType of
  slqtPostingOrder:
   if aDataUpdate then
    Result := defDataAdapter.Monitoring.IsExist
   else
    Result := defDataAdapter.Monitoring.IsExist and not Assigned(TnsPostingsTreeSingle.Instance.MgrSearch);
  slqtPublishSource: Result := defDataAdapter.IsExists_PublishSourceTag;
  slqtInpharmSearch: Result := defDataAdapter.IsInpharmExists;
 else
  Result := True;
 end;
//#UC END# *55127A5401DE_4958E3AB0247_impl*
end;//TPrimSaveLoadForm.IsAcceptable

procedure TPrimSaveLoadForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
end;//TPrimSaveLoadForm.SignalDataSourceChanged

procedure TPrimSaveLoadForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Loadable, nil);
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Query, nil);
  PublishFormEntity(en_Filterable, nil);
  PublishFormEntity(en_Filters, nil);
  PublishFormEntity(en_LogicOperation, nil);
  PublishOp(en_File, op_SaveToFolder, File_SaveToFolder_Execute, File_SaveToFolder_Test, nil);
  PublishOp(en_File, op_LoadFromFolder, File_LoadFromFolder_Execute, File_LoadFromFolder_Test, nil);
  PublishOpWithResult(en_Loadable, op_Load, Loadable_Load, nil, nil);
  PublishOp(en_Result, op_OkExt, Result_OkExt_Execute, Result_OkExt_Test, Result_OkExt_GetState);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, Result_Cancel_GetState);
  PublishOpWithResult(en_Query, op_ClearAll, Query_ClearAll, nil, nil);
  PublishOpWithResult(en_Query, op_SetList, Query_SetList, nil, nil);
  PublishOpWithResult(en_Filterable, op_Add, Filterable_Add, nil, nil);
  PublishOpWithResult(en_Filterable, op_Delete, Filterable_Delete, nil, nil);
  PublishOpWithResult(en_Query, op_GetList, Query_GetList, nil, nil);
  PublishOpWithResult(en_Filterable, op_ClearAll, Filterable_ClearAll, nil, nil);
  PublishOpWithResult(en_Filterable, op_Refresh, Filterable_Refresh, nil, nil);
  PublishOp(en_Result, op_ClearAll, Result_ClearAll_Execute, Result_ClearAll_Test, nil);
  PublishOp(en_Query, op_GetOldQuery, Query_GetOldQuery_Execute, Query_GetOldQuery_Test, nil);
  PublishOp(en_Query, op_SearchType, Query_SearchType_Execute, Query_SearchType_Test, nil);
  PublishOp(en_LogicOperation, op_LogicOr, LogicOperation_LogicOr_Execute, LogicOperation_LogicOr_Test, nil);
  PublishOp(en_LogicOperation, op_LogicAnd, LogicOperation_LogicAnd_Execute, LogicOperation_LogicAnd_Test, nil);
  PublishOp(en_LogicOperation, op_LogicNot, LogicOperation_LogicNot_Execute, LogicOperation_LogicNot_Test, nil);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, Result_Cancel_GetState);
  PublishOp(en_Result, op_OkExt, Result_OkExt_Execute, Result_OkExt_Test, Result_OkExt_GetState);
  PublishOp(en_Filters, op_FiltersListOpen, Filters_FiltersListOpen_Execute, Filters_FiltersListOpen_Test, nil);
  PublishOpWithResult(en_Filterable, op_GetListType, Filterable_GetListType, nil, nil);
 end;//with Entities.Entities
end;//TPrimSaveLoadForm.InitEntities

procedure TPrimSaveLoadForm.MakeControls;
begin
 inherited;
 f_pnHeader := TvtPanel.Create(Self);
 f_pnHeader.Name := 'pnHeader';
 f_pnHeader.Parent := Self;
 f_lbHeader := TvtLabel.Create(Self);
 f_lbHeader.Name := 'lbHeader';
 f_lbHeader.Parent := pnHeader;
 f_pbHeader := TPaintBox.Create(Self);
 f_pbHeader.Name := 'pbHeader';
 f_pbHeader.Parent := pnHeader;
 f_ParentZone := TvtPanel.Create(Self);
 f_ParentZone.Name := 'ParentZone';
 f_ParentZone.Parent := Self;
 with DefineZone(vcm_ztParent, f_ParentZone) do
 begin
  FormStyle.Toolbars.Bottom.MergeWithContainer := vcm_bTrue;
 end;//with DefineZone(vcm_ztParent
end;//TPrimSaveLoadForm.MakeControls

initialization
 str_WellDone.Init;
 str_WellDone.SetDlgType(mtInformation);
 {* Инициализация str_WellDone }
 str_QueryIsEmptyMessage.Init;
 str_QueryIsEmptyMessage.SetDlgType(mtWarning);
 {* Инициализация str_QueryIsEmptyMessage }
 str_FilterCaption.Init;
 {* Инициализация str_FilterCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSaveLoadForm);
 {* Регистрация PrimSaveLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
