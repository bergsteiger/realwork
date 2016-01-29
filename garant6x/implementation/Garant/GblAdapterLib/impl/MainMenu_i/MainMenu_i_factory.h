////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::MainMenu_i
// Заголовк реализации фабрик интерфеса MainMenu для серванта MainMenu_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_MAINMENU_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_MAINMENU_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for MainMenu_i
class MainMenu_i_factory: virtual public ::Core::RefCountObjectBase, virtual public MainMenuAbstractFactory {
public:
	MainMenu_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MainMenu* make ();

};

typedef ::Core::Var<MainMenu_i_factory> MainMenu_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_MAINMENU_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

