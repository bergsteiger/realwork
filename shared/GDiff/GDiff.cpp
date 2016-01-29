#pragma  warning (push)
	#pragma  warning (disable: 4244) // 'argument' : conversion from 'type1' to 'type2', possible loss of data
	#pragma  warning (disable: 4267) // 'var' : conversion from 'size_t' to 'type', possible loss of data
	#pragma  warning (disable: 4311) // 'variable' : pointer truncation from 'type' to 'type'
	#pragma  warning (disable: 4312) // 'operation' : conversion from 'type1' to 'type2' of greater size

	#include "ace/ACE.h"
	#include "ace/OS.h"
	#include "ace/SString.h"
#pragma  warning (pop)

#include "GDiffComparators.h"

int main (int a_argc, char* a_argv []) {
	ACE_OS::printf (
		"\nDIFF TOOL \"%s\" (C) SIE \"GARANT-SERVICE-UNIVERSITY\" LLC, 1990-2015\n"
		, ACE::basename ((assert (a_argv [0] != 0), a_argv [0]))
	);

	if (
		(
			a_argc > 2
		) && (
			ACE_OS::strcmp ((assert (a_argv [1] != 0), a_argv [1]), "-file") == 0
		) && (
			a_argv [2] != 0
		) && (
			a_argv [3] != 0
		)
	) {
		class CallbackWrapper {
		public:
			static const char* get_next_lpara (
				void* a_this
				, size_t& a_size
			) {
				return (
					reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->get_next_lpara (
						a_size
					)
				);
			}

			static const char* get_next_rpara (
				void* a_this
				, size_t& a_size
			) {
				return (
					reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->get_next_rpara (
						a_size
					)
				);
			}
		public:
			static void put_compare_info (
				void* a_this
				, size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->put_compare_info (
					a_lposition
					, a_ldeleted
					, a_rposition
					, a_rinserted
				);
			}
		private:
			inline static size_t default_buffer_size (
				void
			) {
				return (64* 1024);
			}
		public:
			CallbackWrapper (
				const char* a_lname
				, const char* a_rname
			)
				: m_lname ((assert (a_lname != 0), a_lname))
				, m_lfile (ACE_OS::fopen (m_lname, "r"))
				, m_lbuffer (new char [default_buffer_size ()])
				, m_rname ((assert (a_rname != 0), a_rname))
				, m_rfile (ACE_OS::fopen (m_rname, "r"))
				, m_rbuffer (new char [default_buffer_size ()])
				, m_lcurrent (static_cast <size_t> (-1))
				, m_rcurrent (static_cast <size_t> (-1))
			{
				// do nothing
			}

			~CallbackWrapper (void) {
				ACE_OS::fclose (m_rfile);
				ACE_OS::fclose (m_lfile);
			}
		public:
			inline const char* lname (
				void
			) const {
				return (m_lname);
			}

			inline const char* rname (
				void
			) const {
				return (m_rname);
			}
		private:
			const char* get_next_lpara (
				size_t& a_size
			) {
				return (
					this->get_next_para (
						m_lfile
						, m_lbuffer.get ()
						, static_cast <int> (default_buffer_size ())
						, a_size
					)
				);
			}

			const char* get_next_rpara (
				size_t& a_size
			) {
				return (
					this->get_next_para (
						m_rfile
						, m_rbuffer.get ()
						, static_cast <int> (default_buffer_size ())
						, a_size
					)
				);
			}
		private:
			void put_compare_info (
				size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				ACE_OS::printf (
					"      >lposition=%05u.ldeleted=%03u.rposition=%05u.rinserted=%03u\n"
					, a_lposition
					, a_ldeleted
					, a_rposition
					, a_rinserted
				);

				if (a_ldeleted == a_rinserted == 1) {
					class CallbackWrapper {
					public:
						CallbackWrapper (
							const char* a_ltext
							, const char* a_rtext
						)
							: m_ltext ((assert (a_ltext != 0), a_ltext))
							, m_rtext ((assert (a_rtext != 0), a_rtext))
						{
							// do nothing
						}

						~CallbackWrapper (
							void
						) {
							// do nothing
						}
					public:
						static void put_compare_info (
							void* a_this
							, size_t a_lposition
							, size_t a_ldeleted
							, size_t a_rposition
							, size_t a_rinserted
						) {
							ACE_OS::printf (
								"          >lposition=%03u.ldeleted=%03u.rposition=%03u.rinserted=%03u\n"
								, a_lposition
								, a_ldeleted
								, a_rposition
								, a_rinserted
							);
						}
					public:
						inline const char* ltext (
							void
						) const {
							return (m_ltext);
						}

						inline const char* rtext (
							void
						) const {
							return (m_rtext);
						}
					private:
						const char* m_ltext;
						const char* m_rtext;
					} l_callback_wrapper (
						this->get_para (
							m_lfile
							, m_lbuffer.get ()
							, static_cast <int> (default_buffer_size ())
							, a_lposition+ 1
							, m_lcurrent
						)
						, this->get_para (
							m_rfile
							, m_rbuffer.get ()
							, static_cast <int> (default_buffer_size ())
							, a_rposition+ 1
							, m_rcurrent
						)
					);

					GDiff::TextComparatorA::compare (
						&l_callback_wrapper
						, &CallbackWrapper::put_compare_info
						, l_callback_wrapper.ltext ()
						, l_callback_wrapper.rtext ()
					);
				}
			}
		private:
			const char* get_next_para (
				FILE* a_file
				, char* a_buffer
				, int a_buffer_size
				, size_t& a_size
			) {
				return (ACE_OS::fgets (a_buffer, a_buffer_size, a_file));
			}
		private:
			const char* get_para (
				FILE* a_file
				, char* a_buffer
				, int a_buffer_size
				, size_t a_position
				, size_t a_previous
			) {
				const char* l_result; {
					if (a_position < a_previous) {
						fpos_t l_fpos = 0;
						
						(ACE_OS::fsetpos (a_file, &l_fpos), a_previous = 0);
					}

					do {
						l_result = (++a_previous, ACE_OS::fgets (a_buffer, a_buffer_size, a_file));
					} while ((a_previous != a_position) && (l_result != 0));
				}

				return (l_result);
			}
		private:
			typedef ACE_Auto_Array_Ptr <char> Buffer;
		private:
			const char* m_lname;
			FILE* m_lfile;
			Buffer m_lbuffer;

			const char* m_rname;
			FILE* m_rfile;
			Buffer m_rbuffer;

			size_t m_lcurrent;
			size_t m_rcurrent;
		} l_callback_wrapper (a_argv [2], a_argv [3]); // class CallbackWrapper

		ACE_OS::printf ("\n  Create diff for files {\n");
		ACE_OS::printf ("      lname=\"%s\"\n", l_callback_wrapper.lname ());
		ACE_OS::printf ("      rname=\"%s\"\n", l_callback_wrapper.rname ());
		ACE_OS::printf ("  }\n\n");

		ACE_OS::printf ("\n  Results (only diff data) {\n");

		GDiff::ParaComparator::compare (
			&l_callback_wrapper
			, &CallbackWrapper::put_compare_info
			, &CallbackWrapper::get_next_lpara
			, &CallbackWrapper::get_next_rpara
		);

		ACE_OS::printf ("  }\n");

		ACE_OS::printf ("\nDiff created successfully\n");
	} else if ((a_argc > 1) && (a_argv [1] != 0) && (a_argv [2] != 0)) {
		class CallbackWrapper {
		public:
			CallbackWrapper (
				const char* a_ltext
				, const char* a_rtext
			)
				: m_ltext ((assert (a_ltext != 0), a_ltext))
				, m_llength (ACE_OS::strlen (m_ltext))
				, m_rtext ((assert (a_rtext != 0), a_rtext))
				, m_rlength (ACE_OS::strlen (m_rtext))
				, m_position (0)
				, m_result ()
				, m_status ()
			{
				// do nothing
			}

			~CallbackWrapper (
				void
			) {
				// do nothing
			}
		public:
			static void put_compare_info (
				void* a_this
				, size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				reinterpret_cast <CallbackWrapper*> ((assert (a_this != 0), a_this))->put_compare_info (
					a_lposition
					, a_ldeleted
					, a_rposition
					, a_rinserted
				);
			}
		public:
			inline void reset (
				void
			) {
				m_position = 0; // rewind to begin

				m_result.clear ();
				m_status.clear ();
			}
		public:
			inline const char* result (
				void
			) {
				return (
					(
						const_cast <CallbackWrapper*> (this)->rest_of_unchanged_chars ()
						, m_result.c_str ()
					)
				);
			}

			inline const char* status (
				void
			) const {
				return (
					(
						const_cast <CallbackWrapper*> (this)->rest_of_unchanged_chars ()
						, m_status.c_str ()
					)
				);
			}
		public:
			inline const char* ltext (
				void
			) const {
				return (m_ltext);
			}

			inline const char* rtext (
				void
			) const {
				return (m_rtext);
			}
		private:
			void rest_of_unchanged_chars (
				void
			) {
				// Write rest of unchanged chars
				while (m_position < m_rlength) {
					m_result += m_rtext [m_position++];
					m_status += " ";
				}
			}
		private:
			void put_compare_info (
				size_t a_lposition
				, size_t a_ldeleted
				, size_t a_rposition
				, size_t a_rinserted
			) {
				ACE_OS::printf (
					"      >lposition=%03u.ldeleted=%03u.rposition=%03u.rinserted=%03u\n"
					, a_lposition
					, a_ldeleted
					, a_rposition
					, a_rinserted
				);
				
				// Write unchanged chars
				while ((m_position < a_rposition) && (m_position < m_rlength)) {
					m_result += m_rtext [m_position++];
					m_status += " ";
				}

				// Write deleted chars
				for (size_t i = 0; (i < a_ldeleted); ++i) {
					m_result += m_ltext [a_lposition+ i];
					m_status += "-";
				}

				// Write inserted chars
				while (m_position < (a_rposition+ a_rinserted)) {
					m_result += m_rtext [m_position++];
					m_status += "+";
				}
			}
		private:
			const char* m_ltext;
			const size_t m_llength;

			const char* m_rtext;
			const size_t m_rlength;

			size_t m_position;

			ACE_CString m_result;
			ACE_CString m_status;
		} l_callback_wrapper (a_argv [1], a_argv [2]); // class CallbackWrapper

		ACE_OS::printf ("\n  Create diff for strings {\n");
		ACE_OS::printf ("      ltext=\"%s\"\n", l_callback_wrapper.ltext ());
		ACE_OS::printf ("      rtext=\"%s\"\n", l_callback_wrapper.rtext ());
		ACE_OS::printf ("  }\n\n");

		{
			ACE_OS::printf ("\n  Results {\n");

			GDiff::TextComparatorA::compare (
				(
					l_callback_wrapper.reset ()
					, &l_callback_wrapper
				)
				, &CallbackWrapper::put_compare_info
				, l_callback_wrapper.ltext ()
				, l_callback_wrapper.rtext ()
			);

			ACE_OS::printf (
				"\n      \"%s\"\n       %s\n  }\n"
				, l_callback_wrapper.result ()
				, l_callback_wrapper.status ()
			);
		} {
			ACE_OS::printf ("\n  Results (optimized for paragraph comparation) {\n");

			GDiff::TextAsParaComparatorA::compare (
				(
					l_callback_wrapper.reset ()
					, &l_callback_wrapper
				)
				, &CallbackWrapper::put_compare_info
				, l_callback_wrapper.ltext ()
				, l_callback_wrapper.rtext ()
			);

			ACE_OS::printf (
				"\n      \"%s\"\n       %s\n  }\n"
				, l_callback_wrapper.result ()
				, l_callback_wrapper.status ()
			);
		}

		ACE_OS::printf ("\nDiff created successfully\n");
	} else {
		ACE_OS::printf ("\nAvailable options {\n");
		ACE_OS::printf ("  <LeftText> <RightText>\n");
		ACE_OS::printf ("  -file <LeftFile> <RightFile>\n");
		ACE_OS::printf ("}\n");
	}

	return (0);
}
