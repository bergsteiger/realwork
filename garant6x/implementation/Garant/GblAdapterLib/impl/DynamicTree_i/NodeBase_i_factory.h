////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeBase_i
// Заголовк реализации фабрик интерфеса NodeBase для серванта NodeBase_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEBASE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEBASE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

/// Servant-factory implementation for NodeBase_i
namespace GblAdapterLib {
	class NodeDelegate; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	template <class NodeType_, class NodeDelegateType_> class Tree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class NodeBase_iServantFactory {
	friend class NodeDelegate;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;

	static NodeBase_i* make () /*throw (CanNotFindData)*/;

	static NodeBase_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static NodeBase_i* make_servant (TreeBase* owner_tree, const GTree::Node& snode);

	static NodeBase_i* make_servant ();
};

/// Interface-factory implementation for NodeBase_i
class NodeBase_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class NodeBase_iServantFactory;

public:
	NodeBase_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static NodeBase_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<NodeBase_i_factory> NodeBase_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::NodeBase_i> {
	typedef GblAdapterLib::NodeBase_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEBASE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

