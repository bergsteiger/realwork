////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNodeDelegate
// Заголовк реализации фабрик интерфеса DynListNode для серванта DynListNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODEDELEGATE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODEDELEGATE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"

/// Servant-factory implementation for DynListNodeDelegate
namespace GblAdapterLib {
	template <class NodeType_> class ListTree; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ListTreeView; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DynListNodeDelegateServantFactory {
	template <class NodeType_> friend class ListTree;
	friend class ListTreeView;
	template <class NodeDelegateType_> friend class View;


	static DynListNodeDelegate* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

	static DynListNodeDelegate* make (TreeBase* owner_tree);
};

/// Interface-factory implementation for DynListNodeDelegate
class DynListNodeDelegate_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public DynListNodeAbstractFactory
{
	friend class DynListNodeDelegateServantFactory;

public:
	DynListNodeDelegate_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static DynListNodeDelegate_factory* s_instance;

	const char* key () const;

	DynListNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<DynListNodeDelegate_factory> DynListNodeDelegate_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::DynListNodeDelegate> {
	typedef GblAdapterLib::DynListNodeDelegateServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DYNLISTNODEDELEGATE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

