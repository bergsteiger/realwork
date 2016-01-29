////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PrefixTree_i::PrefixNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PREFIXTREE_I_PREFIXNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_PREFIXTREE_I_PREFIXNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

namespace GblAdapterLib {

class PrefixNode_i; // self forward Var
typedef ::Core::Var<PrefixNode_i> PrefixNode_i_var;
typedef ::Core::Var<const PrefixNode_i> PrefixNode_i_cvar;

class PrefixNode_i_factory;
class PrefixNode_iServantFactory;

class PrefixNode_i:
	virtual public FilteredTreeNode_i
{
	SET_OBJECT_COUNTER (PrefixNode_i)
	friend class PrefixNode_i_factory; // self factory
	friend class PrefixNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<PrefixNode_i>::PoolMemoryManagerSingleton PoolPrefixNode_i;
	typedef ::Core::PoolMemoryManager<PrefixNode_i> Pool;
	friend class ::Core::PoolMemoryManager<PrefixNode_i>;
	void* operator new (size_t cs) {              
		return PoolPrefixNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolPrefixNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PrefixNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	virtual ~PrefixNode_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodeType m_mask;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
	// для диффиренцации отображения
	virtual NodeType get_type () const;

	virtual void set_type (NodeType type)
		/*throw (ConstantModify)*/;

}; // class PrefixNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PREFIXTREE_I_PREFIXNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
