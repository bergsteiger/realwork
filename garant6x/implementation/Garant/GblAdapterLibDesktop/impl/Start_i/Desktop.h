////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibDesktop::Start_i::Desktop
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIBDESKTOP_START_I_DESKTOP_H__
#define __GARANT6X_GBLADAPTERLIBDESKTOP_START_I_DESKTOP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/ComponentManagerBase.h"

//#UC START# *474C107C02E0_CUSTOM_INCLUDES*
//#UC END# *474C107C02E0_CUSTOM_INCLUDES*

namespace GblAdapterLibDesktop {
namespace Start_i {

class Desktop; // self forward Var
typedef ::Core::Var<Desktop> Desktop_var;
typedef ::Core::Var<const Desktop> Desktop_cvar;

class Desktop_factory;

class Desktop:
	virtual public GblAdapterLib::ComponentManagerBase
{
	SET_OBJECT_COUNTER (Desktop)
	friend class Desktop_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Desktop ();

	virtual ~Desktop ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GblAdapterLib::ComponentManagerBase
	virtual void run ();

	// implemented method from GblAdapterLib::ComponentManagerBase
	virtual void smart_backend_init () const;

	// implemented method from GblAdapterLib::ComponentManagerBase
	virtual void timestamp_init (GblPilot::FunctionMng* function_manager) const;

//#UC START# *474C107C02E0*
//#UC END# *474C107C02E0*
}; // class Desktop

} // namespace Start_i
} // namespace GblAdapterLibDesktop


#endif //__GARANT6X_GBLADAPTERLIBDESKTOP_START_I_DESKTOP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
