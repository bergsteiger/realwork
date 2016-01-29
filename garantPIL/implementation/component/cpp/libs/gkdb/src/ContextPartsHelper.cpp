//
// ContextPartsHelper.cpp : implementation file
//

#include "ace/ACE.h"

#include "boost/lexical_cast.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "ContextPartsHelper.h"

static const std::string SIDE_PART = "side";
static const std::string EDIS_PART = "edis";
static const std::string PHARM_PART = "inpharm";

static const std::string CONTEXT_NAME = "NWCntxt";
static const std::string SWORDS_NAME = "SWords";
static const std::string FORM_NAME = "NFContxt";

//////////////////////////////////////////////////////////////////////////////////////////

struct PartsHelper {
	template <typename Data>
	static void read (DBCore::Store* store, std::vector <Data>& out) {
		if (store && store->Length ()) {
			out.resize (store->Length () / sizeof (Data));
			store->Read (&out [0], store->Length ());
		}
	}
};

//////////////////////////////////////////////////////////////////////////////////////////

class PartsCache {
	typedef ACE_Singleton <PartsCache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PartsCache, ACE_SYNCH_RECURSIVE_MUTEX>;

public:
	static PartsCache* instance () {
		return Singleton::instance ();
	}

protected:
	PartsCache ();

public:
	void init (Base* base);
	void fini ();

	void get_part_name (std::string& str, long doc_id);
	void get_parts_names (const std::string& str, GCL::StrVector& out, bool with_editions);

	std::string get_part (const std::string& name, const std::string& str);

	const std::vector <long>& get_changed_docs ();

	ContextPartsHelper::PartInfo get_info (const std::string& name);

	long size () const {
		return m_size;
	}

private:
	void load_changed_docs (Base* base);
	void add (Index* index, long part, const std::string& name, const std::string& key);

private:
	typedef std::map <long, std::vector <long> > MPartsDocs;

	Core::Mutex m_mutex;

	MPartsDocs m_parts_docs;

	std::map <std::string, long> m_parts;
	std::map <long, std::string> m_names;

	std::vector <long> m_changed_docs;

	long m_size;

	std::string m_path;
};

PartsCache::PartsCache () : m_size (0) { 
}

void PartsCache::init (Base* base) {
	GUARD (m_mutex);

	if (m_size == 0) {
		Index* index = base->FindIndex ("Aux");

		Stream* str = index->Open (AUX_PARTS);

		if (str) {
			str->Read (&m_size, sizeof (long));
			index->Close (str);
		}

		if (m_size) {
			m_path = base->textFile->FileName;

			size_t pos = m_path.rfind ('\\');

			if (pos != std::string::npos) {
				m_path.erase (pos + 1);
			}

			long part = 0;

			for (; part < m_size; ++part) {
				std::string part_str = boost::lexical_cast <std::string> (part);
				std::string key = "Prt" + part_str;
				this->add (index, part, part_str, key);
			}

			this->add (index, part++, EDIS_PART , "PrtE");
			this->add (index, part++, PHARM_PART, "PrtI");
			this->add (index, part++, SIDE_PART , "PrtM");
		}
	}

	if (m_size == 0) {
		this->load_changed_docs (base);
	}
}

void PartsCache::fini () {
	GUARD (m_mutex);

	m_parts_docs.clear ();
	m_parts.clear ();
	m_names.clear ();
	m_size = 0;

	std::vector <long> ().swap (m_changed_docs);
}

void PartsCache::add (Index* index, long part, const std::string& name, const std::string& key) {
	m_parts [name] = part;
	m_names [part] = name;

	Stream* str = index->Open (key.c_str ());

	if (str) {
		MPartsDocs::iterator it = m_parts_docs.insert (MPartsDocs::value_type (part, std::vector <long> ())).first;
		PartsHelper::read <long> (str, it->second);
		index->Close (str);
	}
}

void PartsCache::load_changed_docs (Base* base) {
	if (m_changed_docs.empty ()) {
		Index* index = base->FindIndex (SIDE_INDEX_NAME.c_str ());

		if (index && index->KeyCount > 0) {
			BTIterator it (index);

			Stream* str = index->keyOpen (it.Key (), 1);

			if (str) {
				PartsHelper::read <long> (str, m_changed_docs);
				index->Close (str);
			}
		}
	}
}

