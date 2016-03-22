//
// ParaTree.cpp : implementation file
//
#pragma warning (disable: 4786 4284)

#include "ace/ACE.h"

#include "shared/GCL/str/str_conv.h"

#include "boost/lexical_cast.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "common/components/rtl/Garant/EVD/Types/Types.h"
#include "common/components/rtl/Garant/EVD/Styles/Styles.h"
#include "garantPIL/implementation/component/cpp/libs/endt/Helpers.h"

#include "common/components/rtl/Garant/EVD/eeReader.h"
#include "common/components/rtl/Garant/EVD/evddata.h"

#include "Cache.h"
#include "ParaTree.h"
#include "ConvertProc.h"

#include <algorithm>
#include <functional>

namespace EndtConvertor {

static const char* pictures_links [] = {
	"графическийобъект", "музыкальнуюредакцию(ноты)", "графическоеизображение"
};

static const unsigned LINKS_COUNT = sizeof (pictures_links) / sizeof (char*);

////////////////////////////////////////////////////////////////////////////////////////

static EVD::IndentType get_justification (unsigned char val) {
	switch (val) {
	case 'L':
		return EVD::it_Left;
		break;
	case 'R':
		return EVD::it_Right;
		break;
	case 'J':
		return EVD::it_Width;
		break;
	case 'C':
		return EVD::it_Center;
		break;
	case 'P':
		return EVD::it_Preformatted;
		break;
	default:
		return EVD::it_None;
		break;
	}
}

bool only_blanks (const char* buffer, int size) {
	const char* res = std::find_if (buffer, buffer + size, std::bind2nd (std::not_equal_to <char> (), ' '));
	return res == (buffer + size);
}

////////////////////////////////////////////////////////////////////////////////////////

void TopicData::set_address (Base* base, long doc_id, Ref* pRef) {
	if (pRef->DocId != doc_id) {
		m_status = Cache::Singleton::instance ()->get_status (pRef->DocId);
	}

	if (m_status & DS_REFDOC) {           // if reference
		m_class_id = EndtTools::CI_REF;
	} else if (m_status & DS_EDITION) {   // if redaction
		m_class_id = EndtTools::CI_EDITION;
	} else {                              // if topic
		m_class_id = EndtTools::CI_TOPIC;
	}

	if (pRef->DocId != doc_id && m_class_id == EndtTools::CI_REF) {
		Core::Aptr <Document> doc = base->GetDoc (pRef->DocId);

		char* para = doc->EVDParaText (doc->GetPara (base->SubToPara (*pRef)));

		if (strstr (para, "script:") == para) {
			m_class_id = EndtTools::CI_SCRIPT;
		} else if (strstr (para, "eno:") == para) {
			m_class_id = EndtTools::CI_ENO;
		} else if (strstr (para, "query:") == para) {
			m_class_id = EndtTools::CI_SEARCH_QUERY;
		}
	}

	m_object_id = pRef->DocId;
	m_sub = (EndtTools::is_dict_document (pRef->DocId))? 0 : pRef->Sub;
}

void TopicData::add_address (evd::IeeGenerator* generator, long doc_id) {
	if (m_object_id != (unsigned long) doc_id) { // if the link is not sub in this document
		this->add_redactions (generator, doc_id);
	}

	generator->AddIntegerAtom (evd::ti_Type, m_class_id);

	if (m_sub) {
		generator->AddIntegerAtom (evd::ti_SubID, m_sub);
	}
}

void TopicData::add_redactions (evd::IeeGenerator* generator, long doc_id) {
	long active_redaction_doc_id = 0;

	Cache* _cache = Cache::Singleton::instance ();

	if (m_status == 0) {
		active_redaction_doc_id = _cache->get_active_redaction_ex ((long) m_object_id);
	} else if (m_class_id == EndtTools::CI_EDITION) {
		active_redaction_doc_id = _cache->get_active_redaction ((long) m_object_id, m_status);
	} 

	if (active_redaction_doc_id > 0) {
		// if this a redaction of another document
		if (active_redaction_doc_id != _cache->get_active_redaction (doc_id, _cache->get_status (doc_id))) { 
			generator->AddIntegerAtom (evd::ti_DocID, active_redaction_doc_id);
			m_class_id = EndtTools::CI_EDITION;
		}
		generator->AddIntegerAtom (evd::ti_Revision, m_object_id);
	} else {
		generator->AddIntegerAtom (evd::ti_DocID, m_object_id);
	}
}

////////////////////////////////////////////////////////////////////////////////////////

TreeNode::TreeNode (Para* master, NodeType type) 
	: m_parent (0)
	, m_type (type) 
	, m_master (master) {
}

TreeNode::~TreeNode () {
	node_t *n1 = 0, *n2 = 0;

	for (n1 = &m_children; n1; n1 = n2) {
		n2 = n1->m_next;

		if (n1->m_child) {
			delete n1->m_child; 
			n1->m_child = 0;
		}

		if (n1 != &m_children) {
			delete n1; 
			n1 = 0;
		}
	}
}

void TreeNode::add_child (TreeNode* child) {
	if (m_children.m_child) {
		node_t* node = 0;
		for (node = &m_children; node->m_next; node = node->m_next);
		node->m_next = new node_t ();
		node->m_next->m_child = child;
	} else {
		m_children.m_child = child;
	}

	child->m_parent = this;
}

void TreeNode::add_text (const char* text) {
	if (m_children.m_child) {
		node_t* node = 0;
		for (node = &m_children; node->m_next; node = node->m_next);
		node->m_text_after += text;
	} else {
		m_text_before += text;
	}
}

void TreeNode::generate_style (
	evd::IeeGenerator* generator
	, EndtTools::EndtWriter& writer
	, std::string& str
	, std::string& part
) {
	if (m_position.is_valid ()) {
		if (m_master->need_normalize ()) {
			this->normalize (m_master->get_obj_seg_positions ()); // нормализация длины сегмента
		}

		switch (m_type) {
		case nt_DecorStyle:
			{
				DecorStyle* node = static_cast <DecorStyle*> (this);

				std::string decor = node->get_decor ();
				if (decor.size ()) {
					char positions [64];
					sprintf (positions, "Start = %ld Finish = %ld ", m_position.start, m_position.finish);
					std::string segment (positions);
					segment += decor;					
					if (part.size ()) {
						std::string text = part;
						GCL::string_recoding (GCL::cd_dos, GCL::cd_win, &(*text.begin ()), 0);
						segment += " Text = '";
						segment += text;
						segment += "'";
					}
					std::string buffer;
					buffer = ": TextSegment = {" + segment;
					buffer += "}";
					evd::EvdReader_var evd_reader = new evd::EvdReader (buffer.c_str (), buffer.size (), generator);
					evd_reader->convert_text_object ();
				}
			}
			break;
		case nt_Link:
			{
				Link* node = static_cast <Link*> (this);

				if (node->is_display_picture ()) {
					writer.set_object_id (node->m_data.get_object_id ());
					writer.set_flag (ENDT_HAS_BMP);

					str.clear ();
					part.clear ();
				} else {
					generator->StartChild (evd::id_HyperLink); {
						generator->AddIntegerAtom (evd::ti_Start,  m_position.start);
						generator->AddIntegerAtom (evd::ti_Finish, m_position.finish);

						generator->StartChild (evd::id_Address); {
							node->m_data.add_address (generator, m_master->get_doc ());
							if (node->m_name.empty () == false) {
								generator->AddStringAtom (evd::ti_Name, node->m_name.c_str ());
							}
						}
						generator->Finish ();
					}
					generator->Finish ();
				}
			}
			break;
		case nt_Formula:
			generator->StartChild (evd::id_ObjectSegment); {
				generator->AddIntegerAtom (evd::ti_Start,  m_position.start);
				generator->AddIntegerAtom (evd::ti_Finish, m_position.start);

				std::string formula_text = part;

				if (formula_text.size ()) {
					GCL::string_recoding (GCL::cd_dos, GCL::cd_win, &(*formula_text.begin ()), 0);
				}

				generator->StartChild (evd::id_Formula); {
					generator->AddStringAtom (evd::ti_Text, formula_text.c_str ());
				}
				generator->Finish ();
			}
			generator->Finish ();

			part = '*';
			break;
		case nt_Picture:
			generator->StartChild (evd::id_ObjectSegment); {
				generator->AddIntegerAtom (evd::ti_Start,  m_position.start);
				generator->AddIntegerAtom (evd::ti_Finish, m_position.start);

				long blob_id = 0, bloffs = 0, dpi_val = 0, width = 0, height = 0;

				GCL::StrVector data;
				boost::split (data, part, boost::is_any_of (":;"));

				for (GCL::StrVector::const_iterator it = data.begin (); it != data.end (); ++it) {
					if (*it == "topic") {
						++it;
						blob_id = boost::lexical_cast <long> (*it) + ID_BORDER;
					} else if (*it == "bloffs") {
						++it;
						bloffs  = boost::lexical_cast <long> (*it);
					} else if (*it == "res") {
						++it;
						dpi_val = boost::lexical_cast <long> (*it);
					} else if (*it == "width") {
						++it;
						width = boost::lexical_cast <long> (*it);
					} else if (*it == "height") {
						++it;
						height = boost::lexical_cast <long> (*it);
					}
				}

				generator->AddIntegerAtom (evd::ti_BaseLine, bloffs);

				generator->StartChild (evd::id_BitmapPara); {
					generator->AddIntegerAtom (evd::ti_ExternalHandle, blob_id);
					generator->AddIntegerAtom (evd::ti_DPI, dpi_val);

					if (height) { 
						generator->AddIntegerAtom (evd::ti_Height, height);
					}

					if (width) { 
						generator->AddIntegerAtom (evd::ti_Width, width);
					}
				}
				generator->Finish ();
			}
			generator->Finish ();

			part = '*';
			break;
		default:
			m_master->make_style (generator, this, m_position);
			break;
		}
	} else {
#ifdef _DEBUG
		_msg_log (
			"%s: invalid segment: {start: %ld, finish: %ld}, type: %ld, topic: %ld"
			, GDS_CURRENT_FUNCTION
			, m_position.start
			, m_position.finish
			, m_type
			, m_master->get_doc ()
		);
#endif
	}
}

std::string TreeNode::generate (
	evd::IeeGenerator* generator
	, EndtTools::EndtWriter& writer
	, const ParaHeights& para_heights
) {
	std::string str = m_text_before;

	if (m_children.m_child) {
		for (node_t* node = &m_children; node && node->m_child; node = node->m_next) {
			std::string part = node->m_child->generate (generator, writer, para_heights);

			node->m_child->generate_style (generator, writer, str, part);

			str += part;
			str += node->m_text_after;
		}
	} 

	/*
#ifdef _DEBUG
	if (str.size ()) {
		std::string para_str = GCL::convert (str.c_str (), GCL::cd_dos, GCL::cd_win);
		const char* para_buf = para_str.c_str ();
	}
#endif
	*/

	return str;
}

void TreeNode::normalize (const Positions& positions) {
	long start = m_position.start, finish = m_position.finish;

	for (Positions::const_iterator it = positions.begin (); it != positions.end (); ++it) {
		if (it->start > m_position.finish) { // формула находится за текущим сегментом
			break;
		}

		size_t delta = (it->finish > it->start)? it->finish - it->start : 0;

		finish -= delta;

		if (m_type != nt_Formula) {
			if (it->finish < m_position.start) { // формула находится до текущего сегмента
				start -= delta;
			}
		} else if (it->start != m_position.start) {
			start -= delta;
		}
	}

	m_position.start = start;
	m_position.finish = finish;
}

////////////////////////////////////////////////////////////////////////////////////////

void Link::make (Base* base, const char* buf, short& pos, size_t count, long doc_id) {
	m_ref_type = buf [pos + 1];
	m_ref_count = GetHTRefCount (*(unsigned short*)(buf + pos + 2));

	bool is_med_topics = false;

	switch (m_ref_type) {
	case REFTYPE_REFLIST:
		if (m_ref_count == 1) {
			Ref* obj = (Ref*)(buf + pos + 4);
			m_data.set_address (base, doc_id, obj);
		} else if (MedTopicsSingleton::instance ()->load (base)) {
			DocCollection data;

			for (size_t i = 0, offset = 4; i < m_ref_count; ++i, offset += 8) {
				Ref* obj = (Ref*)(buf + pos + offset);
				data.Add (obj->DocId);
			}

			is_med_topics = MedTopicsSingleton::instance ()->is_medtopics (data);
		}
		pos += 3 + m_ref_count * sizeof (Ref);
		break;
	case REFTYPE_BLOB:
		if (m_ref_count == 1) {
			ObjKey* obj = (ObjKey*)(buf + pos + 4);

			ObjInfo_ info;
			Cache::Singleton::instance ()->get_blob_info (obj->id, info);

			m_name = info.name;
			m_obj_type = info.type;
			m_obj_id = obj->id;

			m_data.set_data ((m_obj_type == EOT_PIC || m_obj_type == EOT_PNG || m_obj_type == EOT_GIF || m_obj_type == EOT_JPG)? EndtTools::CI_PIC : EndtTools::CI_BLOB, obj->id, 0);
		}
		pos += 3 + m_ref_count * sizeof (ObjKey);
		break;
	}

	if (m_ref_count > 1) {
		unsigned long class_id = (is_med_topics == true)? EndtTools::CI_PHARM_MULTI : EndtTools::CI_MULTI;
		m_data.set_data (class_id, 0, count);
	}
}

////////////////////////////////////////////////////////////////////////////////////////

Para::Para () 
	: m_root (0)
	, m_para (0)
	, m_para_style (st_Empty)
	, m_doc (0)
	, m_para_len (0)
	, m_first_empty (0)
	, m_has_bmp (false)
	, m_has_pseudo_graph (false)
	, m_has_legal_content (false)
	, m_has_comment_handle (false)
	, m_is_legal_comment (false)
	, m_is_comment_in_chain (false) {
}

Para::~Para () {
	if (m_root) {
		delete m_root; 
		m_root = 0;
	}
}

void Para::reset () {
	if (m_root) {
		delete m_root; 
		m_root = 0;
	}

	m_obj_seg_positions.clear ();

	m_para_len = 0;
	m_first_empty = 0;
	m_para_style = st_Empty;

	m_has_bmp = false;
	m_is_legal_comment = false;
	m_has_pseudo_graph = false;
	m_has_legal_content = false;
	m_has_comment_handle = false;
	m_is_endt_comments = false;

	marked_positions.clear ();
}

void Para::build_tree (
	Base* base
	, Document* doc
	, const Para& prev
	, unsigned num
	, bool& is_chain
	, bool has_sub
	, bool inherit_prev
) {
	this->reset ();

	m_para = num;
	m_doc = doc->DocId;
	m_is_comment_in_chain = is_chain;

	char* buffer = doc->GetPara (m_para);
	short para_size = TextSize (buffer);

	m_style = ParaStyle (buffer);
	m_redline = RedLine (buffer);
	m_leftmargin = LeftMargin (buffer);
	m_rightmargin = RightMargin (buffer);

	buffer = ParaText (buffer);

	/*
#ifdef _DEBUG
	std::string p_str = GCL::convert (buffer, GCL::cd_dos, GCL::cd_win);
	const char* p_buf = p_str.c_str ();
#endif
	*/

	GDS_ASSERT (m_style != PS_SIDEBYSIDE);

	long pos = 0;

	size_t links_count = 0, offset = 0, picture_link_len = 0;

	bool in_print = false
		, in_xref = false
		, in_sel1 = false
		, in_sel2 = false
		, in_sel3 = false
		, in_sel6 = false
		, in_fut  = false
		, in_pic  = false
		, in_formula = false
		, in_decor = false;

	bool is_legal_comment = false, is_right_part = false;
	bool is_pseudo_content = only_blanks (buffer, para_size); // if the para has blanks only, it can be pseudo content

	char node_text [MAX_PARA_LEN] = {'\0'};

	TreeNode* cur_node = 0;

	this->add_node <Normal> (cur_node);

	for (short i = 0; i < para_size;) {
		if (is_pseudo_content && buffer [i] != AT_PRINT) {
			is_pseudo_content = false;
		}

		switch (buffer [i]) {
		case AT_XREF:
			if (in_xref) {
				Link* link_node = static_cast <Link*> (cur_node);
				link_node->make (base, buffer, i, links_count, doc->DocId);

				if (link_node->is_picture ()) {
					if (this->is_show_picture (node_text) && is_true_before (buffer)) {
						m_has_bmp = true;
						link_node->set_display_picture (true);
					} else { // Add info to log if link was not converted to picture
						PictList::Singleton::instance ()->add (m_doc, link_node->get_obj_id ());
					}
				}
				++links_count;
			}

			this->make_node <Link> (cur_node, in_xref, offset);
			++i;
			break;
		case AT_SEL1:
			if (in_decor) {
				this->make_node <DecorStyle> (cur_node, in_decor, offset);
				++i;
			} else if (!strncmp (buffer + i + 1, "decor:{", 7)) {
				this->make_node <DecorStyle> (cur_node, in_decor, offset);
				DecorStyle* decor_node = static_cast <DecorStyle*> (cur_node);
				i += 7;
				long depth = 0, from = 0;
				for (;;) {
					if (buffer [i] == '{') {
						if (0 == depth)
							from = i - 1;
						depth++;
					} else if (buffer [i] == '}') {
						depth--;
						if (0 == depth)
							break;
					}
					++i;
				}
				if (from) {
					std::string decor (buffer + from + 2, i - from - 2);
					decor_node->set_decor (decor);
				}
				++i; //skip '}'
			} else {
				this->make_node <Header> (cur_node, in_sel1, offset);
				++i;
			}
			break;
		case AT_SEL2:
			if (!in_sel2) {
				get_segment_start (buffer + i + 1, offset, pos);
				--pos;
			} else {
				pos = offset - get_space_count (node_text, ACE_OS::strlen (node_text));
			}

			this->make_node <LinkCont> (cur_node, in_sel2, pos);
			++i;
			break;
		case AT_SEL3:
			if (!is_legal_comment) {
				this->make_node <Comment> (cur_node, in_sel3, offset);

				if (in_sel3) {
					m_is_legal_comment = true;
				}
			}
			++i;
			break;
		case AT_PRINT:
			if (!in_print) {
				if (buffer [i + 1] == AT_SEL3) {
					this->add_node <LegalComment> (cur_node, offset);

					m_is_legal_comment = true;
					is_legal_comment = true;

					if (buffer [i + 2] == AT_PRINT) {
						_msg_log ("%s: invalid style: topic: %ld, para: %ld", GDS_CURRENT_FUNCTION, m_doc, m_para);
					}
				} else {
					bool find_content = false;
					int j = i + 1;

					for (; j < para_size; ++j) {
						if (buffer [j] != ' ') {
							if (buffer [j] == AT_SEL2 || buffer [j] == AT_XREF) {
								find_content = true;
							}
							break;
						}
					}

					// Если параграф не имеет текста, то добавляем ноду как LegalContent
					if (find_content || j == para_size - 1) {
						this->add_node <LegalContent> (cur_node, offset);
						m_has_legal_content = true;
					} else {
						this->add_node <NoPrint> (cur_node, offset);
					}
				}
			} else {
				cur_node->set_finish (offset);
				this->go_up (cur_node);
				is_legal_comment = false;
			}

			in_print = !in_print;
			++i;
			break;
		case AT_MARKEDTEXT:
			marked_positions.push_back (offset);
			++i;
			break;
		case AT_SEL6:
			this->make_node <NoActive> (cur_node, in_sel6, offset);
			++i;
			break;
		case AT_FUT:
			this->make_node <NotApplied> (cur_node, in_fut, offset);
			++i;
			break;
		case AT_FORMULA:
			if (!in_formula) {
				this->add_node <Formula> (cur_node, offset);
			} else {
				cur_node->set_finish (offset);

				// Т.к. формулы вырезаются из текста, то собираем в вектор позиции соотв. сегментов 
				// Необходимо для последующей нормализации позиций сегментов
				m_obj_seg_positions.push_back (cur_node->get_position ());

				this->go_up (cur_node);
			}

			in_formula = !in_formula;
			++i;
			break;
		case AT_EMBEDDEDPIC:
			if (!in_pic) {
				this->add_node <Picture> (cur_node, offset);
			} else {
				cur_node->set_finish (offset);

				// Т.к. инфа о картинках вырезается из текста, то собираем в вектор позиции соотв. сегментов 
				// Необходимо для последующей нормализации позиций сегментов
				m_obj_seg_positions.push_back (cur_node->get_position ());

				this->go_up (cur_node);
			}
			in_pic = !in_pic;
			++i;
			break;
		default:
			bool is_first_empty = (i == 0);

			unsigned j = 0;

			while (i < para_size && this->is_nsr_char (buffer [i]) == false) {
				if (buffer [i] == '\0' && i < para_size - 1) {
					_msg ("%s: embedded 0 in para text: topic: %ld, para: %ld", GDS_CURRENT_FUNCTION, m_doc, m_para);
					++i;
				} else {
					if (m_has_pseudo_graph == false) {
						m_has_pseudo_graph = is_pseudo_graph (buffer [i]);
					}

					if (is_first_empty) {
						if (buffer [i] == ' ') {
							++m_first_empty;
						} else {
							is_first_empty = false;
						}
					}

					node_text [j++] = buffer [i++];
				}
			}

			node_text [j] = '\0';

			/*
#ifdef _DEBUG
			std::string para_str = GCL::convert (node_text, GCL::cd_dos, GCL::cd_win);
			const char* para_buf = para_str.c_str ();
#endif
			*/

			offset += j;

			cur_node->add_text (node_text);
			break;
		}
	}

	m_para_len = offset;

	if (m_para > 0) {
		if (prev.m_is_legal_comment && para_size == 0) {
			if (inherit_prev)
				m_para_style = (prev.m_style == PS_VERSION)? st_PseudoVersionComment : st_PseudoComment;
		} else if (prev.m_has_legal_content && is_pseudo_content) {
			m_para_style = st_PseudoContent;
			m_has_legal_content = true;
		}

		if (m_is_comment_in_chain) {
			if (prev.is_garant_comment () && this->is_version_comment ()) {
				m_is_comment_in_chain = false;
			} else if (prev.is_version_comment () && this->is_garant_comment ()) {
				m_is_comment_in_chain = false;
			}
		}
	}

	is_chain = (
		m_is_legal_comment 
		|| m_para_style == st_PseudoComment 
		|| m_para_style == st_PseudoVersionComment
	);

	if (is_chain) { // the legal comment or sub is found in a chain of legal comments
		m_has_comment_handle = ((m_is_comment_in_chain == false || has_sub) && !m_has_bmp);
	}
}

bool Para::is_show_picture (const char* buf) {
	bool ret = false; 

	if (m_style != PS_PREFORMATTED && buf) {
		char recode [1024] = {'\0'};

		ACE_OS::strcpy (recode, buf);
		GCL::string_recoding (GCL::cd_dos, GCL::cd_win, recode, 0);
		GCL::string_lower (recode);
		
		char parse [1024] = {'\0'};
		char* seps = " ";
		char* token = ACE_OS::strtok (recode, seps);

		GCL::StrVector words;
		words.push_back (std::string ("См"));
		
		while (token) {
			words.push_back (std::string (token));
			ACE_OS::strcat (parse, token);
			token = ACE_OS::strtok (0, seps);
		}

		for (unsigned i = 0; i < LINKS_COUNT; ++i) {
			ret = (!ACE_OS::strcmp (parse, pictures_links [i]));
			if (ret) {
				break;
			}
		}
	}

	return ret;
}

void Para::set_style (const TreeNode::NodeType& type) {
	if (m_para_style == st_Empty) {
		switch (type) {
		case TreeNode::nt_Comment:
			m_para_style = st_Comment;
			break;
		case TreeNode::nt_LegalComment:
			m_para_style = st_LegalComment;
			break;
		case TreeNode::nt_Header:
			m_para_style = st_Header;
			break;
		case TreeNode::nt_LegalContent:
			m_para_style = st_LegalContent;
			break;
		case TreeNode::nt_NoPrint:
			m_para_style = st_NoPrint;
			break;
		case TreeNode::nt_NoActive:
			m_para_style = st_NoActive;
			break;
		case TreeNode::nt_NotApplied:
			m_para_style = st_NotApplied;
			break;
		default:
			_msg_log ("%s: unknown style: node type: %ld, topic: %ld", GDS_CURRENT_FUNCTION, type, this->get_doc ());
			break;
		}
	} else if (!this->is_pseudo ()) {
		_msg_log ("%s: incorrect style: node type: %ld, topic: %ld", GDS_CURRENT_FUNCTION, type, this->get_doc ());
	}
}

void Para::generate (
	evd::IeeGenerator* generator
	, EndtTools::EndtWriter& writer
	, bool is_clear_pseudo
	, const ParaHeights& para_heights
) {    
	if (is_clear_pseudo && (m_para_style == st_PseudoComment || m_para_style == st_PseudoVersionComment)) {
		m_para_style = st_Empty;
	}

	generator->StartChild (evd::id_TextPara);

	if (m_root) {
		if (m_has_comment_handle) {
			generator->StartChild (evd::id_Mark); {
				if (m_style == PS_VERSION) {
					generator->AddIntegerAtom (evd::ti_Flags, EVD::c_VersionCommentsFlag);
				} else {
					generator->AddIntegerAtom (evd::ti_Flags, EVD::c_CommentsFlag);
				}
			}
			generator->Finish ();
		}

		if (m_style == PS_STYLED) {
			generator->StartTag (evd::ti_TabStops);
				generator->StartDefaultChild ();
					generator->AddIntegerAtom (evd::ti_Type, 3);
					generator->AddIntegerAtom (evd::ti_Start, evd::char2inch (m_leftmargin));
				generator->Finish ();
			generator->Finish ();
		}

		long para_height = para_heights.get_para_height (m_para);

		if (para_height) {
			generator->AddIntegerAtom (evd::ti_PrintFontSize, para_height);
		}

		try {
			writer.m_text = m_root->generate (generator, writer, para_heights);
		} catch (...) {
			_msg ("%s: unknown exception: topic: %ld, para: %ld", GDS_CURRENT_FUNCTION, m_doc, m_para);
			throw std::exception ();
		}

		/*
#ifdef _DEBUG
		std::string p_str;
		if (writer.m_text.size ()) {
			p_str = GCL::convert (writer.m_text.c_str (), GCL::cd_dos, GCL::cd_win);
		}
		const char* p_buf = p_str.c_str ();
#endif
		*/

		if (m_style == PS_STYLENUM) {
			if (m_leftmargin == (-1) * EVD::sa_ChangesInfo) {
				writer.set_flag (ENDT_DOC_DATES);
			} else if ((m_leftmargin == (-1) * EVD::sa_TxtHeader2) || (m_leftmargin == (-1) * EVD::sa_TxtHeader3)) {
				writer.set_flag (ENDT_ARTICLE_HEADER);
			}

			generator->AddIntegerAtom (evd::ti_Style, (-1) * m_leftmargin);

			if (m_redline) {
				generator->AddIntegerAtom (evd::ti_LeftIndent, evd::char2inch (m_redline));
			}

			if (m_rightmargin) {
				generator->AddIntegerAtom (evd::ti_Justification, get_justification (m_rightmargin));
			}
		} else if (m_style != PS_SIDEBYSIDE) {
			if (m_style == PS_PREFORMATTED && writer.m_text.size ()) {
				writer.set_flag (ENDT_PREFORMATTED);
			}
				
			this->generate_style_1 (generator, writer);

			if (!writer.m_text.empty ()) {
				this->generate_style_2 (generator, writer);
			}
		}

		if (writer.get_flags () & ENDT_HAS_BMP) {
			writer.set_type (evd::id_BitmapPara);
		} else {
			writer.set_type (evd::id_TextPara);
		}

		writer.set_code_page_ (m_style, m_has_pseudo_graph);
	} 

	generator->Finish ();
}

bool Para::is_paragraph_style (TreeNode* node, unsigned seg_len) {
	if (m_style == PS_STYLENUM) {
		return false;
	}

	bool ret = false;

	TreeNode::NodeType node_type = node->get_type ();

	if (node_type == TreeNode::nt_LegalContent) {
		seg_len += m_first_empty;
	}

	if (m_para_len == seg_len) {
		if (node_type == TreeNode::nt_Header) {
			ret = (m_style == PS_CENTERED);
		} else if (node_type != TreeNode::nt_LinkContinue) {
			if (node_type == TreeNode::nt_LegalContent) {
				ret = true;
			} else {
				ret = (m_style != PS_PREFORMATTED);
			}
		}

		if (ret) {
			TreeNode* parent = node->parent ();

			if (parent->parent ()) {
				ret = (seg_len != parent->get_length ());
#ifdef _DEBUG
				if (ret) {
					_msg_log ("%s: parent->parent () != 0, %ld", GDS_CURRENT_FUNCTION, m_doc);
				}
#endif
			} 
		} 
	}

	return ret;
}

void Para::make_style (evd::IeeGenerator* generator, TreeNode* node, const Position& pos) {
	if (this->is_paragraph_style (node, pos.get_length ())) {
		this->set_style (node->get_type ());
	} else {
		this->generate_segment (generator, node->get_type (), pos);
	} 
}

void Para::generate_style_1 (evd::IeeGenerator* generator, EndtTools::EndtWriter& writer) {
	if (writer.get_type () == evd::id_BitmapPara) {
		return;
	}

	switch (m_para_style) {
	case st_Header:
		writer.set_flag (ENDT_HEADER);
		generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtHeader1);
		break;
	case st_Comment:
	case st_LegalComment:
	case st_PseudoComment:
	case st_PseudoVersionComment:
		if (m_style == PS_VERSION || m_para_style == st_PseudoVersionComment) {
			writer.set_flag (ENDT_VERSION_COMMENTS);
			m_is_endt_comments = true;
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_VersionInfo);
		} else {
			writer.set_flag (ENDT_COMMENTS);
			m_is_endt_comments = true;
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtComment);
		}
		if (m_para_style == st_Comment) {
			generator->AddBoolAtom (evd::ti_Visible, true);
		}
		break;
	case st_LegalContent:
	case st_PseudoContent:
		generator->AddIntegerAtom (evd::ti_Style, EVD::sa_Contents);
		break;
	case st_NoActive:
		generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtOutOfDate);
		break;
	case st_NotApplied:
		generator->AddIntegerAtom (evd::ti_Style, EVD::sa_NotApplied);
		break;
	case st_NoPrint:
		generator->AddBoolAtom (evd::ti_Visible, false);
		break;
	}
}

