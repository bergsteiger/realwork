////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/IO/IO_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// пакет интерфейсов ввода-вывода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IO_tie.h"
//#UC START# *4423F94903C8_CUSTOM_INCLUDE_FOR_NATIVE_DEFINITION*
#include "shared/GCI/impl/IO_i/MSDNStreamWrapper.h"
//#UC END# *4423F94903C8_CUSTOM_INCLUDE_FOR_NATIVE_DEFINITION*

namespace GCI {
namespace IO {

const ::Core::ComIID String_tie::s_com_iid = {0x952E8D0E, 0x1685, 0x49D2, {0xBF, 0xDB, 0xD8, 0x54, 0xF4, 0xBF, 0x01, 0x56}};

String_tie::IidRegistrator String_tie::s_iid_registrator;

String_tie::String_tie () : m_impl(NULL) {
}

unsigned long __stdcall String_tie::query_interface (
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
unsigned long __stdcall String_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall String_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<String_tie* const>(this));
	}
	return counter;
}

void String_tie::init () {
		m_counter = 1;
	}

void String_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* String_tie::cast (::Core::IObject* obj) {
	String* ret = dynamic_cast<String*>(obj);
	if (ret) {
		ret->addref();
	}
	IString_tie* ret_ = NULL;
	String_tie::make_tie (ret, ret_);
	return ret_;
}

