////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Tips/Tips.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// ����� ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/Tips.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/TipsFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for TipsManager
TipsManager* TipsManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return TipsManagerFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

