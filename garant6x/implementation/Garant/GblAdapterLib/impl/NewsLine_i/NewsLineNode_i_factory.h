////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::NewsLine_i::NewsLineNode_i
// Заголовк реализации фабрик интерфеса  для серванта NewsLineNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NEWSLINE_I_NEWSLINENODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_NEWSLINE_I_NEWSLINENODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLine_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i.h"

/// Servant-factory implementation for NewsLineNode_i
namespace GblAdapterLib {
	class MonitoringManager_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class NewsLineNode_iServantFactory {
	friend class MonitoringManager_i;
	friend class Tree< NewsLineNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static NewsLineNode_i* make () /*throw (CanNotFindData)*/;

	static NewsLineNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static NewsLineNode_i* make_servant (TreeBase* owner_tree, const GTree::Node& snode);

	static NewsLineNode_i* make_servant ();
};

/// Interface-factory implementation for NewsLineNode_i
class NewsLineNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class NewsLineNode_iServantFactory;

public:
	NewsLineNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static NewsLineNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<NewsLineNode_i_factory> NewsLineNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::NewsLineNode_i> {
	typedef GblAdapterLib::NewsLineNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_NEWSLINE_I_NEWSLINENODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

