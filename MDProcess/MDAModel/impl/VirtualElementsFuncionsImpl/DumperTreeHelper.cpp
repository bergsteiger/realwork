////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/DumperTreeHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::DumperTreeHelper
//
// вспомогательный класс для работы с деревом дамперов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/DumperTreeHelper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseClassDependencyImpl.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// находит элемент в дереве дамперов по гуиду
RoseAbstractDumper* DumperTreeHelper::find_in_tree (const std::string& guid) {
	//#UC START# *4A39B83D03E2*	
	ATL::CComObject<RoseInternal::RoseClassDependencyImpl>* obj;
	obj->CreateInstance (&obj);
	IRoseItemPtr item;
	obj->QueryInterface (&item);

	if (item) {
		obj->set_unique_id (guid);
		return RoseAbstractDumper::find_in_tree (item);
	}

	return 0;
	//#UC END# *4A39B83D03E2*
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

