////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Parser_i
// Заголовок реализации класса серванта для интерфеса DataParser
//
// разбирает заданную строку формата:
// <login><разделитель><ФИО><разделитель>[password]<разделитель>[e-
// mail]<разделитель>[using_consulting_status]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_PARSER_I_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_PARSER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"

namespace UsersImport_i {

class Parser_i; // self forward Var
typedef ::Core::Var<Parser_i> Parser_i_var;
typedef ::Core::Var<const Parser_i> Parser_i_cvar;

class Parser_i_factory;

// разбирает заданную строку формата:
// <login><разделитель><ФИО><разделитель>[password]<разделитель>[e-
// mail]<разделитель>[using_consulting_status]
class Parser_i:
	virtual public UsersImport::DataParser
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Parser_i)
	friend class Parser_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// возвращает true, если символ недопустим в логине или пароле
	struct NotCorrectCharacter : public std::unary_function<unsigned char, bool> {
		bool operator () (unsigned char param_) const;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Parser_i (UsersImport::DataWriter* writer);

	virtual ~Parser_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// проверка корректности значения разрешения консалтинга, возвращает заданное значение
	virtual boost::tribool check_consulting (const std::string& value) const /*throw (BadConsultingValue)*/;

	// проверка корректности email
	virtual void check_email (const std::string& email) const /*throw (BadEmailValue)*/;

	// проверка корректности имени группы, возвращает идентификатор заданной группы
	virtual GCD::Uid check_group (const std::string& group_name) const /*throw (BadGroupValue)*/;

	// проверка корректности login-а
	virtual void check_login (const std::string& login) const /*throw (BadLoginValue)*/;

	// проверка корректности ФИО пользователя
	virtual void check_name (const std::string& name) const /*throw (BadNameValue)*/;

	// проверка корректности пароля
	virtual void check_password (const std::string& password) const /*throw (BadPasswordValue)*/;

	// проверка корректности свойства привилегированности, возвращает заданное значение
	virtual bool check_privileged (const std::string& value) const /*throw (BadPrivilegedValue)*/;

	// разобрать строку и вернуть данные (UserData и количество разобранных полей)
	virtual size_t parse_i (const std::string& data, size_t string_number, UsersImport::UserData& user_data) const;

	// что сделать с данным пользователем. Возвращает true, если параметр указывает на какое-либо
	// действие
	virtual bool set_action (const std::string& action, UsersImport::UserData& user_data) const;

	// вычитывает разделитель из заданной строки
	virtual void set_delimiter (const std::string& data) const /*throw (CantFindDelimiter)*/;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable unsigned char m_delimiter;

	mutable UsersImport::DataWriter_var m_writer;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UsersImport::DataParser
	// выполнить разбор данных, и записать их в заданный в конструкторе writer. string_num - номер
	// разбираемой строки, нужен для вывода в лог.
	virtual void parse (const std::string& data, size_t string_number);
}; // class Parser_i

} // namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_PARSER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
