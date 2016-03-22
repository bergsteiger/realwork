////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Document_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentMaster.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/RedactionInfoListHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"
#include "shared/GCI/I18N/I18N.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/TranslatedDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DocStatusConverter.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ExternalObjectTypeConvertor.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport.h"
#include "garantServer/src/Global/Core/Common/Operators.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
const unsigned long Document_i::OID_NOT_SHURE_WARNING_DOC = 3885711+100000;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Document_i::Document_i ()
//#UC START# *47569959037A_BASE_INIT*
	: m_has_next_redaction_ (-1)
	, m_has_prev_redaction_ (-1)
	, m_loaded (false)
	, m_doc_size (GblPilotDef::DS_UNKNOWN_SIZE)
	, m_current_state (new DocumentState_i ())
	, m_doc_part_mask (0)
	, m_status_changes_updated (false)
	, m_status_changes (0)
	, m_last_check (0,0,0)
	, m_contents_data_loaded (false)
	, m_correspondent_mask (0)
	, m_respondent_mask (0)
	, m_yellow_time_machine_warning (boost::indeterminate)
	, m_can_like (boost::indeterminate)
	, m_warning_impl (0)
	, m_short_name_impl (0)
	, m_status_impl (IS_UNKNOWN)
//#UC END# *47569959037A_BASE_INIT*
{
	//#UC START# *47569959037A_BODY*
	m_current_state->m_source_doc = this;
	this->start_listen_common ();
	//#UC END# *47569959037A_BODY*
}

Document_i::Document_i (GblPilot::Document* document)
//#UC START# *49BE24D301BC_BASE_INIT*
	: m_has_next_redaction_ (-1)
	, m_has_prev_redaction_ (-1)
	, m_loaded (false)
	, m_doc_size (GblPilotDef::DS_UNKNOWN_SIZE)
	, m_current_state (new DocumentState_i ())
	, m_doc_part_mask (0)
	, m_status_changes_updated (false)
	, m_status_changes (0)
	, m_last_check (0,0,0)
	, m_contents_data_loaded (false)
	, m_correspondent_mask (0)
	, m_respondent_mask (0)
	, m_yellow_time_machine_warning (boost::indeterminate)
	, m_can_like (boost::indeterminate)
	, m_warning_impl (0)
	, m_short_name_impl (0)
	, m_status_impl (IS_UNKNOWN)
//#UC END# *49BE24D301BC_BASE_INIT*
{
	//#UC START# *49BE24D301BC_BODY*
	GDS_ASSERT (document);
	m_current_state->m_source_doc = this;
	m_document = GblPilot::Document::_duplicate (document);	
	this->start_listen_common ();
	//#UC END# *49BE24D301BC_BODY*
}

Document_i::Document_i (const char* name)
//#UC START# *49BE24D90262_BASE_INIT*
	: m_has_next_redaction_ (-1)
	, m_has_prev_redaction_ (-1)
	, m_loaded (false)
	, m_doc_size (GblPilotDef::DS_UNKNOWN_SIZE)
	, m_current_state (new DocumentState_i ())
	, m_doc_part_mask (0)
	, m_status_changes_updated (false)
	, m_status_changes (0)
	, m_last_check (0,0,0)
	, m_contents_data_loaded (false)
	, m_correspondent_mask (0)
	, m_respondent_mask (0)
	, m_yellow_time_machine_warning (boost::indeterminate)
	, m_can_like (boost::indeterminate)
	, m_warning_impl (0)
	, m_short_name_impl (0)
	, m_status_impl (IS_UNKNOWN)
//#UC END# *49BE24D90262_BASE_INIT*
{
	//#UC START# *49BE24D90262_BODY*
	m_current_state->m_source_doc = this;

	if (name) {
		m_short_name_impl = GCI::IO::StringFactory::make (name);
	}
	this->start_listen_common ();
	//#UC END# *49BE24D90262_BODY*
}

Document_i::~Document_i () {
	//#UC START# *45740ADE0119_DESTR_BODY*
	try {
		if (!CORBA::is_nil (m_document)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_document.in ());
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}

	try {
		this->stop_listen_common (); 
	} catch (...) {
		LOG_D (("%s: unknown exception catched", GDS_CURRENT_FUNCTION));
		GDS_ASSERT (false);
	}

	//#UC END# *45740ADE0119_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Document_i::build_extruct_list (GblPilotDef::SubParaList& sp_list) const {
	//#UC START# *460A648C00E2*
	// [zakharov]:
	if (m_current_state->m_new_state.appropriate_entry_in_list.is_nil () || !m_current_state->m_new_state.has_extruct) {
		sp_list.length (0);
	} else {
		sp_list = m_current_state->m_new_state.appropriate_entry_in_list->get_entry_list ();
	}
	// :[zakharov]
	//#UC END# *460A648C00E2*
}

const RedactionInfo& Document_i::get_current_redaction_info () const {
	//#UC START# *460BC55E001F*
	const RedactionInfoList& redactions_list = this->get_redactions_list ();
	if (!redactions_list.empty ()) {
		int ind = RedactionInfoListHelper::find_redaction (redactions_list, m_current_state->redaction ());
		if (ind >= 0) {
			return redactions_list [ind];
		}
	}
	throw CanNotFindData ();
	//#UC END# *460BC55E001F*
}

ExternalLink* Document_i::get_internet_image_url_i (long block_id) const {
	//#UC START# *465EBC2403D8*
	GblPilot::LegalDocument_var legal_document = GblPilot::LegalDocument::_narrow (this->get_server_doc());
	if (CORBA::is_nil (legal_document.in ())) {
		throw CanNotFindData ();
	} 
		
	CORBA::String_var url (legal_document->get_internet_image (block_id));
	return ExternalLinkFactory::make (url.in ());		
	//#UC END# *465EBC2403D8*
}

// получить тултип к ссылке
GCI::IO::String* Document_i::get_linked_hint (unsigned long doc_id, const Topic& id, RedactionID rid) const {
	//#UC START# *47AC531D02BF*
	Link_var link = 
		LinkFactory::make (doc_id, id, rid);
	return link->get_linked_hint ();
	//#UC END# *47AC531D02BF*
}

bool Document_i::has_same_redactions (const Document_i* comparable) const {
	//#UC START# *4E1D6754015C*
	return m_current_state->is_same_redactions (comparable->m_current_state.in ());
	//#UC END# *4E1D6754015C*
}

bool Document_i::is_date_in_not_sure_interval_i (const Date& date, NotSureInfo& not_sure_info) const {
	//#UC START# *460A624E003E*
	try {
		const RedactionInfo& curr_red = this->get_current_redaction_info ();
		for (size_t i = 0; i < curr_red.not_sure_intervals.size (); ++i) {
			const NotSureInfo& info = curr_red.not_sure_intervals [i];
			if ((info.interval.start <= date && date <= info.interval.finish)
				|| (info.interval.start <= date && info.interval.finish == Date ())
				|| (info.interval.start == Date () && date <= info.interval.finish)
			) {
				not_sure_info = info;
				return true;
			}
		}
	} catch (CanNotFindData&)	{
	}
	return false;
	//#UC END# *460A624E003E*
}

// // UC 72.5.2 пункт 3) [пункты 1) и 2) выполняются автоматически]
bool Document_i::is_yellow_medal_time_machine_warning (const Date& date, const Date& redaction_date) const {
	//#UC START# *4E16D3BF0021*	
	this->check_update_and_clear_cache ();

	if (boost::indeterminate (m_yellow_time_machine_warning)) {
		GblPilot::FunctionMng_ptr fm = ApplicationHelper::instance ()->get_cached_function_manager ();
		RedactionID redaction_id = m_current_state->redaction ();

		m_yellow_time_machine_warning = 
			date < redaction_date 
			&& fm->test_document_kind (GblPilotDef::DK_PRACTICE, redaction_id)
			&& !fm->is_document_not_active (redaction_id);
	}

	return m_yellow_time_machine_warning;
	//#UC END# *4E16D3BF0021*
}

