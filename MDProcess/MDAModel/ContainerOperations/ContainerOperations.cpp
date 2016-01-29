////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/ContainerOperations/ContainerOperations.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::ContainerOperations
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperationsFactories.h"

namespace ContainerOperations {

// factory interface wrapper for ContainerTemplateOperations
ContainerTemplateOperations& ContainerTemplateOperationsFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ContainerTemplateOperationsFactoryManager::Singleton::instance ()->get ();
}

} // namespace ContainerOperations

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

