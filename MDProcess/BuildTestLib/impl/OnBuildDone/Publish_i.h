////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/Publish_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::Publish_i
// ��������� ���������� ������ �������� ��� ��������� Publish
//
// ������� ���������� ��������� ���������� ������ � �
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_PUBLISH_I_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_PUBLISH_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Contents/Contents.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublish.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublishS.h"

namespace BuildTestLib {
namespace OnBuildDone {

class Publish_i; // self forward Var
typedef ::Core::Var<Publish_i> Publish_i_var;
typedef ::Core::Var<const Publish_i> Publish_i_cvar;

class Publish_i_factory;

// ������� ���������� ��������� ���������� ������ � �
class Publish_i:
	virtual public POA_BuildTestLib::TestPublish::Publish
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (Publish_i)
	friend class Publish_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Publish_i ();

	virtual ~Publish_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������ ���������� ��������������� �����
	virtual void functional_part_to_K (TestResults::FunctionalTest* func_test, ServerGate::Contents::KPage* p) const;

	// ������ ����� ���������� �����
	virtual void generic_testsuite_to_K (
		const TestPublish::TestSuite& gen_test_suite
		, ServerGate::Contents::KPage* p
	) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from TestPublish::Publish
	// ������ ���������� ����� ����������� ������� (������ - � �)
	virtual void post (
		const TestPublish::TestSuite& result
		, ServerGate::Contents::PageId page_id
	) throw (
		CORBA::SystemException
	);
}; // class Publish_i

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_PUBLISH_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
