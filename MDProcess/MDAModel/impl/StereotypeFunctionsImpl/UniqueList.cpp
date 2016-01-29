////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/UniqueList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::UniqueList
//
// %S%f_unique_list() - удаляет дубликаты из списка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/UniqueList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UniqueList::UniqueList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B7542C0003E_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B7542C0003E_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B7542C0003E_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B7542C0003E_BODY*
}

UniqueList::~UniqueList () {
	//#UC START# *4B7542C0003E_DESTR_BODY*
	//#UC END# *4B7542C0003E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
const std::string UniqueList::execute_impl2 (
	TemplatePainter::ContainerDumper* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4B75414501B9_4B7542C0003E*
	std::string command;
	if (params.size() > 0) {
		std::string param1 = params[0];
		if (GCL::border_with (param1.data(), '"')) {
			command.assign (param1, 1, param1.size () - 2);							
		} else {
			command = param1;
		}
	}

	ContainerOperations::ContainerTemplateOperationsFactory::get ().unique (
		self
		, command
		, painter
	);

	return std::string ();
	//#UC END# *4B75414501B9_4B7542C0003E*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

