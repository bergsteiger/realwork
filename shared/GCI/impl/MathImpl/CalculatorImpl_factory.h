////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/MathImpl/CalculatorImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MathImpl::CalculatorImpl
// Заголовк реализации фабрик интерфеса Calculator для серванта CalculatorImpl
//
// Реализация калькулятора, реализует простейшие выражения: сложение, умножение, вычитание,
// деление, группировка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MATHIMPL_CALCULATORIMPL_FCTR_H__
#define __SHARED_GCI_MATHIMPL_CALCULATORIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/Math/MathFactories.h"

namespace GCI {
namespace MathImpl {

/// Interface-factory implementation for CalculatorImpl
class CalculatorImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Math::CalculatorAbstractFactory
{
public:
	CalculatorImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Math::Calculator* make ();

};

typedef ::Core::Var<CalculatorImpl_factory> CalculatorImpl_factory_var;

} // namespace MathImpl
} // namespace GCI


#endif //__SHARED_GCI_MATHIMPL_CALCULATORIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

