////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garant6x::GblAdapterLib
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatch_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatchEx_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/DataReadingStream_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/LayerFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SortFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FindIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/KW_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TYPE_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CLASS_REVIEW_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/REG_NUM_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/REG_IN_MU_NUM_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/STATUS_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NORM_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/REG_IN_MU_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BASES_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PREFIX_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TERRITORY_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/EDITION_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/UC_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_KIND_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_USER_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_ORG_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_INTEREST_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_TAX_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimLeafFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_INTERNATIONAL_NAME_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_TRADE_NAME_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_CHAPTER_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_COUNTRY_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_REG_STATUS_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_MEDICINAL_FORM_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_ATC_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_MKB_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_GROUP_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_EFFECT_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_UNRECIPE_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_IMPORTANT_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_NARCOTIC_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PHARM_COUNTRY_FOR_FILTER_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Variants_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BlocksFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/InpharmFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/VariantsForDocFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PREFIX_REVIEW_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_FINANCE_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SOURCE_REVIEW_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_LEGAL_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_HR_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_BUDGET_ORGS_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/BaseSearchPanesTree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CLASS_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/SOURCE_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_PHARM_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/IMPORTANT_DOCUMENTS_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/MissingInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TipDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDictDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DictDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FlashDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffDocDataProvider_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsContentsDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/RefDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ListFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalObjectFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/EnoFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalOperationFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookmarkFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/QueryFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/SearchDynList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalLink_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalObject_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/SplashScreen_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/StringDataTransformer_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/AssemblyInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Common_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchImpl_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCreator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AdapterFiltersQuery_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ConsultingQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PharmQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ReviewQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributesHelper_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Logging_i/LogEventData_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Monitoring_i/MonitoringList_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FiltersManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageListener_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/ChatManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ChatService_i/MessageManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/GroupsNode_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/DefaultValuesChangesIndicator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/JournalNode_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultingTemplateInfo_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/FinanceSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/HRSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LegalSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BudgetOrgsSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BusinessReferencesSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/ChangesInLegislationSection_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LawForAllSection_factory.h"

