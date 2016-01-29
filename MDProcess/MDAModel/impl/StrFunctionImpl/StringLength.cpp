////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringLength.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringLength
//
// ���������� ���������� ������� ���������� _string_length
// _string_length(�������) - ����� ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringLength.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StringLength::StringLength ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE6DB00A0_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE6DB00A0_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE6DB00A0_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE6DB00A0_BODY*
}

StringLength::~StringLength () {
	//#UC START# *4A2CE6DB00A0_DESTR_BODY*
	//#UC END# *4A2CE6DB00A0_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string StringLength::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE6DB00A0*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	std::string source_str = TemplatePainter::resolve_exp(params[0], painter);		
	std::string ret = boost::lexical_cast<std::string> (source_str.length ());
	return ret;
	//#UC END# *4A2CE18202C1_4A2CE6DB00A0*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

