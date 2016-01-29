////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/SearchEntity_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::SearchEntity_i
// Заголовок реализации класса серванта для интерфеса SearchEntity
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_SEARCHENTITY_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_SEARCHENTITY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

//#UC START# *456EE2440148_CUSTOM_INCLUDES*
//#UC END# *456EE2440148_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class SearchEntity_i; // self forward Var
typedef ::Core::Var<SearchEntity_i> SearchEntity_i_var;
typedef ::Core::Var<const SearchEntity_i> SearchEntity_i_cvar;

class SearchEntity_i_factory;

class SearchEntity_i:
	virtual public SearchEntity
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SearchEntity_i)
	friend class SearchEntity_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SearchEntity_i (SearchResultType result_type, size_t document_count, size_t entry_count, size_t edition_count);

	virtual ~SearchEntity_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	size_t m_document_count;

	// Количество редакций
	size_t m_edition_count;

	size_t m_entry_count;

	SearchResultType m_result_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from SearchEntity
	// Количество найденных документов
	virtual size_t get_document_count () const;

	// implemented method from SearchEntity
	// количество редакций
	virtual size_t get_edition_count () const;

	// implemented method from SearchEntity
	// Количество вхождений
	virtual size_t get_entry_count () const;

	// implemented method from SearchEntity
	// Тип результата поиска (список, автореферат, консультация)
	virtual SearchResultType get_result_type () const;

//#UC START# *456EE2440148*
//#UC END# *456EE2440148*
}; // class SearchEntity_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_SEARCHENTITY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
