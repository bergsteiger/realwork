////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DynListNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTreeView.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DynListNodeDelegate::DynListNodeDelegate (TreeBase* owner_tree)
//#UC START# *5464C79400FD_BASE_INIT*
: DefaultNodeBase (owner_tree), DelegateNodeBase (owner_tree), NodeDelegate (owner_tree)
//#UC END# *5464C79400FD_BASE_INIT*
{
	//#UC START# *5464C79400FD_BODY*
	//#UC END# *5464C79400FD_BODY*
}

DynListNodeDelegate::~DynListNodeDelegate () {
	//#UC START# *5464C77601DC_DESTR_BODY*
	//#UC END# *5464C77601DC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DynListNode
// Получить идентифкатор документа из ноды списка
ObjectId DynListNodeDelegate::get_document_id () const {
	//#UC START# *53CF894902A4_5464C77601DC*
	const DynListNode* master_node = dynamic_cast<const DynListNode*> (this->cached_master_node ());
	GDS_ASSERT (master_node);
	return master_node->get_document_id ();
	//#UC END# *53CF894902A4_5464C77601DC*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

