////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Tips/Tips_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Tips
//
// Совет дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIPS_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_TIPS_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Tips/Tips.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"

namespace GblAdapterLib {

class ITipsManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_current_tip_47B572E3010B (
		NodeIndexPath_tie*& ret_
	) const = 0;

	virtual bool __stdcall is_exist_47B93A910257 () const = 0;


	virtual void __stdcall get_tips_tree_root (INodeBase_tie*& ret_) /*throw (CanNotFindData_tie)*/ = 0;
};

class __declspec (dllexport) TipsManager_tie: public ITipsManager_tie {
	SET_OBJECT_COUNTER (TipsManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	TipsManager_tie ();

	typedef ::Core::PoolObjectManager<TipsManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<TipsManager_tie> Pool;
	friend class ::Core::PoolObjectManager<TipsManager_tie>;
	typedef ::Core::IidMapRegistrator<TipsManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ITipsManager_tie* obj, TipsManager*& ret_, bool interface_addref = false);

	static void make_tie (const TipsManager* obj, ITipsManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const TipsManager& obj, ITipsManager_tie*& ret_, const Core::TIEBase* owner);

	TipsManager* m_impl;

protected:
	virtual void __stdcall get_current_tip_47B572E3010B (
		NodeIndexPath_tie*& ret_
	) const;

	virtual bool __stdcall is_exist_47B93A910257 () const;


	virtual void __stdcall get_tips_tree_root (INodeBase_tie*& ret_) /*throw (CanNotFindData_tie)*/;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_TIPS_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

