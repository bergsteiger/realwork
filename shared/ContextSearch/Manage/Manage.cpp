////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Manage/Manage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Manage
//
// Интерфейсы и типы для менеджеров поисковых алгоритмов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Manage/Manage.h"
#include "shared/ContextSearch/Manage/ManageFactories.h"

namespace ContextSearch {
namespace Manage {

// factory interface wrapper for IRequestTransformer
IRequestTransformer* IRequestTransformerFactory::make (
	Morpho::Def::INormalizer* normalizer
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IRequestTransformerFactoryManager::Singleton::instance ()->make (normalizer);
}

// factory interface wrapper for ISynManager
ISynManager* ISynManagerFactory::make (
	Morpho::Def::INormalizer* normalizer
	, DBComm::IDBCommunicator* comm
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ISynManagerFactoryManager::Singleton::instance ()->make (normalizer, comm);
}

// factory interface wrapper for IQuery
IQuery* IQueryFactory::make (
	const Env& in
	, DBComm::IDBCommunicator* comm
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IQueryFactoryManager::Singleton::instance ()->make (in, comm);
}


const char* InvalidQuery::uid () const /*throw ()*/ {
	return "1491C7A2-789E-430B-B790-4A650EA7E6F3";
}

const char* InvalidQuery::what () const throw () {
	//#UC START# *51F928F700EE_WHAT_IMPL*
	return "InvalidQuery (Невалидный запрос)";
	//#UC END# *51F928F700EE_WHAT_IMPL*
}

} // namespace Manage
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

