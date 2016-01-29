//
// BaseCache.cpp : implementation file
//

#include "ace/ACE.h"

#include "shared/Morpho/Facade/Factory.h"

#include "ContextPartsHelper.h"
#include "BaseCache.h"

BaseCache::BaseCache () : m_short_list_size (0), is_protected_para_init (false) {
	m_cache = Morpho::Factory::make ();
}

BaseCache::~BaseCache () {
}

const MorphoHashes& BaseCache::get_morpho_hashes (Base* base) {
	GUARD (m_morpho_hashes_mutex);

	if (m_morpho_hashes.empty ()) {
		long size = 0, offset = sizeof (unsigned long);

		Buffer buf = this->load_aux (base, AUX_MORPHO_HASHES, size);

		for (char* ptr = buf.in (); ptr - buf.in () < size;) {
			unsigned long* hash_ptr = (unsigned long*) (ptr + ACE_OS::strlen (ptr) + 1);
			m_morpho_hashes [*hash_ptr].push_back (ptr);
			ptr = (char*) hash_ptr + offset;
		}
	}

	return m_morpho_hashes;
}

const BaseInfoMap& BaseCache::get_map_baseinfos (Base *base) {
	GUARD (m_mutex);

	if (m_map_baseinfos.empty ()) {
		Stream *str = base->FindIndex ("Aux")->Open ("Base");
		if (str) {
			int count = str->Length () / sizeof (BaseInfo);
			while (count--) {
				BaseInfo baseInfo;
				gk_bzero (&baseInfo, sizeof (baseInfo));
				str->Read (&baseInfo, sizeof (BaseInfo));
				std::pair<std::string,std::string> names (baseInfo.Name, baseInfo.NameEng);
				m_map_baseinfos.insert (std::map<short, std::pair<std::string,std::string> >::value_type (baseInfo.BaseId, names));
			}
			base->FindIndex ("Aux")->Close (str);
		}
	}

	return m_map_baseinfos;
}

const TypingErrors& BaseCache::get_typing_errors (Base* base) {
	GUARD (m_typing_errors_mutex);

	if (m_typing_errors.empty ()) {
		long size = 0;

		Buffer buf = this->load_aux (base, AUX_TYPING_ERRORS, size);

		for (char* ptr = buf.in (); ptr - buf.in () < size;) {
			char* ptr2 = ptr + ACE_OS::strlen (ptr) + 1;
			m_typing_errors [ptr] = ptr2;
			ptr = ptr2 + strlen (ptr2) + 1;
		}
	}

	return m_typing_errors;
}

const GCL::StrSet& BaseCache::get_good_words (Base* base) {
	GUARD (m_typing_errors_mutex);

	if (m_good_words.empty ()) {
		long size = 0;

		Buffer buf = this->load_aux (base, AUX_ERRORS_GOODWORDS, size);

		for (char* ptr = buf.in (); ptr - buf.in () < size; ptr += ACE_OS::strlen (ptr) + 1) {
			m_good_words.insert (ptr);
		}
	}

	return m_good_words;
}

Morpho::Def::ICache* BaseCache::get_morpho_cache_ptr () {
	return m_cache.in ();
}

Morpho::Def::INormalizer* BaseCache::make (DBCore::IBase* base) {
	GDS_ASSERT (base);
	m_cache->load (base, true);
	return Morpho::Factory::make (m_cache.in ());
}

void BaseCache::release () {
	AllDocsCache::instance ()->release ();
	ContextPartsHelper::fini ();

	m_cache->clear ();

	{
		GUARD (m_find_in_cache_mutex);
		m_request_cache_offset.clear ();
	}
	{
		GUARD (m_morpho_hashes_mutex);
		m_morpho_hashes.clear ();
	}
	{
		GUARD (m_typing_errors_mutex);
		m_typing_errors.clear ();
		m_good_words.clear ();
	}
	{
		GUARD (m_mutex);

		m_short_list_size = 0;
		is_protected_para_init = false;

		m_map_baseinfos.clear ();
		m_map_doc_edis.clear ();

		std::vector <short> ().swap (m_here_segs);
		std::vector <short> ().swap (m_ignore_segs);
	}
}

char* BaseCache::load_aux (Base* base, const void* key, long& size) {
	Buffer ret;

	try {
		Index* index = base->FindIndex ("Aux");

		if (index) {
			Stream* str = index->Open (key);

			if (str) {
				size = str->Length ();
				ret = new char [size + 4];
				str->Read (ret.inout (), size);
				index->Close (str);
			}
		}
	} catch (...) {
		LOG_UEX (("%s: key %s", GDS_CURRENT_FUNCTION, (char*) key));
	}

	return ret._retn ();
}

