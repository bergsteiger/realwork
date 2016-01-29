////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/ApplicationServer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::ApplicationServer
//
// Абстрактный сервер приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_OS_APPLICATIONSERVER_H__
#define __SHARED_CORE_OS_APPLICATIONSERVER_H__

#include "ace/ACE.h"

//#UC START# *4E9BF2400279_USER_INCLUDES*
#include "boost/shared_ptr.hpp"

#include "shared/Core/Params/Params.h"
#include "shared/Core/mng/LogMsgSmartBackend.h"
//#UC END# *4E9BF2400279_USER_INCLUDES*

namespace Core {

//#UC START# *4E9BF2400279_USER_DEFINITION*
class ApplicationServer {
public:

	int init (int argc, char* argv[]);
	int run ();
	int shutdown ();

private:
	void init_log_backend ();
	void init_param_manager (int argc, char* argv []) const;

	virtual const ParamManagerInitData& get_param_manager_data () const = 0;
	virtual void init_server () = 0;

	virtual int start_work () = 0;
	virtual int stop_work () = 0;

private:
	boost::shared_ptr <LogMsgSmartBackend> m_log_msg_smart_backend;	
};
//#UC END# *4E9BF2400279_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_OS_APPLICATIONSERVER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
