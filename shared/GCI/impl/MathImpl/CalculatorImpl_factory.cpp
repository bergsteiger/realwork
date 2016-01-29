////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MathImpl/CalculatorImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MathImpl::CalculatorImpl
//
// Реализация калькулятора, реализует простейшие выражения: сложение, умножение, вычитание,
// деление, группировка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MathImpl/CalculatorImpl_factory.h"
#include "shared/GCI/impl/MathImpl/CalculatorImpl.h"

namespace GCI {
namespace MathImpl {

CalculatorImpl_factory::CalculatorImpl_factory () {
}

void CalculatorImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Math::CalculatorFactoryManager::register_factory (this, priority);
}

const char* CalculatorImpl_factory::key () const {
	return "CalculatorImpl";
}

Math::Calculator* CalculatorImpl_factory::make () {
	CalculatorImpl_var ret = new CalculatorImpl ();
	return ret._retn ();
}

} // namespace MathImpl
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

