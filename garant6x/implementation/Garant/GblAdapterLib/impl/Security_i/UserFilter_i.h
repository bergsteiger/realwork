////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserFilter_i
// Заголовок реализации класса серванта для интерфеса UserFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"

namespace GblAdapterLib {

class UserFilter_i; // self forward Var
typedef ::Core::Var<UserFilter_i> UserFilter_i_var;
typedef ::Core::Var<const UserFilter_i> UserFilter_i_cvar;

class UserFilter_i_factory;

class UserFilter_i:
	virtual public UserFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (UserFilter_i)
	friend class UserFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UserFilter_i ();

	virtual ~UserFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Uid m_current_uid;

	unsigned long m_flags;

	Uid m_group_uid;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UserFilter
	virtual unsigned long get_flags () const;

	virtual void set_flags (unsigned long flags);

	// implemented method from UserFilter
	// идентификатор группы по которой необходимо осуществить фильтрацию
	virtual const Uid get_group_uid () const;

	virtual void set_group_uid (Uid group_uid);
}; // class UserFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
