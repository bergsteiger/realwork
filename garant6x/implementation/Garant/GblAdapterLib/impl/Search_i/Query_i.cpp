////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::Query_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Business/GblPilot/Home/Adapter.h"
#include "ace/Date_Time.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/LogicOperationTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/DateTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/FoldersHelper/ContentChecker.h"
#include "shared/GCI/I18N/I18N.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"

//#UC START# *45FEB86E0267_CUSTOM_INCLUDES*
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"

#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultationManager_ami.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ProgressIndicatorSupport_i/ProgressIndicatorServant_i.h" 
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchManager_ami.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynList_i.h"


namespace GblAdapterLib {

void Query_i::save_data (bool need_save_name_and_comment) {
	GDS_ASSERT (!CORBA::is_nil (m_saved_query.in ()));
	
	GblPilotQueryDef::Query_var query = this->build_query();
	try {
		m_saved_query->set_query (query.in());
		m_saved_query->doc_count (0);
		if (need_save_name_and_comment && m_name.ptr ()) {
			m_saved_query->set_name (m_name->get_data ());
		}
		if (need_save_name_and_comment && m_comment.ptr ()) {
			m_saved_query->set_comment (m_comment->get_data ());
		}
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	}
}

void Query_i::complete_search (unsigned long count) {
	GDS_ASSERT (false);
}

void Query_i::parse_server_query (const GblPilotQueryDef::Query& server_query) {
	class ParseFlagController {
	public:
		ParseFlagController (bool& flag) : m_flag (flag) {
			m_flag = true;
		}
		~ParseFlagController () {
			m_flag = false;
		}
	private:
		bool& m_flag;	
	};
	
	ParseFlagController parse_flag_controller (m_parse_now);
	
	m_attributes.clear ();
	this->set_type (QueryTypeTranslatorSingleton::instance ()->get (server_query.type));
	CORBA::ULong length = server_query.attributes.length ();
	for (CORBA::ULong i = 0; i < length; ++i) {
		const GblPilotQueryDef::QueryAttribute& server_attribute = server_query.attributes [i];
		AttributeTag tag = const_cast<AttributeTag> (Defines::AttributeTagTranslator::translate (server_attribute.tag));
		CORBA::ULong value_size = server_attribute.value.length ();
		GDS_ASSERT (value_size);
		GblPilotQueryDef::QueryDictData* query_dict_data;
		GblPilotQueryDef::QueryContextData* query_context_data;
		GblPilotQueryDef::QueryDateData* query_date_data;
		GblPilotQueryDef::QueryPhoneNumberData* query_phone_number_data;
		if (server_attribute.value [0] >>= query_dict_data) {
			this->unpack_node (tag, server_attribute.value);
		} else if (server_attribute.value [0] >>= query_context_data) {
			this->unpack_context (tag, server_attribute.value);
		} else if (server_attribute.value [0] >>= query_date_data) {
			this->unpack_date (tag, server_attribute.value);
		} else if (server_attribute.value [0] >>= query_phone_number_data) {
			this->unpack_phone_number (tag, server_attribute.value);
		} else {
			GDS_ASSERT (false);
		}
	}
}

void Query_i::check_saved_query () {
	if (!m_parse_now 
		&& m_attributes.size () == 0 
		&& !CORBA::is_nil (m_saved_query) 
		&& !m_saved_query_was_load
		&& !m_new_content
	) {
		if (!ContentChecker::check_server_content (m_saved_query.in ())) {
			m_saved_query_was_load = false;
			m_saved_query = 0;
			return;
		}
		
		GblPilotQueryDef::Query_var saved_query = m_saved_query->get_query ();
		m_saved_query_was_load = true;
		this->parse_server_query (saved_query.in ());
	}
}

} // namespace

//#UC END# *45FEB86E0267_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45FEB86E0267*
//#UC END# *45FEB86E0267*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Query_i::Query_i (GblUserJournal::JournalQuery* journal_query)
//#UC START# *4CAC1A6C0378_4CAC14270150_45FEB86E0267_BASE_INIT*
	: QueryHelper (QueryTypeTranslatorSingleton::instance()->get (journal_query->get_query_type ()))
	, m_folders_node (0)
	, m_parse_now (false)
	, m_saved_query_was_load (true)
	, m_new_content (false)
