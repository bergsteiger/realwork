////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::AnalysisNode_i
// Заголовк реализации фабрик интерфеса  для серванта AnalysisNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_ANALYSISNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_ANALYSISNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i.h"

/// Servant-factory implementation for AnalysisNode_i
namespace GblAdapterLib {
	class ListAnalysisTree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class AnalysisNode_iServantFactory {
	friend class ListAnalysisTree;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;


	static AnalysisNode_i* make () /*throw (CanNotFindData)*/;

	static AnalysisNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static AnalysisNode_i* make (TreeBase* owner_tree, const GTree::Node& node);
};

/// Interface-factory implementation for AnalysisNode_i
class AnalysisNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NodeBaseAbstractFactory {
	friend class AnalysisNode_iServantFactory;

public:
	AnalysisNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static AnalysisNode_i_factory* s_instance;

	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<AnalysisNode_i_factory> AnalysisNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::AnalysisNode_i> {
	typedef GblAdapterLib::AnalysisNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_ANALYSISNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

