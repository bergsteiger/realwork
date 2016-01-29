////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/impl/Root_i/Root_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::CoreSrv::Root_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_I_H__
#define __SHARED_CORESRV_ROOT_I_H__

#include "shared/Core/sys/std_inc.h"
#include "TAO/tao/PortableInterceptorC.h"
#include "tao/ORB_Core.h"
#include "tao/PortableServer/PortableServerC.h"
#include "TAO/orbsvcs/orbsvcs/CosNamingC.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/impl/Root_i/Root_i.h"
#include "shared/CoreSrv/Root/Root.h"
#include "shared/Core/Params/Params.h"


namespace CoreSrv {
namespace Root_i {

class CorbaLibHomeLocal;
typedef ::Core::Var<CorbaLibHomeLocal> CorbaLibHomeLocal_var;
typedef ::Core::Var<const CorbaLibHomeLocal> CorbaLibHomeLocal_cvar;
// ��������� ���������, ����� ��� �������������� ����������������, ��������� ������ ����������
// ����������.
class CorbaLibHomeLocal
	: virtual public Core::Root_i::LibHomeLocal
	, virtual public Root::CorbaLibHome
{
public:
	// ������ � �������� �������������� ORB-�
	virtual void set_orb_facet (Root::OrbAcsessor* orb_facet) = 0;

	// � ���� ���-��� ������ ����� ���� ����������������� � NS ��� ������ �������, ������������
	// �����������
	virtual void publish_all_event_channel () = 0;

	// � ���� ���-��� ������ ����� ���� ����������������� � NS ��� ������������� ��������� �������
	virtual void publish_all_servers_factories () const = 0;
};

} //namespace Root_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

