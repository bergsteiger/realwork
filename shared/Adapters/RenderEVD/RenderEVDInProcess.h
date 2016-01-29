#ifndef _SHARED_ADAPTERS_RENDER_EVD_IN_PROCESS_H_
#define _SHARED_ADAPTERS_RENDER_EVD_IN_PROCESS_H_

#include "shared/Adapters/RenderEVD/RenderEVD.h"

namespace Adapters {

class RenderEVDInProcess : public RenderEVD {
public:
	RenderEVDInProcess ();
	~RenderEVDInProcess ();
	
	bool get_formula_bitmap (
		const char* evd_buffer
		, ACE_INT32 evd_buffer_size
		, ACE_INT32 number
		, ACE_INT32 zoom
		, GCI::IO::Stream* picture
	);

	bool get_rtf_by_evd (
		GCI::IO::Stream* evd_stream
		, GCI::IO::Stream* rtf_stream
		, const std::vector<ACE_INT32>& ignored_styles
		, const char* link_host
	);

	bool get_rtf_by_evd_with_style (
		GCI::IO::Stream* evd_stream
		, GCI::IO::Stream* rtf_stream
		, const std::string& style
		, const std::vector<ACE_INT32>& ignored_styles
		, const char* link_host
	);

	bool set_style_table (const std::string& style_table);
	
private:
	ACE_SHLIB_HANDLE m_handle;
	Core::Mutex m_lib_guard;	
};

typedef ACE_Singleton<RenderEVDInProcess, ACE_SYNCH_MUTEX> RenderEVDInProcessSingleton;

} // namespace Adapters

#endif // _SHARED_ADAPTERS_RENDER_EVD_IN_PROCESS_H_
