////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BusinessReferencesSection.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::BusinessReferencesSection
// Заголовок реализации класса серванта для интерфеса Section
//
// Раздел Бизнес-справки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUSINESSREFERENCESSECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUSINESSREFERENCESSECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class BusinessReferencesSection; // self forward Var
typedef ::Core::Var<BusinessReferencesSection> BusinessReferencesSection_var;
typedef ::Core::Var<const BusinessReferencesSection> BusinessReferencesSection_cvar;

class BusinessReferencesSection_factory;

// Раздел Бизнес-справки
class BusinessReferencesSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (BusinessReferencesSection)
	friend class BusinessReferencesSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BusinessReferencesSection ();

	virtual ~BusinessReferencesSection ();
}; // class BusinessReferencesSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUSINESSREFERENCESSECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
