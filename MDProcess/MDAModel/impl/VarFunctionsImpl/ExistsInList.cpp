////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ExistsInList
//
// реализация встроенной функции генератора _exists_in_list.
// _exists_in_list (идентификатор», «значение») - проверяет наличие в списке с заданным
// идентификатором элемента (может быть ЭЛЕМЕНТ МОДЕЛИ или СТРОКА), возвращает true или false
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExistsInList::ExistsInList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BODY*
}

ExistsInList::~ExistsInList () {
	//#UC START# *4A2CDD1F00DD_DESTR_BODY*
	//#UC END# *4A2CDD1F00DD_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ExistsInList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDD1F00DD*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	TemplateFunctions::InternalFunction& func = TemplateFunctions::InternalFunctionFactory::make ("_count_in_list");

	std::string count = func.execute (params, painter);
	return count == "0" ? "false" : "true";
	//#UC END# *4A2CE18202C1_4A2CDD1F00DD*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

