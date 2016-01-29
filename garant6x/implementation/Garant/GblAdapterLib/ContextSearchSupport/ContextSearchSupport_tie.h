////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ContextSearchSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupport/ContextSearchSupport.h"

namespace GblAdapterLib {

class HighlightPositionList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (HighlightPositionList_tie)
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
	HighlightPositionList_tie ();

	typedef ::Core::PoolObjectManager<HighlightPositionList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<HighlightPositionList_tie> Pool;
	friend class ::Core::PoolObjectManager<HighlightPositionList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const HighlightPositionList_tie* obj, HighlightPositionList*& ret_);

	static void make_tie (HighlightPositionList* obj, HighlightPositionList_tie*& ret_);
	
	static void make_tie (const HighlightPositionList& obj, HighlightPositionList_tie*& ret_);

	static void make_tie (const HighlightPositionList& obj, HighlightPositionList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (HighlightPositionList* obj, HighlightPositionList_tie*& ret_);

	HighlightPositionList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, HighlightPosition& ret_);
	virtual void __stdcall set_item (size_t index, const HighlightPosition& item);
	virtual size_t __stdcall add (const HighlightPosition& item);
	virtual size_t __stdcall insert (size_t index, const HighlightPosition& item);
};

#pragma pack (push, 1)

struct ContextSearchResult_tie {
	unsigned long item_index;
	HighlightPositionList_tie* positions;
	
	static void make_cpp (const ContextSearchResult_tie& obj, ContextSearchResult& ret_);

	static void make_tie (const ContextSearchResult& obj, ContextSearchResult_tie& ret_);
};

#pragma pack (pop)

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_CONTEXTSEARCHSUPPORT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

