////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::KPageToolLib::ActionsImpl::SourceFileHelper
//
// ��� ������ � ������ ������ � ���� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SOURCEFILEHELPER_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SOURCEFILEHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/ActionsImpl.h"

namespace KPageToolLib {
namespace ActionsImpl {

// ��� ������ � ������ ������ � ���� ������
class SourceFileHelper {
	SET_OBJECT_COUNTER (SourceFileHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������ ������ ��� ������
	static int read_as_char_vector (CharVector& str);

	// ������ �� ����� �� ��������, � ������ ������ ���������� �� ����
	static int read_as_string (std::string& str);

	// ����� str � ���� �� ��������, � ������ ������ ���������� �� ����.
	static int write (const char* str);

}; // class SourceFileHelper

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SOURCEFILEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

