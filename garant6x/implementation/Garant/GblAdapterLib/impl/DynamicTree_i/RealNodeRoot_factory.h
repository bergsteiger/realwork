////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeRoot
// Заголовк реализации фабрик интерфеса  для серванта RealNodeRoot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEROOT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEROOT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.h"

/// Servant-factory implementation for RealNodeRoot
namespace GblAdapterLib {
	template <class NodeType_, class NodeDelegateType_> class Tree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class RealNodeRootServantFactory {
	template <class NodeType_, class NodeDelegateType_> friend class Tree;

	static RealNodeRoot* make () /*throw (CanNotFindData)*/;

	static RealNodeRoot* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for RealNodeRoot
class RealNodeRoot_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class RealNodeRootServantFactory;

public:
	RealNodeRoot_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static RealNodeRoot_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<RealNodeRoot_factory> RealNodeRoot_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::RealNodeRoot> {
	typedef GblAdapterLib::RealNodeRootServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEROOT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

