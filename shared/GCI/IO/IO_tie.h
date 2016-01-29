////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/IO/IO_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// пакет интерфейсов ввода-вывода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_TIE_H__
#define __SHARED_GCI_IO_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "shared/GCI/IO/IO.h"

namespace GCI {
namespace IO {

class IString_tie: public ::Core::IIObject_tie {
public:
	virtual const char* __stdcall add_43185CB60312 (
		const char* str
	) = 0;

	virtual const char* __stdcall add_43185CF2021E (
		const IString_tie* str
	) = 0;


	virtual short __stdcall get_code_page () const = 0;
	virtual void __stdcall set_code_page (short code_page) = 0;


	virtual const char* __stdcall get_data () const = 0;


	virtual unsigned long __stdcall get_length () const = 0;


	virtual unsigned long __stdcall get_maximum () const = 0;
	virtual void __stdcall set_maximum (unsigned long maximum) = 0;

	virtual void __stdcall reset_431841610366 (
		const char* str
	) = 0;

	virtual void __stdcall strdup_431841610362 (
		IString_tie*& ret_
	) const = 0;
};

class __declspec (dllexport) String_tie: public IString_tie {
	SET_OBJECT_COUNTER (String_tie)
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
	String_tie ();

	typedef ::Core::PoolObjectManager<String_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<String_tie> Pool;
	friend class ::Core::PoolObjectManager<String_tie>;
	typedef ::Core::IidMapRegistrator<String_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IString_tie* obj, String*& ret_, bool interface_addref = false);

	static void make_tie (const String* obj, IString_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const String& obj, IString_tie*& ret_, const Core::TIEBase* owner);

	String* m_impl;

protected:
	virtual const char* __stdcall add_43185CB60312 (
		const char* str
	);

	virtual const char* __stdcall add_43185CF2021E (
		const IString_tie* str
	);


	virtual short __stdcall get_code_page () const;
	virtual void __stdcall set_code_page (short code_page);


	virtual const char* __stdcall get_data () const;


	virtual unsigned long __stdcall get_length () const;


	virtual unsigned long __stdcall get_maximum () const;
	virtual void __stdcall set_maximum (unsigned long maximum);

	virtual void __stdcall reset_431841610366 (
		const char* str
	);

	virtual void __stdcall strdup_431841610362 (
		IString_tie*& ret_
	) const;
};

class IStream_tie: public ::Core::TIEBase {
public:
// user defined TIE-wrapper for native outside interafce
	//#UC START# *4423FB5903D8_INTERFACE*
	virtual unsigned long __stdcall read_4423FC9C0290 (
		void* buffer
		, unsigned long size
		, unsigned long& actually_read
	) = 0;

	virtual unsigned long __stdcall write_4423FCA20232 (
		const void* buffer
		, unsigned long size
		, unsigned long& actually_written
	) = 0;

	virtual unsigned long __stdcall seek_4423FCA9030D (
		long long offset
		, unsigned long whence
		, unsigned long long& actually_offset
	) = 0;

	virtual unsigned long __stdcall set_size_4423FCAD035B (
		unsigned long long size
	) = 0;

	virtual unsigned long __stdcall copy_to_4423FCB4029F (
		const IStream_tie* dst
		, unsigned long long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	) = 0;

	virtual unsigned long __stdcall commit_4423FCBC0177 (
		unsigned long flags
	) = 0;

	virtual unsigned long __stdcall revert_4423FCC203D8 () = 0;

	virtual unsigned long __stdcall lock_region_4423FCCF0203 (
		unsigned long long offset
		, unsigned long long size
		, unsigned long flags
	) = 0;

	virtual unsigned long __stdcall unlock_region_4423FCD70000 (
		unsigned long long offset
		, unsigned long long size
		, unsigned long flags
	) = 0;

	virtual unsigned long __stdcall stat_4423FCE00290 (
		void* stat
		, unsigned long flags
	) = 0;

	virtual unsigned long __stdcall clone_4423FCE3036B (
		IStream_tie*& stream
	) = 0;
	//#UC END# *4423FB5903D8_INTERFACE*
};

class __declspec (dllexport) Stream_tie: public IStream_tie {
	SET_OBJECT_COUNTER (Stream_tie)
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
	Stream_tie ();

	typedef ::Core::PoolObjectManager<Stream_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Stream_tie> Pool;
	friend class ::Core::PoolObjectManager<Stream_tie>;
	typedef ::Core::IidMapRegistrator<Stream_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IStream_tie* obj, Stream*& ret_, bool interface_addref = false);

	static void make_tie (const Stream* obj, IStream_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Stream& obj, IStream_tie*& ret_, const Core::TIEBase* owner);

	Stream* m_impl;

protected:
// user defined TIE-wrapper for native outside interafce
	//#UC START# *4423FB5903D8*
	virtual unsigned long __stdcall read_4423FC9C0290 (
		void* buffer
		, unsigned long size
		, unsigned long& actually_read
	);

	virtual unsigned long __stdcall write_4423FCA20232 (
		const void* buffer
		, unsigned long size
		, unsigned long& actually_written
	);

	virtual unsigned long __stdcall seek_4423FCA9030D (
		long long offset
		, unsigned long whence
		, unsigned long long& actually_offset
	);

	virtual unsigned long __stdcall set_size_4423FCAD035B (
		unsigned long long size
	);

	virtual unsigned long __stdcall copy_to_4423FCB4029F (
		const IStream_tie* dst
		, unsigned long long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	);

	virtual unsigned long __stdcall commit_4423FCBC0177 (
		unsigned long flags
	);

	virtual unsigned long __stdcall revert_4423FCC203D8 ();

	virtual unsigned long __stdcall lock_region_4423FCCF0203 (
		unsigned long long offset
		, unsigned long long size
		, unsigned long flags
	);

	virtual unsigned long __stdcall unlock_region_4423FCD70000 (
		unsigned long long offset
		, unsigned long long size
		, unsigned long flags
	);

	virtual unsigned long __stdcall stat_4423FCE00290 (
		void* stat
		, unsigned long flags
	);

	virtual unsigned long __stdcall clone_4423FCE3036B (
		IStream_tie*& stream
	);
	//#UC END# *4423FB5903D8*

};

} // namespace IO
} // namespace GCI
	

#endif //__SHARED_GCI_IO_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

