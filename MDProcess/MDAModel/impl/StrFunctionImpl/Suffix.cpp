////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Suffix.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Suffix
//
// ������ ������:
// %f_suffix(������,�������) - ���� ������ ������������� ��������� - ���������� �������, �����
// ���������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Suffix.h"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Suffix::Suffix ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE74F00FF_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE74F00FF_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE74F00FF_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE74F00FF_BODY*
}

Suffix::~Suffix () {
	//#UC START# *4A2CE74F00FF_DESTR_BODY*
	//#UC END# *4A2CE74F00FF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string Suffix::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE74F00FF*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string source_str = TemplatePainter::resolve_exp (params[0], painter);
	std::string suffix = TemplatePainter::resolve_exp (params[1], painter);

	if (GCL::end_with (source_str.c_str (), suffix.c_str ())) {
		return suffix;
	}
	return source_str;
	//#UC END# *4A2CE18202C1_4A2CE74F00FF*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

