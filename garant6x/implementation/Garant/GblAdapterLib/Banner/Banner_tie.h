////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Banner/Banner_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// Баннеры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BANNER_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_BANNER_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.h"

namespace GblAdapterLib {

class IBanner_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_picture_4ACC85A303E1 (
		IExternalObject_tie*& ret_
	) const = 0;

	virtual void __stdcall open_link_4ACC6E5F00E5 (
		Core::IIObject_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;
};

class __declspec (dllexport) Banner_tie: public IBanner_tie {
	SET_OBJECT_COUNTER (Banner_tie)
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
	Banner_tie ();

	typedef ::Core::PoolObjectManager<Banner_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Banner_tie> Pool;
	friend class ::Core::PoolObjectManager<Banner_tie>;
	typedef ::Core::IidMapRegistrator<Banner_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBanner_tie* obj, Banner*& ret_, bool interface_addref = false);

	static void make_tie (const Banner* obj, IBanner_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Banner& obj, IBanner_tie*& ret_, const Core::TIEBase* owner);

	Banner* m_impl;

protected:
	virtual void __stdcall get_picture_4ACC85A303E1 (
		IExternalObject_tie*& ret_
	) const;

	virtual void __stdcall open_link_4ACC6E5F00E5 (
		Core::IIObject_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_BANNER_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

