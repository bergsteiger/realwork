////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PrefixTree_i::PrefixNode_i
// Заголовк реализации фабрик интерфеса  для серванта PrefixNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PREFIXTREE_I_PREFIXNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PREFIXTREE_I_PREFIXNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i.h"

/// Servant-factory implementation for PrefixNode_i
namespace GblAdapterLib {
	class PrefixTree; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class PrefixNode_iServantFactory {
	friend class PrefixTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;

	friend class Tree< PrefixNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static PrefixNode_i* make () /*throw (CanNotFindData)*/;

	static PrefixNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static PrefixNode_i* make_servant (TreeBase* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for PrefixNode_i
class PrefixNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class PrefixNode_iServantFactory;

public:
	PrefixNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static PrefixNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<PrefixNode_i_factory> PrefixNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::PrefixNode_i> {
	typedef GblAdapterLib::PrefixNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_PREFIXTREE_I_PREFIXNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

