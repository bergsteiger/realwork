
#ifndef __COMMON_H__
#define __COMMON_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <map>

void _msg (const char *format_str, ...);
void _msg_log (const char *format_str, ...);
void _msg_console (const char *format_str, ...);

//////////////////////////////////////////////////////////////////////////////////////

class PictList {
	public:
		PictList ();

		void add (unsigned doc_id, long obj_id);
		void write (const char* file_name);

	public:
		typedef std::set <long> DataSet;
		typedef std::map <unsigned, DataSet> DocPicList;

		typedef ACE_Singleton <PictList, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <PictList, ACE_SYNCH_RECURSIVE_MUTEX>;

	private:
		void write (FILE* file, unsigned doc_id, const DataSet& data, const char* time_buf);

	private:
		DocPicList m_data;
		Core::Mutex m_mutex;
	};

#endif // #ifndef __COMMON_H__
