//
// NsrcWriter.cpp : implementation file
//

#include "ace/ACE.h"

#include <algorithm>

#include "boost/lexical_cast.hpp"

#include "shared/Core/GDS/StopWatch.h"

#include "common/components/rtl/Garant/EVD/eeReader.h"
#include "common/components/rtl/Garant/EVD/evddata.h"

#include "RefFilter.h"
#include "EndtWriter.h"
#include "EndtParser.h"
#include "TableDecompile.h"
#include "IsVersionComment.h"

namespace EndtTools {

/////////////////////////////////////////////////////////////////////////////////////////////
// Writers

void __stdcall nsrc_write (void* user_data, char* style, long style_len, char* text, long text_len, size_t flags) {
	NsrcData* data = static_cast <NsrcData*> (user_data);

	if (flags & ENDT_SBS) {
		data->add_text (text, text_len);
	} else {
		data->set_text (text, text_len);
		data->set_style (style, style_len);
	}
}

struct WriteToNdt : public evd::UserWriter {
public:
	WriteToNdt (EndtWriter* writer) : m_writer (writer) {
	}

	long write (unsigned char* buffer, long len) {
		m_writer->write_para ((const char*) buffer, len);
		return 0;
	}

private:
	EndtWriter* m_writer;
};

/////////////////////////////////////////////////////////////////////////////////////////////
// EndtParser implementation

EndtParser::EndtParser (Base* base) {
	m_helper = new GeneratorHelper (base);
}

void EndtParser::log_activate (const char* path) {
	m_helper->log_activate (path);
}

void EndtParser::dump (Document* doc, NsrcFileWriter* file_writer, bool with_style) {
	long i = -1;
	try {
		long ids_count = 0;

		INDEX_DATA (long) para_ids = IndexLoader (doc->base).load <ParaId> (doc->DocId, IDD2_PARAIDS, ids_count);

		for (i = 0; i < doc->Stat.ParaCount; ++i) {
			if (para_ids.ptr () && para_ids.ptr () [i] == 0) {
				file_writer->write_empty ();
			} else {
				Core::Aptr <NsrcData> data = this->get_nsrc_data (doc, i, 0);

				if (data.ptr () && data->is_valid ()) {
					if (with_style) {
						file_writer->write_nsrc (data.in ()); // style and text
					} else {
						file_writer->write (data->get_text (), i); // text and para's number
					}
				}
			}
		}
	} catch (...) {
		LOG_UEX (("%s: canceled: para = %d", GDS_CURRENT_FUNCTION, i));
	}
}

void EndtParser::dump_para (Document* doc, NsrcFileWriter* file_writer, long para) {
	Core::Aptr <NsrcData> data = this->get_nsrc_data (doc, para, 0);
	if (data.ptr () && data->is_valid ()) {
		file_writer->write (data->get_text (), para);
	}
}

NsrcData* EndtParser::get_nsrc_data (Document* doc, long para, const std::map<long,std::string>* map_blob_name) {
	Core::Aptr <NsrcData> ret;

	if (doc) {
		m_helper->load_data (doc->DocId);

		char* para_buffer = doc->GetPara (para);
		short para_size = TextSize (para_buffer);

		EndtReader endt_reader (para_buffer, RECODE);

		const EndtReader::ParaPart* left = endt_reader.get_para ();

		if (left->has_text () || endt_reader.get_object_id ()) {
			ParaInfo info ((size_t) doc->DocId, para, 0, endt_reader.get_object_id ());

			ret = new NsrcData ();

			this->execute <NsrcGenerator_i, NsrcData> (ret.in (), nsrc_write, left, &info, map_blob_name);
		}
	}

	return ret._retn ();
}

void EndtParser::get_resp_documents (LongVector* vect, Document* doc, long para) {
	if (doc) {
		const char* para_buffer = doc->GetPara (para);

		if (para_buffer) {
			EndtReader endt_reader (para_buffer, RECODE);

			const EndtReader::ParaPart* left = endt_reader.get_para ();

			if (left->has_text ()) {
				ParaInfo info ((size_t) doc->DocId, para, 0, endt_reader.get_object_id ());

				this->execute <RespGenerator_i, LongVector> (vect, 0, left, &info, 0);
			}
		}
	}
}

LongVector* EndtParser::get_resp_documents (Document* doc, bool is_sorted, long para) {
	Core::Aptr <LongVector> ret;
	ret = new LongVector ();

	if (doc->Stat.Status & DS_EVD) {
		long i = -1;
		try {
			m_helper->load_data (doc->DocId);

			if (para == -1) {
				ret->reserve (1024);
				for (i = 0; i < doc->Stat.ParaCount; ++i) {
					this->get_resp_documents (ret.inout (), doc, i);
				}
			} else {
				ret->reserve (16);
				this->get_resp_documents (ret.inout (), doc, para);
			}
		} catch (...) {
			LOG_UEX (("%s: canceled: para = %d", GDS_CURRENT_FUNCTION, i));
		}

		if (is_sorted) {
			std::sort (ret->begin (), ret->end ());
			LongVector::iterator it = std::unique (ret->begin (), ret->end ());
			ret->resize (std::distance (ret->begin (), it));
		}
	}

	return ret._retn ();
}

void EndtParser::remove_bad_ref (Document* doc) {
	if (doc) {
		EndtWriter writer (0);
		writer.create_new_document (doc->DocId, &(doc->Stat));

		bool is_no_doc = ((doc->Stat.Status & (DS_DOC | DS_EDITION)) == 0);

		WriteToNdt write_to_ndt (&writer);
		evd::IeeGenerator_var generator = new RefFilter_i (&write_to_ndt, m_helper.ptr (), 0, is_no_doc);

		if (generator.ptr ()) {
			long i = 0;

			try {
				generator->Start ();

				for (; i < doc->Stat.ParaCount; ++i) {
					const char* para_buffer = doc->GetPara (i);

					if (para_buffer) {
						m_helper->set_para (i);
						{
							EndtReader endt_reader (para_buffer, NO_RECODE);

							const EndtReader::ParaPart* left = endt_reader.get_para ();

							writer.set_flags (endt_reader.get_flags ());
							writer.set_code_page (endt_reader.get_code_page ());
							writer.set_object_id (endt_reader.get_object_id ());
							writer.set_text (left->m_text, left->m_text_len);

							EndtParser::execute (generator.in (), left, true);
						}
						m_helper->set_reset (true);
					}
				}

				generator->Finish ();

			} catch (...) {
				LOG_UEX (("%s: topic %d, para %d", GDS_CURRENT_FUNCTION, doc->DocId, i));
			}
		}
	}
}

void EndtParser::remove_bad_ref_2 (Document* doc) {
	if (doc) {
		EndtWriter writer (0);
		writer.create_new_document (doc->DocId, &(doc->Stat));

		bool is_no_doc = ((doc->Stat.Status & (DS_DOC | DS_EDITION)) == 0);

		WriteToNdt write_to_ndt (&writer);
		evd::IeeGenerator_var generator = new RefFilter2_i (&write_to_ndt, m_helper.ptr (), 0, is_no_doc);

		if (generator.ptr ()) {
			long i = 0;

			try {
				generator->Start ();

				for (; i < doc->Stat.ParaCount; ++i) {
					const char* para_buffer = doc->GetPara (i);
					long flags = doc->EVDFlags ((char*) para_buffer);

					bool is_comment = (flags & ENDT_COMMENTS) && ((flags & ENDT_VERSION_COMMENTS) == 0) && ((flags & ENDT_HAS_BMP) == 0);

					if (para_buffer) {
						m_helper->set_para (i);
						{
							EndtReader endt_reader (para_buffer, NO_RECODE);

							const EndtReader::ParaPart* left = endt_reader.get_para ();

							writer.set_flags (is_comment ? 0x160000 : endt_reader.get_flags ());
							writer.set_code_page (endt_reader.get_code_page ());
							writer.set_object_id (endt_reader.get_object_id ());
							if (left->m_text_len) {
								const char *text = left->m_text;
								if (strstr (text, "См. текст ") == text || strstr (text, "См текст ") == text) {
									const char *prev = strstr (text, "в предыдущей редакции");
									const char *next = strstr (text, "в будущей редакции");
									if ((prev && prev-text+21 == left->m_text_len) || (next && next-text+18 == left->m_text_len)) {										
										for (int chars = 0; chars < left->m_text_len; chars++)
											left->m_text [chars] = ' ';
									}
								} else if (is_comment) {
									for (int chars = 0; chars < left->m_text_len; chars++)
										left->m_text [chars] = ' ';
								}
							}
							writer.set_text (left->m_text, left->m_text_len);

							m_helper->set_comment (is_comment);
							EndtParser::execute (generator.in (), left, true);
						}
						m_helper->set_reset (true);
					}
				}

				generator->Finish ();

			} catch (...) {
				LOG_UEX (("%s: topic %d, para %d", GDS_CURRENT_FUNCTION, doc->DocId, i));
			}
		}
	}
}

void EndtParser::remove_bad_ref_for_doc (Base* out_base, long doc_id) {
	m_helper->load_data (doc_id);
	m_helper->bad_ref_init ();
	
	try {
		Document_aptr doc = m_helper->open_document (doc_id);
		this->remove_bad_ref (doc.in ()); // remove styles from evd

	} catch (TopicNotFound&) {
		LOG_E (("%s: topic %d not found", GDS_CURRENT_FUNCTION, doc_id));
	} catch (NotEvdFormat&) {
	} catch (...) {
		LOG_UEX (("%s: topic %d", GDS_CURRENT_FUNCTION, doc_id));
	}

	m_helper->remove_bad_ref (out_base, doc_id); // remove refs from index
}

void EndtParser::remove_bad_ref_for_doc_2 (Base* out_base, long doc_id) {
	m_helper->load_data (doc_id);
	m_helper->bad_ref_init ();
	
	try {
		Document_aptr doc = m_helper->open_document (doc_id);
		this->remove_bad_ref_2 (doc.in ()); // remove styles from evd

	} catch (TopicNotFound&) {
		LOG_E (("%s: topic %d not found", GDS_CURRENT_FUNCTION, doc_id));
	} catch (NotEvdFormat&) {
	} catch (...) {
		LOG_UEX (("%s: topic %d", GDS_CURRENT_FUNCTION, doc_id));
	}

	m_helper->remove_bad_ref_2 (out_base, doc_id); // remove refs from index
}

void EndtParser::remove_bad_ref (Base* out_base, const DocData& data, long doc_id) {
	if (out_base) {
		m_helper->set_doc_data (data);

		if (doc_id) {
			this->remove_bad_ref_for_doc (out_base, doc_id);
		} else {
			Core::Aptr <DocCollection> topics = m_helper->get_base ()->AllTopics (100000);

			if (topics.ptr () && topics->ItemCount > 0) {
				ProcessIndicator indicator (GDS_CURRENT_FUNCTION);
				indicator.init (topics->ItemCount);

				for (long i = 0; i < topics->ItemCount; ++i) {
					indicator.update (i, (*topics)[i]);

					this->remove_bad_ref_for_doc (out_base, (*topics)[i]);
				}
			} else {
				LOG_E (("%s: topics not found", GDS_CURRENT_FUNCTION));
			}
		}
	}
}

void EndtParser::remove_bad_ref_2 (Base* out_base, const DocData& data, long doc_id) {
	if (out_base) {
		m_helper->set_doc_data (data);

		if (doc_id) {
			this->remove_bad_ref_for_doc (out_base, doc_id);
		} else {
			Core::Aptr <DocCollection> topics = m_helper->get_base ()->AllTopics (100000);

			if (topics.ptr () && topics->ItemCount > 0) {
				ProcessIndicator indicator (GDS_CURRENT_FUNCTION);
				indicator.init (topics->ItemCount);

				for (long i = 0; i < topics->ItemCount; ++i) {
					indicator.update (i, (*topics)[i]);

					this->remove_bad_ref_for_doc_2 (out_base, (*topics)[i]);
				}
			} else {
				LOG_E (("%s: topics not found", GDS_CURRENT_FUNCTION));
			}
		}
	}
}

void EndtParser::decompile_table (long doc_id, TableInfo& out) {
	GDS_ASSERT (doc_id);

	long data_size = 0;

	try {
		INDEX_DATA (char) data = m_helper->get_idd_evd (doc_id, data_size);

		if (data_size) {
			std::string info;

			evd::IeeGenerator_var generator = TableDecompileFactory::make (info);

			for (const char* ptr = data.in (); ptr - data.in () < (int) (data_size & 0x7fffffff); ) {
				long id = *(long*) ptr;
				ptr += sizeof (long);
				long size = *(char*) ptr;

				EndtParser::execute (generator.in (), ++ptr, size);

				ptr += size;

				if (out.find (id) == out.end ()) {
					out [id] = info;
				} else {
					std::string oldinfo = out [id];
					long indent, oldindent, zoom, oldzoom;
					sscanf (oldinfo.c_str (), "TABLE %ld %ld", &oldindent, &oldzoom);
					sscanf (info.c_str (), "TABLE %ld %ld", &indent, &zoom);
					char newinfo [32];
					sprintf (newinfo, "TABLE %ld %ld", indent + oldindent, zoom + oldzoom);
					out [id] = newinfo;
				}
			}
		}
	} catch (...) {
		LOG_UEX (("%s: canceled: doc %d", GDS_CURRENT_FUNCTION, doc_id));
	}
}

static long find_sub (Base* base, long doc_id, long para) {
	IndexLoader loader (base);
	long structs_count, i = 0, ret = 0;
	INDEX_DATA (DocStruct) structs = loader.load <DocStruct> (doc_id, IDD_DOCSTRUCT, structs_count);
	DocStruct *ptr;
	for (ptr = structs.ptr (), i = 0; i < structs_count; i++, ptr++) {
		short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
		if (evd_type == SUBDESCEX_BLOCK	&& para >= (long) ptr->m_start_para && para <= (long) ptr->m_end_para) {
			ret = ptr->m_para_list_id;
		}
	}
	return ret;
}

void EndtParser::get_norm_definitions (long doc_id, GCL::StrVector& out) {
	long i = -1, ids_count = 0;

	char delimiter = '@';

	std::string norm_def_style = "!STYLE J 0 73 5";
	std::string id_str (1, delimiter);
	id_str += boost::lexical_cast <std::string> (doc_id);
	id_str += '.';

	try {
		Document_aptr doc = m_helper->open_document (doc_id);

		INDEX_DATA (long) para_ids = IndexLoader (doc->base).load <ParaId> (doc->DocId, IDD2_PARAIDS, ids_count);

		GDS_ASSERT (para_ids.ptr ());

		for (i = 0; i < doc->Stat.ParaCount; ++i) {
			if (para_ids.ptr () [i]) {
				Core::Aptr <NsrcData> data = this->get_nsrc_data (doc.in (), i, 0);

				if (data.ptr () && data->is_valid ()) {
					if (!norm_def_style.compare (data->get_style ())) {
						const char* first = data->get_text ();
						const char* last = first + data->get_text_len () - 1;
#ifdef _DEBUG
						std::string str = GCL::convert (first, GCL::cd_dos, GCL::cd_win);
						const char* buf = str.c_str ();
#endif
						if (*last != AT_SEL1) {
							const char* ptr = std::find (first, last, AT_SEL1);

							if (ptr != last && ptr - first < 10) {
								out.push_back (GCL::convert (first, GCL::cd_dos, GCL::cd_win));
								std::string& item = out.back ();
								std::replace (item.begin (), item.end (), AT_SEL1, delimiter);
								item += id_str;
								item += boost::lexical_cast <std::string> (find_sub (doc->base, doc_id, i));
							}
						}
					}
				} else {
					LOG_E (("%s: invalid nsrc dara: {%d,%d}", GDS_CURRENT_FUNCTION, doc_id, i));
				}
			}
		}
	} catch (TopicNotFound& ex) {
		LOG_W (("%s: %s", ex.what (), GDS_CURRENT_FUNCTION));
	} catch (NotEvdFormat& ex) {
		LOG_W (("%s: %s", ex.what (), GDS_CURRENT_FUNCTION));
	} catch (...) {
		LOG_UEX (("%s: canceled: para = %d", GDS_CURRENT_FUNCTION, i));
	}
}

void EndtParser::execute (evd::IeeGenerator* generator, const EndtReader::ParaPart* part, bool is_para) {
	if (is_para) {
		generator->StartChild (evd::id_TextPara);
	} else {
		generator->Start ();
	}

	evd::EvdReader_var evd_reader = new evd::EvdReader (part->m_style, part->m_style_len, generator);
	evd_reader->convert_binary_object ();

	generator->Finish ();
}

void EndtParser::execute (evd::IeeGenerator* generator, const char* buf, long size) {
	generator->Start ();

	evd::EvdReader_var evd_reader = new evd::EvdReader (buf, size, generator);
	evd_reader->convert_binary_object ();

	generator->Finish ();
}

} // namespace
