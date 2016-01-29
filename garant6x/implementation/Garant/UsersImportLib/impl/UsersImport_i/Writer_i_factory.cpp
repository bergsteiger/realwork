////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Writer_i
//
// передаёт на сервер заданные данные для создания пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i.h"

namespace UsersImport_i {

Writer_i_factory* Writer_i_factory::s_instance = 0;

Writer_i_factory::Writer_i_factory () {
}

void Writer_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UsersImport::DataWriterFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* Writer_i_factory::key () const {
	return "Writer_i";
}

UsersImport::DataWriter* Writer_i_factory::make () {
	Writer_i_var ret = new Writer_i ();
	return ret._retn ();
}

Writer_i* Writer_iServantFactory::make () {
	if (Writer_i_factory::s_instance) {
		return dynamic_cast<Writer_i*>(Writer_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("UsersImportLib::UsersImport_i::Writer_i_factory");
	}
}

} // namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

