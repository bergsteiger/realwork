////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Filters_i/Filters.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garantCore::Search::Filters_i::Filters
// Файл реализации утилитного набора Filters
//
// Фасад фильтров
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Filters_i/Filters.h"
// by <<uses>> dependencies
#include "garantCore/Search/impl/Filters_i/FiltersFactory.h"

//#UC START# *53171A850009_CUSTOM_INCLUDES*
//#UC END# *53171A850009_CUSTOM_INCLUDES*

namespace Search {

//#UC START# *53171A850009*

////////////////////////////////////////////////////////////////////////////////////////
// class Filter implementation

Filter::Filter (SortedCollection* in, MergeOp op) 
	: FilterData ()
	, m_data (FiltersFactory::make (in, op)) {
}

Filter::Filter (const SearchAdapterLib::Adapter::LongVector& in, MergeOp op) 
	: FilterData ()
	, m_data (FiltersFactory::make (in, op)) {
}

Filter::Filter (Index* index, const char* key, MergeOp op) 
	: FilterData ()
	, m_data (FiltersFactory::make (index, key, op)) {
}

Filter::Filter (SearchBase* base, const char* name, const char* key, MergeOp op) 
	: FilterData ()
	, m_data (FiltersFactory::make (base, name, key, op)) {
}

IFilter* Filter::in () const {
	return m_data.in ();
}

IFilter* Filter::_retn () const {
	return m_data._retn ();
}

////////////////////////////////////////////////////////////////////////////////////////
// class BooleanFilter implementation

BooleanFilter::BooleanFilter (MergeOp op)
	: FilterData ()
	, m_data (FiltersFactory::make (op)) {
}

BooleanFilter::BooleanFilter (IBooleanFilter* in) 
	: FilterData ()
	, m_data (IBooleanFilter::_duplicate (in)) {
}

IFilter* BooleanFilter::in () const {
	return m_data.in ();
}

IFilter* BooleanFilter::_retn () const {
	return m_data._retn ();
}

BooleanFilter& BooleanFilter::operator << (const FilterData& data) {
	m_data->add (const_cast <IFilter*> (data.in ()));
	return *this;
}

BooleanFilter& BooleanFilter::operator << (IFilter* data) {
	m_data->add (data);
	return *this;
}

//#UC END# *53171A850009*

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