const RequestCacheOffset& BaseCache::get_request_cache_offset (Base* base) {
	GUARD (m_find_in_cache_mutex);

	if (m_request_cache_offset.empty ()) {
		const std::vector <short>& here_segs = this->get_here_seg (base);

		size_t seg = 0;

		for (std::vector <short>::const_iterator it = here_segs.begin (); it != here_segs.end (); ++it, ++seg) {
			char name [5];
			sprintf (name, "-%03d", *it);

			long size = 0;

			Buffer buf = this->load_aux (base, name, size);

			char* offset_ptr;

			for (char* ptr = buf.in (); ptr - buf.in () < size;) {
				long str_len = *(long*) ptr;
				ptr += sizeof (long);

				WinStrUpr (ptr);

				offset_ptr = ptr + str_len;

				long offset = *(long*) offset_ptr;

				RequestCacheOffset::iterator _it = m_request_cache_offset.find (ptr);

				if (_it == m_request_cache_offset.end ()) {
					_it = m_request_cache_offset.insert (
						RequestCacheOffset::value_type (ptr, std::vector <long> (here_segs.size (), -1))
					).first;
				} 

				_it->second.at (seg) = offset;

				ptr = offset_ptr + sizeof (long);
			}
		}
	}

	return m_request_cache_offset;
}

const std::vector <short>& BaseCache::get_here_seg (Base* base) {
	GUARD (m_mutex);

	if (m_here_segs.empty ()) {
		Index* index = base->FindIndex ("Aux");

		Stream* str = index->Open ("Here");

		if (str) {
			long length = str->Length ();
			short* heres = (short*) malloc (length);
			str->Read (heres, length);
			index->Close (str);

			length /= 2;
			m_here_segs.resize (length);

			for (long i = 0; i < length; ++i) {
				m_here_segs [i] = heres [i];
			}

			gk_free (heres);

			std::sort (m_here_segs.begin (), m_here_segs.end ());
		}
	}

	return m_here_segs;
}

const DocDataMap& BaseCache::get_map_doc_edis (Base* base) {
	GUARD (m_mutex);

	if (m_map_doc_edis.empty ()) {
		Index* index = base->FindIndex ("Aux");

		Stream* str = index->Open ("Edis");

		if (str) {
			long count = str->Length (), *edis_map = (long*) malloc (count), *ptr = edis_map;
			str->Read (edis_map, count);
			index->Close (str);

			count /= sizeof (long) * 2;

			for (int i = 0; i < count; i++, ptr++) {
				long edition = *ptr;
				long doc = *++ptr;

				std::map<long, std::set<long> >::iterator it = m_map_doc_edis.find (doc);

				if (it == m_map_doc_edis.end ()) {
					std::set <long> long_set;
					long_set.insert (edition);
					m_map_doc_edis.insert (std::map<long, std::set<long> >::value_type (doc, long_set));
				} else {
					it->second.insert (edition);
				}
			}

			gk_free (edis_map);
		}
	}

	return m_map_doc_edis;
}

const std::vector <short>& BaseCache::get_ignore_segs (Base* base) {
	GUARD (m_mutex);

	if (m_ignore_segs.empty ()) {
		Index* index = base->FindIndex ("Aux");

		Stream* str = index->Open (AUX_IGNORE_BELONGS);

		if (str) {
			long length = str->Length ();
			char* segs = (char*) malloc (length), *ptr = segs;
			str->Read (segs, length);
			index->Close (str);

			short tmpRet;

			while (ptr - segs < length) {
				tmpRet= (short)(atol (ptr) & 0x7fff);
				m_ignore_segs.push_back (tmpRet);
				ptr += strlen (ptr) + 1;
			}

			gk_free (segs);

			std::sort (m_ignore_segs.begin (), m_ignore_segs.end ());
		}
	}

	return m_ignore_segs;
}

long BaseCache::get_short_list_size (Base* base) {
	GUARD (m_mutex);

	if (m_short_list_size == 0) {
		Index* index = base->FindIndex ("Aux");

		Stream* str = index->Open (AUX_SHORTLISTSIZE);

		if (str) {
			str->Read (&m_short_list_size, sizeof (long));
			index->Close (str);
		} else {
			m_short_list_size = 60;
		}
	}

	return m_short_list_size; 
}

extern unsigned char protected_para [81];

void BaseCache::init_protected_para (Base* base) {
	GUARD (m_mutex);

	if (is_protected_para_init == false) {
		Index* index = base->FindIndex ("Aux");

		for (int i = 0; i < 48 / 4; i++) {
			char key [5];
			sprintf (key, "PRO%X", i);

			Stream *str = index->Open (key);

			if (str) {
				long dummy;
				str->Read (&dummy, sizeof (dummy));
				char* charptr = (char*) &dummy;
				for (int chars = 0; chars < 4; chars++)
					if (*(charptr + chars) == 0)
						*(charptr + chars) = ' ';
				memcpy (protected_para + 26 + i * 4, &dummy, sizeof (dummy));
				index->Close (str);
			} else {
				break;
			}
		}

		is_protected_para_init = true;
	}
}

