////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelPropertiesHelperImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/ModelPropertiesHelperImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/Base/Base.h"
#include "boost/lexical_cast.hpp"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ModelPropertiesHelperImpl::ModelPropertiesHelperImpl ()
//#UC START# *4AAE2857038D_4AAE288C012D_4AAE28FB034E_BASE_INIT*
//#UC END# *4AAE2857038D_4AAE288C012D_4AAE28FB034E_BASE_INIT*
{
	//#UC START# *4AAE2857038D_4AAE288C012D_4AAE28FB034E_BODY*
	//#UC END# *4AAE2857038D_4AAE288C012D_4AAE28FB034E_BODY*
}

ModelPropertiesHelperImpl::~ModelPropertiesHelperImpl () {
	//#UC START# *4AAE28FB034E_DESTR_BODY*
	//#UC END# *4AAE28FB034E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ModelPropertiesHelper
// возвращает уровень видимости для элемента
int ModelPropertiesHelperImpl::get_visibility_level (IRoseElementPtr elem) const {
	//#UC START# *4AAE2896008A_4AAE28FB034E*
	std::string res (static_cast<const char*> (elem->GetPropertyValue (TOOL_NAME, Base::VISIBILITY_LEVEL_KEY.c_str ())));
	if (!res.empty ()) {
		try {
			return boost::lexical_cast<int> (res);
		} catch (boost::bad_lexical_cast&) {
		}
	}

	return 0;
	//#UC END# *4AAE2896008A_4AAE28FB034E*
}

// implemented method from ModelPropertiesHelper
bool ModelPropertiesHelperImpl::is_global_locally (IRoseElementPtr elem) const {
	//#UC START# *4B4DBCB201C1_4AAE28FB034E*
	if (elem->IsClass(CATEGORY_TYPE)) {
		std::string res (static_cast<const char*> (elem->GetPropertyValue (TOOL_NAME, Base::GLOBAL_LOCALLY_KEY.c_str ())));
		return (res == "true");
	}

	return false;
	//#UC END# *4B4DBCB201C1_4AAE28FB034E*
}

// implemented method from ModelPropertiesHelper
void ModelPropertiesHelperImpl::set_global_locally (IRoseElementPtr elem, bool value) const {
	//#UC START# *4B4DBCCE038C_4AAE28FB034E*
	RoseHelper::override_property (
		elem
		, TOOL_NAME
		, Base::GLOBAL_LOCALLY_KEY.c_str (), value ? "true" : "false"
	);

	//нужно обновить значение дампера, криво, но что делать...
	RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (elem);
	if (rad) {
		rad->update_cached_attrs ();
	}
	//#UC END# *4B4DBCCE038C_4AAE28FB034E*
}

// implemented method from ModelPropertiesHelper
// устанавливает уровень видимости детей для элемента (при необходимсоти захватывает элемент)
void ModelPropertiesHelperImpl::set_visibility_level (IRoseElementPtr elem, int level) const {
	//#UC START# *4AAE28BF00DE_4AAE28FB034E*
	RoseHelper::override_property (
		elem
		, TOOL_NAME
		, Base::VISIBILITY_LEVEL_KEY.c_str (), boost::lexical_cast<std::string> (level).c_str ()
	);
	//#UC END# *4AAE28BF00DE_4AAE28FB034E*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

