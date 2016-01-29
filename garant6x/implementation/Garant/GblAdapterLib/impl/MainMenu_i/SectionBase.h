////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::SectionBase
// Заголовок реализации класса серванта для интерфеса Section
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONBASE_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"

namespace GblAdapterLib {

class SectionBase; // self forward Var
typedef ::Core::Var<SectionBase> SectionBase_var;
typedef ::Core::Var<const SectionBase> SectionBase_cvar;

class SectionBase:
	virtual public Section
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (SectionBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SectionBase ();


	explicit SectionBase (SectionType type);

	virtual ~SectionBase ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Серверный раздел ОМ
	GblPilot::Section_var m_server_section;

	GblPilot::SectionType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from Section
	// имя
	virtual const GCI::IO::String* get_caption () const;
	virtual GCI::IO::String* get_caption ();

	// implemented method from Section
	// Получить элементы раздела ОМ
	virtual SectionItemList* get_items () const;
}; // class SectionBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
