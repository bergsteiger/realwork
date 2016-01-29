////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/Query_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::Query_i
// Заголовок реализации класса серванта для интерфеса IQuery
//
// Реализация интерфейса менеджера поисковых запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_QUERY_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_QUERY_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Manage/Manage.h"

namespace ContextSearch {
namespace Manage_i {

class Query_i; // self forward Var
typedef ::Core::Var<Query_i> Query_i_var;
typedef ::Core::Var<const Query_i> Query_i_cvar;

class Query_i_factory;

// Реализация интерфейса менеджера поисковых запросов
class Query_i:
	virtual public Manage::IQuery
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Query_i)
	friend class Query_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Константы
	static const size_t RESERVE_SIZE; // размер для резервирования

	// Информация о поисковом запросе
	struct ReqInfo {
		// поле флагов
		unsigned long flags;
		// максимальный размер фрагмента
		size_t max_fragment;
		// синонимировать
		bool has_syn;
		// контекст
		std::string context;
		// исходная строка
		std::string src;
		// логическая операция
		char op;
		ReqInfo () : flags(0), max_fragment(0), has_syn(true), op('&') {
			//#UC START# *48D36A0601AE_DEF_INIT_CTOR*
			//#UC END# *48D36A0601AE_DEF_INIT_CTOR**cpp*
		}
		//#UC START# *48D36A0601AE*
		bool operator < (const ReqInfo& val) const {
			short x = (op == Defs::so_AND)? 3 : ((op == Defs::so_OR)? 2 : 1);
			short y = (val.op == Defs::so_AND)? 3 : ((val.op == Defs::so_OR)? 2 : 1);
			return x < y;
		}
		//#UC END# *48D36A0601AE*
	};

	// Инфо по каждому запросу
	typedef std::vector < ReqInfo > ReqsInfo;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	Query_i (const Manage::Env& in, DBComm::IDBCommunicator* comm);

	~Query_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// выполнить поиск
	void execute (
		const ReqInfo& req
		, Search::IFilter* filter
		, Relevancy::IRelevancyInfo* info
		, Search::IResCollector* collector
	);

	// алгоритм
	Search::IAlgorithm* get_alg (
		Search::IRequestView* view
		, const ReqInfo& info
		, Relevancy::IRelevancyInfo* collector
		, bool strong_deflate
	);

	// все лексемы запроса
	Search::Phrase* get_lexemes (const Search::SplitRequests& in, bool add_special);

	// представление запроса
	Search::IRequestView* get_view (const ReqInfo& info, bool is_default);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator_var m_communicator;

	Manage::Env m_env;

	ReqsInfo m_info;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Manage::IQuery
	// добавить запрос
	void add (const Defs::Request& req, bool uwc);

	// implemented method from Manage::IQuery
	// очистить кэш
	void clear ();

	// implemented method from Manage::IQuery
	// выполнить поиск
	Defs::RelevancyDocuments* execute (const Defs::SearchInfo& info);

	// implemented method from Manage::IQuery
	// выполнить поиск
	void execute (const Defs::SearchInfo& info, Defs::IResCollector* collector);

	// implemented method from Manage::IQuery
	// список синонимичных запросов
	Search::SplitRequests* get_data ();

	// implemented method from Manage::IQuery
	// выполнить поиск в документе
	Defs::Fragments* get_fragments (DBComm::DocId id);

	// implemented method from Manage::IQuery
	// все лексемы запроса
	GCL::StrVector* get_lexemes (bool add_special);

	// implemented method from Manage::IQuery
	// позиции релевантных фрагментов
	Defs::Positions* get_positions (DBComm::DocId id);
}; // class Query_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_QUERY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
