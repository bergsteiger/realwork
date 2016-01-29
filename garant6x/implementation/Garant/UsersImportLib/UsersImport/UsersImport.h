////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::UsersImportLib::UsersImport
//
// ���������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "garantServer/src/Global/Core/gcdC.h"

namespace UsersImport {

// ��� ��������
enum ActionType {
	ADD_USER // �������� ������������ (������������� ��������)
	, ERASE_USER // ������� ������������
	, CHANGE_USER // �������� ������ ������������
};

#pragma pack (push, 1)

// ������ ������������
struct UserData {
	// ��������������� ���, ������������ ��������, ���������� ��������, ����� - �� ����� 32 ������
	std::string login;
	// ��� ������������, ������������ ��������, ����� - �� ����� 255 ������
	std::string name;
	// ������ ������������, �������������� ��������, ����� - �� ����� 255 ������
	std::string password;
	// email ������������, �������������� ��������, ���� ������, � ��� ����������� ������ ���� "@" �
	// "."
	std::string email;
	// ����� ������������� ������ ��������� �����������, �������������� ��������, ��������� ��������
	// ('','0','1'): "�������� �� �������" (�� ���������) - ����� ����������� � ������������ �
	// ��������� ���������� ������� �� ����� ������� � ������������� ��� ����� �������������, "0" -
	// ���������, "1" - ���������.
	boost::tribool consulting_value;
	// �������� ������������������� ������������ , �������������� ��������, ��������� ��������
	// ('','0','1'): "�������� �� �������" (�� ���������) - �� ����������������� ������������, "0" -
	// �� ����������������� ������������, "1" - ����������������� ������������.
	bool privileged_status;
	// ������������� ������ ������������
	GCD::Uid group_id;
	ActionType action;

	// ����������� ��-���������
	UserData ();
};

#pragma pack (pop)

class DataWriter;
typedef ::Core::Var<DataWriter> DataWriter_var;
typedef ::Core::Var<const DataWriter> DataWriter_cvar;
// ������� ����������� ������
class DataWriter
	: virtual public ::Core::IObject
{
public:
	// �������� ������
	virtual void add_user (const UserData& user_data) = 0;

	// �������� ������������� ������ �� � �����
	virtual GCD::Uid get_group_id (const std::string& name) = 0;

	// ������� ������������
	virtual void erase_user (const UserData& user_data) = 0;

	// ������� ������ ������������
	virtual void change_user (const UserData& user_data, size_t fields_count) = 0;
};

/// factory interface for DataWriter
class DataWriterFactory {
public:
	// �������
	static DataWriter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DataParser;
typedef ::Core::Var<DataParser> DataParser_var;
typedef ::Core::Var<const DataParser> DataParser_cvar;
// ��������� ������
class DataParser
	: virtual public ::Core::IObject
{
public:
	// ��������� ������ ������, � �������� �� � �������� � ������������ writer. string_num - �����
	// ����������� ������, ����� ��� ������ � ���.
	virtual void parse (const std::string& data, size_t string_number) = 0;
};

/// factory interface for DataParser
class DataParserFactory {
public:
	// ������� �������� �������, � ������� ��������������� ����������� ������
	static DataParser* make (DataWriter* writer)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DataReader;
typedef ::Core::Var<DataReader> DataReader_var;
typedef ::Core::Var<const DataReader> DataReader_cvar;
// ������ ������ ��� �������
class DataReader
	: virtual public ::Core::IObject
{
};

/// factory interface for DataReader
class DataReaderFactory {
public:
	// ������� �������� ��� ���������, ������ ������ ������ � ���������, �������� ��� ����� ��� ������
	// �����������
	static DataReader* make (const std::string& source, DataParser* parser)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� �������� ��� ���������, ������ ������ ������
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
