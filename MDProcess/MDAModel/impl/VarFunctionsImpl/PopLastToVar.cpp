////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopLastToVar
//
// реализация встроенной функции генератора _pop_last_to_var.
// _pop_last_to_var(«идентификатор», «идентификатор переменной») - помещает в переменную
// «идентификатор переменной» значение последнего дампера из списка (аналогично _set_var), и
// удаляет его (из списка)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PopLastToVar::PopLastToVar ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDE0D015D_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDE0D015D_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDE0D015D_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDE0D015D_BODY*
}

PopLastToVar::~PopLastToVar () {
	//#UC START# *4A2CDE0D015D_DESTR_BODY*
	//#UC END# *4A2CDE0D015D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string PopLastToVar::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDE0D015D*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string list_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string var_id = TemplatePainter::resolve_exp(params[1], painter);
	
	TemplatePainter::ContainerDumper* cont = get_container_if_exists (list_id);
	if (cont) {
		ContainerOperations::ContainerTemplateOperationsFactory::get ().pop_last_to_var (
			cont
			, var_id
		);
	}

	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDE0D015D*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

