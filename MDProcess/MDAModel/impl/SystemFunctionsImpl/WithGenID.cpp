////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/WithGenID.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::WithGenID
//
// реализация встроенной функции генератора "_with_gen_id".
// _with_gen_id(«gen id»,«параметр») - выводит параметр от «имени» генератора с заданным ID
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/WithGenID.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

WithGenID::WithGenID ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CED5602EA_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CED5602EA_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CED5602EA_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CED5602EA_BODY*
}

WithGenID::~WithGenID () {
	//#UC START# *4A2CED5602EA_DESTR_BODY*
	//#UC END# *4A2CED5602EA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string WithGenID::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CED5602EA*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	AbstractDumperBase::GenID tmp = AbstractDumperBase::s_current_map;
	std::string new_gen_id = TemplatePainter::resolve_exp(params[0], painter);
	
	AbstractDumperBase::s_current_map = new_gen_id;
	std::string ret = TemplatePainter::resolve_exp(params[1], painter);
	AbstractDumperBase::s_current_map = tmp;
	return ret;
	//#UC END# *4A2CE18202C1_4A2CED5602EA*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

