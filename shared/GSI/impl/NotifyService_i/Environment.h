////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/Environment.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Environment::Class>> shared::GSI::NotifyService_i::NotifyServiceEnv
//
// Необходимый энвайромент для работы с текущей реализацией сервиса нотификаци
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_I_NOTIFYSERVICEENV_H__
#define __SHARED_GSI_NOTIFYSERVICE_I_NOTIFYSERVICEENV_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "tao/ORB_Core.h"

//#UC START# *45363645030D_CUSTOM_INCLUDES*
//#UC END# *45363645030D_CUSTOM_INCLUDES*
namespace GSI {
namespace NotifyService_i {

class Environment;

class Environment_i {
	friend class Environment;
	
	ConfigurationType get_type () const {
		return m_type;
	}

	void set_type (ConfigurationType type) {
		m_type = type;
	}
	CORBA::ORB& get_orb () const {
		if (m_orb.ptr()) {
			return *m_orb.ptr();
		} else {
			throw Core::Root::CachedAttrUninitialized (GDS_CURRENT_FUNCTION);
		}
	}

	void set_orb (CORBA::ORB* orb) {
		m_orb = CORBA::ORB::_duplicate(orb);
	}

private:
	typedef ACE_Singleton<Environment_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton<Environment_i, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	ConfigurationType m_type;

	CORBA::ORB_var m_orb;

}; // class Environment_i

class Environment {
public:
	static ConfigurationType get_type () {
		return Environment_i::Singleton::instance()->get_type ();
	}

	static void set_type (ConfigurationType type) {
		Environment_i::Singleton::instance()->set_type (type);
	}	

	static CORBA::ORB& get_orb () {
		return Environment_i::Singleton::instance()->get_orb ();
	}

	static void set_orb (CORBA::ORB* orb) {
		Environment_i::Singleton::instance()->set_orb (orb);
	}	
}; // class Environment

} // namespace NotifyService_i
} // namespace GSI


#endif //__SHARED_GSI_NOTIFYSERVICE_I_NOTIFYSERVICEENV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
