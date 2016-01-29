////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/RegistryHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::RegistryHelper
//
// Модуль-помошник [helper], обеспечивающий минимальную работу с реестром [registry] операционной
// системы Windows. Позволяет прочитать значение текстового [REG_SZ] ключа. Если ключ не найден или
// функции API системы возвращают ошибки, то используется значение задаваемое по умолчанию.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_OS_REGISTRYHELPER_H__
#define __SHARED_CORE_OS_REGISTRYHELPER_H__

#include "ace/ACE.h"

//#UC START# *4500351F0119_USER_INCLUDES*
#include "ace/ACE.h"
#include "ace/Singleton.h"
#include "ace/Null_Mutex.h"
#include "ace/Auto_Ptr.h"
#include <stdexcept>
#include <vector>
#include <string>


/*  EXAMPLE:

	const HKEY REGISTRY_KEY_ROOT = HKEY_LOCAL_MACHINE;
	const ACE_TCHAR REGISTRY_KEY_PATH [] = ACE_TEXT ("SOFTWARE\\GARANT-NEMESIS");
	const ACE_TCHAR REGISTRY_OPTION_NAME [] = ACE_TEXT ("UserJournalPath");
	const ACE_TCHAR DEFAULT_OPTION_VALUE [] = ACE_TEXT ("\0");

	ACE_Auto_Basic_Array_Ptr <ACE_TCHAR> option_value; 
	
	option_value.reset (
		Core::RegistryHelper::get_option_value (
			REGISTRY_KEY_ROOT
			, REGISTRY_KEY_PATH
			, REGISTRY_OPTION_NAME
			, DEFAULT_OPTION_VALUE
		)
	);			

	if (std::string (option_value.get ()) != "") {
		UserJournal::s_log_path = option_value.get ();
	}

*/

//#UC END# *4500351F0119_USER_INCLUDES*

namespace Core {

//#UC START# *4500351F0119_USER_DEFINITION*

class RegistryHelper_i {
friend class ACE_Singleton<RegistryHelper_i, ACE_Null_Mutex>;
friend class RegistryHelper;
public:
	typedef ACE_Singleton<RegistryHelper_i, ACE_Null_Mutex> Singleton;

	typedef void* Key;
	Key KEY_LOCAL_MACHINE;
	Key KEY_CURRENT_USER;
public:	
	struct KeyInfo {
		std::string name;
		std::string value;
		KeyInfo () {}
		//KeyInfo (_name, _value) : name (_name), value (_value) {
		//}
	};
	typedef std::vector<KeyInfo> KeysArray;
private:	
	std::string FILE_LOCAL_MACHINE;
	std::string FILE_CURRENT_USER;
// Блок определения статических методов
	// Сохранение значения текстового [REG_SZ] ключа
	bool set_option_value (
		const Key registry_key_root
		, const std::string& registry_key_path
		, const std::string& registry_option_name
		, const std::string& option_value
		, bool create_if_not_exists = true
	);

	// Получение значения текстового [REG_SZ] ключа
	std::string get_option_value (
		const Key registry_key_root
		, const std::string& registry_key_path
		, const std::string& registry_option_name
		, const std::string& default_option_value
	);

	// Проверка на существование ветки реестра
	bool is_subkey_exist (
		const Key registry_key_root
		, const std::string& registry_key_path
	);
	
	// Получение массива, содержащего названия всех поля и их значений в заданной ветке реестра 
	bool get_keys_array (
		const Key registry_key_root
		, const std::string& registry_key_path
		, KeysArray& array
	);

	// Выделение из пути в реестре predefined key (HKEY_LOCAL_MACHINE или HKEY_CURRENT_USER)
	// и subkey (путь внутри predefined key)
	bool parse_registry_path (const std::string& path, Key& key, std::string& subkey);
private:	
	RegistryHelper_i();
	~RegistryHelper_i();
}; // class RegistryHelper

// wrapper around RegistryHelper_i::Singleton
class RegistryHelper {
public:
	enum Key {
		KEY_LOCAL_MACHINE,
		KEY_CURRENT_USER
	};
private:
	static RegistryHelper_i::Key key_to_i_key(const Key k) {
		switch (k) {
			case KEY_LOCAL_MACHINE: return RegistryHelper_i::Singleton::instance()->KEY_LOCAL_MACHINE;
			case KEY_CURRENT_USER: return RegistryHelper_i::Singleton::instance()->KEY_CURRENT_USER;
		}
		throw std::logic_error("RegistryHelper: bad compiler supposes int is enum");
	}
	static Key i_key_to_key(const RegistryHelper_i::Key& i_key) {
		if (i_key == RegistryHelper_i::Singleton::instance()->KEY_LOCAL_MACHINE) {
			return KEY_LOCAL_MACHINE;
		}
		if (i_key == RegistryHelper_i::Singleton::instance()->KEY_CURRENT_USER) {
			return KEY_CURRENT_USER;
		}
		throw std::logic_error("RegistryHelper: internal error: bad RegistryHelper_i::Key");
	}
public:
	typedef RegistryHelper_i::KeyInfo KeyInfo;
	typedef RegistryHelper_i::KeysArray KeysArray;
	static bool set_option_value (
		const Key registry_key_root
		, const std::string& registry_key_path
		, const std::string& registry_option_name
		, const std::string& option_value
		, bool create_if_not_exists = true
	) { 
		return RegistryHelper_i::Singleton::instance()->set_option_value(
			key_to_i_key(registry_key_root)
			, registry_key_path
			, registry_option_name
			, option_value
			, create_if_not_exists
		); 
	}
	static std::string get_option_value (
		const Key registry_key_root
		, const std::string& registry_key_path
		, const std::string& registry_option_name
		, const std::string& default_option_value
	) {
		return RegistryHelper_i::Singleton::instance()->get_option_value(
			key_to_i_key(registry_key_root)
			, registry_key_path
			, registry_option_name
			, default_option_value
		);
	}
	static bool is_subkey_exist (
		const Key registry_key_root
		, const std::string& registry_key_path
	) {
		return RegistryHelper_i::Singleton::instance()->is_subkey_exist(
			key_to_i_key(registry_key_root)
			, registry_key_path
		);
	}
	static bool get_keys_array (
		const Key registry_key_root
		, const std::string& registry_key_path
		, KeysArray& array
	) {
		return RegistryHelper_i::Singleton::instance()->get_keys_array(
			key_to_i_key(registry_key_root)
			, registry_key_path
			, array
		);
	}
	static bool parse_registry_path (const std::string& path, Key& key, std::string& subkey) {
		RegistryHelper_i::Key i_key;
		bool res = RegistryHelper_i::Singleton::instance()->parse_registry_path(
			path
			, i_key
			, subkey
		);
		if (res) {
			key = i_key_to_key(i_key);
		}
		return res; 			
	}
};

//#UC END# *4500351F0119_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_OS_REGISTRYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
