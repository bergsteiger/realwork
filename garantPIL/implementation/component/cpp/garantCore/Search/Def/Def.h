////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Def/Def.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::Search::Def
//
// Общие типы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_DEF_H__
#define __GARANTCORE_SEARCH_DEF_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <vector>
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "shared/GCL/data/std_defs.h"

namespace Search {

// Логическая операция
typedef char MergeOp;

#pragma pack (push, 1)

// Тэг
struct QueryTag {
	// ключ
	std::string key;
	// данные
	std::string val;
	// логическая операция
	MergeOp op;
	//#UC START# *50A514AF0034*
	QueryTag () {
	}
	QueryTag (const std::string& _key) : key (_key) {
	}
	QueryTag (const std::string& _key, const std::string& _val, MergeOp _op) : key (_key), val (_val), op (_op) {
	}

	bool operator == (const std::string& str) const {
		return key == str;
	}
	bool operator != (const std::string& str) const {
		return key != str;
	}
	//#UC END# *50A514AF0034*
};

#pragma pack (pop)

// Список тэгов
typedef std::vector < QueryTag > QueriesTags;

#pragma pack (push, 1)

// Параметры поиска
struct SearchProp {
	// идентификатор документа
	unsigned long doc_id;
	// максимальный размер результата поиска
	long max_res_size;
	// список
	const SortedCollection* init;
	// фильтр
	SearchAdapterLib::Adapter::IFilter* filter;
	// контекстные индексы
	GCL::StrVector ctx_src;
	SearchProp () : doc_id(0) {
		//#UC START# *50A9FEBC01E1_DEF_INIT_CTOR*
		init = 0;
		filter = 0;
		info_collector = 0;

		max_res_size = std::numeric_limits <long>::max () - 1;
		//#UC END# *50A9FEBC01E1_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *50A9FEBC01E1*
	ContextSearch::Defs::IRelevancyInfo* info_collector;
	//#UC END# *50A9FEBC01E1*
};

#pragma pack (pop)

#pragma pack (push, 1)

// Результат поиска
struct SearchResult {
	// признак усечения списка
	bool is_cut;
	// признак прерывания поиска пользователем
	bool is_interrupted;
	// размер полного списка
	size_t full_size;
	SearchResult () : is_cut(false), is_interrupted(false), full_size(0) {
		//#UC START# *509D097B02AD_DEF_INIT_CTOR*
		//#UC END# *509D097B02AD_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *509D097B02AD*
	Core::Aptr <SortedCollection> list;
	//#UC END# *509D097B02AD*
};

#pragma pack (pop)

class IQuery;
typedef ::Core::Var<IQuery> IQuery_var;
typedef ::Core::Var<const IQuery> IQuery_cvar;
// Запрос
class IQuery
	: virtual public ::Core::IObject
{
public:
	// данные
	virtual const std::string& get_data () const = 0;

	// тип
	virtual const std::string& get_type () const = 0;
};

class IBooleanQuery;
typedef ::Core::Var<IBooleanQuery> IBooleanQuery_var;
typedef ::Core::Var<const IBooleanQuery> IBooleanQuery_cvar;
// Логический запрос
class IBooleanQuery
	: virtual public IQuery
{
public:
	// добавить запрос
	virtual void add (IQuery* query, MergeOp op) = 0;

	// количество запросов
	virtual size_t get_count () const = 0;
};

class ISearcher;
typedef ::Core::Var<ISearcher> ISearcher_var;
typedef ::Core::Var<const ISearcher> ISearcher_cvar;
// Интерфейс поисковика
class ISearcher
	: virtual public ::Core::IObject
{
public:
	// выполнить
	virtual SearchResult* execute (const std::string& query, const SearchProp& prop) = 0;

	// выполнить
	virtual SearchResult* execute (IQuery* query, const SearchProp& prop) = 0;
};

// Типы запросов
static const std::string BOOL_TYPE = "BOOL"; // Тип логического запроса
static const std::string BODY_TYPE = "MorphoText"; // Тип контекстного запроса для поиска в тексте
static const std::string TITLE_TYPE = "MorphoName"; // Тип контекстного запроса для поиска в заголовках

// Множество сегментов
typedef std::set < short > Segments;

// Невалидный ключ
class InvalidKey : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Логические операции
static const char so_AND = '&'; // AND
static const char so_OR = '|'; // OR
static const char so_NOT = '~'; // NOT

class IBooleanFilter;
typedef ::Core::Var<IBooleanFilter> IBooleanFilter_var;
typedef ::Core::Var<const IBooleanFilter> IBooleanFilter_cvar;
// Логический фильтр
class IBooleanFilter
	: virtual public SearchAdapterLib::Adapter::IFilter
{
public:
	// добавить
	virtual void add (SearchAdapterLib::Adapter::IFilter* in) = 0;
};

} // namespace Search


#endif //__GARANTCORE_SEARCH_DEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
