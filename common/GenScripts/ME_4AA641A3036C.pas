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
 , SearchUnit
 , DynamicDocListUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SimpleListInterfaces
 , bsTypes
 , PrimPrimListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , nsQueryInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TSearchModule = class(TvcmModule)
  {* Поиск }
  private
   f_SearchTypeList: IvcmItems;
  protected
   function DefineFilterForm(const aQuery: IQuery): TnsFilterForm;
    {* определить тип формы фильтры }
   procedure ShowList(aType: TnsSearchListType);
   class function CreateSearchContainer(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    aSearchType: TvcmUserType;
    aSearchInList: Boolean;
    const aList: IdeList;
    aZoneType: TvcmZoneType): IvcmEntityForm;
   procedure OpenInpharm(anIndex: Integer;
    aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
   procedure OpenPublishSource(anIndex: Integer;
    aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aList: IDynList;
    const aPublishSearchTag: Il3CString);
    {* Открывает карточку поиска по источнику опубликования }
   procedure PublishSourceSearch; overload;
   procedure FillAllBaseListParams(const aParams: IvcmTestParamsPrim);
   procedure InpharmSearch; overload;
    {* Поиск лекарственных средств }
   procedure StartENO;
   procedure DocumentsWithoutClass;
   procedure DocumentsWithoutIncluded;
   procedure DocumentsWithoutKey;
   procedure BaseSearch;
   procedure OpenConsult;
   procedure AllSearch;
    {* Поиск }
   procedure OpenSituation(aFormSetId: RvcmFormSetFactory;
    const aQuery: IQuery);
   procedure OpenOldSituation(aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aContainer: IvcmContainer);
   procedure OpenKeyWordSearch;
    {* Поиск по ситуации }
   procedure OpenAttribute(anIndex: Integer;
    aZoneType: TvcmZoneType;
    aUserType: TvcmUserType;
    const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
    {* открыть ППР }
   procedure AttributeSearch; overload;
    {* Поиск по реквизитам }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure OpenLegislationReview(const aQuery: IQuery);
    {* открыть Обзор изменений законодательства }
   procedure OpenFiltersForm(const aData: IdeFilter);
    {* Открывает форму фильтров }
   procedure MakeNewFilter(aListType: TbsListType);
    {* Вызывает форму создания нового фильтра }
   procedure InpharmSearch(const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer); overload;
    {* Поиск лекарственных средств }
   procedure PublishSourceSearch(const aQuery: IQuery;
    const aList: IDynList); overload;
   procedure DateQuery(const aCaller: IvcmEntityForm;
    const aData: IqaDateReqDataHolder);
   procedure OpenKeyWord(const aQuery: IQuery;
    const aContainer: IvcmContainer);
    {* открыть ППС }
   procedure EditFilter(const aFilter: IdeFilter;
    anItemIndex: Integer);
    {* Редактироваить фильтр }
   procedure AttributeSearch(const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer); overload;
   procedure OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
    {* СМИ по налогам и бухучёту }
   procedure OpenSituationCard(const aQuery: IQuery);
    {* открыть ППС 6.х }
   procedure OpenOldSituationCard(const aQuery: IQuery;
    const aContainer: IvcmContainer);
    {* открыть ППС 5.х }
   procedure OpenPharmPublishSearch;
   procedure OpenPharmLegislationReview;
 end;//TSearchModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
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
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConst
 , l3String
 , afwFacade
 , DataAdapter
 , deListSet
 , nsManagers
 , deList
 , nsTypes
 , deDocumentList
 , nsENOIntegration
 {$If NOT Defined(NoVCM)}
 , vcmItems
 {$IfEnd} // NOT Defined(NoVCM)
 , deSearch
 , sdsSituation
 , DynamicTreeUnit
 , bsHyperLinkProcessorPrim
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 , Base_Operations_Strange_Controls
;

{$If NOT Defined(NoVCM)}
function TSearchModule.DefineFilterForm(const aQuery: IQuery): TnsFilterForm;
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
(*   QT_OLD_FILTER:
    Result := ns_ffAttributeSearch;*)
   QT_ATTRIBUTE
(*   ,
   QT_OLD_ATTRIBUTE*)
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

procedure TSearchModule.ShowList(aType: TnsSearchListType);
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
  TdmStdRes.OpenList(TdeListSet.Make(l_List), nil);
 finally
  l_List := nil;
 end;//try..finally
//#UC END# *4AA65AA9011E_4AA641A3036C_impl*
end;//TSearchModule.ShowList

procedure TSearchModule.OpenLegislationReview(const aQuery: IQuery);
 {* открыть Обзор изменений законодательства }
var l_Container: IvcmEntityForm;
//#UC START# *4AB77FFF008F_4AA641A3036C_var*
//#UC END# *4AB77FFF008F_4AA641A3036C_var*
begin
//#UC START# *4AB77FFF008F_4AA641A3036C_impl*
 // Создание базового контейнера для КЗ
 l_Container := TdmStdRes.MakeSaveLoadForm(vcmCheckAggregate(
                                            vcmMakeParams(nil,
                                                      CheckContainer(nil))),
                                           vcm_ztParent,
                                           True,
                                           Ord(slqtLegislationReview));

 // Создание карточки "Построение обзора законодательства"
 Result := TdmStdRes.MakeQueryCardForm(false, // IsFilter
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
end;//TSearchModule.OpenLegislationReview

procedure TSearchModule.OpenFiltersForm(const aData: IdeFilter);
 {* Открывает форму фильтров }
var l_MainContainer: IvcmEntityForm;
//#UC START# *4AB7B8D30345_4AA641A3036C_var*
//#UC END# *4AB7B8D30345_4AA641A3036C_var*
begin
//#UC START# *4AB7B8D30345_4AA641A3036C_impl*
 vcmDispatcher.FormDispatcher.Lock;
 try
  l_MainContainer := TdmStdRes.MakeSaveLoadForm(vcmCheckAggregate(
                                                 vcmMakeParams(nil,
                                                           CheckContainer(nil))),
                                                vcm_ztManualModal,
                                                true,
                                                Ord(slqtFilters));
  Result := TdmStdRes.MakeQueryCardForm(true, // IsFilter
                                        vcmMakeParams(l_MainContainer.Aggregate,
                                                  l_MainContainer.AsContainer),
                                        vcm_ztAny,
                                        True,
                                        0);
  // Передадим запрос в КЗ
  if (aData <> nil) then
   op_SearchParameters_SetQuery.Call(l_MainContainer.Aggregate, aData.Query);
 finally
  vcmDispatcher.FormDispatcher.UnLock;
 end;//try..finally
 if (l_MainContainer <> nil) AND (l_MainContainer.ZoneType = vcm_ztManualModal) then
 begin
  l_MainContainer.ShowModal;
  Result := nil;
  l_MainContainer := nil;
 end;//Result <> nil
//#UC END# *4AB7B8D30345_4AA641A3036C_impl*
end;//TSearchModule.OpenFiltersForm

procedure TSearchModule.MakeNewFilter(aListType: TbsListType);
 {* Вызывает форму создания нового фильтра }
//#UC START# *4AB7BFE700D2_4AA641A3036C_var*
//#UC END# *4AB7BFE700D2_4AA641A3036C_var*
begin
//#UC START# *4AB7BFE700D2_4AA641A3036C_impl*
 Case aListType of
  bs_ltNone:
   Assert(false);
  bs_ltDocument:
   OpenFiltersForm(nil);
  bs_ltDrug:
   OpenInpharm(0,
               vcm_ztManualModal,
               slqtFilters,
               nil,
               nil,
               nil);
  else
   Assert(false);
 end;//Case aListType
//#UC END# *4AB7BFE700D2_4AA641A3036C_impl*
end;//TSearchModule.MakeNewFilter

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
 Result := TdmStdRes.MakeSaveLoadForm(vcmMakeParams(anAggregate,
                                                CheckContainer(aContainer)),
                                      aZoneType,
                                      True,
                                      aSearchType);
 if (l_List <> nil) then
  Op_Query_SetList.Call(Result.Entity, l_List, l_SearchInList);
//#UC END# *4AB7C62D0091_4AA641A3036C_impl*
end;//TSearchModule.CreateSearchContainer

procedure TSearchModule.OpenInpharm(anIndex: Integer;
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
  l_Form := TdmStdRes.MakeQueryCardForm((aUserType = slqtFilters), // IsFilter
                                        aParams,
                                        vcm_ztParent,
                                        True,
                                        utqcInpharmSearch);
  if (aZoneType <> vcm_ztManualModal) AND (aZoneType <> vcm_ztModal) then
   if afw.Settings.LoadBoolean(pi_Search_Sheets_Filters, dv_Search_Sheets_Filters) then
    TdmStdRes.OldSchoolFiltersOpen(l_Form.Aggregate,
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

procedure TSearchModule.InpharmSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
 {* Поиск лекарственных средств }
//#UC START# *4AB7D4340301_4AA641A3036C_var*
//#UC END# *4AB7D4340301_4AA641A3036C_var*
begin
//#UC START# *4AB7D4340301_4AA641A3036C_impl*
 OpenInpharm(0,
             vcm_ztParent,
             vcm_utAny,
             aQuery,
             aList,
             aContainer);
//#UC END# *4AB7D4340301_4AA641A3036C_impl*
end;//TSearchModule.InpharmSearch

procedure TSearchModule.OpenPublishSource(anIndex: Integer;
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

 l_Container := TdmStdRes.MakeAttributeSelect(l_Params,
                                              vcm_ztParent,
                                              true,
                                              utSingleSearch);

 l_Params := vcmMakeParams(l_Container.Aggregate,
                       l_Container.AsContainer);
 if l3Same(aPublishSearchTag, AT_PUBLISH_SOURCE_PHARM) then
   TdmStdRes.MakeTreeAttributeSelect(l_Params,
                                     vcm_ztAny,
                                     true,
                                     Ord(astPharmPublishSearch))
 else
 if l3Same(aPublishSearchTag, AT_PUBLISH_SOURCE) then
   TdmStdRes.MakeTreeAttributeSelect(l_Params,
                                     vcm_ztAny,
                                     true,
                                     Ord(astTaxesPublishSearch))
 else
  TdmStdRes.MakeTreeAttributeSelect(l_Params,
                                    vcm_ztAny,
                                    true,
                                    0);
 TdmStdRes.MakeSelectedAttributes(l_Params, vcm_ztAny, true);

 if (l_ZoneType <> vcm_ztManualModal) and
   afw.Settings.LoadBoolean(pi_Search_Sheets_Filters, dv_Search_Sheets_Filters) then
  TdmStdRes.OldSchoolFiltersOpen(l_Params.Aggregate,
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

procedure TSearchModule.PublishSourceSearch(const aQuery: IQuery;
 const aList: IDynList);
//#UC START# *4AB8A68700C7_4AA641A3036C_var*
//#UC END# *4AB8A68700C7_4AA641A3036C_var*
begin
//#UC START# *4AB8A68700C7_4AA641A3036C_impl*
 OpenPublishSource(0,
                   vcm_ztParent,
                   vcm_utAny,
                   aQuery,
                   aList,
                   nil);
//#UC END# *4AB8A68700C7_4AA641A3036C_impl*
end;//TSearchModule.PublishSourceSearch

procedure TSearchModule.PublishSourceSearch;
//#UC START# *4AB8A97D01BF_4AA641A3036C_var*
//#UC END# *4AB8A97D01BF_4AA641A3036C_var*
begin
//#UC START# *4AB8A97D01BF_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8A97D01BF_4AA641A3036C_impl*
end;//TSearchModule.PublishSourceSearch

procedure TSearchModule.FillAllBaseListParams(const aParams: IvcmTestParamsPrim);
//#UC START# *4AB8ABF801D5_4AA641A3036C_var*

 function IsCurrentObjectList : Boolean;
 begin//IsCurrentObjectList
  if Assigned(g_Dispatcher.FormDispatcher.CurrentMainForm) then
   Result := (g_Dispatcher.FormDispatcher.CurrentMainForm.asContainer)
              .HasForm(fm_efList.rFormID, vcm_ztParent, true)
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

procedure TSearchModule.InpharmSearch;
 {* Поиск лекарственных средств }
//#UC START# *4AB8AF2002B4_4AA641A3036C_var*
//#UC END# *4AB8AF2002B4_4AA641A3036C_var*
begin
//#UC START# *4AB8AF2002B4_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8AF2002B4_4AA641A3036C_impl*
end;//TSearchModule.InpharmSearch

procedure TSearchModule.StartENO;
//#UC START# *4AB8B29F0256_4AA641A3036C_var*
//#UC END# *4AB8B29F0256_4AA641A3036C_var*
begin
//#UC START# *4AB8B29F0256_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8B29F0256_4AA641A3036C_impl*
end;//TSearchModule.StartENO

procedure TSearchModule.DocumentsWithoutClass;
//#UC START# *4AB8B7D100EA_4AA641A3036C_var*
//#UC END# *4AB8B7D100EA_4AA641A3036C_var*
begin
//#UC START# *4AB8B7D100EA_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8B7D100EA_4AA641A3036C_impl*
end;//TSearchModule.DocumentsWithoutClass

procedure TSearchModule.DocumentsWithoutIncluded;
//#UC START# *4AB8B7E501F3_4AA641A3036C_var*
//#UC END# *4AB8B7E501F3_4AA641A3036C_var*
begin
//#UC START# *4AB8B7E501F3_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8B7E501F3_4AA641A3036C_impl*
end;//TSearchModule.DocumentsWithoutIncluded

procedure TSearchModule.DocumentsWithoutKey;
//#UC START# *4AB8B7F8006D_4AA641A3036C_var*
//#UC END# *4AB8B7F8006D_4AA641A3036C_var*
begin
//#UC START# *4AB8B7F8006D_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8B7F8006D_4AA641A3036C_impl*
end;//TSearchModule.DocumentsWithoutKey

procedure TSearchModule.BaseSearch;
//#UC START# *4AB8B9530325_4AA641A3036C_var*
//#UC END# *4AB8B9530325_4AA641A3036C_var*
begin
//#UC START# *4AB8B9530325_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8B9530325_4AA641A3036C_impl*
end;//TSearchModule.BaseSearch

procedure TSearchModule.OpenConsult;
//#UC START# *4AB8BA8302A8_4AA641A3036C_var*
//#UC END# *4AB8BA8302A8_4AA641A3036C_var*
begin
//#UC START# *4AB8BA8302A8_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8BA8302A8_4AA641A3036C_impl*
end;//TSearchModule.OpenConsult

procedure TSearchModule.AllSearch;
 {* Поиск }
//#UC START# *4AB8C9EB0166_4AA641A3036C_var*
//#UC END# *4AB8C9EB0166_4AA641A3036C_var*
begin
//#UC START# *4AB8C9EB0166_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8C9EB0166_4AA641A3036C_impl*
end;//TSearchModule.AllSearch

procedure TSearchModule.DateQuery(const aCaller: IvcmEntityForm;
 const aData: IqaDateReqDataHolder);
//#UC START# *4AB8CC830075_4AA641A3036C_var*
//#UC END# *4AB8CC830075_4AA641A3036C_var*
begin
//#UC START# *4AB8CC830075_4AA641A3036C_impl*
 Result := Ten_DefineSearchDate.Make(aData, vcmMakeParams(nil, nil, aCaller.VCLWinControl));
//#UC END# *4AB8CC830075_4AA641A3036C_impl*
end;//TSearchModule.DateQuery

procedure TSearchModule.OpenSituation(aFormSetId: RvcmFormSetFactory;
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

procedure TSearchModule.OpenOldSituation(aZoneType: TvcmZoneType;
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
  TdmStdRes.MakeTreeAttributeSelect(l_Params,
                                    vcm_ztChild,
                                    True,
                                    Byte(astOneLevel));
  TdmStdRes.MakeTreeAttributeSelect(l_Params,
                                    vcm_ztMain,
                                    True,
                                    Byte(astFirstLevel));
  TdmStdRes.MakeSelectedAttributes(l_Params, vcm_ztParent, True);

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
 l_Container := TdmStdRes.MakeSaveLoadForm(vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(aContainer))),
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

procedure TSearchModule.OpenKeyWord(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* открыть ППС }
//#UC START# *4AB8EF3B0310_4AA641A3036C_var*
//#UC END# *4AB8EF3B0310_4AA641A3036C_var*
begin
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
end;//TSearchModule.OpenKeyWord

procedure TSearchModule.OpenKeyWordSearch;
 {* Поиск по ситуации }
//#UC START# *4AB8F0B00149_4AA641A3036C_var*
//#UC END# *4AB8F0B00149_4AA641A3036C_var*
begin
//#UC START# *4AB8F0B00149_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8F0B00149_4AA641A3036C_impl*
end;//TSearchModule.OpenKeyWordSearch

procedure TSearchModule.EditFilter(const aFilter: IdeFilter;
 anItemIndex: Integer);
 {* Редактироваить фильтр }
//#UC START# *4AB8F2DC01A3_4AA641A3036C_var*
//#UC END# *4AB8F2DC01A3_4AA641A3036C_var*
begin
//#UC START# *4AB8F2DC01A3_4AA641A3036C_impl*
 // Редактироваить фильтр
 if (aFilter <> nil) AND (aFilter.Query <> nil) then
 begin
  case DefineFilterForm(aFilter.Query) of
   ns_ffAttributeSearch:
    OpenFiltersForm(aFilter);
   ns_ffPublishSource:
    OpenPublishSource(anItemIndex,
                      vcm_ztManualModal,
                      slqtFilters,
                      aFilter.Query,
                      nil,
                      nil);
   ns_ffSituation:
    OpenSituation(Tfs_SituationFilter,
                  aFilter.Query);
   ns_ffOldSituation:
    OpenOldSituation(vcm_ztManualModal,
                     slqtFilters,
                     aFilter.Query,
                     nil);
   ns_ffBaseSearch:
    TdmStdRes.OpenBaseSearch(ns_bsokGlobal, aFilter.Query);
   ns_ffInpharmSearch:
    OpenInpharm(anItemIndex,
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
  Assert(false, 'Пользуйтесь фабрикой TdmStdRes.MakeNewFilter');
//#UC END# *4AB8F2DC01A3_4AA641A3036C_impl*
end;//TSearchModule.EditFilter

procedure TSearchModule.OpenAttribute(anIndex: Integer;
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
  l_Form := TdmStdRes.MakeQueryCardForm(false, // IsFilter
                                        aParams,
                                        vcm_ztParent,
                                        True,
                                        utqcAttributeSearch);
  if afw.Settings.LoadBoolean(pi_Search_Sheets_Filters, dv_Search_Sheets_Filters) then
   TdmStdRes.OldSchoolFiltersOpen(l_Form.Aggregate,
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

procedure TSearchModule.AttributeSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
//#UC START# *4AB8FBBA016C_4AA641A3036C_var*
//#UC END# *4AB8FBBA016C_4AA641A3036C_var*
begin
//#UC START# *4AB8FBBA016C_4AA641A3036C_impl*
 OpenAttribute(0,
               vcm_ztParent,
               vcm_utAny,
               aQuery,
               aList,
               aContainer);
//#UC END# *4AB8FBBA016C_4AA641A3036C_impl*
end;//TSearchModule.AttributeSearch

procedure TSearchModule.AttributeSearch;
 {* Поиск по реквизитам }
//#UC START# *4AB8FF1C0353_4AA641A3036C_var*
//#UC END# *4AB8FF1C0353_4AA641A3036C_var*
begin
//#UC START# *4AB8FF1C0353_4AA641A3036C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB8FF1C0353_4AA641A3036C_impl*
end;//TSearchModule.AttributeSearch

procedure TSearchModule.OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
 {* СМИ по налогам и бухучёту }
//#UC START# *4ACDF7FB02FB_4AA641A3036C_var*
//#UC END# *4ACDF7FB02FB_4AA641A3036C_var*
begin
//#UC START# *4ACDF7FB02FB_4AA641A3036C_impl*
 if (aPublishSearchTag = nil) then
  OpenPublishSource(0,
                    vcm_ztParent,
                    vcm_utAny,
                    nil,
                    nil,
                    nsCStr('AT_PUBLISH_SOURCE_FINANCE'))
 else                   
  OpenPublishSource(0,
                    vcm_ztParent,
                    vcm_utAny,
                    nil,
                    nil,
                    aPublishSearchTag);
//#UC END# *4ACDF7FB02FB_4AA641A3036C_impl*
end;//TSearchModule.OpenTaxesPublishSearch

procedure TSearchModule.OpenSituationCard(const aQuery: IQuery);
 {* открыть ППС 6.х }
//#UC START# *4F27EA7D0011_4AA641A3036C_var*
//#UC END# *4F27EA7D0011_4AA641A3036C_var*
begin
//#UC START# *4F27EA7D0011_4AA641A3036C_impl*
 OpenSituation(Tfs_SituationSearch, aQuery);
//#UC END# *4F27EA7D0011_4AA641A3036C_impl*
end;//TSearchModule.OpenSituationCard

procedure TSearchModule.OpenOldSituationCard(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* открыть ППС 5.х }
//#UC START# *4F27EAB1039F_4AA641A3036C_var*
//#UC END# *4F27EAB1039F_4AA641A3036C_var*
begin
//#UC START# *4F27EAB1039F_4AA641A3036C_impl*
 OpenOldSituation(vcm_ztParent, vcm_utAny, aQuery, aContainer);
//#UC END# *4F27EAB1039F_4AA641A3036C_impl*
end;//TSearchModule.OpenOldSituationCard

procedure TSearchModule.OpenPharmPublishSearch;
//#UC START# *53A7FE780201_4AA641A3036C_var*
//#UC END# *53A7FE780201_4AA641A3036C_var*
begin
//#UC START# *53A7FE780201_4AA641A3036C_impl*
  OpenPublishSource(0,
                    vcm_ztParent,
                    vcm_utAny,
                    nil,
                    nil,
                    nsCStr(AT_PUBLISH_SOURCE_PHARM))
//#UC END# *53A7FE780201_4AA641A3036C_impl*
end;//TSearchModule.OpenPharmPublishSearch

procedure TSearchModule.OpenPharmLegislationReview;
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
//#UC START# *53D771310272_4AA641A3036C_impl*
  l_Date := '''' + DateToStr(IncMonth(Now, -2)) + '''';
  TbsHyperLinkProcessorPrim.RunScript(Format(c_Script, [c_Class, l_Date]));
//#UC END# *53D771310272_4AA641A3036C_impl*
end;//TSearchModule.OpenPharmLegislationReview

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
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
