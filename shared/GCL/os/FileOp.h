////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/os/FileOp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::os::FileOp
//
// расширенные операции над файлом (копирование, перенос, удаление)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_OS_FILEOP_H__
#define __SHARED_GCL_OS_FILEOP_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4503DEC603C8_USER_INCLUDES*
#include <string>
//#UC END# *4503DEC603C8_USER_INCLUDES*

namespace GCL {
namespace FileOp {

// Группа исключений для файловых операций
class FOException : public ::Core::Exception {
};

// Unknown File operation exception
class UnknownError : public FOException {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// cant complete move operation becouse destination file exists
class FileExists : public FOException {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// acess denied to make file operation
class AccessDenied : public FOException {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// invalid path specified for file opertion
class InvalidPath : public FOException {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// not enough room to complete file opertion
class NotEnoughRoom : public FOException {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// копирует файл с возможностью перезаписи
void copy_file (const char* from, const char* to, bool overwrite) /*throw (FOException)*/;

// переносит файл с возможностью перезаписи
void move_file (const char* from, const char* to, bool overwrite) /*throw (FOException)*/;

// удаляет файл
void remove_file (const char* from) /*throw (FOException)*/;

// Функция сравнивнения двух файлов.
// елсли as_binary = true - файлы сравнивают бинарно
int compare (const char* first, const char* second, bool as_binary) /*throw (AccessDenied, InvalidPath)*/;

//#UC START# *4503DEC603C8_USER_DEFINITION*
void splitpath(
	const std::string& path
	, std::string& drive
	, std::string& dir
	, std::string& fname
	, std::string& ext
	, bool dflt=false // if (dflt), splitpath gets current drive & dir
); 
//#UC END# *4503DEC603C8_USER_DEFINITION*

} // namespace FileOp
} // namespace GCL


#endif //__SHARED_GCL_OS_FILEOP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
