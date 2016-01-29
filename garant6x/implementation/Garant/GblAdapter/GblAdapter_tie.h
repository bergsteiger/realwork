////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapter/GblAdapter_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<AdapterTargetUnion::Category>> garant6x::GblAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTER_TIE_H__
#define __GARANT6X_GBLADAPTER_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO_tie.h"
#include "shared/GCI/IO/IOFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupportFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/FiltersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControlFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/LoggingFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperationFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocTree/DocTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTree_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/Profile_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/ProfileFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/ConsultingFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/Complect_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/ComplectFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupportFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/Monitoring_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Monitoring/MonitoringFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfaces_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ChatInterfaces/ChatInterfacesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProjectFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/Tips_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/TipsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournalFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapter {

class Root_tie {
	SET_OBJECT_COUNTER (Root_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	) {
		static ::Core::ComIID my_iid = {0xF11331C9, 0x6903, 0x4F59, {0x98, 0x76, 0x78, 0xB3, 0xCC, 0xEE, 0x32, 0x09}};
		if (my_iid == iid) {
			this->addref();
			object = this;
			return 0x00000000UL;
		} else {
			object = 0;
			return 0x80004002UL;
		}
	}

public:
	virtual unsigned long __stdcall addref () const {
		return ++m_counter;
	}

	virtual unsigned long __stdcall release () const {
		if (m_counter == 1) {
			delete this;
			return 0;
		}
		return --m_counter;
	}
	
private:
	typedef ACE_Singleton<Root_tie, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;

public:
	Root_tie () : m_counter (1) {
	}

	static Root_tie* instance() {
		return Singleton::instance();
	}

	// exported factories

