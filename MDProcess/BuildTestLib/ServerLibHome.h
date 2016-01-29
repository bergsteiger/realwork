////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/ServerLibHome.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::BuildTestLib
//
// библиотека реализующая логику сервера запуска тестов ночных сборок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"

namespace BuildTestLib {

class ServerLibHomeFactory {
public:
	static Core::Root::LibHome& get ();
};

class ServerLibHomeImpl : virtual public Core::Root_i::StdLibHomeBase {
	SET_OBJECT_COUNTER (ServerLibHomeImpl)


private:
	friend class ServerLibHomeFactory;
	
	REFCOUNT_SINGLETON(ServerLibHomeImpl)
	
	ServerLibHomeImpl ();

	void registrate_all_factories () const;
	
	void finalize ();
	
	void print_usage () const;
	
	bool check_params () const;
};
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
