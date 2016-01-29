////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::FilePublishLib
//
// читает содержимое файла и публикует его как результат теста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/FilePublishLib/LibHome.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i_factory.h"
#include "MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest_factory.h"

namespace FilePublishLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4C88D9250093_ENVIRONMENTS_CONFIG*
	//#UC END# *4C88D9250093_ENVIRONMENTS_CONFIG*

	{
		FilePublishImpl::PlainTextPublish_i_factory_var fctr = new FilePublishImpl::PlainTextPublish_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		FilePublishImpl::PlainText2FunctionalTest_factory_var fctr = new FilePublishImpl::PlainText2FunctionalTest_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace FilePublishLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
