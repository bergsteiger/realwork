////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/HRSection.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::HRSection
// Заголовок реализации класса серванта для интерфеса Section
//
// раздел для кадровиков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_HRSECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_HRSECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class HRSection; // self forward Var
typedef ::Core::Var<HRSection> HRSection_var;
typedef ::Core::Var<const HRSection> HRSection_cvar;

class HRSection_factory;

// раздел для кадровиков
class HRSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (HRSection)
	friend class HRSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	HRSection ();

	virtual ~HRSection ();
}; // class HRSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_HRSECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
