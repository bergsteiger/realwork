//
// DivisionInfo.cpp : implementation file
//

#include "ace/ACE.h"

#include "DivisionInfo.h"

namespace EndtConvertor {

enum PageOrientation { po_Portrait, po_Landscape };

enum PageType { pt_A0, pt_A1, pt_A2, pt_A3, pt_A4, pt_A5 };

struct PageSize {
	long m_width;
	long m_height;

	void init (PageType page_type);
	void convert_to_inch ();
};

static const PageSize page_sizes [6] = {
	{8400, 11880}, // A0
	{5940, 8400 }, // A1
	{4200, 5940 }, // A2
	{2970, 4200 }, // A3
	{2100, 2970 }, // A4
	{1480, 2100 }  // A5
};

void PageSize::init (PageType page_type) {
	m_width  = evd::cm2inch (page_sizes [page_type].m_width);
	m_height = evd::cm2inch (page_sizes [page_type].m_height);
}

void PageSize::convert_to_inch () {
	m_width  = evd::cm2inch (m_width  * 10);
	m_height = evd::cm2inch (m_height * 10);
}

////////////////////////////////////////////////////////////////////////////////////////

DivisionInfos::DivisionInfos (Base* base, long doc_id) {
	long size = 0, total = 0;

	INDEX_DATA (DivisionInfo) data = IndexLoader (base).load <DivisionInfo> (
		doc_id, IDD_DIVISION, size, false
	);

	const char* ptr = (const char*) data.in ();

	while (total < size) {
		DivisionInfo* info = (DivisionInfo*) ptr;
		const char* params = ptr + sizeof (info->Para) + sizeof (info->Symbol);

		m_data.insert (DivisionData::value_type (info->Para, DivisionInfoEx (info->Symbol, params)));

		size_t len = ACE_OS::strlen (params) + 1;
		total += len + sizeof (info->Para) + sizeof (info->Symbol);
		ptr = params + len;
	}
}

////////////////////////////////////////////////////////////////////////////////////////

void DivisionInfoGenerator::generate (
	evd::IeeGenerator* generator
	, EndtTools::EndtWriter& writer
	, const DivisionInfoEx& info
) {
	writer.m_text.clear ();

	if (info.m_symbol != 'L' && info.m_symbol != 'P' && info.m_params == "") {
		writer.set_type (evd::id_PageBreak);
		generator->StartChild (evd::id_PageBreak);
	} else {
		writer.set_type (evd::id_SectionBreak);
		generator->StartChild (evd::id_SectionBreak);
		DivisionInfoGenerator::generate_section_break (generator, info);
	}

	generator->Finish ();
}

void DivisionInfoGenerator::generate_section_break (
	evd::IeeGenerator* generator
	, const DivisionInfoEx& info
) {
	generator->StartTag (evd::ti_Paras); {
		if (info.m_symbol == 'L') {
			generator->AddIntegerAtom (evd::ti_Orientation, po_Landscape);
		}

		PageSize page_size;
		page_size.m_width = 0;
		page_size.m_height = 0;

		if (info.m_params.size () > 0) {
			if (!info.m_params.compare ("A0")) {
				page_size.init (pt_A0);
			} else if (!info.m_params.compare ("A1")) {
				page_size.init (pt_A1);
			} else if (!info.m_params.compare ("A2")) {
				page_size.init (pt_A2);
			} else if (!info.m_params.compare ("A3")) {
				page_size.init (pt_A3);
			} else if (!info.m_params.compare ("A4")) {
				page_size.init (pt_A4);
			} else if (!info.m_params.compare ("A5")) {
				page_size.init (pt_A5);
			} else {
				int pos = info.m_params.find ('x');
				if (pos == std::string::npos) {
					pos = info.m_params.find ('X');
				} 
				if (pos != std::string::npos) {
					std::string str_width = info.m_params.substr (0, pos);
					page_size.m_width = atol (str_width.c_str ());
					std::string str_height = info.m_params.substr (pos + 1);
					page_size.m_height = atol (str_height.c_str ());
					page_size.convert_to_inch ();
				}
			}
		}

		if (page_size.m_width > 0) {
			generator->AddIntegerAtom (evd::ti_Width, page_size.m_width);
		}
		if (page_size.m_height > 0) {
			generator->AddIntegerAtom (evd::ti_Height, page_size.m_height);
		}
	}
	generator->Finish ();
}

}