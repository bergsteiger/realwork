////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedDir.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NormolizedDir
//
// ���������� ���������� ������� ���������� "_normolized_dir".
// _normolized_dir(�������� ���������,��������), ��������:
// %f_normolized_dir(dll.h,C)
// - ������� ���� ��������� ��� �������� ��������, ������������ ���� � ����� ��������� ��������
// ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedDir.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NormolizedDir::NormolizedDir ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEBE3020D_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEBE3020D_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CEBE3020D_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CEBE3020D_BODY*
}

NormolizedDir::~NormolizedDir () {
	//#UC START# *4A2CEBE3020D_DESTR_BODY*
	//#UC END# *4A2CEBE3020D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string NormolizedDir::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CEBE3020D*
	if (params.size () < 2) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 2, params.size ());
	}
	AbstractDumperBase::GenID tmp = AbstractDumperBase::s_current_map;
	AbstractDumperBase::s_current_map = TemplatePainter::resolve_exp(params[0], painter);
		
	std::string::const_iterator it = params[1].begin();		
	const AbstractDumperBase* adb = painter->get_dumper_by_template(it, params[1].end ());
	
	std::string target_path;
	std::string target_root;
	if (adb) {
		target_path = adb->create_relative_dir_name();
		target_root = adb->get_root_dir (false);
	}
	
	AbstractDumperBase::s_current_map = tmp;

	if (target_path != "") {
		return painter->get_main_scope ()->create_normolized_path (target_path.data(), target_root.data());
	} else {
		return std::string ();
	}
	//#UC END# *4A2CE18202C1_4A2CEBE3020D*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

