////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsTreeNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREENODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREENODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class TipsTreeNode_i; // self forward Var
typedef ::Core::Var<TipsTreeNode_i> TipsTreeNode_i_var;
typedef ::Core::Var<const TipsTreeNode_i> TipsTreeNode_i_cvar;

class TipsTreeNode_i_factory;

class TipsTreeNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (TipsTreeNode_i)
	friend class TipsTreeNode_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<TipsTreeNode_i>::PoolMemoryManagerSingleton PoolTipsTreeNode_i;
	typedef ::Core::PoolMemoryManager<TipsTreeNode_i> Pool;
	friend class ::Core::PoolMemoryManager<TipsTreeNode_i>;
	void* operator new (size_t cs) {              
		return PoolTipsTreeNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolTipsTreeNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TipsTreeNode_i ();

	TipsTreeNode_i (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	virtual ~TipsTreeNode_i ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/;

	virtual void set_entity (EntityBase* entity);

}; // class TipsTreeNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREENODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
