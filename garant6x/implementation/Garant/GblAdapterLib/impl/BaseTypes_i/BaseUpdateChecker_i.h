////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::BaseTypes_i::BaseUpdateChecker_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_BASEUPDATECHECKER_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_BASEUPDATECHECKER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

class BaseUpdateChecker_i;
typedef Core::Var<BaseUpdateChecker_i> BaseUpdateChecker_i_var;
typedef Core::Var<const BaseUpdateChecker_i> BaseUpdateChecker_i_cvar;

class BaseUpdateChecker_i :
	virtual public StartLocal::BaseUpdateChecker
	, virtual public Core::RefCountObjectBase
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~BaseUpdateChecker_i ();


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
private:
	virtual void clear_cache () = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable ApplicationHelper::BaseId m_base_id;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from StartLocal::BaseUpdateChecker
	// метод вызывается при обновлении базы
	virtual void check_update_and_clear_cache () const;
}; // class BaseUpdateChecker_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_BASEUPDATECHECKER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

