////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Rubricator_i::RubricatorNode_i
// Заголовк реализации фабрик интерфеса  для серванта RubricatorNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_RUBRICATORNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_RUBRICATORNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/Rubricator_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i.h"

/// Servant-factory implementation for RubricatorNode_i
namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class RubricatorNode_iServantFactory {
	friend class Tree< RubricatorNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static RubricatorNode_i* make () /*throw (CanNotFindData)*/;

	static RubricatorNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static RubricatorNode_i* make_servant ();

	static RubricatorNode_i* make_servant (FakeFacetForFactory* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for RubricatorNode_i
class RubricatorNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class RubricatorNode_iServantFactory;

public:
	RubricatorNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static RubricatorNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<RubricatorNode_i_factory> RubricatorNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::RubricatorNode_i> {
	typedef GblAdapterLib::RubricatorNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_RUBRICATOR_I_RUBRICATORNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

