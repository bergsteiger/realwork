////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::BaseFunctionImpl::InternalFunctionBase
//
// базовая реализация встроенной функции шаблона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace BaseFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InternalFunctionBase::InternalFunctionBase ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE15C003D_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE15C003D_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE15C003D_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE15C003D_BODY*
}

InternalFunctionBase::~InternalFunctionBase () {
	//#UC START# *4A2CE15C003D_DESTR_BODY*
	//#UC END# *4A2CE15C003D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TemplateFunctions::BaseFunction
// выполнение функции шаблона
const std::string InternalFunctionBase::execute (
	const TemplateFunctions::FunctionParams& params
	, Base::AbstractTemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFBAB0285_4A2CE15C003D*
	return this->execute_impl (params, dynamic_cast<TemplatePainter*> (painter));
	//#UC END# *4A2DFBAB0285_4A2CE15C003D*
}
} // namespace BaseFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

