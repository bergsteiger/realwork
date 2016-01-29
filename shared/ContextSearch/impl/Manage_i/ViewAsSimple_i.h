////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsSimple_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsSimple_i
// Заголовок реализации класса серванта для интерфеса IRequestView
//
// Простое представление (без синонимов)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSIMPLE_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSIMPLE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"

namespace ContextSearch {
namespace Manage_i {

class ViewAsSimple_i; // self forward Var
typedef ::Core::Var<ViewAsSimple_i> ViewAsSimple_i_var;
typedef ::Core::Var<const ViewAsSimple_i> ViewAsSimple_i_cvar;

class ViewAsSimple_i_factory;

// Простое представление (без синонимов)
class ViewAsSimple_i:
	virtual public Search::IRequestView
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ViewAsSimple_i)
	friend class ViewAsSimple_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	ViewAsSimple_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

	~ViewAsSimple_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// добавить запрос
	void add_request (const std::string& req);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Search::SplitRequests m_sequence;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Search::IRequestView
	// создать
	bool build (const Search::Phrase& in, const Morpho::Def::StrStrMap& pseudo, const std::string& src);

	// implemented method from Search::IRequestView
	// список синонимичных
	const Search::SplitRequests& get_sequence () const;

	// implemented method from Search::IRequestView
	// спаны
	const Search::Phrases& get_spans () const;

	// implemented method from Search::IRequestView
	// тип
	Search::AlgorithmSelector get_type () const;
}; // class ViewAsSimple_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASSIMPLE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