const std::vector <long>& PartsCache::get_changed_docs () {
	return (m_size)? m_parts_docs [m_parts [SIDE_PART]] : m_changed_docs;
}

void PartsCache::get_part_name (std::string& str, long doc_id) {
	const std::vector <long>& data = this->get_changed_docs ();

	bool is_changed = std::binary_search (data.begin (), data.end (), doc_id);

	if (m_size) {
		if (is_changed) {
			str += ".str"; // нашли в списке измененных
		} else {
			for (MPartsDocs::const_iterator it = m_parts_docs.begin (); it != m_parts_docs.end (); ++it) {
				if (std::binary_search (it->second.begin (), it->second.end (), doc_id)) {
					str += boost::lexical_cast <std::string> (it->first) + ".str";
					return;
				}
			}
		}
	} else if (is_changed) {
		str = SIDE_INDEX_NAME; // нашли в списке измененных
	} else {
		str += ".str";
	}
}

std::string PartsCache::get_part (const std::string& name, const std::string& str) {
	return str + boost::lexical_cast <std::string> (m_parts [name]) + ".str";
}

void PartsCache::get_parts_names (const std::string& str, GCL::StrVector& out, bool with_editions) {
	std::string base_name = str + ".str";

	if (m_size) {
		for (long i = 0; i < m_size; ++i) {
			std::string name = str + boost::lexical_cast <std::string> (i) + ".str";
			out.push_back (name);
		}

		if (with_editions) {
			out.push_back (this->get_part (EDIS_PART, str));
		}

		out.push_back (this->get_part (PHARM_PART, str));
		out.push_back (base_name);
	} else {
		out.resize (2);
		out [0] = base_name;
		out [1] = SIDE_INDEX_NAME;
	}
}

ContextPartsHelper::PartInfo PartsCache::get_info (const std::string& name) {
	ContextPartsHelper::PartInfo ret = boost::make_tuple (-1, "", "");

	std::string::const_iterator it = std::find_if (name.begin (), name.end (), boost::is_digit ());

	if (it != name.end ()) {
		std::string index_name (name.begin (), it);

		if (index_name == CONTEXT_NAME || index_name == FORM_NAME || index_name == SWORDS_NAME) {
			std::string part (it, std::find_if (it, name.end (), !boost::is_digit ()));

			boost::get <0> (ret) = boost::lexical_cast <long> (part);
			boost::get <1> (ret) = index_name;
			boost::get <2> (ret) = m_path + "part" + m_names [boost::get <0> (ret)] + ".ndt";
		}
	}

	return ret;
}

//////////////////////////////////////////////////////////////////////////////////////////

void ContextPartsHelper::init (Base* base) {
	PartsCache::instance ()->init (base);
}

void ContextPartsHelper::fini () {
	PartsCache::instance ()->fini ();
}

bool ContextPartsHelper::is_parts () {
	return (PartsCache::instance ()->size () != 0);
}

const std::vector <long>& ContextPartsHelper::get_changed_docs () {
	return PartsCache::instance ()->get_changed_docs ();
}

ContextPartsHelper::PartInfo ContextPartsHelper::get_info (const std::string& name) {
	return PartsCache::instance ()->get_info (name);
}

void ContextPartsHelper::get_context_parts_names (GCL::StrVector& out, bool with_editions) {
	PartsCache::instance ()->get_parts_names (CONTEXT_NAME, out, with_editions);
}

void ContextPartsHelper::get_form_parts_names (GCL::StrVector& out, bool with_editions) {
	PartsCache::instance ()->get_parts_names (FORM_NAME, out, with_editions);
}

std::string ContextPartsHelper::get_pharm_context_index_name () {
	bool res = ContextPartsHelper::is_parts ();
	return (res)? PartsCache::instance ()->get_part (PHARM_PART, CONTEXT_NAME) : SIDE_INDEX_NAME;
}

std::string ContextPartsHelper::get_context_index_name (long doc_id) {
	std::string str = CONTEXT_NAME;
	PartsCache::instance ()->get_part_name (str, doc_id);
	return str;
}

std::string ContextPartsHelper::get_swords_index_name (long doc_id) {
	std::string str = SWORDS_NAME;
	PartsCache::instance ()->get_part_name (str, doc_id);
	return str;
}

