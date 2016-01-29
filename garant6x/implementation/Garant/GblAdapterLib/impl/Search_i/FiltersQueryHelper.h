////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FiltersQueryHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FiltersQueryHelper
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERYHELPER_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERYHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryHelper.h"

namespace GblAdapterLib {

class FiltersQueryHelper; // self forward Var
typedef ::Core::Var<FiltersQueryHelper> FiltersQueryHelper_var;
typedef ::Core::Var<const FiltersQueryHelper> FiltersQueryHelper_cvar;

class FiltersQueryHelper:
	virtual public QueryHelper
{
	SET_OBJECT_COUNTER (FiltersQueryHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FiltersQueryHelper (QueryType type);

	virtual ~FiltersQueryHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from EntityBase
	// Сохраняет в базе  измененное состояние объекта.
	// Объеденяя с с ранее сохраненными данными
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/;

	// implemented method from EntityBase
	// идентификатор
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/;

	// implemented method from EntityBase
	// свойство изменённости
	virtual bool get_is_changed () const;

	// implemented method from Query
	virtual const QueryAttributeList& get_attributes () const;

	// implemented method from Query
	// Количество найденных документов при последнем поиске.
	virtual unsigned long get_count () const;

	// implemented method from Query
	virtual const Date& get_date () const;

	// implemented method from Query
	virtual void execute (
		DynList* filtrate_list
		, SearchProgressIndicator::ProgressIndicatorForSearch* progress
		, SearchProgressIndicator::CancelSearch*& cancel_process
	);

	// implemented method from Query
	virtual GCI::IO::String* get_comment () const;

	// implemented method from Query
	// получен ли запрос с фильтра
	virtual bool is_filter_query () const;

	// implemented method from Query
	// Отправить запрос на консультацию
	virtual void send_query ();

	// implemented method from Query
	virtual void set_comment (GCI::IO::String* comment);

	// implemented method from Query
	virtual QueryType get_type () const;
}; // class FiltersQueryHelper

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_FILTERSQUERYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