void Para::generate_style_2 (evd::IeeGenerator* generator, EndtTools::EndtWriter& writer) {
	bool is_not_style = false;

	if (m_style == PS_LEFT) {
		// Затычка: если стиль "прижатый влево" и с красной строкой (!), тогда преобразуем его в нормальный
		if (m_para_style == st_Empty && this->is_normal_ANSI ()) {
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtNormalANSI);
			return;
		}
	}

	switch (m_style) {
	case PS_CENTERED:
		if (m_para_style != st_Header) {
			generator->AddIntegerAtom (evd::ti_Justification, EVD::it_Center);
			generator->AddIntegerAtom (evd::ti_LeftIndent, evd::char2inch (m_leftmargin));
			generator->AddIntegerAtom (evd::ti_FirstIndent, evd::char2inch (m_redline));
		}
		break;
	case PS_JUSTIFIED:
		if (m_para_style == st_Empty) {
			if (this->is_normal_ANSI ()) {
				generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtNormalANSI);
			} else if (this->is_article_header ()) {
				writer.set_flag (ENDT_ARTICLE_HEADER);
				generator->AddIntegerAtom (evd::ti_Style, EVD::sa_ArticleHeader);
			} else if (this->is_normal_note ()) {
				generator->AddIntegerAtom (evd::ti_Style, EVD::sa_NormalNote);
			} else if (this->is_dict_entry ()) {
				generator->AddIntegerAtom (evd::ti_Style, EVD::sa_DictEntry);
			} else {
				is_not_style = true;
			}
		} else if (m_para_style == st_LegalComment) {
			if (m_leftmargin != 1 || m_redline != 1) {
				is_not_style = true;
			}
		} else {
			is_not_style = true;
		}
		break;
	case PS_RIGHT:
		generator->AddIntegerAtom (evd::ti_Justification, EVD::it_Right);
		if (m_redline == 111) {
			m_redline = 0;
		}
		is_not_style = true;
		break;
	case PS_LEFT:
		if (m_para_style == st_Empty) {
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_ToLeft);
		} 
		is_not_style = true; // Затычка: для прижатых влево всегда выливаем отступы :(
		break;
	case PS_PREFORMATTED:
		if (m_para_style == st_Empty) {
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtNormalOEM);
		} else {
			is_not_style = true;
		}
		break;
	}

	// Если стиль не найден, то выставляем принудительно отступы
	if (is_not_style) { 
		generator->AddIntegerAtom (evd::ti_LeftIndent, evd::char2inch (m_leftmargin));
		generator->AddIntegerAtom (evd::ti_FirstIndent, evd::char2inch (m_redline));
	}
}

