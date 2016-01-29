//
// Convertor.cpp : implementation file
//

#pragma warning (disable: 4786 4284)

#include "ace/ACE.h"

#include "garantPIL/implementation/component/cpp/libs/endt/Helpers.h"

#include "Cache.h"
#include "ParaTree.h"
#include "Convertor.h"
#include "DivisionInfo.h"
#include "ThreadManager.h"

namespace EndtConvertor {

static const size_t buffer_size = 64 * 1024;

struct WriteProc : public evd::UserWriter {
	WriteProc (EndtTools::EndtWriter* writer) : m_writer (writer) {
	}

	long write (unsigned char* buf, long len) {
		m_writer->write_para ((const char*) buf, len);
		return len;
	}

private:
	EndtTools::EndtWriter* m_writer;
};

////////////////////////////////////////////////////////////////////////////////////////////

// IConvertor factory

IConvertor* IConvertorFactory::make (const Properties& prop) {
	try {
		IConvertor_var ret = new Convertor_i (prop);
		return ret._retn ();
	} catch (...) {
		throw std::exception ();
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////

static void show_ex (Base* base, const char* what, unsigned long doc_id, size_t i) {
	long count = 0;
	INDEX_DATA (long) ids = IndexLoader (base).load <long> (doc_id, IDD2_PARAIDS, count);
	long para_id = (ids.is_nil ())? -1 : ids.ptr () [i];

	_msg ("%s: topic %ld, para %ld, para_id %ld", what, doc_id, i, para_id);
}

static void convert_doc (unsigned long doc_id, Base* base) {
	Core::Aptr <Document> doc;

	try {
		doc = base->GetDoc (doc_id);
	} catch (...) {
		_msg ("%s: can't receive topic %ld", GDS_CURRENT_FUNCTION, doc_id);
		throw std::exception ();
	}

	if (doc.is_nil () || !doc->IsOk ()) {
		_msg ("%s: topic %ld not found", GDS_CURRENT_FUNCTION, doc_id);
		return ;
		throw std::exception ();
	}

	SubDescsEx sub_list;
	sub_list.load (base, doc_id);

	ParaHeights para_heights;
	para_heights.load (base, doc_id);

	EndtTools::EndtWriter writer (EndtTools::WP_GENERATE_EXCEPTIONS);
	writer.create_new_document (doc_id, &(doc->Stat));

	WriteProc write_proc (&writer);
	evd::IeeGenerator_var generator = new evd::EeGenerator_i (&write_proc, buffer_size);

	Para cur, prev;
	size_t i = 0, pos = 0;
	bool is_chain = false, is_clear_pseudo = false;

	try {
		DivisionInfos division_info (base, doc_id);

		const DivisionData& data = division_info.get_data ();

		std::map <long, std::vector <long> > map_para_markedpositions;

		generator->Start ();
		{
			for (; i < (size_t) doc->Stat.ParaCount; ++i) {
				try {
					cur.build_tree (base, doc.in (), prev, i, is_chain, sub_list.is_sub (i, pos), sub_list.not_cell (i));

					if (cur.marked_positions.size () && (cur.marked_positions.size () % 2 == 0)) {
						map_para_markedpositions.insert (
							std::map <long, std::vector <long> >::value_type (i, cur.marked_positions)
						);
					}

					prev = cur;

					DivisionData::const_iterator d_it = data.find (i);

					if (d_it != data.end ()) {
						DivisionInfoGenerator::generate (generator.in (), writer, d_it->second);
					} else {
						cur.generate (generator.in (), writer, is_clear_pseudo, para_heights);
						is_clear_pseudo = cur.has_legal_bmp ();
					}
				} catch (EndtTools::InvalidStyleSize& ex) {
					EndtConvertor::show_ex (base, ex.what (), doc_id, i);
				} catch (EndtTools::InvalidTextSize& ex) {
					EndtConvertor::show_ex (base, ex.what (), doc_id, i);
				} 
			}
		}
		generator->Finish ();

		if (map_para_markedpositions.size ()) {
			long size = 0;
			std::map <long, std::vector<long> >::const_iterator map_it;

			for (map_it = map_para_markedpositions.begin (); map_it != map_para_markedpositions.end (); map_it++) {
				size += sizeof (long) * 2 + map_it->second.size () * sizeof (long);
			}

			long *data = new long [size], *ptr = data;

			for (map_it = map_para_markedpositions.begin (); map_it != map_para_markedpositions.end (); map_it++) {
				*ptr++ = map_it->first;
				*ptr++ = map_it->second.size ();

				for (std::vector<long>::const_iterator pos_it = map_it->second.begin (); pos_it != map_it->second.end (); pos_it++) {
					*ptr++ = *pos_it;
				}
			}

			EndtTools::SafeBase::Singleton::instance ()->replace_attr (doc_id, IDD_MARKEDTEXT, data, size);
			delete[] data;
		}
	} catch (...) {
		_msg ("%s: unknown exception at data writing: topic %ld, para %ld", GDS_CURRENT_FUNCTION, doc_id, i);
		throw std::exception ();
	}
}

int conv_thr_func (void* arg) {
	DocCollection* topics = static_cast <DocCollection*> (arg);

	Cache* _cache = Cache::Singleton::instance ();
	ThreadManager* manager = ThreadManager::Singleton::instance ();

	GDS_ASSERT (topics && _cache && manager);

	Core::Aptr <Base> base = manager->make ();

	while (true) {
		size_t pos = manager->get_pos ();

		if (pos >= (size_t) topics->ItemCount) {
			break;
		}

		long doc_id = (*topics)[pos];

		if (_cache->is_splash (doc_id)) {
			_msg_console ("%s: skip splash: topic %ld", GDS_CURRENT_FUNCTION, doc_id);
		} else if (EndtTools::is_big_info (doc_id)) {
			_msg_console ("%s: skip big info: topic %ld", GDS_CURRENT_FUNCTION, doc_id);
		} else {			
			try {
				convert_doc (doc_id, base.in ());
			} catch (...) {
				_msg ("%s: canceled for topic %ld", GDS_CURRENT_FUNCTION, doc_id);
				throw std::exception ();
			}
		}
	}

	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////
// Convertor_i

Convertor_i::Convertor_i (const Properties& prop) {
	EndtTools::SafeBase::Singleton::instance ()->init (prop.path_dst);
	ThreadManager::Singleton::instance ()->init (prop.path_src, prop.thr_count);

	Cache* obj = Cache::Singleton::instance ();

	obj->init (prop.path_src);
	obj->load_pics (prop.path_pics);
	obj->load_editions (prop.path_editions);
}

void Convertor_i::convert (DocCollection* topics, size_t from) {
	try {
		EndtTools::ProcessIndicator progress ("convert", "EndtConvertor.log");
		progress.init (topics->ItemCount);

		ThreadManager::Singleton::instance ()->execute ((ACE_THR_FUNC) conv_thr_func, topics, from, &progress);
		PictList::Singleton::instance ()->write ("doc_pict_list.log");
	} catch (...) {
		_msg ("%s: UEX", GDS_CURRENT_FUNCTION);
	}
}

// implemented method from IConvertor
void Convertor_i::convert (unsigned long doc_id) {
	try {
		convert_doc (doc_id, Cache::Singleton::instance ()->get_base ());
	} catch (...) {
		_msg ("%s: canceled for topic %ld", GDS_CURRENT_FUNCTION, doc_id);
		throw std::exception ();
	}
}

// implemented method from IConvertor
void Convertor_i::convert_from (unsigned long doc_id) {
	DocCollection* topics = Cache::Singleton::instance ()->get_all_topics ();
	this->convert (topics, topics->IndexOf (&doc_id) + 1);
}

// implemented method from IConvertor
void Convertor_i::convert (ConvertType type) {
	if (type == ct_All) {
		this->convert (Cache::Singleton::instance ()->get_all_topics (), 0);
	} else if (type == ct_Docs) {
		Core::Aptr <DocCollection> topics = Cache::Singleton::instance ()->get_all_docs ();
		this->convert (topics.in (), 0);
	} else {
		_msg ("%s: unknown type of convertation", GDS_CURRENT_FUNCTION);
	}
}

} // namespace

