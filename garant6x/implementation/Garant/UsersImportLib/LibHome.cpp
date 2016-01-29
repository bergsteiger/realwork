////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garant6x::UsersImportLib
//
// модули утилиты импорта пользователей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/UsersImportLib/LibHome.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImportMain.h"

namespace UsersImportLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&UsersImportMain::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *481D6D4F010F_ENVIRONMENTS_CONFIG*
	//#UC END# *481D6D4F010F_ENVIRONMENTS_CONFIG*

	{
		UsersImport_i::FileReader_i_factory_var fctr = new UsersImport_i::FileReader_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UsersImport_i::Writer_i_factory_var fctr = new UsersImport_i::Writer_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		UsersImport_i::Parser_i_factory_var fctr = new UsersImport_i::Parser_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace UsersImportLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
