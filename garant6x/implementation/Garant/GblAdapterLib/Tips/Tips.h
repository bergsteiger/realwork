////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Tips/Tips.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// Совет дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIPS_H__
#define __GARANT6X_GBLADAPTERLIB_TIPS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class TipsManager;
typedef ::Core::Var<TipsManager> TipsManager_var;
typedef ::Core::Var<const TipsManager> TipsManager_cvar;
// Менеджер Советов дня
class TipsManager
	: virtual public ::Core::IObject
{
public:
	// Рут дерева совет дня
	virtual const NodeBase* get_tips_tree_root () const
		/*throw (CanNotFindData)*/ = 0;
	virtual NodeBase* get_tips_tree_root ()
		/*throw (CanNotFindData)*/ = 0;

	// Получить текущий (по сценарию) Совет дня
	virtual NodeIndexPath* get_current_tip () const = 0;

	virtual bool is_exist () const = 0;
};

/// factory interface for TipsManager
class TipsManagerFactory {
public:
	static TipsManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::TipsManager> {
	typedef GblAdapterLib::TipsManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_TIPS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
