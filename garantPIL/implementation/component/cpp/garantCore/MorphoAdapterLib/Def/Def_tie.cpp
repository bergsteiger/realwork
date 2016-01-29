////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/Def/Def_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// Интерфейсы и типы морфо-адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/Def_tie.h"

namespace MorphoAdapterLib {

const ::Core::ComIID MorphoAdapter_tie::s_com_iid = {0x2261F9E6, 0x0615, 0x4910, {0x8D, 0x58, 0x09, 0x8D, 0x1E, 0xA2, 0xCE, 0x2C}};

MorphoAdapter_tie::IidRegistrator MorphoAdapter_tie::s_iid_registrator;

MorphoAdapter_tie::MorphoAdapter_tie () : m_impl(NULL) {
}

unsigned long __stdcall MorphoAdapter_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall MorphoAdapter_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MorphoAdapter_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MorphoAdapter_tie* const>(this));
	}
	return counter;
}

void MorphoAdapter_tie::init () {
		m_counter = 1;
	}

void MorphoAdapter_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* MorphoAdapter_tie::cast (::Core::IObject* obj) {
	MorphoAdapter* ret = dynamic_cast<MorphoAdapter*>(obj);
	if (ret) {
		ret->addref();
	}
	IMorphoAdapter_tie* ret_ = NULL;
	MorphoAdapter_tie::make_tie (ret, ret_);
	return ret_;
}

void MorphoAdapter_tie::make_cpp (const IMorphoAdapter_tie* obj, MorphoAdapter*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<MorphoAdapter*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void MorphoAdapter_tie::make_tie (const MorphoAdapter* obj, IMorphoAdapter_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		MorphoAdapter_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<MorphoAdapter*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void MorphoAdapter_tie::make_tie (const MorphoAdapter& obj, IMorphoAdapter_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	MorphoAdapter_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<MorphoAdapter*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* MorphoAdapter_tie::get_impl () const {
	return m_impl;
}

size_t __stdcall MorphoAdapter_tie::normalize_4EA17BED0282 (
	const char* word
	, char* out
) {
_DLL_TRY
	return m_impl->normalize (word, out);
_DLL_CATCH
}



const ::Core::ComIID MlmaRu_tie::s_com_iid = {0xA835EF81, 0x9A98, 0x422C, {0x94, 0x54, 0xC4, 0xF9, 0xC1, 0x48, 0x48, 0xF5}};

MlmaRu_tie::IidRegistrator MlmaRu_tie::s_iid_registrator;

MlmaRu_tie::MlmaRu_tie () : m_impl(NULL) {
}

unsigned long __stdcall MlmaRu_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall MlmaRu_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MlmaRu_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MlmaRu_tie* const>(this));
	}
	return counter;
}

void MlmaRu_tie::init () {
		m_counter = 1;
	}

void MlmaRu_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* MlmaRu_tie::cast (::Core::IObject* obj) {
	MlmaRu* ret = dynamic_cast<MlmaRu*>(obj);
	if (ret) {
		ret->addref();
	}
	IMlmaRu_tie* ret_ = NULL;
	MlmaRu_tie::make_tie (ret, ret_);
	return ret_;
}

void MlmaRu_tie::make_cpp (const IMlmaRu_tie* obj, MlmaRu*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<MlmaRu*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void MlmaRu_tie::make_tie (const MlmaRu* obj, IMlmaRu_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		MlmaRu_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<MlmaRu*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void MlmaRu_tie::make_tie (const MlmaRu& obj, IMlmaRu_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	MlmaRu_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<MlmaRu*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* MlmaRu_tie::get_impl () const {
	return m_impl;
}

short __stdcall MlmaRu_tie::build_form_4EA56C9703D2 (
	const char* word
	, unsigned long id
	, unsigned short options
	, unsigned char form
	, char* res
	, unsigned short len
) {
_DLL_TRY
	return m_impl->build_form (word, id, options, form, res, len);
_DLL_CATCH
}

short __stdcall MlmaRu_tie::build_form_gi_4EA57CA10210 (
	const char* word
	, unsigned long lex_id
	, unsigned short options
	, unsigned short gr_info
	, unsigned char flags
	, char* dest
	, unsigned short cc_dest
) {
_DLL_TRY
	return m_impl->build_form_gi (word, lex_id, options, gr_info, flags, dest, cc_dest);
_DLL_CATCH
}

short __stdcall MlmaRu_tie::check_help_4EA57D4301DC (
	const char* word
	, char* list
) {
_DLL_TRY
	return m_impl->check_help (word, list);
_DLL_CATCH
}

short __stdcall MlmaRu_tie::check_word_4EA57C5F02D8 (
	const char* word
	, unsigned short options
) {
_DLL_TRY
	return m_impl->check_word (word, options);
_DLL_CATCH
}

short __stdcall MlmaRu_tie::lemmatize_4EA56A69023C (
	const char* word
	, unsigned short options
	, char* lemm
	, void* LIDs
	, char* gram
	, unsigned short nlemm
	, unsigned short nLID
	, unsigned short ngram
) {
_DLL_TRY
	return m_impl->lemmatize (word, options, lemm, LIDs, gram, nlemm, nLID, ngram);
_DLL_CATCH
}



const ::Core::ComIID MorphoManager_tie::s_com_iid = {0x4B31F9B1, 0xECFE, 0x4C7F, {0xB8, 0x2A, 0x0F, 0x93, 0xD4, 0xC4, 0x88, 0xBE}};

MorphoManager_tie::IidRegistrator MorphoManager_tie::s_iid_registrator;

MorphoManager_tie::MorphoManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall MorphoManager_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall MorphoManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall MorphoManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<MorphoManager_tie* const>(this));
	}
	return counter;
}

void MorphoManager_tie::init () {
		m_counter = 1;
	}

void MorphoManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* MorphoManager_tie::cast (::Core::IObject* obj) {
	MorphoManager* ret = dynamic_cast<MorphoManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IMorphoManager_tie* ret_ = NULL;
	MorphoManager_tie::make_tie (ret, ret_);
	return ret_;
}

void MorphoManager_tie::make_cpp (const IMorphoManager_tie* obj, MorphoManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<MorphoManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void MorphoManager_tie::make_tie (const MorphoManager* obj, IMorphoManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		MorphoManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<MorphoManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void MorphoManager_tie::make_tie (const MorphoManager& obj, IMorphoManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	MorphoManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<MorphoManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* MorphoManager_tie::get_impl () const {
	return m_impl;
}

void __stdcall MorphoManager_tie::done_4EA41F7F0354 () {
_DLL_TRY

	m_impl->done();
_DLL_CATCH
}

void __stdcall MorphoManager_tie::init_4EA41F5C039F (
	const char* base_path
) {
_DLL_TRY

	m_impl->init(base_path);
_DLL_CATCH
}



} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

