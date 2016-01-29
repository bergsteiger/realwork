////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AdapterFiltersQuery_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AdapterFiltersQuery_i
// Заголовок реализации класса серванта для интерфеса AdapterFiltersQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_ADAPTERFILTERSQUERY_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_ADAPTERFILTERSQUERY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQueryHelper.h"

namespace GblAdapterLib {

class AdapterFiltersQuery_i; // self forward Var
typedef ::Core::Var<AdapterFiltersQuery_i> AdapterFiltersQuery_i_var;
typedef ::Core::Var<const AdapterFiltersQuery_i> AdapterFiltersQuery_i_cvar;

class AdapterFiltersQuery_i_factory;

class AdapterFiltersQuery_i:
	virtual public AdapterFiltersQuery
	, virtual public FiltersQueryHelper
{
	SET_OBJECT_COUNTER (AdapterFiltersQuery_i)
	friend class AdapterFiltersQuery_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AdapterFiltersQuery_i (QueryType type);

	virtual ~AdapterFiltersQuery_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void check_saved_query ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from EntityBase
	// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
	// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
	// вернет исключение.
	virtual bool get_is_saved () const;

	// implemented method from EntityBase
	// Перезаписать сущность текущей сущностью.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/;

	// implemented method from Query
	virtual Query* clone ();

	// implemented method from Query
	virtual const GCI::IO::String* get_name () const;

	// implemented method from Query
	virtual void set_name (GCI::IO::String* name);
}; // class AdapterFiltersQuery_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_ADAPTERFILTERSQUERY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
