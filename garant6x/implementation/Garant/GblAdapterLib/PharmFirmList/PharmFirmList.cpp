////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// ������ ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmListFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for PharmFirmListEntry
PharmFirmListEntry* PharmFirmListEntryFactory::make (
	GCD::ObjectID id
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PharmFirmListEntryFactoryManager::Singleton::instance ()->make (id);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

