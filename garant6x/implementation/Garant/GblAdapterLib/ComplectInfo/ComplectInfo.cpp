////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfo.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Interface::Category>> garant6x::GblAdapterLib::ComplectInfo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfo.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfoFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for ComplectInfo
ComplectInfo* ComplectInfoFactory::make () /*throw (Core::Root::NoActiveFactory)*/ {
	return ComplectInfoFactoryManager::Singleton::instance()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

