////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterServer/GblAdapterServer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> garant6x::GblAdapterServer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERSERVER_H__
#define __GARANT6X_GBLADAPTERSERVER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"
#include "shared/GCI/I18N/I18NFactories.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"
#include "shared/GSI/NotifyService/NotifyServiceFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupportFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/FiltersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControlFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/LoggingFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperationFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocalFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterfaceFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocalFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/ProfileFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/ConsultingFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/ComplectFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupportFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/MonitoringFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfacesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProjectFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/TipsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournalFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"
#include "shared/CoreSrv/SecurityComm/SecurityCommFactories.h"
#include "shared/CoreSrv/Security/SecurityFactories.h"
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"
//#UC START# *47397F650051_CUSTOM_INCLUDE*
//#UC END# *47397F650051_CUSTOM_INCLUDE*

namespace GblAdapterServer {

class Root : virtual public Core::RefCountObjectBase {
public:
	virtual CoreSrv::Authenticator& get_authenticator (
	) {
		return CoreSrv::AuthenticatorFactory::get();
	}

	virtual CoreSrv::Session& get_session (
	) {
		return CoreSrv::SessionFactory::get();
	}

	virtual GCI::UnicodeHelper::ConverterHelper* make_converter_helper (
	) {
		return GCI::UnicodeHelper::ConverterHelperFactory::make();
	}

	virtual GCI::I18N::LocaleOperations& make_locale_operations (
	) {
		return GCI::I18N::LocaleOperationsFactory::make();
	}

	virtual GCI::I18N::Messages& messages_messages (
	) {
		return GCI::I18N::MessagesFactory::messages();
	}

	virtual GCI::IO::Stream* make_stream (
	) {
		return GCI::IO::StreamFactory::make();
	}

	virtual GCI::IO::Stream* make_stream (
		const char* path
	
	) {
		return GCI::IO::StreamFactory::make(path);
	}

	virtual GCI::IO::String* make_string (
		const char* str
	
	) {
		return GCI::IO::StringFactory::make(str);
	}

	virtual GCI::IO::String* alloc_string (
		unsigned long maximum
	
	) {
		return GCI::IO::StringFactory::alloc(maximum);
	}

	virtual GSI::NotifyService::Manager& make_manager (
	) {
		return GSI::NotifyService::ManagerFactory::make();
	}

	virtual GSI::NotifyService::Supplier* make_supplier (
	) {
		return GSI::NotifyService::SupplierFactory::make();
	}

	virtual GblAdapterLib::AdapterFiltersQuery* make_adapter_filters_query (
		GblAdapterLib::QueryType type
	
	) {
		return GblAdapterLib::AdapterFiltersQueryFactory::make(type);
	}

	virtual GblAdapterLib::AssemblyInfo* make_assembly_info (
	) {
		return GblAdapterLib::AssemblyInfoFactory::make();
	}

	virtual GblAdapterLib::AttributeInfo* make_attribute_info (
		GblAdapterLib::AttributeTag_const tag
	
	) {
		return GblAdapterLib::AttributeInfoFactory::make(tag);
	}

	virtual GblAdapterLib::AttributesHelper* make_attributes_helper (
	) {
		return GblAdapterLib::AttributesHelperFactory::make();
	}

	virtual GblAdapterLib::Authorization* make_authorization (
	) {
		return GblAdapterLib::AuthorizationFactory::make();
	}

	virtual GblAdapterLib::BlocksFilter* make_blocks_filter (
	) {
		return GblAdapterLib::BlocksFilterFactory::make();
	}

	virtual GblAdapterLib::ChatInterfaces::ChatManager& make_chat_manager (
	) {
		return GblAdapterLib::ChatInterfaces::ChatManagerFactory::make();
	}

	virtual GblAdapterLib::Common* make_common (
	) {
		return GblAdapterLib::CommonFactory::make();
	}

	virtual GblAdapterLib::ComplectInfo* make_complect_info (
	) {
		return GblAdapterLib::ComplectInfoFactory::make();
	}

	virtual GblAdapterLib::ComponentManager& make_component_manager (
	) {
		return GblAdapterLib::ComponentManagerFactory::make();
	}

	virtual GblAdapterLib::Configuration* make_configuration (
		long id
		, const GCI::IO::String* name
		, const GCI::IO::String* hint
		, bool readonly
	
	) {
		return GblAdapterLib::ConfigurationFactory::make(id, name, hint, readonly);
	}

	virtual GblAdapterLib::ConfigurationManager* make_configuration_manager (
	) {
		return GblAdapterLib::ConfigurationManagerFactory::make();
	}

