////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/MathImpl/CalculatorImpl_Rule.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCI::MathImpl::CalculatorImpl::Rule
//
// ������� ������� ��������������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MathImpl/CalculatorImpl.h"

//#UC START# *4766402B03DF_CUSTOM_INCLUDES*
//#UC END# *4766402B03DF_CUSTOM_INCLUDES*

namespace GCI {
namespace MathImpl {
class CalculatorImpl;
//#UC START# *4766402B03DF*
//#UC END# *4766402B03DF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// �����������, calculator - ������ ����������� �������������� ��������
CalculatorImpl::Rule::Rule (CalculatorImpl* calculator)
//#UC START# *476640B50392_BASE_INIT*
: m_calculator (calculator)
//#UC END# *476640B50392_BASE_INIT*
{
	//#UC START# *476640B50392_BODY*
	//#UC END# *476640B50392_BODY*
}

CalculatorImpl::Rule::~Rule () {
	//#UC START# *4766402B03DF_DESTR_BODY*
	//#UC END# *4766402B03DF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ���������� ������, ����������� �������������� ��������
const CalculatorImpl& CalculatorImpl::Rule::get_calculator () const {
	//#UC START# *47C4F59903AC*
	return *m_calculator;
	//#UC END# *47C4F59903AC*
}

} // namespace MathImpl
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