	virtual void _stdcall make_stream_442807A00138 (
		GCI::IO::IStream_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::Stream_tie::make_tie (GCI::IO::StreamFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_stream_44312A6F0128 (
		const char* path
		, GCI::IO::IStream_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::Stream_tie::make_tie (GCI::IO::StreamFactory::make(path), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall alloc_string_43184161036A (
		unsigned long maximum
		, GCI::IO::IString_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::String_tie::make_tie (GCI::IO::StringFactory::alloc(maximum), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_string_461384D70213 (
		const char* str
		, GCI::IO::IString_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::String_tie::make_tie (GCI::IO::StringFactory::make(str), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_active_interval_list_45EED87E0383 (GblAdapterLib::ActiveIntervalList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ActiveIntervalList_tie::new_tie (new GblAdapterLib::ActiveIntervalList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_assembly_info_460919DE03B9 (
		GblAdapterLib::IAssemblyInfo_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::AssemblyInfo_tie::make_tie (GblAdapterLib::AssemblyInfoFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_attribute_info_460128C701A1 (
		const GblAdapterLib::AttributeTag tag
		, GblAdapterLib::IAttributeInfo_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::AttributeInfo_tie::make_tie (GblAdapterLib::AttributeInfoFactory::make(tag), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_attribute_list_4CC7D983022E (GblAdapterLib::AttributeList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::AttributeList_tie::new_tie (new GblAdapterLib::AttributeList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_attributes_helper_4CEA4EEF01E8 (
		GblAdapterLib::IAttributesHelper_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::AttributesHelper_tie::make_tie (GblAdapterLib::AttributesHelperFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_authorization_4609270F03C8 (
		GblAdapterLib::IAuthorization_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Authorization_tie::make_tie (GblAdapterLib::AuthorizationFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_blocks_filter_45F6A01A007D (
		GblAdapterLib::IBlocksFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::BlocksFilter_tie::make_tie (GblAdapterLib::BlocksFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_bookmark_list_4C5ABD7603D1 (GblAdapterLib::BookmarkList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::BookmarkList_tie::new_tie (new GblAdapterLib::BookmarkList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_chat_manager_4A4099B701A8 (
		GblAdapterLib::ChatInterfaces::IChatManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ChatInterfaces::ChatManager_tie::make_tie (&GblAdapterLib::ChatInterfaces::ChatManagerFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_comments_para_list_4D147CA200AE (GblAdapterLib::CommentsParaList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::CommentsParaList_tie::new_tie (new GblAdapterLib::CommentsParaList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_common_460A43770251 (
		GblAdapterLib::ICommon_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Common_tie::make_tie (GblAdapterLib::CommonFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_complect_info_45F16A9002C0 (
		GblAdapterLib::IComplectInfo_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ComplectInfo_tie::make_tie (GblAdapterLib::ComplectInfoFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_component_manager_474C117B0280 (
		GblAdapterLib::IComponentManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ComponentManager_tie::make_tie (&GblAdapterLib::ComponentManagerFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_configuration_45F11C98009C (
		long id
		, const GCI::IO::IString_tie* name
		, const GCI::IO::IString_tie* hint
		, bool readonly
		, GblAdapterLib::IConfiguration_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::String* name_ = 0;
		GCI::IO::String_tie::make_cpp(name, name_);
		GCI::IO::String* hint_ = 0;
		GCI::IO::String_tie::make_cpp(hint, hint_);
		GblAdapterLib::Configuration_tie::make_tie (GblAdapterLib::ConfigurationFactory::make(id, name_, hint_, readonly), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_configuration_manager_45F11C04001F (
		GblAdapterLib::IConfigurationManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ConfigurationManager_tie::make_tie (GblAdapterLib::ConfigurationManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_configurations_45EEDC7901B5 (GblAdapterLib::Configurations_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::Configurations_tie::new_tie (new GblAdapterLib::Configurations (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_consultation_manager_457026D700EA (
		GblAdapterLib::IConsultationManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ConsultationManager_tie::make_tie (GblAdapterLib::ConsultationManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_consulting_template_info_4CEBDE5D01AA (
		GblAdapterLib::IConsultingTemplateInfo_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ConsultingTemplateInfo_tie::make_tie (GblAdapterLib::ConsultingTemplateInfoFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_context_filter_45F6A01A007D (
		GblAdapterLib::IContextFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ContextFilter_tie::make_tie (GblAdapterLib::ContextFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_context_list_4CA32AC30364 (GblAdapterLib::ContextList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ContextList_tie::new_tie (new GblAdapterLib::ContextList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_context_value_list_45EEE3F80286 (GblAdapterLib::ContextValueList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ContextValueList_tie::new_tie (new GblAdapterLib::ContextValueList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_context_word_list_45F1163501EF (GblAdapterLib::ContextWordList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ContextWordList_tie::new_tie (new GblAdapterLib::ContextWordList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_control_manager_45FA9A5D0124 (
		GblAdapterLib::IControlManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ControlManager_tie::make_tie (&GblAdapterLib::ControlManagerFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_controlled_objects_45F118FC0312 (GblAdapterLib::ControlledObjects_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ControlledObjects_tie::new_tie (new GblAdapterLib::ControlledObjects (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_country_filter_47F7267701D5 (
		const GblAdapterLib::INodeBase_tie* country
		, GblAdapterLib::ICountryFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::NodeBase* country_ = 0;
		GblAdapterLib::NodeBase_tie::make_cpp(country, country_);
		GblAdapterLib::CountryFilter_tie::make_tie (GblAdapterLib::CountryFilterFactory::make(country_), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_country_filter_45F6A01A007D (
		GblAdapterLib::ICountryFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::CountryFilter_tie::make_tie (GblAdapterLib::CountryFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_cut_to_leaf_count_filter_483548E800F4 (
		unsigned long leaf_count
		, GblAdapterLib::ICutToLeafCountFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::CutToLeafCountFilter_tie::make_tie (GblAdapterLib::CutToLeafCountFilterFactory::make(leaf_count), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_cut_to_leaf_count_filter_45F6A01A007D (
		GblAdapterLib::ICutToLeafCountFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::CutToLeafCountFilter_tie::make_tie (GblAdapterLib::CutToLeafCountFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_date_value_list_45EEE59E01F7 (GblAdapterLib::DateValueList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::DateValueList_tie::new_tie (new GblAdapterLib::DateValueList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_decisions_archive_support_4F71D0930146 (
		GblAdapterLib::IDecisionsArchiveSupport_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::DecisionsArchiveSupport_tie::make_tie (GblAdapterLib::DecisionsArchiveSupportFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_default_values_changes_indicator_45F11E8A00FA (
		GblAdapterLib::DefaultValuesChangesState state
		, const GblAdapterLib::IConfiguration_tie* configuration
		, GblAdapterLib::IDefaultValuesChangesIndicator_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Configuration* configuration_ = 0;
		GblAdapterLib::Configuration_tie::make_cpp(configuration, configuration_);
		GblAdapterLib::DefaultValuesChangesIndicator_tie::make_tie (GblAdapterLib::DefaultValuesChangesIndicatorFactory::make(state, configuration_), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_diff_doc_data_provider_4D78DFAF0175 (
		const GblAdapterLib::IDocument_tie* left
		, const GblAdapterLib::IDocument_tie* right
		, GblAdapterLib::IDiffDocDataProvider_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Document* left_ = 0;
		GblAdapterLib::Document_tie::make_cpp(left, left_);
		GblAdapterLib::Document* right_ = 0;
		GblAdapterLib::Document_tie::make_cpp(right, right_);
		GblAdapterLib::DiffDocDataProvider_tie::make_tie (GblAdapterLib::DiffDocDataProviderFactory::make(left_, right_), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_diff_doc_para_list_4D78D65C01FF (GblAdapterLib::DiffDocParaList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::DiffDocParaList_tie::new_tie (new GblAdapterLib::DiffDocParaList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_doc_list_factory_4D95C73000CF (
		GblAdapterLib::IDocListFactory_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::DocListFactory_tie::make_tie (GblAdapterLib::DocListFactoryFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_doc_node_filter_45F6A01A007D (
		GblAdapterLib::IDocNodeFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::DocNodeFilter_tie::make_tie (GblAdapterLib::DocNodeFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_doc_point_list_4DCBBAEF025F (GblAdapterLib::DocPointList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::DocPointList_tie::new_tie (new GblAdapterLib::DocPointList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_document_state_4628CE6F02EA (
		GblAdapterLib::IDocument_tie* source_doc
		, GblAdapterLib::IDocumentState_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Document* source_doc_ = 0;
		GblAdapterLib::Document_tie::make_cpp(source_doc, source_doc_);
		GblAdapterLib::DocumentState_tie::make_tie (GblAdapterLib::DocumentStateFactory::make(source_doc_), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_document_text_provider_descriptor_list_4D628F1402C0 (GblAdapterLib::DocumentTextProviderDescriptorList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::DocumentTextProviderDescriptorList_tie::new_tie (new GblAdapterLib::DocumentTextProviderDescriptorList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_document_text_provider_list_4CED493F01B9 (GblAdapterLib::DocumentTextProviderList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::DocumentTextProviderList_tie::new_tie (new GblAdapterLib::DocumentTextProviderList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_dyn_list_47FDCBAE0324 (
		GblAdapterLib::SpecialListKey key
		, GblAdapterLib::IDynList_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::DynList_tie::make_tie (GblAdapterLib::DynListFactory::make(key), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_estimation_45700DC8004E (
		GblAdapterLib::IEstimation_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Estimation_tie::make_tie (GblAdapterLib::EstimationFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_external_object_data_list_4D14813D02BB (GblAdapterLib::ExternalObjectDataList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ExternalObjectDataList_tie::new_tie (new GblAdapterLib::ExternalObjectDataList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_external_operation_45F577DE0283 (
		GblAdapterLib::ObjectId id
		, GblAdapterLib::IExternalOperation_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ExternalOperation_tie::make_tie (GblAdapterLib::ExternalOperationFactory::make(id), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_filter_list_45EEBD050271 (GblAdapterLib::FilterList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::FilterList_tie::new_tie (new GblAdapterLib::FilterList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_filtered_4D3D28610043 (GblAdapterLib::Filtered_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::Filtered_tie::new_tie (new GblAdapterLib::Filtered (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_filters_from_query_45EEB14402F9 (GblAdapterLib::FiltersFromQuery_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::FiltersFromQuery_tie::new_tie (new GblAdapterLib::FiltersFromQuery (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_filters_manager_4CA49E130064 (
		GblAdapterLib::IFiltersManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::FiltersManager_tie::make_tie (GblAdapterLib::FiltersManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_find_position_list_45EEC2C0005D (GblAdapterLib::FindPositionList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::FindPositionList_tie::new_tie (new GblAdapterLib::FindPositionList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_folders_45EED7B8013A (
		GblAdapterLib::IFolders_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Folders_tie::make_tie (&GblAdapterLib::FoldersFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_fragment_list_4D39697600E4 (GblAdapterLib::FragmentList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::FragmentList_tie::new_tie (new GblAdapterLib::FragmentList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_highlight_position_list_456FED7501C5 (GblAdapterLib::HighlightPositionList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::HighlightPositionList_tie::new_tie (new GblAdapterLib::HighlightPositionList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_inpharm_filter_45F6A01A007D (
		GblAdapterLib::IInpharmFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::InpharmFilter_tie::make_tie (GblAdapterLib::InpharmFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_integration_463F5060029F (
		GblAdapterLib::IIntegration_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Integration_tie::make_tie (GblAdapterLib::IntegrationFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_internet_support_4BD1393B0146 (
		GblAdapterLib::IInternetSupport_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::InternetSupport_tie::make_tie (GblAdapterLib::InternetSupportFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_journal_bookmark_list_4A8A9DCF030D (GblAdapterLib::JournalBookmarkList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::JournalBookmarkList_tie::new_tie (new GblAdapterLib::JournalBookmarkList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_keys_list_4BE3CED001A4 (GblAdapterLib::KeysList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::KeysList_tie::new_tie (new GblAdapterLib::KeysList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_languages_list_456EE8920119 (GblAdapterLib::LanguagesList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::LanguagesList_tie::new_tie (new GblAdapterLib::LanguagesList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_layer_filter_45F6A01A007D (
		GblAdapterLib::ILayerFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::LayerFilter_tie::make_tie (GblAdapterLib::LayerFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_layer_id_list_45EEC80F0128 (GblAdapterLib::LayerIdList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::LayerIdList_tie::new_tie (new GblAdapterLib::LayerIdList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_log_event_data_45ED5A8C03B1 (
		GblAdapterLib::ILogEventData_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::LogEventData_tie::make_tie (GblAdapterLib::LogEventDataFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_log_manager_45ED5A0A021D (
		GblAdapterLib::ILogManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::LogManager_tie::make_tie (GblAdapterLib::LogManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_main_menu_4DD251830230 (
		GblAdapterLib::IMainMenu_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::MainMenu_tie::make_tie (&GblAdapterLib::MainMenuFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_messages_4A40A5670265 (GblAdapterLib::ChatInterfaces::Messages_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ChatInterfaces::Messages_tie::new_tie (new GblAdapterLib::ChatInterfaces::Messages (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_messages_manager_4A40A59901F4 (
		GblAdapterLib::ChatInterfaces::IMessagesManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::ChatInterfaces::MessagesManager_tie::make_tie (&GblAdapterLib::ChatInterfaces::MessagesManagerFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_monitoring_45EEC16B01A1 (
		GblAdapterLib::IMonitoring_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Monitoring_tie::make_tie (GblAdapterLib::MonitoringFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_node_4602879E0119 (
		GblAdapterLib::INode_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Node_tie::make_tie (GblAdapterLib::NodeFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_node_base_45F6694A01B5 (
		const char* key
		, GblAdapterLib::INodeBase_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::NodeBase_tie::make_tie (GblAdapterLib::NodeBaseFactory::make(key), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_node_id_list_483EC24E0308 (GblAdapterLib::NodeIdList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::NodeIdList_tie::new_tie (new GblAdapterLib::NodeIdList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_node_index_path_45EEC8680109 (GblAdapterLib::NodeIndexPath_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::NodeIndexPath_tie::new_tie (new GblAdapterLib::NodeIndexPath (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_node_iterator_473DCB1102C4 (
		GblAdapterLib::INodeIterator_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::NodeIterator_tie::make_tie (GblAdapterLib::NodeIteratorFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_node_value_list_45EEE6220215 (GblAdapterLib::NodeValueList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::NodeValueList_tie::new_tie (new GblAdapterLib::NodeValueList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_nodes_clipboard_4600E43B0232 (
		GblAdapterLib::INodesClipboard_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::NodesClipboard_tie::make_tie (GblAdapterLib::NodesClipboardFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_not_sure_interval_list_45EED88901BE (GblAdapterLib::NotSureIntervalList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::NotSureIntervalList_tie::new_tie (new GblAdapterLib::NotSureIntervalList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_notify_manager_45F80136005E (
		GblAdapterLib::INotifyManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::NotifyManager_tie::make_tie (&GblAdapterLib::NotifyManagerFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_operation_list_45EEE7390252 (GblAdapterLib::OperationList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::OperationList_tie::new_tie (new GblAdapterLib::OperationList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_paras_list_4CEBCFD7003C (GblAdapterLib::ParasList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::ParasList_tie::new_tie (new GblAdapterLib::ParasList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_permanent_settings_manager_4AC49AB80031 (
		GblAdapterLib::IPermanentSettingsManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::PermanentSettingsManager_tie::make_tie (GblAdapterLib::PermanentSettingsManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_position_list_45EEB65202EF (GblAdapterLib::PositionList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::PositionList_tie::new_tie (new GblAdapterLib::PositionList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_prefix_node_4683751B006A (
		GblAdapterLib::IPrefixNode_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::PrefixNode_tie::make_tie (GblAdapterLib::PrefixNodeFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall get_contract_data_prime_contract_data_4D381CAD0282 (
		GblAdapterLib::IQuery_tie* query
		, GblAdapterLib::IPrimeContractData_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Query* query_ = 0;
		GblAdapterLib::Query_tie::make_cpp(query, query_);
		GblAdapterLib::PrimeContractData_tie::make_tie (GblAdapterLib::PrimeContractDataFactory::get_contract_data(query_), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_prime_list_47BEE49E0351 (GblAdapterLib::PrimeList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::PrimeList_tie::new_tie (new GblAdapterLib::PrimeList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_prime_manager_47BEE1810005 (
		GblAdapterLib::IPrimeManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::PrimeManager_tie::make_tie (&GblAdapterLib::PrimeManagerFactory::make(), ret_, true /*addref*/);
		_DLL_CATCH
	}

	virtual void _stdcall make_prime_settings_manager_4C98A6130388 (
		GblAdapterLib::IPrimeSettingsManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::PrimeSettingsManager_tie::make_tie (GblAdapterLib::PrimeSettingsManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_property_string_id_list_4979D9140170 (GblAdapterLib::PropertyStringIDList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::PropertyStringIDList_tie::new_tie (new GblAdapterLib::PropertyStringIDList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_query_45FFA1AA01D0 (
		GblAdapterLib::QueryType type
		, GblAdapterLib::IQuery_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Query_tie::make_tie (GblAdapterLib::QueryFactory::make(type), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_query_attribute_list_45EEE25C0373 (GblAdapterLib::QueryAttributeList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::QueryAttributeList_tie::new_tie (new GblAdapterLib::QueryAttributeList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall create_query_card_info_4CC7E1EC001C (
		const char* key
		, GblAdapterLib::IQueryCardInfo_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::QueryCardInfo_tie::make_tie (GblAdapterLib::QueryCardInfoFactory::create(key), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_query_context_attribute_45FFE4CA02FD (
		const GblAdapterLib::AttributeTag attribute_tag
		, GblAdapterLib::IQueryContextAttribute_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::QueryContextAttribute_tie::make_tie (GblAdapterLib::QueryContextAttributeFactory::make(attribute_tag), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_query_date_attribute_45FFE4EA02AF (
		const GblAdapterLib::AttributeTag attribute_tag
		, GblAdapterLib::IQueryDateAttribute_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::QueryDateAttribute_tie::make_tie (GblAdapterLib::QueryDateAttributeFactory::make(attribute_tag), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_query_list_45EEE1BC02F7 (GblAdapterLib::QueryList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::QueryList_tie::new_tie (new GblAdapterLib::QueryList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_query_node_attribute_45FFE4E60138 (
		const GblAdapterLib::AttributeTag attribute_tag
		, GblAdapterLib::IQueryNodeAttribute_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::QueryNodeAttribute_tie::make_tie (GblAdapterLib::QueryNodeAttributeFactory::make(attribute_tag), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_query_phone_number_attribute_45FFE4F3030C (
		const GblAdapterLib::AttributeTag attribute_tag
		, GblAdapterLib::IQueryPhoneNumberAttribute_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::QueryPhoneNumberAttribute_tie::make_tie (GblAdapterLib::QueryPhoneNumberAttributeFactory::make(attribute_tag), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_redaction_info_list_45EED8DE0121 (GblAdapterLib::RedactionInfoList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::RedactionInfoList_tie::new_tie (new GblAdapterLib::RedactionInfoList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_redaction_source_document_info_list_51FB7643002D (GblAdapterLib::RedactionSourceDocumentInfoList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::RedactionSourceDocumentInfoList_tie::new_tie (new GblAdapterLib::RedactionSourceDocumentInfoList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_search_460125C20341 (
		GblAdapterLib::ISearch_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Search_tie::make_tie (GblAdapterLib::SearchFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_search_entity_456EE2B102EE (
		GblAdapterLib::SearchResultType result_type
		, size_t document_count
		, size_t entry_count
		, size_t edition_count
		, GblAdapterLib::ISearchEntity_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::SearchEntity_tie::make_tie (GblAdapterLib::SearchEntityFactory::make(result_type, document_count, entry_count, edition_count), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_section_item_list_4E36C8550143 (GblAdapterLib::SectionItemList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::SectionItemList_tie::new_tie (new GblAdapterLib::SectionItemList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_sort_filter_45F6A01A007D (
		GblAdapterLib::ISortFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::SortFilter_tie::make_tie (GblAdapterLib::SortFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_sort_types_45EEDB9B038E (GblAdapterLib::SortTypes_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::SortTypes_tie::new_tie (new GblAdapterLib::SortTypes (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_stop_watch_45F6ABAD0006 (
		const char* context
		, GblAdapterLib::IStopWatch_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::StopWatch_tie::make_tie (GblAdapterLib::StopWatchFactory::make(context), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_stop_watch_ex_45F6AB6201EB (
		const char* id
		, const char* context
		, GblAdapterLib::IStopWatchEx_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::StopWatchEx_tie::make_tie (GblAdapterLib::StopWatchExFactory::make(id, context), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_string_list_457453C10000 (GblAdapterLib::StringList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::StringList_tie::new_tie (new GblAdapterLib::StringList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_sub_list_4C9B41F302A7 (GblAdapterLib::SubList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::SubList_tie::new_tie (new GblAdapterLib::SubList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_tips_manager_47B30CFF0271 (
		GblAdapterLib::ITipsManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::TipsManager_tie::make_tie (GblAdapterLib::TipsManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_trim_filter_45F6A01A007D (
		GblAdapterLib::ITrimFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::TrimFilter_tie::make_tie (GblAdapterLib::TrimFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_trim_leaf_filter_45F6A01A007D (
		GblAdapterLib::ITrimLeafFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::TrimLeafFilter_tie::make_tie (GblAdapterLib::TrimLeafFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_uid_list_4651A5AE00FA (GblAdapterLib::UidList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::UidList_tie::new_tie (new GblAdapterLib::UidList (), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_user_filter_45F6A01A007D (
		GblAdapterLib::IUserFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::UserFilter_tie::make_tie (GblAdapterLib::UserFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_user_journal_4A7FFC1801CF (
		GblAdapterLib::IUserJournal_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::UserJournal_tie::make_tie (GblAdapterLib::UserJournalFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_user_manager_4607D6430177 (
		GblAdapterLib::IUserManager_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::UserManager_tie::make_tie (GblAdapterLib::UserManagerFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_user_profile_4608D6F501F4 (
		GblAdapterLib::IUserProfile_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::UserProfile_tie::make_tie (GblAdapterLib::UserProfileFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_variant_4602A882007D (
		GblAdapterLib::IVariant_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Variant_tie::make_tie (GblAdapterLib::VariantFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_bool_variant_456EEA5F005D (
		bool value
		, GblAdapterLib::IVariant_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Variant_tie::make_tie (GblAdapterLib::VariantFactory::make_bool(value), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_long_variant_456EE9DF038A (
		long value
		, GblAdapterLib::IVariant_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::Variant_tie::make_tie (GblAdapterLib::VariantFactory::make_long(value), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_object_variant_456EEA9C01E4 (
		Core::IIObject_tie* value
		, GblAdapterLib::IVariant_tie*& ret_
	) {
		_DLL_TRY
		Core::IObject* value_ = 0;
		Core::IObject_tie::make_cpp(value, value_);
		GblAdapterLib::Variant_tie::make_tie (GblAdapterLib::VariantFactory::make_object(value_), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_string_variant_456EEA7E0261 (
		GCI::IO::IString_tie* value
		, GblAdapterLib::IVariant_tie*& ret_
	) {
		_DLL_TRY
		GCI::IO::String* value_ = 0;
		GCI::IO::String_tie::make_cpp(value, value_);
		GblAdapterLib::Variant_tie::make_tie (GblAdapterLib::VariantFactory::make_string(value_), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_variants_for_doc_filter_4AA0FEB300BC (
		unsigned long doc_id
		, GblAdapterLib::IVariantsForDocFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::VariantsForDocFilter_tie::make_tie (GblAdapterLib::VariantsForDocFilterFactory::make(doc_id), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_variants_for_doc_filter_45F6A01A007D (
		GblAdapterLib::IVariantsForDocFilter_tie*& ret_
	) {
		_DLL_TRY
		GblAdapterLib::VariantsForDocFilter_tie::make_tie (GblAdapterLib::VariantsForDocFilterFactory::make(), ret_);
		_DLL_CATCH
	}

	virtual void _stdcall make_visual_representation_list_53E0C7FD03B0 (GblAdapterLib::VisualRepresentationList_tie*& ret_) {
		_DLL_TRY
		GblAdapterLib::VisualRepresentationList_tie::new_tie (new GblAdapterLib::VisualRepresentationList (), ret_);
		_DLL_CATCH
	}


};

} //namespace GblAdapter



#endif //__GARANT6X_GBLADAPTER_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
