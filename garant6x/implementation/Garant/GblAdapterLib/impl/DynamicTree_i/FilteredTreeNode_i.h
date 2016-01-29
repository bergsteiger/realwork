////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FilteredTreeNode_i
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FILTEREDTREENODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FILTEREDTREENODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

//#UC START# *4DB15A950379_CUSTOM_INCLUDES*
namespace GblAdapterLib {
NodeBase* make_filtered_tree_and_root (const char* key);
}
//#UC END# *4DB15A950379_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class FilteredTreeNode_i; // self forward Var
typedef ::Core::Var<FilteredTreeNode_i> FilteredTreeNode_i_var;
typedef ::Core::Var<const FilteredTreeNode_i> FilteredTreeNode_i_cvar;

class FilteredTreeNode_i_factory;
class FilteredTreeNode_iServantFactory;

class FilteredTreeNode_i:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (FilteredTreeNode_i)
	friend class FilteredTreeNode_i_factory; // self factory
	friend class FilteredTreeNode_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<FilteredTreeNode_i>::PoolMemoryManagerSingleton PoolFilteredTreeNode_i;
	typedef ::Core::PoolMemoryManager<FilteredTreeNode_i> Pool;
	friend class ::Core::PoolMemoryManager<FilteredTreeNode_i>;
	void* operator new (size_t cs) {              
		return PoolFilteredTreeNode_i::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolFilteredTreeNode_i::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FilteredTreeNode_i (TreeBase* owner_tree, const GTree::Node& snode);

	virtual ~FilteredTreeNode_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Признак, что у ноды показываются не все дети
	bool m_has_filtered_children;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from NodeBase
	// признак того что нода соджержит отфильтрованных детей
	virtual bool has_filtered_children () const;


//#UC START# *4DB15A950379*
//#UC END# *4DB15A950379*
}; // class FilteredTreeNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FILTEREDTREENODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
