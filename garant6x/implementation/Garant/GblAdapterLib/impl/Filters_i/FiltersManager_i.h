////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Filters_i/FiltersManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Filters_i::FiltersManager_i
// Заголовок реализации класса серванта для интерфеса FiltersManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERSMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERSMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"

//#UC START# *4CA9CBF3026F_CUSTOM_INCLUDES*
//#UC END# *4CA9CBF3026F_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class FiltersManager_i; // self forward Var
typedef ::Core::Var<FiltersManager_i> FiltersManager_i_var;
typedef ::Core::Var<const FiltersManager_i> FiltersManager_i_cvar;

class FiltersManager_i_factory;

class FiltersManager_i:
	virtual public FiltersManager
	, virtual public ::Core::RefCountObjectBase
	, virtual public GSI::NotifyService_i::Consumer_i
{
	SET_OBJECT_COUNTER (FiltersManager_i)
	friend class FiltersManager_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <FiltersManager_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FiltersManager_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FiltersManager_i ();

	virtual ~FiltersManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual FiltersFromQuery* get_adapter_list (const GblFilters::FiltersList& server_filters) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GblFilters::FiltersList_var m_legal_filters;

	FilterNotifier_cvar m_legal_notifier;

	mutable GblFilters::FiltersList_var m_pharm_filters;

	FilterNotifier_cvar m_pharm_notifier;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from FiltersManager
	virtual void clear_cache (bool pharm);

	// implemented method from FiltersManager
	// создать новый фильтр
	virtual void create_filter (const EntityBase* query, const GCI::IO::String* name);

	// implemented method from FiltersManager
	virtual void filter_name_changed (bool pharm) const;

	// implemented method from FiltersManager
	virtual void filter_permanence_changed (bool pharm) const;

	// implemented method from FiltersManager
	virtual void filter_removed (bool pharm) const;

	// implemented method from FiltersManager
	// получить список фильтров для правовых документов
	virtual FiltersFromQuery* get_legal_filters () const;

	// implemented method from FiltersManager
	virtual FiltersFromQuery* get_pharm_filters () const;

	// implemented method from FiltersManager
	virtual void set_legal_notifier (FilterNotifier* notifier);

	// implemented method from FiltersManager
	virtual void set_pharm_notifier (FilterNotifier* notifier);
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from GSI::NotifyService::Consumer
	// Для получения сообщений реализация перекрывает этот метод.
	virtual void fire_event (const CORBA::Any& event);


//#UC START# *4CA9CBF3026F*
//#UC END# *4CA9CBF3026F*
}; // class FiltersManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_I_FILTERSMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
