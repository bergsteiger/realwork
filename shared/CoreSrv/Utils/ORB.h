////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Utils/ORB.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::CoreSrv::Utils::ORB
//
// обертка над CORBA::ORB предоставляющая функции управления дополнительными свойствами ОРБа
// (БиДир, ПулПотоков, РТ-расширения)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_UTILS_ORB_H__
#define __SHARED_CORESRV_UTILS_ORB_H__

#include "shared/Core/sys/std_inc.h"
#include "tao/ORB_Core.h"
#include "tao/PortableServer/PortableServerC.h"

//#UC START# *4503D75003D8_CUSTOM_INCLUDES*
#include <string>
//#UC END# *4503D75003D8_CUSTOM_INCLUDES*

namespace CoreSrv {

// обертка над CORBA::ORB предоставляющая функции управления дополнительными свойствами ОРБа
// (БиДир, ПулПотоков, РТ-расширения)
class ORB {
	SET_OBJECT_COUNTER (ORB)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// включает режим bi-dir
	static void enable_bidir (CORBA::ORB* orb);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ORB ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возвращает закешированную ссылку на рутовый POA
	virtual PortableServer::POA* get_cached_root_poa () const;


//#UC START# *4503D75003D8*
	static void enable_request_timeout (CORBA::ORB_ptr orb, unsigned short seconds);

	ORB (const char* name, size_t threads_count);

	virtual void init (int argc, char* argv[]);
	virtual void run ();
	virtual void spawn_run ();
	virtual void shutdown ();
	
	CORBA::ORB_ptr get_cached_orb () const;
	
	const char* name () const;
	size_t threads_count () const;

private:
	CORBA::ORB_var m_orb;
	PortableServer::POA_var m_root_poa;
	
	size_t m_threads_count;
	std::string m_name;
//#UC END# *4503D75003D8*
}; // class ORB

} // namespace CoreSrv


#endif //__SHARED_CORESRV_UTILS_ORB_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