void String_tie::make_cpp (const IString_tie* obj, String*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<String*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void String_tie::make_tie (const String* obj, IString_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		String_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<String*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void String_tie::make_tie (const String& obj, IString_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	String_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<String*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* String_tie::get_impl () const {
	return m_impl;
}

const char* __stdcall String_tie::add_43185CB60312 (
	const char* str
) {
_DLL_TRY
	return m_impl->add (str);
_DLL_CATCH
}

const char* __stdcall String_tie::add_43185CF2021E (
	const IString_tie* str
) {
_DLL_TRY
	String* str_;
	String_tie::make_cpp(str, str_);

	const char* ret = m_impl->add(str_);
	return ret;
_DLL_CATCH
}


short __stdcall String_tie::get_code_page () const {
_DLL_TRY
	return m_impl->get_code_page();
_DLL_CATCH
}
void __stdcall String_tie::set_code_page (short code_page) {
_DLL_TRY
	m_impl->set_code_page(code_page);
_DLL_CATCH
}


const char* __stdcall String_tie::get_data () const {
_DLL_TRY
	return m_impl->get_data();
_DLL_CATCH
}


unsigned long __stdcall String_tie::get_length () const {
_DLL_TRY
	return m_impl->get_length();
_DLL_CATCH
}


unsigned long __stdcall String_tie::get_maximum () const {
_DLL_TRY
	return m_impl->get_maximum();
_DLL_CATCH
}
void __stdcall String_tie::set_maximum (unsigned long maximum) {
_DLL_TRY
	m_impl->set_maximum(maximum);
_DLL_CATCH
}

void __stdcall String_tie::reset_431841610366 (
	const char* str
) {
_DLL_TRY

	m_impl->reset(str);
_DLL_CATCH
}

void __stdcall String_tie::strdup_431841610362 (
	IString_tie*& ret_
) const {
_DLL_TRY

	String* ret = m_impl->strdup();
	String_tie::make_tie(ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID Stream_tie::s_com_iid = {
	//#UC START# *4423FB5903D8_NATIVE_IID*
	0x0000000c, 0x0000, 0x0000, {0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46}
	//#UC END# *4423FB5903D8_NATIVE_IID*
};

Stream_tie::IidRegistrator Stream_tie::s_iid_registrator;

Stream_tie::Stream_tie () : m_impl(NULL) {
}

unsigned long __stdcall Stream_tie::query_interface (
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
unsigned long __stdcall Stream_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Stream_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Stream_tie* const>(this));
	}
	return counter;
}

void Stream_tie::init () {
		m_counter = 1;
	}

void Stream_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Stream_tie::cast (::Core::IObject* obj) {
	Stream* ret = dynamic_cast<Stream*>(obj);
	if (ret) {
		ret->addref();
	}
	IStream_tie* ret_ = NULL;
	Stream_tie::make_tie (ret, ret_);
	return ret_;
}

void Stream_tie::make_cpp (const IStream_tie* obj, Stream*& ret_, bool interface_addref) {
	//#UC START# *4423FB5903D8_NATIVE_DEFINITION_IMPL*
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = new GCI::IO_i::MSDNStreamWrapper (const_cast<IStream_tie*> (obj));
	}
	//#UC END# *4423FB5903D8_NATIVE_DEFINITION_IMPL*
}

void Stream_tie::make_tie (const Stream* obj, IStream_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Stream_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Stream*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Stream_tie::make_tie (const Stream& obj, IStream_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Stream_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Stream*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}


// user defined TIE-wrapper for native outside interafce
//#UC START# *4423FB5903D8*
#define TEST_STREAM_STATE if (m_impl->bad ()) return 0x8000FFFFUL;

unsigned long __stdcall Stream_tie::read_4423FC9C0290 (
	void* buffer
	, unsigned long size
	, unsigned long& actually_read
) {
_DLL_TRY
	TEST_STREAM_STATE

	actually_read = m_impl->read(buffer, size);
	if (m_impl->eof () && !actually_read) {
		return 1;
	}
	return 0;
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::write_4423FCA20232 (
	const void* buffer
	, unsigned long size
	, unsigned long& actually_written
) {
_DLL_TRY
	TEST_STREAM_STATE

	actually_written = m_impl->write(buffer, size);
	if (m_impl->eof () && !actually_written) {
		return 1;
	}
	return 0;
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::seek_4423FCA9030D (
	long long offset
	, unsigned long whence
	, unsigned long long& actually_offset
) {
_DLL_TRY
	TEST_STREAM_STATE
	try {
		actually_offset = m_impl->seek (static_cast<long> (offset), whence);
	} catch (GCI::IO::NotImplemented&) {
		return 0x80004001UL; // E_NOTIMPL
	} catch (GCI::IO::OperationError&) {
		return 0x80070057L; // E_INVALIDARG
	}
	return 0;
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::set_size_4423FCAD035B (
	unsigned long long size
) {
_DLL_TRY
	TEST_STREAM_STATE

	return 0x80004001UL; // E_NOTIMPL
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::copy_to_4423FCB4029F (
	const IStream_tie* dst
	, unsigned long long size
	, unsigned long long& actually_read
	, unsigned long long& actually_written
) {
_DLL_TRY
	TEST_STREAM_STATE

	IO::Stream_var _dst;			// Я правильно понял мы должны при выходе из метода убить созданный GCI::IO_i::MSDNStreamWrapper?
	Stream_tie::make_cpp(dst, _dst.out ());

	m_impl->copy_to(_dst.in (), static_cast<unsigned long> (size), actually_read, actually_written);

	return 0;
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::commit_4423FCBC0177 (
	unsigned long flags
) {
_DLL_TRY
	TEST_STREAM_STATE

	return 0x80004001UL; // E_NOTIMPL
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::revert_4423FCC203D8 () {
_DLL_TRY
	TEST_STREAM_STATE

	return 0x80004001UL; // E_NOTIMPL
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::lock_region_4423FCCF0203 (
	unsigned long long offset
	, unsigned long long size
	, unsigned long flags
) {
_DLL_TRY
	TEST_STREAM_STATE

	return 0x80004001UL; // E_NOTIMPL
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::unlock_region_4423FCD70000 (
	unsigned long long offset
	, unsigned long long size
	, unsigned long flags
) {
_DLL_TRY
	TEST_STREAM_STATE

	return 0x80004001UL; // E_NOTIMPL
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::stat_4423FCE00290 (
	void* stat
	, unsigned long flags
) {
_DLL_TRY
	TEST_STREAM_STATE

	return 0x80004001UL; // E_NOTIMPL
_DLL_CATCH
}

unsigned long __stdcall Stream_tie::clone_4423FCE3036B (
	IStream_tie*& stream
) {
_DLL_TRY
	TEST_STREAM_STATE

	return 0x80004001UL; // E_NOTIMPL
_DLL_CATCH
}

//#UC END# *4423FB5903D8*


} // namespace IO
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

