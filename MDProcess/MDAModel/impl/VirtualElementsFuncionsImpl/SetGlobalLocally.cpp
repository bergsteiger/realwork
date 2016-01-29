////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetGlobalLocally.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetGlobalLocally
//
// %S%f_set_global_locally(true|false) - метод для установки "локальной глобальности"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetGlobalLocally.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetGlobalLocally::SetGlobalLocally ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4DEA4A01F2_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4DEA4A01F2_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4DEA4A01F2_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4DEA4A01F2_BODY*
}

SetGlobalLocally::~SetGlobalLocally () {
	//#UC START# *4B4DEA4A01F2_DESTR_BODY*
	//#UC END# *4B4DEA4A01F2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetGlobalLocally::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4B4DEA4A01F2*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	RoseAbstractCategoryDumper* rad = const_cast<RoseAbstractCategoryDumper*> (dynamic_cast<const RoseAbstractCategoryDumper*> (self));
	if (rad) {
		std::string value = TemplatePainter::resolve_exp (params[0], painter);
					
		bool bool_value;
		if (value == "true") {
			bool_value = true;
		} else if (value == "false") {
			bool_value = false;
		} else {
			throw Base::FatalError ("параметр функции должен быть true или false");
		}

		rad->set_is_global_locally (bool_value);
	} else {
		throw Base::FatalError ("фунция применима только к пакетам");
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4B4DEA4A01F2*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

