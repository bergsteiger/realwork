////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/FoldersHelper/ContentChecker.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::FoldersHelper::ContentChecker
// ���� ���������� ���������� ������ ContentChecker
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/FoldersHelper/ContentChecker.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {
namespace ContentChecker {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// �������� �������� �� �������������
bool check_content (Containers::Content* content) {
	//#UC START# *45F8045C03D2*
	// ��� ���, �������� ���������� � ������ ��� ���������� � ����� - ��� ����� �������� ������� ��� �� ������� � ������������� �������
	return content != NULL;
	// ����� ����

	if (!content) {
		return false;
	}

	try {
		Containers::Content_var valid_content = 
			ApplicationHelper::instance ()->get_cached_folders ()->id_to_content (content->id ());
		return true;
	} catch (...) {
	}

	return false;
	//#UC END# *45F8045C03D2*
}

// �������� ���������� �� ������� (����� �� ������)
bool check_server_content (Containers::Content* content) {
	//#UC START# *45F804B50161*
	if (!content) {
		return false;
	}
	try {
		Containers::Content_var valid_content = 
			ApplicationHelper::instance ()->get_cached_folders ()->id_to_content (content->id ());
		return true;
	} catch (...) {
	}
	return false;
	//#UC END# *45F804B50161*
}

} // namespace ContentChecker
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

