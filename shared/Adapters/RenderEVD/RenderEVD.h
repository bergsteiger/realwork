#ifndef _SHARED_ADAPTERS_RENDER_EVD_H_
#define _SHARED_ADAPTERS_RENDER_EVD_H_

#include <string>
#include <deque>
#include <stdexcept>

#include "ace/os_include/os_dlfcn.h"
#include "shared/Core/sys/Exception.h"
#include "shared/GCI/IO/IO.h"            // gcc need it to compile 
#include "tao/Basic_Types.h"             // 'read_stream' function (see below)

namespace Adapters {
	
class RenderEVD {
public:
	class LibraryLoadError : public Core::Exception {
		const char* what () const throw () {
			return "Can't load RenderEVD.dll";
		}
		const char* uid () const /*throw ()*/ {
			return "Adapters::FormulasRenderer::LibraryLoadError";
		}		
	};

	class FunctionLoadError : public Core::Exception {
		const char* what () const throw () {
			return "GetProcAddress for 'RenderFormula' fails";
		}
		const char* uid () const /*throw ()*/ {
			return "Adapters::FormulasRenderer::FunctionLoadError";
		}		
	};

public:
	virtual bool get_formula_bitmap (
		const char* evd_buffer
		, ACE_INT32 evd_buffer_size
		, ACE_INT32 number
		, ACE_INT32 zoom
		, GCI::IO::Stream* picture
	) = 0;

	virtual bool get_rtf_by_evd (
		GCI::IO::Stream* evd_stream
		, GCI::IO::Stream* rtf_stream
		, const std::vector<ACE_INT32>& ignored_styles
		, const char* link_host
	) = 0;

	virtual bool get_rtf_by_evd_with_style (
		GCI::IO::Stream* evd_stream
		, GCI::IO::Stream* rtf_stream
		, const std::string& style
		, const std::vector<ACE_INT32>& ignored_styles
		, const char* link_host
	) = 0;

	virtual bool set_style_table (const std::string& style) = 0;
};

template<typename T>
T* read_stream (GCI::IO::Stream* stream) {

	typedef Core::Box<char, Core::ArrayDeleteDestructor<char> > BufBox;
	std::deque<BufBox> buf_list;
	const unsigned long BUF_SIZE = 1024;
	unsigned long last_size = 0;
	do {
		BufBox buf = new char [BUF_SIZE];
		if (last_size = stream->read (buf.inout (), BUF_SIZE)) {
			buf_list.push_back (buf);
		}
	} while (last_size == BUF_SIZE);
	
	if (buf_list.empty ()) {
		throw std::logic_error ("empty stream");
	}

	CORBA::ULong size = 
		static_cast<CORBA::ULong> (
			last_size ? 
				(buf_list.size () - 1) * BUF_SIZE + last_size 
				: buf_list.size () * BUF_SIZE
		);

	Core::Aptr<CORBA::Octet> octet_buffer = T::allocbuf (size);
	CORBA::Octet* dest = octet_buffer.ptr ();
	for (size_t i = 0, last_index = buf_list.size () - 1; i < buf_list.size (); ++i, dest += BUF_SIZE) {
		memcpy (dest, buf_list[i].ptr (), (i == last_index && last_size) ? last_size : BUF_SIZE);
	}
	
	return new T (size, size, octet_buffer.forget (), 1);
}

} // namespace Adapters

#endif // _SHARED_ADAPTERS_RENDER_EVD_H_
