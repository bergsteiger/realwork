////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ExistsInList
//
// ���������� ���������� ������� ���������� _exists_in_list.
// _exists_in_list (�������������, ���������) - ��������� ������� � ������ � ��������
// ��������������� �������� (����� ���� ������� ������ ��� ������), ���������� true ��� false
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ExistsInList.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace VarFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExistsInList::ExistsInList ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDD1F00DD_BODY*
}

ExistsInList::~ExistsInList () {
	//#UC START# *4A2CDD1F00DD_DESTR_BODY*
	//#UC END# *4A2CDD1F00DD_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string ExistsInList::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDD1F00DD*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	TemplateFunctions::InternalFunction& func = TemplateFunctions::InternalFunctionFactory::make ("_count_in_list");

	std::string count = func.execute (params, painter);
	return count == "0" ? "false" : "true";
	//#UC END# *4A2CE18202C1_4A2CDD1F00DD*
}
} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

