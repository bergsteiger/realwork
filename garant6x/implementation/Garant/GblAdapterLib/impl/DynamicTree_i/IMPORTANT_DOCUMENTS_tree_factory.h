////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/IMPORTANT_DOCUMENTS_tree_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::IMPORTANT_DOCUMENTS_tree
// Заголовк реализации фабрик интерфеса  для серванта IMPORTANT_DOCUMENTS_tree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_IMPORTANT_DOCUMENTS_TREE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_IMPORTANT_DOCUMENTS_TREE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for IMPORTANT_DOCUMENTS_tree
class IMPORTANT_DOCUMENTS_tree_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public NodeBaseAbstractFactory
{
public:
	IMPORTANT_DOCUMENTS_tree_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	NodeBase* make () /*throw (CanNotFindData)*/;

	NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode);

};

typedef ::Core::Var<IMPORTANT_DOCUMENTS_tree_factory> IMPORTANT_DOCUMENTS_tree_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_IMPORTANT_DOCUMENTS_TREE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

