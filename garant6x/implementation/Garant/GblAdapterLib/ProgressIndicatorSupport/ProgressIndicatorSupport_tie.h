////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport.h"

namespace GblAdapterLib {


class IProgressIndicator_tie;

// callback only cpp-wraper
class ProgressIndicator_callback_tie : virtual public ProgressIndicator, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (ProgressIndicator_callback_tie)
	friend class IProgressIndicator_tie;
protected:
	virtual unsigned long addref () const;

	virtual unsigned long ref_count () const;

public:
	virtual unsigned long release () const;
	virtual long get_max_count () const;

	// Изменение состояния длительного процесса.
	// В качестве параметра cur_count подается либо число уже обработанных элементов, принимающих
	// участие в длительном процессе, либо число <=100 (при индикации в %).
	virtual void set_current (long cur_count, long arg) const;

	ProgressIndicator_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<ProgressIndicator_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ProgressIndicator_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<ProgressIndicator_callback_tie>;
	
public:
	mutable IProgressIndicator_tie* m_impl;
};

// callback only abstarct interface
class IProgressIndicator_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;


	virtual long __stdcall get_max_count () const = 0;

	virtual void __stdcall set_current_45EEE00A025D (
		long cur_count
		, long arg
	) const = 0;

	static void make_cpp (const IProgressIndicator_tie* obj, ProgressIndicator*& ret_, bool interface_addref = false);

	static void make_tie (IProgressIndicator_tie* obj, ProgressIndicator_callback_tie*& ret_);
};


class ICancelLongProcess_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall cancel_process_45EEE00D032A () const = 0;
};

class __declspec (dllexport) CancelLongProcess_tie: public ICancelLongProcess_tie {
	SET_OBJECT_COUNTER (CancelLongProcess_tie)
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
	CancelLongProcess_tie ();

	typedef ::Core::PoolObjectManager<CancelLongProcess_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<CancelLongProcess_tie> Pool;
	friend class ::Core::PoolObjectManager<CancelLongProcess_tie>;
	typedef ::Core::IidMapRegistrator<CancelLongProcess_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ICancelLongProcess_tie* obj, CancelLongProcess*& ret_, bool interface_addref = false);

	static void make_tie (const CancelLongProcess* obj, ICancelLongProcess_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const CancelLongProcess& obj, ICancelLongProcess_tie*& ret_, const Core::TIEBase* owner);

	CancelLongProcess* m_impl;

protected:
	virtual void __stdcall cancel_process_45EEE00D032A () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

