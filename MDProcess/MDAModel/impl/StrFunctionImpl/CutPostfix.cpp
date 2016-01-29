////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::CutPostfix
//
// реализация встроенной функции генератора "_cut_postfix"
// _cut_postfix(<строка>,<постфикс>) - удаляет постфикс у строчки, если она на него заканчивается.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CutPostfix::CutPostfix ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE2440012_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE2440012_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE2440012_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE2440012_BODY*
}

CutPostfix::~CutPostfix () {
	//#UC START# *4A2CE2440012_DESTR_BODY*
	//#UC END# *4A2CE2440012_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string CutPostfix::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE2440012*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}

	std::string res = TemplatePainter::resolve_exp (params[0], painter);
	std::string prefix = TemplatePainter::resolve_exp (params[1], painter);
	
	if (prefix.empty () == false) {
		std::string::size_type off = res.length () - prefix.length ();
		if (off >= 0 && res.substr (off) == prefix) {
			res.erase (off);
		}
	}
	return res;
	//#UC END# *4A2CE18202C1_4A2CE2440012*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

