////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ContextFilter_i
// Заголовк реализации фабрик интерфеса ContextFilter для серванта ContextFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CONTEXTFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CONTEXTFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i.h"

/// Servant-factory implementation for ContextFilter_i
namespace GblAdapterLib {
	template <class NodeType_> class ListTree; //forward friend
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class TreeBase; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class ContextFilter_iServantFactory {
	template <class NodeType_> friend class ListTree;
	friend class TreeBase;

	static ContextFilter_i* make ();
};

/// Interface-factory implementation for ContextFilter_i
class ContextFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ContextFilterAbstractFactory {
	friend class ContextFilter_iServantFactory;

public:
	ContextFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static ContextFilter_i_factory* s_instance;

	const char* key () const;

	ContextFilter* make ();

};

typedef ::Core::Var<ContextFilter_i_factory> ContextFilter_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ContextFilter_i> {
	typedef GblAdapterLib::ContextFilter_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CONTEXTFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

