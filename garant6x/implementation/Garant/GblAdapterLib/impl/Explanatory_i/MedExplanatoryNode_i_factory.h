////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::MedExplanatoryNode_i
// Заголовк реализации фабрик интерфеса  для серванта MedExplanatoryNode_i
//
// Узел для словарной статьи мед. термина
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_MEDEXPLANATORYNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_MEDEXPLANATORYNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/Explanatory_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i.h"

/// Servant-factory implementation for MedExplanatoryNode_i
namespace GblAdapterLib {
	
} // namespace GblAdapterLib


namespace GblAdapterLib {

class MedExplanatoryNode_iServantFactory {
	friend class Tree< MedExplanatoryNode_i, NodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static MedExplanatoryNode_i* make () /*throw (CanNotFindData)*/;

	static MedExplanatoryNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static MedExplanatoryNode_i* make_servant (TreeBase* owner_tree, const GTree::Node& snode);

	static MedExplanatoryNode_i* make_servant ();
};

/// Interface-factory implementation for MedExplanatoryNode_i
class MedExplanatoryNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class MedExplanatoryNode_iServantFactory;

public:
	MedExplanatoryNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static MedExplanatoryNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<MedExplanatoryNode_i_factory> MedExplanatoryNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::MedExplanatoryNode_i> {
	typedef GblAdapterLib::MedExplanatoryNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_EXPLANATORY_I_MEDEXPLANATORYNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

