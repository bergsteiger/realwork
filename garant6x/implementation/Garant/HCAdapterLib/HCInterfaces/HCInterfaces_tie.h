////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// Интерфейсы для взаимодействия с отделом Пащака
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_TIE_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
#include "shared/GCI/IO/IO_tie.h"

namespace HCAdapterLib {
namespace HCInterfaces {

class IConsultingData_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall data_received_442BFEEF0399 () const = 0;

	virtual void __stdcall get_data_442BF015006D (
		GCI::IO::IStream_tie*& ret_
	) = 0;
};

class __declspec (dllexport) ConsultingData_tie: public IConsultingData_tie {
	SET_OBJECT_COUNTER (ConsultingData_tie)
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
	ConsultingData_tie ();

	typedef ::Core::PoolObjectManager<ConsultingData_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ConsultingData_tie> Pool;
	friend class ::Core::PoolObjectManager<ConsultingData_tie>;
	typedef ::Core::IidMapRegistrator<ConsultingData_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IConsultingData_tie* obj, ConsultingData*& ret_, bool interface_addref = false);

	static void make_tie (const ConsultingData* obj, IConsultingData_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ConsultingData& obj, IConsultingData_tie*& ret_, const Core::TIEBase* owner);

	ConsultingData* m_impl;

protected:
	virtual void __stdcall data_received_442BFEEF0399 () const;

	virtual void __stdcall get_data_442BF015006D (
		GCI::IO::IStream_tie*& ret_
	);
};

class IOnlineData_tie: public IConsultingData_tie {
public:

};

class __declspec (dllexport) OnlineData_tie: public IOnlineData_tie {
	SET_OBJECT_COUNTER (OnlineData_tie)
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
	OnlineData_tie ();

	typedef ::Core::PoolObjectManager<OnlineData_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<OnlineData_tie> Pool;
	friend class ::Core::PoolObjectManager<OnlineData_tie>;
	typedef ::Core::IidMapRegistrator<OnlineData_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IOnlineData_tie* obj, OnlineData*& ret_, bool interface_addref = false);

	static void make_tie (const OnlineData* obj, IOnlineData_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const OnlineData& obj, IOnlineData_tie*& ret_, const Core::TIEBase* owner);

	OnlineData* m_impl;

protected:
	virtual void __stdcall get_data_442BF015006D (
		GCI::IO::IStream_tie*& ret_
	);

	virtual void __stdcall data_received_442BFEEF0399 () const;

};

class IBusinessLogicLifeCycle_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall start_478619CE0231 () = 0;

	virtual void __stdcall stop_478619F80225 () = 0;
};

class __declspec (dllexport) BusinessLogicLifeCycle_tie: public IBusinessLogicLifeCycle_tie {
	SET_OBJECT_COUNTER (BusinessLogicLifeCycle_tie)
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
	BusinessLogicLifeCycle_tie ();

	typedef ::Core::PoolObjectManager<BusinessLogicLifeCycle_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<BusinessLogicLifeCycle_tie> Pool;
	friend class ::Core::PoolObjectManager<BusinessLogicLifeCycle_tie>;
	typedef ::Core::IidMapRegistrator<BusinessLogicLifeCycle_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBusinessLogicLifeCycle_tie* obj, BusinessLogicLifeCycle*& ret_, bool interface_addref = false);

	static void make_tie (const BusinessLogicLifeCycle* obj, IBusinessLogicLifeCycle_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const BusinessLogicLifeCycle& obj, IBusinessLogicLifeCycle_tie*& ret_, const Core::TIEBase* owner);

	BusinessLogicLifeCycle* m_impl;

protected:
	virtual void __stdcall start_478619CE0231 ();

	virtual void __stdcall stop_478619F80225 ();
};

class IConsultingRequests_tie: public ::Core::IIObject_tie {
public:
	virtual ResultValue __stdcall erase_queries_by_id_47B0663F0363 (
		GCI::IO::IStream_tie* query
		, GCI::IO::IStream_tie*& result
	) const = 0;

	virtual ResultValue __stdcall get_list_of_new_queries_4EE08E2C0010 (
		GCI::IO::IStream_tie*& result
	) const = 0;

	virtual ResultValue __stdcall get_next_mark_442BFFFE038A (
		IConsultingData_tie*& data
	) const = 0;

	virtual ResultValue __stdcall get_query_by_id_442BFF9202EE (
		const QueryID query_id
		, IConsultingData_tie*& data
	) const = 0;

	virtual ResultValue __stdcall get_status_statistic_45B49CBD03B9 (
		GCI::IO::IStream_tie* query
		, GCI::IO::IStream_tie*& result
	) const = 0;

	virtual ResultValue __stdcall set_answer_442C007702FD (
		GCI::IO::IStream_tie* answer
	) const = 0;

	virtual ResultValue __stdcall sign_query_484402BF023D (
		GCI::IO::IStream_tie* query
		, GCI::IO::IStream_tie*& signed_query
	) const = 0;
};

class __declspec (dllexport) ConsultingRequests_tie: public IConsultingRequests_tie {
	SET_OBJECT_COUNTER (ConsultingRequests_tie)
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
	ConsultingRequests_tie ();

	typedef ::Core::PoolObjectManager<ConsultingRequests_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ConsultingRequests_tie> Pool;
	friend class ::Core::PoolObjectManager<ConsultingRequests_tie>;
	typedef ::Core::IidMapRegistrator<ConsultingRequests_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IConsultingRequests_tie* obj, ConsultingRequests*& ret_, bool interface_addref = false);

	static void make_tie (const ConsultingRequests* obj, IConsultingRequests_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ConsultingRequests& obj, IConsultingRequests_tie*& ret_, const Core::TIEBase* owner);

	ConsultingRequests* m_impl;

protected:
	virtual ResultValue __stdcall erase_queries_by_id_47B0663F0363 (
		GCI::IO::IStream_tie* query
		, GCI::IO::IStream_tie*& result
	) const;

	virtual ResultValue __stdcall get_list_of_new_queries_4EE08E2C0010 (
		GCI::IO::IStream_tie*& result
	) const;

	virtual ResultValue __stdcall get_next_mark_442BFFFE038A (
		IConsultingData_tie*& data
	) const;

	virtual ResultValue __stdcall get_query_by_id_442BFF9202EE (
		const QueryID query_id
		, IConsultingData_tie*& data
	) const;

	virtual ResultValue __stdcall get_status_statistic_45B49CBD03B9 (
		GCI::IO::IStream_tie* query
		, GCI::IO::IStream_tie*& result
	) const;

	virtual ResultValue __stdcall set_answer_442C007702FD (
		GCI::IO::IStream_tie* answer
	) const;

	virtual ResultValue __stdcall sign_query_484402BF023D (
		GCI::IO::IStream_tie* query
		, GCI::IO::IStream_tie*& signed_query
	) const;
};

} // namespace HCInterfaces
} // namespace HCAdapterLib
	

#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

