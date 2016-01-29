////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewInterfaces/NewInterfaces_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWINTERFACES_TIE_H__
#define __TESTMODEL_BASICTESTS_NEWINTERFACES_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfaces.h"

namespace BasicTests {
namespace NewInterfaces {

class INewFacet_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) NewFacet_tie: public INewFacet_tie {
	SET_OBJECT_COUNTER (NewFacet_tie)
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
	NewFacet_tie ();

	typedef ::Core::PoolObjectManager<NewFacet_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<NewFacet_tie> Pool;
	friend class ::Core::PoolObjectManager<NewFacet_tie>;
	typedef ::Core::IidMapRegistrator<NewFacet_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const INewFacet_tie* obj, NewFacet*& ret_, bool interface_addref = false);

	static void make_tie (const NewFacet* obj, INewFacet_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const NewFacet& obj, INewFacet_tie*& ret_, const Core::TIEBase* owner);

	NewFacet* m_impl;

protected:

};

class IBaseInterface_tie: public ::Core::IIObject_tie {
public:

	virtual long __stdcall get_agr_long_p () const = 0;
	virtual void __stdcall set_agr_long_p (long agr_long_p) = 0;


	virtual void __stdcall get_agr_struct_p (NewStruct& ret_) const = 0;
	virtual void __stdcall set_agr_struct_p (const NewStruct agr_struct_p) = 0;


	virtual const long __stdcall get_lnk_long_p () const = 0;
	virtual void __stdcall set_lnk_long_p (long lnk_long_p) = 0;


	virtual void __stdcall get_lnk_struct_p (NewStruct& ret_) const = 0;
	virtual void __stdcall set_lnk_struct_p (const NewStruct lnk_struct_p) = 0;
};

class __declspec (dllexport) BaseInterface_tie: public IBaseInterface_tie {
	SET_OBJECT_COUNTER (BaseInterface_tie)
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
	BaseInterface_tie ();

	typedef ::Core::PoolObjectManager<BaseInterface_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<BaseInterface_tie> Pool;
	friend class ::Core::PoolObjectManager<BaseInterface_tie>;
	typedef ::Core::IidMapRegistrator<BaseInterface_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBaseInterface_tie* obj, BaseInterface*& ret_, bool interface_addref = false);

	static void make_tie (const BaseInterface* obj, IBaseInterface_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const BaseInterface& obj, IBaseInterface_tie*& ret_, const Core::TIEBase* owner);

	BaseInterface* m_impl;

protected:

	virtual long __stdcall get_agr_long_p () const;
	virtual void __stdcall set_agr_long_p (long agr_long_p);


	virtual void __stdcall get_agr_struct_p (NewStruct& ret_) const;
	virtual void __stdcall set_agr_struct_p (const NewStruct agr_struct_p);


	virtual const long __stdcall get_lnk_long_p () const;
	virtual void __stdcall set_lnk_long_p (long lnk_long_p);


	virtual void __stdcall get_lnk_struct_p (NewStruct& ret_) const;
	virtual void __stdcall set_lnk_struct_p (const NewStruct lnk_struct_p);
};

class MySyperData_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (MySyperData_tie)
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
	MySyperData_tie ();

	typedef ::Core::PoolObjectManager<MySyperData_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MySyperData_tie> Pool;
	friend class ::Core::PoolObjectManager<MySyperData_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const MySyperData_tie* obj, MySyperData*& ret_);

	static void make_tie (MySyperData* obj, MySyperData_tie*& ret_);
	
	static void make_tie (const MySyperData& obj, MySyperData_tie*& ret_);

	static void make_tie (const MySyperData& obj, MySyperData_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (MySyperData* obj, MySyperData_tie*& ret_);

	MySyperData* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual long long __stdcall get_item (size_t index);
	virtual void __stdcall set_item (size_t index, long long item);
	virtual size_t __stdcall add (long long item);
	virtual size_t __stdcall insert (size_t index, long long item);
};

class IDerivedInterface_tie: public IBaseInterface_tie {
public:
	virtual void __stdcall my_func_49BA60BC0263 (
		const MySyperData_tie* a
	) const = 0;
};

class __declspec (dllexport) DerivedInterface_tie: public IDerivedInterface_tie {
	SET_OBJECT_COUNTER (DerivedInterface_tie)
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
	DerivedInterface_tie ();

	typedef ::Core::PoolObjectManager<DerivedInterface_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DerivedInterface_tie> Pool;
	friend class ::Core::PoolObjectManager<DerivedInterface_tie>;
	typedef ::Core::IidMapRegistrator<DerivedInterface_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDerivedInterface_tie* obj, DerivedInterface*& ret_, bool interface_addref = false);

	static void make_tie (const DerivedInterface* obj, IDerivedInterface_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DerivedInterface& obj, IDerivedInterface_tie*& ret_, const Core::TIEBase* owner);

	DerivedInterface* m_impl;

