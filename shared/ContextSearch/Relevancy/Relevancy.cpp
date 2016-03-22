////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/Relevancy/Relevancy.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Relevancy
//
// ���������� � ���� ��� ��������� ���������� �������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Relevancy/RelevancyFactories.h"

namespace ContextSearch {
namespace Relevancy {

// factory interface wrapper for IAlgorithm
IAlgorithm* IAlgorithmFactory::make (
	const Data& req_data
	, const AlgorithmProperties& properties
	, AlgorithmSelector key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IAlgorithmFactoryManager::Singleton::instance ()->make (req_data, properties, key);
}


IAlgorithmFactory::KeySet* IAlgorithmFactory::keys () {
	return IAlgorithmFactoryManager::keys ();
}

// factory interface wrapper for IBlocksAlgorithm
IBlocksAlgorithm* IBlocksAlgorithmFactory::make (
	const Data& req_data
	, const AlgorithmProperties& properties
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IBlocksAlgorithmFactoryManager::Singleton::instance ()->make (req_data, properties);
}

} // namespace Relevancy
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

