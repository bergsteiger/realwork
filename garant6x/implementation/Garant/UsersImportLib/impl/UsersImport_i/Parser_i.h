////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Parser_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Parser_i
// ��������� ���������� ������ �������� ��� ��������� DataParser
//
// ��������� �������� ������ �������:
// <login><�����������><���><�����������>[password]<�����������>[e-
// mail]<�����������>[using_consulting_status]
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ��������� �������� ������ �������:
// <login><�����������><���><�����������>[password]<�����������>[e-
// mail]<�����������>[using_consulting_status]
class Parser_i:
	virtual public UsersImport::DataParser
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Parser_i)
	friend class Parser_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ���������� true, ���� ������ ���������� � ������ ��� ������
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
	// �������� ������������ �������� ���������� �����������, ���������� �������� ��������
	virtual boost::tribool check_consulting (const std::string& value) const /*throw (BadConsultingValue)*/;

	// �������� ������������ email
	virtual void check_email (const std::string& email) const /*throw (BadEmailValue)*/;

	// �������� ������������ ����� ������, ���������� ������������� �������� ������
	virtual GCD::Uid check_group (const std::string& group_name) const /*throw (BadGroupValue)*/;

	// �������� ������������ login-�
	virtual void check_login (const std::string& login) const /*throw (BadLoginValue)*/;

	// �������� ������������ ��� ������������
	virtual void check_name (const std::string& name) const /*throw (BadNameValue)*/;

	// �������� ������������ ������
	virtual void check_password (const std::string& password) const /*throw (BadPasswordValue)*/;

	// �������� ������������ �������� �������������������, ���������� �������� ��������
	virtual bool check_privileged (const std::string& value) const /*throw (BadPrivilegedValue)*/;

	// ��������� ������ � ������� ������ (UserData � ���������� ����������� �����)
	virtual size_t parse_i (const std::string& data, size_t string_number, UsersImport::UserData& user_data) const;

	// ��� ������� � ������ �������������. ���������� true, ���� �������� ��������� �� �����-����
	// ��������
	virtual bool set_action (const std::string& action, UsersImport::UserData& user_data) const;

	// ���������� ����������� �� �������� ������
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
	// ��������� ������ ������, � �������� �� � �������� � ������������ writer. string_num - �����
	// ����������� ������, ����� ��� ������ � ���.
	virtual void parse (const std::string& data, size_t string_number);
}; // class Parser_i

} // namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_PARSER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
