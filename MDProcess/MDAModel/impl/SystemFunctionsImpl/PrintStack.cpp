////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/PrintStack.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::PrintStack
//
// %f_print_stack("������") - ������� ���� ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/PrintStack.h"

namespace SystemFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PrintStack::PrintStack ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B2F858E02D3_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B2F858E02D3_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4B2F858E02D3_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4B2F858E02D3_BODY*
}

PrintStack::~PrintStack () {
	//#UC START# *4B2F858E02D3_DESTR_BODY*
	//#UC END# *4B2F858E02D3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
const std::string PrintStack::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4B2F858E02D3*
	std::string mess;
	if (!params.empty ()) {
		mess = "(" + TemplatePainter::resolve_exp (params[0], painter) + ") ";
	}

	mess += "���� ������ �������:\r\n\t ";

	Core::Aptr<GCL::StrVector> functions_stack (painter->get_stack ());
	if (!functions_stack.is_nil () && !functions_stack->empty ()) {
		mess += GCL::join (*functions_stack.ptr (), "\r\n\t ");
	} else {
		mess += "EMPTY";
	}

	mess += "\r\n";

	const AbstractDumperBase* adb = painter->get_owner () ? painter->get_owner () : painter->get_main_scope ();

	if (adb) {
		adb->write_template_warning_log(mess.c_str ());
	} else {
		GDS_ASSERT_MSG(adb !=0,("������� �������� ������� %%f_warning ��� 0-�� %%S � %%B"));
		throw Base::FatalError ("������� �������� ������� %f_print_stack ��� 0-�� %S � %B");
	}

	return std::string ();
	//#UC END# *4A2CE18202C1_4B2F858E02D3*
}
} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

