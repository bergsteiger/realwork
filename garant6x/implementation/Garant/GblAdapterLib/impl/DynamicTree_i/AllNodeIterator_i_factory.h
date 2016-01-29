////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::AllNodeIterator_i
// Заголовк реализации фабрик интерфеса NodeIterator для серванта AllNodeIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ALLNODEITERATOR_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ALLNODEITERATOR_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i.h"

/// Servant-factory implementation for AllNodeIterator_i
namespace GblAdapterLib {
	class NodeBase_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeDelegate; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class AllNodeIterator_iServantFactory {
	friend class NodeBase_i;
	friend class NodeDelegate;

	static AllNodeIterator_i* make ();

	static AllNodeIterator_i* make (DefaultNodeBase* from_node, FlagMask with_flag);
};

/// Interface-factory implementation for AllNodeIterator_i
class AllNodeIterator_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeIteratorAbstractFactory {
	friend class AllNodeIterator_iServantFactory;

public:
	AllNodeIterator_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static AllNodeIterator_i_factory* s_instance;

	const char* key () const;

	NodeIterator* make ();

};

typedef ::Core::Var<AllNodeIterator_i_factory> AllNodeIterator_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::AllNodeIterator_i> {
	typedef GblAdapterLib::AllNodeIterator_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ALLNODEITERATOR_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

