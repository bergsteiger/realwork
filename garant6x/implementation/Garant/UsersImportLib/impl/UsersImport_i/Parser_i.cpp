////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Parser_i
//
// разбирает заданную строку формата:
// <login><разделитель><ФИО><разделитель>[password]<разделитель>[e-
// mail]<разделитель>[using_consulting_status]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/LibHome.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"

namespace UsersImport_i {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
bool Parser_i::NotCorrectCharacter::operator () (unsigned char param_) const {
	//#UC START# *4862523801D8_IMPL*
	return param_ < ' ';
	//#UC END# *4862523801D8_IMPL*
}

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Parser_i::Parser_i (UsersImport::DataWriter* writer)
//#UC START# *481D6FC201FD_481D6FE701AC_481D797C02B3_BASE_INIT*
: m_delimiter (0), m_writer (writer)
//#UC END# *481D6FC201FD_481D6FE701AC_481D797C02B3_BASE_INIT*
{
	//#UC START# *481D6FC201FD_481D6FE701AC_481D797C02B3_BODY*
	//#UC END# *481D6FC201FD_481D6FE701AC_481D797C02B3_BODY*
}

Parser_i::~Parser_i () {
	//#UC START# *481D797C02B3_DESTR_BODY*
	//#UC END# *481D797C02B3_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверка корректности значения разрешения консалтинга, возвращает заданное значение
boost::tribool Parser_i::check_consulting (const std::string& value) const /*throw (BadConsultingValue)*/ {
	//#UC START# *481DA42903B4*
	if (value.size () > 1) {
		throw BadConsultingValue ();
	}
	if (value.empty ()) {
		return boost::indeterminate;
	}
	if (value[0] == '0') {
		return false;
	}
	if (value[0] == '1') {
		return true;
	}
	throw BadConsultingValue ();
	//#UC END# *481DA42903B4*
}

// проверка корректности email
void Parser_i::check_email (const std::string& email) const /*throw (BadEmailValue)*/ {
	//#UC START# *481DA3F202AA*
	if (email.empty ()) {
		return;
	}
	std::string::size_type position1 = email.find_first_of ('@');
	std::string::size_type position2 = email.find_last_of ('.');
	if ((position1 == std::string::npos)
		|| (position2 == std::string::npos)
		|| (position2 < position1)
	) {
		throw BadEmailValue ();
	}
	//#UC END# *481DA3F202AA*
}

// проверка корректности имени группы, возвращает идентификатор заданной группы
GCD::Uid Parser_i::check_group (const std::string& group_name) const /*throw (BadGroupValue)*/ {
	//#UC START# *49EC55920010*
	if (group_name.empty ()) {
		throw BadGroupValue ();
	}

	return m_writer->get_group_id (group_name);
	//#UC END# *49EC55920010*
}

// проверка корректности login-а
void Parser_i::check_login (const std::string& login) const /*throw (BadLoginValue)*/ {
	//#UC START# *481DA07A02CA*
	const size_t max_login_size = 32;
	if (login.empty () || (login.size () > max_login_size)) {
		throw BadLoginValue ();
	}
	if (std::find_if (login.begin (), login.end (), NotCorrectCharacter ()) != login.end ()) {
		throw BadLoginValue ();
	}
	//#UC END# *481DA07A02CA*
}

// проверка корректности ФИО пользователя
void Parser_i::check_name (const std::string& name) const /*throw (BadNameValue)*/ {
	//#UC START# *481DA2BB0364*
	const size_t max_name_size = 255;
	if (name.empty () || (name.size () > max_name_size)) {
		throw BadNameValue ();
	}
	//#UC END# *481DA2BB0364*
}

// проверка корректности пароля
void Parser_i::check_password (const std::string& password) const /*throw (BadPasswordValue)*/ {
	//#UC START# *481DA39803D3*
	const size_t max_password_size = 255;
	if (password.size () > max_password_size) {
		throw BadPasswordValue ();
	}
	//#UC END# *481DA39803D3*
}

// проверка корректности свойства привилегированности, возвращает заданное значение
bool Parser_i::check_privileged (const std::string& value) const /*throw (BadPrivilegedValue)*/ {
	//#UC START# *481DAF470204*
	if (value.size () > 1) {
		throw BadPrivilegedValue ();
	}
	if (value.empty () || (value[0] == '0')) {
		return false;
	}
	if (value[0] == '1') {
		return true;
	}
	throw BadPrivilegedValue ();
	//#UC END# *481DAF470204*
}

// разобрать строку и вернуть данные (UserData и количество разобранных полей)
size_t Parser_i::parse_i (const std::string& data, size_t string_number, UsersImport::UserData& user_data) const {
	//#UC START# *481F2FB701CE*
	if (!m_delimiter) {
		this->set_delimiter (data);
	}

	std::vector<std::string> splited_strings;
	boost::split (splited_strings, data, boost::is_from_range (m_delimiter, m_delimiter));
	size_t fields_count = splited_strings.size ();

	if (fields_count == 1) {
		throw CantFindDelimiter ();
	}

	if (this->set_action (splited_strings[0], user_data)) {
		splited_strings.erase (splited_strings.begin ());
		--fields_count;

		if ((fields_count == 1) && (user_data.action != UsersImport::ERASE_USER)) {
			throw CantFindName ();
		}
	}

	

	user_data.login = splited_strings[0];
	this->check_login (user_data.login);

	if (user_data.action == UsersImport::ERASE_USER) {
		return fields_count;
	}

	user_data.name = splited_strings[1];
	this->check_name (user_data.name);

	if (fields_count == 2) {
		return fields_count;
	}
	user_data.password = splited_strings[2];
	this->check_password (user_data.password);

	if (fields_count == 3) {
		return fields_count;
	}
	user_data.email = splited_strings[3];
	try {
		this->check_email (user_data.email);
	} catch (BadEmailValue&) {
		LOG_E (("CSV String (%d): incorrect e-mail address, parameter skipped", string_number));
	}

	if (fields_count == 4) {
		return fields_count;
	}
	try {
		user_data.consulting_value = this->check_consulting (splited_strings[4]);
	} catch (BadConsultingValue&) {
		LOG_E (("CSV String (%d): incorrect consulting rights value. Using default", string_number));
	}

	if (fields_count == 5) {
		return fields_count;
	}
	try {
		user_data.privileged_status = this->check_privileged (splited_strings[5]);
	} catch (BadPrivilegedValue&) {
		LOG_E (("CSV String (%d): incorrect privileged rights value. Using default", string_number));
	}

	if (fields_count == 6) {
		return fields_count;
	}
	try {
		user_data.group_id = this->check_group (splited_strings[6]);
	} catch (BadGroupValue&) {
		LOG_E (("CSV String (%d): incorrect group name. Using default group", string_number));
	}

	return fields_count;
	//#UC END# *481F2FB701CE*
}

// что сделать с данным пользователем. Возвращает true, если параметр указывает на какое-либо
// действие
bool Parser_i::set_action (const std::string& action, UsersImport::UserData& user_data) const {
	//#UC START# *4C2D9CEC02B7*
	if (action.size () != 1) {
		return false;
	}

	switch (action[0]) {
		case '+':
			return true;
		case '-':
			user_data.action = UsersImport::ERASE_USER;
			return true;
		case '=':
			user_data.action = UsersImport::CHANGE_USER;
			return true;
	}

	return false;
	//#UC END# *4C2D9CEC02B7*
}

// вычитывает разделитель из заданной строки
void Parser_i::set_delimiter (const std::string& data) const /*throw (CantFindDelimiter)*/ {
	//#UC START# *481D926500D3*
	const std::string list_of_delimiters (";,|\t");
	std::string::size_type position = data.find_first_of (list_of_delimiters);
	if (position == std::string::npos) {
		throw CantFindDelimiter ();
	}
	m_delimiter = data[position];
	//#UC END# *481D926500D3*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from UsersImport::DataParser
// выполнить разбор данных, и записать их в заданный в конструкторе writer. string_num - номер
// разбираемой строки, нужен для вывода в лог.
void Parser_i::parse (const std::string& data, size_t string_number) {
	//#UC START# *481D776901DB_481D797C02B3*
	UsersImport::UserData user_data;
	size_t fields_count = this->parse_i (data, string_number, user_data);

	while ( 1) {
		try {
			switch (user_data.action) {
				case UsersImport::ADD_USER:
					try {
						m_writer->add_user (user_data);
						return;
					} catch (GslUserManager::NoMorePersistentUsers&) {
						LOG_W (("CSV String (%d): maximum count of privileged users reached, add nonprivileged user", string_number));
						user_data.privileged_status = false;
					} catch (GslUserManager::LoginDuplicate&) {
						LOG_E (("CSV String (%d) skipped: user <%s> already exists", string_number, user_data.login.c_str ()));
						throw;
					} 
					break;
				case UsersImport::CHANGE_USER:
					try {
						m_writer->change_user (user_data, fields_count);
						return;
					}  catch (GslUserManager::NoMorePersistentUsers&) {
						LOG_W (("CSV String (%d): maximum count of privileged users reached, flag not changed", string_number));
						user_data.privileged_status = false;
					} catch (GCD::CanNotFindData&) {
						LOG_W (("CSV String (%d): can't find modified user, create new one", string_number));
						user_data.action = UsersImport::ADD_USER;
					}
					break;
				case UsersImport::ERASE_USER:
					try {
						m_writer->erase_user (user_data);
					} catch (GCD::CanNotFindData&) {
						throw ErasedUserNotExists ();
					} catch (GslUserManager::BadGUID&) {
						throw ErasedUserNotExists ();
					}
					return;
				default:
					GDS_ASSERT (false);
					return;
			}
		} catch (GCD::AccessDenied&) {
			GDS_ASSERT (false);
			return;
		}
	}
	//#UC END# *481D776901DB_481D797C02B3*
}
} // namespace UsersImport_i

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

