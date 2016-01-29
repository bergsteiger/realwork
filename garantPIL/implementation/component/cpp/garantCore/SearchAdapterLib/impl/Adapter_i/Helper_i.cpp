////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Helper_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Helper_i
//
// Реализация интерфейса IHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/LibHome.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Helper_i.h"
// by <<uses>> dependencies
#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Common/ContextUtility.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "garantCore/SearchAdapterLib/Cache/Cache.h"
#include "boost/algorithm/string/join.hpp"

//#UC START# *4ED500FA02BB_CUSTOM_INCLUDES*
//#UC END# *4ED500FA02BB_CUSTOM_INCLUDES*

namespace SearchAdapterLib {
namespace Adapter_i {

//#UC START# *4ED500FA02BB*
class Words_i :
	virtual public Adapter::IStrings
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Words_i)
public:
	explicit Words_i (const GCL::StrVector& val) {
		m_data.insert (val.begin (), val.end ());
	}

private:
	GCL::StrSet m_data;

protected:
	const GCL::StrSet& data () const {
		return m_data;
	}
};

//////////////////////////////////////////////////////////////////////////////////////////

class SynRequest_i :
	virtual public Adapter::ISynRequest
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SynRequest_i)
public:
	explicit SynRequest_i (const ContextSearch::Search::SplitRequests& data) {
		m_data.assign (data.begin (), data.end ());
	}

private:
	ContextSearch::Search::SplitRequests m_data;

protected:
	size_t size () const {
		return m_data.size ();
	}

	const GCL::StrVector& data (size_t i) const {
		return m_data [i].context;
	}
};
//#UC END# *4ED500FA02BB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Helper_i::Helper_i (Morpho::Def::ICache* cache)
//#UC START# *4ED4FE2E00D5_4ED501D002E4_4ED500FA02BB_BASE_INIT*
//#UC END# *4ED4FE2E00D5_4ED501D002E4_4ED500FA02BB_BASE_INIT*
{
	//#UC START# *4ED4FE2E00D5_4ED501D002E4_4ED500FA02BB_BODY*
	m_normalizer = Morpho::Factory::make (cache);
	//#UC END# *4ED4FE2E00D5_4ED501D002E4_4ED500FA02BB_BODY*
}

Helper_i::~Helper_i () {
	//#UC START# *4ED500FA02BB_DESTR_BODY*
	//#UC END# *4ED500FA02BB_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Adapter::IHelper
// синонимия
Adapter::ISynRequest* Helper_i::synonymy (const char* req) {
	//#UC START# *55CDD31B034D_4ED500FA02BB*
	using namespace ContextSearch;

	std::string str = req;

	if (std::count (str.begin (), str.end (), '\"') != 0) {
		str.erase (std::remove (str.begin (), str.end (), '\"'), str.end ());
	}

	{
		GCL::StrVector words;
		ContextUtility::split (words, str, false);
		str = boost::join (words, " ");
	}

	if (str.empty ()) {
		LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
		return 0;
	}

	Search::IRequestView_var view;
	view = Search::IRequestViewFactory::make (Cache::instance ()->get (), m_normalizer.in (), Search::as_Default);

	view->build (GCL::StrVector (1, str), std::map <std::string, std::string> (), str);

	return new SynRequest_i (view->get_sequence ());
	//#UC END# *55CDD31B034D_4ED500FA02BB*
}

// implemented method from Adapter::IHelper
// трансформация строки запроса
Adapter::IStrings* Helper_i::transform (const std::string& str) {
	//#UC START# *4FD0A6370192_4ED500FA02BB*
	using namespace ContextSearch;

	Manage::IRequestTransformer_var transformer = Manage::IRequestTransformerFactory::make (m_normalizer.in ());

	std::string fixed;
	transformer->correct (str, fixed);

	if (fixed.empty ()) {
		return 0;
	}

	DBComm::IDBCommunicator* comm = Cache::instance ()->get ();

	Defs::StrStrMap pseudo;

	Core::Aptr <GCL::StrVector> res;
	res = transformer->execute (fixed, comm->get_exclude_data (), comm->get_hard_phrases (), pseudo);

	return (res->empty ())? 0 : new Words_i (*res);
	//#UC END# *4FD0A6370192_4ED500FA02BB*
}
} // namespace Adapter_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

