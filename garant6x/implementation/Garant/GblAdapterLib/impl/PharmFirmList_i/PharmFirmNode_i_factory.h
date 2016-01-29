////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmNode_i
// Заголовк реализации фабрик интерфеса  для серванта PharmFirmNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmList_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i.h"

/// Servant-factory implementation for PharmFirmNode_i
namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class PharmFirmNode_iServantFactory {
	friend class Tree< PharmFirmNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static PharmFirmNode_i* make () /*throw (CanNotFindData)*/;

	static PharmFirmNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static PharmFirmNode_i* make_servant (TreeBase* owner_tree, const GTree::Node& snode);

	static PharmFirmNode_i* make_servant ();
};

/// Interface-factory implementation for PharmFirmNode_i
class PharmFirmNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class PharmFirmNode_iServantFactory;

public:
	PharmFirmNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static PharmFirmNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<PharmFirmNode_i_factory> PharmFirmNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::PharmFirmNode_i> {
	typedef GblAdapterLib::PharmFirmNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

