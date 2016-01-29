////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Prime/Prime_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search_tie.h"

namespace GblAdapterLib {

class IPrime_tie: public ::Core::IIObject_tie {
public:

	virtual PrimeKey __stdcall get_id () const = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_name (GCI::IO::IString_tie* name) = 0;


	virtual void __stdcall get_query (IQuery_tie*& ret_) = 0;
	virtual void __stdcall set_query (IQuery_tie* query) = 0;
};

class __declspec (dllexport) Prime_tie: public IPrime_tie {
	SET_OBJECT_COUNTER (Prime_tie)
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
	Prime_tie ();

	typedef ::Core::PoolObjectManager<Prime_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Prime_tie> Pool;
	friend class ::Core::PoolObjectManager<Prime_tie>;
	typedef ::Core::IidMapRegistrator<Prime_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IPrime_tie* obj, Prime*& ret_, bool interface_addref = false);

	static void make_tie (const Prime* obj, IPrime_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Prime& obj, IPrime_tie*& ret_, const Core::TIEBase* owner);

	Prime* m_impl;

protected:

	virtual PrimeKey __stdcall get_id () const;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_name (GCI::IO::IString_tie* name);


	virtual void __stdcall get_query (IQuery_tie*& ret_);
	virtual void __stdcall set_query (IQuery_tie* query);
};

class PrimeList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (PrimeList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	PrimeList_tie ();

	typedef ::Core::PoolObjectManager<PrimeList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PrimeList_tie> Pool;
	friend class ::Core::PoolObjectManager<PrimeList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const PrimeList_tie* obj, PrimeList*& ret_);

	static void make_tie (PrimeList* obj, PrimeList_tie*& ret_);
	
	static void make_tie (const PrimeList& obj, PrimeList_tie*& ret_);

	static void make_tie (const PrimeList& obj, PrimeList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (PrimeList* obj, PrimeList_tie*& ret_);

	PrimeList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, IPrime_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const IPrime_tie* item);
	virtual size_t __stdcall add (const IPrime_tie* item);
	virtual size_t __stdcall insert (size_t index, const IPrime_tie* item);
};

class KeysList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (KeysList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	KeysList_tie ();

	typedef ::Core::PoolObjectManager<KeysList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<KeysList_tie> Pool;
	friend class ::Core::PoolObjectManager<KeysList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const KeysList_tie* obj, KeysList*& ret_);

	static void make_tie (KeysList* obj, KeysList_tie*& ret_);
	
	static void make_tie (const KeysList& obj, KeysList_tie*& ret_);

	static void make_tie (const KeysList& obj, KeysList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (KeysList* obj, KeysList_tie*& ret_);

	KeysList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual PrimeKey __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, PrimeKey item);
	virtual size_t __stdcall add (PrimeKey item);
	virtual size_t __stdcall insert (size_t index, PrimeKey item);
};

class IPrimeManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall add_47C29A6A0154 (
		const GCI::IO::IString_tie* name
		, const IQuery_tie* query
		, IPrime_tie*& ret_
	) /*throw (DuplicateName_tie)*/ = 0;

	virtual bool __stdcall check_connection_to_online_server_5416C35E015D () const = 0;


	virtual bool __stdcall get_has_online_access () const = 0;


	virtual void __stdcall get_list (PrimeList_tie*& ret_) const = 0;

	virtual void __stdcall remove_47C29C2001FA (
		PrimeKey id
	) = 0;

	virtual void __stdcall save_and_send_to_online_server_5411BC740155 () const = 0;

	virtual void __stdcall save_list_to_xml_4BE3CF5C02CB (
		const KeysList_tie* keys
		, const char* xml_file_path
	) const /*throw (UnknownExportError_tie)*/ = 0;

	virtual void __stdcall save_mail_delivery_task_47C5860401E8 (
		const char* xml_file_path
	) const /*throw (UnknownExportError_tie)*/ = 0;

	virtual void __stdcall share_prime_for_file_server_47D4FEDA03DC () const /*throw (UnknownExportError_tie)*/ = 0;

	virtual void __stdcall update_4C88A58B02D8 () const = 0;
};

class __declspec (dllexport) PrimeManager_tie: public IPrimeManager_tie {
	SET_OBJECT_COUNTER (PrimeManager_tie)
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
	PrimeManager_tie ();

	typedef ::Core::PoolObjectManager<PrimeManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PrimeManager_tie> Pool;
	friend class ::Core::PoolObjectManager<PrimeManager_tie>;
	typedef ::Core::IidMapRegistrator<PrimeManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IPrimeManager_tie* obj, PrimeManager*& ret_, bool interface_addref = false);

	static void make_tie (const PrimeManager* obj, IPrimeManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const PrimeManager& obj, IPrimeManager_tie*& ret_, const Core::TIEBase* owner);

	PrimeManager* m_impl;