	virtual GblAdapterLib::ConsultationManager* make_consultation_manager (
	) {
		return GblAdapterLib::ConsultationManagerFactory::make();
	}

	virtual GblAdapterLib::ConsultingStateStub* make_stub_consulting_state_stub (
	) {
		return GblAdapterLib::ConsultingStateStubFactory::make_stub();
	}

	virtual GblAdapterLib::ConsultingTemplateInfo* make_consulting_template_info (
	) {
		return GblAdapterLib::ConsultingTemplateInfoFactory::make();
	}

	virtual GblAdapterLib::ContextFilter* make_context_filter (
	) {
		return GblAdapterLib::ContextFilterFactory::make();
	}

	virtual GblAdapterLib::ControlManager& make_control_manager (
	) {
		return GblAdapterLib::ControlManagerFactory::make();
	}

	virtual GblAdapterLib::CountryFilter* make_country_filter (
		const GblAdapterLib::NodeBase* country
	
	) {
		return GblAdapterLib::CountryFilterFactory::make(country);
	}

	virtual GblAdapterLib::CountryFilter* make_country_filter (
	) {
		return GblAdapterLib::CountryFilterFactory::make();
	}

	virtual GblAdapterLib::CutToLeafCountFilter* make_cut_to_leaf_count_filter (
		unsigned long leaf_count
	
	) {
		return GblAdapterLib::CutToLeafCountFilterFactory::make(leaf_count);
	}

	virtual GblAdapterLib::CutToLeafCountFilter* make_cut_to_leaf_count_filter (
	) {
		return GblAdapterLib::CutToLeafCountFilterFactory::make();
	}

	virtual GblAdapterLib::DataReadingStream* make_data_reading_stream (
		GslDataPipe::DataReading* data_reading
	
	) {
		return GblAdapterLib::DataReadingStreamFactory::make(data_reading);
	}

	virtual GblAdapterLib::DataTransformer* make_data_transformer (const char* key
	) {
		return GblAdapterLib::DataTransformerFactory::make(key);
	}

	virtual GblAdapterLib::DecisionsArchiveSupport* make_decisions_archive_support (
	) {
		return GblAdapterLib::DecisionsArchiveSupportFactory::make();
	}

	virtual GblAdapterLib::DefaultValuesChangesIndicator* make_default_values_changes_indicator (
		GblAdapterLib::DefaultValuesChangesState state
		, const GblAdapterLib::Configuration* configuration
	
	) {
		return GblAdapterLib::DefaultValuesChangesIndicatorFactory::make(state, configuration);
	}

	virtual GblAdapterLib::DiffDocDataProvider* make_diff_doc_data_provider (
		const GblAdapterLib::Document* left
		, const GblAdapterLib::Document* right
	
	) {
		return GblAdapterLib::DiffDocDataProviderFactory::make(left, right);
	}

	virtual GblAdapterLib::DocListFactory* make_doc_list_factory (
	) {
		return GblAdapterLib::DocListFactoryFactory::make();
	}

	virtual GblAdapterLib::DocNodeFilter* make_doc_node_filter (
	) {
		return GblAdapterLib::DocNodeFilterFactory::make();
	}

	virtual GblAdapterLib::DocumentState* make_document_state (
		GblAdapterLib::Document* source_doc
	
	) {
		return GblAdapterLib::DocumentStateFactory::make(source_doc);
	}

	virtual GblAdapterLib::DynList* make_dyn_list (
		GblAdapterLib::SpecialListKey key
	
	) {
		return GblAdapterLib::DynListFactory::make(key);
	}

	virtual GblAdapterLib::Estimation* make_estimation (
	) {
		return GblAdapterLib::EstimationFactory::make();
	}

	virtual GblAdapterLib::ExternalOperation* make_external_operation (
		GblAdapterLib::ObjectId id
	
	) {
		return GblAdapterLib::ExternalOperationFactory::make(id);
	}

	virtual GblAdapterLib::FiltersManager* make_filters_manager (
	) {
		return GblAdapterLib::FiltersManagerFactory::make();
	}

	virtual GblAdapterLib::FiltersQuery* make_filters_query (
		GblAdapterLib::FilterFromQuery* filter
	
	) {
		return GblAdapterLib::FiltersQueryFactory::make(filter);
	}

	virtual GblAdapterLib::FiltersUsageCounter* make_filters_usage_counter (
	) {
		return GblAdapterLib::FiltersUsageCounterFactory::make();
	}

	virtual GblAdapterLib::Folders& make_folders (
	) {
		return GblAdapterLib::FoldersFactory::make();
	}

