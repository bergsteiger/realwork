////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::VirtualFunctionsHelper
//
// набор вспомогательных функций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALFUNCTIONSHELPER_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALFUNCTIONSHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"

namespace VirtualElementsFuncionsImpl {

// набор вспомогательных функций
class VirtualFunctionsHelper {
	SET_OBJECT_COUNTER (VirtualFunctionsHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// запускает генерацию spell'а для элемента, предварительно вызывая spell на элементах, кот
	// которых он "жестко" зависит
	static void run_spell_with_suppliers (const AbstractDumper* elem);

}; // class VirtualFunctionsHelper

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALFUNCTIONSHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

