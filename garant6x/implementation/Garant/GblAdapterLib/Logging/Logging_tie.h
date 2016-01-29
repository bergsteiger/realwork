////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Logging/Logging_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Logging
//
// Операции логирования действий пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_LOGGING_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_LOGGING_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Logging/Logging.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"

namespace GblAdapterLib {

class ILogEventData_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall add_date_4746DDAB022F (
		const Date& data
	) = 0;

	virtual void __stdcall add_object_45ED5973006A (
		const Core::IIObject_tie* data
	) = 0;

	virtual void __stdcall add_string_45ED5973006C (
		const char* data
	) = 0;

	virtual void __stdcall add_ulong_4746DD60023E (
		unsigned long data
	) = 0;
};

class __declspec (dllexport) LogEventData_tie: public ILogEventData_tie {
	SET_OBJECT_COUNTER (LogEventData_tie)
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
	LogEventData_tie ();

	typedef ::Core::PoolObjectManager<LogEventData_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<LogEventData_tie> Pool;
	friend class ::Core::PoolObjectManager<LogEventData_tie>;
	typedef ::Core::IidMapRegistrator<LogEventData_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ILogEventData_tie* obj, LogEventData*& ret_, bool interface_addref = false);

	static void make_tie (const LogEventData* obj, ILogEventData_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const LogEventData& obj, ILogEventData_tie*& ret_, const Core::TIEBase* owner);

	LogEventData* m_impl;

protected:
	virtual void __stdcall add_date_4746DDAB022F (
		const Date& data
	);

	virtual void __stdcall add_object_45ED5973006A (
		const Core::IIObject_tie* data
	);

	virtual void __stdcall add_string_45ED5973006C (
		const char* data
	);

	virtual void __stdcall add_ulong_4746DD60023E (
		unsigned long data
	);
};

class ILogManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall add_event_45ED59950192 (
		LogEvent log_event
		, ILogEventData_tie* data
	) = 0;
};

class __declspec (dllexport) LogManager_tie: public ILogManager_tie {
	SET_OBJECT_COUNTER (LogManager_tie)
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
	LogManager_tie ();

	typedef ::Core::PoolObjectManager<LogManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<LogManager_tie> Pool;
	friend class ::Core::PoolObjectManager<LogManager_tie>;
	typedef ::Core::IidMapRegistrator<LogManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ILogManager_tie* obj, LogManager*& ret_, bool interface_addref = false);

	static void make_tie (const LogManager* obj, ILogManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const LogManager& obj, ILogManager_tie*& ret_, const Core::TIEBase* owner);

	LogManager* m_impl;

protected:
	virtual void __stdcall add_event_45ED59950192 (
		LogEvent log_event
		, ILogEventData_tie* data
	);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_LOGGING_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