//#UC END# *4CAC1A6C0378_4CAC14270150_45FEB86E0267_BASE_INIT*
{
	//#UC START# *4CAC1A6C0378_4CAC14270150_45FEB86E0267_BODY*
	m_name = GCI::IO::StringFactory::make (CORBA::String_var (journal_query->name ()).in ());
	m_comment = GCI::IO::StringFactory::make (CORBA::String_var (journal_query->full_name ()).in ());
	{
		// Парсим серверный журнальный Query и отпускаем его
		GblPilotQueryDef::Query_var query = journal_query->get_query ();
		this->parse_server_query (query.in ());
		ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (journal_query);
	}
	//#UC END# *4CAC1A6C0378_4CAC14270150_45FEB86E0267_BODY*
}

Query_i::Query_i (GblFolders::SavedQuery* saved_query, bool load_on_demand, FoldersNode* folders_node)
//#UC START# *4CAC1A6C0378_4CAC143900A7_45FEB86E0267_BASE_INIT*
	: QueryHelper (QueryTypeTranslatorSingleton::instance ()->get (saved_query->get_query_type ()))
	, m_folders_node (folders_node)
	, m_parse_now (false)
	, m_saved_query_was_load (false)
	, m_saved_query (GblFolders::SavedQuery::_duplicate (saved_query))
	, m_new_content (false)
//#UC END# *4CAC1A6C0378_4CAC143900A7_45FEB86E0267_BASE_INIT*
{
	//#UC START# *4CAC1A6C0378_4CAC143900A7_45FEB86E0267_BODY*
	m_name = GCI::IO::StringFactory::make (CORBA::String_var (m_saved_query->get_name ()).in ());
	m_comment = GCI::IO::StringFactory::make (CORBA::String_var (m_saved_query->get_comment ()).in ());
	if (!load_on_demand) {
		this->check_saved_query ();
	}
	//#UC END# *4CAC1A6C0378_4CAC143900A7_45FEB86E0267_BODY*
}

Query_i::Query_i (const GblPilotQueryDef::Query& query)
//#UC START# *4CAC1A6C0378_4CAC144903DE_45FEB86E0267_BASE_INIT*
	: QueryHelper (QueryTypeTranslatorSingleton::instance()->get (query.type))
	, m_folders_node (0)
	, m_parse_now (false)
	, m_saved_query_was_load (false)
	, m_new_content (false)
//#UC END# *4CAC1A6C0378_4CAC144903DE_45FEB86E0267_BASE_INIT*
{
	//#UC START# *4CAC1A6C0378_4CAC144903DE_45FEB86E0267_BODY*
	this->parse_server_query (query);
	//#UC END# *4CAC1A6C0378_4CAC144903DE_45FEB86E0267_BODY*
}

Query_i::Query_i (QueryType type) : QueryHelper(type)
//#UC START# *45EEE145027B_45FFA1AA01D0_45FEB86E0267_BASE_INIT*
	, m_folders_node (0)
	, m_parse_now (false)
	, m_saved_query_was_load (false)
	, m_new_content (false)
//#UC END# *45EEE145027B_45FFA1AA01D0_45FEB86E0267_BASE_INIT*
{
	//#UC START# *45EEE145027B_45FFA1AA01D0_45FEB86E0267_BODY*
	//#UC END# *45EEE145027B_45FFA1AA01D0_45FEB86E0267_BODY*
}

Query_i::~Query_i () {
	//#UC START# *45FEB86E0267_DESTR_BODY*
	//#UC END# *45FEB86E0267_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* Query_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_45FEB86E0267*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_45FEB86E0267*
}

