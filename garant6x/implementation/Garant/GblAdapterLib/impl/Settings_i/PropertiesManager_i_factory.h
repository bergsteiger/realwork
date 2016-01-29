////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::PropertiesManager_i
// �������� ���������� ������ ��������� PermanentSettingsManager ��� �������� PropertiesManager_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_PROPERTIESMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_PROPERTIESMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PropertiesManager_i
class PropertiesManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public PermanentSettingsManagerAbstractFactory
{
public:
	PropertiesManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	PermanentSettingsManager* make ();

};

typedef ::Core::Var<PropertiesManager_i_factory> PropertiesManager_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_PROPERTIESMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

