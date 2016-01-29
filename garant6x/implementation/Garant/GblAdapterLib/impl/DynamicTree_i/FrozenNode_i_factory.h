////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FrozenNode_i
// Заголовк реализации фабрик интерфеса NodeBase для серванта FrozenNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FROZENNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FROZENNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i.h"

/// Servant-factory implementation for FrozenNode_i
namespace GblAdapterLib {
	class DefaultNodeBase; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeBase_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeDelegate; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class FrozenNode_iServantFactory {
	friend class DefaultNodeBase;
	friend class NodeBase_i;
	friend class NodeDelegate;

	static FrozenNode_i* make () /*throw (CanNotFindData)*/;

	static FrozenNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static FrozenNode_i* make (const DefaultNodeBase* node_to_froze);
};

/// Interface-factory implementation for FrozenNode_i
class FrozenNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class FrozenNode_iServantFactory;

public:
	FrozenNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static FrozenNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<FrozenNode_i_factory> FrozenNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::FrozenNode_i> {
	typedef GblAdapterLib::FrozenNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FROZENNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

