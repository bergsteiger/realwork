////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTreeView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListTreeView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListTreeView.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNodeDelegate_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ListTreeView::ListTreeView ()
//#UC START# *5465C2970213_BASE_INIT*
//#UC END# *5465C2970213_BASE_INIT*
{
	//#UC START# *5465C2970213_BODY*
	//#UC END# *5465C2970213_BODY*
}

ListTreeView::~ListTreeView () {
	//#UC START# *5465B85E011B_DESTR_BODY*
	//#UC END# *5465B85E011B_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from TreeBase
ViewBase* ListTreeView::alloc_new_view () {
	//#UC START# *460127E400EA_5465B85E011B*
	return new ListTreeView ();
	//#UC END# *460127E400EA_5465B85E011B*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

