////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Authorization_i
// �������� ���������� ������ ��������� Authorization ��� �������� Authorization_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_I_AUTHORIZATION_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_START_I_AUTHORIZATION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Start_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Authorization_i
class Authorization_i_factory: virtual public ::Core::RefCountObjectBase, virtual public AuthorizationAbstractFactory {
public:
	Authorization_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Authorization* make () /*throw (XMLImportRunning)*/;

};

typedef ::Core::Var<Authorization_i_factory> Authorization_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_START_I_AUTHORIZATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

