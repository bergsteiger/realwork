////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetPreUserCodeContent
//
// %S%f_set_pre_uc_content(gen_id, uc_id,content) - добавляет дополнительный код перед юзерсекцией
// заданной uc_id для генератора gen_id
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetPreUserCodeContent.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// реализация функции
const std::string SetPreUserCodeContent::uc_function_impl (const std::string& gen_id, const std::string& uc_id, const std::string& content, const AbstractDumperBase* self, TemplatePainter* painter) {
	//#UC START# *4B28AEF70197*
	AbstractDumperBase::UserCodeData uc_data;
		
	const AbstractDumperBase::UserCodeData* existent_data = AbstractDumperBase::get_uc_data (gen_id, uc_id);
	if (existent_data) {
		uc_data = *existent_data;
	}

	uc_data.used = true;
	uc_data.is_loaded = false;
	uc_data.pre_uc_content = content;

	AbstractDumperBase::set_user_code (gen_id, uc_id, uc_data);

	return std::string ();
	//#UC END# *4B28AEF70197*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetPreUserCodeContent::SetPreUserCodeContent ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A4D9884038B_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A4D9884038B_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A4D9884038B_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A4D9884038B_BODY*
}

SetPreUserCodeContent::~SetPreUserCodeContent () {
	//#UC START# *4A4D9884038B_DESTR_BODY*
	//#UC END# *4A4D9884038B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UCModificationBase
// возвращает реализацию конкретной функции
const UCModificationBase::UCModificationFunctionImpl SetPreUserCodeContent::get_uc_function_impl () const {
	//#UC START# *4A97B40B0296_4A4D9884038B*
	return UCModificationBase::UCModificationFunctionImpl (&SetPreUserCodeContent::uc_function_impl);
	//#UC END# *4A97B40B0296_4A4D9884038B*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

