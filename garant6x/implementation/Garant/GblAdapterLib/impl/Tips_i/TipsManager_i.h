////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Tips_i/TipsManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Tips_i::TipsManager_i
// Заголовок реализации класса серванта для интерфеса TipsManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/Tips.h"

namespace GblAdapterLib {

class TipsManager_i; // self forward Var
typedef ::Core::Var<TipsManager_i> TipsManager_i_var;
typedef ::Core::Var<const TipsManager_i> TipsManager_i_cvar;

class TipsManager_i_factory;

class TipsManager_i:
	virtual public TipsManager
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (TipsManager_i)
	friend class TipsManager_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <TipsManager_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TipsManager_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TipsManager_i ();

	virtual ~TipsManager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable boost::tribool m_tips_exists;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from TipsManager
	// Получить текущий (по сценарию) Совет дня
	virtual NodeIndexPath* get_current_tip () const;

	// implemented method from TipsManager
	virtual bool is_exist () const;

	// implemented method from TipsManager
	// Рут дерева совет дня
	virtual const NodeBase* get_tips_tree_root () const
		/*throw (CanNotFindData)*/;
	virtual NodeBase* get_tips_tree_root ()
		/*throw (CanNotFindData)*/;
}; // class TipsManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIPS_I_TIPSMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
