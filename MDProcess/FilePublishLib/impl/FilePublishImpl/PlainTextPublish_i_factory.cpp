////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainTextPublish_i
//
// конвертит файл в тест и публикует его
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i_factory.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i.h"

namespace FilePublishLib {
namespace FilePublishImpl {

PlainTextPublish_i_factory::PlainTextPublish_i_factory () {
}

void PlainTextPublish_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	FilePublish::PlainTextPublishFactoryManager::register_factory (this, priority);
}

const char* PlainTextPublish_i_factory::key () const {
	return "PlainTextPublish_i";
}

FilePublish::PlainTextPublish* PlainTextPublish_i_factory::make () {
	PlainTextPublish_i_var ret = new PlainTextPublish_i ();
	return ret._retn ();
}

} // namespace FilePublishImpl
} // namespace FilePublishLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

