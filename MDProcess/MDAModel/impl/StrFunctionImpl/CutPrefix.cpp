////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/CutPrefix.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::CutPrefix
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPrefix.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CutPrefix::CutPrefix ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE2CF0035_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE2CF0035_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE2CF0035_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE2CF0035_BODY*
}

CutPrefix::~CutPrefix () {
	//#UC START# *4A2CE2CF0035_DESTR_BODY*
	//#UC END# *4A2CE2CF0035_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string CutPrefix::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE2CF0035*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string res = TemplatePainter::resolve_exp (params[0], painter);
	std::string prefix = TemplatePainter::resolve_exp (params[1], painter);
	
	if (prefix.empty () == false) {
		if (res.substr (0, prefix.length ()) == prefix) {
			res.erase (0,  prefix.length ());
		}
	}
	return res;
	//#UC END# *4A2CE18202C1_4A2CE2CF0035*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

