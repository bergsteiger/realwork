////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FilterFromQuery_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FilterFromQuery_i
// Заголовок реализации класса серванта для интерфеса FilterFromQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERFROMQUERY_I_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERFROMQUERY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"

//#UC START# *4CA9CBD90227_CUSTOM_INCLUDES*
//#UC END# *4CA9CBD90227_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class FilterFromQuery_i; // self forward Var
typedef ::Core::Var<FilterFromQuery_i> FilterFromQuery_i_var;
typedef ::Core::Var<const FilterFromQuery_i> FilterFromQuery_i_cvar;

class FilterFromQuery_i_factory;

class FilterFromQuery_i:
	virtual public FilterFromQuery
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (FilterFromQuery_i)
	friend class FilterFromQuery_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FilterFromQuery_i (const GblFilters::Filter& filter);

	virtual ~FilterFromQuery_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// все ли атрибуты в фильтре могут быть восстановлены
	bool m_checked;

	GblFilters::Filter m_filter;

	GblPilotQueryDef::Query m_saved_query;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from FilterFromQuery
	virtual const bool get_changeable () const;

	// implemented method from FilterFromQuery
	// проверить атрибуты в фильтре
	virtual bool check ();

	// implemented method from FilterFromQuery
	virtual const unsigned long get_flags () const;

	// implemented method from FilterFromQuery
	virtual const GblPilotQueryDef::Query& get_server_query () const;

	// implemented method from FilterFromQuery
	// идентификатор нужен оболочке, чтобы идентифицировать установленные фильтры (К274848126)
	virtual const unsigned long get_id () const;

	// implemented method from FilterFromQuery
	// возвращает true, если оригинальный и переданный фильтры совпадают
	virtual bool is_same (const FilterFromQuery* other) const;

	// implemented method from FilterFromQuery
	// наложен ли фильтр
	virtual bool is_used () const;

	// implemented method from FilterFromQuery
	// удалить фильтр после того, как он перестанет использоваться
	virtual void mark_to_erase ();

	// implemented method from FilterFromQuery
	virtual bool marked_to_erase () const;

	// implemented method from FilterFromQuery
	virtual const GCI::IO::String* get_name () const;
	virtual GCI::IO::String* get_name ();

	virtual void set_name (GCI::IO::String* name);

	// implemented method from FilterFromQuery
	virtual const bool get_permanent () const;

	virtual void set_permanent (bool permanent);

	// implemented method from FilterFromQuery
	// если делать query Search::Query, каковым он и является, на модели получается дофига циклических
	// связей, которые небыстро будет развязать
	virtual const EntityBase* get_query () const;
	virtual EntityBase* get_query ();

	// implemented method from FilterFromQuery
	virtual void save_to_server (const GblPilotQueryDef::Query& query);

//#UC START# *4CA9CBD90227*
private:
	CORBA::Boolean m_all_attributes_restored;
//#UC END# *4CA9CBD90227*
}; // class FilterFromQuery_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERFROMQUERY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
