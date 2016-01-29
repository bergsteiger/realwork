////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MenuHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAAddinLib::Addin_i::MenuHelper
//
// класс-помошник для работы с MFC-шным меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUHELPER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace MenuHelper {

// заменяет названия всех меню с названием совпадающим с menu_string на new_menu_string
bool modify_menu_item (CMenu& menu, const char* menu_string, const char* new_menu_string);

// заменяет названия всех меню с идентификатором совпадающим с id на new_menu_string
bool modify_menu_item (CMenu& menu, unsigned int id, const char* new_menu_string);

// удаляет пункты меню, по идентификатору
bool remove_menu_item (CMenu& menu, unsigned int id);

// удаляет пункты меню по названию
bool remove_menu_item (CMenu& menu, const char* menu_string);

// включает/выключает пукнкт меню по идентификатору
bool enable_menu_item (CMenu& menu, unsigned int id, bool enable);

// включает/выключет пукнкт меню по названию
bool enable_menu_item (CMenu& menu, const char* menu_string, bool enable);

// возвращает под меню пункта меню с названием menu_string
CMenu* get_sub_menu (CMenu& menu, const char* menu_string);

// удаляет один из двух идущих подряд сепараторов
void clear_duplicate_separator (CMenu& menu);


} // namespace MenuHelper


#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MENUHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
