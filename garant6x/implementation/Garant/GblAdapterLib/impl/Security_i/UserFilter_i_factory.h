////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserFilter_i
// �������� ���������� ������ ��������� UserFilter ��� �������� UserFilter_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/Security_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for UserFilter_i
class UserFilter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public UserFilterAbstractFactory {
public:
	UserFilter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	UserFilter* make ();

};

typedef ::Core::Var<UserFilter_i_factory> UserFilter_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

