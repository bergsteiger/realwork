//
// DocAnalyzer_i.cpp : implementation file
//

#include "ace/ACE.h"

#include "DocAnalyzer_i.h"

namespace Compiler {

static long __stdcall func (unsigned char* buffer, long buffer_size, void* writer) {
	return 0;
}

DocAnalyzer_i::DocAnalyzer_i (void* endt_writer, size_t buf_size /*, IBaseWriter* base_writer*/)
	: evd::EeGenerator_i (func, endt_writer, buf_size) 
	//, m_base_writer (IBaseWriter::_duplicate (base_writer))
	//, m_writer (endt_writer)
	/*
	, m_para_level (0) 
	, m_ref_number (0)
	, m_skip_level (0) 
	*/
{
}

DocAnalyzer_i::~DocAnalyzer_i () {
}

void DocAnalyzer_i::Finish (bool is_need_undo) { 
	/*
	if (this->is_para () || m_stack.empty ()) { // закрыли последнюю скобку или скобку параграфа
	} else if (m_skip_level == m_stack.size ()) {
		m_skip_level = 0;
	}
	*/

	if (m_stack.empty () == false) {
		long type = m_stack.back ().b_type;

		if (type != evd::id_Document && type != evd::id_DocumentSub) {
			if (evd::INHERITS [type][evd::id_HyperLink]) {
				//m_refs.push_back (*(m_ref.in ()));
				//m_ref = 0;
			} else if (evd::INHERITS [type][evd::id_TableColumn]) {
				//this->add_sub (type | SUBDESCEX_END);
			} else if (evd::INHERITS [type][evd::id_ParaList]) {
				//this->add_sub (type | SUBDESCEX_END);
			} else if (evd::INHERITS [type][evd::id_TextPara]) {
				//m_para_level = 0;
			} 
			
			/*
			if (is_requisite (m_stack.back ().type)) {
				//this->add_requisite (m_stack.back ().type);
			}
			*/
		} 

		m_stack.pop_back ();

		if (m_stack.empty ()) { //закрыли последнюю скобку
		}
	}
}

void DocAnalyzer_i::StartChild (long type_id) {
}

void DocAnalyzer_i::StartDefaultChild () {
}

void DocAnalyzer_i::StartTag (long tag_id) {
}

void DocAnalyzer_i::AddStringAtom (long tag_id, const char* buf, long len, long code_page) {
}

void DocAnalyzer_i::AddIntegerAtom (long tag_id, long value) {
}

void DocAnalyzer_i::AddTransparentAtom (unsigned short index) {
}

}