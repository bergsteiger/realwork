////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/FileReader_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::FileReader_i
// Заголовк реализации фабрик интерфеса DataReader для серванта FileReader_i
//
// реализация чтения данных из заданного файла
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_FILEREADER_I_FCTR_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_FILEREADER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"

namespace UsersImport_i {

/// Interface-factory implementation for FileReader_i
class FileReader_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public UsersImport::DataReaderAbstractFactory
{
public:
	FileReader_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	UsersImport::DataReader* make (const std::string& source, UsersImport::DataParser* parser);

	UsersImport::DataReader* make (const std::string& source);

};

typedef ::Core::Var<FileReader_i_factory> FileReader_i_factory_var;

} // namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_FILEREADER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

