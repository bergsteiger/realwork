//
// WordFinder.cpp : implementation file
//

#include "ace/ACE.h"
#include "shared/GCL/str/str_conv.h"
#include "boost/tokenizer.hpp"
#include "WordFinder.h"

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

WordFinder::WordFinder (Base* base) : m_base (base) {
}

WordFinder::~WordFinder () {
}

std::string WordFinder::execute (long doc_id, long para, short pos) {
	std::string ret;

	if (m_doc.is_nil ()) {
		m_doc = m_base->GetDoc (doc_id);
	}

	if (m_doc.is_nil () == false && m_doc->IsOk () && (m_doc->Stat.Status & DS_EVD)) {
		char* src = ParaText (m_doc->GetPara (para));

		long flags = 0;
		ACE_OS::memcpy (&flags, src, sizeof (long));

		size_t offset = sizeof (long);

		short cp = 0;
		ACE_OS::memcpy (&cp, src + offset, sizeof (short));
		offset += sizeof (short);

		if (flags & ENDT_HAS_BMP) {
			offset += sizeof (long);
		} 

		long len = 0;
		ACE_OS::memcpy (&len, src + offset, sizeof (long));
		offset += sizeof (long) + len + sizeof (long);

		std::string text = src + offset;

		if (cp == CP_OEM) {
			GCL::string_recoding (GCL::cd_dos, GCL::cd_win, &(*text.begin ()), 0);
		}

#ifdef _DEBUG
		const char* text_ptr = text.c_str ();
#endif

		std::string delim = "_-.,:;{}()<>[]/\\| ";
		delim += (char) (-120);
		delim += (char) (-121);
		delim += (char) (-122);
		delim += (char) (-123);
		delim += (char) (-127);
		delim += (char) (-128);

		typedef boost::tokenizer <boost::char_separator <char> > tokenizer; 
		boost::char_separator <char> sep (delim.c_str ());
		tokenizer tok (text, sep); 

		tokenizer::iterator prev_it;

		for (tokenizer::iterator it = tok.begin (); it != tok.end (); ++it) {
			size_t last = it->size () - 1;

			if (it->at (last) == '#') {
				if (pos == 0) {
					if (last) {
						ret = it->substr (0, last);
					} else if (it != tok.begin ()) {
						ret = *prev_it;
					}
					break;
				} else {
					--pos;
				}
			}

			prev_it = it;
		}
	}

	return ret;
}

