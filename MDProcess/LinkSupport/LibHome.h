////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/LinkSupport/LibHome.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::LinkSupport
//
// поддержка переходов от страницы к элементу в розу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_LINKSUPPORT_H__
#define __MDPROCESS_LINKSUPPORT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeBase.h"

namespace LinkSupport {

class LibHomeFactory {
public:
	static CoreSrv::Root::CorbaLibHome& get ();
};

class LibHomeImpl : virtual public CoreSrv::Root_i::CorbaLibHomeBase {
	SET_OBJECT_COUNTER (LibHomeImpl)


private:
	void publish_all_servers_factories () const;

private:
	friend class LibHomeFactory;
	
	REFCOUNT_SINGLETON(LibHomeImpl)
	
	LibHomeImpl ();

	void registrate_all_factories () const;
	
	void finalize ();
};
} // namespace LinkSupport


#endif //__MDPROCESS_LINKSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
