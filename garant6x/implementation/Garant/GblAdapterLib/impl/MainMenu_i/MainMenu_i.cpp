////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::MainMenu_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MainMenu_i::MainMenu_i ()
//#UC START# *4DD24C180204_4DD251830230_4DD24E49013C_BASE_INIT*
//#UC END# *4DD24C180204_4DD251830230_4DD24E49013C_BASE_INIT*
{
	//#UC START# *4DD24C180204_4DD251830230_4DD24E49013C_BODY*
	//#UC END# *4DD24C180204_4DD251830230_4DD24E49013C_BODY*
}

MainMenu_i::~MainMenu_i () {
	//#UC START# *4DD24E49013C_DESTR_BODY*
	//#UC END# *4DD24E49013C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from MainMenu
// Получить дерево вкладок Бзового поиска
NodeBase* MainMenu_i::get_base_search_panes () const {
	//#UC START# *4DD24C3000F5_4DD24E49013C*
	return NodeBaseFactory::make ("AT_BASE_SEARCH_PANES");
	//#UC END# *4DD24C3000F5_4DD24E49013C*
}

// implemented method from MainMenu
// Получить дерево секции ОМ по типу
const Section& MainMenu_i::get_section (SectionType type) const {
	//#UC START# *4E3012910002_4DD24E49013C*
	return Core::TypeTraits<Section>::Factory::make (type);
	//#UC END# *4E3012910002_4DD24E49013C*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

