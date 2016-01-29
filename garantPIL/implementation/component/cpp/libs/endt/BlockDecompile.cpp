//
// BlockDecompile.cpp : implementation file
//

#include "ace/ACE.h"

#include "BlockDecompile.h"

namespace EndtTools {

class BlockDecompile_i
	: virtual public evd::IeeGenerator 
	, virtual public Core::RefCountObjectBase {
public:
	BlockDecompile_i (std::string& value) : m_value (value) {
	}

	virtual ~BlockDecompile_i () {
	}

public:
	virtual void StartChild (long tag_id) {
	}

	virtual void Start () {
	}

	virtual void Finish (bool is_need_undo = false) {
	}

	virtual void StartTag (long tag_id) {
	}

	virtual void AddIntegerAtom (long tag_id, long value) {
		if (tag_id == evd::ti_ViewKind) {
			if (value == EVD::bvk_Right) {
				m_value = "RIGHT";
			} else if (value == EVD::bvk_Left) {
				m_value = "LEFT";
			}
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
	}

	virtual void AddTransparentAtom (unsigned short atom_index) {
	}

private:
	std::string& m_value;
};

evd::IeeGenerator* BlockDecompileFactory::make (std::string& value) {
	evd::IeeGenerator_var ret;

	try {
		ret = new BlockDecompile_i (value);
	} catch (...) {
	}

	return ret._retn ();
}

} // namespace