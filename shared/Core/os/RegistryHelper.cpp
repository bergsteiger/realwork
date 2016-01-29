////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/RegistryHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::RegistryHelper
// Файл реализации утилитного набора RegistryHelper
//
// Модуль-помошник [helper], обеспечивающий минимальную работу с реестром [registry] операционной
// системы Windows. Позволяет прочитать значение текстового [REG_SZ] ключа. Если ключ не найден или
// функции API системы возвращают ошибки, то используется значение задаваемое по умолчанию.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/os/RegistryHelper.h"

//#UC START# *4500351F0119_CUSTOM_INCLUDES*
#include "ace/OS.h"
#include <stdexcept>
#include <iostream>
#include <locale>
#if defined(WIN32) || defined(_MSC_VER)
#include <windows.h>
#endif
//#UC END# *4500351F0119_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *4500351F0119*
#if defined(WIN32) || defined(_MSC_VER) // GARANT_GCC_FINAL

	RegistryHelper_i::RegistryHelper_i() {
		this->KEY_LOCAL_MACHINE = HKEY_LOCAL_MACHINE;
		this->KEY_CURRENT_USER = HKEY_CURRENT_USER;
	}

	RegistryHelper_i::~RegistryHelper_i() {
	}

	bool RegistryHelper_i::set_option_value ( // no del_option for  a while
		const RegistryHelper_i::Key registry_key_root_in 
		, const std::string& registry_key_path_in
		, const std::string& registry_option_name_in
		, const std::string& option_value_in
		, bool create_if_not_exists // ignore, assume true
	) {
		const HKEY registry_key_root = reinterpret_cast<const HKEY>(registry_key_root_in);
		const char* registry_key_path = registry_key_path_in.c_str();
		const char* registry_option_name = registry_option_name_in.c_str();
		const char* option_value = option_value_in.c_str();

		bool result = false;
		//
		HKEY hkey = 0;
		DWORD disposition = 0;
		//
		if (ACE_TEXT_RegCreateKeyEx (registry_key_root, registry_key_path, 0, 0, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, 0, &hkey, &disposition) == ERROR_SUCCESS) {
			try {
				const BYTE* data = (const BYTE*)option_value;
				DWORD size = (DWORD)(sizeof (ACE_TCHAR)*(ACE_OS_String::strlen (option_value)+1));
				//
				DWORD type = 0;
				//
				if (ACE_TEXT_RegQueryValueEx (hkey, registry_option_name, 0, &type, 0, 0) == ERROR_SUCCESS) {
					result = ((type == REG_SZ) && (ACE_TEXT_RegSetValueEx (hkey, registry_option_name, 0, REG_SZ, data, size) == ERROR_SUCCESS));
				} else {
					result = (ACE_TEXT_RegSetValueEx (hkey, registry_option_name, 0, REG_SZ, data, size) == ERROR_SUCCESS);
				}
			} catch (...) {
				RegCloseKey (hkey);
				//
				throw;
			}
			RegCloseKey (hkey);
		}
		//
		return result;
	}

	std::string RegistryHelper_i::get_option_value (
		const RegistryHelper_i::Key registry_key_root_in
		, const std::string& registry_key_path_in
		, const std::string& registry_option_name_in
		, const std::string& default_option_value_in
	) {
		const HKEY registry_key_root = reinterpret_cast<const HKEY>(registry_key_root_in);
		const char* registry_key_path = registry_key_path_in.c_str();
		const char* registry_option_name = registry_option_name_in.c_str();

		std::string result = "";
		//
		HKEY hkey = 0;
		//
		if (ACE_TEXT_RegOpenKeyEx (registry_key_root, registry_key_path, 0, KEY_READ, &hkey) == ERROR_SUCCESS) {
			try {
				DWORD type = 0;
				DWORD size = 0;
				//
				if ((ACE_TEXT_RegQueryValueEx (hkey, registry_option_name, 0, &type, 0, &size) == ERROR_SUCCESS) && (type == REG_SZ)) {
					BYTE* data = (BYTE*)alloca(size+1);
					//
					if (ACE_TEXT_RegQueryValueEx (hkey, registry_option_name, 0, 0, data, &size) == ERROR_SUCCESS) {
						data[size] = 0;
						result = reinterpret_cast<char*>(data);
					} else {
						result = default_option_value_in;
					}
				} else {
					result = default_option_value_in;
				}
			} catch (...) {
				RegCloseKey (hkey);
				//
				throw;
			}
			RegCloseKey (hkey);
		} else {
			result = default_option_value_in;
		}
		//
		return result;
	}

	bool RegistryHelper_i::is_subkey_exist (
		const RegistryHelper_i::Key registry_key_root_in
		, const std::string& registry_key_path_in
	) {
		const HKEY registry_key_root = reinterpret_cast<const HKEY>(registry_key_root_in);
		const char* registry_key_path = registry_key_path_in.c_str();

		HKEY hkey = 0;
		if (ERROR_SUCCESS != ACE_TEXT_RegOpenKeyEx (registry_key_root, registry_key_path, 0, KEY_READ, &hkey)) {
			return false;
		}
		RegCloseKey (hkey);
		return true;
	}

	bool RegistryHelper_i::get_keys_array (
		const RegistryHelper_i::Key registry_key_root_in
		, const std::string& registry_key_path_in
		, KeysArray& array
	) {
		const HKEY registry_key_root = reinterpret_cast<const HKEY>(registry_key_root_in);
		const char* registry_key_path = registry_key_path_in.c_str();

		HKEY hkey = 0;
		if (ERROR_SUCCESS != ACE_TEXT_RegOpenKeyEx (registry_key_root, registry_key_path, 0, KEY_READ, &hkey)) {
			return false;
		}
		static const unsigned long BUF_SIZE = 2048;
		DWORD name_size = BUF_SIZE;
		char name[BUF_SIZE];
		DWORD value_size = BUF_SIZE;
		BYTE value[BUF_SIZE];
		DWORD type;
		array.clear ();
		for (long i = 0;
				ERROR_SUCCESS == ACE_TEXT_RegEnumValue (
						hkey, i, name, &name_size, 0, &type, value, &value_size
					);
				i++
			) {
			KeyInfo ki;
			ki.name = name;
			if (REG_SZ != type) {
				char buf[BUF_SIZE];
				sprintf (buf, "%d\0", *(reinterpret_cast<long*>(value)));
				ki.value = buf;
			} else {
				ki.value = reinterpret_cast<char*>(value);
			}
			array.push_back (ki);
			name_size = BUF_SIZE;
			value_size = BUF_SIZE;
		}
		RegCloseKey (hkey);
		return true;
	}

	bool RegistryHelper_i::parse_registry_path (const std::string& path, RegistryHelper_i::Key& key, std::string& subkey) {
		std::string::size_type pos = path.find ('\\');
		if (std::string::npos == pos) {
			return false;
		}
		std::string key_str = path.substr (0, pos);
		if ("Core::RegistryHelper::KEY_LOCAL_MACHINE" == key_str) {
			key = reinterpret_cast<RegistryHelper_i::Key>(HKEY_LOCAL_MACHINE);
		} else if ("Core::RegistryHelper::KEY_CURRENT_USER" == key_str){
			key = reinterpret_cast<RegistryHelper_i::Key>(HKEY_CURRENT_USER);
		} else {
			return false;
		}
		subkey = path.substr (pos+1, path.length () - pos - 1);
		return true;
	}

