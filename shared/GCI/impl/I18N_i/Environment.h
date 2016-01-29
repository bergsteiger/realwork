////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/Environment.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Environment::Class>> shared::GCI::I18N_i::Environment
//
// хранит умолчательную локаль
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_ENVIRONMENT_H__
#define __SHARED_GCI_I18N_I_ENVIRONMENT_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18N.h"

//#UC START# *454B0CE10128_CUSTOM_INCLUDES*
//#UC END# *454B0CE10128_CUSTOM_INCLUDES*
namespace GCI {
namespace I18N_i {

class Environment;

class Environment_i {
	friend class Environment;
	
	I18N::SupportedLocales get_default_locale () const {
		return m_default_locale;
	}

	void set_default_locale (I18N::SupportedLocales default_locale) {
		m_default_locale = default_locale;
	}

private:
	typedef ACE_Singleton<Environment_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton<Environment_i, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	I18N::SupportedLocales m_default_locale;

}; // class Environment_i

class Environment {
public:
	static I18N::SupportedLocales get_default_locale () {
		return Environment_i::Singleton::instance()->get_default_locale ();
	}

	static void set_default_locale (I18N::SupportedLocales default_locale) {
		Environment_i::Singleton::instance()->set_default_locale (default_locale);
	}	
}; // class Environment

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_ENVIRONMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
