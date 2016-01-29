////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetOverloadSelectType.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetOverloadSelectType
//
// %S%f_set_overload_select_type(all|include|exclude) - ������������� ��� ��������� ���
// ���������������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetOverloadSelectType.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClass.h"
#include "MDProcess/MDAModel/Base/Base.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetOverloadSelectType::SetOverloadSelectType ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F5746003D_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F5746003D_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A3F5746003D_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A3F5746003D_BODY*
}

SetOverloadSelectType::~SetOverloadSelectType () {
	//#UC START# *4A3F5746003D_DESTR_BODY*
	//#UC END# *4A3F5746003D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string SetOverloadSelectType::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A3F5746003D*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		std::string target = TemplatePainter::resolve_exp (params[0], painter);		

		const AbstractDumperBase::Template& tpl = rad->get_template ();
		if (!tpl.has_derived_impl) {
			throw Base::FatalError ("������ �� ��������� �������� IMPLEMENT_SELECT_TYPE");
		}
		std::string select_type = TemplatePainter::resolve_exp (params[0], painter);

		if (
			select_type != Base::ALL 
			&& select_type != Base::INCLUDE
			&& select_type != Base::EXCLUDE
		) {
			throw Base::FatalError ("�������� �������� �������, ������ ���� all|include|exclude");
		}
		
		std::string tool_name (_bstr_t (TOOL_NAME));
		std::string prop_name (_bstr_t (PROP_OVERLOAD_SELECT_TYPE));

		rad->set_temporary_property (tool_name, prop_name, select_type);
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A3F5746003D*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

