////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeRoot
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEROOT_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEROOT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ViewBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"

namespace GblAdapterLib {

class DelegateNodeRoot; // self forward Var
typedef ::Core::Var<DelegateNodeRoot> DelegateNodeRoot_var;
typedef ::Core::Var<const DelegateNodeRoot> DelegateNodeRoot_cvar;

class DelegateNodeRoot_factory;
class DelegateNodeRootServantFactory;

class DelegateNodeRoot:
	virtual public NodeDelegate
{
	SET_OBJECT_COUNTER (DelegateNodeRoot)
	friend class DelegateNodeRoot_factory; // self factory
	friend class DelegateNodeRootServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<DelegateNodeRoot>::PoolMemoryManagerSingleton PoolDelegateNodeRoot;
	typedef ::Core::PoolMemoryManager<DelegateNodeRoot> Pool;
	friend class ::Core::PoolMemoryManager<DelegateNodeRoot>;
	void* operator new (size_t cs) {              
		return PoolDelegateNodeRoot::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolDelegateNodeRoot::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit DelegateNodeRoot (TreeBase* owner_tree);

	virtual ~DelegateNodeRoot ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ViewBase_var m_owner_view;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from DefaultNodeBase
	virtual bool apply_change_delta (GTree::ChangeDelta& delta);

}; // class DelegateNodeRoot

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEROOT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
