////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::UsersImportLib::UsersImport
//
// интерфейсы уутилиты
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.h"

namespace UsersImport {


// конструктор по-умолчанию
UserData::UserData ()
//#UC START# *481DB9AA03A3_INIT_CTOR_BASE_INIT*
: action (ADD_USER), consulting_value (boost::indeterminate), privileged_status (false), group_id (GCD::BaseUsersGroup)
//#UC END# *481DB9AA03A3_INIT_CTOR_BASE_INIT*
{
	//#UC START# *481DB9AA03A3_CTOR_BODY*
	//#UC END# *481DB9AA03A3_CTOR_BODY*
}
// factory interface wrapper for DataWriter
DataWriter* DataWriterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DataWriterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for DataParser
DataParser* DataParserFactory::make (
	DataWriter* writer
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DataParserFactoryManager::Singleton::instance ()->make (writer);
}

// factory interface wrapper for DataReader
DataReader* DataReaderFactory::make (
	const std::string& source
	, DataParser* parser
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DataReaderFactoryManager::Singleton::instance ()->make (source, parser);
}

DataReader* DataReaderFactory::make (
	const std::string& source
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DataReaderFactoryManager::Singleton::instance ()->make (source);
}

} // namespace UsersImport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

