////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsTreeNode_i
// Заголовк реализации фабрик интерфеса  для серванта TipsTreeNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREENODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREENODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsTreeNode_i.h"

/// Servant-factory implementation for TipsTreeNode_i
namespace GblAdapterLib {
	class TipsTree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class TipsTreeNode_iServantFactory {
	friend class TipsTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static TipsTreeNode_i* make () /*throw (CanNotFindData)*/;

	static TipsTreeNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for TipsTreeNode_i
class TipsTreeNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class TipsTreeNode_iServantFactory;

public:
	TipsTreeNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static TipsTreeNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<TipsTreeNode_i_factory> TipsTreeNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::TipsTreeNode_i> {
	typedef GblAdapterLib::TipsTreeNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSTREENODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

