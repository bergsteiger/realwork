////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LegalSection.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::LegalSection
// Заголовок реализации класса серванта для интерфеса Section
//
// Раздел для юристов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_LEGALSECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_LEGALSECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class LegalSection; // self forward Var
typedef ::Core::Var<LegalSection> LegalSection_var;
typedef ::Core::Var<const LegalSection> LegalSection_cvar;

class LegalSection_factory;

// Раздел для юристов
class LegalSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (LegalSection)
	friend class LegalSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LegalSection ();

	virtual ~LegalSection ();
}; // class LegalSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_LEGALSECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
