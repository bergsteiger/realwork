////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ClearList
//
// реализация встроенной функции генератора _clear_list.
// _clear_list (идентификатор») - очищает список с заданным идентификатором.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ClearList::ClearList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDC760216_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDC760216_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDC760216_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDC760216_BODY*
}

ClearList::~ClearList () {
	//#UC START# *4A2CDC760216_DESTR_BODY*
	//#UC END# *4A2CDC760216_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string ClearList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDC760216*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);
	get_container (var_id)->clear ();
	
	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CDC760216*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

