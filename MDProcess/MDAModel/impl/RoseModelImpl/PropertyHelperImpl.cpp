////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::PropertyHelperImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/PropertyHelperImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/Base/Base.h"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PropertyHelperImpl::PropertyHelperImpl ()
//#UC START# *4AA73CE001A0_4AA73D1C00D5_4AA73E100051_BASE_INIT*
//#UC END# *4AA73CE001A0_4AA73D1C00D5_4AA73E100051_BASE_INIT*
{
	//#UC START# *4AA73CE001A0_4AA73D1C00D5_4AA73E100051_BODY*
	//#UC END# *4AA73CE001A0_4AA73D1C00D5_4AA73E100051_BODY*
}

PropertyHelperImpl::~PropertyHelperImpl () {
	//#UC START# *4AA73E100051_DESTR_BODY*
	//#UC END# *4AA73E100051_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from PropertyHelper
// возвращает true, если свойство может быть удалено из модели
bool PropertyHelperImpl::can_be_deleted (IRosePropertyPtr property) const {
	//#UC START# *4AFBC60F010E_4AA73E100051*
	std::string prop_name = property->GetName ();
	std::string tool_name = property->GetToolName ();

	if (
		(
			prop_name == Base::RESOLVED_TYPE_GUID
			|| prop_name == Base::VISIBILITY_LEVEL_KEY
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_ROOTDIR)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_ATTR_SET_RAISES)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_ATTR_GET_RAISES)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_TEMPLATE_FILE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_AUTO_COUNTER)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_IS_NATIVE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_IMPLEMENT_SELECT_TYPE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_OVERLOAD_SELECT_TYPE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (Base::ABSTRACTION_TYPE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (Base::VISIBILITY_TYPE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_TARGET_STEREOTYPE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_APPLGEN)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_INCOMPLETE)))
			|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_OS_GUID)))
			|| prop_name == "MODEL_MAIN_ELEMENT"
			|| prop_name == "ValueInitialized"
			|| prop_name == "UseCase"
			|| prop_name.find ("NATIVE_PATH") != std::string::npos
		) && (
			tool_name == std::string (static_cast<const char*> (_bstr_t (TOOL_NAME)))
		)
	) {
		return false;
	}

	if (tool_name == std::string (static_cast<const char*> (_bstr_t (Base::USER_PROPERTY_TOOL)))) {
		return false;
	}
	return true;
	//#UC END# *4AFBC60F010E_4AA73E100051*
}

// implemented method from PropertyHelper
// возвращает true, если свойство определяет сгенерированный артефакт
bool PropertyHelperImpl::is_self_generated_source (const std::string& prop_id) const {
	//#UC START# *4AA743CD03D3_4AA73E100051*
	return prop_id.find ("SELF GENERATED FILE (") != std::string::npos
		|| prop_id.find ("WikiPageID (") != std::string::npos;
	//#UC END# *4AA743CD03D3_4AA73E100051*
}

// implemented method from PropertyHelper
// возвращает true, если свойство нужно обязательно сохранить в модель
bool PropertyHelperImpl::need_persist (const std::string& prop_id) const {
	//#UC START# *4AA73DB0006F_4AA73E100051*
	return this->is_self_generated_source (prop_id)
		|| prop_id == std::string (PROP_OS_GUID);
	//#UC END# *4AA73DB0006F_4AA73E100051*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

