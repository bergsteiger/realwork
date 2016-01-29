////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetUserCodeContent
//
// %S%f_set_uc_content(gen_id, uc_id,content) - добавляет содержимое юзерсекции для генератора
// gen_id
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// реализация функции
const std::string SetUserCodeContent::uc_function_impl (const std::string& gen_id, const std::string& uc_id, const std::string& content, const AbstractDumperBase* self, TemplatePainter* painter) {
	//#UC START# *4B28AF3A02D1*
	AbstractDumperBase::UserCodeData uc_data;
	
	const AbstractDumperBase::UserCodeData* existent_data = AbstractDumperBase::get_uc_data (gen_id, uc_id);
	if (existent_data) {
		uc_data = *existent_data;
	}

	uc_data.uc = content;
	uc_data.used = true;
	uc_data.is_loaded = false;
	uc_data.is_default = false;

	AbstractDumperBase::set_user_code (gen_id, uc_id, uc_data);
	return std::string ();
	//#UC END# *4B28AF3A02D1*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetUserCodeContent::SetUserCodeContent ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A39E27900AF_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A39E27900AF_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A39E27900AF_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A39E27900AF_BODY*
}

SetUserCodeContent::~SetUserCodeContent () {
	//#UC START# *4A39E27900AF_DESTR_BODY*
	//#UC END# *4A39E27900AF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UCModificationBase
// возвращает реализацию конкретной функции
const UCModificationBase::UCModificationFunctionImpl SetUserCodeContent::get_uc_function_impl () const {
	//#UC START# *4A97B40B0296_4A39E27900AF*
	return UCModificationBase::UCModificationFunctionImpl (&SetUserCodeContent::uc_function_impl);
	//#UC END# *4A97B40B0296_4A39E27900AF*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

