////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::SearchProgressIndicator
//
// Прогрессиндикаторы для поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport_tie.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator {

class ICancelSearch_tie: public ICancelLongProcess_tie {
public:

};

class __declspec (dllexport) CancelSearch_tie: public ICancelSearch_tie {
	SET_OBJECT_COUNTER (CancelSearch_tie)
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
	CancelSearch_tie ();

	typedef ::Core::PoolObjectManager<CancelSearch_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<CancelSearch_tie> Pool;
	friend class ::Core::PoolObjectManager<CancelSearch_tie>;
	typedef ::Core::IidMapRegistrator<CancelSearch_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ICancelSearch_tie* obj, CancelSearch*& ret_, bool interface_addref = false);

	static void make_tie (const CancelSearch* obj, ICancelSearch_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const CancelSearch& obj, ICancelSearch_tie*& ret_, const Core::TIEBase* owner);

	CancelSearch* m_impl;

protected:
	virtual void __stdcall cancel_process_45EEE00D032A () const;

};


class IProgressIndicatorForSearch_tie;

// callback only cpp-wraper
class ProgressIndicatorForSearch_callback_tie : virtual public ProgressIndicatorForSearch, virtual public ::Core::IObject {
	SET_OBJECT_COUNTER (ProgressIndicatorForSearch_callback_tie)
	friend class IProgressIndicatorForSearch_tie;
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
	virtual void finish_process (const SearchEntity* entity) const;

	ProgressIndicatorForSearch_callback_tie ();

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;
// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

protected:
	typedef ::Core::PoolObjectManager<ProgressIndicatorForSearch_callback_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ProgressIndicatorForSearch_callback_tie> Pool;
	friend class ::Core::PoolObjectManager<ProgressIndicatorForSearch_callback_tie>;
	
public:
	mutable IProgressIndicatorForSearch_tie* m_impl;
};

// callback only abstarct interface
class IProgressIndicatorForSearch_tie {
public:
	virtual unsigned long __stdcall query_interface (const ::Core::ComIID& iid, void*& object) = 0;	
	virtual unsigned long __stdcall addref () const = 0;
	virtual unsigned long __stdcall release () const = 0;


	virtual long __stdcall get_max_count () const = 0;

	virtual void __stdcall set_current_45EEE00A025D (
		long cur_count
		, long arg
	) const = 0;
	virtual void __stdcall finish_process_462741D0012E (
		const ISearchEntity_tie* entity
	) const = 0;

	static void make_cpp (const IProgressIndicatorForSearch_tie* obj, ProgressIndicatorForSearch*& ret_, bool interface_addref = false);

	static void make_tie (IProgressIndicatorForSearch_tie* obj, ProgressIndicatorForSearch_callback_tie*& ret_);
};


} // namespace SearchProgressIndicator
} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

