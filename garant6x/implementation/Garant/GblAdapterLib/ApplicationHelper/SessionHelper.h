////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/SessionHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::ApplicationHelper::SessionHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_SESSIONHELPER_H__
#define __GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_SESSIONHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"

namespace GblAdapterLib {

class SessionHelper {
	SET_OBJECT_COUNTER (SessionHelper)

	// singleton declaration
	typedef ACE_Singleton <SessionHelper, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SessionHelper, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static SessionHelper* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SessionHelper ();

	virtual ~SessionHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_is_session_active;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual bool get_is_session_active () const;

	virtual void set_is_session_active (bool is_session_active);
}; // class SessionHelper

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_APPLICATIONHELPER_SESSIONHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