void Document_i::load (GblPilotDef::ExtendedDocInfo* edi) const {
	//#UC START# *460A61D501D6*
	m_doc_part_mask = edi->parts_mask ();
	m_correspondent_mask  = edi->correspondent_mask ();
	m_respondent_mask  = edi->respondent_mask ();
		
	if (strcmp (edi->warning (), "")) {
		m_warning_impl = GCI::IO::StringFactory::make (edi->warning ());
	} else {
		m_warning_impl = 0;
	}
	{
	// Меняем короткое имя, только если документ жив или еще не заполнен
	if (m_short_name_impl.is_nil () || this->is_alive ()) {
		if (strcmp (edi->short_name (), "")) {
			m_short_name_impl =  GCI::IO::StringFactory::make (edi->short_name ());
		} else {
			m_short_name_impl = 0;
		}
	}
	}

	m_doc_size = edi->size ();
	m_status_impl = DocStatusConverterSingleton::instance ()->get (edi->status ());
	//#UC END# *460A61D501D6*
}

void Document_i::load_and_update () const {
	//#UC START# *460A6230032C*
	//Core::GDS::StopWatchEx sw ("Document_i::load_and_update");
	this->check_update_and_clear_cache ();

	if (!m_loaded) {
		try {
			GblPilotDef::ExtendedDocInfo_var edi = this->get_server_doc()->extended_info();
			this->load(edi);
		} catch (GCD::FeatureDisabled& ex) {
			LOG_CEXD ((ex, "%s: extended_info", GDS_CURRENT_FUNCTION));
		} catch (...) {
			LOG_E (("%s: extended_info", GDS_CURRENT_FUNCTION));
		}
		m_loaded = true;
	}
	//#UC END# *460A6230032C*
}

void Document_i::load_contents_data_if_empty () {
	//#UC START# *4D14922F02E7*
	if (m_contents_data_loaded) {
		return;
	}

	GUARD (m_contents_data_mutex);

	if (m_contents_data_loaded) {
		return;
	}

	GblPilot::FlatDocument_var doc = GblPilot::FlatDocument::_narrow (this->get_server_doc ());
	GDS_ASSERT (!CORBA::is_nil (doc));

	GblPilot::ContentsData_var data = doc->get_contents_data ();

	for (CORBA::ULong i = 0, length = data->bookmark_list.length (); i < length; ++i) {
		Bookmark2 bookmark;
		bookmark.para_id = data->bookmark_list [i].m_para;
		bookmark.eid     = data->bookmark_list [i].m_id;
		bookmark.name    = GCI::IO::StringFactory::make (data->bookmark_list [i].m_name.in ());
		m_bookmark_list.push_back (bookmark);	
	}

	for (CORBA::ULong i = 0, length = data->comments_para_list.length (); i < length; ++i) {
		m_comments_para_list.push_back (data->comments_para_list [i]);
	}

	for (CORBA::ULong i = 0, length = data->blob_list.length (); i < length; ++i) {

		ExternalObjectData object_data;
		try {
			object_data.type = ExternalObjectTypeConvertorSingleton::instance ()->get (data->blob_list [i].type); 
		} catch (Core::ElementNotFound&) {
			object_data.type = EOT_USR;
		}
		object_data.para_id = data->blob_list [i].para_id;
		object_data.name    = GCI::IO::StringFactory::make (data->blob_list [i].name.in ());

		m_external_object_data_list.push_back (object_data);
	}
		
	m_contents_data_loaded = true;
	//#UC END# *4D14922F02E7*
}

DocumentTextProvider* Document_i::make_text_provider (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) const {
	//#UC START# *504DDBB6016A*
	return DocumentTextProviderFactory::make (server_doc, handle, all_at_once);
	//#UC END# *504DDBB6016A*
}

RedactionID Document_i::redaction_id () const {
	//#UC START# *4E1D57210338*
	return this->m_current_state->redaction ();
	//#UC END# *4E1D57210338*
}

void Document_i::set_inner_state (const DocumentState_i* state) {
	//#UC START# *4E1D76E9027B*
	this->m_current_state->m_new_state = state->m_new_state;
	//#UC END# *4E1D76E9027B*
}

