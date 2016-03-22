////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Searcher_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Searcher_i
// Заголовок реализации класса серванта для интерфеса ISearcher
//
// Реализация интерфейса ISearcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHER_I_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/SearchCore.h"

//#UC START# *4ECE68240089_CUSTOM_INCLUDES*
//#UC END# *4ECE68240089_CUSTOM_INCLUDES*

namespace SearchAdapterLib {
namespace Adapter_i {

class Searcher_i; // self forward Var
typedef ::Core::Var<Searcher_i> Searcher_i_var;
typedef ::Core::Var<const Searcher_i> Searcher_i_cvar;

class Searcher_i_factory;

// Реализация интерфейса ISearcher
class Searcher_i:
	virtual public Adapter::ISearcher
	, virtual public ::Core::RefCountObjectBase
	, virtual public SearchCore
{
	SET_OBJECT_COUNTER (Searcher_i)
	friend class Searcher_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Searcher_i (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src);

	virtual ~Searcher_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Adapter::ISearcher
	// получить список релевантных документов
	virtual Adapter::IDocuments* get_documents (
		const ContextSearch::Defs::Requests& reqs
		, const ContextSearch::Defs::SearchInfo& info
	);

	// implemented method from Adapter::ISearcher
	// получить список релевантных фрагментов
	virtual Adapter::IFragments* get_fragments (
		const std::string& in
		, DBCore::DocId id
		, const ContextSearch::Defs::PosPair& pair
	);

	// implemented method from Adapter::ISearcher
	// получить список релевантных фрагментов
	virtual Adapter::IFragments* get_fragments (const std::string& in, DBCore::DocId id);

	// implemented method from Adapter::ISearcher
	// получить позиции всех релевантных фрагментов
	virtual Adapter::IPositions* get_positions (const GCL::StrVector& reqs, DBCore::DocId id);

	// implemented method from Adapter::ISearcher
	// поиск
	virtual void search (
		const ContextSearch::Defs::Requests& in
		, const ContextSearch::Defs::SearchInfo& info
		, DBCore::IProgress* progress
		, Adapter::IResCollector* collector
	);

//#UC START# *4ECE68240089*
//#UC END# *4ECE68240089*
}; // class Searcher_i

} // namespace Adapter_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_SEARCHER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
