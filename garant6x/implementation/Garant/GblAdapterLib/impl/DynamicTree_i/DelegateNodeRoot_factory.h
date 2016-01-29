////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeRoot
// Заголовк реализации фабрик интерфеса  для серванта DelegateNodeRoot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEROOT_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEROOT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.h"

/// Servant-factory implementation for DelegateNodeRoot
namespace GblAdapterLib {
	template <class NodeDelegateType_> class View; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ViewBase; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DelegateNodeRootServantFactory {
	template <class NodeDelegateType_> friend class View;
	friend class ViewBase;

	static DelegateNodeRoot* make () /*throw (CanNotFindData)*/;

	static DelegateNodeRoot* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static DelegateNodeRoot* make (TreeBase* owner_tree);
};

/// Interface-factory implementation for DelegateNodeRoot
class DelegateNodeRoot_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class DelegateNodeRootServantFactory;

public:
	DelegateNodeRoot_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DelegateNodeRoot_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<DelegateNodeRoot_factory> DelegateNodeRoot_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DelegateNodeRoot> {
	typedef GblAdapterLib::DelegateNodeRootServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEROOT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

