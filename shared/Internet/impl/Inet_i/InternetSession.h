////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Internet/impl/Inet_i/InternetSession.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::Internet::Inet_i::InternetSession
//
// Интернет сессия
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_INTERNET_INET_I_INTERNETSESSION_H__
#define __SHARED_INTERNET_INET_I_INTERNETSESSION_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4AC5F7FA036E_CUSTOM_INCLUDES*
#ifndef __AFXINET_H_
#include "afxinet.h"
#endif
//#UC END# *4AC5F7FA036E_CUSTOM_INCLUDES*

namespace Internet {
namespace Inet_i {

// Интернет сессия
class InternetSession :
	virtual public CInternetSession
{
	SET_OBJECT_COUNTER (InternetSession)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	InternetSession (const char* user_agent, unsigned long access_type, const char* proxy_name);

public:
	virtual ~InternetSession ();


//#UC START# *4AC5F7FA036E*
	virtual void OnStatusCallback (DWORD context, DWORD status, LPVOID status_info, DWORD status_info_length) {
		switch (status) {
			case INTERNET_STATUS_CONNECTING_TO_SERVER:
				break;
			case INTERNET_STATUS_CONNECTED_TO_SERVER:
				break;
			case INTERNET_STATUS_SENDING_REQUEST:
				break;
			case INTERNET_STATUS_CLOSING_CONNECTION:
				break;
			case INTERNET_STATUS_CONNECTION_CLOSED:
				break;
			case INTERNET_STATUS_REQUEST_COMPLETE:
				break;
		}
	}
//#UC END# *4AC5F7FA036E*
}; // class InternetSession

} // namespace Inet_i
} // namespace Internet


#endif //__SHARED_INTERNET_INET_I_INTERNETSESSION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

