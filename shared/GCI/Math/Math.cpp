////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/Math/Math.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::Math
//
// ����� ����������� ��������� � ��������������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/Math/Math.h"
#include "shared/GCI/Math/MathFactories.h"

namespace GCI {
namespace Math {


const char* BadExpression::uid () const /*throw ()*/ {
	return "1498C1F2-5910-4D80-8B74-E87C7681808C";
}

const char* BadExpression::what () const throw () {
	//#UC START# *476635710293_WHAT_IMPL*
	return "BadExpression (�������� ���������, ��������� ��� ������������� ��������� �������������� ���������.)";
	//#UC END# *476635710293_WHAT_IMPL*
}

// factory interface wrapper for Calculator
Calculator& CalculatorFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CalculatorFactoryManager::Singleton::instance ()->make ();
}

} // namespace Math
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

