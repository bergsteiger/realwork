////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::SectionItem_i
// Заголовок реализации класса серванта для интерфеса SectionItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONITEM_I_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONITEM_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"

//#UC START# *4E36CB3C02C9_CUSTOM_INCLUDES*
//#UC END# *4E36CB3C02C9_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class SectionItem_i; // self forward Var
typedef ::Core::Var<SectionItem_i> SectionItem_i_var;
typedef ::Core::Var<const SectionItem_i> SectionItem_i_cvar;

class SectionItem_i_factory;

class SectionItem_i:
	virtual public SectionItem
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SectionItem_i)
	friend class SectionItem_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SectionItem_i (const GblPilot::SectionItem& section_item);

	virtual ~SectionItem_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblPilot::SectionItem m_server_section_item;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from SectionItem
	// Имя
	virtual const GCI::IO::String* get_caption () const;
	virtual GCI::IO::String* get_caption ();

	// implemented method from SectionItem
	// Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString)
	virtual Core::IObject* open () const;

//#UC START# *4E36CB3C02C9*
//#UC END# *4E36CB3C02C9*
}; // class SectionItem_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONITEM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