protected:
	virtual void __stdcall add_47C29A6A0154 (
		const GCI::IO::IString_tie* name
		, const IQuery_tie* query
		, IPrime_tie*& ret_
	) /*throw (DuplicateName_tie)*/;

	virtual bool __stdcall check_connection_to_online_server_5416C35E015D () const;


	virtual bool __stdcall get_has_online_access () const;


	virtual void __stdcall get_list (PrimeList_tie*& ret_) const;

	virtual void __stdcall remove_47C29C2001FA (
		PrimeKey id
	);

	virtual void __stdcall save_and_send_to_online_server_5411BC740155 () const;

	virtual void __stdcall save_list_to_xml_4BE3CF5C02CB (
		const KeysList_tie* keys
		, const char* xml_file_path
	) const /*throw (UnknownExportError_tie)*/;

	virtual void __stdcall save_mail_delivery_task_47C5860401E8 (
		const char* xml_file_path
	) const /*throw (UnknownExportError_tie)*/;

	virtual void __stdcall share_prime_for_file_server_47D4FEDA03DC () const /*throw (UnknownExportError_tie)*/;

	virtual void __stdcall update_4C88A58B02D8 () const;
};

class IPrimeSettingsManager_tie: public IBaseSettingsManager_tie {
public:

};

class __declspec (dllexport) PrimeSettingsManager_tie: public IPrimeSettingsManager_tie {
	SET_OBJECT_COUNTER (PrimeSettingsManager_tie)
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
	PrimeSettingsManager_tie ();

	typedef ::Core::PoolObjectManager<PrimeSettingsManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PrimeSettingsManager_tie> Pool;
	friend class ::Core::PoolObjectManager<PrimeSettingsManager_tie>;
	typedef ::Core::IidMapRegistrator<PrimeSettingsManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IPrimeSettingsManager_tie* obj, PrimeSettingsManager*& ret_, bool interface_addref = false);

	static void make_tie (const PrimeSettingsManager* obj, IPrimeSettingsManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const PrimeSettingsManager& obj, IPrimeSettingsManager_tie*& ret_, const Core::TIEBase* owner);

	PrimeSettingsManager* m_impl;

protected:
	virtual bool __stdcall get_bool_4AC4990B0238 (
		const PropertyStringID id
		, bool& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_int64_4AC4990F037A (
		const PropertyStringID id
		, long long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_long_4AC49912024A (
		const PropertyStringID id
		, long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_string_4AC499150301 (
		const PropertyStringID id
		, GCI::IO::IString_tie*& value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall get_ulong_4AC49919002B (
		const PropertyStringID id
		, unsigned long& value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_bool_4AC4991C01E1 (
		const PropertyStringID id
		, bool value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_int64_4AC4991F02F1 (
		const PropertyStringID id
		, long long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_long_4AC499220301 (
		const PropertyStringID id
		, long value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_string_4AC4992601BC (
		const PropertyStringID id
		, const char* value
	) /*throw (InvalidValueType_tie)*/;

	virtual void __stdcall set_ulong_4AC499290308 (
		const PropertyStringID id
		, unsigned long value
	) /*throw (InvalidValueType_tie)*/;

	virtual bool __stdcall is_exist_4AC4993302A8 (
		const PropertyStringID id
	) const;

};

class IPrimeContractData_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_area (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_client_name (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_email (GCI::IO::IString_tie*& ret_) = 0;

	virtual void __stdcall get_contract_evd_form_4D38192E0375 (
		GCI::IO::IStream_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/ = 0;


	virtual void __stdcall get_info_kind (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_organisation_type (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_profession (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_taxes (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_themes_name (GCI::IO::IString_tie*& ret_) = 0;
};

class __declspec (dllexport) PrimeContractData_tie: public IPrimeContractData_tie {
	SET_OBJECT_COUNTER (PrimeContractData_tie)
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
	PrimeContractData_tie ();

	typedef ::Core::PoolObjectManager<PrimeContractData_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PrimeContractData_tie> Pool;
	friend class ::Core::PoolObjectManager<PrimeContractData_tie>;
	typedef ::Core::IidMapRegistrator<PrimeContractData_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IPrimeContractData_tie* obj, PrimeContractData*& ret_, bool interface_addref = false);

	static void make_tie (const PrimeContractData* obj, IPrimeContractData_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const PrimeContractData& obj, IPrimeContractData_tie*& ret_, const Core::TIEBase* owner);

	PrimeContractData* m_impl;

protected:

	virtual void __stdcall get_area (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_client_name (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_email (GCI::IO::IString_tie*& ret_);

	virtual void __stdcall get_contract_evd_form_4D38192E0375 (
		GCI::IO::IStream_tie*& ret_
	) const /*throw (CanNotFindData_tie)*/;


	virtual void __stdcall get_info_kind (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_organisation_type (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_profession (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_taxes (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_themes_name (GCI::IO::IString_tie*& ret_);
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_PRIME_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

