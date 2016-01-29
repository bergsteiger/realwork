////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::TypeLinkHelperImpl
//
// сервант
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TypeLinkHelperImpl::TypeLinkHelperImpl ()
//#UC START# *4AC1ECD50061_4AC1EE4F03AE_4AC1EF8501FC_BASE_INIT*
//#UC END# *4AC1ECD50061_4AC1EE4F03AE_4AC1EF8501FC_BASE_INIT*
{
	//#UC START# *4AC1ECD50061_4AC1EE4F03AE_4AC1EF8501FC_BODY*
	//#UC END# *4AC1ECD50061_4AC1EE4F03AE_4AC1EF8501FC_BODY*
}

TypeLinkHelperImpl::~TypeLinkHelperImpl () {
	//#UC START# *4AC1EF8501FC_DESTR_BODY*
	//#UC END# *4AC1EF8501FC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TypeLinkHelper
// возвращает идентифкатор элемента, с которым связан элемент
const std::string TypeLinkHelperImpl::get_linked (IRoseElementPtr source) const {
	//#UC START# *4AC1F5E70269_4AC1EF8501FC*
	return std::string (
		static_cast<const char*> (source->GetPropertyValue (TOOL_NAME, Base::RESOLVED_TYPE_GUID.c_str ()))
	);
	//#UC END# *4AC1F5E70269_4AC1EF8501FC*
}

// implemented method from TypeLinkHelper
// Прописывает в свойства элемента, что он связан с элементом, имеющим гуид target_uid
void TypeLinkHelperImpl::link (IRoseElementPtr source, const std::string& target_uid) const {
	//#UC START# *4AC1EE8B01FA_4AC1EF8501FC*
	RoseHelper::write_property_with_lock (
		source
		, Base::RESOLVED_TYPE_GUID
		, target_uid
		, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
		, true
		, "Идентификатор связанного типа"
	);
	//#UC END# *4AC1EE8B01FA_4AC1EF8501FC*
}

// implemented method from TypeLinkHelper
// разрывает связь для элемента
void TypeLinkHelperImpl::unlink (IRoseElementPtr source) const {
	//#UC START# *4AC1EEE80036_4AC1EF8501FC*
	RoseHelper::write_property_with_lock (
		source
		, Base::RESOLVED_TYPE_GUID
		, std::string ("")
		, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
		, true
		, "Идентификатор связанного типа"
	);
	//#UC END# *4AC1EEE80036_4AC1EF8501FC*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

