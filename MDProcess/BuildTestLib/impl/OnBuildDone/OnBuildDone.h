////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::BuildTestLib::OnBuildDone
//
// ������������ ���� ��� ���� ������� �� ������� ��������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <fstream>
#include "MDProcess/ServerGate/Comm/Comm.h"
#include "MDProcess/ServerGate/Contents/Contents.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublish.h"


namespace BuildTestLib {
namespace OnBuildDone {

class LocalPageLogin;
typedef ::Core::Var<LocalPageLogin> LocalPageLogin_var;
typedef ::Core::Var<const LocalPageLogin> LocalPageLogin_cvar;
// ������ - ����� � � �� ���������-��������� � ����-�������
class LocalPageLogin
	: virtual public ::Core::IObject
{
public:
	// ������ �� ��������
	virtual ServerGate::Contents::KPage* get_p () const = 0;
};

/// factory interface for LocalPageLogin
class LocalPageLoginFactory {
public:
	// ������ ����-�����/������
	static LocalPageLogin* make (
		const std::string& login
		, const std::string& passwd
		, ServerGate::Contents::PageId page_id
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ����� ������������� ����������� ����� � �
struct TestKForm {
	// wiki �����, ����������� �� �������� �
	std::string wiki_text;
	// page labels, ����������� �� �������� �
	std::string page_labels;
};

} //namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

