////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::MainMenu
//
// Основное меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"

namespace GblAdapterLib {

class ISectionItem_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_) = 0;

	virtual void __stdcall open_4E36C80302E6 (
		Core::IIObject_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) SectionItem_tie: public ISectionItem_tie {
	SET_OBJECT_COUNTER (SectionItem_tie)
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
	SectionItem_tie ();

	typedef ::Core::PoolObjectManager<SectionItem_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SectionItem_tie> Pool;
	friend class ::Core::PoolObjectManager<SectionItem_tie>;
	typedef ::Core::IidMapRegistrator<SectionItem_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISectionItem_tie* obj, SectionItem*& ret_, bool interface_addref = false);

	static void make_tie (const SectionItem* obj, ISectionItem_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const SectionItem& obj, ISectionItem_tie*& ret_, const Core::TIEBase* owner);

	SectionItem* m_impl;

protected:

	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_);

	virtual void __stdcall open_4E36C80302E6 (
		Core::IIObject_tie*& ret_
	) const;
};

class SectionItemList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (SectionItemList_tie)
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
	SectionItemList_tie ();

	typedef ::Core::PoolObjectManager<SectionItemList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<SectionItemList_tie> Pool;
	friend class ::Core::PoolObjectManager<SectionItemList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const SectionItemList_tie* obj, SectionItemList*& ret_);

	static void make_tie (SectionItemList* obj, SectionItemList_tie*& ret_);
	
	static void make_tie (const SectionItemList& obj, SectionItemList_tie*& ret_);

	static void make_tie (const SectionItemList& obj, SectionItemList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (SectionItemList* obj, SectionItemList_tie*& ret_);

	SectionItemList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, ISectionItem_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const ISectionItem_tie* item);
	virtual size_t __stdcall add (const ISectionItem_tie* item);
	virtual size_t __stdcall insert (size_t index, const ISectionItem_tie* item);
};

class ISection_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_) = 0;

	virtual void __stdcall get_items_4E37CA4300B7 (
		SectionItemList_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) Section_tie: public ISection_tie {
	SET_OBJECT_COUNTER (Section_tie)
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
	Section_tie ();

	typedef ::Core::PoolObjectManager<Section_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Section_tie> Pool;
	friend class ::Core::PoolObjectManager<Section_tie>;
	typedef ::Core::IidMapRegistrator<Section_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const ISection_tie* obj, Section*& ret_, bool interface_addref = false);

	static void make_tie (const Section* obj, ISection_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Section& obj, ISection_tie*& ret_, const Core::TIEBase* owner);

	Section* m_impl;

protected:

	virtual void __stdcall get_caption (GCI::IO::IString_tie*& ret_);

	virtual void __stdcall get_items_4E37CA4300B7 (
		SectionItemList_tie*& ret_
	) const;
};

class IMainMenu_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_base_search_panes_4DD24C3000F5 (
		INodeBase_tie*& ret_
	) const = 0;

	virtual void __stdcall get_section_4E3012910002 (
		SectionType type
		, ISection_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) MainMenu_tie: public IMainMenu_tie {
	SET_OBJECT_COUNTER (MainMenu_tie)
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
	MainMenu_tie ();

	typedef ::Core::PoolObjectManager<MainMenu_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MainMenu_tie> Pool;
	friend class ::Core::PoolObjectManager<MainMenu_tie>;
	typedef ::Core::IidMapRegistrator<MainMenu_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMainMenu_tie* obj, MainMenu*& ret_, bool interface_addref = false);

	static void make_tie (const MainMenu* obj, IMainMenu_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const MainMenu& obj, IMainMenu_tie*& ret_, const Core::TIEBase* owner);

	MainMenu* m_impl;

protected:
	virtual void __stdcall get_base_search_panes_4DD24C3000F5 (
		INodeBase_tie*& ret_
	) const;

	virtual void __stdcall get_section_4E3012910002 (
		SectionType type
		, ISection_tie*& ret_
	) const;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

