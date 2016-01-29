////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDefaultUC
//
// %f_set_default_uc(<генератор>,<Идентификатор юзер-секции>,<код юзер-секции>) - заменяет код юзер-
// секции, который генерится шаблоном при первой генерации (или при выставленной галке "rewrite
// user code")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

const std::string SetDefaultUC::uc_function_impl (const std::string& gen_id, const std::string& uc_id, const std::string& content, const AbstractDumperBase* self, TemplatePainter* painter) {
	//#UC START# *4B28AF1500BA*
	const AbstractDumperBase::UserCodeData* existent_data = AbstractDumperBase::get_uc_data (gen_id, uc_id);
	
	AbstractDumperBase::UserCodeData uc_data;

	if (existent_data) {
		uc_data = *existent_data;
	}

	uc_data.used = true;
	uc_data.is_loaded = false;
	uc_data.is_default = true;

	std::string from_model = self->get_user_code (gen_id, uc_id);

	if (from_model.empty ()) {
		uc_data.uc = TemplatePainter::make_uc (uc_id
			, content
			, self->get_template_body ()
		);
	} else {
		uc_data.uc = from_model;
	}

	AbstractDumperBase::set_user_code (gen_id, uc_id, uc_data);

	return std::string ();
	//#UC END# *4B28AF1500BA*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetDefaultUC::SetDefaultUC ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A97B24B008A_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A97B24B008A_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A97B24B008A_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A97B24B008A_BODY*
}

SetDefaultUC::~SetDefaultUC () {
	//#UC START# *4A97B24B008A_DESTR_BODY*
	//#UC END# *4A97B24B008A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UCModificationBase
// возвращает реализацию конкретной функции
const UCModificationBase::UCModificationFunctionImpl SetDefaultUC::get_uc_function_impl () const {
	//#UC START# *4A97B40B0296_4A97B24B008A*
	return UCModificationBase::UCModificationFunctionImpl (&SetDefaultUC::uc_function_impl);
	//#UC END# *4A97B40B0296_4A97B24B008A*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

