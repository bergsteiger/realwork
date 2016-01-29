////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FilteredTreeNode_i
// Заголовк реализации фабрик интерфеса  для серванта FilteredTreeNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FILTEREDTREENODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FILTEREDTREENODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

/// Servant-factory implementation for FilteredTreeNode_i
namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class FilteredTreeNode_iServantFactory {
	friend class Tree< FilteredTreeNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static FilteredTreeNode_i* make () /*throw (CanNotFindData)*/;

	static FilteredTreeNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static FilteredTreeNode_i* make (TreeBase* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for FilteredTreeNode_i
class FilteredTreeNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class FilteredTreeNode_iServantFactory;

public:
	FilteredTreeNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static FilteredTreeNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<FilteredTreeNode_i_factory> FilteredTreeNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::FilteredTreeNode_i> {
	typedef GblAdapterLib::FilteredTreeNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FILTEREDTREENODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