// implemented method from EntityBase
// идентификатор
const unsigned long Query_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_45FEB86E0267_GET*
	if (this->get_is_saved ()) {
		GDS_ASSERT (!CORBA::is_nil (m_saved_query));
		return m_saved_query->id ();
	} else {
		throw NotSaved ();
	}
	//#UC END# *456EE084033C_45FEB86E0267_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool Query_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_45FEB86E0267_GET*
	GDS_ASSERT (false);
	return false;
	//#UC END# *456EB3E1017D_45FEB86E0267_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool Query_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_45FEB86E0267_GET*
	return ContentChecker::check_content (m_saved_query.in ());
	//#UC END# *456EB3E1017C_45FEB86E0267_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* Query_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_45FEB86E0267*
	if (!storage) {
		if (false == ContentChecker::check_server_content (m_saved_query.in ())) {
			throw NotSaved ();
		}
		this->save_data (false);
		return 0;
	} else if (Defines::CT_FOLDER == storage->get_content_type ()) {
		Node* fn = dynamic_cast <Node*> (const_cast<EntityStorage*> (storage));
		if (!fn) {
			throw CanNotSave ();
		}
		if (this->get_is_saved ()) {
			m_saved_query = 0;
		}
		Node_var node = fn->add_child_node (static_cast<Query*> (this));
		return node._sretn ();
	} else if (Defines::CT_SAVED_QUERY == storage->get_content_type ()) {
		m_saved_query = GblFolders::SavedQuery::_narrow (storage->get_cached_content ());
		this->save_data (false);
		return 0;
	} else {
		GDS_ASSERT (false);
		throw CanNotSave ();
	}
	//#UC END# *456EB3E10178_45FEB86E0267*
}

// implemented method from FoldersQuery
GblFolders::SavedQuery* Query_i::get_saved_query () {
	//#UC START# *461CCEF90271_45FEB86E0267*
	class local_NewContent {
	public:
		local_NewContent (bool& new_content) : m_new_content_ref (new_content) {
			m_new_content_ref = true;
		}
		~local_NewContent () {
			m_new_content_ref = false;
		}
	private:
		bool& m_new_content_ref;
	}; 

	if (!this->get_is_saved ()) {
		Containers::Content_var content = ApplicationHelper::instance ()->get_cached_folders ()->create_content (
			Defines::CT_SAVED_QUERY
		);
		
		local_NewContent new_content (m_new_content);
		m_saved_query = GblFolders::SavedQuery::_narrow (content);
		this->save_data (true);
	}

	GDS_ASSERT (!CORBA::is_nil (m_saved_query));
	return GblFolders::SavedQuery::_duplicate (m_saved_query.in ());
	//#UC END# *461CCEF90271_45FEB86E0267*
}

// implemented method from FoldersQuery
void Query_i::reset_saved_query () {
	//#UC START# *461CD06202C8_45FEB86E0267*
	m_saved_query = 0;
	//#UC END# *461CD06202C8_45FEB86E0267*
}

// implemented method from Query
const QueryAttributeList& Query_i::get_attributes () const {
	//#UC START# *45EEE262018E_45FEB86E0267_GET*
	const_cast<Query_i*> (this)->check_saved_query ();
	return m_attributes;
	//#UC END# *45EEE262018E_45FEB86E0267_GET*
}

// implemented method from Query
Query* Query_i::clone () {
	//#UC START# *45EEE1450288_45FEB86E0267*
	GblPilotQueryDef::Query_var server_query = this->build_query ();
	Query_i* query_i = new Query_i (server_query);
	query_i->m_name = m_name;
	query_i->m_comment = m_comment;
	return query_i;
	//#UC END# *45EEE1450288_45FEB86E0267*
}

// implemented method from Query
// Количество найденных документов при последнем поиске.
unsigned long Query_i::get_count () const {
	//#UC START# *45EEE145028F_45FEB86E0267_GET*
	throw QueryNotExecuted ();
	//#UC END# *45EEE145028F_45FEB86E0267_GET*
}

// implemented method from Query
const Date& Query_i::get_date () const {
	//#UC START# *45EEE19A0122_45FEB86E0267_GET*
	throw QueryNotExecuted ();
	//#UC END# *45EEE19A0122_45FEB86E0267_GET*
}

