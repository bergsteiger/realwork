////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::IsEmpty
//
// реализация встроенной функции генератора _is_empty.
// _is_empty(«идентификатор») - возвращает true, если список пуст
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

IsEmpty::IsEmpty ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD4503B2_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD4503B2_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD4503B2_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD4503B2_BODY*
}

IsEmpty::~IsEmpty () {
	//#UC START# *4A2CDD4503B2_DESTR_BODY*
	//#UC END# *4A2CDD4503B2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string IsEmpty::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDD4503B2*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);		
	
	std::string ret = "true";
	TemplatePainter::ContainerDumper* cont = get_container_if_exists (var_id);
	if (cont) {
		bool is_empty = cont->size () == 0;
		ret = is_empty ? "true" : "false";
	}
	return ret;
	//#UC END# *4A2CE18202C1_4A2CDD4503B2*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

