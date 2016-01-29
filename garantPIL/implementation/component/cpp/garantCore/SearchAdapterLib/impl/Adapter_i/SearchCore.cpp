////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/SearchCore.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::Adapter_i::SearchCore
//
// Базовая реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/SearchCore.h"
// by <<uses>> dependencies
#include "shared/Morpho/Facade/Factory.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/StreamsManager.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/WildCard_i.h"
#include "garantCore/SearchAdapterLib/Cache/Cache.h"
#include "boost/bind.hpp"
#include "boost/algorithm/string/classification.hpp"

namespace SearchAdapterLib {
namespace Adapter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SearchCore::SearchCore (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src)
//#UC START# *4EC2A3F40141_BASE_INIT*
	: m_uwc (false)
//#UC END# *4EC2A3F40141_BASE_INIT*
{
	//#UC START# *4EC2A3F40141_BODY*
	std::string form_src;

	if (src == "Context.str") {
		form_src = src;
		m_uwc = true;
	} else {
		form_src = "NFContxt";

		std::string::const_iterator it = std::find_if (src.begin (), src.end (), boost::is_digit ());

		if (it != src.end ()) {
			std::string str (it, std::find_if (it, src.end (), !boost::is_digit ())); 
			form_src += str;
			m_uwc = (str == "7");
		}

		form_src += ".str";
	}

	m_env.normalizer = Morpho::Factory::make (cache);
	m_env.factory = new DBComm_i::StreamsManager (base, src, form_src);
	m_env.wild_mng = new DBComm_i::WildCard_i (base, form_src, 1000, m_env.normalizer.in ());
	//#UC END# *4EC2A3F40141_BODY*
}

SearchCore::~SearchCore () {
	//#UC START# *4EC2A3CD010B_DESTR_BODY*
	//#UC END# *4EC2A3CD010B_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// поиск релевантных фрагментов в заданном документе
ContextSearch::Defs::Fragments* SearchCore::get_fragments (const std::string& in, DBCore::DocId id) {
	//#UC START# *4EC3DF5C0123*
	using namespace ContextSearch;

	Manage::IQuery_var query = Manage::IQueryFactory::make (m_env, Cache::instance ()->get ());
	query->add (Defs::Request (in), false);

	return query->get_fragments (id);
	//#UC END# *4EC3DF5C0123*
}

// поиск позиций всех релевантных фрагментов в заданном документе
ContextSearch::Defs::Positions* SearchCore::get_positions (const GCL::StrVector& reqs, DBCore::DocId id) {
	//#UC START# *4ECA82D10030*
	using namespace ContextSearch;

	Manage::IQuery_var query = Manage::IQueryFactory::make (m_env, Cache::instance ()->get ());

	for (GCL::StrVector::const_iterator it = reqs.begin (); it != reqs.end (); ++it) {
		query->add (Defs::Request (*it), false);
	}

	return query->get_positions (id);
	//#UC END# *4ECA82D10030*
}

// поиск релевантных документов
ContextSearch::Defs::RelevancyDocuments* SearchCore::search (
	const ContextSearch::Defs::Requests& reqs
	, const ContextSearch::Defs::SearchInfo& info
) {
	//#UC START# *4EC3E09F02DF*
	using namespace ContextSearch;

	Manage::IQuery_var query = Manage::IQueryFactory::make (m_env, Cache::instance ()->get ());
	std::for_each (reqs.begin (), reqs.end (), boost::bind (&Manage::IQuery::add, query.in (), _1, false));

	return query->execute (info);
	//#UC END# *4EC3E09F02DF*
}

// поиск релевантных документов
void SearchCore::search (
	const ContextSearch::Defs::Requests& reqs
	, const ContextSearch::Defs::SearchInfo& info
	, DBCore::IProgress* progress
	, ContextSearch::Defs::IResCollector* collector
) {
	//#UC START# *552FEF5900C6*
	using namespace ContextSearch;

	m_env.progress = DBCore::IProgress::_duplicate (progress);

	Manage::IQuery_var query = Manage::IQueryFactory::make (m_env, Cache::instance ()->get ());
	std::for_each (reqs.begin (), reqs.end (), boost::bind (&Manage::IQuery::add, query.in (), _1, m_uwc));

	query->execute (info, collector);
	//#UC END# *552FEF5900C6*
}

} // namespace Adapter_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

