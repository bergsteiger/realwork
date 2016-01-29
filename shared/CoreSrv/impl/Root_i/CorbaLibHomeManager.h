////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/impl/Root_i/CorbaLibHomeManager.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::CorbaLibHomeManager
// ��������� ���������� ������ �������� ��� ��������� LibHomeManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_I_CORBALIBHOMEMANAGER_H__
#define __SHARED_CORESRV_ROOT_I_CORBALIBHOMEMANAGER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "TAO/tao/PortableInterceptorC.h"
#include "tao/ORB_Core.h"
#include "tao/PortableServer/PortableServerC.h"
#include "TAO/orbsvcs/orbsvcs/CosNamingC.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/impl/Root_i/StdLibHomeManager.h"
#include "shared/CoreSrv/Root/Root.h"

//#UC START# *457EA15F01D0_CUSTOM_INCLUDES*
//#UC END# *457EA15F01D0_CUSTOM_INCLUDES*

namespace CoreSrv {
namespace Root_i {

class CorbaLibHomeManager; // self forward Var
typedef ::Core::Var<CorbaLibHomeManager> CorbaLibHomeManager_var;
typedef ::Core::Var<const CorbaLibHomeManager> CorbaLibHomeManager_cvar;

class CorbaLibHomeManager_factory;

class CorbaLibHomeManager:
	virtual public Core::Root::LibHomeManager
	, virtual public Root::OrbAcsessor
	, virtual public Core::Root_i::StdLibHomeManager
{
	SET_OBJECT_COUNTER (CorbaLibHomeManager)
	friend class CorbaLibHomeManager_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ��������� ������� ��� ������� ������� ORB-�, �������� �������������� ������������� ������
	// (����� ��������������� ������)
	static void* orb_cycle_thread (void* arg);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CorbaLibHomeManager ();

	virtual ~CorbaLibHomeManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ������ ���� ����������� (�� ������ ����������) ����������� CORBA-��������
	virtual void cos_run ();

	// ������� � ������������� ������ �� ��� ����������� CORBA-�������
	virtual void cos_setup ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	CORBA::ORB_var m_main_orb;

	CosNaming::NamingContext_var m_name_service;

	PortableInterceptor::Current_var m_pi_current;

	PortableServer::POA_var m_root_poa;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Root::OrbAcsessor
	// �������� ORB
	virtual CORBA::ORB& get_main_orb () const;

	// implemented method from Root::OrbAcsessor
	// ������� ������ ��������� Name Service-�
	virtual CosNaming::NamingContext& get_ns_root () const;

	// implemented method from Root::OrbAcsessor
	// ������ �������� ��������� PICurrent
	virtual PortableInterceptor::Current& get_pi_current () const;

	// implemented method from Root::OrbAcsessor
	// ������� POA
	virtual PortableServer::POA& get_root_poa () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Core::Root::LibHomeManager
	// ������ ��������� �� ����������. �������������� ��� ��������� � ��������� �� ������������.
	virtual void execute () /*throw (Core::Root::InvalidParams, Core::Root::HomeManagerInitError)*/;

	// overloaded method from Core::Root::LibHomeManager
	// ������������� ������ ���������� � ����������� ��� ������� ������� (����������� �������
	// ������������������ ��������� �������������� � �������, �������� �� �����������!)
	virtual void finalize ();


//#UC START# *457EA15F01D0*
//#UC END# *457EA15F01D0*
}; // class CorbaLibHomeManager

} // namespace Root_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_I_CORBALIBHOMEMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
