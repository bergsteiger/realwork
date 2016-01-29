////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DecToHex.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DecToHex
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DecToHex.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DecToHex::DecToHex ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE8B80202_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE8B80202_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE8B80202_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE8B80202_BODY*
}

DecToHex::~DecToHex () {
	//#UC START# *4A2CE8B80202_DESTR_BODY*
	//#UC END# *4A2CE8B80202_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string DecToHex::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE8B80202*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string str = TemplatePainter::resolve_exp(params[0], painter);
	int i = atoi (str.c_str()+1);
	char buf[32];
	std::string ret = itoa (i, buf, 16);

	int length = atoi (params[1].c_str());

	while (length - (int)ret.size() > 0) {
		ret = "0" + ret;
	}
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE8B80202*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

