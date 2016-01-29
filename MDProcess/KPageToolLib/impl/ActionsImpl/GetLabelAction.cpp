////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetLabelAction.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetLabelAction
//
// �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetLabelAction.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GetLabelAction::GetLabelAction ()
//#UC START# *48E49C08024A_48E49C5D02FE_4BF3BDA30054_BASE_INIT*
//#UC END# *48E49C08024A_48E49C5D02FE_4BF3BDA30054_BASE_INIT*
{
	//#UC START# *48E49C08024A_48E49C5D02FE_4BF3BDA30054_BODY*
	//#UC END# *48E49C08024A_48E49C5D02FE_4BF3BDA30054_BODY*
}

GetLabelAction::~GetLabelAction () {
	//#UC START# *4BF3BDA30054_DESTR_BODY*
	//#UC END# *4BF3BDA30054_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Actions::KPageAction
// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
// (����������� � ���������� ����).
// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
int GetLabelAction::execute (ServerGate::Contents::KPage* page) {
	//#UC START# *48E49D8D0020_4BF3BDA30054*
	GDS_ASSERT_MSG(page != 0,("Error page can't be NULL"));
	CORBA::String_var labels_string = page->get_labels ();
	if (labels_string.in ()) {
		int ret = SourceFileHelper::write (labels_string.in ());
		if (ret != 0) {
			return ret;
		}
	}
	return 0;
	//#UC END# *48E49D8D0020_4BF3BDA30054*
}
} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

