//
// ConvertProc.cpp : implementation file
//
#include "ace/ACE.h"

#include "shared/GCL/str/str_conv.h"
#include "ConvertProc.h"

namespace EndtConvertor {

bool is_true_before (const char* buf) {
	bool ret = false;
	size_t len = ACE_OS_String::strlen (buf);
	if (len > 0) {
		Core::Aptr <char> tmp (new char [len + 1]);
		ACE_OS_String::strcpy (tmp.inout (), buf);
		tmp.ptr () [len] = '\0';
		GCL::string_recoding (GCL::cd_dos, GCL::cd_win, tmp.inout (), 0);  
		GCL::string_lower (tmp.inout ());
		char* result = ACE_OS_String::strstr (tmp.inout (), "см");
		ret = (result != 0);
	}
	return ret;
}

unsigned get_space_count (const char* buf, unsigned pos) {
	long i = pos - 1;
	for (; i > 0 && buf [i] == ' '; --i);
	return pos - i - 1;
}

unsigned get_segment_start (const char* buf, unsigned cur_buff_len, long &pos) {
	unsigned ret = 0;
	if (cur_buff_len) {
		pos = cur_buff_len;
	} else {
		while (buf [ret] == ' ') {
			++ret;
		}
		pos = ret;
	}
	++pos;
	return ret;
}

void dump_para (const char* file_path, const char* para_buf, long len, size_t num) {
	FILE* file = mpcxc_fopen (file_path, "a");
	if (file) {
		if (len) {
			char buf [17000];
			char pbuf [17000];

			ACE_OS::strncpy (pbuf, para_buf, len);
			pbuf [len] = '\0';

			ACE_OS::sprintf (buf, "%d\n%s\n\n", num, pbuf);
			ACE_OS::fprintf (file, buf);
		} else {
			ACE_OS::fprintf (file, " ");
		}
		ACE_OS::fclose (file);
	}
}

} // namespace
