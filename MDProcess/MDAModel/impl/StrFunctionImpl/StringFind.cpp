////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringFind.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringFind
//
// ���������� ���������� ������� ���������� _string_find
// _string_find(�������,����������) - ���� ��������� � ������, ���������� ��������� �������, ����
// ��������� �� ������� - ���������� -1
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringFind.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StringFind::StringFind ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE5AC037A_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE5AC037A_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE5AC037A_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE5AC037A_BODY*
}

StringFind::~StringFind () {
	//#UC START# *4A2CE5AC037A_DESTR_BODY*
	//#UC END# *4A2CE5AC037A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string StringFind::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE5AC037A*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string str = TemplatePainter::resolve_exp(params[0], painter);
	std::string substr = TemplatePainter::resolve_exp(params[1], painter);
	
	std::string::size_type pos = str.find (substr);
	std::string res ("-1");
	if (pos != std::string::npos) {		
		res = boost::lexical_cast<std::string> (pos);
	}
	return res;
	//#UC END# *4A2CE18202C1_4A2CE5AC037A*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

