////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainText2FunctionalTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest_factory.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest.h"

namespace FilePublishLib {
namespace FilePublishImpl {

PlainText2FunctionalTest_factory::PlainText2FunctionalTest_factory () {
}

void PlainText2FunctionalTest_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FilePublish::PlainText2FunctionalTestFactoryManager::register_factory (this, priority);
}

const char* PlainText2FunctionalTest_factory::key () const {
	return "PlainText2FunctionalTest";
}

FilePublish::PlainText2FunctionalTest* PlainText2FunctionalTest_factory::get () {
	PlainText2FunctionalTest_var ret = new PlainText2FunctionalTest ();
	return ret._retn ();
}

} // namespace FilePublishImpl
} // namespace FilePublishLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

