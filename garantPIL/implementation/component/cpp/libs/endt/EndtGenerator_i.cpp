///
// EndtGenerator_i.cpp : implementation file
//

#include "ace/ACE.h"

#include "shared/GCL/str/str_conv.h" //!!!

#include "EndtGenerator_i.h"

namespace EndtTools {

static const unsigned long FT_FRAME_LEFT  = 0x0001;
static const unsigned long FT_FRAME_RIGHT = 0x0002;
static const unsigned long FT_FRAME_UP    = 0x0004;
static const unsigned long FT_FRAME_DOWN  = 0x0008;

/*
TODO: 
	избавится от m_para_level ???
	ссылки на ЭНО ???
	подумать о b_type ???

	обработать исключения
	разобраться с мультиссылками
	разобраться с id параграфов в ссылках
	разобраться с разрывами страниц
	обрабатывать Name и ShortName (например Name документа и саба)
	прикрутить логер-синглтон
*/

/*
Реквизиты документа!
*/

/*
Сделано, но не проверено:
	получение id документа из evd (ExternalHandle)
	что-то непонятное с сабнеймами
*/

static const long DOCS [2] = {555333, 10103000};
//static const long DOCS [2] = {10900200, 10103000};
static long test_counter = 0;

////////////////////////////////////////////////////////////////////////////////////////////////////

bool is_requisite (long tag_id)	{
	bool ret = false;

	switch (tag_id) {
		case evd::ti_AccGroups:
		case evd::ti_Groups:
		case evd::ti_Types:
		case evd::ti_Classes:
		case evd::ti_Prefix:
		case evd::ti_Sources:
		case evd::ti_KeyWords:
			ret = true;
			break;
	}

	return ret;
}

struct CellWriteFunction : public evd::UserWriter {
public:
	CellWriteFunction (IBaseWriter* writer) : m_writer (writer) {
	}

