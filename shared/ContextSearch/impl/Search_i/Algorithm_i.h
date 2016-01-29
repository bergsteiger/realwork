////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Search_i/Algorithm_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::Algorithm_i
// Заголовок реализации класса серванта для интерфеса IAlgorithm
//
// Реализация интерфейса поискового алгоритма
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_ALGORITHM_I_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_ALGORITHM_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/MorphoBase/Searcher.h"

namespace ContextSearch {
namespace Search_i {

class Algorithm_i; // self forward Var
typedef ::Core::Var<Algorithm_i> Algorithm_i_var;
typedef ::Core::Var<const Algorithm_i> Algorithm_i_cvar;

class Algorithm_i_factory;

// Реализация интерфейса поискового алгоритма
class Algorithm_i:
	virtual public Search::IAlgorithm
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Algorithm_i)
	friend class Algorithm_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Algorithm_i (Search::IRequestView* view, DBComm::IProgress* progress, const Search::AlgorithmProperties& properties);

	virtual ~Algorithm_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// выполнить для синонимичного запроса
	void execute (const Search::RequestEx& request, Search::IFilter* filter, Search::IResCollector* collector);

	// выполнить (mt)
	Search::RelevancyDocuments* execute_mt (Search::IWorker* worker);

	// релевантные фрагменты
	Search::FragmentsPair* get_fragments (
		const Search::RequestEx& request
		, DBComm::DocId doc_id
		, const Search::InvisibleBlocks& blocks
	);

	// очко
	void set_max_fragment (size_t req_size);

	// изменить состояние прогресс-индикатора
	bool set_progress (size_t i, Searcher& searcher);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	size_t m_max_fragment;

	DBComm::IProgress_var m_progress;

	Search::AlgorithmProperties m_properties;

	Search::IRequestView_var m_view;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Search::IAlgorithm
	// список релевантных фрагментов
	virtual Defs::Fragments* get_fragments (DBComm::DocId doc_id, const Defs::InvisibleBlocks& blocks);

	// implemented method from Search::IAlgorithm
	// поиск
	virtual void search (Defs::IResCollector* collector, Defs::IFilter* filter);
}; // class Algorithm_i

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_ALGORITHM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
