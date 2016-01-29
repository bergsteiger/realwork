////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::UsersImportLib::UsersImport_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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

// в первой строке нет ни одного символа-разделителя
class CantFindDelimiter : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// плохое значение для login-а пользователя
class BadLoginValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// плохое значение имени пользователя
class BadNameValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// плохое значение пароля
class BadPasswordValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// плохое значение email
class BadEmailValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// плохое значение разрешения консалтинга
class BadConsultingValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// плохое значение свойства привилегированности
class BadPrivilegedValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// некорректное имя группы
class BadGroupValue : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// не смогли получить ссылку на соответствующую серверную компоненту
class CantFindUserManager : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// не смогли открыть файл с данными
class BadSourceFile : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// администратор уже залогирован на сервере
class AdminAlreadyLogged : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// не заданы ФИО
class CantFindName : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// нет удаляемого пользователя
class ErasedUserNotExists : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} //namespace UsersImport_i


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

