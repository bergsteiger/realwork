////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// Список фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"

namespace GblAdapterLib {

class IPharmFirmListEntry_tie: public IEntityBase_tie {
public:
	virtual void __stdcall get_document_47E8E09A02D3 (
		IDocument_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) PharmFirmListEntry_tie: public IPharmFirmListEntry_tie {
	SET_OBJECT_COUNTER (PharmFirmListEntry_tie)
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
	PharmFirmListEntry_tie ();

	typedef ::Core::PoolObjectManager<PharmFirmListEntry_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<PharmFirmListEntry_tie> Pool;
	friend class ::Core::PoolObjectManager<PharmFirmListEntry_tie>;
	typedef ::Core::IidMapRegistrator<PharmFirmListEntry_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IPharmFirmListEntry_tie* obj, PharmFirmListEntry*& ret_, bool interface_addref = false);

	static void make_tie (const PharmFirmListEntry* obj, IPharmFirmListEntry_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const PharmFirmListEntry& obj, IPharmFirmListEntry_tie*& ret_, const Core::TIEBase* owner);

	PharmFirmListEntry* m_impl;

protected:

	virtual bool __stdcall get_is_saved () const;


	virtual bool __stdcall get_is_changed () const;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/;

	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/;
	virtual void __stdcall get_document_47E8E09A02D3 (
		IDocument_tie*& ret_
	) const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

