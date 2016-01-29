////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetTextAction
//
// ���������� ������� GET. ������ ����� �������� � � ���������� ��� � ����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GetTextAction::GetTextAction ()
//#UC START# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BASE_INIT*
//#UC END# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BASE_INIT*
{
	//#UC START# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BODY*
	//#UC END# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BODY*
}

GetTextAction::~GetTextAction () {
	//#UC START# *48E49C9802F4_DESTR_BODY*
	//#UC END# *48E49C9802F4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Actions::KPageAction
// ��������� �������� ��� ���������. ���������� 0 - � ������ �����. 1 - � ������ ����� ������
// (����������� � ���������� ����).
// page - ���������� �������� ��� ������� ����� ��������� ��������. page �� ����� ������ � Var!
int GetTextAction::execute (ServerGate::Contents::KPage* page) {
	//#UC START# *48E49D8D0020_48E49C9802F4*
	GDS_ASSERT_MSG(page != 0,("Error page can't be NULL"));
	CORBA::String_var page_text = page->get_wiki_text ();
	if (page_text.in ()) {
		int ret = SourceFileHelper::write (page_text.in ());
		if (ret != 0) {
			return ret;
		}
	}
	return 0;
	//#UC END# *48E49D8D0020_48E49C9802F4*
}
} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

