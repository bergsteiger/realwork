
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/BuildTestLib/TestPublish/TestPublish.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::BuildTestLib::TestPublish
//
// ����������� ���������� ����������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_TESTPUBLISH_H__
#define __MDPROCESS_BUILDTESTLIB_TESTPUBLISH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublishC.h"
#include <vector>
#include "MDProcess/ServerGate/Contents/Contents.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"

namespace BuildTestLib {
namespace TestPublish {

/// factory interface for Publish
class PublishFactory {
public:
	// make
	static Publish* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<PublishFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

} // namespace TestPublish
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_TESTPUBLISH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

