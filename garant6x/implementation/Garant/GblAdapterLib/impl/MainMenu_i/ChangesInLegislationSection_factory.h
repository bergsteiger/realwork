////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/ChangesInLegislationSection_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::ChangesInLegislationSection
// Заголовк реализации фабрик интерфеса Section для серванта ChangesInLegislationSection
//
// Раздел Изменения в законодательстве
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_CHANGESINLEGISLATIONSECTION_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_CHANGESINLEGISLATIONSECTION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for ChangesInLegislationSection
class ChangesInLegislationSection_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public SectionAbstractFactory
{
public:
	ChangesInLegislationSection_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const SectionType key () const;

	Section* make ();

};

typedef ::Core::Var<ChangesInLegislationSection_factory> ChangesInLegislationSection_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_CHANGESINLEGISLATIONSECTION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

