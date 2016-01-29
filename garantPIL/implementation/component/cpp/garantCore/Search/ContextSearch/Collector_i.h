////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/Collector_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::Collector_i
//
// Коллектор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CONTEXTSEARCH_COLLECTOR_I_H__
#define __GARANTCORE_SEARCH_CONTEXTSEARCH_COLLECTOR_I_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <vector>
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/refcol.h"

//#UC START# *533EB45103D2_CUSTOM_INCLUDES*
//#UC END# *533EB45103D2_CUSTOM_INCLUDES*

namespace Search {

// Коллектор
class Collector_i;
typedef Core::Var<Collector_i> Collector_i_var;
typedef Core::Var<const Collector_i> Collector_i_cvar;

class Collector_i :
	virtual public SearchAdapterLib::Adapter::IResCollector
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Collector_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// DocVector
	typedef std::vector < unsigned long > DocVector;

public:
	// Data
	struct Data {
		// type
		DocVector type;
		// code
		DocVector code;
	};

	// RequestData
	typedef std::map < std::string, Data > RequestData;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	Collector_i (SearchAdapterLib::Adapter::IRelevancyInfo* info, const RequestData& in);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// _retn
	RefwReleCollection* _retn ();

private:
	// merge
	void merge ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchAdapterLib::Adapter::IFilter_var m_filter;

	SearchAdapterLib::Adapter::IRelevancyInfo* m_info_collector;

	long m_last;

	size_t m_mid;

	const RequestData* m_request_data;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContextSearch::Defs::IResCollector
	// add
	void add (ContextSearch::Defs::DocId id, const ContextSearch::Defs::RelevancyInfo& info);

	// implemented method from ContextSearch::Defs::IResCollector
	// empty
	bool empty () const;

	// implemented method from ContextSearch::Defs::IResCollector
	// finish
	void finish (const std::string& req);

	// implemented method from ContextSearch::Defs::IResCollector
	// filter
	ContextSearch::Defs::IFilter* get_filter (char op);

	// implemented method from ContextSearch::Defs::IResCollector
	// start
	void start (const std::string& req);

//#UC START# *533EB45103D2*
private:
	Core::Aptr <RefwReleCollection> m_data;
	Core::Aptr <RefwReleCollection> m_tmp;
//#UC END# *533EB45103D2*
}; // class Collector_i

} // namespace Search


#endif //__GARANTCORE_SEARCH_CONTEXTSEARCH_COLLECTOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

