unit nsStringValueMapFactory;
{* реализация менеджера мап "строка"-"строка" }

{$Include nsDefine.inc }

interface

uses
 l3ProtoObject,

 L10nInterfaces
 ;

type
 TnsStringValueMapFactory = class(Tl3ProtoObject, InsStringValueMapFactory)
 private
  function MakeMap(const aID: TnsValueMapID): InsValueMap;
 public
  class function Make: InsStringValueMapFactory;
 end;//TnsStringValueMapFactory

implementation

uses
 nsValueMapsIDs,
 nsStringValueMap,
 nsPictureScaleMap,
 nsCRTypeStringValueMap,
 nsLanguageMap,
 nsSettingsConst,
 nsSettings,
 nsConst,

 StdRes,
 SystemStr,

 DynamicTreeUnit,
 nsTextWithCommentsRes,
 nsStringValueMapFactoryRes,
 {$If not (defined(Monitorings) or defined(Admin))}
 vcmTabbedContainerRes,
 {$IfEnd not (defined(Monitorings) or defined(Admin))}
 afwFacade,
 afwInterfaces
 ;

{ TnsStringValueMapManager }

class function TnsStringValueMapFactory.Make: InsStringValueMapFactory;
var
 l_Fac: TnsStringValueMapFactory;
begin
 l_Fac := Create;
 try
  Result := l_Fac;
 finally
  l_Fac.Free;
 end;
end;

function TnsStringValueMapFactory.MakeMap(const aID: TnsValueMapID): InsValueMap;
type
 TnsStringValueMapRecordArray = array of TnsStringValueMapRecord;

 function lp_MakeValuesArray(const aValues: array of TnsStringValueMapRecord): TnsStringValueMapRecordArray;
 var
  l_Index: Integer;
 begin
  SetLength(Result, Length(aValues));
  for l_Index := Low(aValues) to High(aValues) do
   Result[l_Index] := aValues[l_Index];
 end;

 function lp_CatArrays(const aSrcValues: TnsStringValueMapRecordArray;
  const aValuesToAppend: TnsStringValueMapRecordArray): TnsStringValueMapRecordArray;
 var
  l_Index: Integer;
  l_SrcArrLen: Integer;
  l_AppArrLen: Integer;
 begin
  l_SrcArrLen := Succ(High(aSrcValues));
  l_AppArrLen := Succ(High(aValuesToAppend));
  SetLength(Result, l_SrcArrLen + l_AppArrLen);
  for l_Index := 0 to Pred(l_SrcArrLen) do
   Result[l_Index] := aSrcValues[l_Index];
  for l_Index := 0 to Pred(l_AppArrLen) do
   Result[l_SrcArrLen + l_Index] := aValuesToAppend[l_Index];
 end;//lp_ConcatArrays

var
 l_CommonOpenOnStartValues: TnsStringValueMapRecordArray;
 l_RussianOpenOnStartValues: TnsStringValueMapRecordArray;
 l_ResultOpenOnStartValues: TnsStringValueMapRecordArray;
begin
 {$If not (defined(Monitorings) or defined(Admin))}
