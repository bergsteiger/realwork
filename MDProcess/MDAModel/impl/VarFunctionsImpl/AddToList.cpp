////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::AddToList
//
// реализация встроенной функции генератора _add_to_list.
// _add_to_list («идентификатор», «значение») - добавляет в список c заданным идентификатором
// элемент (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА).
// %f_add_to_list (LIST, S)
// %f_add_to_list (LIST, "test str")
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddToList::AddToList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDC4B0370_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDC4B0370_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDC4B0370_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDC4B0370_BODY*
}

AddToList::~AddToList () {
	//#UC START# *4A2CDC4B0370_DESTR_BODY*
	//#UC END# *4A2CDC4B0370_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddToList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDC4B0370*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string var_id (TemplatePainter::resolve_exp (params[0], painter));

	ContainerOperations::ContainerTemplateOperationsFactory::get ().add (
		this->get_container (var_id)
		, params[1]
		, painter
	);

	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDC4B0370*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

