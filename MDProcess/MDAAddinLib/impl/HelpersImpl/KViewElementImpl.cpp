////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::KViewElementImpl
//
// открывает описание элемента в К используя системную функцию ShellExecute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/KSettings.h"

namespace HelpersImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

KViewElementImpl::KViewElementImpl ()
//#UC START# *49CC614C01C3_49CC617F0220_49CC638B0360_BASE_INIT*
//#UC END# *49CC614C01C3_49CC617F0220_49CC638B0360_BASE_INIT*
{
	//#UC START# *49CC614C01C3_49CC617F0220_49CC638B0360_BODY*
	//#UC END# *49CC614C01C3_49CC617F0220_49CC638B0360_BODY*
}

KViewElementImpl::~KViewElementImpl () {
	//#UC START# *49CC638B0360_DESTR_BODY*
	//#UC END# *49CC638B0360_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Helpers::KViewElement
// формирует ссылку для открытия описания элемента в К
const std::string KViewElementImpl::make_view_link (IRoseElementPtr elem) const {
	//#UC START# *49CC6334037A_49CC638B0360*
	std::string klink = KSettings::get_k_link ();
	std::string view_action_link ("/ru/garant/MDProcess/MDGenPlugins/PageMacros/ViewPageActions/ViewPageActionsPackage/viewpagebyguid.action?elemGuid=");
	return klink + view_action_link + get_rose_element_uid(elem);
	//#UC END# *49CC6334037A_49CC638B0360*
}

// implemented method from Helpers::KViewElement
// показывает описание элемента в К
void KViewElementImpl::view (IRoseElementPtr elem) const {
	//#UC START# *49CC63070081_49CC638B0360*
	GDS_ASSERT_MSG(elem != 0, (GDS_CURRENT_FUNCTION));
	::ShellExecute (NULL, "open", make_view_link (elem).c_str (), NULL, NULL, SW_SHOWNORMAL);
	//#UC END# *49CC63070081_49CC638B0360*
}
} // namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

