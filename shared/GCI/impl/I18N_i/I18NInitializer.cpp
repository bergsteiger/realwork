////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: I18NInitializer.cpp
// C++ implementation files (.cpp)
// Файл для инициализации объектов интернационализации.
// Используется только в проектах, для которых main функция
// или функция инициализации библиотеки не генерится с модели.
// При генерации с модели необходимо использовать соответствующую
// юзер-секцию для инициализации локали по-умолчанию
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/GCI/impl/I18N_i/I18NInitializer.h"

#include "shared/GCI/impl/I18N_i/Messages_i_factory.h"
#include "shared/GCI/impl/I18N_i/GarantWinLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/PosixLocaleOperations_factory.h"
#include "shared/GCI/impl/UnicodeHelper_i/EmptyHelper_factory.h"
#include "shared/GCI/impl/UnicodeHelper_i/TatarHelper_factory.h"

#include "shared/GCI/impl/I18N_i/Environment.h"

namespace I18NInitializer {

// инициализация механизма интернационализации сообщений. Передаваемый 
// параметр задаёт локаль языка ключей.

struct I18NInitializerHelper {
	I18NInitializerHelper () {
		messages_factory = new GCI::I18N_i::Messages_i_factory ();
		messages_factory->registrate_me (0);

		tatar_helper_factory = new GCI::UnicodeHelper_i::TatarHelper_factory ();
		tatar_helper_factory->registrate_me(0);

		empty_helper_factory = new GCI::UnicodeHelper_i::EmptyHelper_factory ();
		empty_helper_factory->registrate_me(0);
#if defined (WIN32)
		garant_win_locale_factory = new GCI::I18N_i::GarantWinLocaleOperations_factory ();
		garant_win_locale_factory->registrate_me(0);
#else
		posix_locale_factory = new GCI::I18N_i::PosixLocaleOperations_factory ();
		posix_locale_factory->registrate_me(0);
#endif
}

private:
	GCI::I18N_i::Messages_i_factory_var messages_factory;
	GCI::UnicodeHelper_i::TatarHelper_factory_var tatar_helper_factory;
	GCI::UnicodeHelper_i::EmptyHelper_factory_var empty_helper_factory;
	GCI::I18N_i::PosixLocaleOperations_factory_var posix_locale_factory;
	GCI::I18N_i::GarantWinLocaleOperations_factory_var garant_win_locale_factory;
};

void init_messages (GCI::I18N::SupportedLocales locale) {
	typedef ACE_Singleton <I18NInitializerHelper, ACE_SYNCH_RECURSIVE_MUTEX> I18NInitializerSingleton;
	I18NInitializerSingleton::instance ();

	GCI::I18N_i::Environment::set_default_locale (locale);
}

} // end of namespace