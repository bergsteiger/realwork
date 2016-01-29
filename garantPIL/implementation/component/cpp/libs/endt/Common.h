//
// Common.h : header file
//

#if !defined __ENDT_COMMON_H
#define __ENDT_COMMON_H

#include "shared/Core/mng/Aptr.h"

#include <string>

namespace EndtTools {

	class FileWriter {
	public:
		FileWriter (const char* file_path);
		virtual ~FileWriter ();

		virtual void write_empty ();
		virtual void write (const char* buffer, size_t num = 0); 

		inline const bool is_valid () const { 
			return (m_file != 0); 
		}

		inline FILE* get_handle () const {
			return m_file;
		}

	private:
		FILE* m_file;
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	class Log 
		: virtual public FileWriter {
	public:
		Log (const char* path);

		void out (const char *str, ...);
	};

	//////////////////////////////////////////////////////////////////////////////////////////////////////

	class ProcessIndicator {
	public:
		struct ptime {
			int m_hour;
			int m_min;
			int m_sec;

			inline void set (int hour, int min, int sec) {
				m_hour = hour;
				m_min  = min;
				m_sec  = sec;
			}
		};

	public:
		ProcessIndicator (const char *text = 0, const char* log_path = "") 
			: m_pos (0)
			, m_iter (0)
			, m_proc (0)
			, m_count (0)
			, m_prev_proc (0)
			, m_update_rate (0) 
			, m_is_wo_rt (false)
			, m_log_path (log_path)
		{
			this->set_text (text);
		}

		~ProcessIndicator ();

		void init (unsigned long count, unsigned rate = 0);
		void update (unsigned i, unsigned long cur_id = 0);
		void get_runtime ();
		void show_runtime ();

		void start ();
		void update_ (unsigned i);

		inline void set_text (const char *text) { 
			if (text) {
				m_text = text; 
			}
		}

		inline void set_wo_rt (bool val) {
			m_is_wo_rt = val;
		}

	protected:
		void msg (const char *format_str, ...);

	private:
		inline void calc (unsigned i) {
			if (m_count > 1) {
				m_proc = (unsigned)((i * 100)/(m_count - 1) + 0.5);
			} else {
				m_proc = 0;
			}
		}

		inline void set_update_rate (unsigned rate = 0) {
			m_update_rate = (rate)? rate : (unsigned)(m_count/100. + 1.);
		}

		inline void set_count (unsigned long count) {
			m_count = count; 
		}

	private:
		ptime m_rt;
		ptime m_start_time;

		std::string m_text;
		std::string m_log_path;

		bool m_is_wo_rt;

		unsigned m_pos;
		unsigned m_proc;
		unsigned m_iter;
		unsigned m_prev_proc;
		unsigned m_update_rate;
		unsigned long m_count;
	};

} // namespace

#endif // !defined(__ENDT_COMMON_H)