#else // operate upon xml file

	RegistryHelper_i::RegistryHelper_i(): FILE_LOCAL_MACHINE("1"), FILE_CURRENT_USER("2") {
		this->KEY_LOCAL_MACHINE = &this->FILE_LOCAL_MACHINE;
		this->KEY_CURRENT_USER = &this->FILE_CURRENT_USER;
	
	}
	
	RegistryHelper_i::~RegistryHelper_i() {
	}
	
	bool RegistryHelper_i::set_option_value (
		const RegistryHelper_i::Key registry_key_root
		, const std::string& registry_key_path_in
		, const std::string& registry_option_name
		, const std::string& option_value
		, bool create_if_not_exists) {		
		return true;
	}

	std::string RegistryHelper_i::get_option_value (
		const RegistryHelper_i::Key registry_key_root
		, const std::string& registry_key_path_in
		, const std::string& registry_option_name
		, const std::string& default_option_value
	) {
		return default_option_value;
	}

	bool RegistryHelper_i::is_subkey_exist (
		const RegistryHelper_i::Key registry_key_root
		, const std::string& registry_key_path_in
	) {
		return true;
	}

	bool RegistryHelper_i::get_keys_array (
		const RegistryHelper_i::Key registry_key_root
		, const std::string& registry_key_path_in
		, RegistryHelper_i::KeysArray& array
	) {
		array = RegistryHelper_i::KeysArray();		
		return true;
	}

	bool RegistryHelper_i::parse_registry_path (const std::string& path_in, RegistryHelper_i::Key& key, std::string& subkey) {
		subkey = "";
		key = RegistryHelper_i::KEY_LOCAL_MACHINE;
		return true;
	}

#endif

//#UC END# *4500351F0119*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

