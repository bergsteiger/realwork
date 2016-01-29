////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::Prime_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Business/GblPrime/Home/Client.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Prime_i::Prime_i (PrimeKey key, const char* name, GblFoldersAdap::SavedQueryData query)
//#UC START# *47BECCE501B5_47BEE4840213_47BEECF100AF_BASE_INIT*
	: m_key (key), m_name (GCI::IO::StringFactory::make (name)), m_query (query)
//#UC END# *47BECCE501B5_47BEE4840213_47BEECF100AF_BASE_INIT*
{
	//#UC START# *47BECCE501B5_47BEE4840213_47BEECF100AF_BODY*
	//#UC END# *47BECCE501B5_47BEE4840213_47BEECF100AF_BODY*
}

Prime_i::~Prime_i () {
	//#UC START# *47BEECF100AF_DESTR_BODY*
	//#UC END# *47BEECF100AF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Prime_i::save () {
	//#UC START# *47C2BFB00331*
	GblPrime::PrimeQuery prime;

	prime.key = m_key;
	prime.name = m_name->get_data ();
	prime.query = m_query;

	ApplicationHelper::instance ()->get_cached_prime ()->update_query (prime);
	//#UC END# *47C2BFB00331*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Prime
PrimeKey Prime_i::get_id () const {
	//#UC START# *47C29BAB018A_47BEECF100AF_GET*
	return m_key;
	//#UC END# *47C29BAB018A_47BEECF100AF_GET*
}

// implemented method from Prime
const GCI::IO::String& Prime_i::get_name () const {
	//#UC START# *47BED5ED00BC_47BEECF100AF_GET*
	return *(m_name.ptr ());
	//#UC END# *47BED5ED00BC_47BEECF100AF_GET*
}

GCI::IO::String& Prime_i::get_name () {
	return const_cast<GCI::IO::String&>(((const Prime_i*)this)->get_name ());
}

void Prime_i::set_name (GCI::IO::String* name) {
	//#UC START# *47BED5ED00BC_47BEECF100AF_SET*
	m_name = Core::IObject::_duplicate (name);
	this->save ();
	//#UC END# *47BED5ED00BC_47BEECF100AF_SET*
}

// implemented method from Prime
const Query* Prime_i::get_query () const {
	//#UC START# *47BED62B0318_47BEECF100AF_GET*
	QueryCreator_var creator (QueryCreatorFactory::make ());
	return creator->make_query (m_query.query);
	//#UC END# *47BED62B0318_47BEECF100AF_GET*
}

Query* Prime_i::get_query () {
	return const_cast<Query*>(((const Prime_i*)this)->get_query ());
}

void Prime_i::set_query (Query* query) {
	//#UC START# *47BED62B0318_47BEECF100AF_SET*
	GblPilotQueryDef::Query_var q (query->build_query());
	m_query.query = q;
	m_query.doc_count = 0;
	m_query.filter_type = GblFolders::NO_FILTER;
	this->save ();
	//#UC END# *47BED62B0318_47BEECF100AF_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

