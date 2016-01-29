////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/Notification_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::Notification_i
// Заголовок реализации класса серванта для интерфеса Notification
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFICATION_I_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFICATION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"

namespace GblAdapterLib {

class Notification_i; // self forward Var
typedef ::Core::Var<Notification_i> Notification_i_var;
typedef ::Core::Var<const Notification_i> Notification_i_cvar;

class Notification_i_factory;

class Notification_i:
	virtual public Notification
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Notification_i)
	friend class Notification_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Notification_i ();

	virtual ~Notification_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Variant_var m_data;

	NotifyType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Notification
	virtual const Variant& get_data () const;
	virtual Variant& get_data ();

	// implemented method from Notification
	virtual NotifyType get_id () const;

	// implemented method from Notification
	virtual void set_data (Variant* data);

	// implemented method from Notification
	virtual void set_type (NotifyType type);
}; // class Notification_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_NOTIFICATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
