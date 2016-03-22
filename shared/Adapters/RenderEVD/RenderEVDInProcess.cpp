#include "ace/ACE.h"

#include "shared/Core/Params/Params.h"
#include "shared/GCI/IO/IO.h"
#include "shared/GCI/IO/IO_tie.h"
#include "shared/Adapters/RenderEVD/RenderEVDInProcess.h"
#include "shared/Adapters/RenderEVD/DefaultStyleTable.h"

namespace {

std::string get_evd_to_rtf_function_name () {
#if defined(_GCD_SERVER)
	static const char* EVD_TO_RTF_PARAMETER_NAME = "-EVDtoRTFWithoutCommentDecor";
	return Core::ParamManagerFactory::get ().get_ulong (EVD_TO_RTF_PARAMETER_NAME, 0)
		? std::string ("EVDtoRTFWithoutCommentDecor")
		: std::string ("EVDtoRTF");
#else
	return std::string ("EVDtoRTF");
#endif
}

}

namespace Adapters {

RenderEVDInProcess::RenderEVDInProcess () : m_handle (ACE_SHLIB_INVALID_HANDLE) {

	const ACE_TCHAR* name = (
		ACE_DLL_PREFIX \
		ACE_TEXT ("RenderEVD") \
		ACE_DLL_SUFFIX
	);

	m_handle = ACE_OS::dlopen (name);

	if (m_handle == ACE_SHLIB_INVALID_HANDLE) {
		throw LibraryLoadError ();
	}

	if (!this->set_style_table (Adapters::DefaultStyleTable::instance ()->get ())) {
		LOG_E (("%s: can't set default style table (%s)", GDS_CURRENT_FUNCTION, Adapters::DefaultStyleTable::instance ()->get ().c_str ()));
	}
}
	
RenderEVDInProcess::~RenderEVDInProcess () {
	try {
		if (m_handle != ACE_SHLIB_INVALID_HANDLE) {
			ACE_OS::dlclose (m_handle);
		}
	} catch (...) {
	}
}

bool RenderEVDInProcess::get_formula_bitmap (
	const char* evd_buffer
	, ACE_INT32 evd_buffer_size
	, ACE_INT32 number
	, ACE_INT32 zoom
	, GCI::IO::Stream* picture
) {
#if defined (WIN32)
	typedef bool (__stdcall *FunctionPtr) (const char*, ACE_INT32, ACE_INT32, ACE_INT32, GCI::IO::IStream_tie*);
#else
	typedef bool (*FunctionPtr) (const char*, ACE_INT32, ACE_INT32, ACE_INT32, GCI::IO::IStream_tie*);
#endif
	FunctionPtr function_ptr = (FunctionPtr) ACE_OS::dlsym (m_handle, ACE_TEXT ("RenderFormula"));

	if (!function_ptr) {
		throw FunctionLoadError ();
	}

	Core::Var<GCI::IO::IStream_tie> stream_tie ((GCI::IO::IStream_tie*) GCI::IO::Stream_tie::cast (picture));
	GUARD (m_lib_guard);
	return function_ptr (evd_buffer, evd_buffer_size, number, zoom, stream_tie.ptr ());
}

bool RenderEVDInProcess::get_rtf_by_evd (
	GCI::IO::Stream* evd_stream
	, GCI::IO::Stream* rtf_stream
	, const std::vector<ACE_INT32>& ignored_styles
	, const char* link_host
) {
#if defined (WIN32)
		typedef bool (__stdcall *EvdRtfFunctionPtr) (
			GCI::IO::IStream_tie*
			, GCI::IO::IStream_tie*
			, const ACE_INT32*
			, ACE_INT32
			, const char*
		);
#else
		typedef bool (*EvdRtfFunctionPtr) (
			GCI::IO::IStream_tie*
			, GCI::IO::IStream_tie*
			, const ACE_INT32*
			, ACE_INT32
			, const char*
		);
#endif
		static const std::string evd_to_rtf_function_name = get_evd_to_rtf_function_name ();
		EvdRtfFunctionPtr function_ptr = (EvdRtfFunctionPtr) ACE_OS::dlsym (m_handle, evd_to_rtf_function_name.c_str ());

		if (!function_ptr) {
			throw FunctionLoadError ();
		}

		Core::Var<GCI::IO::IStream_tie> evd_stream_tie ((GCI::IO::IStream_tie*) GCI::IO::Stream_tie::cast (evd_stream));
		Core::Var<GCI::IO::IStream_tie> rtf_stream_tie ((GCI::IO::IStream_tie*) GCI::IO::Stream_tie::cast (rtf_stream));

		GUARD (m_lib_guard);
		return ignored_styles.empty () ?
			function_ptr (evd_stream_tie.ptr (), rtf_stream_tie.ptr (), 0, 0, link_host)
			: function_ptr (evd_stream_tie.ptr (), rtf_stream_tie.ptr (), &ignored_styles[0], static_cast<ACE_INT32> (ignored_styles.size ()), link_host);
}

bool RenderEVDInProcess::set_style_table (const std::string& style_table) {
#if defined (WIN32)
		typedef bool (__stdcall *StyleTableFunctionPtr) (const char*, ACE_INT32);
#else
		typedef bool (*StyleTableFunctionPtr) (const char*, ACE_INT32);
#endif
	StyleTableFunctionPtr function_ptr = (StyleTableFunctionPtr) ACE_OS::dlsym (m_handle, ACE_TEXT ("SetStyleTable"));

	if (!function_ptr) {
		throw FunctionLoadError ();
	}

	GUARD (m_lib_guard);
	return function_ptr (style_table.data (), static_cast<ACE_INT32> (style_table.size ()));
}

bool RenderEVDInProcess::get_rtf_by_evd_with_style (
	GCI::IO::Stream* evd_stream
	, GCI::IO::Stream* rtf_stream
	, const std::string& style
	, const std::vector<ACE_INT32>& ignored_styles
	, const char* link_host
) {
	GDS_ASSERT ("this method now used only in the itnternet version (so you should use the 64x build)");

	GUARD (m_lib_guard);
	this->set_style_table (style);
	bool result = this->get_rtf_by_evd (evd_stream, rtf_stream, ignored_styles, link_host);
	this->set_style_table (Adapters::DefaultStyleTable::instance ()->get ());

	return result;
}

} // namespace Adapters


