////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::ExplanatoryNode_i
// Заголовк реализации фабрик интерфеса  для серванта ExplanatoryNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_EXPLANATORYNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_EXPLANATORYNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/Explanatory_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i.h"

/// Servant-factory implementation for ExplanatoryNode_i
namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ExplanatoryNode_iServantFactory {
	friend class Tree< ExplanatoryNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static ExplanatoryNode_i* make () /*throw (CanNotFindData)*/;

	static ExplanatoryNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static ExplanatoryNode_i* make_servant (TreeBase* owner_tree, const GTree::Node& snode);

	static ExplanatoryNode_i* make_servant ();
};

/// Interface-factory implementation for ExplanatoryNode_i
class ExplanatoryNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class ExplanatoryNode_iServantFactory;

public:
	ExplanatoryNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static ExplanatoryNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<ExplanatoryNode_i_factory> ExplanatoryNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ExplanatoryNode_i> {
	typedef GblAdapterLib::ExplanatoryNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_EXPLANATORYNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

