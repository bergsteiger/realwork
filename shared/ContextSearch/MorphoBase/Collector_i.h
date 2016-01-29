////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/Collector_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::Collector_i
//
// Коллектор
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_COLLECTOR_I_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_COLLECTOR_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/DB/DBCore/DBCore.h"

namespace ContextSearch {

// Коллектор
class Collector_i;
typedef Core::Var<Collector_i> Collector_i_var;
typedef Core::Var<const Collector_i> Collector_i_cvar;

class Collector_i :
	virtual public Search::IResCollector
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Collector_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	Collector_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// _retn
	Search::RelevancyDocuments* _retn ();

private:
	// merge
	void merge ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Box<Search::RelevancyDocuments> m_data;

	DBCore::DocId m_last;

	size_t m_mid;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Defs::IResCollector
	// add
	void add (Defs::DocId id, const Defs::RelevancyInfo& info);

	// implemented method from Defs::IResCollector
	// empty
	bool empty () const;

	// implemented method from Defs::IResCollector
	// finish
	void finish (const std::string& req);

	// implemented method from Defs::IResCollector
	// filter
	Defs::IFilter* get_filter (char op);

	// implemented method from Defs::IResCollector
	// start
	void start (const std::string& req);
}; // class Collector_i

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_COLLECTOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

