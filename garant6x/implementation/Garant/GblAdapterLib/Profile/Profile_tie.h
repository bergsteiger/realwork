////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Profile/Profile_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Profile
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROFILE_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_PROFILE_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/Profile.h"

namespace GblAdapterLib {

class IStopWatch_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) StopWatch_tie: public IStopWatch_tie {
	SET_OBJECT_COUNTER (StopWatch_tie)
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
	StopWatch_tie ();

	typedef ::Core::PoolObjectManager<StopWatch_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<StopWatch_tie> Pool;
	friend class ::Core::PoolObjectManager<StopWatch_tie>;
	typedef ::Core::IidMapRegistrator<StopWatch_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IStopWatch_tie* obj, StopWatch*& ret_, bool interface_addref = false);

	static void make_tie (const StopWatch* obj, IStopWatch_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const StopWatch& obj, IStopWatch_tie*& ret_, const Core::TIEBase* owner);

	StopWatch* m_impl;

protected:

};

class IStopWatchEx_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) StopWatchEx_tie: public IStopWatchEx_tie {
	SET_OBJECT_COUNTER (StopWatchEx_tie)
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
	StopWatchEx_tie ();

	typedef ::Core::PoolObjectManager<StopWatchEx_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<StopWatchEx_tie> Pool;
	friend class ::Core::PoolObjectManager<StopWatchEx_tie>;
	typedef ::Core::IidMapRegistrator<StopWatchEx_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IStopWatchEx_tie* obj, StopWatchEx*& ret_, bool interface_addref = false);

	static void make_tie (const StopWatchEx* obj, IStopWatchEx_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const StopWatchEx& obj, IStopWatchEx_tie*& ret_, const Core::TIEBase* owner);

	StopWatchEx* m_impl;

protected:

};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_PROFILE_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

