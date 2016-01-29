////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodesClipboard_i
// Заголовк реализации фабрик интерфеса NodesClipboard для серванта NodesClipboard_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESCLIPBOARD_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESCLIPBOARD_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i.h"

/// Servant-factory implementation for NodesClipboard_i
namespace GblAdapterLib {
	class DynList_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class NodeBase_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class NodesClipboard_iServantFactory {
	friend class DynList_i;
	template <class NodeType_> friend class ListCatalogBase_i;

	friend class NodeBase_i;

	static NodesClipboard_i* make ();

	static NodesClipboard_i* make (GTree::NodeHolder* node_holder);
};

/// Interface-factory implementation for NodesClipboard_i
class NodesClipboard_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public NodesClipboardAbstractFactory
{
	friend class NodesClipboard_iServantFactory;

public:
	NodesClipboard_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static NodesClipboard_i_factory* s_instance;

	const char* key () const;

	NodesClipboard* make ();

	NodesClipboard* make (GTree::NodeHolder* node_holder);

};

typedef ::Core::Var<NodesClipboard_i_factory> NodesClipboard_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::NodesClipboard_i> {
	typedef GblAdapterLib::NodesClipboard_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODESCLIPBOARD_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

