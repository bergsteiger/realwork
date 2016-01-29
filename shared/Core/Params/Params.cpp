////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/Params/Params.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Params
//
// ����� ��� ������ � ����������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/Params/Params.h"
#include "shared/Core/Params/ParamsFactories.h"

namespace Core {

// factory interface wrapper for ParamManager
ParamManager& ParamManagerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ParamManagerFactoryManager::Singleton::instance ()->get ();
}

ParamManager* ParamManagerFactory::make (
	const std::string& args
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ParamManagerFactoryManager::Singleton::instance ()->make (args);
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

