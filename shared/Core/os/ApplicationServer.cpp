////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/ApplicationServer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::ApplicationServer
// Файл реализации утилитного набора ApplicationServer
//
// Абстрактный сервер приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/os/ApplicationServer.h"

//#UC START# *4E9BF2400279_CUSTOM_INCLUDES*
#include "boost/scoped_ptr.hpp"
#include "shared/Core/ParamsHelper/ParamConvert.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
//#UC END# *4E9BF2400279_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *4E9BF2400279*
int ApplicationServer::init (int argc, char* argv []) {
	try {
		this->init_param_manager (argc, argv);
		this->init_log_backend ();
		this->init_server ();
		return 0;
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
		return -1;
	}
}

void ApplicationServer::init_param_manager (int argc, char* argv []) const {
	try {
		Core::ParamsImpl::ParamManagerImpl_factory_var param_manager_factory = new Core::ParamsImpl::ParamManagerImpl_factory ();
		param_manager_factory->registrate_me(0);
	} catch (Core::Root::DuplicatedFactoryKey&) { 		//гасим, т.к менеджер может быть зарегестрирован в другом месте
	}

	ParamManagerFactory::get ().init (ParamConvert::make_arg_list (argc, argv), this->get_param_manager_data ());
}

void ApplicationServer::init_log_backend () { 
	boost::scoped_ptr <Core::ParamArgs> arg_list (ParamManagerFactory::get ().command_line_for_sbe_init ());
	boost::scoped_ptr <ACE_ARGV> arg (ParamConvert::make_ace_argv (*arg_list));

	int argc = arg->argc ();
	if (!m_log_msg_smart_backend.get ()) {
		m_log_msg_smart_backend.reset (new LogMsgSmartBackend (argc, arg->argv ()));
	}
}

int ApplicationServer::run () {
	return this->start_work ();
}

int ApplicationServer::shutdown () {
	return this->stop_work (); 
}
//#UC END# *4E9BF2400279*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

