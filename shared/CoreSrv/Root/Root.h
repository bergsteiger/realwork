////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/Root/Root.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Root
//
// ����� ������� ��������� ����������� ��������� GCM2 (��������� ������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_H__
#define __SHARED_CORESRV_ROOT_H__

#include "shared/Core/sys/std_inc.h"
#include "TAO/orbsvcs/orbsvcs/CosNamingC.h"
#include "TAO/tao/PortableInterceptorC.h"
#include "shared/Core/Root/Root.h"
#include "tao/ORB_Core.h"
#include "tao/PortableServer/PortableServerC.h"

namespace CoreSrv {
namespace Root {

class OrbAcsessor;
typedef ::Core::Var<OrbAcsessor> OrbAcsessor_var;
typedef ::Core::Var<const OrbAcsessor> OrbAcsessor_cvar;
// ��������� ������� � ������ � �������� ORB-�
class OrbAcsessor
	: virtual public ::Core::IObject
{
public:
	// �������� ORB
	virtual CORBA::ORB& get_main_orb () const = 0;

	// ������� ������ ��������� Name Service-�
	virtual CosNaming::NamingContext& get_ns_root () const = 0;

	// ������ �������� ��������� PICurrent
	virtual PortableInterceptor::Current& get_pi_current () const = 0;

	// ������� POA
	virtual PortableServer::POA& get_root_poa () const = 0;
};

class CorbaLibHome;
typedef ::Core::Var<CorbaLibHome> CorbaLibHome_var;
typedef ::Core::Var<const CorbaLibHome> CorbaLibHome_cvar;
// ��������� ������� ���������� ����������. ��������� ������� ������������ ������� � ��������� ORB-�
class CorbaLibHome
	: virtual public Core::Root::LibHome
{
public:
	// ������ ������������� ORB-� (��� ����������� �������������)
	virtual PortableInterceptor::ORBInitializer* get_orb_initializer () const = 0;

	// ������ � �������� �������������� ORB-�
	virtual const OrbAcsessor& get_orb_facet () const = 0;
	virtual OrbAcsessor& get_orb_facet () = 0;
};

} // namespace Root
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
