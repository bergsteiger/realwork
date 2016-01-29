////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatchEx_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Profile_i::StopWatchEx_i
// Заголовок реализации класса серванта для интерфеса StopWatchEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCHEX_I_H__
#define __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCHEX_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/Profile.h"

//#UC START# *45F6AD48006E_CUSTOM_INCLUDES*
//#UC END# *45F6AD48006E_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class StopWatchEx_i; // self forward Var
typedef ::Core::Var<StopWatchEx_i> StopWatchEx_i_var;
typedef ::Core::Var<const StopWatchEx_i> StopWatchEx_i_cvar;

class StopWatchEx_i_factory;

class StopWatchEx_i:
	virtual public StopWatchEx
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StopWatchEx_i)
	friend class StopWatchEx_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StopWatchEx_i (const char* id, const char* context);

	virtual ~StopWatchEx_i ();

//#UC START# *45F6AD48006E*
private: 
	Core::GDS::StopWatchEx m_stop_watch;
//#UC END# *45F6AD48006E*
}; // class StopWatchEx_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCHEX_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
