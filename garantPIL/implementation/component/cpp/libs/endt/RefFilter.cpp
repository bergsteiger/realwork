//
// RefFilter.cpp : implementation file
//

#include "ace/ACE.h"

#include "Defines.h"
#include "RefFilter.h"

namespace EndtTools {

static const unsigned buf_size = 64 * 1024;

RefFilter_i::RefFilter_i (
	evd::UserWriter* writer
	, GeneratorHelper* helper
	, const ParaInfo* info
	, bool is_no_doc
) 
	: evd::EeGenerator_i (writer, buf_size)
	, GeneratorData (helper, 0, 0, info) 
	, m_skip_finish (0) 
	, m_is_no_doc (is_no_doc) {
}

RefFilter_i::~RefFilter_i () {
	if (m_link) {
		delete m_link;
		m_link = 0;
	}
}

void RefFilter_i::add () {
	bool is_valid;

	if (m_link->m_type == EndtTools::CI_MULTI || m_is_no_doc == false) {
		is_valid = m_helper->is_ref_exist (m_helper->get_para (), m_link_offset);
	} else {
		is_valid = m_helper->is_doc_exist (m_link->m_id);
	}

	if (is_valid == false) {
		is_valid = m_helper->is_blob_exist (m_link->m_id);
	}

	if (is_valid && m_link->pos.m_start >= 0 && m_link->pos.m_start < m_link->pos.m_finish) {
		evd::EeGenerator_i::StartChild (evd::id_HyperLink); {
			evd::EeGenerator_i::AddIntegerAtom (evd::ti_Start,  static_cast<long> (m_link->pos.m_start));
			evd::EeGenerator_i::AddIntegerAtom (evd::ti_Finish, static_cast<long> (m_link->pos.m_finish));

			evd::EeGenerator_i::StartChild (evd::id_Address); {
				evd::EeGenerator_i::AddIntegerAtom (evd::ti_Type, m_link->m_type);

				if (m_link->m_revision_id) {
					evd::EeGenerator_i::AddIntegerAtom (evd::ti_Revision, m_link->m_revision_id);
				}
				if (m_link->m_id) {
					evd::EeGenerator_i::AddIntegerAtom (evd::ti_DocID, m_link->m_id);
				}
				if (m_link->m_sub) {
					evd::EeGenerator_i::AddIntegerAtom (evd::ti_SubID, m_link->m_sub);
				}
				if (m_link->m_name.empty () == false) {
					evd::EeGenerator_i::AddStringAtom (evd::ti_Name, m_link->m_name.c_str ());
				}
			}
		}
	} else {
		m_skip_finish = 2; // for evd::id_HyperLink and evd::id_Address
	}

	++m_link_offset;

	delete m_link;
	m_link = 0;
}

void RefFilter_i::Finish (bool is_need_undo) {
	if (m_link) {
		this->add ();
	} 
	if (m_skip_finish) {
		--m_skip_finish;
	} else {
		evd::EeGenerator_i::Finish (is_need_undo);
	}
}

void RefFilter_i::StartChild (long tag_id) {
	if (m_helper->is_reset ()) {
		GeneratorData::reset ();
		m_helper->set_reset (false);
	}
	if (tag_id == evd::id_HyperLink) {
		m_link = new Link;
	} else if (m_link == 0) {
		evd::EeGenerator_i::StartChild (tag_id);
	}
}

void RefFilter_i::AddIntegerAtom (long tag_id, long value) {
	if (m_link) {
		switch (tag_id) {
		case evd::ti_Type:
			m_link->m_type = value;
			break;
		case evd::ti_SubID:
			m_link->m_sub = value;
			break;
		case evd::ti_DocID:
			m_link->m_id = value;
			break;
		case evd::ti_Revision:
			m_link->m_revision_id = value;
			break;
		case evd::ti_Start:
			m_link->pos.m_start = value;
			break;
		case evd::ti_Finish:
			m_link->pos.m_finish = value;
			break;
		default:
			break;
		}
	} else {
		evd::EeGenerator_i::AddIntegerAtom (tag_id, value);
	}
}

void RefFilter_i::AddStringAtom (long tag_id, const char* buf, long len, long code_page) {
	if (m_link) {
		if (tag_id == evd::ti_Name) {
			m_link->m_name = buf;
		}
	} else {
		evd::EeGenerator_i::AddStringAtom (tag_id, buf, len, code_page);
	}
}

//////

RefFilter2_i::RefFilter2_i (
	evd::UserWriter* writer
	, GeneratorHelper* helper
	, const ParaInfo* info
	, bool is_no_doc
) 
	: evd::EeGenerator_i (writer, buf_size)
	, GeneratorData (helper, 0, 0, info) 
	, m_skip_finish (0) 
	, m_is_no_doc (is_no_doc) {
}

RefFilter2_i::~RefFilter2_i () {
	if (m_link) {
		delete m_link;
		m_link = 0;
	}
}

void RefFilter2_i::add () {
	bool is_valid;

	if (m_link->m_type == EndtTools::CI_EDITION) {
		is_valid = false;
	} else {
		if (m_link->m_type == EndtTools::CI_MULTI || m_is_no_doc == false) {
			is_valid = m_helper->is_ref_exist_2 (m_helper->get_para (), m_link_offset);
		} else {
			is_valid = m_helper->is_doc_exist (m_link->m_id);
		}

		if (is_valid == false) {
			is_valid = m_helper->is_blob_exist (m_link->m_id);
		}
	}

	if (is_valid && m_helper->is_comment ())
		is_valid = false;

	if (is_valid && m_link->pos.m_start >= 0 && m_link->pos.m_start < m_link->pos.m_finish) {
		evd::EeGenerator_i::StartChild (evd::id_HyperLink); {
			evd::EeGenerator_i::AddIntegerAtom (evd::ti_Start,  static_cast<long> (m_link->pos.m_start));
			evd::EeGenerator_i::AddIntegerAtom (evd::ti_Finish, static_cast<long> (m_link->pos.m_finish));

			evd::EeGenerator_i::StartChild (evd::id_Address); {
				evd::EeGenerator_i::AddIntegerAtom (evd::ti_Type, m_link->m_type);

				if (m_link->m_revision_id) {
					evd::EeGenerator_i::AddIntegerAtom (evd::ti_Revision, m_link->m_revision_id);
				}
				if (m_link->m_id) {
					evd::EeGenerator_i::AddIntegerAtom (evd::ti_DocID, m_link->m_id);
				}
				/*
				if (m_link->m_sub) {
					evd::EeGenerator_i::AddIntegerAtom (evd::ti_SubID, m_link->m_sub);
				}
				*/
				if (m_link->m_name.empty () == false) {
					evd::EeGenerator_i::AddStringAtom (evd::ti_Name, m_link->m_name.c_str ());
				}
			}
		}
	} else {
		m_skip_finish = 2; // for evd::id_HyperLink and evd::id_Address
	}

	++m_link_offset;

	delete m_link;
	m_link = 0;
}

void RefFilter2_i::Finish (bool is_need_undo) {
	if (m_link) {
		this->add ();
	} 
	if (m_skip_finish) {
		--m_skip_finish;
	} else {
		evd::EeGenerator_i::Finish (is_need_undo);
	}
}

void RefFilter2_i::StartChild (long tag_id) {
	if (m_helper->is_reset ()) {
		GeneratorData::reset ();
		m_helper->set_reset (false);
	}
	if (tag_id == evd::id_HyperLink) {
		m_link = new Link;
	} else if (m_link == 0) {
		evd::EeGenerator_i::StartChild (tag_id);
	}
}

void RefFilter2_i::AddIntegerAtom (long tag_id, long value) {
	if (m_link) {
		switch (tag_id) {
		case evd::ti_Type:
			m_link->m_type = value;
			break;
		case evd::ti_SubID:
			m_link->m_sub = value;
			break;
		case evd::ti_DocID:
			m_link->m_id = value;
			break;
		case evd::ti_Revision:
			m_link->m_revision_id = value;
			break;
		case evd::ti_Start:
			m_link->pos.m_start = value;
			break;
		case evd::ti_Finish:
			m_link->pos.m_finish = value;
			break;
		default:
			break;
		}
	} else {
		if (tag_id == evd::ti_Style && value == EVD::sa_TxtComment)
			value = EVD::sa_TxtNormalANSI;
		evd::EeGenerator_i::AddIntegerAtom (tag_id, value);
	}
}

void RefFilter2_i::AddStringAtom (long tag_id, const char* buf, long len, long code_page) {
	if (m_link) {
		if (tag_id == evd::ti_Name) {
			m_link->m_name = buf;
		}
	} else {
		evd::EeGenerator_i::AddStringAtom (tag_id, buf, len, code_page);
	}
}

} // namespace
