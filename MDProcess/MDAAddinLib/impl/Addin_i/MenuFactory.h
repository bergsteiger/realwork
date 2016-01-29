////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MenuFactory.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAAddinLib::Addin_i::MenuFactory
//
// фабрика для создания меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUFACTORY_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MENUFACTORY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *462DB25701A5_USER_INCLUDES*
//#UC END# *462DB25701A5_USER_INCLUDES*

namespace MenuFactory {

// тип меню: для диграммы, для дерева
enum MenuType {
	TREE_MENU // меня для элемента в браузере
	, DIAG_MENU // меню для элемента на диаграмме
};

// создает меню для элемента
CMenu* create_menu (MenuType type, IRoseElementPtr elem);

// создает меню для элемента дерева
CMenu* create_tree_menu (IRoseElementPtr elem);

// создает меню для элемента на диграмме
CMenu* create_diag_menu (IRoseElementPtr elem);

//#UC START# *462DB25701A5_USER_DEFINITION*
//#UC END# *462DB25701A5_USER_DEFINITION*

} // namespace MenuFactory


#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MENUFACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
