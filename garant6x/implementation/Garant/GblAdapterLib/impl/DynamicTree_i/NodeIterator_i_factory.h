////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeIterator_i
// Заголовк реализации фабрик интерфеса NodeIterator для серванта NodeIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEITERATOR_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEITERATOR_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.h"

/// Servant-factory implementation for NodeIterator_i
namespace GblAdapterLib {
	class NodeBase_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeDelegate; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class NodeIterator_iServantFactory {
	friend class NodeBase_i;
	friend class NodeDelegate;

	static NodeIterator_i* make ();

	static NodeIterator_i* make (DefaultNodeBase* from_node, FlagMask with_flag);
};

/// Interface-factory implementation for NodeIterator_i
class NodeIterator_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeIteratorAbstractFactory {
	friend class NodeIterator_iServantFactory;

public:
	NodeIterator_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static NodeIterator_i_factory* s_instance;

	const char* key () const;

	NodeIterator* make ();

};

typedef ::Core::Var<NodeIterator_i_factory> NodeIterator_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::NodeIterator_i> {
	typedef GblAdapterLib::NodeIterator_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEITERATOR_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

