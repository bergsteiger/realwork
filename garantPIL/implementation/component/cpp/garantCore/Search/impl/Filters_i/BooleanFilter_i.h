////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/BooleanFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Filters_i::BooleanFilter_i
//
// Реализация логического фильтра
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FILTERS_I_BOOLEANFILTER_I_H__
#define __GARANTCORE_SEARCH_FILTERS_I_BOOLEANFILTER_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantCore/Search/Def/Def.h"

namespace Search {

// Реализация логического фильтра
class BooleanFilter_i;
typedef Core::Var<BooleanFilter_i> BooleanFilter_i_var;
typedef Core::Var<const BooleanFilter_i> BooleanFilter_i_cvar;

class BooleanFilter_i :
	virtual public IBooleanFilter
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (BooleanFilter_i)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// Операция
	enum Operation {
		ot_None // ничего
		, ot_Or // дизъюнкция
		, ot_And // конъюнкция
		, ot_Not // отрицание
	};

private:
	// Фильтр
	struct DataPair {
		// фильтр
		SearchAdapterLib::Adapter::IFilter_var filter;
		// операция
		Operation op;
		//#UC START# *530B4116006F*
		bool operator < (const DataPair& val) const {
			if (op == val.op) {
				return filter->get_size () < val.filter->get_size (); 
			}
			return op < val.op;
		}
		//#UC END# *530B4116006F*
	};

public:
	// Cписок фильтров
	typedef std::vector < SearchAdapterLib::Adapter::IFilter* > Filters;

	// Компаратор
	struct FiltersCompare : public std::binary_function<SearchAdapterLib::Adapter::IFilter, SearchAdapterLib::Adapter::IFilter, bool> {
		bool operator () (const SearchAdapterLib::Adapter::IFilter* first_param_, const SearchAdapterLib::Adapter::IFilter* second_param_) const;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit BooleanFilter_i (MergeOp op);

public:
	~BooleanFilter_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Filters m_filters;

	MergeOp m_op;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IBooleanFilter
	// добавить
	void add (SearchAdapterLib::Adapter::IFilter* in);

	// implemented method from ContextSearch::Defs::IFilter
	// check
	bool check (ContextSearch::Defs::DocId val);

	// implemented method from ContextSearch::Defs::IFilter
	// check
	bool check () const;

	// implemented method from ContextSearch::Defs::IFilter
	// создать дубликат
	ContextSearch::Defs::IFilter* duplicate ();

	// implemented method from ContextSearch::Defs::IFilter
	// logic op
	char get_op () const;

	// implemented method from ContextSearch::Defs::IFilter
	// size
	size_t get_size () const;

	// implemented method from ContextSearch::Defs::IFilter
	// reset
	void reset ();

	// implemented method from ContextSearch::Defs::IFilter
	// type
	const char* type () const;
}; // class BooleanFilter_i

} // namespace Search


#endif //__GARANTCORE_SEARCH_FILTERS_I_BOOLEANFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

