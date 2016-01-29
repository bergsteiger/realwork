////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Warning.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Warning
//
// ���������� ���������� ������� ���������� "_warning"
// _warning(����������) - ������� ��������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Warning.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Warning::Warning ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CED2C0317_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CED2C0317_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CED2C0317_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CED2C0317_BODY*
}

Warning::~Warning () {
	//#UC START# *4A2CED2C0317_DESTR_BODY*
	//#UC END# *4A2CED2C0317_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string Warning::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CED2C0317*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}

	std::string message = TemplatePainter::resolve_exp(params[0], painter);
	const AbstractDumperBase* adb = painter->get_owner () ? painter->get_owner () : painter->get_main_scope ();

	if (adb) {
		adb->write_template_warning_log(message.c_str ());
	} else {
		GDS_ASSERT_MSG(adb !=0,("������� �������� ������� %%f_warning ��� 0-�� %%S � %%B"));
		throw Base::FatalError ("������� �������� ������� %f_warning ��� 0-�� %S � %B");
	}

	return std::string ();
	//#UC END# *4A2CE18202C1_4A2CED2C0317*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

