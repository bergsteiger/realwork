////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SubstractList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SubstractList
//
// %S%f_substract_list(элемент являющийся списком) - вычитание из списка другого списка:
// {code}
// %f_clear_list(LIST1)
// %f_clear_list(LIST2)
// ...
// %{LIST1}%f_substract_list({LIST2})
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SubstractList.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SubstractList::SubstractList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B602CAE00F9_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B602CAE00F9_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B602CAE00F9_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B602CAE00F9_BODY*
}

SubstractList::~SubstractList () {
	//#UC START# *4B602CAE00F9_DESTR_BODY*
	//#UC END# *4B602CAE00F9_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
const std::string SubstractList::execute_impl2 (
	TemplatePainter::ContainerDumper* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4B75414501B9_4B602CAE00F9*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);

	std::string::const_iterator it = var_id.begin();
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, var_id.end ());
	
	const TemplatePainter::ContainerDumper* arg = adb ? dynamic_cast<const TemplatePainter::ContainerDumper*> (adb): 0;
	
	if (arg) {
		self->substract (arg);
	}

	return std::string ();
	//#UC END# *4B75414501B9_4B602CAE00F9*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

