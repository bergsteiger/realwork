////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/FilePublish/FilePublish.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::FilePublishLib::FilePublish
//
// публикация файла как результата теста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublish.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublishFactories.h"

namespace FilePublishLib {
namespace FilePublish {

// factory interface wrapper for PlainTextPublish
PlainTextPublish* PlainTextPublishFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PlainTextPublishFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for PlainText2FunctionalTest
PlainText2FunctionalTest& PlainText2FunctionalTestFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PlainText2FunctionalTestFactoryManager::Singleton::instance ()->get ();
}

} // namespace FilePublish
} // namespace FilePublishLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

