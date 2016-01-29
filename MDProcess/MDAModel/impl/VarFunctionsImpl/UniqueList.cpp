////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/UniqueList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::UniqueList
//
// реализация встроенной функции генератора _unique_list.
// _unique_list(«идентификатор») - удаляет дубликаты из списка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/UniqueList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "boost/bind.hpp"
#include "boost/function.hpp"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UniqueList::UniqueList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDF1A03B3_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDF1A03B3_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDF1A03B3_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDF1A03B3_BODY*
}

UniqueList::~UniqueList () {
	//#UC START# *4A2CDF1A03B3_DESTR_BODY*
	//#UC END# *4A2CDF1A03B3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string UniqueList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDF1A03B3*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);		
	
	TemplatePainter::ContainerDumper* cont = get_container_if_exists (var_id);
	if (cont) {
		std::string command;
		if (params.size() > 1) {
			std::string param1 = params[1];
			if (GCL::border_with (param1.data(), '"')) {
				command.assign (param1, 1, param1.size () - 2);							
			} else {
				command = param1;
			}
		}
		ContainerOperations::ContainerTemplateOperationsFactory::get ().unique (cont, command, painter);
	}
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDF1A03B3*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

