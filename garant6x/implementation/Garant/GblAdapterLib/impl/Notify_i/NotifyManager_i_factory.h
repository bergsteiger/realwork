////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/NotifyManager_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::NotifyManager_i
// �������� ���������� ������ ��������� NotifyManager ��� �������� NotifyManager_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFYMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFYMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for NotifyManager_i
class NotifyManager_i_factory: virtual public ::Core::RefCountObjectBase, virtual public NotifyManagerAbstractFactory {
public:
	NotifyManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	NotifyManager* make ();

};

typedef ::Core::Var<NotifyManager_i_factory> NotifyManager_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFYMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

