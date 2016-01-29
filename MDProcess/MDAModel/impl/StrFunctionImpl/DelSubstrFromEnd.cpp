////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromEnd
//
// ���������� ���������� ������� ���������� "_delsubstr_from_end"
// _delsubstr_from_end("<������>",n) - ������� n �������� � ����� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

namespace StrFunctionImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DelSubstrFromEnd::DelSubstrFromEnd ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE3E900D7_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE3E900D7_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CE3E900D7_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CE3E900D7_BODY*
}

DelSubstrFromEnd::~DelSubstrFromEnd () {
	//#UC START# *4A2CE3E900D7_DESTR_BODY*
	//#UC END# *4A2CE3E900D7_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string DelSubstrFromEnd::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CE3E900D7*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	std::string source_str = TemplatePainter::resolve_exp(params[0], painter);
	long symbols_count = boost::lexical_cast<long> (TemplatePainter::resolve_exp(params[1], painter));		
	long skip_symbols = source_str.size () - symbols_count;
	if (skip_symbols < 0) {//���� ������ �������� ������ ��� ���� - ������� ��� ������
		skip_symbols = source_str.size ();
	}		
	return source_str.substr (0, skip_symbols);
	//#UC END# *4A2CE18202C1_4A2CE3E900D7*
}
} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