	virtual GblAdapterLib::InpharmFilter* make_inpharm_filter (
	) {
		return GblAdapterLib::InpharmFilterFactory::make();
	}

	virtual GblAdapterLib::Integration* make_integration (
	) {
		return GblAdapterLib::IntegrationFactory::make();
	}

	virtual GblAdapterLib::InternetSupport* make_internet_support (
	) {
		return GblAdapterLib::InternetSupportFactory::make();
	}

	virtual GblAdapterLib::LayerFilter* make_layer_filter (
	) {
		return GblAdapterLib::LayerFilterFactory::make();
	}

	virtual GblAdapterLib::LogEventData* make_log_event_data (
	) {
		return GblAdapterLib::LogEventDataFactory::make();
	}

	virtual GblAdapterLib::LogManager* make_log_manager (
	) {
		return GblAdapterLib::LogManagerFactory::make();
	}

	virtual GblAdapterLib::MainMenu& make_main_menu (
	) {
		return GblAdapterLib::MainMenuFactory::make();
	}

	virtual GblAdapterLib::MemoryStream* make_memory_stream (
		const GblAdapterLib::OctetSeq& data
		, bool with_copy
	
	) {
		return GblAdapterLib::MemoryStreamFactory::make(data, with_copy);
	}

	virtual GblAdapterLib::ChatInterfaces::MessagesManager& make_messages_manager (
	) {
		return GblAdapterLib::ChatInterfaces::MessagesManagerFactory::make();
	}

	virtual GblAdapterLib::Monitoring* make_monitoring (
	) {
		return GblAdapterLib::MonitoringFactory::make();
	}

	virtual GblAdapterLib::Node* make_node (
	) {
		return GblAdapterLib::NodeFactory::make();
	}

	virtual GblAdapterLib::NodeBase* make_node_base (const char* key
	) {
		return GblAdapterLib::NodeBaseFactory::make(key);
	}

	virtual GblAdapterLib::NodeIterator* make_node_iterator (
	) {
		return GblAdapterLib::NodeIteratorFactory::make();
	}

	virtual GblAdapterLib::NodesClipboard* make_nodes_clipboard (
	) {
		return GblAdapterLib::NodesClipboardFactory::make();
	}

	virtual GblAdapterLib::NotifyManager& make_notify_manager (
	) {
		return GblAdapterLib::NotifyManagerFactory::make();
	}

	virtual GblAdapterLib::PermanentSettingsManager* make_permanent_settings_manager (
	) {
		return GblAdapterLib::PermanentSettingsManagerFactory::make();
	}

	virtual GblAdapterLib::PrefixNode* make_prefix_node (
	) {
		return GblAdapterLib::PrefixNodeFactory::make();
	}

	virtual GblAdapterLib::PrimeContractData* get_contract_data_prime_contract_data (
		GblAdapterLib::Query* query
	
	) {
		return GblAdapterLib::PrimeContractDataFactory::get_contract_data(query);
	}

	virtual GblAdapterLib::PrimeManager& make_prime_manager (
	) {
		return GblAdapterLib::PrimeManagerFactory::make();
	}

	virtual GblAdapterLib::PrimeSettingsManager* make_prime_settings_manager (
	) {
		return GblAdapterLib::PrimeSettingsManagerFactory::make();
	}

	virtual GblAdapterLib::Query* make_query (
		GblAdapterLib::QueryType type
	
	) {
		return GblAdapterLib::QueryFactory::make(type);
	}

	virtual GblAdapterLib::QueryCardInfo* create_query_card_info (const char* key
	) {
		return GblAdapterLib::QueryCardInfoFactory::create(key);
	}

	virtual GblAdapterLib::QueryContextAttribute* make_query_context_attribute (
		GblAdapterLib::AttributeTag_const attribute_tag
	
	) {
		return GblAdapterLib::QueryContextAttributeFactory::make(attribute_tag);
	}

	virtual GblAdapterLib::QueryCreator* make_query_creator (
	) {
		return GblAdapterLib::QueryCreatorFactory::make();
	}

	virtual GblAdapterLib::QueryDateAttribute* make_query_date_attribute (
		GblAdapterLib::AttributeTag_const attribute_tag
	
	) {
		return GblAdapterLib::QueryDateAttributeFactory::make(attribute_tag);
	}

	virtual GblAdapterLib::QueryFilter* make_query_filter (
		GblAdapterLib::FilterFromQuery* data
	
	) {
		return GblAdapterLib::QueryFilterFactory::make(data);
	}

	virtual GblAdapterLib::QueryFilter* make_query_filter (
		GblAdapterLib::FiltersFromQuery& data
	
	) {
		return GblAdapterLib::QueryFilterFactory::make(data);
	}

