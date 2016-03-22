////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Searcher_i
//
// Реализация интерфейса ISearcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/LibHome.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/RelevancyCore/FragmentsOperations.h"

//#UC START# *4ECE68240089_CUSTOM_INCLUDES*
//#UC END# *4ECE68240089_CUSTOM_INCLUDES*

namespace SearchAdapterLib {
namespace Adapter_i {

//#UC START# *4ECE68240089*
template <typename Type, typename Data>
class Impl : virtual public Type, virtual public Core::RefCountObjectBase {
	SET_OBJECT_COUNTER (Impl)
public:
	explicit Impl (Data* d) : m_data (d) { }

protected:
	const Data& data () const { return *m_data; }

private:
	Core::Aptr <Data> m_data;
};
//#UC END# *4ECE68240089*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Searcher_i::Searcher_i (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src)
//#UC START# *4ECE64720232_4ECE67B20082_4ECE68240089_BASE_INIT*
	: SearchCore (base, cache, src)
//#UC END# *4ECE64720232_4ECE67B20082_4ECE68240089_BASE_INIT*
{
	//#UC START# *4ECE64720232_4ECE67B20082_4ECE68240089_BODY*
	//#UC END# *4ECE64720232_4ECE67B20082_4ECE68240089_BODY*
}

Searcher_i::~Searcher_i () {
	//#UC START# *4ECE68240089_DESTR_BODY*
	//#UC END# *4ECE68240089_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Adapter::ISearcher
// получить список релевантных документов
Adapter::IDocuments* Searcher_i::get_documents (
	const ContextSearch::Defs::Requests& reqs
	, const ContextSearch::Defs::SearchInfo& info
) {
	//#UC START# *4ECE771A0359_4ECE68240089*
	Adapter::IDocuments_var ret;

	try {
		Core::Aptr <ContextSearch::Defs::RelevancyDocuments> res = SearchCore::search (reqs, info);

		if (res.is_nil () == false) {
			ret = new Impl <Adapter::IDocuments, ContextSearch::Defs::RelevancyDocuments> (res._retn ());
		}
	} catch (ContextSearch::Search::CanceledByUser&) {
		throw CanceledByUser ();
	} catch (ContextSearch::Manage::InvalidQuery&) {
		LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return ret._retn ();
	//#UC END# *4ECE771A0359_4ECE68240089*
}

// implemented method from Adapter::ISearcher
// получить список релевантных фрагментов
Adapter::IFragments* Searcher_i::get_fragments (
	const std::string& in
	, DBCore::DocId id
	, const ContextSearch::Defs::PosPair& pair
) {
	//#UC START# *4ECE778602D4_4ECE68240089*
	Adapter::IFragments_var ret;

	try {
		Core::Aptr <ContextSearch::Defs::Fragments> res = SearchCore::get_fragments (in, id);

		if (res.is_nil () == false) {
			if (res->empty () == false) {
				ContextSearch::FragmentsOperations::filtration (*(res.inout ())); // удаление пересекающихся
				ContextSearch::FragmentsOperations::sort (*(res.inout ()), pair); // сортировка
			}
			ret = new Impl <Adapter::IFragments, ContextSearch::Defs::Fragments> (res._retn ());
		}
	} catch (ContextSearch::Manage::InvalidQuery&) {
		LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return ret._retn ();
	//#UC END# *4ECE778602D4_4ECE68240089*
}

// implemented method from Adapter::ISearcher
// получить список релевантных фрагментов
Adapter::IFragments* Searcher_i::get_fragments (const std::string& in, DBCore::DocId id) {
	//#UC START# *4ECE77D500F8_4ECE68240089*
	Adapter::IFragments_var ret;

	try {
		Core::Aptr <ContextSearch::Defs::Fragments> res = SearchCore::get_fragments (in, id);

		if (res.is_nil () == false) {
			ret = new Impl <Adapter::IFragments, ContextSearch::Defs::Fragments> (res._retn ());
		}
	} catch (ContextSearch::Manage::InvalidQuery&) {
		LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return ret._retn ();
	//#UC END# *4ECE77D500F8_4ECE68240089*
}

// implemented method from Adapter::ISearcher
// получить позиции всех релевантных фрагментов
Adapter::IPositions* Searcher_i::get_positions (const GCL::StrVector& reqs, DBCore::DocId id) {
	//#UC START# *4ECE773E03BE_4ECE68240089*
	Adapter::IPositions_var ret;

	try {
		Core::Aptr <ContextSearch::Defs::Positions> res = SearchCore::get_positions (reqs, id);

		if (res.is_nil () == false) {
			ret = new Impl <Adapter::IPositions, ContextSearch::Defs::Positions> (res._retn ());
		}
	} catch (ContextSearch::Manage::InvalidQuery&) {
		LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return ret._retn ();
	//#UC END# *4ECE773E03BE_4ECE68240089*
}

// implemented method from Adapter::ISearcher
// поиск
void Searcher_i::search (
	const ContextSearch::Defs::Requests& in
	, const ContextSearch::Defs::SearchInfo& info
	, DBCore::IProgress* progress
	, Adapter::IResCollector* collector
) {
	//#UC START# *552FF8F00287_4ECE68240089*
	try {
		SearchCore::search (in, info, progress, collector);
	} catch (ContextSearch::Search::CanceledByUser&) {
		throw CanceledByUser ();
	} catch (ContextSearch::Manage::InvalidQuery&) {
		LOG_W (("%s: invalid query", GDS_CURRENT_FUNCTION));
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *552FF8F00287_4ECE68240089*
}
} // namespace Adapter_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

