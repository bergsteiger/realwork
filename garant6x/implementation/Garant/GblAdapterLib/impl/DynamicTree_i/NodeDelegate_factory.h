////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeDelegate
// Заголовк реализации фабрик интерфеса NodeBase для серванта NodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"

/// Servant-factory implementation for NodeDelegate
namespace GblAdapterLib {
	template <class NodeDelegateType_> class View; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class NodeDelegateServantFactory {
	template <class NodeDelegateType_> friend class View;

	static NodeDelegate* make (TreeBase* owner_tree);
};


} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::NodeDelegate> {
	typedef GblAdapterLib::NodeDelegateServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

