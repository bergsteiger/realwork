////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatch_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Profile_i::StopWatch_i
// Заголовок реализации класса серванта для интерфеса StopWatch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCH_I_H__
#define __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCH_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/Profile.h"

//#UC START# *45F6AD310011_CUSTOM_INCLUDES*
//#UC END# *45F6AD310011_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class StopWatch_i; // self forward Var
typedef ::Core::Var<StopWatch_i> StopWatch_i_var;
typedef ::Core::Var<const StopWatch_i> StopWatch_i_cvar;

class StopWatch_i_factory;

class StopWatch_i:
	virtual public StopWatch
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StopWatch_i)
	friend class StopWatch_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StopWatch_i (const char* context);

	virtual ~StopWatch_i ();

//#UC START# *45F6AD310011*
private:
	Core::GDS::StopWatch m_stop_watch;
//#UC END# *45F6AD310011*
}; // class StopWatch_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCH_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
