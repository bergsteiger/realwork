////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.h"

namespace GblAdapterLib {

class IExternalLink_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_url (GCI::IO::IString_tie*& ret_) = 0;
};

class __declspec (dllexport) ExternalLink_tie: public IExternalLink_tie {
	SET_OBJECT_COUNTER (ExternalLink_tie)
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
	ExternalLink_tie ();

	typedef ::Core::PoolObjectManager<ExternalLink_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ExternalLink_tie> Pool;
	friend class ::Core::PoolObjectManager<ExternalLink_tie>;
	typedef ::Core::IidMapRegistrator<ExternalLink_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IExternalLink_tie* obj, ExternalLink*& ret_, bool interface_addref = false);

	static void make_tie (const ExternalLink* obj, IExternalLink_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ExternalLink& obj, IExternalLink_tie*& ret_, const Core::TIEBase* owner);

	ExternalLink* m_impl;

protected:

	virtual void __stdcall get_url (GCI::IO::IString_tie*& ret_);
};

class IExternalObject_tie: public ::Core::IIObject_tie {
public:

	virtual const void* __stdcall get_data_pointer () const = 0;


	virtual unsigned long __stdcall get_data_size () const = 0;


	virtual ExternalObjectType __stdcall get_data_type () const = 0;


	virtual void __stdcall get_extension (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) = 0;
};

class __declspec (dllexport) ExternalObject_tie: public IExternalObject_tie {
	SET_OBJECT_COUNTER (ExternalObject_tie)
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
	ExternalObject_tie ();

	typedef ::Core::PoolObjectManager<ExternalObject_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ExternalObject_tie> Pool;
	friend class ::Core::PoolObjectManager<ExternalObject_tie>;
	typedef ::Core::IidMapRegistrator<ExternalObject_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IExternalObject_tie* obj, ExternalObject*& ret_, bool interface_addref = false);

	static void make_tie (const ExternalObject* obj, IExternalObject_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ExternalObject& obj, IExternalObject_tie*& ret_, const Core::TIEBase* owner);

	ExternalObject* m_impl;

protected:

	virtual const void* __stdcall get_data_pointer () const;


	virtual unsigned long __stdcall get_data_size () const;


	virtual ExternalObjectType __stdcall get_data_type () const;


	virtual void __stdcall get_extension (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);
};

class ISplashScreen_tie: public IExternalObject_tie {
public:

	virtual void __stdcall get_owner (GCI::IO::IString_tie*& ret_) = 0;


	virtual void __stdcall get_owner_caption (GCI::IO::IString_tie*& ret_) = 0;


	virtual short __stdcall get_show_time () const = 0;
};

class __declspec (dllexport) SplashScreen_tie: public ISplashScreen_tie {
	SET_OBJECT_COUNTER (SplashScreen_tie)
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
	SplashScreen_tie ();

	typedef ::Core::PoolObjectManager<SplashScreen_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SplashScreen_tie> Pool;
	friend class ::Core::PoolObjectManager<SplashScreen_tie>;
	typedef ::Core::IidMapRegistrator<SplashScreen_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISplashScreen_tie* obj, SplashScreen*& ret_, bool interface_addref = false);

	static void make_tie (const SplashScreen* obj, ISplashScreen_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const SplashScreen& obj, ISplashScreen_tie*& ret_, const Core::TIEBase* owner);

	SplashScreen* m_impl;

protected:

	virtual unsigned long __stdcall get_data_size () const;


	virtual const void* __stdcall get_data_pointer () const;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_extension (GCI::IO::IString_tie*& ret_);


	virtual ExternalObjectType __stdcall get_data_type () const;

	virtual void __stdcall get_owner (GCI::IO::IString_tie*& ret_);


	virtual void __stdcall get_owner_caption (GCI::IO::IString_tie*& ret_);


	virtual short __stdcall get_show_time () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

