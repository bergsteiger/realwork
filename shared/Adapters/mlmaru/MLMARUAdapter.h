//
// MLMARUAdapter.h : header file
//

#ifndef __MLMA_RU_ADAPTER_H
#define __MLMA_RU_ADAPTER_H

#include "ace/Singleton.h"

#include "shared/GCL/os/DllLoader.h"
#include "shared/Core/sys/synch.h"

#include "libmorph/mlma1049.h"

namespace Adapters {

	static const std::string mlma32ru_basename = "MLMA32RU";

	class MLMA32RUAdapter 
		: public GCL::DllLoader {
	public:
		MLMA32RUAdapter ()
			: GCL::DllLoader (mlma32ru_basename.c_str ())
			, m_lemmatize_func_ptr (0)
			, m_build_form_func_ptr (0)	
		{
			GDS_ASSERT (this->is_loaded ());
		}

		virtual ~MLMA32RUAdapter () {
		}

		short lemmatize (
			const char* word
			, unsigned short options
			, char* lemm
			, unsigned long* LIDs
			, char* gram
			, unsigned short nlemm
			, unsigned short nLID
			, unsigned short ngram 
		) {
			if (m_lemmatize_func_ptr == 0) {
				m_lemmatize_func_ptr = this->get_func_ptr <LEMMATIZE_IMPL> ("mlmaruLemmatize");
			}
			return (*this->m_lemmatize_func_ptr)(word, options, lemm, LIDs, gram, nlemm, nLID, ngram);
		}

		short build_form (
			const char* word
			, unsigned long id
			, unsigned short options
			, unsigned char form
			, char* result
			, unsigned short len
		) {
			if (m_build_form_func_ptr == 0) {
				m_build_form_func_ptr = this->get_func_ptr <BUILD_FORM_IMPL> ("mlmaruBuildForm");
			}
			return (*this->m_build_form_func_ptr) (word, id, options, form, result, len);
		}

		short check_word (const char* word, unsigned short options) {
			if (m_check_word == 0) {
				m_check_word = this->get_func_ptr <CHECK_WORD_IMPL> ("mlmaruCheckWord");
			}
			return (*this->m_check_word) (word, options);
		}

		short build_form_gi (
			const char* word
			, unsigned long lex_id
			, unsigned short options
			, unsigned short gr_info
			, unsigned char flags
			, char* dest
			, unsigned short cc_dest
		) {
			if (m_build_form_gi == 0) {
				m_build_form_gi = this->get_func_ptr <BUILD_FORM_GI> ("mlmaruBuildFormGI");
			}
			return (*this->m_build_form_gi) (word, lex_id, options, gr_info, flags, dest, cc_dest);
		}

		short check_help (const char* word, char* list) {
			if (m_check_help == 0) {
				m_check_help = this->get_func_ptr <CHECK_HELP> ("mlmaruCheckHelp");
			}
			return (*this->m_check_help) (word, list);
		}

	private:
		typedef short (__stdcall *LEMMATIZE_IMPL) (
			const char*
			, unsigned short
			, char*
			, unsigned long*
			, char*
			, unsigned short
			, unsigned short
			, unsigned short
		);

		typedef short (__stdcall *BUILD_FORM_IMPL) (
			const char*
			, unsigned long
			, unsigned short
			, unsigned char
			, char*
			, unsigned short
		);

		typedef short (__stdcall *BUILD_FORM_GI) (
			const char*
			, unsigned long
			, unsigned short
			, unsigned short
			, unsigned char
			, char*
			, unsigned short
		);

		typedef short (__stdcall *CHECK_WORD_IMPL) (const char*, unsigned short);

		typedef short (__stdcall *CHECK_HELP) (const char*, char*);

	private:
		LEMMATIZE_IMPL m_lemmatize_func_ptr;
		BUILD_FORM_IMPL m_build_form_func_ptr;
		BUILD_FORM_GI m_build_form_gi;
		CHECK_WORD_IMPL m_check_word;
		CHECK_HELP m_check_help;
	};

	typedef ACE_Singleton <MLMA32RUAdapter, ACE_SYNCH_RECURSIVE_MUTEX> MLMA32RUAdapterSingleton;
};

#endif // __MLMA_RU_ADAPTER_H