namespace GblAdapterLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *456EA3D2031C_ENVIRONMENTS_CONFIG*
	//#UC END# *456EA3D2031C_ENVIRONMENTS_CONFIG*

	{
		ExternalOperation_i_factory_var fctr = new ExternalOperation_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StopWatch_i_factory_var fctr = new StopWatch_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StopWatchEx_i_factory_var fctr = new StopWatchEx_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SearchEntity_i_factory_var fctr = new SearchEntity_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Variant_i_factory_var fctr = new Variant_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DataReadingStream_i_factory_var fctr = new DataReadingStream_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MemStream_i_factory_var fctr = new MemStream_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ContextFilter_i_factory_var fctr = new ContextFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		LayerFilter_i_factory_var fctr = new LayerFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SortFilter_i_factory_var fctr = new SortFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TrimFilter_i_factory_var fctr = new TrimFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FindIterator_i_factory_var fctr = new FindIterator_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		NodesClipboard_i_factory_var fctr = new NodesClipboard_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		QueryFilter_i_factory_var fctr = new QueryFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		NodeBase_i_factory_var fctr = new NodeBase_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DelegateNodeRoot_factory_var fctr = new DelegateNodeRoot_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FrozenNode_i_factory_var fctr = new FrozenNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		NodeIterator_i_factory_var fctr = new NodeIterator_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RealNodeRoot_factory_var fctr = new RealNodeRoot_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AllNodeIterator_i_factory_var fctr = new AllNodeIterator_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		KW_tree_factory_var fctr = new KW_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TYPE_tree_factory_var fctr = new TYPE_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FilteredTreeNode_i_factory_var fctr = new FilteredTreeNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		CLASS_REVIEW_tree_factory_var fctr = new CLASS_REVIEW_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		REG_NUM_tree_factory_var fctr = new REG_NUM_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		REG_IN_MU_NUM_tree_factory_var fctr = new REG_IN_MU_NUM_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		STATUS_tree_factory_var fctr = new STATUS_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		NORM_tree_factory_var fctr = new NORM_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		REG_IN_MU_tree_factory_var fctr = new REG_IN_MU_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BASES_tree_factory_var fctr = new BASES_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PREFIX_tree_factory_var fctr = new PREFIX_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TERRITORY_tree_factory_var fctr = new TERRITORY_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PUBLISH_SOURCE_tree_factory_var fctr = new PUBLISH_SOURCE_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		EDITION_tree_factory_var fctr = new EDITION_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UC_tree_factory_var fctr = new UC_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ANNO_KIND_tree_factory_var fctr = new ANNO_KIND_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ANNO_USER_tree_factory_var fctr = new ANNO_USER_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ANNO_ORG_factory_var fctr = new ANNO_ORG_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ANNO_INTEREST_tree_factory_var fctr = new ANNO_INTEREST_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ANNO_TAX_factory_var fctr = new ANNO_TAX_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TrimLeafFilter_i_factory_var fctr = new TrimLeafFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_INTERNATIONAL_NAME_tree_factory_var fctr = new PHARM_INTERNATIONAL_NAME_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_TRADE_NAME_tree_factory_var fctr = new PHARM_TRADE_NAME_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_CHAPTER_tree_factory_var fctr = new PHARM_CHAPTER_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_COUNTRY_tree_factory_var fctr = new PHARM_COUNTRY_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_REG_STATUS_tree_factory_var fctr = new PHARM_REG_STATUS_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_MEDICINAL_FORM_tree_factory_var fctr = new PHARM_MEDICINAL_FORM_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_ATC_tree_factory_var fctr = new PHARM_ATC_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_MKB_tree_factory_var fctr = new PHARM_MKB_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_GROUP_tree_factory_var fctr = new PHARM_GROUP_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_EFFECT_tree_factory_var fctr = new PHARM_EFFECT_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_UNRECIPE_tree_factory_var fctr = new PHARM_UNRECIPE_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_IMPORTANT_tree_factory_var fctr = new PHARM_IMPORTANT_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_NARCOTIC_tree_factory_var fctr = new PHARM_NARCOTIC_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PHARM_COUNTRY_FOR_FILTER_tree_factory_var fctr = new PHARM_COUNTRY_FOR_FILTER_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		CountryFilter_i_factory_var fctr = new CountryFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Variants_tree_factory_var fctr = new Variants_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		CutToLeafCountFilter_i_factory_var fctr = new CutToLeafCountFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BlocksFilter_i_factory_var fctr = new BlocksFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		InpharmFilter_i_factory_var fctr = new InpharmFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		VariantsForDocFilter_i_factory_var fctr = new VariantsForDocFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PREFIX_REVIEW_tree_factory_var fctr = new PREFIX_REVIEW_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PUBLISH_SOURCE_FINANCE_tree_factory_var fctr = new PUBLISH_SOURCE_FINANCE_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SOURCE_REVIEW_tree_factory_var fctr = new SOURCE_REVIEW_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PUBLISH_SOURCE_LEGAL_tree_factory_var fctr = new PUBLISH_SOURCE_LEGAL_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PUBLISH_SOURCE_HR_tree_factory_var fctr = new PUBLISH_SOURCE_HR_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PUBLISH_SOURCE_BUDGET_ORGS_tree_factory_var fctr = new PUBLISH_SOURCE_BUDGET_ORGS_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BaseSearchPanesTree_factory_var fctr = new BaseSearchPanesTree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		CLASS_tree_factory_var fctr = new CLASS_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SOURCE_tree_factory_var fctr = new SOURCE_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PUBLISH_SOURCE_PHARM_tree_factory_var fctr = new PUBLISH_SOURCE_PHARM_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IMPORTANT_DOCUMENTS_tree_factory_var fctr = new IMPORTANT_DOCUMENTS_tree_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PrefixNode_i_factory_var fctr = new PrefixNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocNodeFilter_i_factory_var fctr = new DocNodeFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ContentsNode_i_factory_var fctr = new ContentsNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ContentsNodeDelegate_factory_var fctr = new ContentsNodeDelegate_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocumentState_i_factory_var fctr = new DocumentState_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocumentMaster_factory_var fctr = new DocumentMaster_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SimpleDocument_factory_var fctr = new SimpleDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TranslatedDocument_factory_var fctr = new TranslatedDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AutoreferatDocument_factory_var fctr = new AutoreferatDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Bookmark_i_factory_var fctr = new Bookmark_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MissingInfo_i_factory_var fctr = new MissingInfo_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TipDocument_factory_var fctr = new TipDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PharmFirmDocument_i_factory_var fctr = new PharmFirmDocument_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PharmDictDocument_factory_var fctr = new PharmDictDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DictDocument_factory_var fctr = new DictDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PharmDocument_factory_var fctr = new PharmDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FlashDocument_factory_var fctr = new FlashDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		JournalBookmark_i_factory_var fctr = new JournalBookmark_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DiffIterator_i_factory_var fctr = new DiffIterator_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FoundContext_i_factory_var fctr = new FoundContext_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DiffDocDataProvider_i_factory_var fctr = new DiffDocDataProvider_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ConsultingStub_i_factory_var fctr = new ConsultingStub_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ConsultingStateStub_i_factory_var fctr = new ConsultingStateStub_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocumentDelegate_factory_var fctr = new DocumentDelegate_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ActualAnalyticsContentsDocument_factory_var fctr = new ActualAnalyticsContentsDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ActualAnalyticsDocument_factory_var fctr = new ActualAnalyticsDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DTPWithCachedData_factory_var fctr = new DTPWithCachedData_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DTPWithDataCleaning_factory_var fctr = new DTPWithDataCleaning_factory ();
		fctr->registrate_me(1);
	}
	
	{
		Link_i_factory_var fctr = new Link_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RefDocument_factory_var fctr = new RefDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BookDocument_factory_var fctr = new BookDocument_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocumentFromLink_factory_var fctr = new DocumentFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ListFromLink_factory_var fctr = new ListFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ExternalObjectFromLink_factory_var fctr = new ExternalObjectFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ExternalLinkFromLink_factory_var fctr = new ExternalLinkFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		EnoFromLink_factory_var fctr = new EnoFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ScriptFromLink_factory_var fctr = new ScriptFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AutoreferatFromLink_factory_var fctr = new AutoreferatFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ExternalOperationFromLink_factory_var fctr = new ExternalOperationFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BookmarkFromLink_factory_var fctr = new BookmarkFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		QueryFromLink_factory_var fctr = new QueryFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DeletedContentFromLink_factory_var fctr = new DeletedContentFromLink_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ControlManager_i_factory_var fctr = new ControlManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DynListNodeDelegate_factory_var fctr = new DynListNodeDelegate_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DynListNode_i_factory_var fctr = new DynListNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ListEntryInfo_i_factory_var fctr = new ListEntryInfo_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SearchDynList_i_factory_var fctr = new SearchDynList_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DynList_i_factory_var fctr = new DynList_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AnalysisNode_i_factory_var fctr = new AnalysisNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DocListFactory_i_factory_var fctr = new DocListFactory_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ExternalLink_i_factory_var fctr = new ExternalLink_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ExternalObject_i_factory_var fctr = new ExternalObject_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SplashScreen_i_factory_var fctr = new SplashScreen_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		NewsLineNode_i_factory_var fctr = new NewsLineNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		NotifyManager_i_factory_var fctr = new NotifyManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		LongTransformer_i_factory_var fctr = new LongTransformer_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BoolTransformer_i_factory_var fctr = new BoolTransformer_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		StringDataTransformer_i_factory_var fctr = new StringDataTransformer_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Notification_i_factory_var fctr = new Notification_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ComplectInfo_i_factory_var fctr = new ComplectInfo_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ComplectInfoNode_i_factory_var fctr = new ComplectInfoNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ExplanatoryNode_i_factory_var fctr = new ExplanatoryNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MedExplanatoryNode_i_factory_var fctr = new MedExplanatoryNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FoldersManager_i_factory_var fctr = new FoldersManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Folder_i_factory_var fctr = new Folder_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FoldersNode_i_factory_var fctr = new FoldersNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AssemblyInfo_i_factory_var fctr = new AssemblyInfo_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Authorization_i_factory_var fctr = new Authorization_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Common_i_factory_var fctr = new Common_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		QueryContextAttribute_i_factory_var fctr = new QueryContextAttribute_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		QueryPhoneNumberAttribute_i_factory_var fctr = new QueryPhoneNumberAttribute_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		QueryDateAttribute_i_factory_var fctr = new QueryDateAttribute_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		QueryNodeAttribute_i_factory_var fctr = new QueryNodeAttribute_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SearchImpl_factory_var fctr = new SearchImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AttributeInfo_i_factory_var fctr = new AttributeInfo_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		QueryCreator_i_factory_var fctr = new QueryCreator_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Query_i_factory_var fctr = new Query_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AdapterFiltersQuery_i_factory_var fctr = new AdapterFiltersQuery_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FiltersQuery_i_factory_var fctr = new FiltersQuery_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AttributeQueryCard_factory_var fctr = new AttributeQueryCard_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ConsultingQueryCard_factory_var fctr = new ConsultingQueryCard_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PharmQueryCard_factory_var fctr = new PharmQueryCard_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ReviewQueryCard_factory_var fctr = new ReviewQueryCard_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PrimeQueryCard_factory_var fctr = new PrimeQueryCard_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FullAttributeInfo_i_factory_var fctr = new FullAttributeInfo_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		AttributesHelper_i_factory_var fctr = new AttributesHelper_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		LogManager_i_factory_var fctr = new LogManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		LogEventData_i_factory_var fctr = new LogEventData_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MonitoringManager_i_factory_var fctr = new MonitoringManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MonitoringList_i_factory_var fctr = new MonitoringList_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FilterFromQuery_i_factory_var fctr = new FilterFromQuery_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FiltersManager_i_factory_var fctr = new FiltersManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FilterUsageCounter_i_factory_var fctr = new FilterUsageCounter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Integration_i::Integration_i_factory_var fctr = new Integration_i::Integration_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TipsManager_i_factory_var fctr = new TipsManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		TipsTreeNode_i_factory_var fctr = new TipsTreeNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PrimeManager_i_factory_var fctr = new PrimeManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Prime_i_factory_var fctr = new Prime_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PrimeSettingsManager_i_factory_var fctr = new PrimeSettingsManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PrimeContractData_i_factory_var fctr = new PrimeContractData_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PharmFirmListEntry_i_factory_var fctr = new PharmFirmListEntry_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PharmFirmNode_i_factory_var fctr = new PharmFirmNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	//#UC START# *456EA3D2031C_CUSTOM_REGISTRATE_FOR_4A2E3A1802B8_MessageListener_i*
	//#UC END# *456EA3D2031C_CUSTOM_REGISTRATE_FOR_4A2E3A1802B8_MessageListener_i*
	
	{
		ChatService_i::ChatManager_i_factory_var fctr = new ChatService_i::ChatManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ChatService_i::MessageManager_i_factory_var fctr = new ChatService_i::MessageManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UserManager_i_factory_var fctr = new UserManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UserFilter_i_factory_var fctr = new UserFilter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UserProfile_i_factory_var fctr = new UserProfile_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UserNode_i_factory_var fctr = new UserNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		GroupsNode_factory_var fctr = new GroupsNode_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UserNodeDelegate_factory_var fctr = new UserNodeDelegate_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SearchProgressIndicator_i::CancelSearch_i_factory_var fctr = new SearchProgressIndicator_i::CancelSearch_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SettingsManager_i_factory_var fctr = new SettingsManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Configuration_i_factory_var fctr = new Configuration_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DefaultValuesChangesIndicator_i_factory_var fctr = new DefaultValuesChangesIndicator_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ConfigurationManager_i_factory_var fctr = new ConfigurationManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		PropertiesManager_i_factory_var fctr = new PropertiesManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UserJournal_i_factory_var fctr = new UserJournal_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		JournalNode_factory_var fctr = new JournalNode_factory ();
		fctr->registrate_me(0);
	}
	
	{
		RubricatorNode_i_factory_var fctr = new RubricatorNode_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Banner_i_factory_var fctr = new Banner_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Estimation_i_factory_var fctr = new Estimation_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ConsultationManager_i_factory_var fctr = new ConsultationManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Consultation_i_factory_var fctr = new Consultation_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ConsultingTemplateInfo_i_factory_var fctr = new ConsultingTemplateInfo_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		InternetSupport_i_factory_var fctr = new InternetSupport_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		DecisionsArchiveSupport_i_factory_var fctr = new DecisionsArchiveSupport_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MainMenu_i_factory_var fctr = new MainMenu_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		SectionItem_i_factory_var fctr = new SectionItem_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FinanceSection_factory_var fctr = new FinanceSection_factory ();
		fctr->registrate_me(0);
	}
	
	{
		HRSection_factory_var fctr = new HRSection_factory ();
		fctr->registrate_me(0);
	}
	
	{
		LegalSection_factory_var fctr = new LegalSection_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BudgetOrgsSection_factory_var fctr = new BudgetOrgsSection_factory ();
		fctr->registrate_me(0);
	}
	
	{
		BusinessReferencesSection_factory_var fctr = new BusinessReferencesSection_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ChangesInLegislationSection_factory_var fctr = new ChangesInLegislationSection_factory ();
		fctr->registrate_me(0);
	}
	
	{
		LawForAllSection_factory_var fctr = new LawForAllSection_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
