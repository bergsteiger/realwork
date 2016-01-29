////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// Возможности, доступные через интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport.h"
#include "shared/GCI/IO/IO_tie.h"

namespace GblAdapterLib {

class IInternetSupport_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_url_for_document_4BD133E40285 (
		unsigned long doc_id
		, unsigned long para_id
		, GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_url_for_internet_version_4BD1456303BC (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual bool __stdcall is_internet_agent_enabled_4BD1396400A3 () const = 0;

	virtual bool __stdcall revision_check_enabled_4BD133C102AD () const = 0;

	virtual bool __stdcall show_warning_4D6648D000C3 () const = 0;
};

class __declspec (dllexport) InternetSupport_tie: public IInternetSupport_tie {
	SET_OBJECT_COUNTER (InternetSupport_tie)
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
	InternetSupport_tie ();

	typedef ::Core::PoolObjectManager<InternetSupport_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<InternetSupport_tie> Pool;
	friend class ::Core::PoolObjectManager<InternetSupport_tie>;
	typedef ::Core::IidMapRegistrator<InternetSupport_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IInternetSupport_tie* obj, InternetSupport*& ret_, bool interface_addref = false);

	static void make_tie (const InternetSupport* obj, IInternetSupport_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const InternetSupport& obj, IInternetSupport_tie*& ret_, const Core::TIEBase* owner);

	InternetSupport* m_impl;

protected:
	virtual void __stdcall get_url_for_document_4BD133E40285 (
		unsigned long doc_id
		, unsigned long para_id
		, GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_url_for_internet_version_4BD1456303BC (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual bool __stdcall is_internet_agent_enabled_4BD1396400A3 () const;

	virtual bool __stdcall revision_check_enabled_4BD133C102AD () const;

	virtual bool __stdcall show_warning_4D6648D000C3 () const;
};

class IDecisionsArchiveSupport_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall archive_available_4F71DD6B03AA () const = 0;

	virtual void __stdcall get_archive_url_4F71D47D0086 (
		GCI::IO::IString_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) DecisionsArchiveSupport_tie: public IDecisionsArchiveSupport_tie {
	SET_OBJECT_COUNTER (DecisionsArchiveSupport_tie)
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
	DecisionsArchiveSupport_tie ();

	typedef ::Core::PoolObjectManager<DecisionsArchiveSupport_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DecisionsArchiveSupport_tie> Pool;
	friend class ::Core::PoolObjectManager<DecisionsArchiveSupport_tie>;
	typedef ::Core::IidMapRegistrator<DecisionsArchiveSupport_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDecisionsArchiveSupport_tie* obj, DecisionsArchiveSupport*& ret_, bool interface_addref = false);

	static void make_tie (const DecisionsArchiveSupport* obj, IDecisionsArchiveSupport_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DecisionsArchiveSupport& obj, IDecisionsArchiveSupport_tie*& ret_, const Core::TIEBase* owner);

	DecisionsArchiveSupport* m_impl;

protected:
	virtual bool __stdcall archive_available_4F71DD6B03AA () const;

	virtual void __stdcall get_archive_url_4F71D47D0086 (
		GCI::IO::IString_tie*& ret_
	) const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

