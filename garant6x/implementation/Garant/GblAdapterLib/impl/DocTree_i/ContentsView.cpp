////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsView.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ContentsView::ContentsView ()
//#UC START# *4CA06E69018C_BASE_INIT*
//#UC END# *4CA06E69018C_BASE_INIT*
{
	//#UC START# *4CA06E69018C_BODY*
	//#UC END# *4CA06E69018C_BODY*
}

ContentsView::~ContentsView () {
	//#UC START# *4CA06D4A0272_DESTR_BODY*
	//#UC END# *4CA06D4A0272_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from TreeBase
void ContentsView::add_notifier (GCL::StaticNode* root, NodeNotifier* notifier) {
	//#UC START# *46011F130203_4CA06D4A0272*
	TreeBase::add_notifier (root, notifier);
	this->expand_all (true);
	//#UC END# *46011F130203_4CA06D4A0272*
}

// overloaded method from TreeBase
ViewBase* ContentsView::alloc_new_view () {
	//#UC START# *460127E400EA_4CA06D4A0272*
	return new ContentsView ();
	//#UC END# *460127E400EA_4CA06D4A0272*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

