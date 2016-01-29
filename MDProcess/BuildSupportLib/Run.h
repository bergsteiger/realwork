////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildSupportLib/Run.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::BuildSupportLib::LibSupport::Run
//
// Обрабатывает входные параметры и передает их в экземпляр объекта Сборки, вызывая на нем
// соответствующее событие.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDSUPPORTLIB_LIBSUPPORT_RUN_H__
#define __MDPROCESS_BUILDSUPPORTLIB_LIBSUPPORT_RUN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace BuildSupportLib {

// Обрабатывает входные параметры и передает их в экземпляр объекта Сборки, вызывая на нем
// соответствующее событие.

class Run : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (Run)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(Run)

public:
	static Run& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

}; // class Run

} // namespace BuildSupportLib


#endif //__MDPROCESS_BUILDSUPPORTLIB_LIBSUPPORT_RUN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
