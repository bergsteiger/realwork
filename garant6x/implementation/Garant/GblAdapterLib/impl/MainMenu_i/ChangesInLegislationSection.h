////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/ChangesInLegislationSection.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::ChangesInLegislationSection
// Заголовок реализации класса серванта для интерфеса Section
//
// Раздел Изменения в законодательстве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_CHANGESINLEGISLATIONSECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_CHANGESINLEGISLATIONSECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class ChangesInLegislationSection; // self forward Var
typedef ::Core::Var<ChangesInLegislationSection> ChangesInLegislationSection_var;
typedef ::Core::Var<const ChangesInLegislationSection> ChangesInLegislationSection_cvar;

class ChangesInLegislationSection_factory;

// Раздел Изменения в законодательстве
class ChangesInLegislationSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (ChangesInLegislationSection)
	friend class ChangesInLegislationSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ChangesInLegislationSection ();

	virtual ~ChangesInLegislationSection ();
}; // class ChangesInLegislationSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_CHANGESINLEGISLATIONSECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
