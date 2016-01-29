////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/impl/Manage_i/SynManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Manage_i::SynManager_i
// Заголовок реализации класса серванта для интерфеса ISynManager
//
// Реализация интерфейса ISynManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_I_SYNMANAGER_I_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_I_SYNMANAGER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "shared/Morpho/Def/Def.h"

namespace ContextSearch {
namespace Manage_i {

class SynManager_i; // self forward Var
typedef ::Core::Var<SynManager_i> SynManager_i_var;
typedef ::Core::Var<const SynManager_i> SynManager_i_cvar;

class SynManager_i_factory;

// Реализация интерфейса ISynManager
class SynManager_i:
	virtual public Manage::ISynManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SynManager_i)
	friend class SynManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SynManager_i (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm);

	virtual ~SynManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// создать представление запроса
	Search::IRequestView* make_view (Search::AlgorithmSelector selector);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator* m_communicator;

	Morpho::Def::INormalizer_var m_normalizer;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Manage::ISynManager
	// синонимизация
	virtual Search::IRequestView* execute (const std::string& in, bool is_default);
}; // class SynManager_i

} // namespace Manage_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MANAGE_I_SYNMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
