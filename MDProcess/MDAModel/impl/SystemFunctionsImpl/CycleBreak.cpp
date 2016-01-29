////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::CycleBreak
//
// ���������� �������:
// _cycle_break() - ��������� ������� ����, ���� ������� ������� ��� ����� - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
// by <<friend>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CycleBreak::CycleBreak ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4BD6DC17000F_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4BD6DC17000F_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4BD6DC17000F_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4BD6DC17000F_BODY*
}

CycleBreak::~CycleBreak () {
	//#UC START# *4BD6DC17000F_DESTR_BODY*
	//#UC END# *4BD6DC17000F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string CycleBreak::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4BD6DC17000F*
	if (!painter->dereference ()) {
		throw TemplatePainter::TemplateBadSyntax ("�������� ����� ���� ������� ������ ������ �����");
	}
	
	throw TemplatePainter::TemplateCycleIterationBreak ();

	return std::string ();
	//#UC END# *4A2CE18202C1_4BD6DC17000F*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

