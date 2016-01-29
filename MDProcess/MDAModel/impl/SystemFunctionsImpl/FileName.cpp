////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileName.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileName
//
// %f_file_name(���� � �����) - ��������� ��� ����� �� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FileName.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FileName::FileName ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B4F445201A1_BODY*
}

FileName::~FileName () {
	//#UC START# *4B4F445201A1_DESTR_BODY*
	//#UC END# *4B4F445201A1_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string FileName::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4B4F445201A1*
	return FilePathBase::execute_impl (params, painter, FilePathBase::PT_NAME);
	//#UC END# *4A2CE18202C1_4B4F445201A1*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

