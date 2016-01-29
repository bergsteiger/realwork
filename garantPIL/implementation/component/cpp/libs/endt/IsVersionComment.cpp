//
// IsVersionComment.cpp : implementation file
//

#include "ace/ACE.h"

#include "IsVersionComment.h"

namespace EndtTools {

class IsVersionComment_i
	: virtual public evd::IeeGenerator 
	, virtual public Core::RefCountObjectBase {
public:
	IsVersionComment_i (bool& value) : m_value (value) {
		m_value = false;
	}

	virtual ~IsVersionComment_i () {
	}

// IeeGenerator implementation
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
		if (tag_id == evd::ti_Style && value == EVD::sa_VersionInfo) {
			m_value = true;
			throw VersionInfoIsFound ();
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
	bool& m_value;
};

evd::IeeGenerator* IsVersionCommentFactory::make (bool& value) {
	evd::IeeGenerator_var ret;

	try {
		ret = new IsVersionComment_i (value);
	} catch (...) {
	}

	return ret._retn ();
}

} // namespace
