////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport_tie.h"

namespace GblAdapterLib {

class IExternalOperation_tie: public ::Core::IIObject_tie {
public:

	virtual ObjectId __stdcall get_id () const = 0;
};

class __declspec (dllexport) ExternalOperation_tie: public IExternalOperation_tie {
	SET_OBJECT_COUNTER (ExternalOperation_tie)
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
	ExternalOperation_tie ();

	typedef ::Core::PoolObjectManager<ExternalOperation_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ExternalOperation_tie> Pool;
	friend class ::Core::PoolObjectManager<ExternalOperation_tie>;
	typedef ::Core::IidMapRegistrator<ExternalOperation_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IExternalOperation_tie* obj, ExternalOperation*& ret_, bool interface_addref = false);

	static void make_tie (const ExternalOperation* obj, IExternalOperation_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ExternalOperation& obj, IExternalOperation_tie*& ret_, const Core::TIEBase* owner);

	ExternalOperation* m_impl;

protected:

	virtual ObjectId __stdcall get_id () const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

