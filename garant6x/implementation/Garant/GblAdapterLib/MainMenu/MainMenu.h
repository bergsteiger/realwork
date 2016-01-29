////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// Тип секции ОМ
enum SectionType {
	ST_FINANCE // Налоги и финансы
	, ST_HR // Раздел для кадровиков
	, ST_LEGAL // Раздел для юристов
	, ST_BUDGET_ORGS // Бюджетные организаций
	, ST_LAW_FOR_ALL // Право для всех
	, ST_BUSINESS_REFERENCES // Бизнес-справки
	, ST_CHANGES_IN_LEGISLATION // Изменения в законодательстве
};

class SectionItem;
typedef ::Core::Var<SectionItem> SectionItem_var;
typedef ::Core::Var<const SectionItem> SectionItem_cvar;
// Элемент раздела ОМ
class SectionItem
	: virtual public ::Core::IObject
{
public:
	// Имя
	virtual const GCI::IO::String* get_caption () const = 0;
	virtual GCI::IO::String* get_caption () = 0;

	// Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString)
	virtual Core::IObject* open () const = 0;
};

/// factory interface for SectionItem
class SectionItemFactory {
public:
	static SectionItem* make (const GblPilot::SectionItem& section_item)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < SectionItem_var > SectionItemList;

class Section;
typedef ::Core::Var<Section> Section_var;
typedef ::Core::Var<const Section> Section_cvar;
class Section
	: virtual public StartLocal::BaseUpdateChecker
{
public:
	// имя
	virtual const GCI::IO::String* get_caption () const = 0;
	virtual GCI::IO::String* get_caption () = 0;

	// Получить элементы раздела ОМ
	virtual SectionItemList* get_items () const = 0;
};

/// factory interface for Section
class SectionFactory {
public:
	typedef std::vector<SectionType> KeySet;
	
	static KeySet* keys ();
public:
	static const Section& make (SectionType key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class MainMenu;
typedef ::Core::Var<MainMenu> MainMenu_var;
typedef ::Core::Var<const MainMenu> MainMenu_cvar;
// Основное меню
class MainMenu
	: virtual public ::Core::IObject
{
public:
	// Получить дерево вкладок Бзового поиска
	virtual NodeBase* get_base_search_panes () const = 0;

	// Получить дерево секции ОМ по типу
	virtual const Section& get_section (SectionType type) const = 0;
};

/// factory interface for MainMenu
class MainMenuFactory {
public:
	static MainMenu& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SectionItem> {
	typedef GblAdapterLib::SectionItemFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Section> {
	typedef GblAdapterLib::SectionFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::MainMenu> {
	typedef GblAdapterLib::MainMenuFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
