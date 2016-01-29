////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::SearchImpl
// Заголовок реализации класса серванта для интерфеса Search
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_SEARCHIMPL_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_SEARCHIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

class SearchImpl; // self forward Var
typedef ::Core::Var<SearchImpl> SearchImpl_var;
typedef ::Core::Var<const SearchImpl> SearchImpl_cvar;

class SearchImpl_factory;

class SearchImpl:
	virtual public Search
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (SearchImpl)
	friend class SearchImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SearchImpl ();

	virtual ~SearchImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// количество примеров
	mutable unsigned long m_example_text_count;

	mutable boost::tribool m_is_morpho_exist;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from Search
	// Возвращает список слов, которые не смогли скорректировать и скорректированную строку
	virtual ContextWordList* correct_context (
		const ContextWordList& context_for_check
		, bool for_inpharm
		, ContextWordList*& corrected_context
	) const;

	// implemented method from Search
	// Создать новый поисковый запрос. В созданном поисковом запросе по умолчанию создаеться корневой
	// QueryOperationNode с опреацией LO_AND.
	virtual Query* create_query (QueryType type) const;

	// implemented method from Search
	virtual AttributeInfo* get_attribute_info (AttributeTag_const tag) const;

	// implemented method from Search
	// Список документов без команды CLASS
	virtual DynList* get_documents_without_class () const;

	// implemented method from Search
	// Cписок документов с командой vanonced и без команды vincluded
	virtual DynList* get_documents_without_included () const;

	// implemented method from Search
	// Cписок документов без команды key
	virtual DynList* get_documents_without_key () const;

	// implemented method from Search
	// получить текст примера по заданной позиции pos
	virtual GCI::IO::String* get_example_text (unsigned long pos) const /*throw (CanNotFindData)*/;

	// implemented method from Search
	// Получить количество примеров
	virtual unsigned long get_example_text_count () const;

	// implemented method from Search
	virtual bool get_is_morpho_exist () const;
}; // class SearchImpl

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_SEARCHIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
