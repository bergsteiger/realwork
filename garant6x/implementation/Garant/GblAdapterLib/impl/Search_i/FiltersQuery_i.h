////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQuery_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FiltersQuery_i
// Заголовок реализации класса серванта для интерфеса FiltersQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERY_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQueryHelper.h"

namespace GblAdapterLib {

class FiltersQuery_i; // self forward Var
typedef ::Core::Var<FiltersQuery_i> FiltersQuery_i_var;
typedef ::Core::Var<const FiltersQuery_i> FiltersQuery_i_cvar;

class FiltersQuery_i_factory;

class FiltersQuery_i:
	virtual public FiltersQuery
	, virtual public FiltersQueryHelper
{
	SET_OBJECT_COUNTER (FiltersQuery_i)
	friend class FiltersQuery_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FiltersQuery_i (FilterFromQuery* filter);

	virtual ~FiltersQuery_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void check_saved_query ();

	virtual void parse_server_query ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	FilterFromQuery_var m_filter;

	bool m_need_load;

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
}; // class FiltersQuery_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
