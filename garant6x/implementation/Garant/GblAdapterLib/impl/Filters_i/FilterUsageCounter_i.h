////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterUsageCounter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterUsageCounter_i
// Заголовок реализации класса серванта для интерфеса FiltersUsageCounter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERUSAGECOUNTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERUSAGECOUNTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/Filters_i.h"

namespace GblAdapterLib {

class FilterUsageCounter_i; // self forward Var
typedef ::Core::Var<FilterUsageCounter_i> FilterUsageCounter_i_var;
typedef ::Core::Var<const FilterUsageCounter_i> FilterUsageCounter_i_cvar;

class FilterUsageCounter_i_factory;

class FilterUsageCounter_i:
	virtual public FiltersUsageCounter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (FilterUsageCounter_i)
	friend class FilterUsageCounter_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <FilterUsageCounter_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FilterUsageCounter_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FilterUsageCounter_i ();

	virtual ~FilterUsageCounter_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void delete_filter (unsigned long id, bool is_pharm) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Counter m_counter;

	ErasedIds m_erased;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from FiltersUsageCounter
	virtual void add (const FilterFromQuery* filter);

	// implemented method from FiltersUsageCounter
	virtual bool is_used (const FilterFromQuery* filter) const;

	// implemented method from FiltersUsageCounter
	virtual void mark_to_erase (const FilterFromQuery* filter);

	// implemented method from FiltersUsageCounter
	virtual bool marked_to_erase (const FilterFromQuery* filter) const;

	// implemented method from FiltersUsageCounter
	virtual void remove (const FilterFromQuery* filter);
}; // class FilterUsageCounter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERUSAGECOUNTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
