////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FiltersQuery_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"
#include "garantServer/src/Business/GblPilot/Home/Adapter.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FiltersQuery_i::FiltersQuery_i (FilterFromQuery* filter)
//#UC START# *4CAC28CC006A_4CAC294802AB_4CAC29B502B5_BASE_INIT*
	: FiltersQueryHelper (QueryTypeTranslatorSingleton::instance()->get (filter->get_server_query ().type))
	, QueryHelper (QueryTypeTranslatorSingleton::instance()->get (filter->get_server_query ().type))
	, m_filter (Core::IObject::_duplicate (filter))
	, m_need_load (true)
//#UC END# *4CAC28CC006A_4CAC294802AB_4CAC29B502B5_BASE_INIT*
{
	//#UC START# *4CAC28CC006A_4CAC294802AB_4CAC29B502B5_BODY*
	//#UC END# *4CAC28CC006A_4CAC294802AB_4CAC29B502B5_BODY*
}

FiltersQuery_i::~FiltersQuery_i () {
	//#UC START# *4CAC29B502B5_DESTR_BODY*
	//#UC END# *4CAC29B502B5_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void FiltersQuery_i::check_saved_query () {
	//#UC START# *4CAC409C0373*
	if (m_need_load) {
		m_filter->check ();
		m_need_load = false;
		this->parse_server_query ();
	}
	//#UC END# *4CAC409C0373*
}

void FiltersQuery_i::parse_server_query () {
	//#UC START# *4CAC4334014E*
	m_attributes.clear ();
	CORBA::ULong length = m_filter->get_server_query ().attributes.length ();
	for (CORBA::ULong i = 0; i < length; ++i) {
		const GblPilotQueryDef::QueryAttribute& server_attribute = m_filter->get_server_query ().attributes [i];
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
	//#UC END# *4CAC4334014E*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool FiltersQuery_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_4CAC29B502B5_GET*
	return true;
	//#UC END# *456EB3E1017C_4CAC29B502B5_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* FiltersQuery_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_4CAC29B502B5*
	GblPilotQueryDef::Query_var query (this->build_query ());
	m_filter->save_to_server (query.in ());
	return 0;
	//#UC END# *456EB3E10178_4CAC29B502B5*
}

// implemented method from Query
Query* FiltersQuery_i::clone () {
	//#UC START# *45EEE1450288_4CAC29B502B5*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEE1450288_4CAC29B502B5*
}

// implemented method from Query
const GCI::IO::String* FiltersQuery_i::get_name () const {
	//#UC START# *4762B6E401CD_4CAC29B502B5*
	return m_filter->get_name ();
	//#UC END# *4762B6E401CD_4CAC29B502B5*
}

// implemented method from Query
void FiltersQuery_i::set_name (GCI::IO::String* name) {
	//#UC START# *4762B6A10258_4CAC29B502B5*
	m_filter->set_name (name);
	//#UC END# *4762B6A10258_4CAC29B502B5*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

