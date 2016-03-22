////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/ViewAsParts_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::ViewAsParts_i
// Заголовок реализации класса серванта для интерфеса IRequestView
//
// Представление запроса в виде фразальных частей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/MorphoBase/Synonymizer.h"

namespace ContextSearch {
namespace Manage_i {

class ViewAsParts_i; // self forward Var
typedef ::Core::Var<ViewAsParts_i> ViewAsParts_i_var;
typedef ::Core::Var<const ViewAsParts_i> ViewAsParts_i_cvar;

class ViewAsParts_i_factory;

// Представление запроса в виде фразальных частей
class ViewAsParts_i:
	virtual public Search::IRequestView
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ViewAsParts_i)
	friend class ViewAsParts_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Список фраз
	typedef std::vector < Search::PhraseEx > PhraseList;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// добавить фразу
	static void add_phrase (const GCL::StrVector& in, PhraseList& out);

	// добавить фразу
	static void add_phrase (const GCL::StrVector& in, Search::PhraseEx& out);

	// строгая фраза
	static bool is_strong (const std::string& str);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	ViewAsParts_i (DBComm::IDBCommunicator* comm, Morpho::Def::INormalizer* normalizer);

	~ViewAsParts_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// добавить
	void add (const Search::StringSet& in);

	// сжатие фразы
	bool deflate (GCL::StrVector& out);

	// создать контейнер спанов
	bool make_spans (const GCL::StrVector& in);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator* m_communicator;

	Search::Phrases m_spans;

	Core::Box<Synonymizer> m_synonymizer;

	bool m_was_compression;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Search::IRequestView
	// создать
	bool build (const Search::Phrase& in, const std::string& src);

	// implemented method from Search::IRequestView
	// список синонимичных
	const Search::SplitRequests& get_sequence () const;

	// implemented method from Search::IRequestView
	// спаны
	const Search::Phrases& get_spans () const;

	// implemented method from Search::IRequestView
	// тип
	Search::AlgorithmSelector get_type () const;
}; // class ViewAsParts_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_VIEWASPARTS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
