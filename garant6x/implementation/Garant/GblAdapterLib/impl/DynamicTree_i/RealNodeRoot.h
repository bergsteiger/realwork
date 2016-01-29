////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeRoot
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEROOT_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEROOT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class RealNodeRoot; // self forward Var
typedef ::Core::Var<RealNodeRoot> RealNodeRoot_var;
typedef ::Core::Var<const RealNodeRoot> RealNodeRoot_cvar;

class RealNodeRoot_factory;

class RealNodeRoot:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (RealNodeRoot)
	friend class RealNodeRoot_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<RealNodeRoot>::PoolMemoryManagerSingleton PoolRealNodeRoot;
	typedef ::Core::PoolMemoryManager<RealNodeRoot> Pool;
	friend class ::Core::PoolMemoryManager<RealNodeRoot>;
	void* operator new (size_t cs) {              
		return PoolRealNodeRoot::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolRealNodeRoot::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RealNodeRoot ();

	RealNodeRoot (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	virtual ~RealNodeRoot ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void safety_tree_remove ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	TreeBase_var m_owner_tree_var;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual const TreeBase* get_owner_tree_var () const;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from DefaultNodeBase
	virtual void add_notifier (NodeNotifier* notifier);

}; // class RealNodeRoot

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEROOT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