void Document_i::set_list_info (const ListEntryInfo* info) {
	//#UC START# *4E1D6EC0024F*
	m_current_state->set_appropriate_list_info (info);
	//#UC END# *4E1D6EC0024F*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

GblPilotDef::KindMask Document_i::get_correspondent_mask () const {
	//#UC START# *4DF086CD0340_GET_ACCESSOR*
	return m_correspondent_mask;
	//#UC END# *4DF086CD0340_GET_ACCESSOR*
}

GblPilotDef::DocumentPartsMask Document_i::get_doc_part_mask () const {
	//#UC START# *460A2FF40102_GET_ACCESSOR*
	return m_doc_part_mask;
	//#UC END# *460A2FF40102_GET_ACCESSOR*
}

GblPilotDef::DocumentSize Document_i::get_doc_size () const {
	//#UC START# *460A3215038F_GET_ACCESSOR*
	return m_doc_size;
	//#UC END# *460A3215038F_GET_ACCESSOR*
}

GblPilot::Document* Document_i::get_document () const {
	//#UC START# *460A2E29027C_GET_ACCESSOR*
	return GblPilot::Document::_narrow (m_document.ptr ());
	//#UC END# *460A2E29027C_GET_ACCESSOR*
}

void Document_i::set_document (GblPilot::Document* document) const {
	//#UC START# *460A2E29027C_SET_ACCESSOR*
	m_document = document;
	//#UC END# *460A2E29027C_SET_ACCESSOR*
}

char Document_i::get_has_next_redaction_ () const {
	//#UC START# *460A2EDA0123_GET_ACCESSOR*
	return m_has_next_redaction_;
	//#UC END# *460A2EDA0123_GET_ACCESSOR*
}

char Document_i::get_has_prev_redaction_ () const {
	//#UC START# *460A2FC30141_GET_ACCESSOR*
	return m_has_prev_redaction_;
	//#UC END# *460A2FC30141_GET_ACCESSOR*
}

bool Document_i::get_loaded () const {
	//#UC START# *460A30250056_GET_ACCESSOR*
	return m_loaded;
	//#UC END# *460A30250056_GET_ACCESSOR*
}

const GCI::IO::String* Document_i::get_name_impl () const {
	//#UC START# *460A31E30063_GET_ACCESSOR*
	return m_name_impl._sretn ();
	//#UC END# *460A31E30063_GET_ACCESSOR*
}

GblPilotDef::KindMask Document_i::get_respondent_mask () const {
	//#UC START# *4DF0870201C6_GET_ACCESSOR*
	return m_respondent_mask;
	//#UC END# *4DF0870201C6_GET_ACCESSOR*
}

const GCI::IO::String* Document_i::get_short_name_impl () const {
	//#UC START# *460A32010331_GET_ACCESSOR*
	return m_short_name_impl._sretn ();
	//#UC END# *460A32010331_GET_ACCESSOR*
}

ItemStatus Document_i::get_status_impl () const {
	//#UC START# *46C1C2D100FB_GET_ACCESSOR*
	return m_status_impl;
	//#UC END# *46C1C2D100FB_GET_ACCESSOR*
}

const std::string& Document_i::get_time_machine_warning_string () const {
	//#UC START# *460A304800E2_GET_ACCESSOR*
	return m_time_machine_warning_string;
	//#UC END# *460A304800E2_GET_ACCESSOR*
}

const Document* Document_i::get_translation_impl () const {
	//#UC START# *460A323500A1_GET_ACCESSOR*
	return m_translation_impl._sretn ();
	//#UC END# *460A323500A1_GET_ACCESSOR*
}

const GCI::IO::String* Document_i::get_warning_impl () const {
	//#UC START# *460A2E5D0068_GET_ACCESSOR*
	return m_warning_impl._sretn ();
	//#UC END# *460A2E5D0068_GET_ACCESSOR*
}

//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors

const Document_i::AOM& Document_i::get_aom () {
	//#UC START# *460A5E550183_GET_ACCESSOR*
	 return AomSingleton::instance ()->ptr;
	//#UC END# *460A5E550183_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void Document_i::clear_cache () {
	//#UC START# *45702DA9037A_45740ADE0119*
	m_loaded = false;
	m_has_next_redaction_ = -1;
	m_has_prev_redaction_ = -1;
	m_attributes_root = 0;

	m_name_impl = 0;

	m_status_changes_updated = false;
	m_status_changes = 0;
	ACE_OS::memset (&m_last_check, 0, sizeof (m_last_check));

	m_yellow_time_machine_warning = boost::indeterminate;
	m_can_like = boost::indeterminate;
	//m_doc_part_mask = 0xFFFFFFFF;
	//m_warning = 0; - ???
	//#UC END# *45702DA9037A_45740ADE0119*
}

// implemented method from Controllable
// Получить объект на контроле.
Core::IObject* Document_i::open () {
	//#UC START# *45EEC17501B8_45740ADE0119*
	return Core::IObject::_duplicate (this);
	//#UC END# *45EEC17501B8_45740ADE0119*
}

// implemented method from Document
const NodeBase* Document_i::get_attributes_root () const {
	//#UC START# *45EEC00F006F_45740ADE0119_GET*
	this->load_and_update ();
	
	if (this->may_show_attributes ()) {
		if (m_attributes_root.is_nil ()) {
			try {
				GTree::Tree_var attributes_tree (this->get_server_doc ()->get_attributes ());
				Core::Var <AttributeTree> tree (new AttributeTree (attributes_tree.in ()));
				m_attributes_root = dynamic_cast<NodeBase*> (tree->root ());
			} catch (GCD::CanNotFindData&) {
				throw CanNotFindData ();
			} catch (GCD::AccessDenied&) {
				throw AccessDenied ();
			}
		}
		return m_attributes_root._sretn ();
	} else {
		throw AccessDenied ();
	}
	//#UC END# *45EEC00F006F_45740ADE0119_GET*
}

NodeBase* Document_i::get_attributes_root () {
	return const_cast<NodeBase*>(((const Document_i*)this)->get_attributes_root ());
}

// implemented method from Document
const BookmarkList& Document_i::get_bookmark_list () const {
	//#UC START# *4D147C7602A6_45740ADE0119_GET*
	const_cast<Document_i*>(this)->load_contents_data_if_empty ();
	return m_bookmark_list;
	//#UC END# *4D147C7602A6_45740ADE0119_GET*
}

// implemented method from Document
// Статус изменения документа
const unsigned long Document_i::get_change_status () const {
	//#UC START# *4D7E231702E4_45740ADE0119_GET*
	time_t time;
	struct tm current;
	Date current_date;
	if (ACE_OS::time (&time) != (time_t)-1 && ACE_OS::gmtime_r (&time, &current) != NULL) {
		current_date.year = static_cast<short> (current.tm_year) + 1900;
		current_date.month = static_cast<short> (current.tm_mon) + 1;
		current_date.day = static_cast<short> (current.tm_mday);
	} else {
		LOG_W (("%s: can't get current date", GDS_CURRENT_FUNCTION));
	}
	this->check_update_and_clear_cache ();
	if (!m_status_changes_updated || m_last_check != current_date) {
		this->get_server_doc()->update_status_changes ();
		m_status_changes = this->get_server_doc()->get_status_changes ();
		m_status_changes_updated = true;
		m_last_check = current_date;
	}
	return m_status_changes;
	//#UC END# *4D7E231702E4_45740ADE0119_GET*
}

// implemented method from Document
const CommentsParaList& Document_i::get_comments_para_list () const {
	//#UC START# *4D147CCA0051_45740ADE0119_GET*
	const_cast<Document_i*>(this)->load_contents_data_if_empty ();
	return m_comments_para_list;
	//#UC END# *4D147CCA0051_45740ADE0119_GET*
}

// implemented method from Document
const NodeBase* Document_i::get_contents_root () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *4C77A3370186_45740ADE0119_GET*
	this->load_and_update ();
	GTree::Tree_var server_tree;
	try {
		GblPilot::FlatDocument_var doc = GblPilot::FlatDocument::_narrow (this->get_server_doc ());
		GDS_ASSERT (!CORBA::is_nil (doc));
		server_tree = doc->get_contents_tree ();
	} catch (GCD::StorageInternalError&) {
		throw InternalDatabaseError ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (GCD::InvalidLanguage&) {
		throw CanNotFindData ();
	}

	Core::Var<ContentsTree> adapter_tree (new ContentsTree (server_tree.in ()));
	return dynamic_cast<NodeBase*> (adapter_tree->root ());
	//#UC END# *4C77A3370186_45740ADE0119_GET*
}

NodeBase* Document_i::get_contents_root ()
	/*throw (CanNotFindData)*/
{
	return const_cast<NodeBase*>(((const Document_i*)this)->get_contents_root ());
}

// implemented method from Document
// Создает экземпляр Закладки на заданный идентификатор параграфа. Присваивает ей в качестве
// названия короткое имя документа. А в качестве full_name имя документа и имя ближайшего (сверху)
// саба или блока (как в списках).
Bookmark* Document_i::create_bookmark (ParaId para, bool is_para) const {
	//#UC START# *45EEB6520194_45740ADE0119*
	try {
		GblPilotDef::Bookmark pilot_bookmark;
		pilot_bookmark.id = this->get_redaction_pid ();
		pilot_bookmark.para = is_para
		 	? para 
			: ApplicationHelper::instance ()->get_cached_function_manager ()->sub_to_para (pilot_bookmark.id, para)
		;
		return Core::TypeTraits<Bookmark>::Factory::make (pilot_bookmark, 0/*doc_bookmark*/, 0/*folders_node*/);
	} catch (GCD::FeatureDisabled&) {
		throw Unsupported ();
	}
	//#UC END# *45EEB6520194_45740ADE0119*
}

// implemented method from Document
// Создать журнальную закладку
JournalBookmark* Document_i::create_journal_bookmark (ParaId para) const {
	//#UC START# *4A8A9AD600BC_45740ADE0119*
	return Core::TypeTraits<JournalBookmark>::Factory::make (this->get_document_pid ().m_object_id, para);
	//#UC END# *4A8A9AD600BC_45740ADE0119*
}

// implemented method from Document
// Возвращает документ - редакцию, заказанную через  filters.
// Если текущая редакция равна заказанной - возвращает NULL
Document* Document_i::create_view (DocumentState* filters) {
	//#UC START# *45EEB6520197_45740ADE0119*
	DocumentState_i* new_state = dynamic_cast<DocumentState_i*> (filters);	
	if (!new_state) {
		return 0;
	}

	if (!(*(m_current_state.ptr ()) == *new_state)) {
		if (DocumentMaster* master = const_cast<DocumentMaster*> (this->get_master ())) {
			if (master != this) {
				Document* out_document = master->create_view (filters);
				return out_document ? out_document : Core::IObject::_duplicate (master);
			} else {
				return Core::TypeTraits<DocumentDelegate>::Factory::make (master, new_state);
			}
		}
	}
	return 0;
	//#UC END# *45EEB6520197_45740ADE0119*
}

// implemented method from Document
const DocumentState* Document_i::get_current_state () const {
	//#UC START# *45EED98D00E1_45740ADE0119_GET*
	return Core::TypeTraits<DocumentState_i>::Factory::make (const_cast<Document_i*> (this));
	//#UC END# *45EED98D00E1_45740ADE0119_GET*
}

DocumentState* Document_i::get_current_state () {
	return const_cast<DocumentState*>(((const Document_i*)this)->get_current_state ());
}

// implemented method from Document
DiffData* Document_i::diff (const GCD::PID& pid) const {
	//#UC START# *4CC8134700E6_45740ADE0119*
	this->load_and_update ();
	
	GblPilot::DiffData_var server_data;
	try {
		GblPilot::LegalDocument_var server_doc = GblPilot::LegalDocument::_narrow (this->get_server_doc ());
		GDS_ASSERT (!CORBA::is_nil (server_doc));
		server_data = server_doc->diff (pid);
	} catch (GCD::StorageInternalError&) {
		throw InternalDatabaseError ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}

	GblPilot::Document_var prev_server_doc = ApplicationHelper::instance ()->get_cached_function_manager ()->get_document (pid); // LifeCycle::duplicate_object

	Core::Aptr<DiffData> data = new DiffData;
	data->cur  = DocumentTextProviderFactory::make (this->get_server_doc (), server_data->cur, false /*all_at_once*/ );
	data->prev = DocumentTextProviderFactory::make (prev_server_doc, server_data->prev, false /*all_at_once*/ );	
	data->diff_iterator = DiffIteratorFactory::make (server_data);
	
	ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (prev_server_doc.in ()); // LifeCycle::release_object
	

	return data._retn ();	
	//#UC END# *4CC8134700E6_45740ADE0119*
}

// implemented method from Document
DocumentType Document_i::get_doc_type () const {
	//#UC START# *460B80CF0201_45740ADE0119_GET*
	this->load_and_update ();
	if (m_doc_part_mask & GblPilotDef::DPM_BOOK) {
		return DT_BOOK;
	}
	
	return DT_DOCUMENT;
	//#UC END# *460B80CF0201_45740ADE0119_GET*
}

// implemented method from Document
// Не показывать статус изменения данного документа в текущей сессии
void Document_i::dont_show_document_status_changes_warning () const {
	//#UC START# *4F1E5DE102BE_45740ADE0119*
	this->get_server_doc ()->dont_show_document_status_changes_warning ();
	//#UC END# *4F1E5DE102BE_45740ADE0119*
}

// implemented method from Document
const ExternalObjectDataList& Document_i::get_external_object_data_list () const {
	//#UC START# *4D14816D015F_45740ADE0119_GET*
	const_cast<Document_i*>(this)->load_contents_data_if_empty ();
	return m_external_object_data_list;
	//#UC END# *4D14816D015F_45740ADE0119_GET*
}

// implemented method from Document
const GCI::IO::String* Document_i::get_file_position () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *496B249601F3_45740ADE0119_GET*
	try {
		return GCI::IO::StringFactory::make (CORBA::String_var (this->get_server_doc()->get_file_position ()).in ());
	} catch (GCD::FeatureDisabled&) {
		throw CanNotFindData ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (...) {
		GDS_ASSERT (false);
		throw CanNotFindData ();
	}
	//#UC END# *496B249601F3_45740ADE0119_GET*
}

GCI::IO::String* Document_i::get_file_position ()
	/*throw (CanNotFindData)*/
{
	return const_cast<GCI::IO::String*>(((const Document_i*)this)->get_file_position ());
}

// implemented method from Document
GCI::IO::Stream* Document_i::get_annotation_header_evd (unsigned long handle) const /*throw (Unsupported)*/ {
	//#UC START# *4D023D3B02B4_45740ADE0119*
	throw Unsupported ();
	//#UC END# *4D023D3B02B4_45740ADE0119*
}

// implemented method from Document
// вернуть число документов для автореферата
size_t Document_i::get_auto_referat_doc_count () const /*throw (Unsupported)*/ {
	//#UC START# *4A9F9CF3006A_45740ADE0119*
	throw Unsupported ();
	//#UC END# *4A9F9CF3006A_45740ADE0119*
}

// implemented method from Document
GCI::IO::Stream* Document_i::get_autoreferat_header_evd () const /*throw (Unsupported)*/ {
	//#UC START# *4D023C95027A_45740ADE0119*
	throw Unsupported ();
	//#UC END# *4D023C95027A_45740ADE0119*
}

// implemented method from Document
void Document_i::get_correspondents (const NodeBase* category, CatalogBase*& out_list) const {
	//#UC START# *45EEB65201D7_45740ADE0119*
	out_list = 0;
	try {	
		if (!this->has_correspondents (category)) {
			throw CanNotFindData ();
		}
		// CQ: OIT500016003: для редакций СКР расчитываются относительно действующей (this->get_master () in next call):
		GblPilot::LegalDocument_var legal_document = GblPilot::LegalDocument::_narrow (this->get_master ()->get_server_doc());
		if (!CORBA::is_nil (legal_document)) {
			GblPilotQueryDef::Query query;
			ServerAdapterConverters::category_to_query (category, query);
			out_list = Core::TypeTraits<DynList>::Factory::make (legal_document, query, T_CORRESPONDENT);
		}
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEB65201D7_45740ADE0119*
}

// implemented method from Document
// Возвращает список корреспондентов к фрагменту документа (список параграфов) для указанной
// категории (category).
// 
// для редакций, отлчных от "главной", возвращает NULL
void Document_i::get_correspondents_to_part (
	const PositionList& pos_list
	, const NodeBase* category
	, CatalogBase*& out_list
) const {
	//#UC START# *45EEB6520199_45740ADE0119*
	out_list = 0;
	try {
		GblPilot::LegalDocument_var legal_document = GblPilot::LegalDocument::_narrow (this->get_server_doc());
		if (!CORBA::is_nil (legal_document)) {
			GblPilotDef::SubParaList pilot_sub_para_list;
			ServerAdapterConverters::adapter_to_server (pos_list, pilot_sub_para_list);
			GblPilotQueryDef::Query query;
			ServerAdapterConverters::category_to_query (category, query);
			GblDocList::DocListTree_var list (legal_document->get_correspond_list_to_part (pilot_sub_para_list, query));
			out_list = DynListFactory::make (list.in ());
		}
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEB6520199_45740ADE0119*
}

// implemented method from Document
// Получить список выпускаемых фирмой препаратов
CatalogBase* Document_i::get_drug_list () const /*throw (CanNotFindData)*/ {
	//#UC START# *47EBB17D009B_45740ADE0119*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *47EBB17D009B_45740ADE0119*
}

// implemented method from Document
// возвращает evd поток документа - совета дня или evd поток заглушки для отсутствующего в базе
// документа или документа запрещенного к просмотру
GCI::IO::Stream* Document_i::get_evd_stream () const {
	//#UC START# *4CE3E9DF02B0_45740ADE0119*
	GCD::SeqOctet_var data;
	try {
		data = this->get_server_doc ()->get_evd_stream ();
	} catch (GCD::CanNotFindData&) {
		return 0;
	}

	GDS_ASSERT (data->length ());
	return MemoryStreamFactory::make (data, true /*with_copy*/);
	//#UC END# *4CE3E9DF02B0_45740ADE0119*
}

// implemented method from Document
// Получение флеш-ролика
ExternalObject* Document_i::get_flash () const {
	//#UC START# *4857C59403C6_45740ADE0119*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4857C59403C6_45740ADE0119*
}

// implemented method from Document
// Получить url для отсканированного WWW-образа документа.
ExternalLink* Document_i::get_internet_image_url (long block_id) const {
	//#UC START# *45EEB652019D_45740ADE0119*
	try {
		return get_internet_image_url_i (block_id);
	} catch (CanNotFindData&) {
		throw CanNotFindData ();
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEB652019D_45740ADE0119*
}

// implemented method from Document
Link* Document_i::get_link (unsigned long doc_id, const Topic& id, RedactionID rid) const {
	//#UC START# *53E9F3420066_45740ADE0119*
	return LinkFactory::make (doc_id, id, rid);
	//#UC END# *53E9F3420066_45740ADE0119*
}

// implemented method from Document
LinkInfo* Document_i::get_link_info (unsigned long doc_id, const Topic& id, RedactionID rid) const {
	//#UC START# *47AB2FC90361_45740ADE0119*
	Link_var link = LinkFactory::make (doc_id, id, rid);
	return link->get_link_info ();
	//#UC END# *47AB2FC90361_45740ADE0119*
}

// implemented method from Document
// Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему
// идентификатору.
// Возвращается интерфейс на объект (obj) и тип объекта (obj_type).
// Дополнительно можно получить интерфейс (missing_info) с информацией, в каких блоках (базах)
// содержится отсутствующий объект (метод get_missing_info)
// Будет использоваться для перехода по гипертекстовой ссылке.
void Document_i::get_linked_object (
	unsigned long doc_id
	, const Topic& id
	, RedactionID rid
	, LinkedObjectType& obj_type
	, Core::IObject*& obj
) const /*throw (
	InvalidTopicId
	, FolderLinkNotFound
)*/ {
	//#UC START# *45EEB65201A3_45740ADE0119*
	Link_var link = LinkFactory::make (doc_id, id, rid);
	obj = link->get_object ();
	obj_type = link->get_object_type ();
	//#UC END# *45EEB65201A3_45740ADE0119*
}

// implemented method from Document
// Возвращает расширенную информацию по отсутствующему объекту (pid - идентификатор и класс объекта
// по ссылке)
void Document_i::get_missing_info_for_object (const PId& pid, MissingInfo*& missing_info) const {
	//#UC START# *47C6AA260009_45740ADE0119*
	missing_info = 0;

	switch (pid.class_id) {
		case Defines::CI_TOPIC:
		case Defines::CI_EDITION:
		{
			try {
				GCD::PID server_pid;
				server_pid.m_class_id = Defines::CI_TOPIC;
				server_pid.m_object_id = pid.object_id;
				missing_info = MissingInfoFactory::make (server_pid);
			} catch (...) {
			}
			break;
		}
		case Defines::CI_BLOB:
		case Defines::CI_PIC:
		case Defines::CI_MULTI:
		case Defines::CI_REF:
		case Defines::CI_FOLDER_LINK:
		case Defines::CI_EXTERNAL_OPERATION:
		case Defines::CI_WWW_IMAGE:		
		case Defines::CI_SCRIPT:
			break;
		case Defines::CI_SEARCH_QUERY:
			break;

		default:
			GDS_ASSERT (false);
	}
	//#UC END# *47C6AA260009_45740ADE0119*
}

// implemented method from Document
// Получить данные по мульnиссылке в виде списка (DocId, SubId)
DocPointList* Document_i::get_multi_link_info (
	unsigned long doc_id
	, const Topic& id
) const /*throw (
	CanNotFindData
	, InternalDatabaseError
)*/ {
	//#UC START# *4DCBB65D028F_45740ADE0119*
	GDS_ASSERT (id.pid.class_id == Defines::CI_MULTI || id.pid.class_id == Defines::CI_PHARM_MULTI);
	try {
		// В id.pid.object_id лежит не идентификатор документа, а номер параграфа, из которого получаем данные по ссылке
		// а в id.position.point - номер ссылки по порядку в параграфе
		GblPilotDef::DocPointContainer_var doc_point_container 
			= this->get_server_doc()->get_multilink_data (doc_id, id.pid.object_id, id.position.point);
		DocPointList* ret = new DocPointList ();
		ServerAdapterConverters::server_to_adapter (doc_point_container.in (), *ret);
		return ret;
	} catch (GCD::StorageInternalError&) {
		throw InternalDatabaseError ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	}
	//#UC END# *4DCBB65D028F_45740ADE0119*
}

// implemented method from Document
// Возвращает информацию об интервале неуверенности документа. Если указанная в параметра date дата
// не попадает в интревал бросает CanNotFindData
void Document_i::get_not_sure_info (
	const Date& date
	, Date& start
	, Date& finish
	, Document*& info
	, GCI::IO::String*& warning
) const {
	//#UC START# *45EEB65201AA_45740ADE0119*
	NotSureInfo not_sure_info;
	if (!this->is_date_in_not_sure_interval_i (date, not_sure_info)) {
		throw CanNotFindData ();
	}

	start = not_sure_info.interval.start;
	finish = not_sure_info.interval.finish;
	warning = Core::IObject::_duplicate (not_sure_info.warning.ptr ());

	try {
		Common_var common (CommonFactory::make ());
		MissingInfo_var missing_info;
		bool is_alive = common->get_document_on_number (OID_NOT_SHURE_WARNING_DOC, info, missing_info.out ());
	} catch (CanNotFindData&) {
	}
	//#UC END# *45EEB65201AA_45740ADE0119*
}

// implemented method from Document
void Document_i::get_respondents (const NodeBase* category, CatalogBase*& out_list) const {
	//#UC START# *45EEB65201DA_45740ADE0119*
	out_list = 0;
	try {	
		if (!this->has_respondents (category)) {
			throw CanNotFindData ();
		}
	
		// CQ: OIT500016003: для редакций СКР расчитываются относительно действующей (this->get_master () in next call):
		GblPilot::LegalDocument_var legal_document = GblPilot::LegalDocument::_narrow (this->get_master ()->get_server_doc());
		if (!CORBA::is_nil (legal_document)) {
			GblPilotQueryDef::Query query;
			ServerAdapterConverters::category_to_query (category, query);
			out_list = DynListFactory::make (legal_document, query, T_RESPONDENT);
		}
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEB65201DA_45740ADE0119*
}

// implemented method from Document
// Возвращает список респондентов к фрагменту документа (список параграфов) для указанной категории
// (category).
// 
// для редакций, отлчных от "главной", возвращает NULL
void Document_i::get_respondents_to_part (
	const PositionList& pos_list
	, const NodeBase* category
	, CatalogBase*& out_list
) const {
	//#UC START# *45EEB65201B0_45740ADE0119*
	out_list = 0;
	try {
		GblPilot::LegalDocument_var legal_document = GblPilot::LegalDocument::_narrow (this->get_server_doc ());
		if (!CORBA::is_nil (legal_document)) {					
			GblPilotDef::SubParaList pilot_sub_para_list;
			ServerAdapterConverters::adapter_to_server (pos_list, pilot_sub_para_list);

			GblPilotQueryDef::Query query;
			ServerAdapterConverters::category_to_query (category, query);

			GblDocList::DocListTree_var list = legal_document->get_respond_list_to_part (pilot_sub_para_list, query);
			out_list = DynListFactory::make (list.in ());
		}
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEB65201B0_45740ADE0119*
}

// implemented method from Document
// Получить список похожих документов
void Document_i::get_same_documents (CatalogBase*& out_list) const {
	//#UC START# *45EEB65201E1_45740ADE0119*
	out_list = 0;
	try {	
		if (!this->has_same_documents ()) {
			throw CanNotFindData ();
		}
	
		GblPilot::LegalDocument_var legal_document = GblPilot::LegalDocument::_narrow (this->get_server_doc());
		if (!CORBA::is_nil (legal_document)) {
			GblPilotQueryDef::Query query;
			out_list = DynListFactory::make (legal_document, query, T_SAME_DOCUMENTS);
		}
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEB65201E1_45740ADE0119*
}

// implemented method from Document
void Document_i::get_same_to_point (ExternalID id, CatalogBase*& out_list) const {
	//#UC START# *5582DAA202AD_45740ADE0119*
	out_list = 0;
	try {
		GblPilot::LegalDocument_var legal_document = GblPilot::LegalDocument::_narrow (this->get_server_doc());
		if (!CORBA::is_nil (legal_document)) {
			GblDocList::DocListTree_var list (legal_document->get_same_documents_to_sub (id));
			out_list = DynListFactory::make (list.in ());
		}
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *5582DAA202AD_45740ADE0119*
}

// implemented method from Document
// Получить расширенную информацию по текущему документу (в случае его отсутствия - в каких блоках
// этот документ присутствует)
void Document_i::get_self_missing_info (MissingInfo*& missing_info) const {
	//#UC START# *4D3D6F030110_45740ADE0119*
	PId pid;
	pid.object_id = this->get_document_pid ().m_object_id;
	pid.class_id = Defines::CI_TOPIC;
	return this->get_missing_info_for_object (pid, missing_info);
	//#UC END# *4D3D6F030110_45740ADE0119*
}

// implemented method from Document
GblPilot::Document* Document_i::get_server_doc () const {
	//#UC START# *462774050102_45740ADE0119*
	if (CORBA::is_nil(m_document)) {
		this->load_server_doc ();
	}
	return m_document.ptr ();
	//#UC END# *462774050102_45740ADE0119*
}

// implemented method from Document
DocumentTextProvider* Document_i::get_text_provider (bool all_at_once) const /*throw (Unsupported, CanNotFindData)*/ {
	//#UC START# *4CAF1A4B0096_45740ADE0119*
	if (!this->get_server_doc ()->is_alive ()) {
		throw CanNotFindData ();
	}
	
	GblPilot::HighlightHandle handle;
	handle.doc_id = this->get_document_pid ().m_object_id;
	handle.id = GblPilot::NO_HIGHLIGHT;
	GblPilot::FlatDocument_var doc = GblPilot::FlatDocument::_narrow (this->get_server_doc ());
	if (m_current_state->m_new_state.appropriate_entry_in_list.ptr ()) {
		const GblPilotDef::WordList& word_list = m_current_state->m_new_state.appropriate_entry_in_list->get_relevance_words_list ();
		if (word_list.length ()) {
			handle = doc->get_highlight_handle (word_list);
		}
	}

	return this->make_text_provider (doc.in (), handle, all_at_once);
	//#UC END# *4CAF1A4B0096_45740ADE0119*
}

// implemented method from Document
DocumentTextProvider* Document_i::get_text_provider_by_desc (unsigned long handle) /*throw (Unsupported)*/ {
	//#UC START# *4D6291D500E7_45740ADE0119*
	throw Unsupported ();
	//#UC END# *4D6291D500E7_45740ADE0119*
}

// implemented method from Document
const DocumentTextProviderDescriptorList& Document_i::get_text_provider_desc_list () /*throw (Unsupported)*/ {
	//#UC START# *4D6289D601A0_45740ADE0119*
	throw Unsupported ();
	//#UC END# *4D6289D601A0_45740ADE0119*
}

// implemented method from Document
const DocumentTextProviderList& Document_i::get_text_provider_list (bool all_at_once) /*throw (Unsupported)*/ {
	//#UC START# *4CED4A090217_45740ADE0119*
	throw Unsupported ();
	//#UC END# *4CED4A090217_45740ADE0119*
}

// implemented method from Document
TimeMachineWarning* Document_i::get_time_machine_warning (const Date& date) {
	//#UC START# *45EEB65201BE_45740ADE0119*
	class local_StringAssigner {
	public:
		static char* assign (const std::string& str, std::string& storage) {
			storage = str;
			return const_cast<char*>(storage.c_str ());
		}
	}; 

	const static std::string warning_was_not_publishing =		NOT_UNICODE_TR("Документ не был издан и (или) не действовал на указанный в Машине времени момент");
	const static std::string warning_redaction_not_available =	NOT_UNICODE_TR("В настоящее время редакция данного документа на указанную дату недоступна");
	const static std::string warning_action_was_stoped =		NOT_UNICODE_TR("Действие документа было приостановлено на указанный в Машине времени момент ");
	const static std::string warning_document_stale =			NOT_UNICODE_TR("Документ утратил силу к указанному в Машине времени моменту");
	const static std::string warning_data_not_actual =			NOT_UNICODE_TR("Дата, указанная в Машине времени, не относится к периоду действия данной редакции документа");
	const static std::string warning_not_tm =					NOT_UNICODE_TR("Настоящий документ не подключен к Машине времени");
	const static std::string warning_practice =					NOT_UNICODE_TR("Документ не был принят на дату, указанную в Машине времени, однако в нем рассматриваются правоотношения, возникшие до его принятия");

	Core::Aptr<TimeMachineWarning> out_time_machine_warning (new TimeMachineWarning ());

	out_time_machine_warning->type = TMWT_RED;
	out_time_machine_warning->warning = 0;

	if (date == Date ()) {
		throw InvalidDate ();
	}

	if (this->get_master ()->m_doc_part_mask & GblPilotDef::DPM_NOT_IN_TIME_MACHINE) {
		out_time_machine_warning->warning = GCI::IO::StringFactory::make (
			local_StringAssigner::assign (warning_not_tm, m_time_machine_warning_string)
		);
		return out_time_machine_warning.forget ();
	}

	Common_var common = CommonFactory::make ();
	Date base_date = common->get_base_date ();

	if (base_date == date) {
		return out_time_machine_warning.forget ();
	}
	
	try {

		const RedactionInfo& curr_red = this->get_current_redaction_info ();
		long length = curr_red.active_intervals.size ();
		
		if (length == 1) {
			const DateInterval& interval = curr_red.active_intervals[0];
			if (interval.start == Date () && interval.finish == Date ()) {

				if (this->is_yellow_medal_time_machine_warning (date, curr_red.doc_date)) {
					out_time_machine_warning->type = TMWT_YELLOW;
					out_time_machine_warning->warning = GCI::IO::StringFactory::make (
						local_StringAssigner::assign (warning_practice, m_time_machine_warning_string)
					);
					return out_time_machine_warning.forget ();
				}

				// Если у редакции нет интервалов активности (она действует всегда) не выводим 
				if (curr_red.actual_type == RT_ACTUAL
					|| curr_red.actual_type == RT_ACTUAL_PREACTIVE
					|| curr_red.actual_type == RT_ACTUAL_ABOLISHED
				) {
					return out_time_machine_warning.forget ();
				}
			}
		}
		
		long i;
		for (i = 0; static_cast<size_t> (i) < curr_red.active_intervals.size (); ++i) {
			const DateInterval& interval = curr_red.active_intervals[i];       
			if ( (interval.start != Date () && interval.finish == Date () && interval.start <= date)
				|| (interval.start == Date () && interval.finish != Date () && date <= interval.finish)
				|| (interval.start != Date () && interval.finish != Date () && interval.start <= date && date <= interval.finish)
			) {
				return out_time_machine_warning.forget ();
			}
		}
		
		const RedactionInfoList& redactions_list = this->get_redactions_list ();
		length = redactions_list.size ();
		GDS_ASSERT (length);
		
		// warning_was_not_publishing
		Date start;
		for (i = length - 1; i >= 0; --i) {
			const RedactionInfo& data_ref = redactions_list[i];
			start = data_ref.active_intervals[0].start;
			const Date& finish = data_ref.active_intervals[0].finish;
			if (start > Date () && finish > Date ()) { // for skip first redactions 
				break;                                   // without active intervals
			}
		}
		
		if (date < start) {
			out_time_machine_warning->warning = GCI::IO::StringFactory::make (
				local_StringAssigner::assign (warning_was_not_publishing, m_time_machine_warning_string)
			);
			return out_time_machine_warning.forget ();
		}
		
		// warning_document_stale
		const RedactionInfo* data_ref = &redactions_list[0];
		long activity_length = data_ref->active_intervals.size ();
		const Date& finish = data_ref->active_intervals [activity_length-1].finish;
		if (date > finish && finish != Date ()) {
			out_time_machine_warning->warning = GCI::IO::StringFactory::make (
				local_StringAssigner::assign (warning_document_stale, m_time_machine_warning_string)
			);
			return out_time_machine_warning.forget ();
		}

		// warning_action_was_stoped
		for (i = length - 1; i >= 0; --i) {
			data_ref = &redactions_list[i];
			long activity_length = data_ref->active_intervals.size ();
			for (long j = 0; j < activity_length-1; ++j) {
				const Date finish_prev = data_ref->active_intervals[j].finish;
				const Date start_next  = data_ref->active_intervals[j+1].start;
				if (finish_prev < date && date < start_next) {
					out_time_machine_warning->warning = GCI::IO::StringFactory::make (
						local_StringAssigner::assign (warning_action_was_stoped, m_time_machine_warning_string)
					);
					return out_time_machine_warning.forget ();
				}
			}
		}
		
		// warning_redaction_not_available
		for (i = length - 1; i > 0; --i) {
			data_ref = &redactions_list[i];
			long activity_length = data_ref->active_intervals.size ();
		
			const Date& finish_prev = data_ref->active_intervals[activity_length-1].finish;

			do {
				const RedactionInfo& next_data_ref = redactions_list[i-1];
				if (next_data_ref.active_intervals[0].start == Date ()
					&& next_data_ref.active_intervals[0].finish == Date ()
					&& i-1 > 0) {
					--i;
					continue;
				}
				break;
			} while (true);
			
			const RedactionInfo& dref = redactions_list[i-1];
			const Date& start_next = dref.active_intervals[0].start;
			if (finish_prev < date && date < start_next) {
				out_time_machine_warning->warning = GCI::IO::StringFactory::make (
					local_StringAssigner::assign (warning_redaction_not_available, m_time_machine_warning_string)
				);
				return out_time_machine_warning.forget ();
			}
		}

		out_time_machine_warning->warning = GCI::IO::StringFactory::make (
			local_StringAssigner::assign (warning_data_not_actual, m_time_machine_warning_string)
		);
	} catch (CanNotFindData&) {
		// Document_i::get_current_redaction_info () throw CanNotFindData for "null document",
		// suppress it
	}	
	return out_time_machine_warning.forget ();
	//#UC END# *45EEB65201BE_45740ADE0119*
}

// implemented method from Document
bool Document_i::has_annotation () const {
	//#UC START# *45EEB65201C8_45740ADE0119*
	this->load_and_update ();
	return (m_doc_part_mask & GblPilotDef::DPM_HAS_ANNOTATION) != 0;
	//#UC END# *45EEB65201C8_45740ADE0119*
}

// implemented method from Document
// для документов типа DT_BOOK возвращает false,
// для остальных true
bool Document_i::has_attributes () const {
	//#UC START# *45EEB65201C9_45740ADE0119*
	this->load_and_update ();
	if (!this->get_document_pid ().m_object_id) {
		return false;
	}
	return true;
	//#UC END# *45EEB65201C9_45740ADE0119*
}

// implemented method from Document
// Проверка наличия корреспондентов (любогй категории) у текущего документа.
// Возвращает true в случае, если список корреспондентов для документа по категории CR_ALL не пуст.
// 
// для редакций, отличных от "главной", возвращает FALSE
bool Document_i::has_correspondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C0_45740ADE0119*
	this->load_and_update ();
	
	// CQ: OIT500016003: для редакций СКР расчитываются относительно действующей
	if (!category) {
		return (this->get_master ()->m_doc_part_mask & GblPilotDef::DPM_HAS_CORRESPONDENT) != 0;
	}
	return (this->get_master ()->m_correspondent_mask & category->get_type ()) != 0;
	//#UC END# *45EEB65201C0_45740ADE0119*
}

// implemented method from Document
// Проверка наличия WWW-образа у текущего документа.
// Возвращает true в случае, если у текущего документа есть WWW-образ.
bool Document_i::has_internet_image () const {
	//#UC START# *45EEB65201C2_45740ADE0119*
	this->load_and_update ();
	return m_doc_part_mask & GblPilotDef::DPM_HAS_INTERNET_IMAGE;
	//#UC END# *45EEB65201C2_45740ADE0119*
}

// implemented method from Document
// Функция показывает наличие следующей редакции для объекта.
// Следующая редакция считается относительно текущего состояния (current_redaction).
// Возвращает True в случае наличия хотябы одной более поздней (чем текущая) редакции.
bool Document_i::has_next_redaction () const {
	//#UC START# *45EEB65201C3_45740ADE0119*
	try {
		this->load_and_update ();

		if (m_has_next_redaction_ == -1) {
			const RedactionInfoList& redactions_list = this->get_redactions_list ();
			m_has_next_redaction_ = RedactionInfoListHelper::find_redaction (redactions_list, m_current_state->redaction ()) > 0;
		}
	} catch (GCD::FeatureDisabled&) {
		m_has_next_redaction_ = 0;
	}
	return (m_has_next_redaction_ != 0);
	//#UC END# *45EEB65201C3_45740ADE0119*
}

// implemented method from Document
// Функция показывает наличие предыдущей редакции для объекта.
// Предыдущая редакция считается относительно текущего состояния (current_redaction).
// Возвращает True в случае наличия хотябы одной более ранней (чем текущая) редакции.
bool Document_i::has_prev_redaction () const {
	//#UC START# *45EEB65201C4_45740ADE0119*
	try {
		this->load_and_update ();

		if (m_has_prev_redaction_ == -1) {
			const RedactionInfoList& redactions_list = this->get_redactions_list ();
			int ind = RedactionInfoListHelper::find_redaction (redactions_list, m_current_state->redaction ());
			m_has_prev_redaction_ = (ind >= 0 && static_cast<size_t> (ind) < redactions_list.size () - 1);
		}
	} catch (GCD::FeatureDisabled&) {
		m_has_prev_redaction_ = 0;
	}
	return (m_has_prev_redaction_ != 0);
	//#UC END# *45EEB65201C4_45740ADE0119*
}

// implemented method from Document
// Проверка наличия справки у текущего документа.
// Возвращает true в случае, если у текущего документа есть справка.
// 
// для редакций, отличных от "главной", поведение такое же как и для "главной"
bool Document_i::has_related_doc () const {
	//#UC START# *45EEB65201C5_45740ADE0119*
	this->load_and_update ();
	return (m_doc_part_mask & GblPilotDef::DPM_HAS_RELATED) != 0;
	//#UC END# *45EEB65201C5_45740ADE0119*
}

// implemented method from Document
// Проверка наличия респондентов (любогй категории) у текущего документа.
// Возвращает true в случае, если список респондентов для документа по категории CR_ALL не пуст.
// 
// для редакций, отличных от "главной", возвращает FALSE
bool Document_i::has_respondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C6_45740ADE0119*
	this->load_and_update ();
	
	// CQ: OIT500016003: для редакций СКР расчитываются относительно действующей
	if (!category) {
		return (this->get_master ()->m_doc_part_mask & GblPilotDef::DPM_HAS_RESPONDENT) != 0;
	}
	return (this->get_master ()->m_respondent_mask & category->get_type ()) != 0;
	//#UC END# *45EEB65201C6_45740ADE0119*
}

// implemented method from Document
// Проверка наличия похожих документов
bool Document_i::has_same_documents () const {
	//#UC START# *45EEB65201E0_45740ADE0119*
	this->load_and_update ();
	return (m_doc_part_mask & GblPilotDef::DPM_HAS_SAME_DOCUMENTS) != 0;
	//#UC END# *45EEB65201E0_45740ADE0119*
}

// implemented method from Document
// Есть ли у документа перевод
bool Document_i::has_translation () const {
	//#UC START# *45EEB65201DF_45740ADE0119*
	this->load_and_update ();
	return (m_doc_part_mask & GblPilotDef::DPM_HAS_TRANSLATION) != 0;
	//#UC END# *45EEB65201DF_45740ADE0119*
}

// implemented method from Document
// Присутствие предупреждения.
bool Document_i::has_warning () const {
	//#UC START# *45EEB65201CA_45740ADE0119*
	this->load_and_update ();
	return !m_warning_impl.is_nil();
	//#UC END# *45EEB65201CA_45740ADE0119*
}

// implemented method from Document
// внутренний номер документа в базе
unsigned long Document_i::get_internal_id () const {
	//#UC START# *45EEB65201E7_45740ADE0119_GET*
	this->load_and_update ();
	unsigned long id = this->get_redaction_pid ().m_object_id;
	if (!id) {
		throw CanNotFindData ();
	}
	return id < GblPilotDef::GEMMOROI_IZ_ZA_100000 ?
		id : id - GblPilotDef::GEMMOROI_IZ_ZA_100000;
	//#UC END# *45EEB65201E7_45740ADE0119_GET*
}

// implemented method from Document
// Специальный метод, позволяющий выяснить "жив" ли документ на сервере приложений. Если документ
// "жив" - возвращается `true` (как правило такая проверка нужна, когда документ может быть удален,
// например во время обновления базы). Результаты данного метода не кешируются на адаптере, т.е.
// вызов этого метода всегда обращается к серверу приложений.
bool Document_i::is_alive () const {
	//#UC START# *45EEB65201CB_45740ADE0119*
        // Если сервер умер - клиент при первом же обращении за статусом документа об этом узнает
	return (this->get_server_doc()->is_alive () == CORBA::Boolean (1));
	//#UC END# *45EEB65201CB_45740ADE0119*
}

// implemented method from Document
// Метод позволяет определить попадает ли date в интервал неуверенности документа.
bool Document_i::is_date_in_not_sure_interval (const Date& date) const {
	//#UC START# *45EEB65201CC_45740ADE0119*
	NotSureInfo dummy;
	return this->is_date_in_not_sure_interval_i (date, dummy);
	//#UC END# *45EEB65201CC_45740ADE0119*
}

// implemented method from Document
// индексирован ли документ для морфопоиска
bool Document_i::is_morpho_search_supported () const {
	//#UC START# *46CD4B9D030D_45740ADE0119*
	return this->get_server_doc ()->is_morpho_search_supported ();
	//#UC END# *46CD4B9D030D_45740ADE0119*
}

// implemented method from Document
bool Document_i::is_my_bookmark (const Bookmark* bookmark) const {
	//#UC START# *45EEB65201CE_45740ADE0119*
	const PId& adapter_pid = bookmark->get_pid ();
	GCD::PID pid = ServerAdapterConverters::adapter_to_server (adapter_pid);
	
	try {
		return this->get_master ()->is_same_redaction (this) 
			? pid == this->get_document_pid ()
			: pid.m_object_id == m_current_state->redaction ()
		;
	} catch (GCD::FeatureDisabled&) {
		return false;
	}

	//#UC END# *45EEB65201CE_45740ADE0119*
}

// implemented method from Document
bool Document_i::is_same_document (const Document* doc) const {
	//#UC START# *45EEB65201D0_45740ADE0119*
	const Document_i* view = dynamic_cast<const Document_i*> (doc);
	if (!view) {
		return false;
	}
	return this->get_document_pid () == view->get_document_pid ();
	//#UC END# *45EEB65201D0_45740ADE0119*
}

// implemented method from Document
bool Document_i::is_same_redaction (const Document* view) const {
	//#UC START# *45EEB65201D2_45740ADE0119*
	try {
		const Document_i* doc = dynamic_cast<const Document_i*> (view);
		return doc
			&& (this->get_master () == doc->get_master () || this->get_document_pid () == doc->get_document_pid ())
			&& this->has_same_redactions (doc)			
		;
	} catch (GCD::FeatureDisabled&) {
		return this == dynamic_cast<const Document_i*> (view);
	}
	//#UC END# *45EEB65201D2_45740ADE0119*
}

// implemented method from Document
// Возвращает равенство документов с учетом их состояния (в отличии от is_same_entity, который
// возвращает равенство без учета состояния). Состоянием документа является суперпозиция номера
// редакции, языка и списка извлечений.
bool Document_i::is_same_view (const Document* view) const {
	//#UC START# *45EEB65201D4_45740ADE0119*
	try {
		const Document_i* doc = dynamic_cast<const Document_i*> (view);
		return doc
			&& (
				this->get_master () == doc->get_master ()
				|| (this->get_document_pid () == doc->get_document_pid () && this->get_document_pid ().m_object_id)
			)
			&& *(m_current_state.ptr ()) == *(doc->m_current_state.ptr ())
		;
	} catch (GCD::FeatureDisabled&) {
		return false;
	}
	//#UC END# *45EEB65201D4_45740ADE0119*
}

// implemented method from Document
// Имя документа.
const GCI::IO::String& Document_i::get_name () const {
	//#UC START# *45EEB65201E3_45740ADE0119_GET*
	if (m_name_impl.is_nil ()) {
		try {
			m_name_impl = GCI::IO::StringFactory::make (CORBA::String_var (this->get_server_doc ()->get_name ()).in ());
		} catch(...) {
			this->load_and_update ();
			m_name_impl = m_short_name_impl;
		}
	}
	return *(m_name_impl.ptr ());
	//#UC END# *45EEB65201E3_45740ADE0119_GET*
}

GCI::IO::String& Document_i::get_name () {
	return const_cast<GCI::IO::String&>(((const Document_i*)this)->get_name ());
}

// implemented method from Document
// Доступна новая ревизия документа (для супермобильной версии)
const bool Document_i::get_new_revision_available () const {
	//#UC START# *4BC323A60337_45740ADE0119_GET*
	return false;
	//#UC END# *4BC323A60337_45740ADE0119_GET*
}

// implemented method from Document
// True - если документ не подключен к машине времени
const bool Document_i::get_not_tm () const {
	//#UC START# *48285D28025E_45740ADE0119_GET*
	this->load_and_update ();
	return (m_doc_part_mask & GblPilotDef::DPM_NOT_IN_TIME_MACHINE) != 0;
	//#UC END# *48285D28025E_45740ADE0119_GET*
}

// implemented method from Document
// Краткое имя документа.
const GCI::IO::String& Document_i::get_short_name () const {
	//#UC START# *45EEB65201E4_45740ADE0119_GET*
	this->load_and_update ();
	return *(m_short_name_impl.ptr ());
	//#UC END# *45EEB65201E4_45740ADE0119_GET*
}

GCI::IO::String& Document_i::get_short_name () {
	return const_cast<GCI::IO::String&>(((const Document_i*)this)->get_short_name ());
}

// implemented method from Document
// размер документа в байтах
unsigned long Document_i::get_size () const {
	//#UC START# *45EEB65201E6_45740ADE0119_GET*
	this->load_and_update ();
	return m_doc_size != GblPilotDef::DS_UNKNOWN_SIZE ? m_doc_size : throw CanNotFindData ();
	//#UC END# *45EEB65201E6_45740ADE0119_GET*
}

// implemented method from Document
// Статус документа
const ItemStatus Document_i::get_status () const {
	//#UC START# *45EEBECB019A_45740ADE0119_GET*
	this->load_and_update ();
	return m_status_impl;
	//#UC END# *45EEBECB019A_45740ADE0119_GET*
}

// implemented method from Document
const Document* Document_i::get_translation () const {
	//#UC START# *460B8F6A02B2_45740ADE0119_GET*
	try {
		if (m_translation_impl.is_nil ()) {
			GblPilot::LegalDocument_var legal_doc = GblPilot::LegalDocument::_narrow (this->get_server_doc());
			GblPilot::Document_var translation = legal_doc->get_translation ();
			m_translation_impl = Core::TypeTraits<TranslatedDocument>::Factory::make (translation.in ()); 
		}
	} catch (...) {
		throw CanNotFindData ();
	}

	return m_translation_impl._sretn ();
	//#UC END# *460B8F6A02B2_45740ADE0119_GET*
}

Document* Document_i::get_translation () {
	return const_cast<Document*>(((const Document_i*)this)->get_translation ());
}

// implemented method from Document
// Предупреждение к документу.
const GCI::IO::String& Document_i::get_warning () const {
	//#UC START# *45EEB65201E5_45740ADE0119_GET*
	this->load_and_update ();
	if (m_warning_impl.is_nil ()) {
		throw CanNotFindData ();
	}
	return *(m_warning_impl.ptr ());
	//#UC END# *45EEB65201E5_45740ADE0119_GET*
}

GCI::IO::String& Document_i::get_warning () {
	return const_cast<GCI::IO::String&>(((const Document_i*)this)->get_warning ());
}

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* Document_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_45740ADE0119*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_45740ADE0119*
}

// implemented method from EntityBase
// идентификатор
const unsigned long Document_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_45740ADE0119_GET*
	return 0;
	//#UC END# *456EE084033C_45740ADE0119_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool Document_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_45740ADE0119_GET*
	return false;
	//#UC END# *456EB3E1017D_45740ADE0119_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool Document_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_45740ADE0119_GET*
	return true;
	//#UC END# *456EB3E1017C_45740ADE0119_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* Document_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_45740ADE0119*
	throw Unsupported ();
	//#UC END# *456EB3E10178_45740ADE0119*
}

// implemented method from Likeable
// Доступность операции оценки
const bool Document_i::get_can_like () const {
	//#UC START# *4FEAFD79015E_45740ADE0119_GET*
	this->check_update_and_clear_cache ();
	if (boost::indeterminate (m_can_like)) {
		m_can_like = this->get_server_doc ()->can_like ();
	}
	return m_can_like;
	//#UC END# *4FEAFD79015E_45740ADE0119_GET*
}

// implemented method from Likeable
// Нравится
void Document_i::like () const {
	//#UC START# *4FEAFD48024F_45740ADE0119*
	this->get_server_doc ()->like ();
	//#UC END# *4FEAFD48024F_45740ADE0119*
}

// implemented method from Likeable
// Не нравится
void Document_i::unlike () const {
	//#UC START# *4FEAFD5D03D1_45740ADE0119*
	this->get_server_doc ()->unlike ();
	//#UC END# *4FEAFD5D03D1_45740ADE0119*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from GSI::NotifyService::Consumer
// Для получения сообщений реализация перекрывает этот метод.
void Document_i::fire_event (const CORBA::Any& event) {
	//#UC START# *44A119280119_45740ADE0119*
	GblPilotDef::UserNotify* user_notify;
	try {
		if ((event >>= user_notify)) {
			if (user_notify->m_type == GblPilotDef::unt_document_changed) {
				GCD::ObjectID doc_id;
				if (user_notify->m_data >>= doc_id) {
					if (doc_id == this->get_document_pid ().m_object_id) {
						m_status_changes_updated = true;
						m_status_changes = static_cast <unsigned long> (this->get_server_doc()->get_status_changes ());
					}
				} else {
					GDS_ASSERT (false);
				}
			}
		} else {
			GDS_ASSERT (false);
		}
	} catch (...) {
		GDS_ASSERT (false);
	}
	//#UC END# *44A119280119_45740ADE0119*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

