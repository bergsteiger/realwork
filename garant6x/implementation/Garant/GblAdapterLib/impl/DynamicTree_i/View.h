////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/View.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::View
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VIEW_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VIEW_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ViewBase.h"

//#UC START# *45F6583E001F_CUSTOM_INCLUDES*
//#UC END# *45F6583E001F_CUSTOM_INCLUDES*

namespace GblAdapterLib {

template <class NodeDelegateType_>
class View :
	virtual public ViewBase
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	View ();

public:
	virtual ~View ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from TreeBase
	virtual RealNodeBase* apply_created_node (const GTree::CreateData& data);

	// implemented method from TreeBase
	virtual GTree::NewNodeUID associate_node_with_uid (RealNodeBase* node);

	// implemented method from TreeBase
	virtual void disassociate_node_with_uid (RealNodeBase* node);

	// implemented method from TreeBase
	virtual GTree::NewNodeUID find_created_uid (RealNodeBase* node);
protected:

	// implemented method from TreeBase
	virtual DefaultNodeBase* alloc_new_node (const GTree::Node& snode);

	// implemented method from TreeBase
	virtual ViewBase* alloc_new_view ();

//#UC START# *45F6583E001F*
//#UC END# *45F6583E001F*
}; // class View

} // namespace GblAdapterLib

#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/View.i.h"

#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_VIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