// Настройки - их видимое представление для редактирования
 if aID.rID = smap_Settings.rID then
 begin
  Result := TnsStringValueMap.Make(smap_Settings,
   [nsStringValueMapRecord(str_pi_IfaceLanguage, pi_IfaceLanguage),
    nsStringValueMapRecord(str_pi_Document_PermanentSelection, pi_Document_PermanentSelection),
    nsStringValueMapRecord(str_pi_BaseSearch_BuildShortList, pi_BaseSearch_BuildShortList),
    nsStringValueMapRecord(str_pi_ActivateDefaultLanguage, pi_ActivateDefaultLanguage),
    nsStringValueMapRecord(str_pi_NavigatorAutoHideFloat, pi_lnAutoHideFloat),
    nsStringValueMapRecord(str_pi_NavigatorAutoHideFloat, pi_rnAutoHideFloat),
    nsStringValueMapRecord(str_pi_RecentlyOpenDocumentsCount, pi_RecentlyOpenDocumentsCount),
    nsStringValueMapRecord(str_piHistoryItems, piHistoryItems),
    nsStringValueMapRecord(str_pi_WorkJournalSize, pi_WorkJournalSize),
    nsStringValueMapRecord(str_pi_OpenOnStart, pi_OpenOnStart),
    nsStringValueMapRecord(str_pi_Sheets_MainMenu, pi_Sheets_MainMenu),
    nsStringValueMapRecord(str_pi_Sheets_MyDocuments, pi_Sheets_MyDocuments),
    nsStringValueMapRecord(str_pi_Sheets_Config, pi_Sheets_Config),
    nsStringValueMapRecord(str_piSheetsDocUnderControl, piSheetsDocUnderControl),
    nsStringValueMapRecord(str_piSheetsTaskPanel, piSheetsTaskPanel),
    nsStringValueMapRecord(str_pi_DayTips_DontShowAtStart, pi_DayTips_DontShowAtStart),
    nsStringValueMapRecord(str_pi_PlayBeepOnMistake, pi_PlayBeepOnMistake),
    nsStringValueMapRecord(str_pi_Search_Sheets_Filters, pi_Search_Sheets_Filters),
    nsStringValueMapRecord(str_pi_List_Sheets_Filters, pi_List_Sheets_Filters),
    nsStringValueMapRecord(str_pi_Search_SituationType, pi_Search_SituationType),
    nsStringValueMapRecord(str_pi_Search_List_IsBuild, pi_Search_List_IsBuild),
    nsStringValueMapRecord(str_pi_Search_List_BuildCount, pi_Search_List_BuildCount),
    nsStringValueMapRecord(str_piSearchListIsBuildReview, piSearchListIsBuildReview),
    nsStringValueMapRecord(str_piSearchListBuildCountReview, piSearchListBuildCountReview),
    nsStringValueMapRecord(str_pi_List_SortType, pi_List_SortType),
    nsStringValueMapRecord(str_pi_List_OrderType, pi_List_OrderType),
    nsStringValueMapRecord(str_pi_List_AutoTransfer, pi_List_AutoTransfer),
    nsStringValueMapRecord(str_pi_Document_Warning, pi_Document_Warning),
    nsStringValueMapRecord(str_pi_Document_Sheets_Attributes, pi_Document_Sheets_Attributes),
    nsStringValueMapRecord(str_pi_Document_Sheets_Translation, pi_Document_Sheets_Translation),
    nsStringValueMapRecord(str_piDocumentPictureScale, piDocumentPictureScale),
    nsStringValueMapRecord(str_pi_Document_CRSheet0, pi_Document_CRSheet0),
    nsStringValueMapRecord(str_pi_Document_CRType0, pi_Document_CRType0),
    nsStringValueMapRecord(str_pi_Document_CRSheet1, pi_Document_CRSheet1),
    nsStringValueMapRecord(str_pi_Document_CRType1, pi_Document_CRType1),
    nsStringValueMapRecord(str_pi_Document_Sheets_Redactions, pi_Document_Sheets_Redactions),
    nsStringValueMapRecord(str_pi_DropChangeStatus, pi_DropChangeStatus),
    nsStringValueMapRecord(str_pi_DocumentList_PrintOnlyFirstLevel, pi_DocumentList_PrintOnlyFirstLevel),
    nsStringValueMapRecord(str_pi_DrugList_PrintOnlyFirstLevel, pi_DrugList_PrintOnlyFirstLevel),
    nsStringValueMapRecord(str_pi_List_ShowAnnotationByDefault, pi_List_ShowAnnotationByDefault),
    nsStringValueMapRecord(str_pi_Document_SubPanel_ShowBlocks, pi_Document_SubPanel_ShowBlocks),
    nsStringValueMapRecord(str_pi_Document_SubPanel_ShowBookmarks, pi_Document_SubPanel_ShowBookmarks),
    nsStringValueMapRecord(str_pi_Document_SubPanel_ShowJurorComments, pi_Document_SubPanel_ShowJurorComments),
    nsStringValueMapRecord(str_pi_Document_SubPanel_ShowUserComments, pi_Document_SubPanel_ShowUserComments),
    nsStringValueMapRecord(str_pi_Document_SubPanel_ShowVersionComments, pi_Document_SubPanel_ShowVersionComments),
    nsStringValueMapRecord(str_pi_Document_ExportWithBlockNames, pi_Document_ExportWithBlockNames),
    nsStringValueMapRecord(str_pi_Document_ShowVersionsComment, pi_Document_ShowVersionsComment),
    nsStringValueMapRecord(str_pi_NotifyNewChatMesages, pi_NotifyNewChatMesages),
    nsStringValueMapRecord(str_pi_EnableMSOfficeIntegration, pi_EnableMSOfficeIntegration),
    nsStringValueMapRecord(str_pi_Document_ForceAskForIntranet, pi_Document_ForceAskForIntranet),
    nsStringValueMapRecord(str_pi_List_ExportWORestrictions, pi_List_ExportWORestrictions),
    nsStringValueMapRecord(str_pi_OpenDocumentsFromList, pi_OpenDocumentsFromList),
    nsStringValueMapRecord(str_pi_OpenLinksFromDocument, pi_OpenLinksFromDocument)]);
 end
 else
 // Настройки - pi_IfaceLanguage - Язык интерфейса
 if aID.rID = smap_pi_IfaceLanguage.rID then
  Result := TnsLanguageMap.Make(smap_pi_IfaceLanguage)
 else
 // Настройки - pi_OpenOnStart - Поведение системы
 if aID.rID = smap_pi_OpenOnStart.rID then
 begin
  l_CommonOpenOnStartValues := lp_MakeValuesArray(
   [nsStringValueMapRecord(str_li_OpenOnStartAttributeSearch, li_OpenOnStartAttributeSearch),
    nsStringValueMapRecord(str_li_OpenOnStartSituationSearch, li_OpenOnStartSituationSearch),
    nsStringValueMapRecord(str_li_OpenOnStartMainMenu, li_OpenOnStartMainMenu),
    nsStringValueMapRecord(str_li_OpenOnStartNavigator, li_OpenOnStartNavigator)]);
  // Для английской версии - без Инфарма
  // http://mdp.garant.ru/pages/viewpage.action?pageId=380611947
  if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) then
  begin
   l_RussianOpenOnStartValues := lp_MakeValuesArray(
    [nsStringValueMapRecord(str_li_OpenOnStartInpharmSearch, li_OpenOnStartInpharmSearch),
     nsStringValueMapRecord(str_li_OpenOnStartFullDrugList, li_OpenOnStartFullDrugList),
     nsStringValueMapRecord(str_li_OpenOnStartInpharmMainMenu, li_OpenOnStartInpharmMainMenu)]);
   l_ResultOpenOnStartValues := lp_CatArrays(l_CommonOpenOnStartValues, l_RussianOpenOnStartValues);
  end
  else
   l_ResultOpenOnStartValues := l_CommonOpenOnStartValues;
  Result := TnsStringValueMap.Make(smap_pi_OpenOnStart, l_ResultOpenOnStartValues);
 end
 else
 // Настройки - pi_Search_SituationType - Поиск по ситуации:
 if aID.rID = smap_pi_Search_SituationType.rID then
  Result := TnsStringValueMap.Make(smap_pi_Search_SituationType,
   [nsStringValueMapRecord(str_pui_NewSerachCard, li_NewSearch_SituationType),
    nsStringValueMapRecord(str_pui_OldSerachCard, li_OldSearch_SituationType)])
 else
 // Настройки - pi_piDocumentPictureScale - Масштаб графических изображений
 {$IfEnd not (defined(Monitorings) or defined(Admin))}
 if aID.rID = smap_piDocumentPictureScale.rID then
  Result := TnsPictureScaleMap.Make(smap_piDocumentPictureScale,
   li_dpsValues,cvDocumentPictureScaleLow,cvDocumentPictureScaleHigh,
    nsStringValueMapRecord(str_li_dps_Fit, li_dps_Fit))
 else
 if aID.rID = smap_pi_DropChangeStatus.rID then
  Result := TnsStringValueMap.Make(smap_pi_DropChangeStatus,
   [nsStringValueMapRecord(str_li_DropChangeStatus_Manual, li_DropChangeStatus_Manual),
    nsStringValueMapRecord(str_li_DropChangeStatus_OnOpen, li_DropChangeStatus_OnOpen),
    nsStringValueMapRecord(str_li_DropChangeStatus_OnClose, li_DropChangeStatus_OnClose)])
 else
 // Заголовки типов контекстной фоитрации
 if (aID.rID = smap_ContextParamsCaptions.rID) then
  Result := TnsStringValueMap.Make(smap_ContextParamsCaptions,
   [nsStringValueMapRecord(str_cpKeywordSerchCaption, gi_cpKeywordSerch),
    nsStringValueMapRecord(str_cpPublishSourceCaption, gi_cpPublishSource),
    nsStringValueMapRecord(str_cpDictionCaption, gi_cpDiction),
    nsStringValueMapRecord(str_cpNavigatorCaption, gi_cpNavigator),
    nsStringValueMapRecord(str_cpTypeCaption, gi_cpType),
    nsStringValueMapRecord(str_cpClassCaption, AT_Class),
    nsStringValueMapRecord(str_cpSourceCaption, AT_Source),
    nsStringValueMapRecord(str_cpRegNumberCaption, gi_cpRegNumber),
    nsStringValueMapRecord(str_cpMURegNumberCaption, gi_cpMURegNumber),
    nsStringValueMapRecord(str_cpMURegStatusCaption, gi_cpMURegStatus),
    nsStringValueMapRecord(str_cpStatusCaption, gi_cpStatus),
    nsStringValueMapRecord(str_cpNormCaption, gi_cpNorm),
    nsStringValueMapRecord(str_cpPrefixCaption, AT_PREFIX),
    nsStringValueMapRecord(str_cpTerritoryCaption, gi_cpTerritory),
    nsStringValueMapRecord(str_cpBasesCaption, gi_cpBases),
    nsStringValueMapRecord(str_cpContentsCaption, gi_cpContents),
    nsStringValueMapRecord(str_cpUserListCaption, gi_cpUserList),
    nsStringValueMapRecord(str_cpDayTips, gi_cpDayTips),
    nsStringValueMapRecord(str_cpMedicDiction, gi_cpMedicDiction),
    nsStringValueMapRecord(str_cpMedicFirms, gi_cpMedicFirms),
    nsStringValueMapRecord(str_cpDrugContents, gi_cpDrugContents),
    nsStringValueMapRecord(str_cpDrugList, gi_cpDrugList),
    nsStringValueMapRecord(str_cpGroupList, gi_cpGroupList),
    nsStringValueMapRecord(str_cpPrefixCaptionReview, AT_PREFIX_REVIEW),
    nsStringValueMapRecord(str_cpClassCaptionReview, AT_Class_Review),
    nsStringValueMapRecord(str_cpSourceCaptionReview, AT_Source_Review)
    ])
 else
 // Главное окно - Гарант в интернете
 if aID.rID = smap_InternetCaptions.rID then
  Result := TnsStringValueMap.Make(smap_InternetCaptions,
   [nsStringValueMapRecord(str_ilnCompanyName, ciitGarant),
    nsStringValueMapRecord(str_ilnHotDocuments, ciitHotDocs),
    nsStringValueMapRecord(str_ilnNews, ciitGovermentNews),
    nsStringValueMapRecord(str_ilnWebLinks, ciitGovermentWebLinks),
    nsStringValueMapRecord(str_ilnGarantopedia, ciitEncyclopaediaMonitorings),
    nsStringValueMapRecord(str_ilnMainDocuments, ciitBasicDocs),
    nsStringValueMapRecord(str_ilnForum, ciitForum),
    nsStringValueMapRecord(str_ilnEducation, ciitTeaching),
    nsStringValueMapRecord(str_ilnTest, ciitTesting),
    nsStringValueMapRecord(str_ilnCatalogue, ciitCatalogOfProducts),
    nsStringValueMapRecord(str_ilnRumors, ciitGarantWithYou)])
 else
 if aID.rID = smap_SettingsCRType.rID then
  Result := TnsCRTypeStringValueMap.Make(smap_SettingsCRType{, imap_UICRTypes, False})
 else
  Result := nil;
end;

end.

