////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/WinControlHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::WinGUI::Helpers::WinControlHelper
//
// вспомогательные функции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_WINCONTROLHELPER_H__
#define __SHARED_WINGUI_HELPERS_WINCONTROLHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// вспомогательные функции
class WinControlHelper {
	SET_OBJECT_COUNTER (WinControlHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// вовзращает размеры клинтскую области с учетом скролл-баров
	static CRect* get_client_rect_sb (CWnd& wnd);

	// true - если ctrl является комбобоксом, иначе false
	static bool is_combobox (CWnd& ctrl);

}; // class WinControlHelper

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_WINCONTROLHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

