////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/WindowHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::WinGUI::Helpers::WindowHelper
//
// содержит функции для работы с окнами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_WINDOWHELPER_H__
#define __SHARED_WINGUI_HELPERS_WINDOWHELPER_H__

#include "shared/Core/sys/std_inc.h"

namespace WinGUI {

// ищет окно среди детей from, у которого кэпшн совпадает с caption, а имя класса окна с class_name
// один из параметров не задан поиск осуществляется только по тому, который задан
HWND find_window (HWND from, const std::string& caption, const std::string& class_name);


} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_WINDOWHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
