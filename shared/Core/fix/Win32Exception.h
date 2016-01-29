////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/fix/Win32Exception.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::fix::Win32Exception
//
// хак для правильной работы с win32 исключениями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_FIX_WIN32EXCEPTION_H__
#define __SHARED_CORE_FIX_WIN32EXCEPTION_H__

#include "ace/ACE.h"
#include "shared/Core/sys/Exception.h"

//#UC START# *45011F6B0000_USER_INCLUDES*
#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0)
#include "windows.h"
#include <exception>
#else
#endif


// adopted from: http://www.thunderguy.com/semicolon/2002/08/15/visual-c-exception-handling/3/
//
// Note: 
//   Therefore, if a Visual C++ program contains catch(...), 
//   then it should be compiled with asynchronous exception
//   handling enabled (/EHa). Otherwise, if the catch(...)
//   catches a Win32 exception, “some of the unwindable objects
//   in the function where the exception occurs may not get unwound”
//   (Visual C++ Programmer’s Guide), which could lead to resource
//   leaks or worse.
//
//
// Usage:
//     #include "Win32Exception.h"                                                                           
//     #include <iostream>                                                                                   
//                                                                                                           
//     int main() {                                                                                          
//     	Core::Win32Exception::install_handler();                                                             
//     	try {                                                                                               
//     		DoComplexAndErrorProneThings();                                                                   
//     	} catch (const AccessViolation& e) {                                                                
//     		std::cerr << e.what() << " at " << std::hex << e.where() << ": bad "                              
//     							<< (e.is_write() ? "write" : "read") << " on " << e.bad_address () << std::endl;        
//     	} catch (const Win32Exception& e) {                                                                 
//     		std::cerr << e.what() << " (code " << std::hex << e.code() << ") at " << e.where() << std::endl;  
//     	}                                                                                                   
//     }                                                                                                     

//#UC END# *45011F6B0000_USER_INCLUDES*

namespace Core {

//#UC START# *45011F6B0000_USER_DEFINITION*
#if defined(ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0)
class Win32Exception : public Core::Exception {
public:
	typedef const void* Address; // OK on Win32 platform

	static void install_handler ();

	virtual const char* what() const {
		return m_what;
	};

	virtual const char* uid () const /*throw ()*/ {
		return "Core::Win32Exception";
	}

	Address where() const {
	 	return m_where;
	};

	unsigned code() const {
	 	return m_code;
	};

protected:
	Win32Exception(const EXCEPTION_RECORD& info);
	static void translate(unsigned int code, EXCEPTION_POINTERS* info);

private:
	const char* m_what;
	Address m_where;
	unsigned int m_code;
};

class AccessViolation : public Win32Exception {
public:
	bool is_write() const {
		return m_is_write;
	};
	
	Address bad_address() const {
		return m_bad_address;
	};

	virtual const char* uid () const /*throw ()*/ {
		return "Core::AccessViolation";
	}

private:
	bool m_is_write;
	Address m_bad_address;
	AccessViolation(const EXCEPTION_RECORD& info);
	friend static void Win32Exception::translate(unsigned code, EXCEPTION_POINTERS* info);
};
#endif
//#UC END# *45011F6B0000_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_FIX_WIN32EXCEPTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
