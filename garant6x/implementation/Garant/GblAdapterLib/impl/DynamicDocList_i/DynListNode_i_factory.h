////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNode_i
// Заголовк реализации фабрик интерфеса DynListNode для серванта DynListNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODE_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"

/// Servant-factory implementation for DynListNode_i
namespace GblAdapterLib {
	
} // namespace GblAdapterLib

namespace GblAdapterLib {
	template <class NodeType_> class ListCatalogBase_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ListEntryInfo_i; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	template <class NodeType_> class ListTree; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DynListNode_iServantFactory {
	friend class Tree< DynListNode_i, DynListNodeDelegate >;
	template <class NodeType_, class NodeDelegateType_> friend class Tree;

	template <class NodeType_> friend class ListCatalogBase_i;
	friend class ListEntryInfo_i;
	template <class NodeType_> friend class ListTree;

	static DynListNode_i* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static DynListNode_i* make_servant ();

	static DynListNode_i* make_servant2 (TreeBase* owner_tree, const GTree::Node& snode);
};

/// Interface-factory implementation for DynListNode_i
class DynListNode_i_factory: virtual public ::Core::RefCountObjectBase, virtual public DynListNodeAbstractFactory {
	friend class DynListNode_iServantFactory;

public:
	DynListNode_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DynListNode_i_factory* s_instance;

	const char* key () const;

	DynListNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<DynListNode_i_factory> DynListNode_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DynListNode_i> {
	typedef GblAdapterLib::DynListNode_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