	long write (unsigned char* buffer, long buffer_size) {
		GDS_ASSERT (m_writer);

		// Cохраним данные в индекс IDD_EVD

		try {
			m_writer->write_table_info ((const char*) buffer, buffer_size);
		} catch (...) {
		}

		return 0;
	}

private:
	IBaseWriter* m_writer;
};

EndtWriteFunction::EndtWriteFunction (IEndtWriter* writer) : m_writer (writer) {
}

long EndtWriteFunction::write (unsigned char* buffer, long buffer_size) {
	return 0;

	GDS_ASSERT (m_writer);

	// Сохраним сформированный параграф (оформление + текст) в базу

	try {
		m_writer->create_para ();
		m_writer->add_style ((const char*) buffer, buffer_size);
		m_writer->flush ();
	} catch (...) {
	}

	return 0;
}

IEndtWriter* EndtWriteFunction::writer () const {
	return m_writer;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

EndtGenerator_i::EndtGenerator_i (EndtWriteFunction* endt_write_function, size_t buf_size, IBaseWriter* base_writer)
	: evd::EeGenerator_i (endt_write_function, static_cast<long> (buf_size)) 
	, m_base_writer (IBaseWriter::_duplicate (base_writer))
	, m_para_level (0) 
	, m_ref_number (0)
	, m_skip_level (0)
	, m_write_function (endt_write_function)
{
	m_requisites = new Requisites ();
}

EndtGenerator_i::~EndtGenerator_i () {
}

void EndtGenerator_i::set_document (unsigned long doc_id) {
	GDS_ASSERT (m_write_function->writer ());

	try {
		m_write_function->writer ()->set_document (doc_id);
		m_base_writer->set_document (doc_id);
	} catch (...) {
	}
}

void EndtGenerator_i::reset () {
	m_sub_id = 0;
	m_id = 0;
	m_para_counter = 0; 

	if (m_subs.empty () == false) {
		m_subs.clear ();
	}

	if (m_refs.empty () == false) {
		m_refs.clear ();
	}

	if (m_requisites->empty () == false) {
		m_requisites->clear ();
	}
}

void EndtGenerator_i::dump_requisite () {
	ACE_OS::printf ("id: %d\n", m_requisite->first);

	const GCL::StrVector& data = m_requisite->second;

	for (GCL::StrVector::const_iterator it = data.begin (); it != data.end (); ++it) {
		ACE_OS::printf ("%s\n", it->c_str ());
	}

	ACE_OS::printf ("\n");
}

void EndtGenerator_i::dump_requisites () {
	char buf [1024];

	ACE_OS::sprintf (buf, "C:\\TEST\\requisites_%d.txt", DOCS [test_counter - 1]);

	int handle = ace_os_open (buf, O_RDWR | O_APPEND | O_CREAT);

	if (handle != -1) {
		ace_os_lseek (handle, 0, ACE_OS_SEEK_END);

		for (Requisites::const_iterator it = m_requisites->begin (); it != m_requisites->end (); ++it) {
			ACE_OS::sprintf (buf, "type: %d\n", it->first);
			ace_os_write (handle, buf, ACE_OS::strlen (buf));

			for (RequisiteData::const_iterator r_it = it->second.begin (); r_it != it->second.end (); ++r_it) {
				ACE_OS::sprintf (buf, " id: %d\n", r_it->first);
				ace_os_write (handle, buf, ACE_OS::strlen (buf));

				for (GCL::StrVector::const_iterator s_it = r_it->second.begin (); s_it != r_it->second.end (); ++s_it) {
					ACE_OS::sprintf (buf, "  %s\n", s_it->c_str ());
					ace_os_write (handle, buf, ACE_OS::strlen (buf));
				}
			}
		}

		ace_os_close (handle);
	}
}

void EndtGenerator_i::dump_info () {
	for (std::deque <TagInfo>::const_iterator it = m_stack.begin (); it != m_stack.end (); ++it) {
		ACE_OS::printf ("%d, ", it->b_type);
	}
	ACE_OS::printf ("\n");
}

void EndtGenerator_i::write () {
	GDS_ASSERT (m_base_writer.is_nil () == false);

	// Cохраним данные в индекс IDD_SUB_EX
	{
		for (std::vector <SubInfo>::const_iterator it = m_subs.begin (); it != m_subs.end (); ++it) {
			m_base_writer->write_sub (*it);
		}
	} 
	// Cохраним данные в индекс IDD_REFS
	{
		for (std::vector <RefInfo>::const_iterator it = m_refs.begin (); it != m_refs.end (); ++it) {
			m_base_writer->write_ref (*it);
		}
	}
}

void EndtGenerator_i::write_cell_data (long type) {
	if (m_cell_info.is_nil () == false) {
		GDS_ASSERT (m_base_writer.is_nil () == false);

		m_base_writer->set_table_id (m_cell_info->id);

		CellWriteFunction cell_write (m_base_writer.in ());
		evd::IeeGenerator_var generator = new evd::EeGenerator_i (&cell_write, 1024);

		GDS_ASSERT (generator.is_nil () == false);

		generator->Start ();

		generator->StartChild (type);
		{
			if (m_cell_info->is_visible) {
				generator->AddBoolAtom (evd::ti_Visible, m_cell_info->is_visible);
			}
			if (m_cell_info->width > 0)	{
				generator->AddIntegerAtom (evd::ti_Width, m_cell_info->width);
			}
			if (m_cell_info->merge > 0) {
				generator->AddIntegerAtom (evd::ti_MergeStatus, m_cell_info->merge);
			}
			if (m_cell_info->left_indent > 0) {
				generator->AddIntegerAtom (evd::ti_LeftIndent, m_cell_info->left_indent);
			}
			if (m_cell_info->right_indent > 0) {
				generator->AddIntegerAtom (evd::ti_RightIndent, m_cell_info->right_indent);
			}
			if (m_cell_info->vert_align > 0) {
				generator->AddIntegerAtom (evd::ti_VerticalAligment, m_cell_info->vert_align);
			}

			if (m_cell_info->has_frame) {
				generator->StartTag (evd::ti_Frame);
				{
					if (m_cell_info->frame_flags & FT_FRAME_LEFT) {
						generator->StartTag (evd::ti_FrameLeft);
						generator->Finish ();
					}
					if (m_cell_info->frame_flags & FT_FRAME_RIGHT) {
						generator->StartTag (evd::ti_FrameRight);
						generator->Finish ();
					}
					if (m_cell_info->frame_flags & FT_FRAME_UP) {
						generator->StartTag (evd::ti_FrameUp);
						generator->Finish ();
					}
					if (m_cell_info->frame_flags & FT_FRAME_DOWN) {
						generator->StartTag (evd::ti_FrameDown);
						generator->Finish ();
					}
				}
				generator->Finish ();
			}
		}
		generator->Finish ();

		generator->Finish ();

		m_cell_info = 0;
	}
}

void EndtGenerator_i::add_sub (long type) {
	if (type) {
		if ((type & SUBDESCEX_END) == 0) {
			m_stack.back ().id = ++m_sub_id;
		}

		size_t para_counter = (type == evd::id_Sub)? m_para_counter - 1 : m_para_counter;

		m_subs.push_back (
			SubInfo (
				static_cast<long> (m_stack.back ().id)
				, static_cast<long> (para_counter)
				, static_cast<unsigned short> (type)
				, static_cast<long> (++m_id)
				, m_stack.size () - 1
			)
		);
	}
}

void EndtGenerator_i::add_sub_id (long value) {
	if (m_stack.empty () == false) {
		switch (m_stack.back ().b_type) {
			case evd::id_Sub:
				GDS_ASSERT (value >= 0);
				m_subs.back ().data.Sub = value;
				break;
			case evd::id_Block:
				GDS_ASSERT (value >= 0);
				m_subs.back ().data.Sub = value;
				m_stack.back ().id = value;
				break;
		}
	}
}

void EndtGenerator_i::add_ref_data (long tag_id, long value) {
	if (m_ref.is_nil () == false) {
		switch (tag_id) {
			case evd::ti_Revision:
			case evd::ti_DocID:
				GDS_ASSERT (value >= 0);
				m_ref->data.DocId = value;
				break;
			case evd::ti_SubID:
				GDS_ASSERT (value >= 0);
				m_ref->data.Sub = value;
				break;
		}
	}
}

void EndtGenerator_i::add_requisite (long type) {
	std::pair <Requisites::iterator, bool> res = m_requisites->insert (
		Requisites::value_type (type, RequisiteData ())
	);

	GDS_ASSERT (m_requisite.is_nil () == false);

	res.first->second.insert (*(m_requisite.in ()));

	//////////////////////////////////////
	//dump_requisite ();
	//////////////////////////////////////

	m_requisite = 0;
}

void EndtGenerator_i::Finish (bool is_need_undo) {
	//////////////////////////////////////
	if (m_stack.size () <= 1) { 
		long test = 10;
	}
	//////////////////////////////////////

	if (this->is_para () || m_stack.empty ()) { // закрыли последнюю скобку или скобку параграфа
		evd::EeGenerator_i::Finish (is_need_undo);
	} else if (m_skip_level == m_stack.size ()) {
		m_skip_level = 0;
	}

	if (m_stack.empty () == false) {
#ifdef _DEBUG
		//this->dump_info ();
#endif
		long type = m_stack.back ().b_type;

		if (type != evd::id_Document && type != evd::id_DocumentSub) {
			if (evd::INHERITS [type][evd::id_HyperLink]) {
				m_refs.push_back (*(m_ref.in ()));
				m_ref = 0;
			} else if (evd::INHERITS [type][evd::id_TableCell]) {
				this->add_sub (type | SUBDESCEX_END);
				this->write_cell_data (type); // сохраним данные в индекс IDD_EVD
			} else if (evd::INHERITS [type][evd::id_ParaList]) {
				this->add_sub (type | SUBDESCEX_END);
			} else if (evd::INHERITS [type][evd::id_TextPara]) {
				m_para_level = 0;
			} 
			
			if (is_requisite (m_stack.back ().type)) {
				this->add_requisite (m_stack.back ().type);
			}
		} 

		m_stack.pop_back ();

		if (m_stack.empty ()) {
			this->write (); // если закрыли последнюю скобку, то сохраним данные в индексы

#ifdef _DEBUG
			this->dump_requisites ();
#endif
		}
	}
}

void EndtGenerator_i::StartChild (long type_id) {
	m_stack.push_back (TagInfo (false, type_id , type_id));

	if (type_id == evd::id_Document) {
		this->set_document (DOCS [test_counter++]); // Временно (doc_id нужно вычитывать из evd)
		this->reset (); // Обнуляем данные, т.к. в одном файле может быть два документа
	} else if (type_id != evd::id_DocumentSub) {
		if (evd::INHERITS [type_id][evd::id_HyperLink]) {
			m_ref = new RefInfo (static_cast<long> (m_para_counter), static_cast<short> (++m_ref_number));
		} else if (evd::INHERITS [type_id][evd::id_TableCell]) {
			this->add_sub (type_id);
			m_cell_info = new CellInfo (static_cast<long> (m_sub_id));
		} else if (evd::INHERITS [type_id][evd::id_Sub]) {
			this->add_sub (type_id);
		} else if (evd::INHERITS [type_id][evd::id_ParaList]) {
			this->add_sub (type_id);
		} else if (evd::INHERITS [type_id][evd::id_TextPara]) {
			++m_para_counter; // cчетчик параграфов
			m_para_level = m_stack.size (); // cохраним уровень вложенности скобки параграфа
			m_ref_number = 0; // обнулим счетчик ссылок
		} 

		if (this->is_para ()) { // пишем только вложенные в параграф тэги
			evd::EeGenerator_i::StartChild (type_id);
		}
	}
}

void EndtGenerator_i::StartDefaultChild () {
	GDS_ASSERT (m_stack.empty () == false);

	long parent_tag = m_stack.back ().type, tag = 0;

	if (m_stack.back ().flag) {
		GDS_ASSERT (m_stack.size () >= 2);
		long parent_parent_tag = m_stack [m_stack.size () - 2].type;
		GDS_ASSERT (0 <= parent_parent_tag && parent_parent_tag < sizeof (evd::DEF_ATTR_CHILD) / sizeof (evd::DEF_ATTR_CHILD [0]));
		GDS_ASSERT (0 <= parent_tag && parent_tag < sizeof (evd::DEF_ATTR_CHILD [0]) / sizeof (evd::DEF_ATTR_CHILD [0][0]));
		tag = evd::DEF_ATTR_CHILD [parent_parent_tag][parent_tag];
	} else {
		GDS_ASSERT (0 <= parent_tag && parent_tag < sizeof (evd::DEF_CHILD) / sizeof (evd::DEF_CHILD [0]));
		tag = evd::DEF_CHILD [parent_tag];
	}

	this->StartChild (tag);
}

void EndtGenerator_i::StartTag (long tag_id) {
	m_stack.push_back (TagInfo (true, tag_id, 0));

	if (m_cell_info.is_nil () == false) {
		switch (tag_id) {
			case evd::ti_Frame:
				m_cell_info->has_frame = true;
				break;
			case evd::ti_FrameLeft:
				m_cell_info->frame_flags |= FT_FRAME_LEFT;
				break;
			case evd::ti_FrameRight:
				m_cell_info->frame_flags |= FT_FRAME_RIGHT;
				break;
			case evd::ti_FrameUp:
				m_cell_info->frame_flags |= FT_FRAME_UP;
				break;
			case evd::ti_FrameDown:
				m_cell_info->frame_flags |= FT_FRAME_DOWN;
				break;
		}
	} else if (is_requisite (tag_id)) {
		m_requisite = new Requisite ();

		m_requisite->first = 0;

		// Опасно, т.к. id блока может быть неинициализированным!
		if (m_subs.size ()) {
			const SubDescEx& item = m_subs.back ().data;

			if (item.Flags == evd::id_Block) {
				m_requisite->first = item.Sub;
			}
		}
	} 
		
	if (this->is_para ()) { // пишем только вложенные в параграф тэги
		if (tag_id == evd::ti_Subs) {
			m_skip_level = m_stack.size ();
		} else {
			evd::EeGenerator_i::StartTag (tag_id);
		}
	}
}

void EndtGenerator_i::AddStringAtom (long tag_id, const char* buf, long len, long code_page) {
	if (m_requisite.is_nil () == false) {
		switch (tag_id) {
			case evd::ti_ShortName:
			case evd::ti_Name:
				m_requisite->second.push_back (buf);
				break;
			default:
				GDS_ASSERT (0);
				break;
		}
	} else if (this->is_para ()) {
		if (tag_id == evd::ti_Text && m_para_level == m_stack.size ()) {
			GDS_ASSERT (m_write_function->writer ());

			m_write_function->writer ()->add_text (buf, (short) code_page);

			////////////////////////////////////////
			/*
			{
				char test_buf [1024*16];
				ACE_OS::strcpy (test_buf, buf);
				GCL::string_recoding (GCL::cd_win, GCL::cd_dos, test_buf);
				ACE_OS::printf ("\n%s\n", test_buf);
			}
			*/
			/*
			std::string s = "  1. Область применения                                                  ";
			if (s.compare (buf) == 0) {
				long test = 10;
			}
			*/
			////////////////////////////////////////
		} else {
			evd::EeGenerator_i::AddStringAtom (tag_id, buf, len, code_page);
		}
	} else if (m_stack.back ().b_type == evd::id_Block) {
		if (tag_id == evd::ti_ShortName) {
			m_subs.back ().name  = buf;
		} else {
			long test = 10;
		}
	} else {
		// Может приехать Name документа, например...

		if (tag_id == evd::ti_ShortName) {
		} else if (tag_id == evd::ti_Name) {
		}
	}
}

void EndtGenerator_i::AddIntegerAtom (long tag_id, long value) {
	if (m_cell_info.is_nil () == false) {
		switch (tag_id) {
			case evd::ti_Width:
				m_cell_info->width = value;
				break;
			case evd::ti_MergeStatus:
				m_cell_info->merge = value;
				break;
			case evd::ti_VerticalAligment:
				m_cell_info->vert_align = value;
				break;
			case evd::ti_LeftIndent:
				m_cell_info->left_indent = value;
				break;
			case evd::ti_RightIndent:
				m_cell_info->right_indent = value;
				break;
			case evd::ti_Visible:
				m_cell_info->is_visible = (value != 0);
				break;
		}
	}

	switch (tag_id) {
		case evd::ti_ExternalHandle:
			//this->set_document (value);
			break;
		case evd::ti_InternalHandle:
			break;
		case evd::ti_Handle:

			if (value == 103) {
				long test = 10;
			}

			this->add_sub_id (value);
			break;
		case evd::ti_Revision:
		case evd::ti_DocID:
		case evd::ti_SubID:
			this->add_ref_data (tag_id, value);
			break;
		case evd::ti_Finish:
			break;
	}

	switch (value) {
		case EVD::sa_NormalSBSRight:
		case EVD::sa_NormalSBSLeft:
			break;
	}

	if (this->is_para ()) {
		evd::EeGenerator_i::AddIntegerAtom (tag_id, value);
	}
}

void EndtGenerator_i::AddTransparentAtom (unsigned short index) {
	if (this->is_para ()) {
		evd::EeGenerator_i::AddTransparentAtom (index);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////

} // namespace