void Para::generate_segment (evd::IeeGenerator* generator, const TreeNode::NodeType& type, const Position& pos) {
	generator->StartChild (evd::id_TextSegment); {
		generator->AddIntegerAtom (evd::ti_Start,  pos.start);
		generator->AddIntegerAtom (evd::ti_Finish, pos.finish);

		switch (type) {
		case TreeNode::nt_Comment:
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtComment);
			generator->AddBoolAtom (evd::ti_Visible, true);
			break;
		case TreeNode::nt_LegalComment:
			if (m_has_bmp == false) {
				generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtComment);
			}
			break;
		case TreeNode::nt_LegalContent:
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_Contents);
			break;
		case TreeNode::nt_NoActive:
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_TxtOutOfDate);
			break;
		case TreeNode::nt_Header:
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_ColorSelection);
			break;
		case TreeNode::nt_LinkContinue:
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_HyperLinkCont);
			break;
		case TreeNode::nt_NotApplied:
			generator->AddIntegerAtom (evd::ti_Style, EVD::sa_NotApplied);
			break;
		case TreeNode::nt_NoPrint:
			if (!this->is_legal ()) {
				generator->AddBoolAtom (evd::ti_Visible, false);
			}
			break;
		default:
			_msg_log ("%s: incorrect style: node type: %ld, topic: %ld", GDS_CURRENT_FUNCTION, type, this->get_doc ());
			break;
		}
	}
	generator->Finish ();
}

} // namespace