// implemented method from Query
void Query_i::execute (
	DynList* filtrate_list
	, SearchProgressIndicator::ProgressIndicatorForSearch* progress
	, SearchProgressIndicator::CancelSearch*& cancel_process
) {
	//#UC START# *45FF9F9D01F5_45FEB86E0267*
	
	GblPilotQueryDef::Query_var query = this->build_query ();

	CORBA::String_var comment (
		ApplicationHelper::instance ()->get_cached_function_manager ()->get_full_query_name (query.in (), "\n")
	);
	
	this->set_comment (GCI::IO::String_var (GCI::IO::StringFactory::make (comment.in ())).in ());
	
	ACE_Date_Time cur_time;
	char time [128];
	sprintf (time, " (%02d.%02d.%04d - %02d:%02d:%02d)"
		, cur_time.day ()
		, cur_time.month ()
		, cur_time.year ()
		, cur_time.hour ()
		, cur_time.minute ()
		, cur_time.second ()
	);
	
	std::string name = CORBA::String_var (
		ApplicationHelper::instance ()->get_cached_function_manager ()->get_full_query_name (query.in (), "; ")
	).in ();
	
	name = NOT_UNICODE_TR("Запрос: ") + name.substr (0, 70);
	if (name.size () > 70) {
		name += "...";
	}
	name += time;
	this->set_name (GCI::IO::String_var (GCI::IO::StringFactory::make (name.c_str ())).in ());

	cancel_process = Core::TypeTraits<SearchProgressIndicator::CancelSearch>::Factory::make (
		ApplicationHelper::instance ()->get_cached_search_manager ()
	);

	typedef ProgressIndicatorServant_i<SearchProgressIndicator::ProgressIndicatorForSearch> NewExecutePI;
	
	GCD::ProgressIndicator_var progress_indicator;
	NewExecutePI* new_execute_pi = 0;
	if (progress != 0) {
		new_execute_pi = new NewExecutePI (progress);
		progress_indicator = new_execute_pi->_this ();
		new_execute_pi->_remove_ref ();
	}

	SearchManager_ami* search_manager_i = new SearchManager_ami (
		progress
		, new_execute_pi
	);
	GblPilot::AMI_SearchManagerHandler_var search_manager = search_manager_i->_this ();
	search_manager_i->_remove_ref ();

	DynList_i* dl = dynamic_cast<DynList_i*>(filtrate_list);
	ApplicationHelper::instance ()->get_cached_search_manager ()->sendc_search (
		search_manager.in ()
		, query.in()
		, dl ? dl->get_actual_server_tree () : 0
		, progress_indicator.in()
	);
	//#UC END# *45FF9F9D01F5_45FEB86E0267*
}

// implemented method from Query
GCI::IO::String* Query_i::get_comment () const {
	//#UC START# *4762B73103AB_45FEB86E0267*
	if (m_comment.is_nil () && this->get_is_saved ()) {
		m_comment = GCI::IO::StringFactory::make (CORBA::String_var (m_saved_query->get_comment ()).in ());
	}
	return m_comment._sretn();
	//#UC END# *4762B73103AB_45FEB86E0267*
}

// implemented method from Query
const GCI::IO::String* Query_i::get_name () const {
	//#UC START# *4762B6E401CD_45FEB86E0267*
	if (m_name.is_nil () && this->get_is_saved ()) {
		m_name = GCI::IO::StringFactory::make (CORBA::String_var (m_saved_query->get_name ()).in ());
	}
	return m_name._sretn ();
	//#UC END# *4762B6E401CD_45FEB86E0267*
}

// implemented method from Query
// получен ли запрос с фильтра
bool Query_i::is_filter_query () const {
	//#UC START# *4CB6EAED0168_45FEB86E0267*
	return false;
	//#UC END# *4CB6EAED0168_45FEB86E0267*
}

// implemented method from Query
// Отправить запрос на консультацию
void Query_i::send_query () {
	//#UC START# *45EEE1450289_45FEB86E0267*
	GblPilotQueryDef::Query_var query = this->build_query ();
	ConsultationManager_ami* consultation_manager_ami = new ConsultationManager_ami ();
	GblConsultingClient::AMI_ConsultationManagerHandler_var consultation_manager = consultation_manager_ami->_this ();
	consultation_manager_ami->_remove_ref ();
	ApplicationHelper::instance ()->get_cached_consultation_manager ()->sendc_send_query (consultation_manager.in (), query.in ());
	//#UC END# *45EEE1450289_45FEB86E0267*
}

// implemented method from Query
void Query_i::set_comment (GCI::IO::String* comment) {
	//#UC START# *4762B7150252_45FEB86E0267*
	m_comment = GCI::IO::String::_duplicate (comment);
	//#UC END# *4762B7150252_45FEB86E0267*
}

// implemented method from Query
void Query_i::set_name (GCI::IO::String* name) {
	//#UC START# *4762B6A10258_45FEB86E0267*
	m_name = GCI::IO::String::_duplicate (name);
	//#UC END# *4762B6A10258_45FEB86E0267*
}

// implemented method from Query
QueryType Query_i::get_type () const {
	//#UC START# *45EEE16E01DE_45FEB86E0267_GET*
	return QueryHelper::get_type ();
	//#UC END# *45EEE16E01DE_45FEB86E0267_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

