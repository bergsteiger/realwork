////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImportMain.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> garant6x::UsersImportLib::LibSupport::UsersImportMain
//
// методы высокого уровня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_LIBSUPPORT_USERSIMPORTMAIN_H__
#define __GARANT6X_USERSIMPORTLIB_LIBSUPPORT_USERSIMPORTMAIN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"

//#UC START# *481D6E04016B_CUSTOM_INCLUDES*
//#UC END# *481D6E04016B_CUSTOM_INCLUDES*

// методы высокого уровня

class UsersImportMain : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (UsersImportMain)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(UsersImportMain)

public:
	static UsersImportMain& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:

	// Останов приложения
	virtual void fini () const;

	// вернуть путь к приложению
	virtual void get_path_to_application (std::string& path) const;

	// получить полный путь к файлу с данными
	virtual void get_path_to_datafile (std::string& path) const;

	// инициализация приложения (GCMManager-а),возвращает созданный объект для записи данных
	virtual UsersImport::DataWriter* init () const;

	// установка параметров ParamManager
	virtual void init_environment () const;

	// описание использования утилиты
	virtual void usage () const;


//#UC START# *481D6E04016B*
//#UC END# *481D6E04016B*
}; // class UsersImportMain



#endif //__GARANT6X_USERSIMPORTLIB_LIBSUPPORT_USERSIMPORTMAIN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
