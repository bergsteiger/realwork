//
// TableDecompile.cpp : implementation file
//

#include "ace/ACE.h"

#include "TableDecompile.h"

namespace EndtTools {

struct TableInfo {
	long left_indent;
	long zoom;
};

struct CellInfo {
	short frame_left;
	short frame_right;
	short frame_up;
	short frame_down;

	long width;
	long merge_status;
	long vertical_aligment;
};

class TableDecompile_i
	: virtual public evd::IeeGenerator 
	, virtual public Core::RefCountObjectBase {
public:
	TableDecompile_i (std::string& value) : m_value (value), m_counter (0) {
	}

	virtual ~TableDecompile_i () {
	}

// IeeGenerator implementation
public:
	virtual void StartChild (long tag_id) {
		if (tag_id == evd::id_SBS) {
		} else if (tag_id == evd::id_Table) {
		} else if (tag_id == evd::id_TableCell) {
		}
	}

	virtual void Start () {
		++m_counter;
		ACE_OS::memset (&m_cell_info, 0, sizeof (CellInfo));
		m_cell_info.frame_left = 2;
		m_cell_info.frame_right = 2;
		m_cell_info.frame_up = 2;
		m_cell_info.frame_down = 2;
		ACE_OS::memset (&m_table_info, 0, sizeof (TableInfo));
		m_value.clear ();
	}

	virtual void Finish (bool is_need_undo = false) {
		--m_counter;

		char buffer [1024];

		if (m_counter == 0) {
			if (m_table_info.left_indent || m_table_info.zoom) {
				ACE_OS::sprintf (buffer, "TABLE %ld %ld"
					, m_table_info.left_indent
					, m_table_info.zoom
				);
			} else {
				ACE_OS::sprintf (buffer, "CELL %ld %ld %ld %d%d%d%d"
					, m_cell_info.width
					, m_cell_info.merge_status
					, m_cell_info.vertical_aligment
					, m_cell_info.frame_right
					, m_cell_info.frame_left
					, m_cell_info.frame_up
					, m_cell_info.frame_down
				);
			}

			m_value = buffer;
		}
	}

	virtual void StartTag (long tag_id) {
		++m_counter;

		if (tag_id == evd::ti_FrameLeft) {
			m_cell_info.frame_left = 1;
		} else if (tag_id == evd::ti_FrameRight) {
			m_cell_info.frame_right = 1;
		} else if (tag_id == evd::ti_FrameUp) {
			m_cell_info.frame_up = 1;
		} else if (tag_id == evd::ti_FrameDown) {
			m_cell_info.frame_down = 1;
		}
	}

	virtual void AddIntegerAtom (long tag_id, long value) {
		if (tag_id == evd::ti_Zoom) {
			m_table_info.zoom = value;
		} else if (tag_id == evd::ti_Frame) {
			if (value == 0) {
				m_cell_info.frame_left = 0;
				m_cell_info.frame_right = 0;
				m_cell_info.frame_up = 0;
				m_cell_info.frame_down = 0;
			} else if (value == 1111) {
				m_cell_info.frame_left = 1;
				m_cell_info.frame_right = 1;
				m_cell_info.frame_up = 1;
				m_cell_info.frame_down = 1;
			}
		} else if (tag_id == evd::ti_Width) {
			m_cell_info.width = value;
		} else if (tag_id == evd::ti_LeftIndent) {
			m_table_info.left_indent = value;
		} else if (tag_id == evd::ti_MergeStatus) {
			m_cell_info.merge_status = value;
		} else if (tag_id == evd::ti_VerticalAligment) {
			m_cell_info.vertical_aligment = value;
		}
	}

	virtual void AddBoolAtom (long tag_id, bool value) {
	}

	virtual void AddStringAtom (long tag_id, const char* buf, long len = 0xffffffff, long code_page = 0x0) {
	}

	virtual void AddStreamAtom (long tag_id, GCI::IO::Stream* stream) {
	}

	virtual void AddMemAtom (long tag_id, const char* mem_buf, long len) {
	}

	virtual void AddRawData (const char* mem_buf, long len) {
	}

	virtual void StartDefaultChild (void) {
		++m_counter;
	}

	virtual void AddTransparentAtom (unsigned short atom_index) {
	}

private:
	size_t m_counter;

	std::string& m_value;

	CellInfo m_cell_info;
	TableInfo m_table_info;
};

evd::IeeGenerator* TableDecompileFactory::make (std::string& value) {
	evd::IeeGenerator_var ret;

	try {
		ret = new TableDecompile_i (value);
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return ret._retn ();
}

} // namespace
