////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/ClipboardHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::WinGUI::Helpers::ClipboardHelper
//
// вспомогательный класс для работы с буфером обмена
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_CLIPBOARDHELPER_H__
#define __SHARED_WINGUI_HELPERS_CLIPBOARDHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// вспомогательный класс для работы с буфером обмена
class ClipboardHelper {
	SET_OBJECT_COUNTER (ClipboardHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// копирует текст в буфер обмена, возвращает true, если все прошло успешно
	static bool copy_text_to_clipboard (const std::string& text);

}; // class ClipboardHelper

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_CLIPBOARDHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

