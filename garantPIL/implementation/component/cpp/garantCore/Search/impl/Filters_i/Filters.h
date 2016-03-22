////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/Filters.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garantCore::Search::Filters_i::Filters
//
// Фасад фильтров
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FILTERS_I_FILTERS_H__
#define __GARANTCORE_SEARCH_FILTERS_I_FILTERS_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *53171A850009_USER_INCLUDES*
#include "garantCore/Search/impl/Filters_i/FiltersFactory.h"
//#UC END# *53171A850009_USER_INCLUDES*

namespace Search {

//#UC START# *53171A850009_USER_DEFINITION*
typedef SearchAdapterLib::Adapter::IFilter IFilter;

////////////////////////////////////////////////////////////////////////////////////////

class FilterData {
protected:
	FilterData () { }

public:
	virtual IFilter* in () const = 0;
	virtual IFilter* _retn () const = 0;
};

////////////////////////////////////////////////////////////////////////////////////////

class Filter : virtual public FilterData {
public:
	Filter (SortedCollection* in, MergeOp op);
	Filter (const SearchAdapterLib::Adapter::LongVector& in, MergeOp op);
	Filter (Index* index, const char* key, MergeOp op);
	Filter (Base* base, const char* name, const char* key, MergeOp op);

public:
	virtual IFilter* in () const;
	virtual IFilter* _retn () const;

private:
	mutable SearchAdapterLib::Adapter::IFilter_var m_data;
};

////////////////////////////////////////////////////////////////////////////////////////

class BooleanFilter : virtual public FilterData {
public:
	BooleanFilter (MergeOp op = Search::so_AND);
	BooleanFilter (IBooleanFilter* in);

public:
	BooleanFilter& operator << (IFilter* data);
	BooleanFilter& operator << (const FilterData& data);

	virtual IFilter* in () const;
	virtual IFilter* _retn () const;

private:
	mutable IBooleanFilter_var m_data;
};
//#UC END# *53171A850009_USER_DEFINITION*

} // namespace Search


#endif //__GARANTCORE_SEARCH_FILTERS_I_FILTERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
