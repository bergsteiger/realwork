////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Evaluate
//
// реализация встроенной функции генератора _evaluate
// _evaluate(«мат. выражение») - вичисляет мат. выражение и возвращает результат. Например:
// %f_evaluate(2*2+10) - вернёт 14.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate.h"
// by <<uses>> dependencies
#include "shared/GCI/Math/Math.h"
#include "boost/lexical_cast.hpp"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Evaluate::Evaluate ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB2C0373_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB2C0373_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEB2C0373_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEB2C0373_BODY*
}

Evaluate::~Evaluate () {
	//#UC START# *4A2CEB2C0373_DESTR_BODY*
	//#UC END# *4A2CEB2C0373_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string Evaluate::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEB2C0373*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string expression = TemplatePainter::resolve_exp(params[0], painter);
	try {
		double res = GCI::Math::CalculatorFactory::make ().evaluate (expression);
		std::string result = boost::lexical_cast<std::string> (res);
		return result;
	} catch (GCI::Math::BadExpression&) {
		std::string mess("Can't parse expression: ");
		mess += expression;
		throw Base::FatalError (mess);
	} catch (...) {
		std::string mess("Exception, when evaluate expression: ");
		mess += expression;
		throw Base::FatalError (mess);
	}
	//#UC END# *4A2CE18202C1_4A2CEB2C0373*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

