////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/impl/Root_i/StdLibHomeManager.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::StdLibHomeManager
// ��������� ���������� ������ �������� ��� ��������� LibHomeManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_H__
#define __SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_H__

#include "ace/ACE.h"
#include <vector>
#include "shared/Core/data/unsorted_containers.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/impl/Root_i/Root_i.h"

namespace Core {
namespace Root_i {

class StdLibHomeManager; // self forward Var
typedef ::Core::Var<StdLibHomeManager> StdLibHomeManager_var;
typedef ::Core::Var<const StdLibHomeManager> StdLibHomeManager_cvar;

class StdLibHomeManager_factory;

class StdLibHomeManager:
	virtual public Root::LibHomeManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StdLibHomeManager)
	friend class StdLibHomeManager_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:
	// ������ ��������
	typedef std::vector < LibHomeLocal* > LibHomes;

private:
	// ������ ��������������� ������
	typedef boost::unordered_set <Root::ThreadInitializer_var
		, Core::hash<Root::ThreadInitializer_var>
		, Core::equal_to<Root::ThreadInitializer_var> > ThreadInitializers;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StdLibHomeManager ();

	virtual ~StdLibHomeManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// for_all == false : ���� ������ ���� ���������� ����� ������ status - �� ������������ true,
	// ����� false
	// for_all == true : ���� ��� ���������� ����� ������ status - �� ������������ true, ����� false
	virtual bool check_libs_status (Root::ExecutorStatus status, bool for_all) const;

	// ������ �� ���������� ���� ������������������ ����� ���������
	virtual void execute_all_libhomes () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/;

	// ���������� ������� ������������������ ��������� (����������� �������������� � �������, ��������
	// �� �����������!)
	virtual void finalize_all_libhomes ();

	// ���������� ��������� ����������������� ����� ���������
	LibHomes& get_lib_homes ();

	// ���������������� ��� ������������������ ���� ���������
	virtual void initialize_all_libhomes ();

	// ���������������� ��� ������� ���� ����� ���������
	virtual void registrate_all_factories ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	LibHomes m_lib_homes;

	mutable ThreadInitializers m_thread_initializers;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Root::LibHomeManager
	// ��� ������� ������������������� ���� ���������� ��������� �������� ����������, ���������� true,
	// ���� ��� �������� ������ �������.
	virtual bool check_params () const;

	// implemented method from Root::LibHomeManager
	// ������ ��������� �� ����������. �������������� ��� ��������� � ��������� �� ������������.
	virtual void execute () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/;

	// implemented method from Root::LibHomeManager
	// ������������� ������ ���������� � ����������� ��� ������� ������� (����������� �������
	// ������������������ ��������� �������������� � �������, �������� �� �����������!)
	virtual void finalize ();

	// implemented method from Root::LibHomeManager
	// ��������� ��-������������� �������� ������ ����������� ������� ������������������
	// ���������������
	virtual void finalize_thread () const;

	// implemented method from Root::LibHomeManager
	// ��������� ������������� �������� ������ ����������� ������� ������������������ ���������������
	virtual void init_thread () const;

	// implemented method from Root::LibHomeManager
	// ������� �������� ���������� ��� ���� ������������������ ����� ���������
	virtual void print_usage () const;

	// implemented method from Root::LibHomeManager
	// ������������ ��������� � ���������
	virtual void registrate_lib_home (Root::LibHome* lib);

	// implemented method from Root::LibHomeManager
	// ������������ ���������������� ������������� ������
	virtual void registrate_thread_initializer (Root::ThreadInitializer* ti);

	// implemented method from Root::LibHomeManager
	// ���� ���������� ���� ������������ (� �� �������� �������), ���������� 0, ���� ������ ����
	// ��������� ��� ������ (�� ���� �� ������������ �� �������� ������ ES_ERROR)
	virtual int wait_all () const;
}; // class StdLibHomeManager

} // namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
