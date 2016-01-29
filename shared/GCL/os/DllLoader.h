////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/os/DllLoader.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::os::DllLoader
//
// класс реализующий загрузку DLL
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_OS_DLLLOADER_H__
#define __SHARED_GCL_OS_DLLLOADER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4503DE990138_USER_INCLUDES*
#include <string>
//#UC END# *4503DE990138_USER_INCLUDES*

namespace GCL {

//#UC START# *4503DE990138_USER_DEFINITION*
	class DllLoader {
	private:
#if defined (WIN32)
		class ErrorModeController {
		public:
			ErrorModeController () {
				m_previous_error_mode = ::SetErrorMode (SEM_FAILCRITICALERRORS);
			}
			virtual ~ErrorModeController () {
				try {
					::SetErrorMode (m_previous_error_mode);
				} catch (...) {
				}
			}
		private:
			::UINT m_previous_error_mode;
		};
#else  // defined (WIN32)
		class ErrorModeController {
		public:
			ErrorModeController () {
				// do nothing
			}
			virtual ~ErrorModeController () {
				// do nothing
			}
		};
#endif // defined (WIN32)

		class CurrentDirController {
		public:
			CurrentDirController () {
				if (ACE_OS::getcwd (m_current_dir, MAXPATHLEN + 1) == 0) {
					m_current_dir [0] = ACE_TEXT ('\0');
				}
			}
			virtual ~CurrentDirController () {
				try {
					if (ACE_OS::strlen (m_current_dir) != 0) {
						ACE_OS::chdir (m_current_dir);
					}
				} catch (...) {
				}
			}
		private:
			ACE_TCHAR m_current_dir [MAXPATHLEN + 1];
		}; // class CurrentDirController

	public:
		DllLoader (const char* dll_name) : m_handle (ACE_SHLIB_INVALID_HANDLE) {
			try {
				this->open (dll_name);

				if (this->is_loaded () == false) {
					LOG_W (("%s: dynamic library %s not found", GDS_CURRENT_FUNCTION, m_shared_name.c_str ()));
				}
			} catch (...) {
				LOG_W (("%s: dynamic library %s not loaded", GDS_CURRENT_FUNCTION, m_shared_name.c_str ()));
			}
		}

		virtual ~DllLoader () {
			try {
				this->close ();
			} catch (...) {
			}
		}

	public:
		inline bool is_loaded () const { 
			return (m_handle != ACE_SHLIB_INVALID_HANDLE); 
		}

		inline const ACE_SHLIB_HANDLE get_handle () const { 
			return m_handle; 
		}

		inline const char* get_shared_name () const { 
			return m_shared_name.c_str (); 
		}

	protected:
		void open (const char* dll_name) {
			if (dll_name == 0) {
				LOG_W (("%s: invalid dll name", GDS_CURRENT_FUNCTION));
				return;
			}

			ErrorModeController error_mode_controller;

#if defined (ACE_WIN32)
			m_shared_name = std::string (ACE_DLL_PREFIX) + std::string (dll_name) + std::string (ACE_DLL_SUFFIX);

			ACE_TCHAR os_dependent_dir [MAXPATHLEN + 6 + 1]; { // `+6` for `\win??` patern; `+1` for `\0` char
				os_dependent_dir [::GetModuleFileName ((HMODULE)0, os_dependent_dir, MAXPATHLEN)] = ACE_TEXT ('\0');
			}

			if (ACE_OS::strlen (os_dependent_dir) != 0) {
				ACE_TCHAR* last_dir_separator = ACE_OS_String::strrchr (os_dependent_dir, ACE_DIRECTORY_SEPARATOR_CHAR);

				if (last_dir_separator != 0) {
					*last_dir_separator = ACE_TEXT ('\0');
				}

				ACE_OS::strcat (os_dependent_dir, ACE_DIRECTORY_SEPARATOR_STR);

				if ((long)::GetVersion () < 0) {
					ACE_OS::strcat (os_dependent_dir, ACE_TEXT ("win9X"));
				} else {
					ACE_OS::strcat (os_dependent_dir, ACE_TEXT ("winNT"));
				}

				{
					CurrentDirController current_dir_controller;

					if (ACE_OS::chdir (os_dependent_dir) != -1) {
						m_handle = ACE_OS::dlopen (m_shared_name.c_str ());
					}
				}
			}

			if (m_handle == ACE_SHLIB_INVALID_HANDLE) {
				std::string full_name = std::string (os_dependent_dir) + std::string (ACE_DIRECTORY_SEPARATOR_STR) + m_shared_name;
				m_handle = ACE_OS::dlopen (full_name.c_str ());
			}
#else  // defined (ACE_WIN32)
			ACE_TCHAR tmp_name [MAXPATHLEN + 1]; {
				if (ACE::ldfind (ACE_TEXT (dll_name), tmp_name, MAXPATHLEN) == -1) {
					tmp_name [0] = ACE_TEXT ('\0');
				}
				m_shared_name = tmp_name;
			}
#endif // defined (ACE_WIN32)

			if (m_handle == ACE_SHLIB_INVALID_HANDLE && m_shared_name.size ()) {
				m_handle = ACE_OS::dlopen (m_shared_name.c_str ());
			}
		}

		void close () {
			if (m_handle != ACE_SHLIB_INVALID_HANDLE) {
				ACE_OS::dlclose (m_handle);
			}
		}

		template <typename T>
		T get_func_ptr (const char* name) {
			T ret = reinterpret_cast <T> (ACE_OS::dlsym (m_handle, ACE_TEXT (name)));
			if (!ret) {
				LOG_W ((
					"%s: symbol '%s' not found in dynamic library %s"
					, GDS_CURRENT_FUNCTION
					, name
					, m_shared_name.c_str ())
				);
				throw std::exception ();
			}
			return ret;
		}

	private:
		ACE_SHLIB_HANDLE m_handle;

		std::string m_shared_name;
	};

	typedef Core::Aptr <DllLoader> DllLoader_aptr;
//#UC END# *4503DE990138_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_OS_DLLLOADER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
