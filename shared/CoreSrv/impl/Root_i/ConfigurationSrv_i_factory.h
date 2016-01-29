////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/impl/Root_i/ConfigurationSrv_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::ConfigurationSrv_i
// �������� ���������� ������ ���������  ��� �������� ConfigurationSrv_i
//
// ��������� ������� (���� ���������� ��������� ����������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_ROOT_I_CONFIGURATIONSRV_I_FCTR_H__
#define __SHARED_CORESRV_ROOT_I_CONFIGURATIONSRV_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/Root/RootFactories.h"
#include "shared/CoreSrv/impl/Root_i/Root_i.h"

namespace CoreSrv {
namespace Root_i {

/// Interface-factory implementation for ConfigurationSrv_i
class ConfigurationSrv_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Core::Root::ConfigurationAbstractFactory
{
public:
	ConfigurationSrv_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Core::Root::Configuration* get ();

};

typedef ::Core::Var<ConfigurationSrv_i_factory> ConfigurationSrv_i_factory_var;

} // namespace Root_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_ROOT_I_CONFIGURATIONSRV_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

