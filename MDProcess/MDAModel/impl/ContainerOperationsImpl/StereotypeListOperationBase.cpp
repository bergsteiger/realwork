////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::StereotypeListOperationBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.h"

namespace ContainerOperationsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StereotypeListOperationBase::StereotypeListOperationBase ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B753AC2007E_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B753AC2007E_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B753AC2007E_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B753AC2007E_BODY*
}

StereotypeListOperationBase::~StereotypeListOperationBase () {
	//#UC START# *4B753AC2007E_DESTR_BODY*
	//#UC END# *4B753AC2007E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string StereotypeListOperationBase::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4B753AC2007E*
	TemplatePainter::ContainerDumper* container = dynamic_cast<TemplatePainter::ContainerDumper*> (const_cast<AbstractDumperBase*> (self));
	if (!container) {
		throw Base::FatalError ("функция применима только к переменным типа ""список""");
	}

	return this->execute_impl2 (container, params, painter);
	//#UC END# *4A2DFD7B0291_4B753AC2007E*
}
} // namespace ContainerOperationsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

