////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTree_factory.h"
// C++ Interface Factories header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListTree
// Заголовк реализации фабрик интерфеса  для серванта ListTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynamicDocList_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTree.h"

namespace GblAdapterLib {

/// Servant-factory implementation for ListTree
class ListTreeServantFactory {
	friend class ListCatalogBase_i;

	static ListTree<NodeType_>* make (bool active_changeable);

};


} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTTREE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

