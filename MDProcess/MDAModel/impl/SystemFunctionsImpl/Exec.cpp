////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Exec.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Exec
//
// %f_exec(«код шаблона, который нужно выполнить») - выполняет код шаблона. Пример:
// {code}
// %f_exec(%SN)
// 
// //тоже самое:
// %f_set_var(CODE,"\%SN")\
// %f_exec(%{CODE}N)
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Exec.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Exec::Exec ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B012E130384_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B012E130384_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B012E130384_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B012E130384_BODY*
}

Exec::~Exec () {
	//#UC START# *4B012E130384_DESTR_BODY*
	//#UC END# *4B012E130384_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string Exec::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4B012E130384*
	if (params.size () > 0) {
		std::string code = TemplatePainter::resolve_exp(params[0], painter);
		std::string resolved_code = TemplatePainter::resolve_exp(code, painter);

		return resolved_code;
	}

	return std::string ();
	//#UC END# *4A2CE18202C1_4B012E130384*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

