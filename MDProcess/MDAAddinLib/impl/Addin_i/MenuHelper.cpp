////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MenuHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAAddinLib::Addin_i::MenuHelper
// Файл реализации утилитного набора MenuHelper
//
// класс-помошник для работы с MFC-шным меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MenuHelper.h"

namespace MenuHelper {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// удаляет один из двух идущих подряд сепараторов
void clear_duplicate_separator (CMenu& menu) {
	//#UC START# *470DFCC301F4*
	GDS_ASSERT(::IsMenu(menu.GetSafeHmenu()));
	for (unsigned int i = 0; i < menu.GetMenuItemCount(); i++) {
		CString str;
		MENUITEMINFO info;
		info.cbSize = sizeof (MENUITEMINFO); // must fill up this field
		info.fMask = MIIM_FTYPE; 
		menu.GetMenuItemInfo (i, &info, TRUE);
		if (
			info.fType == MFT_SEPARATOR
			&& i < (menu.GetMenuItemCount() - 1)
		) {
			MENUITEMINFO info_next;
			info_next.cbSize = sizeof (MENUITEMINFO); // must fill up this field
			info_next.fMask = MIIM_FTYPE;
			menu.GetMenuItemInfo (i + 1, &info_next, TRUE);
			if (info_next.fType == MFT_SEPARATOR) {
				menu.DeleteMenu (i, MF_BYPOSITION);
				--i;
			}
		}
		CMenu* sub_menu = menu.GetSubMenu(i);
		if (sub_menu) {
			clear_duplicate_separator (*sub_menu);	
		}
	}
	//#UC END# *470DFCC301F4*
}

// включает/выключает пукнкт меню по идентификатору
bool enable_menu_item (CMenu& menu, unsigned int id, bool enable) {
	//#UC START# *462F1F4F0213*
	ASSERT(::IsMenu(menu.GetSafeHmenu()));
	
	int count = menu.GetMenuItemCount();
	for (int i = 0; i < count; i++) {
		CString str;
		if (menu.GetMenuItemID(i) == id) {			
			if (enable) {
				menu.EnableMenuItem(id, MF_BYCOMMAND | MF_ENABLED);
			} else {
				menu.EnableMenuItem(id, MF_BYCOMMAND | MF_DISABLED | MF_GRAYED);
			}
			return true;
		} else {
			CMenu* sub_menu = menu.GetSubMenu(i);
			if (sub_menu) {
				bool enabled = enable_menu_item (*sub_menu, id, enable);
				if (enabled) {
					return enabled;
				}
			}
		}
	}
	return false;
	//#UC END# *462F1F4F0213*
}

// включает/выключет пукнкт меню по названию
bool enable_menu_item (CMenu& menu, const char* menu_string, bool enable) {
	//#UC START# *462F212F0186*
	ASSERT(::IsMenu(menu.GetSafeHmenu()));
	
	int count = menu.GetMenuItemCount();
	for (int i = 0; i < count; i++) {
		CString str;
		if (
			menu.GetMenuString(i, str, MF_BYPOSITION) 
			&& (strcmp(str, menu_string) == 0)
		) {			
			if (enable) {
				menu.EnableMenuItem(i, MF_BYPOSITION | MF_ENABLED);
			} else {
				menu.EnableMenuItem(i, MF_BYPOSITION | MF_DISABLED | MF_GRAYED);
			}
			return true;
		} else {
			CMenu* sub_menu = menu.GetSubMenu(i);
			if (sub_menu) {
				bool enabled = enable_menu_item (*sub_menu, menu_string, enable);
				if (enabled) {
					return enabled;
				}
			}
		}
	}
	return false;
	//#UC END# *462F212F0186*
}

// возвращает под меню пункта меню с названием menu_string
CMenu* get_sub_menu (CMenu& menu, const char* menu_string) {
	//#UC START# *462DCD7A0157*
	ASSERT(::IsMenu(menu.GetSafeHmenu()));
	
	int count = menu.GetMenuItemCount();
	for (int i = 0; i < count; i++) {
		CString str;
		if (
			menu.GetMenuString(i, str, MF_BYPOSITION) 
			&& (strcmp(str, menu_string) == 0)
		) {			
			return menu.GetSubMenu(i);
		} else {
			CMenu* sub_menu = menu.GetSubMenu(i);
			if (sub_menu) {
				CMenu* res = get_sub_menu (*sub_menu, menu_string);
				if (res) {
					return res;
				}
			}
		}
	}
	return 0;
	//#UC END# *462DCD7A0157*
}

// заменяет названия всех меню с названием совпадающим с menu_string на new_menu_string
bool modify_menu_item (CMenu& menu, const char* menu_string, const char* new_menu_string) {
	//#UC START# *462DB55B01C5*	
	ASSERT(::IsMenu(menu.GetSafeHmenu()));
	
	int count = menu.GetMenuItemCount();
	for (int i = 0; i < count; i++) {
		CString str;
		if (
			menu.GetMenuString(i, str, MF_BYPOSITION) 
			&& (strcmp(str, menu_string) == 0)
		) {
			UINT id = menu.GetMenuItemID(i);
			menu.ModifyMenu(id, MF_BYCOMMAND, id, new_menu_string);
			return true;
		} else {
			CMenu* sub_menu = menu.GetSubMenu(i);
			if (sub_menu) {
				bool modified = modify_menu_item (*sub_menu, menu_string, new_menu_string);
				if (modified) {
					return modified;
				}
			}
		}
	}
	return false;
	//#UC END# *462DB55B01C5*
}

// заменяет названия всех меню с идентификатором совпадающим с id на new_menu_string
bool modify_menu_item (CMenu& menu, unsigned int id, const char* new_menu_string) {
	//#UC START# *462DB60F0000*	
	ASSERT(::IsMenu(menu.GetSafeHmenu()));
	
	int count = menu.GetMenuItemCount();
	for (int i = 0; i < count; i++) {
		CString str;
		if (menu.GetMenuItemID(i) == id) {					
			menu.ModifyMenu(id, MF_BYCOMMAND, id, new_menu_string);
			return true;
		} else {
			CMenu* sub_menu = menu.GetSubMenu(i);
			if (sub_menu) {
				bool modified = modify_menu_item (*sub_menu, id, new_menu_string);
				if (modified) {
					return modified;
				}
			}
		}
	}
	return false;
	//#UC END# *462DB60F0000*
}

// удаляет пункты меню, по идентификатору
bool remove_menu_item (CMenu& menu, unsigned int id) {
	//#UC START# *462DB6640399*	
	ASSERT(::IsMenu(menu.GetSafeHmenu()));
	
	int count = menu.GetMenuItemCount();
	for (int i = 0; i < count; i++) {
		CString str;
		if (menu.GetMenuItemID(i) == id) {
			menu.DeleteMenu (i, MF_BYPOSITION);
			return true;
		} else {
			CMenu* sub_menu = menu.GetSubMenu(i);
			if (sub_menu) {
				bool removed = remove_menu_item (*sub_menu, id);
				if (removed) {
					return removed;
				}
			}
		}
	}
	return false;
	//#UC END# *462DB6640399*
}

// удаляет пункты меню по названию
bool remove_menu_item (CMenu& menu, const char* menu_string) {
	//#UC START# *462DB67A0138*
	ASSERT(::IsMenu(menu.GetSafeHmenu()));
	
	int count = menu.GetMenuItemCount();
	for (int i = 0; i < count; i++) {
		CString str;
		if (
			menu.GetMenuString(i, str, MF_BYPOSITION) 
			&& (strcmp(str, menu_string) == 0)
		) {
			menu.DeleteMenu (i, MF_BYPOSITION);
			return true;
		} else {
			CMenu* sub_menu = menu.GetSubMenu(i);
			if (sub_menu) {
				bool removed = remove_menu_item (*sub_menu, menu_string);
				if (removed) {
					return removed;
				}
			}
		}
	}
	return false;
	//#UC END# *462DB67A0138*
}

} // namespace MenuHelper

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

