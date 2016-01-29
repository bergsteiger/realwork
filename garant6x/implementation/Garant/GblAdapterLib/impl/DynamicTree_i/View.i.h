////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/View.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::View
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot_factory.h"

//#UC START# *45F6583E001F_CUSTOM_INCLUDES*
//#UC END# *45F6583E001F_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F6583E001F*
//#UC END# *45F6583E001F*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

template <class NodeDelegateType_>
View<NodeDelegateType_>::View ()
//#UC START# *45F65B2F01B5_BASE_INIT*
//#UC END# *45F65B2F01B5_BASE_INIT**cpp*
{
	//#UC START# *45F65B2F01B5_BODY*
	//LOG_D (("View::View() %X", this));
	//#UC END# *45F65B2F01B5_BODY**cpp*
}

template <class NodeDelegateType_>
View<NodeDelegateType_>::~View () {
	//#UC START# *45F6583E001F_DESTR_BODY*
	//LOG_D (("View::~View() %X", this));
	//#UC END# *45F6583E001F_DESTR_BODY**cpp*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TreeBase
template <class NodeDelegateType_>
DefaultNodeBase* View<NodeDelegateType_>::alloc_new_node (const GTree::Node& snode) {
	//#UC START# *460127AC0157_45F6583E001F*
	//LOG_D (("View[%d]::alloc_new_node (%d, %s)", (ViewBase*)this, snode.pointer, (const char*)snode.name));
	if (snode.pointer != 0 /*GTree::ROOT_POINT*/ ) {
		return Core::TypeTraits<NodeDelegateType_>::Factory::make (this);
	} else {
		return Core::TypeTraits<DelegateNodeRoot>::Factory::make (this);
	}
	//#UC END# *460127AC0157_45F6583E001F**cpp*
}

// implemented method from TreeBase
template <class NodeDelegateType_>
ViewBase* View<NodeDelegateType_>::alloc_new_view () {
	//#UC START# *460127E400EA_45F6583E001F*
	return new View<NodeDelegateType_>;
	//#UC END# *460127E400EA_45F6583E001F**cpp*
}

// implemented method from TreeBase
template <class NodeDelegateType_>
RealNodeBase* View<NodeDelegateType_>::apply_created_node (const GTree::CreateData& data) {
	//#UC START# *460125E60203_45F6583E001F*
	GDS_ASSERT (0);
	return 0;
	//#UC END# *460125E60203_45F6583E001F**cpp*
}

// implemented method from TreeBase
template <class NodeDelegateType_>
GTree::NewNodeUID View<NodeDelegateType_>::associate_node_with_uid (RealNodeBase* node) {
	//#UC START# *46012657032C_45F6583E001F*
	GDS_ASSERT (0);
	return 0;
	//#UC END# *46012657032C_45F6583E001F**cpp*
}

// implemented method from TreeBase
template <class NodeDelegateType_>
void View<NodeDelegateType_>::disassociate_node_with_uid (RealNodeBase* node) {
	//#UC START# *4601267E0177_45F6583E001F*
	GDS_ASSERT (0);
	//#UC END# *4601267E0177_45F6583E001F**cpp*
}

// implemented method from TreeBase
template <class NodeDelegateType_>
GTree::NewNodeUID View<NodeDelegateType_>::find_created_uid (RealNodeBase* node) {
	//#UC START# *46012631034B_45F6583E001F*
	GDS_ASSERT (0);
	return 0;
	//#UC END# *46012631034B_45F6583E001F**cpp*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

