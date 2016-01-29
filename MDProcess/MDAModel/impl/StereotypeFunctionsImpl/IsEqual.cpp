////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/IsEqual.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::IsEqual
//
// %S%f_is_equal (дампер списка) - сравниваем списки, возвращает true или false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/IsEqual.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IsEqual::IsEqual ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B7544EE01C5_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B7544EE01C5_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B7544EE01C5_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B7544EE01C5_BODY*
}

IsEqual::~IsEqual () {
	//#UC START# *4B7544EE01C5_DESTR_BODY*
	//#UC END# *4B7544EE01C5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
const std::string IsEqual::execute_impl2 (
	TemplatePainter::ContainerDumper* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4B75414501B9_4B7544EE01C5*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string res ("false");

	std::string::const_iterator it = params[0].begin ();
	const AbstractDumperBase* dest = painter->get_dumper_by_template (it, params[0].end ());
	const TemplatePainter::ContainerDumper* dest_cont = dest != 0
		? dynamic_cast<const TemplatePainter::ContainerDumper*> (dest)
		: 0;

	if (!dest_cont) {
		if (self->is_equal (dest_cont)) {
			res = "true";
		}
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += ": Can't find list: " + params[0];		
	}

	return res;
	//#UC END# *4B75414501B9_4B7544EE01C5*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

