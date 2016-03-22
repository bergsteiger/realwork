////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/GosZakupkiSection.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::GosZakupkiSection
// Заголовок реализации класса серванта для интерфеса Section
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_GOSZAKUPKISECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_GOSZAKUPKISECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class GosZakupkiSection; // self forward Var
typedef ::Core::Var<GosZakupkiSection> GosZakupkiSection_var;
typedef ::Core::Var<const GosZakupkiSection> GosZakupkiSection_cvar;

class GosZakupkiSection_factory;

class GosZakupkiSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (GosZakupkiSection)
	friend class GosZakupkiSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GosZakupkiSection ();

	virtual ~GosZakupkiSection ();
}; // class GosZakupkiSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_GOSZAKUPKISECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
