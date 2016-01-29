////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::UsersImportLib::UsersImport
//
// интерфейсы уутилиты
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garantServer/src/Global/Core/gcdC.h"

namespace UsersImport {

// тип действия
enum ActionType {
	ADD_USER // добавить пользователя (умолчательное значение)
	, ERASE_USER // удалить пользователя
	, CHANGE_USER // изменить данные пользователя
};

#pragma pack (push, 1)

// данные пользователя
struct UserData {
	// регистрационное имя, обязательный параметр, уникальное значение, длина - не более 32 знаков
	std::string login;
	// ФИО пользователя, обязательный параметр, длина - не более 255 знаков
	std::string name;
	// пароль пользователя, необязательный параметр, длина - не более 255 знаков
	std::string password;
	// email пользователя, необязательный параметр, если указан, в нем обязательно должны быть "@" и
	// "."
	std::string email;
	// право использования услуги Правового консалтинга, необязательный параметр, возможные значения
	// ('','0','1'): "значение не указано" (по умолчанию) - право наследуется в соответствии с
	// групповой настройкой политик на право доступа к консультациям для новых пользователей, "0" -
	// запрещено, "1" - разрешено.
	boost::tribool consulting_value;
	// свойство привилегированности пользователя , необязательный параметр, возможные значения
	// ('','0','1'): "значение не указано" (по умолчанию) - не привилегированный пользователь, "0" -
	// не привилегированный пользователь, "1" - привилегированный пользователь.
	bool privileged_status;
	// идентификатор группы пользователя
	GCD::Uid group_id;
	ActionType action;

	// конструктор по-умолчанию
	UserData ();
};

#pragma pack (pop)

class DataWriter;
typedef ::Core::Var<DataWriter> DataWriter_var;
typedef ::Core::Var<const DataWriter> DataWriter_cvar;
// приёмник разобранных данных
class DataWriter
	: virtual public ::Core::IObject
{
public:
	// записать данные
	virtual void add_user (const UserData& user_data) = 0;

	// получить идентификатор группы по её имени
	virtual GCD::Uid get_group_id (const std::string& name) = 0;

	// удалить пользователя
	virtual void erase_user (const UserData& user_data) = 0;

	// сменить данные пользователя
	virtual void change_user (const UserData& user_data, size_t fields_count) = 0;
};

/// factory interface for DataWriter
class DataWriterFactory {
public:
	// фабрика
	static DataWriter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DataParser;
typedef ::Core::Var<DataParser> DataParser_var;
typedef ::Core::Var<const DataParser> DataParser_cvar;
// разборщик данных
class DataParser
	: virtual public ::Core::IObject
{
public:
	// выполнить разбор данных, и записать их в заданный в конструкторе writer. string_num - номер
	// разбираемой строки, нужен для вывода в лог.
	virtual void parse (const std::string& data, size_t string_number) = 0;
};

/// factory interface for DataParser
class DataParserFactory {
public:
	// фабрика получает приёмник, в который будетзаписывать разобранные данные
	static DataParser* make (DataWriter* writer)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DataReader;
typedef ::Core::Var<DataReader> DataReader_var;
typedef ::Core::Var<const DataReader> DataReader_cvar;
// чтение данных для импорта
class DataReader
	: virtual public ::Core::IObject
{
};

/// factory interface for DataReader
class DataReaderFactory {
public:
	// фабрика получает имя источника, откуда читать данные и разборщик, которому она будет эти данные
	// скармливать
	static DataReader* make (const std::string& source, DataParser* parser)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// фабрика получает имя источника, откуда читать данные
	static DataReader* make (const std::string& source)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace UsersImport

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <UsersImport::DataWriter> {
	typedef UsersImport::DataWriterFactory Factory;
};
template <>
struct TypeTraits <UsersImport::DataParser> {
	typedef UsersImport::DataParserFactory Factory;
};
template <>
struct TypeTraits <UsersImport::DataReader> {
	typedef UsersImport::DataReaderFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
