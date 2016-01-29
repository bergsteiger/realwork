////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/Def/Def_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// Интерфейсы и типы морфо-адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_DEF_TIE_H__
#define __GARANTCORE_MORPHOADAPTERLIB_DEF_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garantCore/MorphoAdapterLib/Def/Def.h"

namespace MorphoAdapterLib {

class IMorphoAdapter_tie: public ::Core::IIObject_tie {
public:
	virtual size_t __stdcall normalize_4EA17BED0282 (
		const char* word
		, char* out
	) = 0;
};

class __declspec (dllexport) MorphoAdapter_tie: public IMorphoAdapter_tie {
	SET_OBJECT_COUNTER (MorphoAdapter_tie)
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
	MorphoAdapter_tie ();

	typedef ::Core::PoolObjectManager<MorphoAdapter_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MorphoAdapter_tie> Pool;
	friend class ::Core::PoolObjectManager<MorphoAdapter_tie>;
	typedef ::Core::IidMapRegistrator<MorphoAdapter_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMorphoAdapter_tie* obj, MorphoAdapter*& ret_, bool interface_addref = false);

	static void make_tie (const MorphoAdapter* obj, IMorphoAdapter_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const MorphoAdapter& obj, IMorphoAdapter_tie*& ret_, const Core::TIEBase* owner);

	MorphoAdapter* m_impl;

protected:
	virtual size_t __stdcall normalize_4EA17BED0282 (
		const char* word
		, char* out
	);
};

class IMlmaRu_tie: public ::Core::IIObject_tie {
public:
	virtual short __stdcall build_form_4EA56C9703D2 (
		const char* word
		, unsigned long id
		, unsigned short options
		, unsigned char form
		, char* res
		, unsigned short len
	) = 0;

	virtual short __stdcall build_form_gi_4EA57CA10210 (
		const char* word
		, unsigned long lex_id
		, unsigned short options
		, unsigned short gr_info
		, unsigned char flags
		, char* dest
		, unsigned short cc_dest
	) = 0;

	virtual short __stdcall check_help_4EA57D4301DC (
		const char* word
		, char* list
	) = 0;

	virtual short __stdcall check_word_4EA57C5F02D8 (
		const char* word
		, unsigned short options
	) = 0;

	virtual short __stdcall lemmatize_4EA56A69023C (
		const char* word
		, unsigned short options
		, char* lemm
		, void* LIDs
		, char* gram
		, unsigned short nlemm
		, unsigned short nLID
		, unsigned short ngram
	) = 0;
};

class __declspec (dllexport) MlmaRu_tie: public IMlmaRu_tie {
	SET_OBJECT_COUNTER (MlmaRu_tie)
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
	MlmaRu_tie ();

	typedef ::Core::PoolObjectManager<MlmaRu_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MlmaRu_tie> Pool;
	friend class ::Core::PoolObjectManager<MlmaRu_tie>;
	typedef ::Core::IidMapRegistrator<MlmaRu_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMlmaRu_tie* obj, MlmaRu*& ret_, bool interface_addref = false);

	static void make_tie (const MlmaRu* obj, IMlmaRu_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const MlmaRu& obj, IMlmaRu_tie*& ret_, const Core::TIEBase* owner);

	MlmaRu* m_impl;

protected:
	virtual short __stdcall build_form_4EA56C9703D2 (
		const char* word
		, unsigned long id
		, unsigned short options
		, unsigned char form
		, char* res
		, unsigned short len
	);

	virtual short __stdcall build_form_gi_4EA57CA10210 (
		const char* word
		, unsigned long lex_id
		, unsigned short options
		, unsigned short gr_info
		, unsigned char flags
		, char* dest
		, unsigned short cc_dest
	);

	virtual short __stdcall check_help_4EA57D4301DC (
		const char* word
		, char* list
	);

	virtual short __stdcall check_word_4EA57C5F02D8 (
		const char* word
		, unsigned short options
	);

	virtual short __stdcall lemmatize_4EA56A69023C (
		const char* word
		, unsigned short options
		, char* lemm
		, void* LIDs
		, char* gram
		, unsigned short nlemm
		, unsigned short nLID
		, unsigned short ngram
	);
};

class IMorphoManager_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall done_4EA41F7F0354 () = 0;

	virtual void __stdcall init_4EA41F5C039F (
		const char* base_path
	) = 0;
};

class __declspec (dllexport) MorphoManager_tie: public IMorphoManager_tie {
	SET_OBJECT_COUNTER (MorphoManager_tie)
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
	MorphoManager_tie ();

	typedef ::Core::PoolObjectManager<MorphoManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<MorphoManager_tie> Pool;
	friend class ::Core::PoolObjectManager<MorphoManager_tie>;
	typedef ::Core::IidMapRegistrator<MorphoManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IMorphoManager_tie* obj, MorphoManager*& ret_, bool interface_addref = false);

	static void make_tie (const MorphoManager* obj, IMorphoManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const MorphoManager& obj, IMorphoManager_tie*& ret_, const Core::TIEBase* owner);

	MorphoManager* m_impl;

protected:
	virtual void __stdcall done_4EA41F7F0354 ();

	virtual void __stdcall init_4EA41F5C039F (
		const char* base_path
	);
};

} // namespace MorphoAdapterLib
	

#endif //__GARANTCORE_MORPHOADAPTERLIB_DEF_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

