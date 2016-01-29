////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/FinanceSection.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::FinanceSection
// Заголовок реализации класса серванта для интерфеса Section
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_FINANCESECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_FINANCESECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class FinanceSection; // self forward Var
typedef ::Core::Var<FinanceSection> FinanceSection_var;
typedef ::Core::Var<const FinanceSection> FinanceSection_cvar;

class FinanceSection_factory;

class FinanceSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (FinanceSection)
	friend class FinanceSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FinanceSection ();

	virtual ~FinanceSection ();
}; // class FinanceSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_FINANCESECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