	virtual GblAdapterLib::QueryFilter* make_query_filter (
	) {
		return GblAdapterLib::QueryFilterFactory::make();
	}

	virtual GblAdapterLib::QueryNodeAttribute* make_query_node_attribute (
		GblAdapterLib::AttributeTag_const attribute_tag
	
	) {
		return GblAdapterLib::QueryNodeAttributeFactory::make(attribute_tag);
	}

	virtual GblAdapterLib::QueryPhoneNumberAttribute* make_query_phone_number_attribute (
		GblAdapterLib::AttributeTag_const attribute_tag
	
	) {
		return GblAdapterLib::QueryPhoneNumberAttributeFactory::make(attribute_tag);
	}

	virtual GblAdapterLib::Search* make_search (
	) {
		return GblAdapterLib::SearchFactory::make();
	}

	virtual GblAdapterLib::SearchEntity* make_search_entity (
		GblAdapterLib::SearchResultType result_type
		, size_t document_count
		, size_t entry_count
		, size_t edition_count
	
	) {
		return GblAdapterLib::SearchEntityFactory::make(result_type, document_count, entry_count, edition_count);
	}

	virtual GblAdapterLib::SortFilter* make_sort_filter (
	) {
		return GblAdapterLib::SortFilterFactory::make();
	}

	virtual GblAdapterLib::StopWatch* make_stop_watch (
		const char* context
	
	) {
		return GblAdapterLib::StopWatchFactory::make(context);
	}

	virtual GblAdapterLib::StopWatchEx* make_stop_watch_ex (
		const char* id
		, const char* context
	
	) {
		return GblAdapterLib::StopWatchExFactory::make(id, context);
	}

	virtual GblAdapterLib::TipsManager* make_tips_manager (
	) {
		return GblAdapterLib::TipsManagerFactory::make();
	}

	virtual GblAdapterLib::TrimFilter* make_trim_filter (
	) {
		return GblAdapterLib::TrimFilterFactory::make();
	}

	virtual GblAdapterLib::TrimLeafFilter* make_trim_leaf_filter (
	) {
		return GblAdapterLib::TrimLeafFilterFactory::make();
	}

	virtual GblAdapterLib::UserFilter* make_user_filter (
	) {
		return GblAdapterLib::UserFilterFactory::make();
	}

	virtual GblAdapterLib::UserJournal* make_user_journal (
	) {
		return GblAdapterLib::UserJournalFactory::make();
	}

	virtual GblAdapterLib::UserManager* make_user_manager (
	) {
		return GblAdapterLib::UserManagerFactory::make();
	}

	virtual GblAdapterLib::UserProfile* make_user_profile (
	) {
		return GblAdapterLib::UserProfileFactory::make();
	}

	virtual GblAdapterLib::Variant* make_variant (
	) {
		return GblAdapterLib::VariantFactory::make();
	}

	virtual GblAdapterLib::Variant* make_long_variant (
		long value
	
	) {
		return GblAdapterLib::VariantFactory::make_long(value);
	}

	virtual GblAdapterLib::Variant* make_bool_variant (
		bool value
	
	) {
		return GblAdapterLib::VariantFactory::make_bool(value);
	}

	virtual GblAdapterLib::Variant* make_string_variant (
		GCI::IO::String* value
	
	) {
		return GblAdapterLib::VariantFactory::make_string(value);
	}

	virtual GblAdapterLib::Variant* make_object_variant (
		Core::IObject* value
	
	) {
		return GblAdapterLib::VariantFactory::make_object(value);
	}

	virtual GblAdapterLib::VariantsForDocFilter* make_variants_for_doc_filter (
		unsigned long doc_id
	
	) {
		return GblAdapterLib::VariantsForDocFilterFactory::make(doc_id);
	}

	virtual GblAdapterLib::VariantsForDocFilter* make_variants_for_doc_filter (
	) {
		return GblAdapterLib::VariantsForDocFilterFactory::make();
	}


	
	typedef ACE_Singleton <Root, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Root, ACE_SYNCH_RECURSIVE_MUTEX>;
};

class DllInintializator {
public:
	static void init (unsigned long client_version, const char* locale_string);
	static void done ();

private:
	static Core::Mutex s_init_mutex;
	static unsigned long s_count;
};
} //namespace GblAdapterServer


extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall dll_done ();

extern "C" __declspec (dllexport) void __stdcall dll_get_root (
	GblAdapterServer::Root*& root
);

#endif //__GARANT6X_GBLADAPTERSERVER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
