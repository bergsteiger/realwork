////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::UsersImportLib::UsersImport_i
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include <fstream>
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"


namespace UsersImport_i {

// � ������ ������ ��� �� ������ �������-�����������
class CantFindDelimiter : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������� ��� login-� ������������
class BadLoginValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������� ����� ������������
class BadNameValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������� ������
class BadPasswordValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������� email
class BadEmailValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������� ���������� �����������
class BadConsultingValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������� �������� �������������������
class BadPrivilegedValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ��� ������
class BadGroupValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� ������ �������� ������ �� ��������������� ��������� ����������
class CantFindUserManager : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� ������ ������� ���� � �������
class BadSourceFile : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������� ��� ����������� �� �������
class AdminAlreadyLogged : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� ������ ���
class CantFindName : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��� ���������� ������������
class ErasedUserNotExists : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} //namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

