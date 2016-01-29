////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/DumperTreeHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::DumperTreeHelper
//
// вспомогательный класс для работы с деревом дамперов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_DUMPERTREEHELPER_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_DUMPERTREEHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

namespace VirtualElementsFuncionsImpl {

// вспомогательный класс для работы с деревом дамперов
class DumperTreeHelper {
	SET_OBJECT_COUNTER (DumperTreeHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// находит элемент в дереве дамперов по гуиду
	static RoseAbstractDumper* find_in_tree (const std::string& guid);

}; // class DumperTreeHelper

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_DUMPERTREEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

