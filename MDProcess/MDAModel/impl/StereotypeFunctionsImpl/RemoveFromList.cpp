////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/RemoveFromList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::RemoveFromList
//
// %S%f_remove_from_list («значение») - добавляет в список c заданным идентификатором элемент
// (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/RemoveFromList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace StereotypeFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RemoveFromList::RemoveFromList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B75428202D4_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B75428202D4_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B75428202D4_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B75428202D4_BODY*
}

RemoveFromList::~RemoveFromList () {
	//#UC START# *4B75428202D4_DESTR_BODY*
	//#UC END# *4B75428202D4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ContainerOperationsImpl::StereotypeListOperationBase
const std::string RemoveFromList::execute_impl2 (
	TemplatePainter::ContainerDumper* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4B75414501B9_4B75428202D4*
	//std::string param = TemplatePainter::resolve_exp(params[0], painter);

	ContainerOperations::ContainerTemplateOperationsFactory::get ().remove (
		self
		, params[0]
		, painter
	);

	return std::string ();
	//#UC END# *4B75414501B9_4B75428202D4*
}
} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

