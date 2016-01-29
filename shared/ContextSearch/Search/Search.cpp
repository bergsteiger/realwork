////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Search/Search.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Search
//
// Интерфейсы и типы для алгоритмов контекстного поиска.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/Search/SearchFactories.h"

namespace ContextSearch {
namespace Search {

// factory interface wrapper for IWorker
IWorker* IWorkerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IWorkerFactoryManager::Singleton::instance ()->make ();
}

SplitRequest::SplitRequest (const SplitRequest& copy) 
//#UC START# *49CCFF74015A_COPY_CTOR_BASE_INIT*
//#UC END# *49CCFF74015A_COPY_CTOR_BASE_INIT*
{
	//#UC START# *49CCFF74015A_COPY_CTOR*
	context = copy.context;
	data = copy.data;
	//#UC END# *49CCFF74015A_COPY_CTOR*
}

SplitRequest& SplitRequest::operator = (const SplitRequest& copy) {
	//#UC START# *49CCFF74015A_ASSIGN_OP*
	context = copy.context;
	data = copy.data;
	//#UC END# *49CCFF74015A_ASSIGN_OP*
	return *this;
}

const char* CanceledByUser::uid () const /*throw ()*/ {
	return "000DE69F-2408-4D70-A6BC-81CF66AEEAAB";
}

const char* CanceledByUser::what () const throw () {
	//#UC START# *48D36F5E0075_WHAT_IMPL*
	return "CanceledByUser (Поиск прерван пользователем)";
	//#UC END# *48D36F5E0075_WHAT_IMPL*
}

// factory interface wrapper for IRequestView
IRequestView* IRequestViewFactory::make (
	DBComm::IDBCommunicator* comm
	, Morpho::Def::INormalizer* normalizer
	, AlgorithmSelector key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IRequestViewFactoryManager::Singleton::instance ()->make (comm, normalizer, key);
}


IRequestViewFactory::KeySet* IRequestViewFactory::keys () {
	return IRequestViewFactoryManager::keys ();
}

// factory interface wrapper for IAlgorithm
IAlgorithm* IAlgorithmFactory::make (
	IRequestView* view
	, DBComm::IProgress* progress
	, const AlgorithmProperties& properties
	, AlgorithmSelector key
) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IAlgorithmFactoryManager::Singleton::instance ()->make (view, progress, properties, key);
}


IAlgorithmFactory::KeySet* IAlgorithmFactory::keys () {
	return IAlgorithmFactoryManager::keys ();
}


const char* InvalidSpans::uid () const /*throw ()*/ {
	return "54F853ED-D060-4BA3-9BD4-13123B99CF7C";
}

const char* InvalidSpans::what () const throw () {
	//#UC START# *52948E9502C4_WHAT_IMPL*
	return "InvalidSpans (Невалидные спаны)";
	//#UC END# *52948E9502C4_WHAT_IMPL*
}

} // namespace Search
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

