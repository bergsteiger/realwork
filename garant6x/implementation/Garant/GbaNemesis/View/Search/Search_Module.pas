unit Search_Module;
 {* Поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Search_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Search" MUID: (4AA641A3036C)
// Имя типа: "TSearchModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , QueryCardInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchUnit
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TSearchModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Поиск }
  protected
   class function DefineFilterForm(const aQuery: IQuery): TnsFilterForm;
    {* определить тип формы фильтры }
   class procedure ShowList(aType: TnsSearchListType);
   class function CreateSearchContainer(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    aSearchType: TvcmUserType;
    aSearchInList: Boolean;
    const aList: IdeList;
    aZoneType: TvcmZoneType): IvcmEntityForm;
   class procedure OpenInpharm(anIndex: Integer;
    aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
   class procedure OpenPublishSource(anIndex: Integer;
    aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aList: IDynList;
    const aPublishSearchTag: Il3CString);
    {* Открывает карточку поиска по источнику опубликования }
   class procedure FillAllBaseListParams(const aParams: IvcmTestParamsPrim);
   class procedure OpenSituation(aFormSetId: RvcmFormSetFactory;
    const aQuery: IQuery);
   class procedure OpenOldSituation(aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aContainer: IvcmContainer);
   class procedure OpenAttribute(anIndex: Integer;
    aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
    {* открыть ППР }
   procedure opAllSearchTest(const aParams: IvcmTestParamsPrim);
    {* Поиск }
   procedure opAllSearchExecute(const aParams: IvcmExecuteParamsPrim);
    {* Поиск }
   procedure opAttributeSearchTest(const aParams: IvcmTestParamsPrim);
    {* Поиск по реквизитам }
   procedure opAttributeSearchExecute(const aParams: IvcmExecuteParamsPrim);
    {* Поиск по реквизитам }
   procedure opBaseSearchExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opDocumentsWithoutClassTest(const aParams: IvcmTestParamsPrim);
   procedure opDocumentsWithoutClassExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opDocumentsWithoutIncludedTest(const aParams: IvcmTestParamsPrim);
   procedure opDocumentsWithoutIncludedExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opDocumentsWithoutKeyTest(const aParams: IvcmTestParamsPrim);
   procedure opDocumentsWithoutKeyExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opInpharmSearchTest(const aParams: IvcmTestParamsPrim);
    {* Поиск лекарственных средств }
   procedure opInpharmSearchExecute(const aParams: IvcmExecuteParamsPrim);
    {* Поиск лекарственных средств }
   procedure opOpenConsultTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenConsultExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opPublishSourceSearchTest(const aParams: IvcmTestParamsPrim);
   procedure opPublishSourceSearchExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opStartENOTest(const aParams: IvcmTestParamsPrim);
   procedure opStartENOExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opOpenKeyWordSearchTest(const aParams: IvcmTestParamsPrim);
    {* Поиск по ситуации }
   procedure opOpenKeyWordSearchExecute(const aParams: IvcmExecuteParamsPrim);
    {* Поиск по ситуации }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TSearchModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , SimpleListInterfaces
 , bsTypes
 , nsQueryInterfaces
 , PrimSaveLoadUserTypes_slqtAttribute_UserType
 , PrimSaveLoadUserTypes_slqtKW_UserType
 , PrimSaveLoadUserTypes_slqtOldKW_UserType
 , PrimSaveLoadUserTypes_slqtPublishSource_UserType
 , PrimSaveLoadUserTypes_slqtFilters_UserType
 , PrimSaveLoadUserTypes_slqtPostingOrder_UserType
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 , PrimSaveLoadUserTypes_slqtInpharmSearch_UserType
 , PrimQueryCard_utqcAttributeSearch_UserType
 , PrimQueryCard_utqcLegislationReview_UserType
 , PrimQueryCard_utqcInpharmSearch_UserType
 , PrimAttributeSelect_utAttributeSelect_UserType
 , PrimAttributeSelect_utSingleSearch_UserType
 , PrimTreeAttributeSelect_astOneLevel_UserType
 , PrimTreeAttributeSelect_astFirstLevel_UserType
 , PrimTreeAttributeSelect_astTaxesPublishSearch_UserType
 , Common_FormDefinitions_Controls
 , bsUtils
 , SearchLite_Strange_Controls
 , Search_Strange_Controls
 , BaseSearchInterfaces
 , PrimSaveLoadUserTypes_slqtLegislationReview_UserType
 , PrimTreeAttributeSelect_astPharmPublishSearch_UserType
 , nsENOIntegration
 , bsHyperLinkProcessorPrim
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SearchModuleWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , nsConst
 , l3String
 , afwFacade
 , DataAdapter
 , deListSet
 , nsManagers
 , deList
 , nsTypes
 , deDocumentList
 , deSearch
 , sdsSituation
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , vcmItems
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , fsSituationSearch
 , fsSituationFilter
 , DefineSearchDate_Form
 , OldSituationSearch_Form
 , TreeAttributeFirstLevel_Form
 //#UC START# *4AA641A3036Cimpl_uses*
 , StdRes
 , Search_Services
 , SearchLite_Services
 , vcmDispatcher
 //#UC END# *4AA641A3036Cimpl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TSearchServiceImpl = {final} class(TvcmModuleContractImplementation, ISearchService)
  public
   procedure AttributeSearch(const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
   procedure EditFilter(const aFilter: IdeFilter;
    anItemIndex: Integer);
    {* Редактироваить фильтр }
   procedure InpharmSearch(const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
    {* Поиск лекарственных средств }
   procedure MakeNewFilter(aListType: TbsListType);
    {* Вызывает форму создания нового фильтра }
   procedure OpenKeyWord(const aQuery: IQuery;
    const aContainer: IvcmContainer);
    {* открыть ППС }
   procedure OpenOldSituationCard(const aQuery: IQuery;
    const aContainer: IvcmContainer);
    {* открыть ППС 5.х }
   procedure OpenPharmLegislationReview;
   procedure OpenPharmPublishSearch;
   procedure OpenSituationCard(const aQuery: IQuery);
    {* открыть ППС 6.х }
   procedure OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
    {* СМИ по налогам и бухучёту }
   procedure PublishSourceSearch(const aQuery: IQuery;
    const aList: IDynList);
   function DateQuery(const aCaller: IvcmEntityForm;
    const aData: IqaDateReqDataHolder): IvcmEntityForm;
   function OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
    {* Открывает форму фильтров }
   function OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
    {* открыть Обзор изменений законодательства }
   class function Instance: TSearchServiceImpl;
    {* Метод получения экземпляра синглетона TSearchServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TSearchServiceImpl

var g_TSearchServiceImpl: TSearchServiceImpl = nil;
 {* Экземпляр синглетона TSearchServiceImpl }
var f_SearchTypeList: IvcmItems;

procedure TSearchServiceImplFree;
 {* Метод освобождения экземпляра синглетона TSearchServiceImpl }
begin
 l3Free(g_TSearchServiceImpl);
end;//TSearchServiceImplFree

procedure TSearchServiceImpl.AttributeSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AB8FBBA016C_4AA641A3036C_var*
//#UC END# *4AB8FBBA016C_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB8FBBA016C_4AA641A3036C_impl*
  TSearchModule.OpenAttribute(0,
               vcm_ztParent,
               vcm_utAny,
               aQuery,
               aList,
               aContainer);
//#UC END# *4AB8FBBA016C_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.AttributeSearch

procedure TSearchServiceImpl.EditFilter(const aFilter: IdeFilter;
 anItemIndex: Integer);
 {* Редактироваить фильтр }
var
 __WasEnter : Boolean;
//#UC START# *4AB8F2DC01A3_4AA641A3036C_var*
//#UC END# *4AB8F2DC01A3_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB8F2DC01A3_4AA641A3036C_impl*
 // Редактироваить фильтр
 if (aFilter <> nil) AND (aFilter.Query <> nil) then
 begin
  case TSearchModule.DefineFilterForm(aFilter.Query) of
   ns_ffAttributeSearch:
    OpenFiltersForm(aFilter);
   ns_ffPublishSource:
    TSearchModule.OpenPublishSource(anItemIndex,
                      vcm_ztManualModal,
                      slqtFilters,
                      aFilter.Query,
                      nil,
                      nil);
   ns_ffSituation:
    TSearchModule.OpenSituation(Tfs_SituationFilter,
                  aFilter.Query);
   ns_ffOldSituation:
    TSearchModule.OpenOldSituation(vcm_ztManualModal,
                     slqtFilters,
                     aFilter.Query,
                     nil);
   ns_ffBaseSearch:
    TBaseSearchService.Instance.OpenBaseSearch(ns_bsokGlobal, aFilter.Query);
   ns_ffInpharmSearch:
    TSearchModule.OpenInpharm(anItemIndex,
                vcm_ztManualModal,
                slqtFilters,
                aFilter.Query,
                nil,
                nil);
   else
    Assert(false, 'Неизвестный тип фильтра');
  end;//case DefineFilterForm(aFilter.Query) of
 end//aFilter <> nil..
 // Создать новый фильтр
 else
  Assert(false, 'Пользуйтесь фабрикой TSearchService.Instance.MakeNewFilter');
//#UC END# *4AB8F2DC01A3_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.EditFilter

procedure TSearchServiceImpl.InpharmSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
 {* Поиск лекарственных средств }
var
 __WasEnter : Boolean;
//#UC START# *4AB7D4340301_4AA641A3036C_var*
//#UC END# *4AB7D4340301_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB7D4340301_4AA641A3036C_impl*
 TSearchModule.OpenInpharm(0,
             vcm_ztParent,
             vcm_utAny,
             aQuery,
             aList,
             aContainer);
//#UC END# *4AB7D4340301_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.InpharmSearch

procedure TSearchServiceImpl.MakeNewFilter(aListType: TbsListType);
 {* Вызывает форму создания нового фильтра }
var
 __WasEnter : Boolean;
//#UC START# *4AB7BFE700D2_4AA641A3036C_var*
//#UC END# *4AB7BFE700D2_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB7BFE700D2_4AA641A3036C_impl*
 Case aListType of
  bs_ltNone:
   Assert(false);
  bs_ltDocument:
   OpenFiltersForm(nil);
  bs_ltDrug:
   TSearchModule.OpenInpharm(0,
               vcm_ztManualModal,
               slqtFilters,
               nil,
               nil,
               nil);
  else
   Assert(false);
 end;//Case aListType
//#UC END# *4AB7BFE700D2_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.MakeNewFilter

procedure TSearchServiceImpl.OpenKeyWord(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* открыть ППС }
var
 __WasEnter : Boolean;
//#UC START# *4AB8EF3B0310_4AA641A3036C_var*
//#UC END# *4AB8EF3B0310_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB8EF3B0310_4AA641A3036C_impl*
 // ППС 6.х
 if l3Same(afw.Settings.LoadString(pi_Search_SituationType,
                     dv_Search_SituationType),
                     li_NewSearch_SituationType) then
  OpenSituationCard(aQuery)
 // ППС 5.х
 else
  OpenOldSituationCard(aQuery, aContainer);
//#UC END# *4AB8EF3B0310_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenKeyWord

procedure TSearchServiceImpl.OpenOldSituationCard(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* открыть ППС 5.х }
var
 __WasEnter : Boolean;
//#UC START# *4F27EAB1039F_4AA641A3036C_var*
//#UC END# *4F27EAB1039F_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4F27EAB1039F_4AA641A3036C_impl*
  TSearchModule.OpenOldSituation(vcm_ztParent, vcm_utAny, aQuery, aContainer);
//#UC END# *4F27EAB1039F_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenOldSituationCard

procedure TSearchServiceImpl.OpenPharmLegislationReview;
var
 __WasEnter : Boolean;
//#UC START# *53D771310272_4AA641A3036C_var*
const
 c_Script = ': Fill'#13#10 +
            ' OBJECT VAR l_QC'#13#10 +
            ' focused:control:push >>> l_QC'#13#10 +
            ' 1 ''AT_CLASS_REVIEW'' %s l_QC pop:QueryCard:Attribute:SetWithLogicOperation'#13#10 +
            ' ''AT_PUBLISHING_DATE'' %s l_QC pop:QueryCard:SetAttribute'#13#10 +
            ';'#13#10 +
            '@ Fill RunLegislationReviewSearch'#13#10;

 c_Class = '''Здравоохранение, образование, наука, культура, спорт и туризм\Охрана здоровья населения''';
var
 l_Date: AnsiString;
//#UC END# *53D771310272_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *53D771310272_4AA641A3036C_impl*
  l_Date := '''' + DateToStr(IncMonth(Now, -2)) + '''';
  TbsHyperLinkProcessorPrim.RunScript(Format(c_Script, [c_Class, l_Date]));
//#UC END# *53D771310272_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenPharmLegislationReview

procedure TSearchServiceImpl.OpenPharmPublishSearch;
var
 __WasEnter : Boolean;
//#UC START# *53A7FE780201_4AA641A3036C_var*
//#UC END# *53A7FE780201_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *53A7FE780201_4AA641A3036C_impl*
  TSearchModule.OpenPublishSource(0,
                    vcm_ztParent,
                    vcm_utAny,
                    nil,
                    nil,
                    nsCStr(AT_PUBLISH_SOURCE_PHARM))
//#UC END# *53A7FE780201_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenPharmPublishSearch

procedure TSearchServiceImpl.OpenSituationCard(const aQuery: IQuery);
 {* открыть ППС 6.х }
var
 __WasEnter : Boolean;
//#UC START# *4F27EA7D0011_4AA641A3036C_var*
//#UC END# *4F27EA7D0011_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4F27EA7D0011_4AA641A3036C_impl*
  TSearchModule.OpenSituation(Tfs_SituationSearch, aQuery);
//#UC END# *4F27EA7D0011_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenSituationCard

procedure TSearchServiceImpl.OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
 {* СМИ по налогам и бухучёту }
var
 __WasEnter : Boolean;
//#UC START# *4ACDF7FB02FB_4AA641A3036C_var*
//#UC END# *4ACDF7FB02FB_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ACDF7FB02FB_4AA641A3036C_impl*
 if (aPublishSearchTag = nil) then
  TSearchModule.OpenPublishSource(0,
                    vcm_ztParent,
                    vcm_utAny,
                    nil,
                    nil,
                    nsCStr('AT_PUBLISH_SOURCE_FINANCE'))
 else                   
  TSearchModule.OpenPublishSource(0,
                    vcm_ztParent,
                    vcm_utAny,
                    nil,
                    nil,
                    aPublishSearchTag);
//#UC END# *4ACDF7FB02FB_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenTaxesPublishSearch

procedure TSearchServiceImpl.PublishSourceSearch(const aQuery: IQuery;
 const aList: IDynList);
var
 __WasEnter : Boolean;
//#UC START# *4AB8A68700C7_4AA641A3036C_var*
//#UC END# *4AB8A68700C7_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB8A68700C7_4AA641A3036C_impl*
  TSearchModule.OpenPublishSource(0,
                   vcm_ztParent,
                   vcm_utAny,
                   aQuery,
                   aList,
                   nil);
//#UC END# *4AB8A68700C7_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.PublishSourceSearch

function TSearchServiceImpl.DateQuery(const aCaller: IvcmEntityForm;
 const aData: IqaDateReqDataHolder): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB8CC830075_4AA641A3036C_var*
//#UC END# *4AB8CC830075_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB8CC830075_4AA641A3036C_impl*
 Result := Ten_DefineSearchDate.Make(aData, vcmMakeParams(nil, nil, aCaller.VCLWinControl));
//#UC END# *4AB8CC830075_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.DateQuery

function TSearchServiceImpl.OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
 {* Открывает форму фильтров }
var l_MainContainer: IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB7B8D30345_4AA641A3036C_var*
//#UC END# *4AB7B8D30345_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB7B8D30345_4AA641A3036C_impl*
 TvcmDispatcher.Instance.FormDispatcher.Lock;
 try
  l_MainContainer := TCommonSearchService.Instance.MakeSaveLoadForm(vcmCheckAggregate(
                                                 vcmMakeParams(nil,
                                                           CheckContainer(nil))),
                                                vcm_ztManualModal,
                                                true,
                                                Ord(slqtFilters));
  Result := TCommonSearchService.Instance.MakeQueryCardForm(true, // IsFilter
                                        vcmMakeParams(l_MainContainer.Aggregate, l_MainContainer.AsContainer),
                                        vcm_ztAny,
                                        True,
                                        0);
  // Передадим запрос в КЗ
  if (aData <> nil) then
   op_SearchParameters_SetQuery.Call(l_MainContainer.Aggregate, aData.Query);
 finally
  TvcmDispatcher.Instance.FormDispatcher.UnLock;
 end;//try..finally
 if (l_MainContainer <> nil) AND (l_MainContainer.ZoneType = vcm_ztManualModal) then
 begin
  l_MainContainer.ShowModal;
  Result := nil;
  l_MainContainer := nil;
 end;//Result <> nil
//#UC END# *4AB7B8D30345_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenFiltersForm

function TSearchServiceImpl.OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
 {* открыть Обзор изменений законодательства }
var l_Container: IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AB77FFF008F_4AA641A3036C_var*
//#UC END# *4AB77FFF008F_4AA641A3036C_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AB77FFF008F_4AA641A3036C_impl*
 // Создание базового контейнера для КЗ
 l_Container := TCommonSearchService.Instance.MakeSaveLoadForm(vcmCheckAggregate(
                                            vcmMakeParams(nil,
                                                      CheckContainer(nil))),
                                           vcm_ztParent,
                                           True,
                                           Ord(slqtLegislationReview));

 // Создание карточки "Построение обзора законодательства"
 Result := TCommonSearchService.Instance.MakeQueryCardForm(false, // IsFilter
                                       vcmMakeParams(l_Container.Aggregate,
                                                 l_Container.AsContainer),
                                       vcm_ztParent,
                                       True,
                                       Ord(utqcLegislationReview));
 if (aQuery <> nil) then
  // Передаем запрос в форму КЗ
  op_SearchParameters_SetQuery.Call(l_Container.Aggregate, aQuery)
 else
  Op_Query_ClearAll.Call(l_Container.Aggregate, True);
//#UC END# *4AB77FFF008F_4AA641A3036C_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TSearchServiceImpl.OpenLegislationReview

class function TSearchServiceImpl.Instance: TSearchServiceImpl;
 {* Метод получения экземпляра синглетона TSearchServiceImpl }
begin
 if (g_TSearchServiceImpl = nil) then
 begin
  l3System.AddExitProc(TSearchServiceImplFree);
  g_TSearchServiceImpl := Create;
 end;
 Result := g_TSearchServiceImpl;
end;//TSearchServiceImpl.Instance

class function TSearchServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TSearchServiceImpl <> nil;
end;//TSearchServiceImpl.Exists

class function TSearchModule.DefineFilterForm(const aQuery: IQuery): TnsFilterForm;
 {* определить тип формы фильтры }
//#UC START# *4AA64AFA0360_4AA641A3036C_var*

  function lp_CheckValue(const aSettingId : PAnsiChar;
                         const aDefault   : AnsiString;
                         const aValue     : AnsiString): Boolean;
  begin
   Result := l3Same(afw.Settings.LoadString(aSettingId, aDefault), aValue);
  end;//lp_CheckValue

//#UC END# *4AA64AFA0360_4AA641A3036C_var*
begin
//#UC START# *4AA64AFA0360_4AA641A3036C_impl*
 Result := ns_ffAttributeSearch;
 // Редактироваить фильтр
 if Assigned(aQuery) then
 begin
  case aQuery.GetType of
   QT_ATTRIBUTE
   :
    Result := ns_ffAttributeSearch;
   QT_KEYWORD:
    // ППС 6.х
    if lp_CheckValue(pi_Search_SituationType,
                     dv_Search_SituationType,
                     li_NewSearch_SituationType) then
     Result := ns_ffSituation
    // ППС 5.х
    else
     Result := ns_ffOldSituation;
   QT_PUBLISHED_SOURCE:
    // ППО
    Result := ns_ffPublishSource;
   QT_BASE_SEARCH:
    // Базовый поиск
    Result := ns_ffBaseSearch;
   QT_PHARM_SEARCH:
    Result := ns_ffInpharmSearch; 
   else
    Assert(false);
  end;//case l_Filter.Query.GetType of
 end//if Assigned(aQuery) then
 // Создать новый фильтр
 else
  Result := ns_ffAttributeSearch
//#UC END# *4AA64AFA0360_4AA641A3036C_impl*
end;//TSearchModule.DefineFilterForm

class procedure TSearchModule.ShowList(aType: TnsSearchListType);
var l_List: IDynList;
//#UC START# *4AA65AA9011E_4AA641A3036C_var*
//#UC END# *4AA65AA9011E_4AA641A3036C_var*
begin
//#UC START# *4AA65AA9011E_4AA641A3036C_impl*
 l_List := nil;
 with DefDataAdapter.Search do
  case aType of
    ns_sltWithoutClass:
     GetDocumentsWithoutClass(l_List);
    ns_sltWithoutKey:
     GetDocumentsWithoutKey(l_List);
    ns_sltWithoutInluded:
     GetDocumentsWithoutIncluded(l_List);
    else
     Assert(False);
  end;//case aType of
 if l_List <> nil then
 try
  TListService.Instance.OpenList(TdeListSet.Make(l_List), nil);
 finally
  l_List := nil;
 end;//try..finally
//#UC END# *4AA65AA9011E_4AA641A3036C_impl*
end;//TSearchModule.ShowList

class function TSearchModule.CreateSearchContainer(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 aSearchType: TvcmUserType;
 aSearchInList: Boolean;
 const aList: IdeList;
 aZoneType: TvcmZoneType): IvcmEntityForm;
var l_SearchInList: Boolean;
var l_List: IdeList;

 function GetCurrentListObject: IdeList;
 var l_Form: IvcmEntityForm;
 //#UC START# *4AB7C6AF0140__var*
 //#UC END# *4AB7C6AF0140__var*
 begin
 //#UC START# *4AB7C6AF0140__impl*
  if CheckContainer(aContainer).HasForm(fm_efList.rFormID, vcm_ztParent, true, @l_Form) then
   Result := op_List_GetDeList.Call(l_Form)
  else
   Result := nil;
 //#UC END# *4AB7C6AF0140__impl*
 end;//GetCurrentListObject

//#UC START# *4AB7C62D0091_4AA641A3036C_var*
//#UC END# *4AB7C62D0091_4AA641A3036C_var*
begin
//#UC START# *4AB7C62D0091_4AA641A3036C_impl*
 l_SearchInList := aSearchInList;
 if (aList = nil) then
  l_List := GetCurrentListObject
 else
 begin
  l_List := aList;
  l_SearchInList := True;
 end;//aList = nil
 Result := TCommonSearchService.Instance.MakeSaveLoadForm(vcmMakeParams(anAggregate,
                                                CheckContainer(aContainer)),
                                      aZoneType,
                                      True,
                                      aSearchType);
 if (l_List <> nil) then
  Op_Query_SetList.Call(Result.Entity, l_List, l_SearchInList);
//#UC END# *4AB7C62D0091_4AA641A3036C_impl*
end;//TSearchModule.CreateSearchContainer

class procedure TSearchModule.OpenInpharm(anIndex: Integer;
 aZoneType: TvcmZoneType;
 aUserType: TvcmUserType;
 const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
var l_Container: IvcmEntityForm;
var l_UserType: TvcmUserType;
var l_ZoneType: TvcmZoneType;
//#UC START# *4AB7CC92001F_4AA641A3036C_var*

 procedure InpharmSearchExecute(const aParams : IvcmMakeParams;
                                aZoneType     : TvcmZoneType;
                                aUserType     : TvcmUserType);
 var
  l_Form : IvcmEntityForm;
 begin//InpharmSearchExecute
  l_Form := TCommonSearchService.Instance.MakeQueryCardForm((aUserType = slqtFilters), // IsFilter
                                        aParams,
                                        vcm_ztParent,
                                        True,
                                        utqcInpharmSearch);
  if (aZoneType <> vcm_ztManualModal) AND (aZoneType <> vcm_ztModal) then
   if afw.Settings.LoadBoolean(pi_Search_Sheets_Filters, dv_Search_Sheets_Filters) then
    TFiltersService.Instance.OldSchoolFiltersOpen(l_Form.Aggregate,
                                   l_Form.Container,
                                   l_Form.VCLWinControl);
  if (aQuery <> nil) then
   // Передаем запрос в форму КЗ
   op_SearchParameters_SetQuery.Call(l_Form.Aggregate, aQuery)
  else
   Op_Query_ClearAll.Call(l_Form.Aggregate, True);
 end;//InpharmSearchExecute
 
//#UC END# *4AB7CC92001F_4AA641A3036C_var*
begin
//#UC START# *4AB7CC92001F_4AA641A3036C_impl*
 {$IfDef vcmUseProfilers}
 ProfilersManager.QueryCard.Start;
 {$EndIf vcmUseProfilers}

  // Определим UserType
 case aUserType of
  vcm_utAny:
   l_UserType := slqtInpharmSearch;
  else
   l_UserType := aUserType;
 end;//case aUserType of
 // Определим ZoneType
 Assert(aZoneType <> vcm_ztAny);
 case aZoneType of
  vcm_ztAny:
   l_ZoneType := vcm_ztParent;
  else
   l_ZoneType := aZoneType;
 end;//case aUserType of
 // Создание базового контейнера для КЗ

 if (aList <> nil) then
  l_Container := CreateSearchContainer(vcmCheckAggregate(vcmMakeParams).Aggregate,
                                       CheckContainer(aContainer),
                                       l_UserType,
                                       True,
                                       TdeList.Make(aList),
                                       l_ZoneType)
 else
  l_Container := CreateSearchContainer(vcmCheckAggregate(vcmMakeParams).Aggregate,
                                       CheckContainer(aContainer),
                                       l_UserType,
                                       anIndex = 2,
                                       nil,
                                       l_ZoneType);
 // Создание конкретной карточки запроса
 InpharmSearchExecute(vcmMakeParams(l_Container.Aggregate,
                                l_Container.AsContainer),
                      l_ZoneType,
                      l_UserType);
 // Покажем контейнер
 if (l_ZoneType = vcm_ztManualModal) then
  l_Container.ShowModal;
//#UC END# *4AB7CC92001F_4AA641A3036C_impl*
end;//TSearchModule.OpenInpharm

class procedure TSearchModule.OpenPublishSource(anIndex: Integer;
 aZoneType: TvcmZoneType;
 aUserType: TvcmUserType;
 const aQuery: IQuery;
 const aList: IDynList;
 const aPublishSearchTag: Il3CString);
 {* Открывает карточку поиска по источнику опубликования }
var l_Params: IvcmMakeParams;
var l_Main: IvcmEntityForm;
var l_Container: IvcmEntityForm;
var l_UserType: TvcmUserType;
var l_ZoneType: TvcmZoneType;
//#UC START# *4AB87D3603B7_4AA641A3036C_var*
//#UC END# *4AB87D3603B7_4AA641A3036C_var*
begin
//#UC START# *4AB87D3603B7_4AA641A3036C_impl*
  // Определим UserType
 case aUserType of
  vcm_utAny:
   l_UserType := slqtPublishSource;
  else
   l_UserType := aUserType;
 end;//case aUserType of
 // Определим ZoneType
 case aZoneType of
  vcm_ztAny:
   l_ZoneType := vcm_ztParent;
  else
   l_ZoneType := aZoneType;
 end;//case aUserType of
 l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(nil)));
 if (aList <> nil) then
  l_Main := CreateSearchContainer(l_Params.Aggregate,
                                  l_Params.Container,
                                  l_UserType,
                                  True,
                                  TdeDocumentList.Make(aList),
                                  l_ZoneType)
 else
  l_Main := CreateSearchContainer(l_Params.Aggregate,
                                  l_Params.Container,
                                  l_UserType,
                                  anIndex = 2,
                                  nil,
                                  l_ZoneType);

 l_Params := vcmMakeParams(l_Main.Aggregate,
                       l_Main.AsContainer);

 l_Container := TLiteSearchService.Instance.MakeAttributeSelect(l_Params,
                                              vcm_ztParent,
                                              true,
                                              utSingleSearch);

 l_Params := vcmMakeParams(l_Container.Aggregate,
                       l_Container.AsContainer);
 if l3Same(aPublishSearchTag, AT_PUBLISH_SOURCE_PHARM) then
   TLiteSearchService.Instance.MakeTreeAttributeSelect(l_Params,
                                     vcm_ztAny,
                                     true,
                                     Ord(astPharmPublishSearch))
 else
 if l3Same(aPublishSearchTag, AT_PUBLISH_SOURCE) then
   TLiteSearchService.Instance.MakeTreeAttributeSelect(l_Params,
                                     vcm_ztAny,
                                     true,
                                     Ord(astTaxesPublishSearch))
 else
  TLiteSearchService.Instance.MakeTreeAttributeSelect(l_Params,
                                    vcm_ztAny,
                                    true,
                                    0);
 TLiteSearchService.Instance.MakeSelectedAttributes(l_Params, vcm_ztAny, true);

 if (l_ZoneType <> vcm_ztManualModal) and
   afw.Settings.LoadBoolean(pi_Search_Sheets_Filters, dv_Search_Sheets_Filters) then
  TFiltersService.Instance.OldSchoolFiltersOpen(l_Params.Aggregate,
                                 l_Params.Container,
                                 l_Params.Container.AsForm.VCLWinControl);
 if (aPublishSearchTag = nil) then
  Op_AttributeTree_SetRoot.Call(l_Container.Aggregate,
                                nsCStr(AT_PUBLISH_SOURCE))
 else
  Op_AttributeTree_SetRoot.Call(l_Container.Aggregate,
                                aPublishSearchTag);

 Op_AttributeTree_DropAllLogicSelection.Call(l_Container.Aggregate, true, true);
 // !^! очищаем карточку перед использованием, поскольку флаги общие

 if (aQuery <> nil) then
  op_SearchParameters_SetQuery.Call(l_Container.Aggregate, aQuery)
 else
  Op_Query_ClearAll.Call(l_Container.Aggregate, True);
 // Если редактируем фильтр, то показываем модально
 if (l_ZoneType = vcm_ztManualModal) then
  l_Main.ShowModal;
//#UC END# *4AB87D3603B7_4AA641A3036C_impl*
end;//TSearchModule.OpenPublishSource

class procedure TSearchModule.FillAllBaseListParams(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8ABF801D5_4AA641A3036C_var*

 function IsCurrentObjectList : Boolean;
 begin//IsCurrentObjectList
  if Assigned(TvcmDispatcher.Instance.FormDispatcher.CurrentMainForm) then
   Result := (TvcmDispatcher.Instance.FormDispatcher.CurrentMainForm.asContainer).HasForm(fm_efList.rFormID, vcm_ztParent, true)
  else
   Result := False;
 end;//IsCurrentObjectList

//#UC END# *4AB8ABF801D5_4AA641A3036C_var*
begin
//#UC START# *4AB8ABF801D5_4AA641A3036C_impl*
 with aParams.Op.SubItems do
  if IsCurrentObjectList then
  begin
   if (Count = 0) then
   begin
    Add(vcmCStr(str_AllDocumentSearch));
    Add(vcmCStr(str_CurListSearch));
   end;//Count = 0
  end//IsCurrentObjectList
  else
  if (Count <> 0) then
   Clear;
//#UC END# *4AB8ABF801D5_4AA641A3036C_impl*
end;//TSearchModule.FillAllBaseListParams

class procedure TSearchModule.OpenSituation(aFormSetId: RvcmFormSetFactory;
 const aQuery: IQuery);
//#UC START# *4AB8E3B301CA_4AA641A3036C_var*
var
 l_DataSource: IvcmFormSetDataSource;
//#UC END# *4AB8E3B301CA_4AA641A3036C_var*
begin
//#UC START# *4AB8E3B301CA_4AA641A3036C_impl*
 l_DataSource := TsdsSituation.Make(TdeSearch.Make(nsCStr(AT_KW), aQuery));
 aFormSetId.Make(l_DataSource,
                 CheckContainer(nil),
                 false);
 // Очищаем КЗ
 // http://mdp.garant.ru/pages/viewpage.action?pageId=235867256
 Op_AttributeTree_DropAllLogicSelection.Call(l_DataSource.FormSet, true, true);
 if (aQuery = nil) then
  Op_Query_ClearAll.Call(l_DataSource.FormSet, True);
 l_DataSource := nil;
//#UC END# *4AB8E3B301CA_4AA641A3036C_impl*
end;//TSearchModule.OpenSituation

class procedure TSearchModule.OpenOldSituation(aZoneType: TvcmZoneType;
 aUserType: TvcmUserType;
 const aQuery: IQuery;
 const aContainer: IvcmContainer);
//#UC START# *4AB8EA610164_4AA641A3036C_var*

 procedure OpenOldKeyWordSearchExecute(const aParams: IvcmMakeParams);
 var
  l_Params    : IvcmMakeParams;
  l_Container : IvcmEntityForm;
 begin//OpenOldKeyWordSearchExecute
  l_Container := TcfOldSituationSearch.MakeSingleChild(aParams.Container,
                                                   aParams,
                                                   vcm_ztParent);
  l_Params := vcmMakeParams(l_Container.Aggregate,
                        l_Container.AsContainer,
                        aParams.Owner);
  TLiteSearchService.Instance.MakeTreeAttributeSelect(l_Params,
                                    vcm_ztChild,
                                    True,
                                    Byte(astOneLevel));
  TLiteSearchService.Instance.MakeTreeAttributeSelect(l_Params,
                                    vcm_ztMain,
                                    True,
                                    Byte(astFirstLevel));
  TLiteSearchService.Instance.MakeSelectedAttributes(l_Params, vcm_ztParent, True);

  // очищаем карточку перед использованием, поскольку флаги общие
  op_AttributeTree_SetRoot.Call(l_Params.Aggregate,
                                nsCStr(AT_KW));
  Op_AttributeTree_DropAllLogicSelection.Call(l_Params.Aggregate, true, true);
  // очищаем карточку перед использованием, поскольку флаги общие
  if (aQuery <> nil) then
   // Передаем запрос в форму КЗ
   op_SearchParameters_SetQuery.Call(l_Params.Aggregate, aQuery)
  else
   Op_Query_ClearAll.Call(l_Params.Aggregate, True);
 end;//OpenOldKeyWordSearchExecute

var
 l_Container : IvcmEntityForm;
 l_UserType  : TvcmUserType;
 l_ZoneType  : TvcmZoneType;
//#UC END# *4AB8EA610164_4AA641A3036C_var*
begin
//#UC START# *4AB8EA610164_4AA641A3036C_impl*
 // Определим UserType
 case aUserType of
  vcm_utAny:
   l_UserType := slqtOldKW;
  else
   l_UserType := aUserType;
 end;//case aUserType of
 // Определим ZoneType
 case aZoneType of
  vcm_ztAny:
   l_ZoneType := vcm_ztParent;
  else
   l_ZoneType := aZoneType;
 end;//case aUserType of
 // Создание базового контейнера для КЗ
 l_Container := TCommonSearchService.Instance.MakeSaveLoadForm(vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(aContainer))),
                                           l_ZoneType,
                                           True,
                                           l_UserType);
 // Создание форм ППС 5.х
 OpenOldKeyWordSearchExecute(vcmMakeParams(l_Container.Aggregate,
                                       l_Container.AsContainer));
 // Покажем форму
 if (l_ZoneType = vcm_ztManualModal) then
  l_Container.ShowModal;
//#UC END# *4AB8EA610164_4AA641A3036C_impl*
end;//TSearchModule.OpenOldSituation

class procedure TSearchModule.OpenAttribute(anIndex: Integer;
 aZoneType: TvcmZoneType;
 aUserType: TvcmUserType;
 const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
 {* открыть ППР }
//#UC START# *4AB8FB72017D_4AA641A3036C_var*

 procedure AttributeSearchExecute(const aParams: IvcmMakeParams);
 var
  l_Form  : IvcmEntityForm;
 begin
  l_Form := TCommonSearchService.Instance.MakeQueryCardForm(false, // IsFilter
                                        aParams,
                                        vcm_ztParent,
                                        True,
                                        utqcAttributeSearch);
  if afw.Settings.LoadBoolean(pi_Search_Sheets_Filters, dv_Search_Sheets_Filters) then
   TFiltersService.Instance.OldSchoolFiltersOpen(l_Form.Aggregate,
                                  l_Form.Container,
                                  l_Form.VCLWinControl);
  if (aQuery <> nil) then
   op_SearchParameters_SetQuery.Call(l_Form.Aggregate, aQuery)
  else
   Op_Query_ClearAll.Call(l_Form.Aggregate, True);
 end;

var
 l_Params        : IvcmMakeParams;
 l_Container     : IvcmEntityForm;
 l_UserType      : TvcmUserType;
 l_ZoneType      : TvcmZoneType;
//#UC END# *4AB8FB72017D_4AA641A3036C_var*
begin
//#UC START# *4AB8FB72017D_4AA641A3036C_impl*
 {$IfDef vcmUseProfilers}
 ProfilersManager.QueryCard.Start;
 {$EndIf vcmUseProfilers}

  // Определим UserType
 case aUserType of
  vcm_utAny:
   l_UserType := slqtAttribute;
  else
   l_UserType := aUserType;
 end;//case aUserType of
 // Определим ZoneType
 case aZoneType of
  vcm_ztAny:
   l_ZoneType := vcm_ztParent;
  else
   l_ZoneType := aZoneType;
 end;//case aUserType of
 // Создание базового контейнера для КЗ
 l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(aContainer)));

 if (aList <> nil) then
  l_Container := CreateSearchContainer(l_Params.Aggregate,
                                       l_Params.Container,
                                       l_UserType,
                                       True,
                                       TdeDocumentList.Make(aList),
                                       l_ZoneType)
 else
  l_Container := CreateSearchContainer(l_Params.Aggregate,
                                       l_Params.Container,
                                       l_UserType,
                                       anIndex = 2,
                                       nil,
                                       l_ZoneType);
 // Создание конкретной карточки запроса
 AttributeSearchExecute(vcmMakeParams(l_Container.Aggregate,
                        l_Container.AsContainer,
                        l_Params.Owner));
 // Покажем контейнер
 if (l_ZoneType = vcm_ztManualModal) then
  l_Container.ShowModal;
//#UC END# *4AB8FB72017D_4AA641A3036C_impl*
end;//TSearchModule.OpenAttribute

procedure TSearchModule.opAllSearchTest(const aParams: IvcmTestParamsPrim);
 {* Поиск }
//#UC START# *4AB8C9EB0166_4AA641A3036Ctest_var*

 function MakeAvailableSearches: IvcmItems;
   {-}
 begin//MakeAvailableSearches
  if (f_SearchTypeList = nil) then
  begin
   f_SearchTypeList := TvcmItems.Make;
   f_SearchTypeList.AddOp(mod_opcode_SearchService_BaseSearch);
   f_SearchTypeList.Add('-');
   f_SearchTypeList.AddOp(mod_opcode_SearchService_AttributeSearch);
   f_SearchTypeList.AddOp(mod_opcode_SearchService_OpenKeyWordSearch);
   f_SearchTypeList.AddOp(mod_opcode_SearchService_PublishSourceSearch);
   f_SearchTypeList.AddOp(mod_opcode_MonitoringsService_OpenLegislationReview);
   f_SearchTypeList.AddOp(mod_opcode_DictionService_OpenDict);
   f_SearchTypeList.Add('-');
   f_SearchTypeList.AddOp(mod_opcode_SearchService_StartENO);
  end;//f_SearchTypeList = nil
  Result := f_SearchTypeList;
 end;//MakeAvailableSearches

var
 l_List : IvcmItems;
//#UC END# *4AB8C9EB0166_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8C9EB0166_4AA641A3036Ctest_impl*
 l_List := MakeAvailableSearches;
 aParams.Op.SubItems := l_List;
 aParams.Op.Flag[vcm_ofEnabled] := (l_List <> nil) AND (l_List.Count > 0);
//#UC END# *4AB8C9EB0166_4AA641A3036Ctest_impl*
end;//TSearchModule.opAllSearchTest

procedure TSearchModule.opAllSearchExecute(const aParams: IvcmExecuteParamsPrim);
 {* Поиск }
//#UC START# *4AB8C9EB0166_4AA641A3036Cexec_var*
//#UC END# *4AB8C9EB0166_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8C9EB0166_4AA641A3036Cexec_impl*
 // - ничего не делаем
//#UC END# *4AB8C9EB0166_4AA641A3036Cexec_impl*
end;//TSearchModule.opAllSearchExecute

procedure TSearchModule.opAttributeSearchTest(const aParams: IvcmTestParamsPrim);
 {* Поиск по реквизитам }
//#UC START# *4AB8FF1C0353_4AA641A3036Ctest_var*
//#UC END# *4AB8FF1C0353_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8FF1C0353_4AA641A3036Ctest_impl*
 FillAllBaseListParams(aParams);
//#UC END# *4AB8FF1C0353_4AA641A3036Ctest_impl*
end;//TSearchModule.opAttributeSearchTest

procedure TSearchModule.opAttributeSearchExecute(const aParams: IvcmExecuteParamsPrim);
 {* Поиск по реквизитам }
//#UC START# *4AB8FF1C0353_4AA641A3036Cexec_var*
//#UC END# *4AB8FF1C0353_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8FF1C0353_4AA641A3036Cexec_impl*
 Assert(((aParams As IvcmExecuteParams).Data = nil),
        'Пользуйтесь фабрикой TdmStsRes.AttributeSearch');
 OpenAttribute(aParams.ItemIndex, vcm_ztParent, vcm_utAny, nil, nil, nil);
//#UC END# *4AB8FF1C0353_4AA641A3036Cexec_impl*
end;//TSearchModule.opAttributeSearchExecute

procedure TSearchModule.opBaseSearchExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB8B9530325_4AA641A3036Cexec_var*
//#UC END# *4AB8B9530325_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8B9530325_4AA641A3036Cexec_impl*
 Assert((aParams As IvcmExecuteParams).Data = nil);
 TBaseSearchService.Instance.OpenBaseSearch(ns_bsokGlobal, nil);
//#UC END# *4AB8B9530325_4AA641A3036Cexec_impl*
end;//TSearchModule.opBaseSearchExecute

procedure TSearchModule.opDocumentsWithoutClassTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8B7D100EA_4AA641A3036Ctest_var*
//#UC END# *4AB8B7D100EA_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8B7D100EA_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofVisible] := afw.Application.IsInternal;
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal;
//#UC END# *4AB8B7D100EA_4AA641A3036Ctest_impl*
end;//TSearchModule.opDocumentsWithoutClassTest

procedure TSearchModule.opDocumentsWithoutClassExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB8B7D100EA_4AA641A3036Cexec_var*
//#UC END# *4AB8B7D100EA_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8B7D100EA_4AA641A3036Cexec_impl*
 ShowList(ns_sltWithoutClass);
//#UC END# *4AB8B7D100EA_4AA641A3036Cexec_impl*
end;//TSearchModule.opDocumentsWithoutClassExecute

procedure TSearchModule.opDocumentsWithoutIncludedTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8B7E501F3_4AA641A3036Ctest_var*
//#UC END# *4AB8B7E501F3_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8B7E501F3_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofVisible] := afw.Application.IsInternal;
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal;
//#UC END# *4AB8B7E501F3_4AA641A3036Ctest_impl*
end;//TSearchModule.opDocumentsWithoutIncludedTest

procedure TSearchModule.opDocumentsWithoutIncludedExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB8B7E501F3_4AA641A3036Cexec_var*
//#UC END# *4AB8B7E501F3_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8B7E501F3_4AA641A3036Cexec_impl*
 ShowList(ns_sltWithoutInluded);
//#UC END# *4AB8B7E501F3_4AA641A3036Cexec_impl*
end;//TSearchModule.opDocumentsWithoutIncludedExecute

procedure TSearchModule.opDocumentsWithoutKeyTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8B7F8006D_4AA641A3036Ctest_var*
//#UC END# *4AB8B7F8006D_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8B7F8006D_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofVisible] := afw.Application.IsInternal;
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal;
//#UC END# *4AB8B7F8006D_4AA641A3036Ctest_impl*
end;//TSearchModule.opDocumentsWithoutKeyTest

procedure TSearchModule.opDocumentsWithoutKeyExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB8B7F8006D_4AA641A3036Cexec_var*
//#UC END# *4AB8B7F8006D_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8B7F8006D_4AA641A3036Cexec_impl*
 ShowList(ns_sltWithoutKey);
//#UC END# *4AB8B7F8006D_4AA641A3036Cexec_impl*
end;//TSearchModule.opDocumentsWithoutKeyExecute

procedure TSearchModule.opInpharmSearchTest(const aParams: IvcmTestParamsPrim);
 {* Поиск лекарственных средств }
//#UC START# *4AB8AF2002B4_4AA641A3036Ctest_var*
//#UC END# *4AB8AF2002B4_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8AF2002B4_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsInpharmExists;
 FillAllBaseListParams(aParams);
//#UC END# *4AB8AF2002B4_4AA641A3036Ctest_impl*
end;//TSearchModule.opInpharmSearchTest

procedure TSearchModule.opInpharmSearchExecute(const aParams: IvcmExecuteParamsPrim);
 {* Поиск лекарственных средств }
//#UC START# *4AB8AF2002B4_4AA641A3036Cexec_var*
//#UC END# *4AB8AF2002B4_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8AF2002B4_4AA641A3036Cexec_impl*
 with (aParams As IvcmExecuteParams) do
  Assert((Data = nil));
 OpenInpharm(aParams.ItemIndex,
             vcm_ztParent,
             vcm_utAny,
             nil,
             nil,
             nil);
//#UC END# *4AB8AF2002B4_4AA641A3036Cexec_impl*
end;//TSearchModule.opInpharmSearchExecute

procedure TSearchModule.opOpenConsultTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8BA8302A8_4AA641A3036Ctest_var*
//#UC END# *4AB8BA8302A8_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8BA8302A8_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofVisible] := DefDataAdapter.HasConsultations;
 aParams.Op.Flag[vcm_ofEnabled] := aParams.Op.Flag[vcm_ofVisible];
//#UC END# *4AB8BA8302A8_4AA641A3036Ctest_impl*
end;//TSearchModule.opOpenConsultTest

procedure TSearchModule.opOpenConsultExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB8BA8302A8_4AA641A3036Cexec_var*
//#UC END# *4AB8BA8302A8_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8BA8302A8_4AA641A3036Cexec_impl*
 TConsultationService.Instance.OpenSendConsultation(nil);
//#UC END# *4AB8BA8302A8_4AA641A3036Cexec_impl*
end;//TSearchModule.opOpenConsultExecute

procedure TSearchModule.opPublishSourceSearchTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8A97D01BF_4AA641A3036Ctest_var*
//#UC END# *4AB8A97D01BF_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8A97D01BF_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsExists_PublishSourceTag;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
 FillAllBaseListParams(aParams);
//#UC END# *4AB8A97D01BF_4AA641A3036Ctest_impl*
end;//TSearchModule.opPublishSourceSearchTest

procedure TSearchModule.opPublishSourceSearchExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB8A97D01BF_4AA641A3036Cexec_var*
//#UC END# *4AB8A97D01BF_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8A97D01BF_4AA641A3036Cexec_impl*
 with (aParams As IvcmExecuteParams) do
  Assert((Data = nil));
 OpenPublishSource(aParams.ItemIndex, vcm_ztParent, vcm_utAny, nil, nil, nil);
//#UC END# *4AB8A97D01BF_4AA641A3036Cexec_impl*
end;//TSearchModule.opPublishSourceSearchExecute

procedure TSearchModule.opStartENOTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8B29F0256_4AA641A3036Ctest_var*
//#UC END# *4AB8B29F0256_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8B29F0256_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsENOEnabled;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4AB8B29F0256_4AA641A3036Ctest_impl*
end;//TSearchModule.opStartENOTest

procedure TSearchModule.opStartENOExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AB8B29F0256_4AA641A3036Cexec_var*
const
 c_StartEnoLink = 'Start.ger';
//#UC END# *4AB8B29F0256_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8B29F0256_4AA641A3036Cexec_impl*
 nsProcessENOLink(nsCStr(c_StartEnoLink));
//#UC END# *4AB8B29F0256_4AA641A3036Cexec_impl*
end;//TSearchModule.opStartENOExecute

procedure TSearchModule.opOpenKeyWordSearchTest(const aParams: IvcmTestParamsPrim);
 {* Поиск по ситуации }
//#UC START# *4AB8F0B00149_4AA641A3036Ctest_var*
//#UC END# *4AB8F0B00149_4AA641A3036Ctest_var*
begin
//#UC START# *4AB8F0B00149_4AA641A3036Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsExists_KeyWordTag;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4AB8F0B00149_4AA641A3036Ctest_impl*
end;//TSearchModule.opOpenKeyWordSearchTest

procedure TSearchModule.opOpenKeyWordSearchExecute(const aParams: IvcmExecuteParamsPrim);
 {* Поиск по ситуации }
//#UC START# *4AB8F0B00149_4AA641A3036Cexec_var*
//#UC END# *4AB8F0B00149_4AA641A3036Cexec_var*
begin
//#UC START# *4AB8F0B00149_4AA641A3036Cexec_impl*
 TSearchService.Instance.OpenKeyWord(nil, nil);
//#UC END# *4AB8F0B00149_4AA641A3036Cexec_impl*
end;//TSearchModule.opOpenKeyWordSearchExecute

procedure TSearchModule.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AA641A3036C_var*
//#UC END# *479731C50290_4AA641A3036C_var*
begin
//#UC START# *479731C50290_4AA641A3036C_impl*
 f_SearchTypeList := nil;
 inherited;
//#UC END# *479731C50290_4AA641A3036C_impl*
end;//TSearchModule.Cleanup

procedure TSearchModule.Loaded;
begin
 inherited;
 PublishOp('opAllSearch', opAllSearchExecute, opAllSearchTest);
 PublishOp('opAttributeSearch', opAttributeSearchExecute, opAttributeSearchTest);
 PublishOp('opBaseSearch', opBaseSearchExecute, nil);
 PublishOp('opDocumentsWithoutClass', opDocumentsWithoutClassExecute, opDocumentsWithoutClassTest);
 PublishOp('opDocumentsWithoutIncluded', opDocumentsWithoutIncludedExecute, opDocumentsWithoutIncludedTest);
 PublishOp('opDocumentsWithoutKey', opDocumentsWithoutKeyExecute, opDocumentsWithoutKeyTest);
 PublishOp('opInpharmSearch', opInpharmSearchExecute, opInpharmSearchTest);
 PublishOp('opOpenConsult', opOpenConsultExecute, opOpenConsultTest);
 PublishOp('opPublishSourceSearch', opPublishSourceSearchExecute, opPublishSourceSearchTest);
 PublishOp('opStartENO', opStartENOExecute, opStartENOTest);
 PublishOp('opOpenKeyWordSearch', opOpenKeyWordSearchExecute, opOpenKeyWordSearchTest);
end;//TSearchModule.Loaded

class procedure TSearchModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(Ten_DefineSearchDate);
 aList.Add(TcfOldSituationSearch);
 aList.Add(TefTreeAttributeFirstLevel);
end;//TSearchModule.GetEntityForms

initialization
 TSearchService.Instance.Alien := TSearchServiceImpl.Instance;
 {* Регистрация TSearchServiceImpl }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSearchModule);
 {* Регистрация Search }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