protected:

	virtual const long __stdcall get_lnk_long_p () const;
	virtual void __stdcall set_lnk_long_p (long lnk_long_p);


	virtual long __stdcall get_agr_long_p () const;
	virtual void __stdcall set_agr_long_p (long agr_long_p);


	virtual void __stdcall get_lnk_struct_p (NewStruct& ret_) const;
	virtual void __stdcall set_lnk_struct_p (const NewStruct lnk_struct_p);


	virtual void __stdcall get_agr_struct_p (NewStruct& ret_) const;
	virtual void __stdcall set_agr_struct_p (const NewStruct agr_struct_p);
	virtual void __stdcall my_func_49BA60BC0263 (
		const MySyperData_tie* a
	) const;
};

class IAbstractInterface_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) AbstractInterface_tie: public IAbstractInterface_tie {
	SET_OBJECT_COUNTER (AbstractInterface_tie)
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
	AbstractInterface_tie ();

	typedef ::Core::PoolObjectManager<AbstractInterface_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<AbstractInterface_tie> Pool;
	friend class ::Core::PoolObjectManager<AbstractInterface_tie>;
	typedef ::Core::IidMapRegistrator<AbstractInterface_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IAbstractInterface_tie* obj, AbstractInterface*& ret_, bool interface_addref = false);

	static void make_tie (const AbstractInterface* obj, IAbstractInterface_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const AbstractInterface& obj, IAbstractInterface_tie*& ret_, const Core::TIEBase* owner);

	AbstractInterface* m_impl;

protected:

};

class IBaseInterface1_tie: public IAbstractInterface_tie {
public:

};

class __declspec (dllexport) BaseInterface1_tie: public IBaseInterface1_tie {
	SET_OBJECT_COUNTER (BaseInterface1_tie)
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
	BaseInterface1_tie ();

	typedef ::Core::PoolObjectManager<BaseInterface1_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<BaseInterface1_tie> Pool;
	friend class ::Core::PoolObjectManager<BaseInterface1_tie>;
	typedef ::Core::IidMapRegistrator<BaseInterface1_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IBaseInterface1_tie* obj, BaseInterface1*& ret_, bool interface_addref = false);

	static void make_tie (const BaseInterface1* obj, IBaseInterface1_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const BaseInterface1& obj, IBaseInterface1_tie*& ret_, const Core::TIEBase* owner);

	BaseInterface1* m_impl;

protected:

};

class IDerivedInterface1_tie: public IBaseInterface1_tie {
public:

};

class __declspec (dllexport) DerivedInterface1_tie: public IDerivedInterface1_tie {
	SET_OBJECT_COUNTER (DerivedInterface1_tie)
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
	DerivedInterface1_tie ();

	typedef ::Core::PoolObjectManager<DerivedInterface1_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<DerivedInterface1_tie> Pool;
	friend class ::Core::PoolObjectManager<DerivedInterface1_tie>;
	typedef ::Core::IidMapRegistrator<DerivedInterface1_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IDerivedInterface1_tie* obj, DerivedInterface1*& ret_, bool interface_addref = false);

	static void make_tie (const DerivedInterface1* obj, IDerivedInterface1_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const DerivedInterface1& obj, IDerivedInterface1_tie*& ret_, const Core::TIEBase* owner);

	DerivedInterface1* m_impl;

protected:

};

class IB_tie: public ::Core::IIObject_tie {
public:

};

class __declspec (dllexport) B_tie: public IB_tie {
	SET_OBJECT_COUNTER (B_tie)
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
	B_tie ();

	typedef ::Core::PoolObjectManager<B_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<B_tie> Pool;
	friend class ::Core::PoolObjectManager<B_tie>;
	typedef ::Core::IidMapRegistrator<B_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IB_tie* obj, B*& ret_, bool interface_addref = false);

	static void make_tie (const B* obj, IB_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const B& obj, IB_tie*& ret_, const Core::TIEBase* owner);

	B* m_impl;

protected:

};

typedef IB_tie IMyB_tie;

class IA_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall op1_4C5BBE680333 (
		TieStruct& ret_
	) const = 0;

	virtual void __stdcall op2_4C5BBE9A0110 (
		const IMyB_tie* arg
	) const = 0;
};

class __declspec (dllexport) A_tie: public IA_tie {
	SET_OBJECT_COUNTER (A_tie)
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
	A_tie ();

	typedef ::Core::PoolObjectManager<A_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<A_tie> Pool;
	friend class ::Core::PoolObjectManager<A_tie>;
	typedef ::Core::IidMapRegistrator<A_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IA_tie* obj, A*& ret_, bool interface_addref = false);

	static void make_tie (const A* obj, IA_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const A& obj, IA_tie*& ret_, const Core::TIEBase* owner);

	A* m_impl;

protected:
	virtual void __stdcall op1_4C5BBE680333 (
		TieStruct& ret_
	) const;

	virtual void __stdcall op2_4C5BBE9A0110 (
		const IMyB_tie* arg
	) const;
};

} // namespace NewInterfaces
} // namespace BasicTests
	

#endif //__TESTMODEL_BASICTESTS_NEWINTERFACES_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

