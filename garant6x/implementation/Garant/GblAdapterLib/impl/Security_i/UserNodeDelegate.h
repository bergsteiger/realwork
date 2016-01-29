////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNodeDelegate
// Заголовок реализации класса серванта для интерфеса ProfileNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODEDELEGATE_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODEDELEGATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"

namespace GblAdapterLib {

class UserNodeDelegate; // self forward Var
typedef ::Core::Var<UserNodeDelegate> UserNodeDelegate_var;
typedef ::Core::Var<const UserNodeDelegate> UserNodeDelegate_cvar;

class UserNodeDelegate_factory;
class UserNodeDelegateServantFactory;

class UserNodeDelegate:
	virtual public ProfileNode
	, virtual public NodeDelegate
{
	SET_OBJECT_COUNTER (UserNodeDelegate)
	friend class UserNodeDelegate_factory; // self factory
	friend class UserNodeDelegateServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<UserNodeDelegate>::PoolMemoryManagerSingleton PoolUserNodeDelegate;
	typedef ::Core::PoolMemoryManager<UserNodeDelegate> Pool;
	friend class ::Core::PoolMemoryManager<UserNodeDelegate>;
	void* operator new (size_t cs) {              
		return PoolUserNodeDelegate::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolUserNodeDelegate::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit UserNodeDelegate (TreeBase* owner_tree);

	virtual ~UserNodeDelegate ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ProfileNode
	virtual Uid get_uid () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	// возвращает ноду по видемому индексу относительно текущей
	virtual NodeBase* get_by_visible_index (VisibleIndex ind);

}; // class UserNodeDelegate

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERNODEDELEGATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
